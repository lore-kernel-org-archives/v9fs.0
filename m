Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F078F2E
	for <v9fs@lists.linux.dev>; Tue,  9 Dec 2025 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313111; cv=none; b=TKNGQETr8xHkgav97bbz2YVDFkjRmZq8Fm+i8vyCpGaGaf7av1AoLM8eEtvuurIs1Z6+34nqeUpSjG7Z/a141emaobT9huShQ6mVJmwGcspw1qcSY13J10MV2nywGmJRWVIlgLQIkIuZwbbsb1IKLnq+yoflTEHjfwa8E1QKvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313111; c=relaxed/simple;
	bh=Zs/Gv6KmROZaKMkNSGejL/KofQjUcAHP7CRkGzftpsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sjq4UDFsgWSiDrMUOQj5ElwF6XtEjewD1VTLpbhjJiApVlyGy+A/iRsLWeD2XugvhdwDuwKdi3VcnmuZ328z6EAkKS3dt9VdscNa4NKkL4uJBOaefWEhfRwOmc5xZVwW9jS73mrnanw67/+Np0v2c/Dk1ewhP1sw/7hqff+YSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=wVjVycSX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBXUjlXU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="wVjVycSX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBXUjlXU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B20727A0142;
	Tue,  9 Dec 2025 15:45:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 09 Dec 2025 15:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765313107;
	 x=1765399507; bh=0N4XCRLiGS86gU5LpO1DbjTF8CqEyMR4G+09xB38BqI=; b=
	wVjVycSXQydYE5trke5qHvZH1R1a6ZPvH8/l/a82l5odiqbYLIqJYcvVFni3Dl1s
	xDO41tdL39XZFam2AOeZ59bNgdSbNW/Gvm5gyPzK8dXAPAm3J0RZWVdRnyfiDVb/
	WZMOLtlc7MjEN1fhl8QcXLiZ67ZgEjgyn3tI3p8GLEdUi+7hra8t/WX0NMhuX0bq
	PjO0v1jzlK2kmi/ICFp2+Y0Vv2dZ2Ap2VsdfyQiuffAYd7D/E1aFH4S9ke3ZHn+9
	praN6PHxozYBxNqSVdbvgztLbrPobP+3sGNMQkOVAIIY83k6DPt/vAeKoSluphuz
	q5k3FxUAHpkB8kwS3K4Qvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765313107; x=1765399507; bh=0N4XCRLiGS86gU5LpO1DbjTF8CqEyMR4G+0
	9xB38BqI=; b=tBXUjlXUR/oAqUnKDuKGoSSArXXMx8lrv16r65zqnmiKomCfV5F
	fW7QFP9Zeu9CTUHjvYR3HOhGJauR1SQrQmagInyADo1tuEgWDr2AdzBcfqT3e73G
	PzuQG9/ikL4LR+VE3RQxJc2NssnaUWtrJSpxgb1RQ2WocbujUCSYyfRN/0FnWYaN
	hUJ+nQ0O4bpzWMiJ/kPD7eZitkHme05nlXdUe/47quPgokojXuNJt1UQxlUPCJW7
	AqCKDO3NWdLhWDiEKSTvUijnb+AE6VnFU4mp0fBdf3MiaVWhPi4zkJyGlBo13617
	f/CIkge2Dn91yR3lXhOVUDWsojBwtAtIqSw==
X-ME-Sender: <xms:Uoo4acT76c76nGTgjloRBRS9DDWwHRBAtpDNL0xNb_J-QyLbpYhwJA>
    <xme:Uoo4ac1L95Km1XtGWi3_vVsZSw5XWOrzUmvp8caK22EFr28e5yQ8nWKuotF__WyLg
    HGg0jA_k85iepGP3kGEF3skaBln5oCrkFh91UMfdJUxPTD3zA>
