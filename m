Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF4150995
	for <v9fs@lists.linux.dev>; Wed, 27 Mar 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571880; cv=none; b=M6CmU8DHk038scCWfF9dLClGIVLqlgvuf5pjUyinVT5qAWf564Jsj3mp3iUUUOE8ICeokq/weYqkECoEpNMuK9IUcTvIEnahqbzJjrNX01ilT3A2E1/Gwx2/RHkfLui+20jzPj6K/9t6w0/BFtg+zWyGwr7WXjLos/ulVC0iDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571880; c=relaxed/simple;
	bh=+q1X6OO5OjLhXHnuIwVLwdI8semz6sAtm2DvDrQfzL0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=m4c6tBHlI8N1HSh/Rc/f6n2HhZhi+MJNtTaosynjrlI7gcWnkWoVecBMwmowuyaEEoyIlzAKXfNcoTDbQbGuu6SIZQYoZ30itgT1w+5Aldfr7wfUNvShJajM/3pZ53W/Wo86EbPh2KOc1d1ItQ4yq9FbM5gyL4jKrfgghMFGf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+U6GzdP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+U6GzdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711571877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qoPQD+VTVHHhRyd75iNpboVK+lvHVLazCUjHaMH4s4=;
	b=f+U6GzdPQ6k3TZnosPenf577kXxgtVBqVQpguxMe5LRqmFT0KXpPdFH8wy+n8w/FXktqOH
	YARFbF+Wb3g//yjADz5Qvcf1sa1lJ/LZAaMw1KbOy494hRT+9p9+lxZ2gk0Q87kNYS3+aY
	a12pgQrKU9WPKDeXo1M8L4UkO6XKp4g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-9x-QYYaoNBy5Yt-5m2eKqg-1; Wed, 27 Mar 2024 16:37:55 -0400
X-MC-Unique: 9x-QYYaoNBy5Yt-5m2eKqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DAB0101A552;
	Wed, 27 Mar 2024 20:37:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6CBC53360;
	Wed, 27 Mar 2024 20:37:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZgRpPd1Ado-0_iYx@casper.infradead.org>
References: <ZgRpPd1Ado-0_iYx@casper.infradead.org> <2318298.1711551844@warthog.procyon.org.uk> <2506007.1711562145@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm, netfs: Provide a means of invalidation without using launder_folio
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2541307.1711571866.1@warthog.procyon.org.uk>
Date: Wed, 27 Mar 2024 20:37:46 +0000
Message-ID: <2541308.1711571866@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Matthew Wilcox <willy@infradead.org> wrote:

> > +	/* Prevent new folios from being added to the inode. */
> > +	filemap_invalidate_lock(mapping);
> 
> I'm kind of surprised that the callers wouldn't want to hold that lock
> over a call to this function.  I guess you're working on the callers,
> so you'd know better than I would, but I would have used lockdep to
> assert that invalidate_lock was held.

I'm not sure.  None of the places that look like they'd be calling this
currently take that lock (though possibly they should).

Also, should I provide it with explicit range, I wonder?

> > +	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> > +		unmap_mapping_pages(mapping, 0, ULONG_MAX, false);
> 
> Is this optimisation worth it?

Perhaps not.

David

