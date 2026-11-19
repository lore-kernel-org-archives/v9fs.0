Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079753;
	b=mmXGB3nECPhd0LhCFzxbq3PwgZZwNu4HwkjYeUs9d1PXdBkl1flF4XOhyPMin05gi6rT
	 /SUplKsqrnwECBF7QJ8KkOktF/OczgrhdmCIdBZvM+qrqts/LhDtH7LhIgKA0eK8OqadZ
	 n7iEo307cNs3aGIOIzSUIF+ln7vn3+BLNL8XqTQ5nwyBSeUWKvpmgl/5p+sCRligXazca
	 D5/Hk4YzL3F5bmIRzh2rDOlwUV92RI9+l/+zS/Z8sUqhm1XgAxg3pD1s0MU+ayNSbrvnk
	 KGmp+njVZXiYo43zdQ1wOxEK6zrxcLmcTNLVOD7PoYZUYRTRUTm9mOforkTYIPgBb8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079753;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HkW+yMVhh/wMtliTpo/nSDoyub7FyodDrg2RXdNWZM8=;
	b=a27l0cHg8ygCQERu+ho4ii/Xxl0RmVGUaNsOBJBr0wupHSLvsBihPiNWvWKft9umZobT
	 d5VohjJzS2U93QP9LehlSiSmPq2kY4AgmmHee+paeNsZ0RibcyRXuLZCfaTw0dgn71lBT
	 teXTqwiH+9W5aVrYqy8aDCbDjgnisRpvos4N01NYCx9m3YnI6iMu+XrmwNHe+ZeGTQUqW
	 o1nrr4jvHV5Nqid+GNMRYxKQ5/BJNgXWG6MQNrbizak0RlLdznoqZjx8FEs9wZntVgGb8
	 d/9kNIt/x/vnymLZ9O2O1X0rYkxPrJQHilEZjnOv7KiY/fq+FZfLcbgf0+wyXTwRdbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffrTfnN7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F3606A324
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffrTfnN7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278051F000C4;
	Thu, 19 Nov 2026 09:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079753;
	bh=HkW+yMVhh/wMtliTpo/nSDoyub7FyodDrg2RXdNWZM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ffrTfnN76MJiKguG6ZS6KZn8PQGN/qh95vO2hkj97pUK9Z0gLnj5ObBVtb7F0kyXc
	 tUawDERN72WGvj8TkQSJGtj33fZy9j2BRuTYMHcLvP5pzRlbwcEPk2zWe3xI8+3nUh
	 rOgsJJzycmYsfdPRYnlDpziUqgqF7IEWPJGkjD98Szu95bCuwOG6pyrd6BPNQHJSZB
	 ZFKh82ElOSLFdGUwUJG/ozoBOkLUjRdb+XaYRjCLFM06gmGLtgIU3IJc3fMaXrBOaw
	 BCAodt67tJ5OrUYArGcZE5/5si7TGfY+Cj27iozixfkPHHZQKwztX9fjOzNhWGhdjG
	 MSC0hxTn4rzuQ==
Message-ID: <sashiko-outbox-222803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 13/17] smbdirect: Support ITER_BVECQ in
 smbdirect_map_sges_from_iter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-14-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-14-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:15:52 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add support for ITER_BVECQ to smbdirect_map_sges_from_iter().
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D13

