Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972EE1AC425
	for <v9fs@lists.linux.dev>; Tue,  9 Jul 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542551; cv=none; b=kQY9QdQqiDCbsAlQrmUhLD5HAOaBkTPvNnPvk/qHfkJDqpTr/TXbwXKv98JNQstVW0kqUZLx5B7CMcyleAImAwWbCm3tV47X3OlXFaNbPdxIRwit5BBkEcheLM6sv3Aq138LTFVs5mmcWSKuQXKms2WqMINDDriBm0mZs3DliL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542551; c=relaxed/simple;
	bh=kOZG8fNJrJlZuakPvtiB3L5cOlJOdQaRoxSINBvrd0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7RA7Nn9OsJ1WbiY//9NaU93Dj3QHntS/qqEBtIZJOefql/kH8SxKVbCnMIFKQAqCviAS15GY9lcTRyYueVcTjcrsom3rAO4Tj5XNdAgG2PTbFLrnnbhvN+CJaGE+FnIeCKktzUgRXxu+YREce+/e0JodF0C94qS2AXKHUpxxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447f41aba9dso11114581cf.0
        for <v9fs@lists.linux.dev>; Tue, 09 Jul 2024 09:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542548; x=1721147348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oV9V0NGv8AYIf8qymFC8ICSxpqZxn+6bGQPkYbNjO1s=;
        b=TviQQujmhAitck8qNCYVg6toNjBRUbD66hsNAu4iV38mPIm3qJa9Z5YJIrybUBovcj
         4W2COlUxdqA5wSnjfJDIcvkuXSV3HDBpIC+ri9dqXXs8/A0D3+TQAT4UTPQRsPJX1JBe
         CZQGio0ifPiLp0J/FA6UYXyizQKTTmPFgjUK/29UBGz9X4F4LFwjaOwzjcmaTSY4Bo1g
         7LhLAvo45dHbqBrhdMudPVDzTikOUQSoWKsQ30r6ZFlClEDnwovaBSm2O5rGaH3Q2D5P
         mBh4YHeZIdd+gwRFMcxrurK+iNkC83URGXRKbLRnps7N16JGb5CG/2lf8l1fgGMVj6dV
         ZI8g==
X-Forwarded-Encrypted: i=1; AJvYcCUSVqc3IbI8vH4A+iZd08Beqb5+Q/vDpDvLKoQ6Kc1pTQREy+4gxs4ksDBe+ptprOSoAqaSM44/IjtIpVEuQMLarXMFjg==
X-Gm-Message-State: AOJu0YwWLk6zSDvfB2ba8aRbASTAcjFSa06QvGJk4PGJ2EjMQLRS0yNK
	IlcMVYEbawUQH5j62Dp/+g6SToN8z0Fc4nEpgy/1m3wFPogIMOi0
X-Google-Smtp-Source: AGHT+IGDggrjeu0qydOoSSBZxs6sMchWfpiZtfm6yB3raETXHz203fTJQ2j6sVkXNYw6GXMHRMGVcw==
X-Received: by 2002:ac8:5d46:0:b0:446:5864:33b1 with SMTP id d75a77b69052e-447fa8ce1camr37651971cf.40.1720542548313;
        Tue, 09 Jul 2024 09:29:08 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447fa56d9aasm11145671cf.34.2024.07.09.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:29:07 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: linux-kernel@vger.kernel.org
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH] net/9p: Fix uaf / refcnt underflow for req object in virtio
Date: Tue,  9 Jul 2024 11:29:04 -0500
Message-ID: <20240709162904.226952-1-void@manifault.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can currently encounter an underflow when freeing an rpc request object
when using a virtio 9p transport, as shown by stress-ng:

