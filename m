Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078390;
	b=KQJXfjJCEMlNuvb2uSc/RzylTlkT6BwjIc0Jd5nIN8R2pWA5eavmPQFgy4e4eFHHs0dj
	 yQxxZxR9On4XbdTondI8WhXlowsbOhKNRLAiOdNNOAT+Frz31a2PwO0ZGdfFnQBpk/AJt
	 qvSKWLs7R8iPWHfM75efbQ5GVTbiRV0MrZpX2DsIYWuhax9h6Li5xZIU1pkzxtaUzlJUL
	 JvA4ZbKq3rUZy/5o4NWHY5hnOtk3lhSEUwIvBjP2QOOm82TkXlt3MdNP7G0wI5TCLLkch
	 VLMPe7qtom5YxFZfDR9AUj8Jylg+Jydbc7gal4IFyGMzf+0FwrBnN4oPWxvfR0zPvOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078390;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L/v6upENLqWKVODY9CXdlpCWs7vFmC0HzkXvbYLmAv4=;
	b=0Kgqm+jm/IGyz3k8KtAgY4vtV/MgLMTVXkhiMPiDNyq3d0LskKWIeB3TEDmvKjBQL1H9
	 QPP3+4Qg1TNgKpTc22Tp33xA8GqflXQKrw4qYJMAjPFKvUTfQpQwtOgODgO4hLO2jXTzt
	 tK3gu2ReljmpaFwlbNBJ0NlWMMdOOpZg6aImJP6/ocIt4n91etyz/TGdLHdQG859Gdvyf
	 rxWLndENHkOD63TDOmNhRJQ89qnsByAZ+wSAikpYM4EjYN8CRs2Sr9FBmkBPi8vi21o5r
	 cH1o/UtRBSPHD5/IjpbIiPhYq/JN3GglrR3l9tRtSqPb0Icu0HQtIFKv1QEYb97AQVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=im8NDxwT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90552606A320
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=im8NDxwT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2458D1F000C4;
	Thu, 19 Nov 2026 08:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078390;
	bh=L/v6upENLqWKVODY9CXdlpCWs7vFmC0HzkXvbYLmAv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=im8NDxwTBXdSBXgBLFUqlVhI3vg1HU0OLlGnrDslhnIbejZptCoAqGXNIg6MklTah
	 +4wkR8btTgUPVnL5mwXr4+32DG1rFtF8dA7wQ773KWQVVT0B0B8YypXIb00ab+NXDI
	 YkatAKHss8BGZ6eCPdOPXO3zX8xOP706XViu3ibxOIvGxn6eBOZaOG80+DmjlV9YE6
	 9zhQ3/ab02xKVjH8JQH6vF0zXELWjZUeHOk1d1M2ZLUhMf12lVyW+qcefdwzkx3bCa
	 WfQt4e1pBcEtbJrok26HTis5GqVQ4abERJbG8V+SJvbcapxL95U5zCbd22lCm0OSGk
	 K9lI2sqnWa1bw==
Message-ID: <sashiko-outbox-222734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 05/17] iov_iter: Add an API document for the bvecq
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261119083851.3306418-6-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-6-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:53:09 +0000
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
- [Low] docs: bvecq: malformed kernel-doc markup in bvecq.c and bvecq.h
--

commit 4351a64f55127d5c3a801238a9cedf6a1d7b17ac
Author: David Howells <dhowells@redhat.com>

iov_iter: Add an API document for the bvecq structure

This commit adds Documentation/core-api/bvecq.rst documenting the bvecq
structure and its API, and links it into the core-api index and
MAINTAINERS.

> diff --git a/Documentation/core-api/bvecq.rst b/Documentation/core-api/bv=
ecq.rst
> new file mode 100644
> index 0000000000000..7e06ca81512ab
> --- /dev/null
> +++ b/Documentation/core-api/bvecq.rst
[ ... ]
> +API Function Reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/linux/bvecq.h
> +.. kernel-doc:: fs/netfs/bvecq.c

[Severity: Low]
Pulling these two files into the documentation build exposes a few
kernel-doc issues in the comments introduced earlier in the series.

In fs/netfs/bvecq.c, the kernel-doc comments for bvecq_alloc_one(),
bvecq_alloc_chain() and bvecq_alloc_buffer2() write *flags and *%flags
instead of *@flags, which leaves unmatched single asterisks in the
generated reStructuredText and triggers docutils inline emphasis warnings
during make htmldocs:

fs/netfs/bvecq.c:bvecq_alloc_chain()
 * Allocate a chain of bvecq nodes providing at least the requested cumulat=
ive
 * number of slots.  Each node is a maximum of 4KiB in size.  If
 * %BVECQ_SHORT_OKAY is set in *%flags, then the chain may be shortened on =
OOM.
 *
 * Return: The first node pointer or NULL on allocation failure.  BVECQ_HIT=
_OOM
 * is set in *flags if an allocation failure occurs.

Also, in include/linux/bvecq.h, the kernel-doc summary line for
bvecq_append() appears to be copy-pasted from bvecq_next():

include/linux/bvecq.h:bvecq_append()
/**
 * bvecq_append - Get the next bvecq with appropriate barrier
 * @to: The bvecq to append to
 * @add: The bvecq to append

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D5
