Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938166;
	b=TCFRwkLP5CmG9QQfwVgmNhgT3rFtox6XMgy30iqYMXOcrvNydlTrWAlwylY+rS1Q6RtP
	 1pJ3s7VvwQfxPDt8K00+4xuQU7k9VwP6CpAiYvmhzxnHjBWLGXvHvXERQWhBxlN4kI3XR
	 os+62xxxAEN4n+3V6KmPol5nvhiEI9DoLgCoDHJ6up/AKewPPuFYdVYBhSbV2Nf2VG1Ne
	 Zsra7e0+IuGbi4yRUGRZHXwYLGO+xXhbkYL5XWdmZbdwT+tx3ovl06VLyij/dygsH2bfd
	 /o4qBEBQEzEgs7JkEAZrFNR70P9RLxQsfB1NgJBl8rkGXt6/bBnBNqMLflqyZC0aoVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938166;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WDf70lb6gxH2ADgCLLBBsUAADzFlgUFg+4QbktwZoj8=;
	b=cf7rnRxELxF3Mdw3wRjZtsd5GFCGb+tThIiKE+x+rqm+M/CR4TzlZO4dBMKlBingAnSH
	 wcq0wjOFWKns8hZ6nD+FIZGedKmRSK5ZiqEuWx+QWYLddv5PbUs895AZLfNo/KC3YIHIQ
	 0YDblcyhVFgpkgtoMQ88yxY0qzjokIfTZwIXLysE6jfk0tjNKGpUdflVeLbp/4lqbso4r
	 Y6N/mFOeC0LnATSRCeUzEKTadumdQKLEZoiY49WlzFfBX6td3olH3hdYcGOuaKviVN05/
	 ECugm+NM632YktCcRR4rTCMaLM7bhaWm77EdCzSyCRNvz8asUS8lZ6PuhcZY0v+GReA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5vPNAh6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E35606A331
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5vPNAh6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709DD1F000C7;
	Tue, 17 Nov 2026 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938166;
	bh=WDf70lb6gxH2ADgCLLBBsUAADzFlgUFg+4QbktwZoj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z5vPNAh6TlAr6OqBcGaF2y3OG3hEYP0BiAOjUCWPNhUfo0z1+NrEGdafaRc7FfclS
	 TWkK2VxxLmsxIoYZVtZ1UiED3IDUSjfpVq8PFmUCrEAhu++ydtF28cMkzByZSZCdt0
	 Ce8N/5LPRHJc8BZCVuDdtiecS5W8TqlQCG5ISIv1uSZiSScS3XFdhu7JEeqIt1P2fI
	 MAcOqBAuh1EL5QY6vUAw2Qh7n3jCSjXN0h7MMlcC5xChi/dSe/LGSNRXbmF+GYUZ8U
	 eRLQdi0Qgm2LgKT2nH7pCEwoPEskYcuVA0xe5zscujwlUVC8ywsDluWVbgTwX9H9y2
	 NBVNfBh+aMpgg==
Message-ID: <sashiko-outbox-219294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 03/17] iov_iter: Add a segmented queue of bio_vec[]
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-4-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-4-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:56:06 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D3

