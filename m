Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D919D8A8
	for <v9fs@lists.linux.dev>; Wed, 18 Feb 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432290; cv=none; b=UAktw+6vZKlukx4UTq5/1gYVYOJOSYEaUgCBu0nLdRUCYbJmPQ5bIBhDpNOb5NhUAeYrpXzlFnc9dmTxWAa50dbryEV4tpx4ytBPe7GvCTxI63mClU9xySrp8f9qcsO58W0V84JFhED0keEW7j4QmgsJhnPKkynMIutTF79BlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432290; c=relaxed/simple;
	bh=Vo7BkA9IkVtviT5FYqmAvn2xiIdQZZZqulPnsgkEVa8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=oqDkkBA6MgJtpNobc7Bep99p0fCBQP1Bnn2fzEIcgnY/wWyFNrd+5CV3CX0eL0UPKsSR2rDmQUj7NsSGRwkHc5VdRpgfyLZSy/LzEBf9XMIMJ2HdTZ/Crgm1iko7fKZRv8vvpSWi2srEJDFuHfz9AJ+1EBbN7q2ZyRzxjbBrmbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIRbNPqh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIRbNPqh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771432287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WN6MV/pqqy5N6LA5Oy61SUJnT18IdF+05qt+cT6L1D0=;
	b=ZIRbNPqhkcSBRSwIWIJyjN7iA9NQf2Bp9MCnhaDEncFwkwsinpdphFecmBp76HNXkWX01a
	Pymy/LR1s0cQLgCCM0jZHbpGyqHhKDxY+aR75KWu++iKNduph22WmNtEDTCRuXZZIOJfxA
	Fkmk253QDwAualI60BYgH9hn7yW6L0U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-faGk4RTvOciYq9153V6HaQ-1; Wed,
 18 Feb 2026 11:31:23 -0500
X-MC-Unique: faGk4RTvOciYq9153V6HaQ-1
X-Mimecast-MFC-AGG-ID: faGk4RTvOciYq9153V6HaQ_1771432282
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53C0A195606D;
	Wed, 18 Feb 2026 16:31:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.225.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14A6A180058F;
	Wed, 18 Feb 2026 16:31:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251227083751.715152-1-pierre@barre.sh>
References: <20251227083751.715152-1-pierre@barre.sh>
To: Pierre Barre <pierre@barre.sh>
Cc: dhowells@redhat.com, ericvh@kernel.org, lucho@ionkov.net,
    asmadeus@codewreck.org, linux_oss@crudebyte.com,
    v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: fix data corruption with writeback caching during concurrent stat
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 18 Feb 2026 16:31:16 +0000
Message-ID: <1667424.1771432276@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: LJGOTKtpy8-zh_2SzC7QTkghXNauFbnblLV4Jhw6O8U_1771432282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1667423.1771432276.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

How about something along these lines instead?  It's a bit more convoluted =
and
will probably still get it wrong if a third party interferes - but I don't
think there's a whole lot we can do about that without changing the protoco=
l.

David
---
9p: fix data corruption with writeback caching during concurrent stat

When using writeback caching (cache=3Dmmap), v9fs_vfs_getattr/setattr have
two issues that can cause data corruption:

1. filemap_fdatawrite() initiates writeback but doesn't wait for
   completion.  The subsequent server stat sees stale file size.

2. v9fs_stat2inode()/v9fs_stat2inode_dotl() unconditionally overwrite
   i_size from the server response, even when dirty pages exist locally.
   This causes processes using lseek(SEEK_END) to see incorrect file sizes.

