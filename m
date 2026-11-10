Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307995;
	b=sj6JZkkfzZtZoFrKUpT9+mf861Nmy5o6GkkCtJjIFozWwlLJ21VIRYiPrT1lQTfI3L+u
	 6ttYC10wOFRL1bUATZVfab67j+JJDp5O3qstaOUT24rR0394ue7WwVCAfhz49jkfFkpgL
	 lxnsplTpnuDkMU5Nvsb9hHTjbPwuuCJU7P3oexiNaOl/mnRU0gREZ3kDEqHWXyQMsecT3
	 W4WGgs8fJziuVD9K5gtMmeghKKlRlIGvkpGgVwj/RmjQOmsq+7QDfvBzPjicyKsVB8O+m
	 KH8Xy8v46xY2EgJ3HNMV9a8Rc7NAkxNrIa2r5DyVwVmoZ9gXgc5rRKo7L19WslMNrsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/GklD8OlqdJ8tD3FPtskAvq1S4s7aMpCC8kittf8DMA=;
	b=uMu9g40Jo4R6Bxcm09gc/ZBMPAJRT49nRy+ffs9H3IoEN5GU9JrFEfB94lw/2pxrJ1KU
	 6qwaJVvQZbzZdAL1cF5O+9tiygIqQHCNm9WG/UBHqATg2QC50EQ/w1/00YWg3JGyjFjku
	 mZWkChJVBfK6DIwmoBZBSYhnDMsi7qwLMLy3qOZKPqFd8YzFHa5NT25L13jOj67kr9RI5
	 VqlnOezmVfqfa9wF2Bs/vn3aUdaBBBSL6kNY5nW5RlqpSh+IJa5PnSsZdbJDIBlbzYkDM
	 JnI2LVl2tUGnvaDeIoOoqUmcMttqkrrieQ4qtstA77cmSYbDNmwm1qO+T4NEN7/7LKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9ItnrDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C54606A31C
	for <v9fs@lists.linux.dev>; Tue, 10 Nov 2026 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9ItnrDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EB51F008A1;
	Tue, 10 Nov 2026 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307995;
	bh=/GklD8OlqdJ8tD3FPtskAvq1S4s7aMpCC8kittf8DMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9ItnrDlMp2aNpU0wEDP9DI0+4mTztL9t5+Z3w2c1N6bojHx3C+JiMP9YHXf8GFIY
	 holX+mw+aduayLMZrhgtT3m9P6mpmFUs4BgdmAoEOjPu4GmSPLSyYeIz8pExf4FT9J
	 kpH2C7NOUm5ia9Ikqf7u+mKDYLHouTLlk/a0JPdHqcpDb0GSFEnL7RSJ3KPKgOky99
	 bhjKXh+ysclZOQ7AgEjgbAXoqo34H9R+TaOhmBCP0SX0ugP2uLDTr3pxQ+UZ6y/sLa
	 8L6d0QnIPoD6lyNTb4FOxS8apUG9hzpfwuukW2K3GkfSLVOMEjQkh491WBkLDGnIbe
	 4ZGyJJvdtnZAA==
Message-ID: <sashiko-outbox-206904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] 9p/virtio: keep zero-copy buffers until the device
 returns them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261109105251.2545764-6-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
 <20261109105251.2545764-6-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:53:14 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> When a fatal signal ends the wait of p9_virtio_zc_request() while the
> device still holds the request, the payload pages are released, and
> p9_client_zc_rpc() returns to its caller once the RFLUSH arrives. Since
> the caller may free the buffers, a misbehaving device can answer the
> request after the RFLUSH and write the reply into freed memory. With the
> payload bounced through swiotlb, the guest itself copies the reply into
> the freed memory when req_done() unmaps the returned buffers:
>=20
>   BUG: KASAN: use-after-free in swiotlb_bounce+0x236/0x270
>   Write of size 4080 at addr ffff888004800010 by task swapper/1/0
>   Call Trace:
>    swiotlb_bounce+0x236/0x270
>    req_done+0xb2/0x280
>=20
> Fix this by releasing the pages in req_done() once the device returns
> the request, when the wait ends without a reply. req_done() can find the
> pages only through the request, so the page arrays, their page counts
> and need_drop are gathered into struct p9_zc_pages allocated for each
> zero-copy request. p9_client_zc_rpc() now waits until the device returns
> the request, since the caller may reuse or free the buffers after
> p9_client_zc_rpc() returns.
>=20
> This patch is assisted by Claude Opus 5.5.
>=20
> Fixes: abfa034e4b8e ("fs/9p: Update zero-copy implementation in 9p")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109105251.2545=
764-1-lian@is.s.u-tokyo.ac.jp?part=3D5

