Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078354;
	b=zIdUOOJlGejUdcR/CQ10UBhO47ACWBdr4faozthDBJLsmGgjPAL53w2EqD8rMtg3bKrf
	 SfRWQQ6FugRpBVaLuhlov5dwEUnu9CqX1bt3scxcKQXBn16kEGZSvOug7eShBACXBZzW6
	 7WUNuD6ZFrlqxBPpViKEX9hsembTpAHorXbY1ghqfLhVak8CbRON3lwaLUiAK3Z1YsHzN
	 ewwjkdB5Ibtxt4jC+iy8m1hY8zcTil5yKffj2uWSbvZ0UFqM0YGp6Wwi87Nl0yt584oG3
	 7JeJaECOLghZYQth9a2X3rvcoJO9J6jRLCqI5qiX/oM8f+z0bB0mYyXQcWcGUCG5AxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078354;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9u5N1FIzbbUkoJKrqR5gztCAYSad5X+GaC9iwvRBkNw=;
	b=2LO+rPZi/qKRlyQ9LVPBcEMKlYzbvQFdFgVoAclH8Y4qzM/zPECY3vq3uIQCq4Q2PB4z
	 mrx5GMwIOxhwngKrH273frH80Z8Ky6kiguNL+zycO6R4hLo70pqYUXFPTefeptnbwA/qT
	 GfTGKFPbBsn1yLi2gAZFmpCZ1e1j+jmaLJZROqRxzm/YhJJM4sxER0u5MkESfiPqpAS3x
	 k8gy2JCt4IWuGdZIr7oU4rc7jRdt8WuRflnhKID1jmeFqqbvh9S10FH+JoLFi0YpvbLnx
	 HlpA7Emex+X5DVymVMgOvLmzECsXYzM2fghzKQ/UkRnolaAlTG2h3oO7sxdIQ2KTu8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1Hen7Bv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1886606A320
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1Hen7Bv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2A71F000C5;
	Thu, 19 Nov 2026 08:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078354;
	bh=9u5N1FIzbbUkoJKrqR5gztCAYSad5X+GaC9iwvRBkNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1Hen7Bv4T4ZDyGFvY+ErPmcDbnTBEn2tezqborv3UTlN78UTTOzPNls4kVissBhx
	 kAb5u5DQZNneoXOcbhudAdXnGwM4FkRGo3rL2uXahyFjeOjvrDXG9nEyuQ7KHq2xAM
	 7/VlLoYJ48/TPf7rtdMeaA46vJwjY0UQMxqSMIh3ryB1OHByHFgETFtrNzN6NdMQh9
	 czgUDKwkzjzGerKrVgSqu0iV14iDuRYgdLm7lozIo9S+BSQQrXjeC5f/mgeY+CK/UY
	 DyNEVQPz1mXeO4Y6E7o8K0JfgZidvBWjs8Lm3ECl/ICJLUklAznoRb4BT/qENumcK8
	 uATQE1W0BmfOA==
Message-ID: <sashiko-outbox-222732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 03/17] iov_iter: Add a segmented queue of bio_vec[]
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-4-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-4-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:52:33 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add the concept of a segmented queue of bio_vec[] arrays.  This allows an
> indefinite quantity of elements to be handled and allows things like
> network filesystems and crypto drivers to glue bits on the ends without
> having to reallocate the array.
>=20
> The bvecq struct that defines each segment also carries capacity/usage
> information along with flags indicating whether the constituent memory
> regions need freeing or unpinning.  The bvecq structs are refcounted to
> allow a queue to be extracted in batches and split between a number of
> subrequests.
>=20
> The bvecq can have the bio_vec[] it manages allocated in with it, but this
> is not required.  A flag is provided for if this is the case as comparing
> ->bv to ->__bv is not sufficient to detect this case.
>=20
> Add an iterator type ITER_BVECQ for it.  This is intended to replace
> ITER_FOLIOQ (and ITER_XARRAY).
>=20
> Note that the prev pointer is only really needed for iov_iter_revert() and
> could be dispensed with if struct iov_iter contained the head information
> as well as the current point.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D3

