Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936749;
	b=ReaV6B0HeU7+uQWD6YJZnQHJ1ogyHoFv6Ff7VaJeH0tl/FzaSyQYIjyNJccT0qpJ3WMH
	 fIFkusnbJjvQclEhEaCR5fBVaXy82hCRZEHcSgxMGp2efaJrt+Wv6z6jUXnDM79/S9164
	 UVPykJR5Ys5iXwKRKKtCMnezAU1Y191pSiz31SP8Nz2idD6i5TfU3Oz9J/XGNO23qusCJ
	 mYbRaz1OvoLgqxti2/mgQ1YUcCfWUn0A9qt4HNs7GsyASXRBLs55MV6Npf3qXO/B7QzUt
	 Fcul+bq4QyO6J9Gfs5wH1agzn27YXBBm7C3uFRBg89NV400GMAOsoIQePVtnGPDyMBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936749;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e/M/3QJQ8Hd0ILJlWvG6m5GpsfA7VfGi+S9hOg4PL4s=;
	b=rWsM9zPU74NftYfy/BnrxepvT6xzrCc3yg5Z/m+79S2fUMO7xCduy6dOwLv75Aa60QmZ
	 96b/z+hOumiEIRpnUvAtFAHoQYPAy5vZi9KdkxFFtqyDKVBKOo/IQoybE2U1miXEWzOu9
	 cAn1JStjoiDjCTzTrsQ11LgxhZbGYmKfZdgze5sOVhx7djqEPzb6jVpWJ6dgwaR1N/iyQ
	 hqPnuNartNw8crqXraywBUHG+Uio/u1SgRoBxsJg8nQCYWwaTKOuQN+xU6qdp/HytJHRX
	 3IZ3JrInXnx7L63vXXvVj7osJb0AlU4UtOSbCMY+cr6R1wFuVD2/mkeUq8lSf6Y81Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zq8W55AK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBA606A32A
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zq8W55AK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D861F000C5;
	Tue, 17 Nov 2026 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936748;
	bh=e/M/3QJQ8Hd0ILJlWvG6m5GpsfA7VfGi+S9hOg4PL4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zq8W55AKh1qsPN1derLNnjfgzrNn5pXM/x1uJeolstq3RtxAIhpnfysUYI+GRk/w6
	 iujf5gQjEDUzVqMvc/kgz5sn6HQWWX3B/T1ASG2f6v9VF5QSegJMVodoCh0hg8DGlw
	 MN0eWGDbRU9i9CdzM49kNAJde3aataqDLvj/WPFrzuOJ2PCJS6vmA6ovtqeTjJ2/lM
	 +Fja20pT1gFa8Wg5TKkFsKHg5bJwNvghkkQG7efw47BO+O5lQm9WOHfKRj0VeEFiOR
	 KzcYNLujmekpu+3AoJPsdaKFM76LSJ/bahuUnYfkbICUkq3Ws8q5w5G0QqjIyNlcKw
	 tAlPTV5faRfPw==
Message-ID: <sashiko-outbox-219239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 05/17] iov_iter: Add an API document for the bvecq
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117171958.2982801-6-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-6-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:32:28 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] docs: bvecq: unescaped *flags and *%flags in fs/netfs/bvecq.c
  kernel-doc
--

commit 3238a6429ad4d02946dab8199e3c3a6af909c86a
Author: David Howells <dhowells@redhat.com>

iov_iter: Add an API document for the bvecq structure

This commit adds an API description document for the bvecq structure and
wires it into the core-api documentation and MAINTAINERS.

> diff --git a/Documentation/core-api/bvecq.rst b/Documentation/core-api/bv=
ecq.rst
> new file mode 100644
> index 0000000000000..b2896992b2843
> --- /dev/null
> +++ b/Documentation/core-api/bvecq.rst
[ ... ]
> +API Function Reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/linux/bvecq.h
> +.. kernel-doc:: fs/netfs/bvecq.c

[Severity: Low]
Does including fs/netfs/bvecq.c via kernel-doc trigger Sphinx inline
emphasis warnings during htmldocs builds?

The kernel-doc comments in fs/netfs/bvecq.c write *flags in the Return
sections of bvecq_alloc_one(), bvecq_alloc_chain() and
bvecq_alloc_buffer2(), and *%flags in bvecq_alloc_chain():

fs/netfs/bvecq.c:bvecq_alloc_chain() {
    ...
 * Allocate a chain of bvecq nodes providing at least the requested cumulat=
ive
 * number of slots.  Each node is a maximum of 4KiB in size.  If
 * %BVECQ_SHORT_OKAY is set in *%flags, then the chain may be shortened on =
OOM.
 *
 * Return: The first node pointer or NULL on allocation failure.  BVECQ_HIT=
_OOM
 * is set in *flags if an allocation failure occurs.
    ...
}

Unlike *@flags (which kernel-doc converts into bold parameter markup),
bare *flags and *%flags leave unmatched leading asterisks in the generated
ReST output.  Using *@flags in those four places avoids the docutils
warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D5
