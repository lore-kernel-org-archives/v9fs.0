Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48A236453
	for <v9fs@lists.linux.dev>; Sat, 20 Dec 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766243847; cv=none; b=dpnNAKG8ewiOrm9OE6F25+9UkYujFnKyBiXgLf0HeVHrwvuvAa3GjIoSuzFEghD8sbRFB0b5ufb6IUGNtwu+SAOvc0/RIWMEAgdYb3iVSdvic/kXCUexVQOu6aRZHYIgIvAEIsUS6gmpILisABqAZ9n/7ZEq/XF+gpVTaehPhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766243847; c=relaxed/simple;
	bh=e8z/1Np1RndNWC0tNeC0T0y+iRLoaBewoFzMNOL1kEE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Ix2cxpXyZCPoSkM8a7wOyk7nB5d7mQe3bUakdvIahmLAtrT9YLwW/zDkcSLj/mTZn00T1nHTcNHtmgQLNt2IpBX2v6mJF1+krtamXftUKWedz/ZF7qfKCmiXlX8Dv4EDFjSBrcKg4IgRuLDcPYDp5cgaxVlwpDdwSZIEkTr2/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NcL08TKg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcL08TKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766243844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8z/1Np1RndNWC0tNeC0T0y+iRLoaBewoFzMNOL1kEE=;
	b=NcL08TKgGDvRcY3OLiAx/WbJU3N2KYgrh6YbuZzn1sia7iLlKlOSWPIHx88GOIPpNjpTC8
	UYar63REG6C49kcP2PPCdJdc+Sme4cMNnFPYtnjqqBKC+a9YEAZAG229+WcNnESKLYZrtp
	nzE7GXsVYsuRnB347D0YOEwwjkOL3Po=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-gj9iZeUoMP-3A5o7NcpMhw-1; Sat,
 20 Dec 2025 10:17:19 -0500
X-MC-Unique: gj9iZeUoMP-3A5o7NcpMhw-1
X-Mimecast-MFC-AGG-ID: gj9iZeUoMP-3A5o7NcpMhw_1766243837
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0543D19560B2;
	Sat, 20 Dec 2025 15:17:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E38830001A2;
	Sat, 20 Dec 2025 15:17:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8618918.T7Z3S40VBb@weasel>
References: <8618918.T7Z3S40VBb@weasel> <938162.1766233900@warthog.procyon.org.uk>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Chris Arges <carges@cloudflare.com>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <sfrench@samba.org>, v9fs@lists.linux.dev,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix early read unlock of page with EOF in middle
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <941466.1766243830.1@warthog.procyon.org.uk>
Date: Sat, 20 Dec 2025 15:17:10 +0000
Message-ID: <941467.1766243830@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> What about write_collect.c side, is it safe as is?

That's a good question - but it should be safe since it doesn't modify the
content of the page and doesn't typically write beyond the EOF (though it
might write a block that spans the EOF marker to the cache).

David

