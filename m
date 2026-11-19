Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079592;
	b=hI0sj0YSgQdrR1QGODWm8eBA2E2CCL7P7/0E9LrFcOLxYaYMrtr85hEmhXPIqSmSxbmM
	 Cwju6nFKmm2vZPADUypB4JKHxfso6h6D61ADNNq1BZ5O22REn81T3sNwJcne0iZlyA6Z8
	 jmD9dlZyx90T/6m3+rV0ojEKiu3kjH5sVM1Khj0JJT/sTz5W2kVK8eZZDb9B6j8mwwew/
	 o0ZVYkm/qVnmaROuBkkMFLUIweEu/UH/BY4754WlvD+Us42SCRLj/pTiTahpegwOQQHoz
	 s9lfkY/+h2twz/guweEVXkxJPrOalFD7pKgYTf09xc1wGhSc79rpyMW/aFyejO/mYyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6AasbtNKsX8m3IulvCM2260TWH1M4RjWDr6SaPqPhEs=;
	b=B2ninLIPBGvx00wsj8quxqt8ZBE2kwPwdvkUlGu43Wg6aYwUuXFn55LQrljB9u1ZMQ7o
	 jkX66QTX2CBvdaBEiGy3ZrqMguTWIymWm3tODGdF92uKy7QnumWhT9f7Sny9pVcmha1RY
	 epmDfGbPpUal9CiQ0bPc/bEUuWJ1OEhwECEczhV+w/E7vXocMQIv5LTO0kBqejwUIdgN8
	 tF46YUuj8OXBaSKlFZLzgXx4zc2YozcXq0U0ElfbnivkI1lcNxs3+nGSiVsbJ+G/WI1ff
	 EP6+sgTgAUcHzulaYdQNj9WyM+kFDXEbDUJensgA29Wso2Vy8VhHIqojghe1k+2XrYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krPrHvVu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCE606A338
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krPrHvVu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119241F000CE;
	Thu, 19 Nov 2026 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079592;
	bh=6AasbtNKsX8m3IulvCM2260TWH1M4RjWDr6SaPqPhEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=krPrHvVuLZYXT3jNzGK/xymbSL2WPApCN3RoWKYvZqc1ZE7IQ1G6JQ5NDbDTN5x74
	 MhaGrgbhMBjQ0KF6yTpCWjujQqdBur/8IifjFrSIo7GkRIUlulpb2LxE8BiYsquAw5
	 jpjaK2h8aLjjIWknwyB7giqKrKnWeaj/nuU/Q/we8wNlu6gQpHWCmY2y8yQGJRWQWm
	 a3PyD0BPCuSVZ/0pYED+vUJyeGdgQ6dH+AHjAYQYw6LOv46woLH02fijOQy7CVh2z4
	 C0maA2QwV313X0um9HYYtMmjUif9xXYc/E2epEC+oO/tRNeUyPUhc0MaXD8GkxOtat
	 P+DSbL9p9thzA==
Message-ID: <sashiko-outbox-222798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 15/17] smbdirect: Remove support for ITER_FOLIOQ
 from smbdirect_map_sges_from_iter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-16-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-16-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:13:11 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> netfslib now only presents an bvecq queue and an associated ITER_BVECQ
> iterator to the filesystem, so it isn't going to see the ITER_FOLIOQ
> iterator.  So remove that code.
>=20
> Netfslib also won't supply ITER_BVEC/KVEC iterators, though smbdirect
> might; further in future, it won't supply iterators at all, but rather a
> bvecq slice (that can be used to construct an iterator).
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D15