Fix by the following means:

 (1) Make cache_validity a bitmask and use atomic bitops on it.

 (2) Use a flag to keep track of when the mtime is 'uncertain'.  Set this
     upon completion of a write subrequest and clear it when we either
     fetch and update the mtime or do a setattr.

 (3) Alter getattr to make the following choices, in order of preference:

     (a) If in CACHE_META/LOOSE mode, don't care about keeping mtime/i_size
         uptodate.

     (b) If AT_STATX_FORCE_SYNC is supplied, then sync all outstanding
         writes and wait, then fetch the new stats.

     (c) If AT_STATX_DONT_SYNC is supplied, then the user specifically said
         they don't care and we do as LOOSE.

     (d) If the mtime is marked uncertain and STATX_MTIME is specifically
         requested, then do as FORCE_SYNC (stat(2) will do this).

     (e) If in CACHE_WRITEBACK mode, start the writeback, but disregard the
         mtime change on the server for now.  Note there's nothing to
         guarantee the ordering writeback will write to the server versus
         the stat retrieval, so mtime may or may not be seen to be updated.

     (f) Otherwise, writeback is not initiated.

 (4) Make setattr write and wait and clear the uncertain mtime flag.

 (5) Update ->netfs.remote_i_size after a successful Write RPC call that
     appears to move the EOF marker.  Writes are done synchronously, so we
     only have to worry about one at a time and netfslib uses a lock to
     serialise writebacks.

 (6) Fix the updating of i_size in stat2inode by:

     (a) Just set it for a new inode.

     (b) If the retrieved file length matches ->netfs.remote_i_size then
     =09 skip updating i_size.  Assume nothing has changed on the server
     =09 and the local i_size is correct.

     (c) If they don't match, then assume a third party interfered and
     =09 invalidate the local cache and discard any local changes, then
     =09 update i_size and remote_i_size.  The invalidation has no effect
     =09 if we're doing unbuffered I/O.

Note that I don't think that we really need to start a writeback for
getattr in CACHE_WRITEBACK mode unless specifically told to sync - and then
we need to wait if STATX_MTIME is set.

Further, if the pagecache is dirty, can we just go with the local mtime
unless the mtime is marked uncertain?  And if it is marked uncertain, and
STATX_MTIME is set, we should just be able to get the stats without
flushing.  Possibly, the act of writing in to the pagecache and setting
i_mtime locally should clear the uncertainty flag - it will be set again
when we write back.

One final thought: should getattr() take i_rwsem when it flushes if it is
forced to sync?  It could take a write lock on i_rwsem and then downgrade
it so that reads can happen concurrently.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Pierre Barre <pierre@barre.sh>
---
 fs/9p/v9fs.h           |    5 +-
 fs/9p/v9fs_vfs.h       |    3 +
 fs/9p/vfs_addr.c       |   11 +++++
 fs/9p/vfs_dentry.c     |    4 +-
 fs/9p/vfs_inode.c      |   84 ++++++++++++++++++++++++++++++-------------
 fs/9p/vfs_inode_dotl.c |   95 ++++++++++++++++++++++++++++++++++++--------=
-----
 6 files changed, 147 insertions(+), 55 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 6a12445d3858..bc4a86c289f4 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -134,12 +134,13 @@ struct v9fs_session_info {
 };
=20
 /* cache_validity flags */
-#define V9FS_INO_INVALID_ATTR 0x01
+#define V9FS_INO_INVALID_ATTR=09=090
+#define V9FS_INO_MTIME_UNCERTAIN=091
=20
 struct v9fs_inode {
 =09struct netfs_inode netfs; /* Netfslib context and vfs inode */
 =09struct p9_qid qid;
-=09unsigned int cache_validity;
+=09unsigned long cache_validity;
 =09struct mutex v_mutex;
 };
=20
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index d3aefbec4de6..58f953788791 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -27,6 +27,7 @@
=20
 /* flags for v9fs_stat2inode() & v9fs_stat2inode_dotl() */
 #define V9FS_STAT2INODE_KEEP_ISIZE 1
+#define V9FS_STAT2INODE_NEW_INODE 2
=20
 extern struct file_system_type v9fs_fs_type;
 extern const struct address_space_operations v9fs_addr_operations;
@@ -70,7 +71,7 @@ static inline void v9fs_invalidate_inode_attr(struct inod=
e *inode)
 =09struct v9fs_inode *v9inode;
=20
 =09v9inode =3D V9FS_I(inode);
-=09v9inode->cache_validity |=3D V9FS_INO_INVALID_ATTR;
+=09set_bit(V9FS_INO_INVALID_ATTR, &v9inode->cache_validity);
 }
=20
 int v9fs_open_to_dotl_flags(int flags);
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 862164181bac..1dbf05df8fc5 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -53,12 +53,21 @@ static void v9fs_begin_writeback(struct netfs_io_reques=
t *wreq)
  */
 static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
 {
+=09struct inode *inode =3D subreq->rreq->inode;
+=09struct v9fs_inode *v9inode =3D V9FS_I(inode);
 =09struct p9_fid *fid =3D subreq->rreq->netfs_priv;
 =09int err, len;
=20
 =09len =3D p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
-=09if (len > 0)
+=09if (len > 0) {
+=09=09unsigned long long end =3D subreq->start + len;
+=09=09spin_lock(&inode->i_lock);
+=09=09if (end > v9inode->netfs.remote_i_size)
+=09=09=09v9inode->netfs.remote_i_size =3D end;
+=09=09set_bit(V9FS_INO_MTIME_UNCERTAIN, &v9inode->cache_validity);
+=09=09spin_unlock(&inode->i_lock);
 =09=09__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+=09}
 =09netfs_write_subrequest_terminated(subreq, len ?: err);
 }
