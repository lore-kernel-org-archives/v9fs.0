Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307993;
	b=pXn6Nck4qnblouCYwZa2zZRw/N6jjPfCdMVOqB8yrrleuOhvs9H5KKI1/ePes4pVUz2d
	 qFUqbKAJqLbtD5vaiF3spvYSQ5vYW287EZOsjTsvATb+ZdhrNScgkl1m7hgcJERLjal2O
	 hqTKhLml2sVQ/GDGjVN1pAAOjp7+t+cYLBLyU2oVNd4U88UgxbrEHsQUDhoizZAKwaigl
	 RgEDFGh9DmruK2Rnbqsr/u0AQBn6/jqOEmTrkQ6wsGgehi9z0gCDUOOJxHr62d+AupRjD
	 pHlKvl8+4MJ71DBVLIOw8Q0MpVx/9YXAgnsQvodRrDubT4ibvXD6B0c4OhsI6HZtuRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UaEqRFJMRRkt7ehFLBRv9VuldPB5N5KKyUfOCcmMc2Y=;
	b=a1PzWcDS6G4MlyXYWL6z6117NXl3MNdji2jBo9FsgeE4+ajuqXQlMMbQMUetPTGOS/q5
	 Dx0tUztF89TA/CyBHwhjrS0HNjY/X0097RUsTiJWEjXiitFVFOTVQ2cWSy+CMNaHq37+j
	 j0hYZbGzhA1lbdGIkT1DXoKOMWRpTwq+OXF8ZLZ2VRA6rWD/16MZF48XJxmDms4XDJA8h
	 28vJx5HT2HkITIMwWvIN3aLBVtZnK479pywYV62ojfK4C1hHHTs6t1ssyTz2j0xEQicxl
	 PVEbnIBQAFbve6YmFvwH2Exs6GQPS0K6p4EsSLxICZp1KPa7PwN/a1qGNP50GtXRxrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKgXzFQE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB8606A326
	for <v9fs@lists.linux.dev>; Tue, 10 Nov 2026 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKgXzFQE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B651F0089F;
	Tue, 10 Nov 2026 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307992;
	bh=UaEqRFJMRRkt7ehFLBRv9VuldPB5N5KKyUfOCcmMc2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKgXzFQEJGDm79bpJ+xuhMpKLXncJymXYlpeRtB5DUY+5XgPOWLMviyAChlYmbjUd
	 Rr9H7I2TU1z5154X9/Gcyt6Wmeuq2fXt/2jKd6UcfkLyZ8DXnaslgRfl6ao/sLBcG7
	 /XL0W21BYx/lBLUW/F1JNDJbm5owOH4clYznsE6Kr/8fY+rKAQTWMQr0zkDpgJhtq/
	 mnHS6/3NC6XVtd4/3Y2tI68/uauE56+22/fredL51x9T68PxT5oFspyvTPP3ho1J7i
	 XaI+xq1JszYnzV+Sx6TAIJO/MHijsiHE+JsZaAl3etF6rLPQxkvVQ8uDtp4zxqJgnY
	 Zavkr50VxPJOw==
Message-ID: <sashiko-outbox-206900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] 9p/virtio: clamp the reply size of a zero-copy
 request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261109105251.2545764-2-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
 <20261109105251.2545764-2-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:53:11 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> req_done() takes the used length from the device as the reply size
> without checking it against the posted buffers, and p9_check_errors()
> skips its size check for zero-copy requests, so reading an oversized
> error reply to a zero-copy request can overrun the posted buffers:
>=20
>   BUG: KASAN: slab-out-of-bounds in handle_rerror+0x144/0x230
>   Read of size 8 at addr ffff888003065768 by task zc9p/157
>   Call Trace:
>    handle_rerror+0x144/0x230
>    p9_virtio_zc_request+0xb8e/0xd70
>    p9_client_zc_rpc+0x21c/0x970
>    p9_client_read_once+0x237/0x6c0
>   The buggy address is located 0 bytes to the right of
>    allocated 8-byte region [ffff888003065760, ffff888003065768)
>=20
> [ ... ]
> Closes: https://lore.kernel.org/all/20260607140603.24342-1-zhaoyz24@mails=
.tsinghua.edu.cn/
> Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
> Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109105251.2545=
764-1-lian@is.s.u-tokyo.ac.jp?part=3D1

