Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564220;
	b=G+HhorGjapvKlV8Hl0aSF76lOy/Eo8FR6nxad3t9218Kk7nuIA03W8jxkWhNusar2gBl
	 TbkvVsfEAciKr2Pl1MaHpUJhmD50cPOvkV2FmivWgetchum0t9W55liyLE2+rwp26ADuK
	 PRIAuNetYaBC1oFxiGWz8o19mjWx5i5U0/mnKzez+j+PL8Mz4DNVlW/wy3Rtrua/QQWzX
	 qDMcVHTTVRTILd9vJZxyb08j05FByuWsXV9Y0UKyLqFy1VeHd+yv+Yim/AfeXz3tgMNy8
	 zheHkysJD9pGEsd5BDl70ED8LWsL49RgkbXVEQtKClEEm6hOCx2nxokN7R11lQATpzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type;
	bh=L/PL4XjMYN8lulvNzXcbg/92o2tqbniVOi/bhb++huo=;
	b=PNZiZjcO72V+cDDHPvUr8wYBxBeNczWeZO7ZOIE4Ely7NoytQhBk4NlQw5qIjTNTybLR
	 t1nkZqqUrG7RvfbClyvB+Osbv4gX9lu1DprbZ/1TvX1ACincRHp5/5gvfbns1jJIdMDlC
	 holGdPtV4RNMv82sLVO02oiqY0HmMgwpIBH7bsH7jbNShaiLjQhRP9x2AnzPXBw0w6C4c
	 T8AJ0iCCyn+sMJQ4hAOgcb4RfA+fcxKXES7t1uTDXBwgKAEmzZgNnOXWjKMJC7kLkjSZ+
	 57DfeaahQkFgZp9H9aSVs2UQGkCRpn7bggShsaSVWKx7LxILV6+4YOjLEgdKwUK4QjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innovatrics.com;
	spf=pass smtp.mailfrom=innovatrics.com;
	dkim=pass header.d=innovatrics.com header.i=@innovatrics.com header.a=rsa-sha256 header.s=google header.b=cDvYNToY;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C765606A320
	for <v9fs@lists.linux.dev>; Wed, 21 Oct 2026 06:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C765606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=innovatrics.com header.i=@innovatrics.com header.a=rsa-sha256 header.s=google header.b=cDvYNToY
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso3037515e9.0
        for <v9fs@lists.linux.dev>; Tue, 20 Oct 2026 23:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innovatrics.com; s=google; t=1792564218; x=1793169018; darn=lists.linux.dev;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/PL4XjMYN8lulvNzXcbg/92o2tqbniVOi/bhb++huo=;
        b=cDvYNToYXQIOHZAwxtgd9jdy3o5/iExIHHEd1Y6XzD0GyrK3PVoWPqE4rmIfKfsW5F
         zLhMerEYvDhonM8grGFLBoyKACngLUn8yYy5+BaZNsZMZKwDBOLpSqEMHRbAf+EcqIbZ
         fgPAtllv2iwwB1vRPgB2WJ8YH/KPMR+R2LLmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564218; x=1793169018;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L/PL4XjMYN8lulvNzXcbg/92o2tqbniVOi/bhb++huo=;
        b=ZS/7IaBX1U7Ega5CJal3FEwGQzD1k9SaK2rPomNoUoh3ApDaAJEzwbdt9h5eeHE8ZI
         9e00QZdNyPkunTvrnHwVm0ApvAMFoy3+3tBbpATM0im9ZXHKz0jhHDgj98PrM2IOCehL
         2AR7DW772k8P1EylCM5rhz5w2mnvzjgXlBeR8pkxpEvxd3qyZKKxp+ASvYtQ5b+ADt17
         jOFmkYqn6DxayHhNY8NHzk/EHDrRFde2eoe1/OMINwemrm/I6R2z2YU/ic4owWf9XboX
         j3QmE5ZxsFtOtlY4Lq5MX6lCvbQ0O8AI0+rK6CpHDRP7HmfSwek8meH0+4uDdZYyqCFB
         VM/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwslbhZ5EYjgpq/jUuLPCOoolo2W7dF96kX7mtTmZADdiwdEEFlrV9VPLhPTtitqzlLZzAH@lists.linux.dev
X-Gm-Message-State: AFq9FYKa2rMUcn0NYF6NicYeTiGpjf2+exsbm4ARBnplK7fNxWaDfmWu
	DHRrwECZI4zgt2UOPX9kJJ5r0dUZULnfQVSur571kutvfexvX0RatgsVuSliqRvTTQ==