=20
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index c5bf74d547e8..aca71d0ba4b8 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -75,7 +75,7 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry=
, unsigned int flags)
 =09=09goto out_valid;
=20
 =09v9inode =3D V9FS_I(inode);
-=09if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
+=09if (test_bit(V9FS_INO_INVALID_ATTR, &v9inode->cache_validity)) {
 =09=09int retval;
 =09=09struct v9fs_session_info *v9ses;
=20
@@ -100,7 +100,7 @@ static int __v9fs_lookup_revalidate(struct dentry *dent=
ry, unsigned int flags)
 =09=09=09=09 dentry, dentry);
 =09=09=09return 0;
 =09=09}
-=09=09if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
+=09=09if (test_bit(V9FS_INO_INVALID_ATTR, &v9inode->cache_validity)) {
 =09=09=09p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) invalidated due to type =
change\n",
 =09=09=09=09 dentry, dentry);
 =09=09=09return 0;
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 97abe65bf7c1..8bb7c4bf8ed3 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -435,7 +435,7 @@ static struct inode *v9fs_qid_iget(struct super_block *=
sb,
 =09if (retval)
 =09=09goto error;
=20
-=09v9fs_stat2inode(st, inode, sb, 0);
+=09v9fs_stat2inode(st, inode, sb, V9FS_STAT2INODE_NEW_INODE);
 =09v9fs_set_netfs_context(inode);
 =09v9fs_cache_inode_get_cookie(inode);
 =09unlock_new_inode(inode);
@@ -966,23 +966,33 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struc=
t path *path,
 {
 =09struct dentry *dentry =3D path->dentry;
 =09struct inode *inode =3D d_inode(dentry);
-=09struct v9fs_session_info *v9ses;
+=09struct v9fs_session_info *v9ses =3D v9fs_dentry2v9ses(dentry);
+=09struct v9fs_inode *v9inode =3D V9FS_I(inode);
 =09struct p9_fid *fid;
-=09struct p9_wstat *st;
+=09struct p9_wstat *st =3D NULL;
+=09bool force_sync =3D flags & AT_STATX_FORCE_SYNC;
+=09int retval;
=20
 =09p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
-=09v9ses =3D v9fs_dentry2v9ses(dentry);
-=09if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-=09=09generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-=09=09return 0;
-=09} else if (v9ses->cache & CACHE_WRITEBACK) {
-=09=09if (S_ISREG(inode->i_mode)) {
-=09=09=09int retval =3D filemap_fdatawrite(inode->i_mapping);
=20
-=09=09=09if (retval)
-=09=09=09=09p9_debug(P9_DEBUG_ERROR,
-=09=09=09=09    "flushing writeback during getattr returned %d\n", retval)=
;
-=09=09}
+=09if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+=09=09goto fill;
+=09if ((flags & AT_STATX_DONT_SYNC) && !force_sync)
+=09=09goto fill;
+=09if (test_bit(V9FS_INO_MTIME_UNCERTAIN, &v9inode->cache_validity) &&
+=09    (request_mask & STATX_MTIME))
+=09=09force_sync =3D true;
+
+=09if (S_ISREG(inode->i_mode)) {
+=09=09if (force_sync)
+=09=09=09retval =3D filemap_write_and_wait(inode->i_mapping);
+=09=09else if (v9ses->cache & CACHE_WRITEBACK)
+=09=09=09retval =3D filemap_fdatawrite(inode->i_mapping);
+=09=09else
+=09=09=09retval =3D 0;
+=09=09if (retval)
+=09=09=09p9_debug(P9_DEBUG_ERROR,
+=09=09=09=09 "flushing writeback during getattr returned %d\n", retval);
 =09}
 =09fid =3D v9fs_fid_lookup(dentry);
 =09if (IS_ERR(fid))
@@ -993,11 +1003,20 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const stru=
ct path *path,
 =09if (IS_ERR(st))
 =09=09return PTR_ERR(st);
=20
-=09v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb, 0);
-=09generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
+=09/*
+=09 * With writeback caching, the client is authoritative for i_size.
+=09 * Don't let the server overwrite it with a potentially stale value.
+=09 */
+=09v9fs_stat2inode(st, inode, dentry->d_sb,
+=09=09=09(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0=
);
+
+fill:
+=09generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
=20
-=09p9stat_free(st);
-=09kfree(st);
+=09if (st) {
+=09=09p9stat_free(st);
+=09=09kfree(st);
+=09}
 =09return 0;
 }
=20
@@ -1014,6 +1033,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 {
 =09int retval, use_dentry =3D 0;
 =09struct inode *inode =3D d_inode(dentry);
+=09struct v9fs_inode *v9inode =3D V9FS_I(inode);
 =09struct v9fs_session_info *v9ses;
 =09struct p9_fid *fid =3D NULL;
 =09struct p9_wstat wstat;
@@ -1058,7 +1078,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
=20
 =09/* Write all dirty data */
 =09if (d_is_reg(dentry)) {
-=09=09retval =3D filemap_fdatawrite(inode->i_mapping);
+=09=09retval =3D filemap_write_and_wait(inode->i_mapping);
 =09=09if (retval)
 =09=09=09p9_debug(P9_DEBUG_ERROR,
 =09=09=09    "flushing writeback during setattr returned %d\n", retval);
@@ -1072,6 +1092,8 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 =09if (retval < 0)
 =09=09return retval;
=20
+=09if (iattr->ia_valid & ATTR_MTIME)
+=09=09clear_bit(V9FS_INO_MTIME_UNCERTAIN, &v9inode->cache_validity);
 =09if ((iattr->ia_valid & ATTR_SIZE) &&
 =09=09 iattr->ia_size !=3D i_size_read(inode)) {
 =09=09truncate_setsize(inode, iattr->ia_size);
@@ -1113,6 +1135,7 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *=
inode,
 =09inode_set_atime(inode, stat->atime, 0);
 =09inode_set_mtime(inode, stat->mtime, 0);
 =09inode_set_ctime(inode, stat->mtime, 0);
+=09clear_bit(V9FS_INO_MTIME_UNCERTAIN, &v9inode->cache_validity);
=20
 =09inode->i_uid =3D v9ses->dfltuid;
 =09inode->i_gid =3D v9ses->dfltgid;
@@ -1141,12 +1164,25 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode=
 *inode,
 =09mode |=3D inode->i_mode & ~S_IALLUGO;
 =09inode->i_mode =3D mode;
=20
-=09v9inode->netfs.remote_i_size =3D stat->length;
-=09if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE))
+=09bool set_size;
+=09if (flags & V9FS_STAT2INODE_NEW_INODE) {
+=09=09set_size =3D true;
+=09} else if (stat->length =3D=3D v9inode->netfs.remote_i_size) {
+=09=09set_size =3D false;
+=09} else {
+=09=09/* Uh oh - the server copy appears to have changed. */
+=09=09filemap_invalidate_inode(inode, false, 0, LLONG_MAX);
+=09=09set_size =3D true;
+=09}
+=09if (set_size) {
+=09=09v9inode->netfs.remote_i_size =3D stat->length;
 =09=09v9fs_i_size_write(inode, stat->length);
-=09/* not real number of blocks, but 512 byte ones ... */
-=09inode->i_blocks =3D (stat->length + 512 - 1) >> 9;
-=09v9inode->cache_validity &=3D ~V9FS_INO_INVALID_ATTR;
+=09=09/* not real number of blocks, but 512 byte ones ... */
+=09=09inode->i_blocks =3D (stat->length + 512 - 1) >> 9;
+=09}
+
+no_size_change:
+=09clear_bit(V9FS_INO_INVALID_ATTR, &v9inode->cache_validity);
 }
=20
 /**
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 643e759eacb2..cbf789752183 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -125,7 +125,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_bl=
ock *sb,
 =09if (retval)
 =09=09goto error;
=20
-=09v9fs_stat2inode_dotl(st, inode, 0);
+=09v9fs_stat2inode_dotl(st, inode, V9FS_STAT2INODE_NEW_INODE);
 =09v9fs_set_netfs_context(inode);
 =09v9fs_cache_inode_get_cookie(inode);
 =09retval =3D v9fs_get_acl(inode, fid);
@@ -421,25 +421,36 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
 =09=09      u32 request_mask, unsigned int flags)
 {
 =09struct dentry *dentry =3D path->dentry;
-=09struct v9fs_session_info *v9ses;
-=09struct p9_fid *fid;
 =09struct inode *inode =3D d_inode(dentry);
-=09struct p9_stat_dotl *st;
+=09struct v9fs_session_info *v9ses =3D v9fs_dentry2v9ses(dentry);
+=09struct v9fs_inode *v9inode =3D V9FS_I(inode);
+=09struct p9_fid *fid;
+=09struct p9_stat_dotl *st =3D NULL;
+=09bool force_sync =3D flags & AT_STATX_FORCE_SYNC;
+=09int retval;
=20
 =09p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
-=09v9ses =3D v9fs_dentry2v9ses(dentry);
-=09if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-=09=09generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-=09=09return 0;
-=09} else if (v9ses->cache) {
-=09=09if (S_ISREG(inode->i_mode)) {
-=09=09=09int retval =3D filemap_fdatawrite(inode->i_mapping);
=20
-=09=09=09if (retval)
-=09=09=09=09p9_debug(P9_DEBUG_ERROR,
-=09=09=09=09    "flushing writeback during getattr returned %d\n", retval)=
;
-=09=09}
+=09if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+=09=09goto fill;
+=09if ((flags & AT_STATX_DONT_SYNC) && !force_sync)
+=09=09goto fill;
+=09if (test_bit(V9FS_INO_MTIME_UNCERTAIN, &v9inode->cache_validity) &&
+=09    (request_mask & STATX_MTIME))
+=09=09force_sync =3D true;
+
+=09if (S_ISREG(inode->i_mode)) {
+=09=09if (force_sync)
+=09=09=09retval =3D filemap_write_and_wait(inode->i_mapping);
+=09=09else if (v9ses->cache & CACHE_WRITEBACK)
+=09=09=09retval =3D filemap_fdatawrite(inode->i_mapping);
+=09=09else
+=09=09=09retval =3D 0;
+=09=09if (retval)
+=09=09=09p9_debug(P9_DEBUG_ERROR,
+=09=09=09=09 "flushing writeback during getattr returned %d\n", retval);
 =09}
+
 =09fid =3D v9fs_fid_lookup(dentry);
 =09if (IS_ERR(fid))
 =09=09return PTR_ERR(fid);
@@ -453,8 +464,15 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
 =09if (IS_ERR(st))
 =09=09return PTR_ERR(st);
=20
-=09v9fs_stat2inode_dotl(st, d_inode(dentry), 0);
-=09generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
+=09/*
+=09 * With writeback caching, the client is authoritative for i_size.
+=09 * Don't let the server overwrite it with a potentially stale value.
+=09 */
+=09v9fs_stat2inode_dotl(st, inode,
+=09=09=09     (v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZ=
E : 0);
+
+fill:
+=09generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 =09/* Change block size to what the server returned */
 =09stat->blksize =3D st->st_blksize;
=20
@@ -516,6 +534,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 =09int retval, use_dentry =3D 0;
 =09struct inode *inode =3D d_inode(dentry);
 =09struct v9fs_session_info __maybe_unused *v9ses;
+=09struct v9fs_inode *v9inode =3D V9FS_I(inode);
 =09struct p9_fid *fid =3D NULL;
 =09struct p9_iattr_dotl p9attr =3D {
 =09=09.uid =3D INVALID_UID,
@@ -561,7 +580,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
=20
 =09/* Write all dirty data */
 =09if (S_ISREG(inode->i_mode)) {
-=09=09retval =3D filemap_fdatawrite(inode->i_mapping);
+=09=09retval =3D filemap_write_and_wait(inode->i_mapping);
 =09=09if (retval < 0)
 =09=09=09p9_debug(P9_DEBUG_ERROR,
 =09=09=09    "Flushing file prior to setattr failed: %d\n", retval);
@@ -574,6 +593,8 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 =09=09return retval;
 =09}
=20
+=09if (iattr->ia_valid & ATTR_MTIME)
+=09=09clear_bit(V9FS_INO_MTIME_UNCERTAIN, &v9inode->cache_validity);
 =09if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size !=3D
 =09=09 i_size_read(inode)) {
 =09=09truncate_setsize(inode, iattr->ia_size);
@@ -624,6 +645,7 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct =
inode *inode,
 =09=09=09=09stat->st_atime_nsec);
 =09=09inode_set_mtime(inode, stat->st_mtime_sec,
 =09=09=09=09stat->st_mtime_nsec);
+=09=09clear_bit(V9FS_INO_MTIME_UNCERTAIN, &v9inode->cache_validity);
 =09=09inode_set_ctime(inode, stat->st_ctime_sec,
 =09=09=09=09stat->st_ctime_nsec);
 =09=09inode->i_uid =3D stat->st_uid;
@@ -634,9 +656,20 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct=
 inode *inode,
 =09=09mode |=3D inode->i_mode & ~S_IALLUGO;
 =09=09inode->i_mode =3D mode;
=20
-=09=09v9inode->netfs.remote_i_size =3D stat->st_size;
-=09=09if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE))
+=09=09bool set_size;
+=09=09if (flags & V9FS_STAT2INODE_NEW_INODE) {
+=09=09=09set_size =3D true;
+=09=09} else if (stat->st_size =3D=3D v9inode->netfs.remote_i_size) {
+=09=09=09set_size =3D false;
+=09=09} else {
+=09=09=09/* Uh oh - the server copy appears to have changed. */
+=09=09=09filemap_invalidate_inode(inode, false, 0, LLONG_MAX);
+=09=09=09set_size =3D true;
+=09=09}
+=09=09if (set_size) {
+=09=09=09v9inode->netfs.remote_i_size =3D stat->st_size;
 =09=09=09v9fs_i_size_write(inode, stat->st_size);
+=09=09}
 =09=09inode->i_blocks =3D stat->st_blocks;
 =09} else {
 =09=09if (stat->st_result_mask & P9_STATS_ATIME) {
@@ -647,6 +680,7 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct =
inode *inode,
 =09=09=09inode_set_mtime(inode, stat->st_mtime_sec,
 =09=09=09=09=09stat->st_mtime_nsec);
 =09=09}
+=09=09clear_bit(V9FS_INO_MTIME_UNCERTAIN, &v9inode->cache_validity);
 =09=09if (stat->st_result_mask & P9_STATS_CTIME) {
 =09=09=09inode_set_ctime(inode, stat->st_ctime_sec,
 =09=09=09=09=09stat->st_ctime_nsec);
@@ -662,10 +696,21 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struc=
t inode *inode,
 =09=09=09mode |=3D inode->i_mode & ~S_IALLUGO;
 =09=09=09inode->i_mode =3D mode;
 =09=09}
-=09=09if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE) &&
-=09=09    stat->st_result_mask & P9_STATS_SIZE) {
-=09=09=09v9inode->netfs.remote_i_size =3D stat->st_size;
-=09=09=09v9fs_i_size_write(inode, stat->st_size);
+=09=09if (stat->st_result_mask & P9_STATS_SIZE) {
+=09=09=09bool set_size;
+=09=09=09if (flags & V9FS_STAT2INODE_NEW_INODE) {
+=09=09=09=09set_size =3D true;
+=09=09=09} else if (stat->st_size =3D=3D v9inode->netfs.remote_i_size) {
+=09=09=09=09set_size =3D false;
+=09=09=09} else {
+=09=09=09=09/* Uh oh - the server copy appears to have changed. */
+=09=09=09=09filemap_invalidate_inode(inode, false, 0, LLONG_MAX);
+=09=09=09=09set_size =3D true;
+=09=09=09}
+=09=09=09if (set_size) {
+=09=09=09=09v9inode->netfs.remote_i_size =3D stat->st_size;
+=09=09=09=09v9fs_i_size_write(inode, stat->st_size);
+=09=09=09}
 =09=09}
 =09=09if (stat->st_result_mask & P9_STATS_BLOCKS)
 =09=09=09inode->i_blocks =3D stat->st_blocks;
@@ -676,7 +721,7 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct =
inode *inode,
 =09/* Currently we don't support P9_STATS_BTIME and P9_STATS_DATA_VERSION
 =09 * because the inode structure does not have fields for them.
 =09 */
-=09v9inode->cache_validity &=3D ~V9FS_INO_INVALID_ATTR;
+=09clear_bit(V9FS_INO_INVALID_ATTR, &v9inode->cache_validity);
 }
=20
 static int

