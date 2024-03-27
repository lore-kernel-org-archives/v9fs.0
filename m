Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285614EC44
	for <v9fs@lists.linux.dev>; Wed, 27 Mar 2024 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571090; cv=none; b=ElbNQv1JDuYCH0dfEIwHouND+OWyKvDODO5z/NnaRqPs1F9/U5es+0EnMYBr6pmirfRzNZoFqwMS/hvGzGCEz7N6jNJsbBc+nBOm0/B98Bfz+T4u5qOvgPUMMKbFxAebTQSJKuarmEQgUoJVRkBmHfYsmuPrxdKjcHncoTpX6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571090; c=relaxed/simple;
	bh=2wt5pcKGxNbpvWCg8ZTbrpXO3NVBOSuebT4+RRom7BE=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=JPzM9/+QQ5NaLG340oXJ5jnwrOnNe583UUys/PtqidNAHZTopqaVPVYkNyEJsG8nPOF0e2I9OHj3j/gkzkadoSVLEcwwc38VMxI772gSWQUVvtHE4UtJTEQPG1T9S8refij9zAR8ZpP45xFza9IWo87loRomt3ixMjxHeKlI+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUuu509u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUuu509u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711571088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5OpSCK5ZWGlU+xhOZk/X4d6um5rclbXdax5bm29ta4o=;
	b=CUuu509u2L3dDKtFIk8GEhChSq5re2Ci493hffj5+BcDF9P6MclPmQ9p8FOohJluV8DQ+W
	kRPKDuH9tYp1+ef8MdBue85UDHF5e91aJRB+2z6XARZRypWwmrPzQp6tG0ytICjZ9+kv8w
	oW9NkK4Qnvfwc/a02gQxo5tIomuqhTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-2F0moKomNwurP2UcBacpSA-1; Wed, 27 Mar 2024 16:24:44 -0400
X-MC-Unique: 2F0moKomNwurP2UcBacpSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 713F585A58C;
	Wed, 27 Mar 2024 20:24:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 04FB840C6CB1;
	Wed, 27 Mar 2024 20:24:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>
cc: dhowells@redhat.com, Christian Schoenebeck <linux_oss@crudebyte.com>,
    Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: Clean up some kdoc and unused var warnings.
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2540926.1711571061.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Mar 2024 20:24:21 +0000
Message-ID: <2540927.1711571061@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

    =

Remove the kdoc for the removed 'req' member of the 9p_conn struct.

Remove a pair of set-but-not-used v9ses variables.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
---
 fs/9p/vfs_inode_dotl.c |    4 ----
 net/9p/trans_fd.c      |    1 -
 2 files changed, 5 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..7af27ba1c25d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -297,7 +297,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap=
,
 			       umode_t omode)
 {
 	int err;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid =3D NULL, *dfid =3D NULL;
 	kgid_t gid;
 	const unsigned char *name;
@@ -307,7 +306,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap=
,
 	struct posix_acl *dacl =3D NULL, *pacl =3D NULL;
 =

 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
-	v9ses =3D v9fs_inode2v9ses(dir);
 =

 	omode |=3D S_IFDIR;
 	if (dir->i_mode & S_ISGID)
@@ -739,7 +737,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct in=
ode *dir,
 	kgid_t gid;
 	const unsigned char *name;
 	umode_t mode;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid =3D NULL, *dfid =3D NULL;
 	struct inode *inode;
 	struct p9_qid qid;
@@ -749,7 +746,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct in=
ode *dir,
 		 dir->i_ino, dentry, omode,
 		 MAJOR(rdev), MINOR(rdev));
 =

-	v9ses =3D v9fs_inode2v9ses(dir);
 	dfid =3D v9fs_parent_fid(dentry);
 	if (IS_ERR(dfid)) {
 		err =3D PTR_ERR(dfid);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 1a3948b8c493..196060dc6138 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -95,7 +95,6 @@ struct p9_poll_wait {
  * @unsent_req_list: accounting for requests that haven't been sent
  * @rreq: read request
  * @wreq: write request
- * @req: current request being processed (if any)
  * @tmp_buf: temporary buffer to read in header
  * @rc: temporary fcall for reading current frame
  * @wpos: write position for current frame

