Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759891;
	b=KNy37oEI3bUQ+IRIYMAMvdshuBSAxK5S5hjPGDtcIGQBSDCQjCHFgRx9s0ovCnA5bMXo
	 JvrPmKqqI84RsKH2yxjpoAel48+WDyYvbX25vIs1zM1X7i33KLms2Qbwz4Ax1Nyr6KKyL
	 NDgjA1TG4bT1XyK1wUbZN9Ga7KHq5vUO0BUVDJoxbILcqLKUZzrGKjb2RuFYHvqFSvs4P
	 KSCNE3lXonQzmr+0RyDGGNgK0+dZxCDM++37nhx4PZ0cDBAavDLd7V9mqE/VEUu1S3CLm
	 7MacOVGTz5v8ZoGY058gaI2Tj1Zvubmx5xJ3nwjVGH0jL/lSHDRb4Bz4BfCAoczFsrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759891;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nAX+lYmpPd4T/fCsOgFkqneBrC4D0YQJdT5CUwL5VOc=;
	b=uWw+FaQFX2F7sI9K4EWrnbKgJ1ozrz0SCbznItPJ/odf0/Dw/7rwxOhfFy6VB1DtTROj
	 ULDxf0kTand8WOM2ymtkLpzhh9MziCFr7Wr+RP/+K4Qe5WKD+VRVsJj+l69ZaKu0Aevt+
	 7AQvqz6DsJXP/zUBMKET8sknTx07Ci2LFGZkjO/Q+wM3rgMFLRB/3G8k2KOfdkpIsjVQz
	 OBbT6+jrO1eNFz0+2QsoVK1EwCQ3dat6cqzVFX8arSY5vipKMLXxyCO+mSkND8qbWHQB7
	 qNUTN/fUkE47qFVgEmdmDC7HLuGzaPT5DKafyBwUjOE5kCQrVPzGiVEI2d0Md9Dq63g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLyXRx6H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6C606A31B
	for <v9fs@lists.linux.dev>; Wed,  4 Nov 2026 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLyXRx6H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2B61F000C1;
	Wed,  4 Nov 2026 02:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759890;
	bh=nAX+lYmpPd4T/fCsOgFkqneBrC4D0YQJdT5CUwL5VOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BLyXRx6HepbdzSJmuGn4E6WqV+KqokMPzde5aVYmIlp9i5a68DvSOVBeecYmmP8h5
	 iKEGxfr4bmVixdsXPBJGd4mDloCHeyg6AROlev8XYSr4jA6JiVdAjIGbR6yFYTw/2m
	 OLqP2RxplVePFg2p9AKckPTdt3VEy3k6/q7o8cHYPlAaWBXfcQT9FPbDAvaQIVmB2J
	 Baf5rBpOYUGKMopFF+51zTyhkVe6J7lTQF32l8a9bHK0E+uSbFirbkx6Gg3SHgFpLE
	 6T0MqzLCZjdOIRjh4MK4PI0oMFMBHg9kBFzo0h33mRQSHTl9p6NSBonvrzYreXR07L
	 7gtgciIg7+WLg==
Message-ID: <sashiko-outbox-196506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] 9p: put the request on a duplicate RDMA reply
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261104022806.1484080-1-vulab@iscas.ac.cn>
References: <20261104022806.1484080-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:38:10 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> recv_done() gets a reference on the request from p9_tag_lookup(), which
> the normal path hands over to p9_client_cb() and that puts it. The
> duplicate reply path jumps to err_out without calling p9_client_cb(), so
> the reference taken by the lookup is never dropped and the request, its
> tag and its buffers are leaked. A duplicated reply for a request that is
> still in the idr is exactly what this path is here to handle, so drop
> the reference before bailing out.
>=20
> Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104022806.1484=
080-1-vulab@iscas.ac.cn?part=3D1

