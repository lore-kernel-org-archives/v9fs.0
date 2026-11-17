Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936482;
	b=0hL4moPoOUbgkewsS5cLMARPr/fvcGpylftvIFI1/kFo3506Iv1kb5x2c+4mSpVKHOb3
	 QPawfIn/sqwAS6qFILqbga2uZ+8HuKZgqxHfACo6dUFlqeKch3JorBkm+TX8lNoSItng5
	 3VdKxODL8qaeQgVvnFKll4t/OWYVsJMDkSTNI17u5GfuZXQKMPfyyHFkxcW3y5D5l8mWN
	 gTGb0SCsx0V9+mSGY1tl3e7p5niYCN/6JcA+2v0h9Zu2V+JmUyfulAnnHLHnA6YBHye3+
	 /QogDvAmcx3U5gT7wkOt6LZL/KpzY3wyjJZ2kh+jZ4Z0n1hdYFH2S/KJ5PXm3MQHfjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OeGPOFM20l6b8lvpRBTTLGZjwmAAnd78aEQ5cT6YCJc=;
	b=tAImA0PnR474G9uwzxMMXH668dMVeuKfLKLm25PvMcIJdnw/a3c6OBSafjU8tefC1qP9
	 L1Q26HLq8MnHCSD9i9Myep6xgyg0DMIU2o6os8ROd9WYlsfO/oq2sWZ3TGkVwgATvHU10
	 FPOJ/eyw/dXatR8YcxVS8ZKAzq4Ph9p8d1tAURUyAMwNh2wAlkGYrlOGg82zGdmR6qelN
	 p9T0SN6NCtjKXuFTz3Sh4Ac1wdvd7fqbzMJYoKEEmqOxA+Wq9DwbYTpBLT33eWiWxRIaz
	 +abq0bslZnXbbeXaxLswlGFAVRlTTfgrYyBs3pXM94Ifn5RAFusyZeO9V1MKUYwlTWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Beoa11AG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED2606A31C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Beoa11AG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245C81F000C4;
	Tue, 17 Nov 2026 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936482;
	bh=OeGPOFM20l6b8lvpRBTTLGZjwmAAnd78aEQ5cT6YCJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Beoa11AG1pU7VsTCGJyqjYYdkIKGHK/Oh/sSYN+Sqk5CDUdhwYBZtqNp13E8VGNwt
	 p4ZoPab6/4YQpPIm7n7EwUfvb47dyJpMkYnet7TXb7/pud/DG8VEOeRWdkTQI0qbNz
	 xGOEJDNaCak6zfaWGZOZ/xIgBdk/SdNb+vP0HpPBNJ9rniCzagZFIjgFlImsLzjFQa
	 E4tnEV7xa3J69doyir08/R2+AkHBBc+sXA3OTCjU6gkMmtyrBldeMFZHyq10UnEOgu
	 jHljaYv4+QoKlZ4aZcFUCE9h6qUT0wOJpsqJpo7+JI+Kxd7CAyPuxYNioBg0KNeYq9
	 zjWWaFJ+OqiDQ==
Message-ID: <sashiko-outbox-219231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 10/17] netfs: Pass the write length to request
 creation where appropriate
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-11-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-11-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:28:01 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> For unbuffered/DIO writes and writes to single-type objects, pass the
> length down into the request creation function so that wreq->len gets set
> correctly.  For buffered writeback and pgpriv2 copying, this remains 0 as
> we don't know in advance how big the request will be.
>=20
> A subsequent patch will use this to set as the i_size on single-type
> objects (e.g. afs directories) as we don't care what the old i_size was a=
nd
> we don't want to see inode->i_size in the netfs file changing due to
> third-party invalidation before we update fscache to say how big the obje=
ct
> is going to be.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D10

