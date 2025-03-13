Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E0261396;
	Thu, 13 Mar 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871303; cv=none; b=pZIHdFh/b/Vy5fBT6e9bDy8A7QudNG7w4y+dDLtRt8aHSp/6NQnTwBXb9nVV1ccFxjtxgytvBZd2Zwjs1WIBD2Y86HOmUj5cm5yiniZA66/OQA3rnXHY1Yk+251sfHtrqjlIdmR+YgGnZmaYjXgbCrNJnb02BKXl0CCkMUreos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871303; c=relaxed/simple;
	bh=l7/nvKtdJpfEE3FPoJjanh1QHvfzO9GOB6E4aJRGnec=;
	h=From:Date:Subject:To:Cc:Message-Id; b=Kr7wNpQ2pliwutVLb9nHRhJgz+LvOLZ2FIT+eL5FYZ1q/aCsPiPonr/6qrDhgf5NQ+AZbSuMlXss6/kSja31cb3m69ALu8yTND7Ggox4yu3hdFF1BlD/KtuoP8AJvaxqetoQ1C2jhj7NWc8D7dVV3pFoio9+TkBe7yPIu/d2tp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=kylie.crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=pegRD4Il; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylie.crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="pegRD4Il"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
	Content-Description; bh=twJYDBirwmXLVr0Fm4IHc5rcNUlk8rsVDi+Ys8RdkGk=; b=pegRD
	4IlhFymvfrjnQ+CF8n55HWAnPouP4MBYWqn3+GutaVxp5cJgwmNmmGETgSJlRGR9ewXtXjPa4vqk2
	3CKg/BaKYb4dYQRiye8BXRhDgKTV3AqbD2p4tyuHMjL3Yy8H67seJre0c4T0K73FBEsUQC6Ae5Wfz
	d8YQtqmPVDX3oJyUU4v/M+tPCeAmT9QLJ2UAMw68e5IxI2CtJQS7LCzGoQO0atmnKA5bfGBt2nssT
	fMku+Q8fpjgmy/XfxSFFN9RMt2f3Iwgh6x4PV3CNj1imWpL1rWuB3CfiCF66DF8aTyivrm/5wr991
	rZgG9npZnYPxbqIbW2+ZqmmYysFdymwZWmR9+5eWsUFzKD8PVxzXedNiS+YWGV20o4HzXJ7cxXJJR
	UmZdOO6/QhQYtiYCj/rPUkhCdHwdMz4LsXQiFUg1Cwhp0C9boEa1X2uQsheOfV6fmEZ7qSw1hwYLm
	J5CeAye4rzxjIm7f3Nr1dUQkH+C5Xo8x56AM0ZDwk2K5b8XFCamU6TtVbmSaU0+U0ZgnYPDwGA/04
	ewh1ymfPtpGM+0uo7jLPK8MOHkJOVnW9AJRjcjsK8R4Pl3BSJCPP4HgfOMcUScy7SNvOD6GOCBzFQ
	2J8vM19On2pLV97qOqlYDdIpGh+1PGS3qa6Ay7/bZMXflasdN5sbitfD46Oj+8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
Date: Thu, 13 Mar 2025 13:59:32 +0100
Subject: [PATCH] fs/9p: fix NULL pointer dereference on mkdir
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    v9fs@lists.linux.dev,
    linux-kernel@vger.kernel.org,
    syzbot <syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com>
Message-Id: <E1tsiI6-002iMG-Kh@kylie.crudebyte.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

When a 9p tree was mounted with option 'posixacl', parent directory had a
default ACL set for its subdirectories, e.g.:

  setfacl -m default:group:simpsons:rwx parentdir

then creating a subdirectory crashed 9p client, as v9fs_fid_add() call in
function v9fs_vfs_mkdir_dotl() sets the passed 'fid' pointer to NULL
(since dafbe689736) even though the subsequent v9fs_set_create_acl() call
expects a valid non-NULL 'fid' pointer:

  [   37.273191] BUG: kernel NULL pointer dereference, address: 0000000000000000
  ...
  [   37.322338] Call Trace:
  [   37.323043]  <TASK>
  [   37.323621]  ? __die+0x1f/0x60
  [   37.324448]  ? page_fault_oops+0x158/0x470
  [   37.325532]  ? search_module_extables+0x4a/0x80
  [   37.326742]  ? p9_client_walk+0x1c/0x2c0 [9pnet]
  [   37.328006]  ? search_bpf_extables+0x5b/0x80
  [   37.329142]  ? exc_page_fault+0x72/0x190
  [   37.330196]  ? asm_exc_page_fault+0x22/0x30
  [   37.331330]  ? p9_client_walk+0x1c/0x2c0 [9pnet]
  [   37.332562]  ? v9fs_fid_xattr_get+0x59/0x120 [9p]
  [   37.333824]  v9fs_fid_xattr_set+0x6f/0x130 [9p]
  [   37.335077]  v9fs_set_acl+0x82/0xc0 [9p]
  [   37.336112]  v9fs_set_create_acl+0x41/0x60 [9p]
  [   37.337326]  v9fs_vfs_mkdir_dotl+0x20d/0x2e0 [9p]
  [   37.338590]  vfs_mkdir+0x192/0x250
  [   37.339535]  do_mkdirat+0x135/0x160
  [   37.340465]  __x64_sys_mkdir+0x42/0x60
  [   37.341455]  do_syscall_64+0x4b/0x110
  [   37.342447]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix this by simply swapping the sequence of these two calls in
v9fs_vfs_mkdir_dotl(), i.e. calling v9fs_set_create_acl() before
v9fs_fid_add().

Fixes: dafbe689736 ('9p fid refcount: cleanup p9_fid_put calls')
Reported-by: syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com
Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
---
 fs/9p/vfs_inode_dotl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 143ac03b7425..3397939fd2d5 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -407,8 +407,8 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 			 err);
 		goto error;
 	}
-	v9fs_fid_add(dentry, &fid);
 	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	v9fs_fid_add(dentry, &fid);
 	d_instantiate(dentry, inode);
 	err = 0;
 	inc_nlink(dir);
-- 
2.39.5

