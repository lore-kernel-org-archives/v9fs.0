Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435726;
	b=VlKtlb6agQvlrFD4LTaT9B36M3jIlkUK/M+MEgFLZx0Q2ylug5Sj5+SLXKseMMHKB5HA
	 KrWvhhjn84G+iO2emQvwnRyCy1hz8pDabJdBVuCihArI6Tkl3mhKw2oV7xmsIJD/+M0hV
	 s20HYsuxv3cyJRNcA5ejCHk6H+7hOtWx4jGOMER/j9x+6GlPuYYZ5nv0UVQtLT2BPcIB7
	 Dg9EI7TtgSUy+d5ZyqvZZ+HNJ66jvQIpVTISTY4q/oXNyJqh2mLKLsBprtllV0b1HV4dp
	 RqNNIoTAxTW1bYLuh11Ly568ie93e3hXd7jfyERumHzVh/fZEgL7/Y5bKp80sHs9nIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435726;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y6DCXn3pdT2hcZmFplUPYGGvY58pTkN7pk/ZkcdlZAU=;
	b=KpfWgw/PfNBRx9xoXj3VaHdd/31Cx0q1o+48XwTfU8LIPu9lHgicwY+7+xtZxG0RJbPK
	 lXm2syjZGA7FWfacFEyoxdgPgSejnXSFhjpDx/5I0xkC6Wk0jl8XS6TkYrPDGtJn1KbE+
	 dq2XctgYRmCSBvRS8YOF+jOKEf3S9hZDxxE4oyFdL7Pejcp0kXX9soeBv5+RYTB9aMx0C
	 VGgRSl7gnPq/Yqxlj309d8X+Lv9fqwNUQmyuHQsXfiQAIwPtUSyVlq97HiWBFqOOOz9wg
	 dHbztjHKehcmlZ5JioBwFrMs7X55T3ov1XNzz39lwkEDzYSeNzAGKei+iRORIDkSYaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bzg1rpgd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0D606A324
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bzg1rpgd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75E41F00A05;
	Wed, 11 Nov 2026 22:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435726;
	bh=y6DCXn3pdT2hcZmFplUPYGGvY58pTkN7pk/ZkcdlZAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bzg1rpgdpeElcetAjiFRtRCacxJHILjVziPYeqtLgSvrjcl7MrKEh5bu65DtIyu+L
	 Qxb8VUutE7E7sbPMLkNbKwUpBfSAiOYgJv/MjJPj/Jl8DHLr7SL14J2xHyvYlaC38i
	 G2DrWpfRKS5Xq2cFQq7nSzTxTpmrjf2jCKx1D3SlEwwoASX9DSR1UGygKWsNTkv0m0
	 x1qUxOPnUwwGijATQjRNLqP6/OMkvm5OJ+d3i+TEGVQXRPmvINyg+Na2ZpecojntIA
	 M1MaowNd9SWxu3lp7Swrnvne7V6QxgMnFrl9rK1qUZjNIchnaJ2UsLk+nAvQigP9mR
	 n4VmcJZ0LybyQ==
Message-ID: <sashiko-outbox-209780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 05/17] iov_iter: Add an API document for the bvecq
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-6-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-6-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 22:22:05 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add an API description document for the bvecq structure.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D5

