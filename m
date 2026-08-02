Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B03BCD25
	for <v9fs@lists.linux.dev>; Sun,  2 Aug 2026 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684181; cv=none; b=EjEg2XuHaF/I9wp3+oFmvC2IhEbugJIQVrWWcutu7mxoR1+55z5XeEoUE4o7Ntc/PM2Hayq1IQy0uedbYSHdHLhSegGUEPzfdVUphwQ/PZPcnS9rW2TX5Ry9VaFCZGiAV2lA7tBx/o3kVD7SVX9mKbYKtjersfK0dlpipNLZl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684181; c=relaxed/simple;
	bh=yEy2DCNdJA/I7Pl94OowDCOEAR1CJ0sdHmR8slgOib0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KGcJvIt/I8SkxkLaNGG0UFUvJPtYG8CMDYvDk4mscIgRDpZKYdZ0wIPBQ7pvTHAQiEdCtaaMzwtkp42o5BpCKzeiBkZVSZQU2U0Qz1gfJrS89bAa+YL6pJ+0vtP5gI2c/WZjm0aHBacpgx0QpdNs387DQkvUJyd3ekoExRw2L80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtSPUZ7F; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtSPUZ7F"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso2949836b3a.2
        for <v9fs@lists.linux.dev>; Sun, 02 Aug 2026 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785684180; x=1786288980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hd5PlWgRxgIJLaDM2acSHPFR2qhyClwTJqROSBY7RIs=;
        b=UtSPUZ7F9ed5ypSvMjJZtKPhtl9Ei/1h+o+6Js86hMq55g9v2MJA1Zlzmys/8xz7cV
         5AJxQEV6OsUr2Q1jqx4s9003GcqHfOGDGMpJyFE7V+YCsYbvgUs0VU/89j3evHLfRazG
         1FNa+knGAgEZJ6d9R6NvI5hJW9p97upNVshCLoOmbpNijzkMyyAMBKw3DNFmJU/WUFbR
         ORDPDmx5P304WoHNreTel5JSf29EeaJD58qs17ejeirrk6yHUi0uhIoqXIgnLgT6FWPx
         04Gn7krLGr5umtbuVft6dQNKFMJINcBW2OlH8o7uWnvGlsw7sQQflMVN8PXQihQxbBTW
         PNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785684180; x=1786288980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hd5PlWgRxgIJLaDM2acSHPFR2qhyClwTJqROSBY7RIs=;
        b=K8Qz9bHqeXFwPxQkuwZiwTdm+6LXshnSF5nj+Y/T7Fieu8XzSKhYTixKtV563PCAeI
         FhYS8kkaOr6Tv6UgZ8GIUgptZYKga3vrC1vNI/VxIr9qcF0Epo5OF/qUkFMeUuzeBrzu
         OHluz5tv63gus2dQfynW1g5hwxo1k0qG6VOGsGFm+b8Extbzope33fkak3c2TYKZ+/nE
         6YoqdTUqGkx6mY2itkiQPEBueUFQqIUqa3Fr3Dxj7LrrKYGn9bODfC9XUI9WPD8orJ1k
         644svqVbeToTvjIBMStmOB4ATjExxS6BjffALzCAwlbxRuViLZ3jBnPu51sC/ZEEJxja
         VsBQ==
X-Gm-Message-State: AOJu0YzMV8IoWWDIN44Eth2fp6c4I0mtDoJLcUskHG0AP3EJbxSoKor5
	3Ohn8mquOO6lfatyEQMKKFERoqV3pgOQRXif0jTyuer1vzzi6D62+4dJ