X-Gm-Gg: AYBFou3/MNUbIaY8w+jH+MDLAO/epaH69FQ7DsJA0Kg7i07LUuyTLleh4ckzBjz3RZ4
	pCXmS4P/wE9xRhGM0iJWs/i1u3brAcuoJ2p73piAKKU1l+ijQOtu+CNTMG4SfFLwE1zSa3EWjt9
	k2sYHIuZqvqwuuaqgVabD8vTRviS1dyrKXbqHIn52PrKMn+jHcWs76tILdt4E4fcfK0Wia8rqZD
	pQlWtVRNBuIiNORIGPENSZec2VXYWZ5JLUcsRaoX3z9CWPFU5OfJvWWeaTGeJPtLfGhEce7Tlq7
	9XIdD2lpgzgo14lf87mHuxIta/qlHT+QWHYfc7NVvZSjOcpSH2NrkxmQcDZUCbMLcryQHXjf0Wc
	Q3EEeeRIx8mNacWBkZ3l2ZWvpWrSOak7a/w3QitKneh99pWtoIWDCHPzPjNrmBT7+XTh+JS3rUq
	PFfcWCSwQ7icew+HH9gdQmAr6/QfU77Jre+TDRG+uCIr3YpBRjhTK3eR/G1AhX3hoB5ue3OJgTa
	Y3/ncX+6zSgaPxq2waaCp1hzC7gDF3jaYCF6L0a12WAJ2NUT9GGIlTvpRqdgjxNchxMaLYop+og
	CdLFb+ylYGVOx/hA/vmQB4mGT5/GDnH4Edx9eCfGPt0nYGLhAeSqegvZb9c3dLjyXluMd7cH92f
	TvQTa7m+5ifhp
X-Received: by 2002:a05:600c:34ca:b0:4a0:eae0:769a with SMTP id 5b1f17b1804b1-4a1fdd39e68mr18248775e9.28.1792564218396;
        Tue, 20 Oct 2026 23:30:18 -0700 (PDT)
