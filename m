Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD20331A57
	for <v9fs@lists.linux.dev>; Fri, 19 Dec 2025 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145983; cv=none; b=Q2iSCog/Ohg5lETvJ7RFavnTMExeCYC2I1noVAgp1+EPOCE9Hubc+9VZc86CywvnhsNx40jSBUkIjjc65y+2DLrYcgCWfk7CVzKwtzN/rwEzzA0617eOwglw0J4hloGMLAcWPx1OHN5Hhir+uq6oZXZJK6yPMkA8YLJEnhOuUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145983; c=relaxed/simple;
	bh=ICSw1Gb+bvlIImpGJ6ZaLP+dJBt9YGwUwZB2tO44IAk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=V6PO1LewIYNMt2oMxD3+/BwHfp0xjscOBetrfUzk18kJ5+HAtH57ylnAI7fd1DK3VUIQLi6e/X6LbWHEYch1Ms1fJRMGF8bOYDUdbEDL1HTocyN41FkdYb3abPvF31+qXriyLCcDsN06aRlebXBRm09JB8VORAMhXh/O3Cihza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdrZmPJ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdrZmPJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766145979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar0CUvCqBxXAgp51z8oF+97RLBA8Nure7aZEO7TfKZ8=;
	b=SdrZmPJ30KFD4PFVcNfsnxsVOLv8J3/fx9ETzOprtkICLggxvSl0WKhH+hKfA3pFCc495l
	AruSKZXk1DRM+VpMqQCJEILArVjb9VQXziv9Qz+XWNzExyih0Q1DxZ4RVCl70ya61ywWkL
	xYM6QTO3sFN1OIMPrF2lK2P55nKodrE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-YpIytl2-OUupyr-e949haA-1; Fri,
 19 Dec 2025 07:06:15 -0500
X-MC-Unique: YpIytl2-OUupyr-e949haA-1
X-Mimecast-MFC-AGG-ID: YpIytl2-OUupyr-e949haA_1766145973
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CACAD1956046;
	Fri, 19 Dec 2025 12:06:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 325EA194C65A;
	Fri, 19 Dec 2025 12:06:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2332946.iZASKD2KPV@weasel>
References: <2332946.iZASKD2KPV@weasel> <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: dhowells@redhat.com, Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>, asmadeus@codewreck.org,
    Chris Arges <carges@cloudflare.com>, v9fs@lists.linux.dev,
    linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter() iovec
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <815150.1766145968.1@warthog.procyon.org.uk>
Date: Fri, 19 Dec 2025 12:06:08 +0000
Message-ID: <815151.1766145968@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> > -	if (!iov_iter_is_kvec(data)) {
> > +	if (user_backed_iter(data)) {

That looks wrong.  If the I/O is coming through netfslib, you should never see
ITER_UBUF or ITER_IOVEC in the filesystem.

David

