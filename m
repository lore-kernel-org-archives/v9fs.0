Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF35576C
	for <v9fs@lists.linux.dev>; Mon, 29 Jan 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520018; cv=none; b=G2SzGaC8aRgKiz9U8KQNPmwzgRu6nAS2WVT0m3nX8OMPL6EVYJyldSLH2Chcl49fZaLgI6vsOEz8PEsVP3h2SNLfJbgry5ikTbnfK3blP1lHXOqj4n6CgWfOFMGbexn07gcwkmZkxln5v/t9TRYHH+k+yMmTcGMLu/NBYdhfzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520018; c=relaxed/simple;
	bh=LbT0h7I/khtawXpM4JWajyKGu9MxvthOZ4Avo9E26OY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=LUAlgfSrve0f1w10e8LyC46hoZu1/zkoWycLKjgjs1iLDhE0k8gu0I465DIALCHMjy4PR3tm8LXtNyVpuZg6Mr84F5KpdHWlf5LG9oOv/jiCG1lbm/xJGc2cmEQKRsHRC71ko4YqhDXooOggmIGALQbtca3B8U+Pbdur6VXBN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I45ST0PX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I45ST0PX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706520015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1qnJyU+OqBjXnjA274wGrx2fIgyJAmc6VYOr1sVyHY=;
	b=I45ST0PXd8iBTq7vKy5PGHk52NJoB/ASOP2eRvknM+cs5VCwIWkUjAWTwaVZiq9s1ClQzN
	L1JnPcK7aYEGq5TUH9yKHVwiAsQlhJJHpJAg7dMNdUvWW8wUn3L87OG4bMdQdnT2Sl62M5
	OLa4Xu/syLd73KhBvUkcd3HawnrWKuE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-759oXP6NPnuxhK4i0dlKlA-1; Mon, 29 Jan 2024 04:20:10 -0500
X-MC-Unique: 759oXP6NPnuxhK4i0dlKlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9BCE868907;
	Mon, 29 Jan 2024 09:20:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A7741C060B2;
	Mon, 29 Jan 2024 09:20:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZbZRRBP453U8PZ8a@codewreck.org>
References: <ZbZRRBP453U8PZ8a@codewreck.org> <ZbQUU6QKmIftKsmo@FV7GG9FTHL> <ZbRiD2a6F9cDm_9n@codewreck.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: dhowells@redhat.com, Eric Van Hensbergen <ericvh@kernel.org>,
    v9fs@lists.linux.dev, linux_oss@crudebyte.com
Subject: Re: fs/9p: regression in 6.8-rc1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 29 Jan 2024 09:20:08 +0000
Message-ID: <1217440.1706520008@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dominique Martinet <asmadeus@codewreck.org> wrote:

> I was going to say we probably need to filter it out - but it looks like
> that might be netfs' job given the call trace I get:
>=20
> # retsnoop -T -e vfs_write -a :fs/9p/*.c -a :fs/netfs/*.c
> FUNCTION CALL TRACE                 RESULT                  DURATION
> ---------------------------------   --------------------  ----------
> =E2=86=92 vfs_write                                                      =
  =20
>     =E2=86=92 netfs_unbuffered_write_iter                                =
  =20

Yeah - I should check to see if generic_write_checks() returned 0 and skip =
if
it did (as does netfs_file_write_iter()).

It might also be worth doing the check before even taking any locks.

David