Received: from [10.11.72.5] (bip-static-148.213-81-147.telecom.sk. [213.81.147.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d85a9bsm143305775e9.15.2026.10.20.23.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:30:17 -0700 (PDT)
From: Petr Chmelar <petr.chmelar@innovatrics.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    netfs@lists.linux.dev,
    linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 0/5] netfs, cachefiles: Changes for next, primarily
 occupancy tracking-related
Message-ID:
 <20261021.cachefiles-seekhole-granularity.pchmelar@innovatrics.com>
In-Reply-To: <1655915.1791879248@warthog.procyon.org.uk>
References: <20260910220242.2165023-1-dhowells@redhat.com>
 <20261011.cachefiles-seek-hole-walk.pchmelar@innovatrics.com>
 <1655915.1791879248@warthog.procyon.org.uk>
Date: Wed, 21 Oct 2026 06:30:15 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6589919273872440461=="

--===============6589919273872440461==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

David Howells <dhowells@redhat.com> wrote:

> I have patches that store a bitmap in an xattr, with 1 bit per 256K block of
> cachefile, for a 512 byte xattr able to map up to 1G of file size.  I need to
> revisit this at some point soon.  It may be better to switch to storing an
> extent list, but:
[...]
> Trying to store a million+ extent records in a single xattr would kind of
> suck.  Now, it might be possible to collapse that somewhat if a lot of the
> extents are virtually sequential within the file, since I don't care about
> physical sequentiality.
>
> Also, can you tell if you have a preferred cache granularity?  Would a 256K
> granularity, say, use too much space?

Sorry for the slow answer.  256K would be fine for us: our cache gets
filled by random training reads of 64 to 256 KB.  The problem is the
size of our files.  Many cached objects are hundreds of GB, the largest
we've seen is 946 GB, so at 256K one object needs up to about 450 KB of
bitmap - far more than a 512 byte xattr.

An extent list would suit the case that hurts us.  An object only gets
slow once it's fully or nearly fully cached, and then it's one virtually
contiguous range, however many physical extents it has: for example
569 GB in 2,528,439 extents.  While such an object is filling, though,
it's scattered pieces at random offsets, so the list would stay long
for weeks before it collapses.

> > I can send the workaround if it's useful as a reference,
>
> If you could, that would be great!

Attached, as a reference only.  It's a naive implementation I wrote
with the help of an LLM, just to confirm where the time goes - I don't
know the netfs and cachefiles internals well enough to propose it as a
fix, and nobody has reviewed it.  It keeps the last SEEK_DATA/SEEK_HOLE
answer in the cachefiles object, so it's lost when the cookie is
withdrawn - 10 s after the file is closed, or on reboot - and each new
open pays one full walk again.  It also still asks the backing
filesystem where the data is, the opposite of where you're taking
cachefiles.  It's written against vfs-7.4.netfs at 9f8b64f66, on top of
your v12 series (cachefiles_query_occupancy()), and was only tested in
a VM.  We also have a port to the Ubuntu 6.8 kernel our nodes run,
under test but not deployed.

On our nodes we'll detect fragmented, fully cached objects and
defragment them, and in the long run we'll move away from such large
files, which aren't ideal for us in other ways either.  I'm still happy
to test whatever you do for this case.

Thanks,
Petr

--===============6589919273872440461==
Content-Type: text/x-patch; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-cachefiles-Remember-known-data-to-avoid-repeated-SEE.patch"
MIME-Version: 1.0

>From ec2bbf3bfaaa09af48a416eb12d389b245a28bed Mon Sep 17 00:00:00 2001
From: Petr Chmelar <petr.chmelar@innovatrics.com>
Date: Sat, 10 Oct 2026 23:14:20 +0000
Subject: [PATCH] cachefiles: Remember known data to avoid repeated SEEK_HOLE
 walks

cachefiles_query_occupancy() locates the cached data of a
CACHEFILES_CONTENT_BACKFS_MAP object with SEEK_DATA followed by SEEK_HOLE.
SEEK_HOLE has no upper bound: on XFS, iomap_seek_hole() calls
xfs_seek_iomap_begin() once per extent until it reaches a hole, and in a
fully populated object the first hole is EOF.  netfslib queries the
occupancy for each read request, so a sequential read of such an object
walks the rest of its extent list once per readahead batch.

An object gets into that state when a netfs file is read at random
offsets.  Each read is copied to the cache at its own offset, the object
is marked BACKFS_MAP on the first discontiguous write and stays so once
it has filled in, and when other files are being cached at the same time
each piece gets its own extent.  Large data sets that are read randomly,
such as training data on NFS, end up as objects with hundreds of
thousands of extents.

In a VM with an NFSv4.2 loopback mount using fsc, a 1 GiB object filled
by random 64 KiB reads ends up with about 16,300 extents.  A sequential
read of it after dropping the page cache makes 4,098 SEEK_HOLE calls
that take 176 s in total, and runs at 4.3 MiB/s.

Remember the most recent region that SEEK_DATA/SEEK_HOLE found to be
contiguous data and answer queries that start inside it without seeking.
Overlapping and abutting regions merge, so a sequential read pays for one
walk instead of one per request.  The read above then makes one SEEK_HOLE
call taking 61 ms, and runs at 17 MiB/s.

Cachefiles only ever adds data to a backing file except where it removes
data itself, so forget the region after each of those: the punch on low
space in __cachefiles_prepare_write(), the padding clear and the
truncation in cachefiles_collect_write(), cachefiles_shorten_object()
and invalidation.  A sequence number sampled before the seeks stops a
query that raced with a removal from recording what it saw before it,
and the cookie's invalidation counter ties the region to the backing
file that the operation was started on.

Assisted-by: LLM
---
 fs/cachefiles/interface.c |  3 ++
 fs/cachefiles/internal.h  | 10 ++++++
 fs/cachefiles/io.c        | 69 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 789ff6abe9..a5eb874ce1 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -172,6 +172,7 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
 	ret = cachefiles_inject_remove_error();
 	if (ret == 0)
 		ret = vfs_truncate(&file->f_path, dio_size);
+	cachefiles_forget_known_data(object);
 	if (ret < 0) {
 		trace_cachefiles_io_error(object, file_inode(file), ret,
 					  cachefiles_trace_trunc_error);
@@ -187,6 +188,7 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
 		if (ret == 0)
 			ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
 					    new_size, dio_size - new_size);
+		cachefiles_forget_known_data(object);
 		if (ret < 0) {
 			trace_cachefiles_io_error(object, file_inode(file), ret,
 						  cachefiles_trace_fallocate_error);
@@ -354,6 +356,7 @@ static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie)
 	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
 
 	spin_unlock(&object->lock);
+	cachefiles_forget_known_data(object);
 	_debug("subbed");
 
 	/* Allow I/O to take place again */
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 664be64ab5..5e9394cadd 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -60,6 +60,15 @@ struct cachefiles_object {
 	spinlock_t			lock;
 	refcount_t			ref;
 	enum cachefiles_content		content_info;	/* Info about content presence */
+	/* Region of the backing file that SEEK_DATA/SEEK_HOLE last found to
+	 * hold contiguous data, so that occupancy queries inside it don't have
+	 * to walk the extent list of a fragmented file again.  Protected by
+	 * ->lock.
+	 */
+	uoff_t				known_data_from;
+	uoff_t				known_data_to;
+	unsigned int			known_data_inval; /* cookie->inval_counter it applies to */
+	unsigned int			known_data_seq;	/* Bumped when data is discarded */
 };
 
 /*
@@ -204,6 +213,7 @@ extern void cachefiles_put_object(struct cachefiles_object *object,
  */
 extern bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 				       enum fscache_want_state want_state);
