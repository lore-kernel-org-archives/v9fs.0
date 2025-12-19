Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580BF311C09
	for <v9fs@lists.linux.dev>; Fri, 19 Dec 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143596; cv=none; b=S2amIlSqjbTrE9zqW7qbOBsd2rgTGl+dye/br71DC8t3c4FNhS9H6hM8Yrt0OQNGqeAXtSemQzmJ544iKBj/5mB6lM0VoLQu3gFzg32SC8s2MmcUgJShAUmylJEAIwYcTbGUihMOr4mvcYwLGT+fHvzUKPmtPJOm7yc+3UjP7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143596; c=relaxed/simple;
	bh=OjKMLBMWvXBLsRQ+Ku+b35IsH0szsjD/FESaTra+1sE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=RDfqNgKyLd9qrA8qzpJ4j/pYLnv4t5Vu+VYJ8kGYWsvbrWJfljq0AJXxGSesvHHw14QN3CvmbUJ2C3pQl8e680JkqdEyXrWZmOjgc9EAxlWZJnMgsXW3J3YobWVNpA8hrs8PfwxFkJZYfiA5CLF0ljitnjm8nuGCGSvB48777cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aizrFeRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aizrFeRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766143593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNkySk2gooQskMWGcML4EcBFjuRdoagkUJErjio2lVE=;
	b=aizrFeRyxuWfam7a30g0wr8mWJ8upFyajF+zKUwNJT8FZJFZFRItVFUv8Ozn48XVY+Nnaj
	kzT23pMzGHZHE2R3Pn4bgv70cYe3mfeBLttrDVFf5lWP7C+oZF60gnmZ65bJpRy+3wBXSm
	+5hvVGrU1mx5MVIn998LokBYwTt1a9k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-VECoU5aiMvyqXc5WYRp_Hg-1; Fri,
 19 Dec 2025 06:26:29 -0500
X-MC-Unique: VECoU5aiMvyqXc5WYRp_Hg-1
X-Mimecast-MFC-AGG-ID: VECoU5aiMvyqXc5WYRp_Hg_1766143588
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D35CF1956053;
	Fri, 19 Dec 2025 11:26:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90E3819560B4;
	Fri, 19 Dec 2025 11:26:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aT1qEmxcOjuJEZH9@codewreck.org>
References: <aT1qEmxcOjuJEZH9@codewreck.org> <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org> <aTkNbptI5stvpBPn@infradead.org> <aTkjWsOyDzXq_bLv@codewreck.org> <aTkwKbnXvUZs4UU9@infradead.org>
To: asmadeus@codewreck.org
Cc: dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
    Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
    Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter() iovec
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <814007.1766143582.1@warthog.procyon.org.uk>
Date: Fri, 19 Dec 2025 11:26:22 +0000
Message-ID: <814008.1766143582@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

asmadeus@codewreck.org wrote:

> FWIW, the comment at the top of extract_iter_to_sg() says:
> > The iov_iter_extract_mode() function should be used to query how cleanup
> but I couldn't find any such function (even back when this comment was
> added to netfs code in 2023...), the two copies of this comment probably
> could use updating... David?

Ah, the function got renamed to iov_iter_extract_will_pin() instead.  I need
to fix the comment.

David

