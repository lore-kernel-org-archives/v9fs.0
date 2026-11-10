Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307994;
	b=JJmmppV5BX91EbwN7GtJWFD8R9o9QmCohemH1iR/w/r4zSzhmMgtMTBNcARoASdiMHF3
	 lAXxjbZnKK4+bOOExgYGqetoCW09fYGx2tBea4lLk8M2u05J7Zt8N6sKtq3mtlXtRvYLt
	 mWoqKd7/QolZOMy7b2QfeNN/v9rm3uSs0v5NZtoKJkJRWu5W6OdeAtpe+QHA0GtO0rLM2
	 OtqFJIHAgyfUxmrYJWHa93/Weg7ZxrfLT0CWvkC0urO7qCQ5X21S+3pO4H8zor/yXXVOd
	 /pf4bFmPNLTjeR8G9gfpuIhibEbruxhauzCw8TPrJO7lAgKiX75V/nKpgV0coflpR9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307994;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MUQZhvFPwtHOiOqI8o4FiIAIO/PZggA220Elj4OLcaA=;
	b=larJPqmzo8lezDt39+/sVmpPCbXwF059c0h20/sBee6CQxZt3OgqaohgtMwIi5sP3KzH
	 XUXRfOtntGx37BxgkbKVkvA+eHJCcioOQ7tr9vQfcVFuwKPGCGWazZSyhKVhx6NbXjBJD
	 lff+Gz6iwGpb0BmUcyIUGxNa0BVkB/HVcNOlsLDUPzmrcGXuq0tPcvlKS6p8p2KfiNVx8
	 mzL5qgtT/g9nSyW2Y02twjgRAiBBa9d4MaZMkIn0qJIrVkhr8T1IW9i28SbpVZpi5j+o9
	 pnLnYPZIP+cNxgMVu+we0g+vgo2FoFXIt3E8yEnJU5fqCs7U1c225hxMUaYKturUwsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUVScKX8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B9606A31C
	for <v9fs@lists.linux.dev>; Tue, 10 Nov 2026 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUVScKX8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FEB1F0089F;
	Tue, 10 Nov 2026 10:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307993;
	bh=MUQZhvFPwtHOiOqI8o4FiIAIO/PZggA220Elj4OLcaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cUVScKX876WNp/hyTeH70bXy67u3La6vcPLOcbtm2tPUdpOSaDDGQ6OTtEsBai8eO
	 OAmLlAugov2gq5yKSVc/xa4hSVyMrVWCoJk1oTHXtkXe1vYpKYaO/uO4KWn73uFajV
	 m8PFaXrhfCj3pwUOkwsunBzqmGfSLztlZCKqK7cODNqlx8ch62o7eg3kQDm4RhD7Ft
	 Zr3ozFb04XDmUFkOJx0BIc+fa/kFJQ4Nlg03hSaojy1s+L4rgjaCLTLBTLQtJpvqOV
	 ef5nqVIlaaSZGI4/kmX/wOU+TF8K8Rl47vfCCYQicvOF8ycSA+o3NZRj2DIaAa5i4E
	 HO7HYDA3tDhfg==
Message-ID: <sashiko-outbox-206902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] 9p/virtio: keep a request until the device returns
 it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261109105251.2545764-4-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
 <20261109105251.2545764-4-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:53:13 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> When the RFLUSH of a pending request arrives, p9_virtio_cancelled()
> drops the virtio transport's reference to it. However,
> p9_virtio_zc_request() has already dropped that reference if a fatal
> signal ended its wait for room in the ring, since the request then never
> reached the device. Such a request is still flushed, so the reference is
> dropped twice. This can happen when concurrent requests fill the ring
> and a waiting process is killed:
>=20
>   refcount_t: underflow; use-after-free.
>   WARNING: lib/refcount.c:37 at refcount_warn_saturate+0x84/0xd0, CPU#3: =
dd/293
>   Call Trace:
>    p9_req_put+0xe5/0x190
>    p9_client_zc_rpc+0x52e/0x970
>    p9_client_read_once+0x237/0x6c0
>    p9_client_read+0x9d/0x140
> [ ... ]
> This patch is assisted by Claude Opus 5.5.
>=20
> Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109105251.2545=
764-1-lian@is.s.u-tokyo.ac.jp?part=3D3