+extern void cachefiles_forget_known_data(struct cachefiles_object *object);
 extern int __cachefiles_prepare_write(struct cachefiles_object *object,
 				      struct file *file,
 				      uoff_t *_start, size_t *_len, size_t upper_len,
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index d050598222..a0a2835967 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -194,6 +194,46 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	return ret;
 }
 
+/*
+ * Discard the record of where the backing file holds data.  This must be
+ * called after anything that removes data from the backing file, so that an
+ * occupancy query that raced with the removal can't record what it saw before.
+ */
+void cachefiles_forget_known_data(struct cachefiles_object *object)
+{
+	spin_lock(&object->lock);
+	object->known_data_seq++;
+	object->known_data_from = 0;
+	object->known_data_to = 0;
+	spin_unlock(&object->lock);
+}
+
+/*
+ * Record a region that SEEK_DATA/SEEK_HOLE found to hold contiguous data,
+ * unless data has been discarded since the query sampled @seq.
+ */
+static void cachefiles_note_known_data(struct cachefiles_object *object,
+				       struct netfs_cache_resources *cres,
+				       unsigned int seq, uoff_t from, uoff_t to)
+{
+	spin_lock(&object->lock);
+	if (object->known_data_seq != seq)
+		goto out;
+	if (object->known_data_inval == cres->inval_counter &&
+	    from <= object->known_data_to &&
+	    to >= object->known_data_from) {
+		/* Overlapping or abutting regions of data merge. */
+		object->known_data_from = umin(from, object->known_data_from);
+		object->known_data_to = umax(to, object->known_data_to);
+	} else {
+		object->known_data_from = from;
+		object->known_data_to = to;
+		object->known_data_inval = cres->inval_counter;
+	}
+out:
+	spin_unlock(&object->lock);
+}
+
 /*
  * Query the occupancy of the cache in a region, returning the extent of the
  * next two chunks of cached data and the next hole.
@@ -205,6 +245,7 @@ static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
 	struct inode *inode;
 	struct file *file;
 	uoff_t read_limit;
+	unsigned int seq;
 	loff_t ret;
 	int i;
 
@@ -238,7 +279,28 @@ static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
 		break;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(occ->cached_from); i++) {
+	/* SEEK_HOLE may have to walk every extent up to the next hole, which
+	 * in a fully populated but fragmented backing file can be hundreds of
+	 * thousands of them, so first check whether an earlier query already
+	 * found data here.
+	 */
+	i = 0;
+	spin_lock(&object->lock);
+	seq = object->known_data_seq;
+	if (object->known_data_inval == cres->inval_counter &&
+	    occ->query_from >= object->known_data_from &&
+	    occ->query_from < object->known_data_to) {
+		occ->cached_type[0] = FSCACHE_EXTENT_DATA;
+		occ->cached_from[0] = occ->query_from;
+		occ->cached_to[0] = object->known_data_to;
+		occ->query_from = object->known_data_to;
+		i = 1;
+	}
+	spin_unlock(&object->lock);
+	if (i > 0 && occ->query_from >= occ->query_to)
+		goto done;
+
+	for (; i < ARRAY_SIZE(occ->cached_from); i++) {
 		ret = cachefiles_inject_read_error();
 		if (ret == 0)
 			ret = vfs_llseek(file, occ->query_from, SEEK_DATA);
@@ -263,6 +325,8 @@ static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
 		}
 		occ->cached_to[i] = ret;
 		occ->query_from = ret;
+		cachefiles_note_known_data(object, cres, seq,
+					   occ->cached_from[i], ret);
 		if (occ->query_from >= occ->query_to)
 			break;
 	}
@@ -473,6 +537,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	if (ret == 0)
 		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 				    start, *_len);
+	cachefiles_forget_known_data(object);
 	if (ret < 0) {
 		trace_cachefiles_io_error(object, file_inode(file), ret,
 					  cachefiles_trace_fallocate_error);
@@ -689,6 +754,7 @@ static void cachefiles_collect_write(struct netfs_io_request *wreq,
 			ret = cachefiles_inject_remove_error();
 			if (ret == 0)
 				ret = vfs_truncate(&file->f_path, 0);
+			cachefiles_forget_known_data(object);
 			if (ret < 0) {
 				trace_cachefiles_io_error(object, inode, ret,
 							  cachefiles_trace_trunc_error);
@@ -775,6 +841,7 @@ static void cachefiles_collect_write(struct netfs_io_request *wreq,
 		if (ret == 0)
 			ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
 					    data_to, old_size - data_to);
+		cachefiles_forget_known_data(object);
 		if (ret < 0) {
 			trace_cachefiles_io_error(object, inode, ret,
 						  cachefiles_trace_fallocate_error);
-- 
2.52.0


--===============6589919273872440461==--
