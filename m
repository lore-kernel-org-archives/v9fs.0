Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE7303C8A
	for <v9fs@lists.linux.dev>; Wed, 15 Apr 2026 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268370; cv=none; b=i/ZQdpODoutYvCKVj0fZWr+3BUaVGWmcr09iupaqIRhnSAxc9t34siV5w5RV524nvHvyoRKpl6+kn2PLKcT3UJyUNr08bQxpVMa2UV4p3E0DpwI8F93nH7QeWVkl+q/yuu6B5y3O0xBtg9coxYGaSKXBy6yOHBqmzKdAvf1e2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268370; c=relaxed/simple;
	bh=qzhOZ/vRN8C1Lx17xBS+NxiV80zqkt3JD/d1NhOgYeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KXVob9b5tKB0EjHeOdX2x6eaSAqikfAjTnYIdUoCZDWWrZrRyxsmznif2FV6xnTVvU4ED+GMmHC/VSgtOcvgupGBWUgDbqOBFNwF0uCs1tqiZXoCO7JxKCbdI6z5Z4mM+wLwSad9SsGPbUtiTuiOkHC26K9DgqY//dHNRt7kaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 2FA51233BA;
	Wed, 15 Apr 2026 18:52:38 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal signal
Date: Wed, 15 Apr 2026 18:52:37 +0300
Message-Id: <20260415155237.182891-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When p9_client_rpc() is called with type P9_TFLUSH and the transport
has no peer (e.g. fd transport backed by pipes with no 9p server),
a fatal signal causes an infinite loop:

  again:
	err = io_wait_event_killable(req->wq, ...)
	/* SIGKILL wakes the task, returns -ERESTARTSYS */

	if (err == -ERESTARTSYS && c->status == Connected &&
		type == P9_TFLUSH) {
		sigpending = 1;
		clear_thread_flag(TIF_SIGPENDING);
		goto again;
	}

clear_thread_flag() clears TIF_SIGPENDING before jumping back to
io_wait_event_killable(). signal_pending_state() checks TIF_SIGPENDING,
finds it zero, and the task goes to sleep again. The task can only wake
on the next signal delivery that calls signal_wake_up() and sets
TIF_SIGPENDING again. When that happens the loop repeats, clears
TIF_SIGPENDING, and sleeps again indefinitely.

This is triggered in practice by coredump_wait(): when a thread in a
multi-threaded process causes a coredump (e.g. via SIGSYS from Syscall
User Dispatch), coredump_wait() sends SIGKILL to all other threads and
waits for them to call mm_release(). If one of those threads is blocked
in p9_client_rpc() over an fd transport with no peer, it enters the
P9_TFLUSH loop and never calls mm_release(), so coredump_wait() stalls
forever:

INFO: task syz.0.18:676 blocked for more than 143 seconds.
      Not tainted 6.12.77+ #1
task:syz.0.18 state:D stack:27600 pid:676 tgid:673 ppid:630 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5344 [inline]
 __schedule+0xcb4/0x5d50 kernel/sched/core.c:6724
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe5/0x350 kernel/sched/core.c:6816
 schedule_timeout+0x253/0x290 kernel/time/timer.c:2593
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x409/0x600 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_state+0x1d/0x40 kernel/sched/completion.c:264
 coredump_wait fs/coredump.c:448 [inline]
 do_coredump+0x854/0x4350 fs/coredump.c:629
 get_signal+0x1425/0x2730 kernel/signal.c:2903
 arch_do_signal_or_restart+0x81/0x880 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xf9/0x160 kernel/entry/common.c:218
 do_syscall_64+0x102/0x220 arch/x86/entry/common.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Fix: check fatal_signal_pending() before clearing TIF_SIGPENDING in the
P9_TFLUSH retry loop. At that point TIF_SIGPENDING is still set, so
fatal_signal_pending() works correctly. If a fatal signal is pending,
jump to recalc_sigpending to restore TIF_SIGPENDING and return
-ERESTARTSYS to the caller.

The same defect is present in stable kernels back to 5.4. On those
kernels the infinite loop is broken earlier by a second SIGKILL from
the parent process (e.g. kill_and_wait() retrying after a timeout),
resulting in a zombie process and a shutdown delay rather than a
permanent D-state hang, but the underlying flaw is the same.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 91b8534fa8f5 ("9p: make rpc code common and rework flush code")
Closes: https://syzkaller.appspot.com/bug?extid=3ce7863f8fc836a427e7
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/9p/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/client.c b/net/9p/client.c
index f0dcf252af7e..748b92d3f0c1 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -600,6 +600,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 
 	if (err == -ERESTARTSYS && c->status == Connected &&
 	    type == P9_TFLUSH) {
+		if (fatal_signal_pending(current))
+			goto recalc_sigpending;
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
 		goto again;
-- 
2.50.1

