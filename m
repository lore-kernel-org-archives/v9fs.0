Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3C2D0C63
	for <v9fs@lists.linux.dev>; Wed, 18 Feb 2026 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421904; cv=none; b=nl/R7ynJjB1Vi7zjhYPGOlNysSuAQGpVpMwRhWEcqMFIBlo5lKVW7i3JLQ0/q1ieIIacctxikVwuNHEidtWhGQuzFCw0DClHUbKySVVyK6fWuuXCokD0I02LC/Yrul2oTAjstvNs5P+QuDUOSdGQAhyhvHrl/rPKgyDH1aFye5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421904; c=relaxed/simple;
	bh=KZzt2wmniiMeHBSAKYUUTIcW2lb0MUI+X7abJKPGIxE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=bVRSADWwZ2KkO3s0IYkJPCVfa5IaCFBr2fgBiOSaQ9aabuPL6snPR1QEzXc/gNEk0oia+kMFX2g3bOif69Pq8qj8x2HkzNP6ocwQ7Aq4sa/LZt4oh0kf2SH6fs1QCd6SmQeDmtNObi0aiX0Czt2MVQeE8QUDV3ngnbXkir4Wjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Be8jUPTk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Be8jUPTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771421901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpR7Rsa1o6eDLAN5ndsVX1V7ImMVIEq9yJ2oPvVopHA=;
	b=Be8jUPTknKchmgI0dAXxBZnJVKiXhTutIvkGvksEkdPaBpd0mbicK+iWhnJGKJ2NMhTmFw
	1itbu5C2J0UfwE83j0HnQTFEPyuL7Z7cxbYy0e1+gJoPYEUXLGhPT6D470dM4GPzubxL5U
	qzlSMYumSeItgJovZOto6f2jmZhbVro=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-2iaFNR1gPyqfmKxKAAgkpw-1; Wed,
 18 Feb 2026 08:38:19 -0500
X-MC-Unique: 2iaFNR1gPyqfmKxKAAgkpw-1
X-Mimecast-MFC-AGG-ID: 2iaFNR1gPyqfmKxKAAgkpw_1771421898
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4486F1890329;
	Wed, 18 Feb 2026 13:38:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.225.173])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5ACA30002EC;
	Wed, 18 Feb 2026 13:38:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251227180137.730385-1-pierre@barre.sh>
References: <20251227180137.730385-1-pierre@barre.sh>
To: Pierre Barre <pierre@barre.sh>
Cc: dhowells@redhat.com, ericvh@kernel.org, lucho@ionkov.net,
    asmadeus@codewreck.org, linux_oss@crudebyte.com,
    v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 9p: fix i_size update race in getattr with writeback caching
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 18 Feb 2026 13:38:03 +0000
Message-ID: <1642497.1771421883@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: geunkmHtNrM12feHOi9ADPJt09LDEwD8RimYSr1MQ7c_1771421898
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1642496.1771421883.1@warthog.procyon.org.uk>

Pierre Barre <pierre@barre.sh> wrote:

> With writeback caching (cache=mmap), v9fs_stat2inode() and
> v9fs_stat2inode_dotl() unconditionally overwrite i_size from the server
> response, even when dirty pages may exist locally. This causes processes
> using lseek(SEEK_END) to see incorrect file sizes, leading to data
> corruption when extending files while concurrent stat() calls occur.
> 
> Fix by passing V9FS_STAT2INODE_KEEP_ISIZE when CACHE_WRITEBACK is
> enabled to preserve the client's authoritative i_size.

I think this might be the wrong approach.

A better way is probably, in v9fs_stat2inode() and v9fs_stat2inode_dotl(), if
the inode isn't new, compare the values for stat->mtime to inode->i_mtime and
stat->length to v9inode->netfs.remote_i_size and if they differ mark the inode
as being remotely modified, invalidate the pagecache and reset inode->i_size.

If stat->mtime == inode->i_mtime and stat->length ==
v9inode->netfs.remote_i_size, then don't alter inode->i_size.

David

