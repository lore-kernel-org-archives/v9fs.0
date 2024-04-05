Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C716C69D
	for <v9fs@lists.linux.dev>; Fri,  5 Apr 2024 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316957; cv=none; b=X7MJfhntDZ2MTP0DRiR+FV2pMemlY9645COvQNDWaGGzKPcEtZtmRlegtI0zowvwbYtcOzyKgmMdyqYrVuw5Y+sT/wZUdzg+RoUprj15sSv0BqpaclEw1klyqLwgkK19sThd+C7Pg+pYScIrp6Vwjt17sxU6E6RwV/fNVu3pr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316957; c=relaxed/simple;
	bh=sftWoBpbGJaOE1LHFFMMJI4nyXjYFzulW/XD3IxjPYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nhj4EX0fqCLAc9kNCphcbMrxYTkjwIYrwr3QsLo88Vd2/NClpCv4mUkAURT86zGrs6t+mtzHgngRQxGisC7KuMQRnV8P8hJNgRRC3fSRE9I4gKLudnk7RfkutC/cEk3ZkewHvqffUpR7voYF/Mc5drQoM97mW0MQ1H9fS7DbX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 5 Apr
 2024 14:35:51 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 5 Apr 2024
 14:35:50 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Eric Van Hensbergen <ericvh@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Latchesar Ionkov
	<lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, "Christian
 Schoenebeck" <linux_oss@crudebyte.com>, <v9fs@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com>
Subject: [PATCH net] net/9p: fix uninit-value in p9_client_rpc()
Date: Fri, 5 Apr 2024 04:35:40 -0700
Message-ID: <20240405113540.20456-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Syzbot with the help of KMSAN reported the following error:

BUG: KMSAN: uninit-value in trace_9p_client_res include/trace/events/9p.h:146 [inline]
BUG: KMSAN: uninit-value in p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 trace_9p_client_res include/trace/events/9p.h:146 [inline]
 p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
 p9_tag_alloc net/9p/client.c:278 [inline]
 p9_client_prepare_req+0x20a/0x1770 net/9p/client.c:641
 p9_client_rpc+0x27e/0x1340 net/9p/client.c:688
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

If p9_check_errors() fails early in p9_client_rpc(), req->rc.tag
will not be properly initialized. However, trace_9p_client_res()
ends up trying to print it out anyway before p9_client_rpc()
finishes.

Fix this issue by assigning default values to p9_fcall fields
such as 'tag' and (just in case KMSAN unearths something new) 'id'
during the tag allocation stage.

Reported-and-tested-by: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
Fixes: 348b59012e5c ("net/9p: Convert net/9p protocol dumps to tracepoints")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. Not entirely sure that 'Fixes' tag is fully correct here.

 net/9p/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/client.c b/net/9p/client.c
index e265a0ca6bdd..a9d613af7455 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -235,6 +235,8 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 	if (!fc->sdata)
 		return -ENOMEM;
 	fc->capacity = alloc_msize;
+	fc->id = 0;
+	fc->tag = 0;
 	return 0;
 }
 
