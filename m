Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393371AB507
	for <v9fs@lists.linux.dev>; Fri, 13 Dec 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079315; cv=none; b=MHoJ1qp3FULIso4znWIoiHqZa+WgLV/J+G+8DU0f0lNcJ9Jw+C3aa0M28MNwqdthHJV1PI45pRDhXV+Iy7PUaFtH5sYNVG7d+ldGb85PyAqGHSmXgp+HBopVDY1zvTYZtTULHXPzVwFOrpEXQ3yGmuLR66gclVvaJNXlunN3ZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079315; c=relaxed/simple;
	bh=Tm18i7HxgZAygLJbz8XvTOxq50709kpfLOwEEi++/iw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=l6qKEex//9u7Tribp0bHSAWp3TEyhZWXpLlTWe/BLhZQUkowulgcdercLCoCGnIxedq0VTFZI4ahBV73jHYXnYtB60gEJ8QhBkHsNjQkeprRRdS9K9kurmOsqNfr7U4K1XJQ12Uib4wv6vJnc3NRrGhbQYV+FbMvvtRvftabZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcFkDr34; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcFkDr34"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734079313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LH059ZlZ7u2Dl3ILlcbpmd2S5dMJXw8i4IebMr3J1Q8=;
	b=hcFkDr34snY+rgplYzFC/hs1bwkG5BTX71TC777Am2a7L52+OyHolQbzcYubRvBAiAY5Fo
	m5R4LICUgXWoo0GF7E2ZBlSkfAjOLDyLcYCD4Q95Xf2t1NdTsQlj5LcqFgmedCznazEsGT
	z+MhfB5jwu2Rj9E4bg7Jf+RXquy3Yus=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-FQ7YRkbrM-u50h34dheMEQ-1; Fri,
 13 Dec 2024 03:41:49 -0500
X-MC-Unique: FQ7YRkbrM-u50h34dheMEQ-1
X-Mimecast-MFC-AGG-ID: FQ7YRkbrM-u50h34dheMEQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53048195604F;
	Fri, 13 Dec 2024 08:41:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9D04195605A;
	Fri, 13 Dec 2024 08:41:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241213072651.1475826-1-lizhi.xu@windriver.com>
References: <20241213072651.1475826-1-lizhi.xu@windriver.com> <2133166.1733759584@warthog.procyon.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: dhowells@redhat.com, asmadeus@codewreck.org, brauner@kernel.org,
    ericvh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux_oss@crudebyte.com, lucho@ionkov.net,
    syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com,
    syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [PATCH] netfs: If didn't read new data then abandon retry
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2890360.1734079302.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Dec 2024 08:41:42 +0000
Message-ID: <2890361.1734079302@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Lizhi Xu <lizhi.xu@windriver.com> wrote:

> >      (1) Replace NETFS_SREQ_NO_PROGRESS with NETFS_SREQ_MADE_PROGRESS =
and make
> >          the filesystem set it if it managed to read or write at least=
 one byte
> >          of data.  Clear this bit before issuing a subrequest.
> Will there be conflicts when reading and writing use the same flag to ma=
rk?

No, because, at the moment, a read done by a write (e.g. RMW with crypto) =
or a
write done by a read (e.g. writing just-read data to the cache) are handle=
d
with an additional request structure since the set regions involved may di=
ffer
(RMW only needs read the unmodified ends for example).

David