X-ME-Received: <xmr:Uoo4aUdMf8SxSxBUTHwz_lADaFul0pX2DYzDX0eDFsYnKVEE6o_H_Tuk3qYAqfF6z6Iw9TRty05YWVUNuwkXVO2CXNkrU-vxcNY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghkucfo
    rghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvhhish
    hisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudelteef
    vefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhn
    vhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopedutddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprghrihgrughnvgesrghrihgrughnvgdr
    shhprggtvgdprhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprh
    gtphhtthhopeigvghnqdguvghvvghlsehlihhsthhsrdigvghnphhrohhjvggtthdrohhr
    ghdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtph
    htthhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohep
    lhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepvghrihgtvhhhsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehjghhrohhsshesshhushgvrdgtohhmpdhrtghpthht
    ohepshhsthgrsggvlhhlihhniheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Uoo4acO7McXj0OqI6Rw8pxTptYHTFnUYzD5tn684xs12Tr1NftuTPQ>
    <xmx:Uoo4aQWNYmqn6IMIMSiB9rW-E2T6gPw5npbXOHqB8VIFvEn-vcRibQ>
    <xmx:Uoo4acyZtu-ZwEPnR5PTpomsZflRNEUoUPU9b8mYcItKWunRV-yR6A>
    <xmx:Uoo4af-Fd1jyi5QPX4VIAJHkKdI_C9jgj4A-tzUg7D-qpcN1lynqsg>
    <xmx:U4o4aXvQuSzCvlM4BBL-UltJnLcgZs7RrY-b1abd7zCJPE5-XAmC2Opm>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 15:45:05 -0500 (EST)
Date: Tue, 9 Dec 2025 21:45:03 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Ariadne Conill <ariadne@ariadne.space>
Cc: v9fs@lists.linux.dev, xen-devel@lists.xenproject.org,
	asmadeus@codewreck.org, linux_oss@crudebyte.com, lucho@ionkov.net,
	ericvh@kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Alex Zenla <alex@edera.dev>
Subject: Re: [PATCH] 9p/xen: mark 9p transport device as closing when
 removing it
Message-ID: <aTiKT9qOS-cQO_L5@mail-itl>
References: <20251208195155.27473-1-ariadne@ariadne.space>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MSfjrwLz2Q9UiVY0"
Content-Disposition: inline
In-Reply-To: <20251208195155.27473-1-ariadne@ariadne.space>


--MSfjrwLz2Q9UiVY0
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 9 Dec 2025 21:45:03 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Ariadne Conill <ariadne@ariadne.space>
Cc: v9fs@lists.linux.dev, xen-devel@lists.xenproject.org,
	asmadeus@codewreck.org, linux_oss@crudebyte.com, lucho@ionkov.net,
	ericvh@kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Alex Zenla <alex@edera.dev>
Subject: Re: [PATCH] 9p/xen: mark 9p transport device as closing when
 removing it

On Mon, Dec 08, 2025 at 11:51:55AM -0800, Ariadne Conill wrote:
> We need to do this so that we can signal to the other end that the
> device is being removed, so that it will release its claim on the
> underlying memory allocation.  Otherwise releasing the grant-table
> entries is deferred resulting in a kernel oops since the pages have
> already been freed.
>=20
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Fixes: 71ebd71921e45 ("xen/9pfs: connect to the backend")
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> Signed-off-by: Alex Zenla <alex@edera.dev>
> ---
>  net/9p/trans_xen.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index b9ff69c7522a..cde283c42dc6 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -312,6 +312,7 @@ static void xen_9pfs_front_remove(struct xenbus_devic=
e *dev)
>  {
>  	struct xen_9pfs_front_priv *priv =3D dev_get_drvdata(&dev->dev);
> =20
> +	xenbus_switch_state(dev, XenbusStateClosing);

I think you need to wait for the backend to acknowledge it by switching
its state, before continuing. See for example
xennet_remove()->xennet_bus_close() in drivers/net/xen-netfront.c.

>  	dev_set_drvdata(&dev->dev, NULL);
>  	xen_9pfs_front_free(priv);
>  }
> --=20
> 2.52.0
>=20
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--MSfjrwLz2Q9UiVY0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmk4ik8ACgkQ24/THMrX
1yxxdwf9EtdVm4vHKrR6Wilq1Fv0h4VXkAx3qT3t0DLPbOJ19GflMTaV5cVPgUQA
OzoCxGYOPjZHIDSkUDjoPrmWWs1al22S8jwB5JtD6ep/i5XX0tWY06SeuwEouXvt
DxFnZDg9DD7LzMd5MC4DDjv1y1TuR7tP7QYjKYrX6sFxRn0lQqEcS7YLZRdDRGXk
LZtgL9hb4LjG5EChL+i9ipHk2FhXbj8McsnwbhLQDgSoIM7BFUQ3m2Qk8gDKAagy
fYVXlkhwy+quQFJoirM7qKsuUkkMPTbdxtmbJTSRTf7VM+DxK57KMghL8Ocsmmn2
jBYyH9svOnzBj/ZJL4iIIAfnjxndwg==
=VcHR
-----END PGP SIGNATURE-----

--MSfjrwLz2Q9UiVY0--
