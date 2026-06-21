Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676372EF652
	for <v9fs@lists.linux.dev>; Sun, 21 Jun 2026 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079596; cv=none; b=NYSkm9w79U4wCE8a9qG/H5hzr7rru7y/e+XovtcfWVxtXO2aP4CBSKspi1E3GYkKCtkuFCYduyYH8SSgUzestULOq2VuEpm7A41szoMubOr+HoawCfaB+MZCclDDHKv0kIDgd5wI0g4zB2JovUZpnmIwGDvaohVWghZIPlc6gzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079596; c=relaxed/simple;
	bh=BEqFzxwejH0rogY9lw0UsqCVacPDDLTpPbh08TM3I9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfB6M3ZZXd/GYmT+UPJkQSSIma67v1SSbRdvXja2vGuJHJAdI3cp/k6zszS52HVVR8KAimMeLyQC76+xjxpFqSOi5mHE/SKn+/aPo7euaEBRFkk0oz+090TnI5JhiEQKg57s59z5gek+4Ng6uC/rNB7CVUZX7wqWwcPIJru71Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [10.88.16.7] (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 5699E2336B;
	Mon, 22 Jun 2026 01:06:22 +0300 (MSK)
Message-ID: <efc4fa29-eae1-0b49-1550-b5dd3b7e28b7@basealt.ru>
Date: Mon, 22 Jun 2026 01:06:21 +0300
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal
 signal
Content-Language: en-US
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260415155237.182891-1-kovalev@altlinux.org>
 <aeA-WpUyfWrYrvaE@codewreck.org>
 <e3e9146a-d820-d35d-cebd-e7e7e4a2fa24@basealt.ru>
 <aeFoRIOUNQZWmTG5@codewreck.org> <ajfgZs23wKUUG6IW@codewreck.org>
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <ajfgZs23wKUUG6IW@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/21/26 16:00, Dominique Martinet wrote:
> Dominique Martinet wrote on Fri, Apr 17, 2026 at 07:52:52AM +0900:
>>>   While the ideal long-term goal is the asynchronous implementation (as
>>> seen in your 9p-async-v2 branch [2]), this patch serves as a reliable
>>> intermediate solution for a critical regression.
>>> [2] https://github.com/martinetd/linux/commits/9p-async-v2
>>
>> iirc one of the problem with the async branch is that the process would
>> quit immediately on, say, ^C, before the IO has completed, but it's
>> possible for the server to process the IO (and not the flush) afterwards
>> and you'd get something that's not supposed to happen e.g.
>>
>> p1             p2
>>
>> write(1)
>> ^C/sigkill
>> flush sent but process exit without waiting for server ack
>>                 1 not written yet
>>                 write(2) in same spot
>>                 write(2) done
>> write(1) completes
>> data isn't 2 as expected after p2 completed
>>
>>
>> So it's quite possible async isn't the way to go, but that there is no
>> good solution for this
>> (given this is true even without async on sigkill: if we have something
>> that works safely, there's no reason to wait only for non-fatal signals...)
> 
> Sorry to come back to this after two months but I'm still a bit worried
> about this patch, and just came back to it as I'm about to send the PR
> to Linus...
> And I'm still thinking about the problem above, or rather possible
> variants involving cache (e.g. write going through the server, but
> client believing it didn't because the response didn't make it in time)
> 
> .. But the thing is, I couldn't actually hit the `if
> (fatal_signal_pending(current))` you added (adding some print
> statement):
> - if cache is enabled, the actual I/Os are done by the vfs in the
> background, so any kill to user processes won't have any impact (and
> thus I guess my main worry about cache is alleviated there)
> - with cache=none I'm not sure why I can't hit it, I tried with an
> external server, breaking on the write() call while running dd, and
> killing dd with SIGKILL a few times but that doesn't appear to be
> enough? (task still stuck in write > rpc > flush > rpc, but it doesn't
> appear to ever get out of io_wait_event_killable() even when I hammer it
> with more signals?)
> 
> So, given that my worry with cache is irrelevant (runs in background &
> won't ever hit this), I can't seem to hit this with what I consider
> to be normal workloads, and assuming it does fix your problems given you
> were able to test it... I'll leave it in and send to Linus now but I'd
> appreciate clarifications on how to test this more thoroughly as time
> permits...
> (I honestly probably should drop the patch at this point, but it'll
> still be time to revert if I figure something out in the next few weeks
> given it's been in -next for almost 2 months already)
> 
> Thanks,

Quoting myself from April: "Severity is low and likely unreachable in
production, but it slows down syzkaller — the hung process ties up
a worker slot until the harness kills it by timeout (143s on our
setup)."

The deterministic path is the syzkaller C reproducer:
https://syzkaller.appspot.com/x/repro.c?x=156aa534580000

What it does:
   1) mounts 9p with trans=fd, rfdno/wfdno pointing to open fds
      with nothing speaking the 9p protocol on the other side
      - RFLUSH can never arrive;
   2) the 9p rpc from mount parks a thread in io_wait_event_killable;
   3) another thread triggers SIGSEGV via prctl(PR_SET_MM) + brk()
      corruption -> coredump_wait;
   4) the harness's kill_and_wait() fires 5s later.

To make both branches visible, debug diff on top of the patch:

diff --git a/net/9p/client.c b/net/9p/client.c
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -600,8 +600,12 @@ p9_client_rpc(...)
         if (err == -ERESTARTSYS && c->status == Connected &&
             type == P9_TFLUSH) {
-               if (fatal_signal_pending(current))
+               pr_info("9p-dbg: TFLUSH retry hit, fatal=%d\n",
+                       fatal_signal_pending(current));
+               if (fatal_signal_pending(current)) {
+                       pr_info("9p-dbg: bailing out via 
recalc_sigpending\n");
                         goto recalc_sigpending;
+               }
                 sigpending = 1;
                 clear_thread_flag(TIF_SIGPENDING);
                 goto again;

In the VM:

   # gcc repro.c -o repro
   # ./repro

dmesg fires on every iteration:

[root@localhost repro]# ./repro
executing program
[  126.254054] repro[363]: segfault at 558a42e9ff30 ip 0000558a42e9ff30 
sp 00007f3225ee4e80 error 14 likely on CPU 0 (core 0, socket 0)
[  126.258095] Code: Unable to access opcode bytes at 0x558a42e9ff06.
[  131.199937] 9pnet: 9p-dbg: TFLUSH retry hit, fatal=1
[  131.201868] 9pnet: 9p-dbg: bailing out via recalc_sigpending
executing program
[  131.270955] repro[366]: segfault at 558a42e9ff30 ip 0000558a42e9ff30 
sp 00007f3225ee4e80 error 14 likely on CPU 3 (core 3, socket 0)
[  131.275131] Code: Unable to access opcode bytes at 0x558a42e9ff06.
[  136.219066] 9pnet: 9p-dbg: TFLUSH retry hit, fatal=1
[  136.221359] 9pnet: 9p-dbg: bailing out via recalc_sigpending
executing program
[  136.290772] repro[369]: segfault at 558a42e9ff30 ip 0000558a42e9ff30 
sp 00007f3225ee4e80 error 14 likely on CPU 2 (core 2, socket 0)
[  136.295901] Code: Unable to access opcode bytes at 0x558a42e9ff06.
[  141.237955] 9pnet: 9p-dbg: TFLUSH retry hit, fatal=1
[  141.239800] 9pnet: 9p-dbg: bailing out via recalc_sigpending
executing program
...

Without the patch the second pr_info never appears and the task
hangs in D-state.

On a real server I couldn't reproduce this by hand. The reproducer
hits the branch deterministically (logs above); why hand-issued
SIGKILLs don't get there is a kernel signal-delivery question
outside the path this patch touches, and I didn't dig into it.

Feel free to revert if anything turns up in the next weeks.

-- 
Thanks,
Vasiliy