$ stress-ng --exec 1 -t 1
...
[    5.188359] ------------[ cut here ]------------
[    5.211094] refcount_t: underflow; use-after-free.
[    5.230781] WARNING: CPU: 6 PID: 557 at lib/refcount.c:28 refcount_warn_saturate+0xb4/0x140
[    5.247551] Modules linked in:
[    5.258476] CPU: 6 PID: 557 Comm: stress-ng-exec- Not tainted 6.10.0-rc2-virtme #26
[    5.276072] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[    5.294310] RIP: 0010:refcount_warn_saturate+0xb4/0x140
[    5.313818] Code: ff 90 0f 0b 90 90 e9 16 07 91 00 cc 80 3d f9 14 83 01 00 75 90 c6 05 f0 14 83 01 01 90 48 c7 c7 97 ad 48 84 e8 5d d2 b5 ff 90 <0f> 0b 90 90 e9 ee 06 91 00 cc 80 3d ce 14 83 01 00 0f 85 64 ff ff
[    5.342462] RSP: 0018:ffffa9ac80a47a28 EFLAGS: 00010246
[    5.345307] RAX: b2786dec9d38b800 RBX: ffff9b67e704eaa8 RCX: ffffffff84c6e950
[    5.361743] RDX: 0000000000000002 RSI: 0000000100005ceb RDI: ffffffff84c9ed60
[    5.384172] RBP: 0000000000000000 R08: 0000000000001ceb R09: ffffffff84c6ed60
[    5.408242] R10: 00000000000056c1 R11: 0000000000000003 R12: 00000000fffffe00
[    5.425085] R13: ffffffff8452db57 R14: ffff9b67cb3b2f00 R15: ffff9b67c4e33ec0
[    5.444305] FS:  00007fb7ba9e16c0(0000) GS:ffff9b67fe780000(0000) knlGS:0000000000000000
[    5.464612] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.481423] CR2: 00007fffcdf76fe8 CR3: 000000000c142000 CR4: 0000000000750ef0
[    5.498275] PKRU: 55555554
[    5.502138] Call Trace:
[    5.505372]  <TASK>
[    5.507353]  ? __warn+0xc9/0x1c0
[    5.511056]  ? refcount_warn_saturate+0xb4/0x140
[    5.520082]  ? report_bug+0x148/0x1e0
[    5.531777]  ? handle_bug+0x3e/0x70
[    5.543371]  ? exc_invalid_op+0x1a/0x50
[    5.557119]  ? asm_exc_invalid_op+0x1a/0x20
[    5.564184]  ? refcount_warn_saturate+0xb4/0x140
[    5.576789]  ? refcount_warn_saturate+0xb3/0x140
[    5.589334]  p9_req_put+0x9e/0xf0
[    5.598119]  p9_client_zc_rpc+0x3ac/0x460
[    5.611438]  ? wake_page_function+0x41/0xa0
[    5.620745]  ? __wake_up_locked_key+0x3f/0x70
[    5.631290]  p9_client_read_once+0xd8/0x2d0
[    5.644251]  p9_client_read+0x3e/0x70
[    5.655285]  v9fs_issue_read+0x47/0x90
[    5.668043]  netfs_begin_read+0x3f2/0x880
[    5.673140]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.676800]  ? netfs_alloc_request+0x21a/0x2b0
[    5.679999]  netfs_read_folio+0xde/0x380
[    5.685441]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.695729]  ? __filemap_get_folio+0x158/0x2a0
[    5.713327]  filemap_read_folio+0x1f/0x70
[    5.726596]  filemap_fault+0x28d/0x510
[    5.737644]  __do_fault+0x42/0xb0
[    5.747996]  handle_mm_fault+0x59c/0x13a0
[    5.759156]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.776631]  ? mt_find+0x2da/0x400
[    5.785758]  do_user_addr_fault+0x1fd/0x790
[    5.800640]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.813852]  exc_page_fault+0x68/0x180
[    5.822403]  asm_exc_page_fault+0x26/0x30
[    5.933431]  </TASK>
[    5.941515] ---[ end trace 0000000000000000 ]---

The sequence that causes this underflow is as follows:

1. The virtio transport returns -ERESTARTSYS from p9_virtio_zc_request()
   due to virtqueue_add_sgs() returning -ENOSPC, and wait_event_killable()
   eventually returning -ERESTARTSYS.

2. The request is never kicked, so its reference is dropped at the end of
   p9_virtio_zc_request(). This is the first of the two available
   references.

3. In p9_client_zc_rpc(), the client is still connected, so we call
   p9_client_flush() which drops the second and final reference in
   the callback to p9_virtio_cancelled().

4. We reference the req object below in p9_virtio_zc_request(), and then
   hit a refcnt underflow when we again try to drop a reference in the
   reterr path.

Let's fix this by only dropping that reference if we're not exiting due to
-ERESTARTSYS, as the assumption is that the reference will instead be
dropped later when we flush the request.

Signed-off-by: David Vernet <void@manifault.com>
---
**NOTE**: I'm not 100% sure that this is correct or the proper way to fix this.
If we get an -ENOSPC error when issuing the flush request on the regular
p9_client_rpc() path taken by p9_client_flush(), then we won't hit the
c->trans_mod->cancelled() (i.e. p9_virtio_cancelled()) path when we would have
otherwise freed this request, so this may end up leaking the request on that
path.

Also not sure if this needs a Fixes tag, as it seems like a bug that's been
around for a very long time.

 net/9p/trans_virtio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 0b8086f58ad5..944f64bf72fe 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -556,8 +556,11 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	}
 	kvfree(in_pages);
 	kvfree(out_pages);
-	if (!kicked) {
-		/* reply won't come */
+	if (!kicked && err != -ERESTARTSYS) {
+		/* Reply won't come, so drop the refcnt here. If we're failing
+		 * with -ERESTARTSYS, the refcnt will be dropped when we flush
+		 * the request.
+		 */
 		p9_req_put(client, req);
 	}
 	return err;
-- 
2.45.2