X-Gm-Gg: AR+sD10MNYVu7qlk9x4N0e660fm8CkWGijRVy/sIHYxwuAz8KZS+eXs7RAK5PaG+Z9d
	Ao4/c4U/8Nsf9/zkw6wWQg5om7EdgJ5gUrH/gJ/7ahHySlQhW7b0OpTL8MDxuz3rGE6ife2lRkB
	ZarokrM0v97piZm3YbfQ1L+WOvsmBZ8H5XQpRPu8afUWc+fcTDHo6pd5Ptfjlxb3ycKmFjNQKK2
	8aELQ+AmEGbEJIpcrtT6ke3M0Udpz7butMmOkkyrYuAgxO7/zOJo5Az9kztFWEJJuUj1ghSNAqD
	6JEyaDT3LNlmP00HrE5jMUpKlLZi8tMM2TMUypuSfYi+zvmx94BVojFBlIksqdg8XbgEQFzCZjR
	AMwMZCdUG37LUnu9GzOHD342LtsBL7N8bb4gzNxThAw3KEhHB+mz3t08LZIwvSnwuz+EiyjM3MU
	0gHqEK6fpvFG+LVEyAitEg4aoqfw4yTVUxTDnzblrF2PLs91D7+lUJYntH4Sxa4KTR//dAPn/dQ
	qXKHIwCigXFAO6SwFdSVoeZ7GlKs2uglHsNuYsE6MpYqw==
X-Received: by 2002:a05:6a00:2d25:b0:848:469b:3d19 with SMTP id d2e1a72fcca58-84ee4881d3emr6073405b3a.29.1785684179816;
        Sun, 02 Aug 2026 08:22:59 -0700 (PDT)
Received: from chcpu15.cse.ust.hk (191host116.mobilenet.cse.ust.hk. [143.89.191.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe7a243sm2573001b3a.24.2026.08.02.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 08:22:58 -0700 (PDT)
From: Qi Zhang <marsy12010123@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <mgr@kernel.org>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org,
	Qi Zhang <marsy12010123@gmail.com>
Subject: [PATCH] net/9p/usbg: clear stale request context after abort
Date: Sun,  2 Aug 2026 23:21:48 +0800
Message-Id: <20260802152148.810390-1-marsy12010123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

usb9pfs_clear_tx() serializes access to the active TX request with
usb9pfs->lock, but leaves in_req->context pointing at the request after
p9_client_cb() drops the transport reference.  A later teardown path can
therefore retrieve the same request after it has been freed:

  CPU 0 (p9_usbg_close)        CPU 1 (usb9pfs_disable)
  lock(usb9pfs->lock)
  req = in_req->context
  p9_client_cb(client, req)
    p9_req_put(client, req)
  unlock(usb9pfs->lock)
  request reaches zero refs
    kmem_cache_free(req)
                                lock(usb9pfs->lock)
                                req = in_req->context
                                read req->t_err

The lock orders the two callbacks, but cannot protect a pointer that
remains published after its reference has been released.  KASAN reported:

  BUG: KASAN: slab-use-after-free in usb9pfs_clear_tx+0x166/0x1b0
  Read of size 4 at addr ffff88810e7420f4 by task poc/94
  Call Trace:
   usb9pfs_clear_tx+0x166/0x1b0
   usb9pfs_disable+0x1d/0x30
   reset_config+0x9d/0x200
   __composite_disconnect+0xa7/0x140
  Allocated by task 93:
   kmem_cache_alloc_noprof+0x141/0x370
   p9_tag_alloc+0x8f/0x5b0
   p9_client_prepare_req+0xff/0x350
   p9_client_rpc+0x1a5/0xac0
  Freed by task 0:
   slab_free_after_rcu_debug+0xa6/0x1e0
   rcu_core+0x50a/0x1850
  Last potentially related work creation:
   kmem_cache_free+0x1db/0x3d0
   p9_req_put+0x164/0x1f0
   usb9pfs_clear_tx+0x120/0x1b0
   p9_usbg_close+0x7e/0x150

Clear in_req->context after the callback while still holding the lock.
This matches the consume-and-clear pattern in usb9pfs_tx_complete(), so
subsequent teardown calls return without touching the released request.
The existing callback and error ordering remain unchanged.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
---
 net/9p/trans_usbg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 419cda13a7b5..9a83dff6f3dd 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -439,6 +439,7 @@ static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
 		req->t_err = -ECONNRESET;
 
 	p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
+	usb9pfs->in_req->context = NULL;
 }
 
 static void p9_usbg_close(struct p9_client *client)
-- 
2.43.0

