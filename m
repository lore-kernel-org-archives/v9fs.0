Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74691351C16
	for <v9fs@lists.linux.dev>; Wed,  4 Mar 2026 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635875; cv=none; b=k3cQtTY9NStv47Xxv/Y3G8/dNara9hrWCHmm04BbTMOAakrxVmd9mF9SRfm+hxH78xEU25CUlqFjtKlLyOegrgtoctioIbHKK3YKyF4NEw9OE2Ubuak+LU3Ma6vDkhUc6FpP4unEWGDmBYh46rxS47JhnCHkpsFfDvDMMftY6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635875; c=relaxed/simple;
	bh=J2x1ESJKoOsDzoDBgGV8XVrsTHEI8VtA69xT+0ng+L0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=tBoaAFpQzANznM4iFcohYQqBtGUnffmPRKAMb9QIyk/gMOITSmM0oQV5juAFOAIXOc6c5SRArxjAtDomElb3k9ARYcdx0OCxFD7LHJtJuIxRBlPGKMiZ2EG8mJLvQ1Bkap+eBA8z6JE8LaPTHQNgEouu/l/GNBUQQaJRwNlk+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kr8Oy71N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kr8Oy71N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772635873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DP3qHu1oBqi7U6R0z0RN6dG7wLOvnmImsJmlhF/fLnU=;
	b=Kr8Oy71NTVeHIstVixG8fTfY45P+9rpOzFZlMCEQvr16Eu2JZ9hoo4qiK1akHWPC4xJr2M
	X5XGXBXXvC47Ph73Nk2nQs59LqEAKpesdTmaM5DLxp8bySk8kVeG/onZjDx+X6KvRj4ORG
	+TszOCH/gy8xwhz7JpYQ6j04Tm1XyF4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-1_qf4EzWN0Cw_Svt9tcqww-1; Wed,
 04 Mar 2026 09:51:09 -0500
X-MC-Unique: 1_qf4EzWN0Cw_Svt9tcqww-1
X-Mimecast-MFC-AGG-ID: 1_qf4EzWN0Cw_Svt9tcqww_1772635867
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EA601956060;
	Wed,  4 Mar 2026 14:51:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.194])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3687195608E;
	Wed,  4 Mar 2026 14:51:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aahEJ7hY-tXRRjJk@infradead.org>
References: <aahEJ7hY-tXRRjJk@infradead.org> <20260304140328.112636-1-dhowells@redhat.com> <20260304140328.112636-18-dhowells@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
    Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH 17/17] netfs: Combine prepare and issue ops and grab the buffers on request
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 04 Mar 2026 14:51:01 +0000
Message-ID: <181470.1772635861@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: BmHxDayx29Nl75nW1XwSRn8ARt70_QJPhmiFF-SGtFg_1772635867
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <181469.1772635861.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Mar 04, 2026 at 02:03:24PM +0000, David Howells wrote:
> > +/*
> > + * Query the occupancy of the cache in a region, returning the extent =
of the
> > + * next chunk of cached data and the next hole.
> > + */
> > +static int cachefiles_query_occupancy(struct netfs_cache_resources *cr=
es,
> > +=09=09=09=09      struct fscache_occupancy *occ)
> > +{
>=20
> Independent of fiemap or not, how is this supposed to work?  File
> systems can create speculative preallocations any time they want,
> so simply querying for holes vs data will corrupt your cache trivially.

SEEK_DATA and SEEK_HOLE avoid preallocations, I presume?

David

