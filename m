Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939581;
	b=YW+BTIh4OE5O0iJ6Cwr/aE4EilsS6EyaUOQIXrrlzHcZgWHK+riEp95KbassBNKsSxGB
	 XRfEilgCBadpt/FYMRW5D7A8O5KTNc5kwejpcSpOUjyt/WGhLx/qHhsMhCL+wFTpEdFch
	 A5G37yy6I2GmEwRJWJaw7LiBpCroiLrlD8G4HsfUq1aG2F9GAvt9lV8Mg5sMz8/+CpAcl
	 d7arNES4cKKCtMXBiNVvVjOeECGOfCpH6c8Bj5gnqmuswOoSJAie9Lp7UTwOZtE3AN6YA
	 J1+SE/IP7RWWrH8Tfj3uvBhG9RgzQmZH8ZKa2QAi3koUD5t1BhdC3os+Z5i0F5iWnTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sz7Yp3pdVtfl1pusx2vs0OzFLbvsRMAl+9oemyBPz1o=;
	b=ecHhQjfmWIZMAJ6e7pwp5Gs6hg/bdPxdVHch0y3mH8VB2dvUXkHR8lLfzE9ALPRGzQW7
	 wuCTrcj+HRbO7Hsj9Z3NeggF1V+f16fmLDue1FMWjhK2JaEP+BCh/GmONTxYFOJZGGWaK
	 sB2ap4et29A8tCyQn6Y1JB5DEgsO1GZAWSCPQ8XSijqfT+FXnBQrwZ/DWG1uFJg8JiVwQ
	 79etcQDDY7SCoAhNiEgEyhjP24yNw98AbFI3GYtjg8J/y/+lxnKXcoQdLsvJ5KztAFZv1
	 TXg3jJKqsMcZt3klGQPTLlWq2YGujaQz5vOh4jRyNOCt3P1xmanRm03okRODGtfrUBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmPQ2BWt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42158606A31C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmPQ2BWt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55111F000C4;
	Tue, 17 Nov 2026 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794939581;
	bh=sz7Yp3pdVtfl1pusx2vs0OzFLbvsRMAl+9oemyBPz1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OmPQ2BWtZZPWMaFPSkMXktzvR4hmX+1hQ4cVzdO1lm1HYlfJ8xqf4FljimkDfLEHa
	 reov+URg/r0w9QCB3TVx4U6q3rNxjqv53x3yECh+5KBVwnto+CNqMa4Qq0llEySLE6
	 PbdigshczGlg3aSvNQ+ndFgN3Vjq5kGKdaEAtHJnYrznSIRxApzPSWzD08yktEEWJV
	 IT+H8+jkvwlr23rLkx7pEGdjDVfyCTN4XeNHDCU2f3SOpM6pZ67DkZImx/LHuqtPen
	 VgAPJXnKB7svsxveIRqtbHG+2puJPEK8hdDF+X+gaOV/4pEIDwb6oaXweaWe5Vx6ZH
	 j9uKtBBrhsZqw==
Message-ID: <sashiko-outbox-219329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 14/17] netfs: Switch folioq to bvecq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117171958.2982801-15-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-15-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:19:40 +0000
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
- [Critical] netfs: use-after-free of bvecq in
  netfs_mark_copy_to_cache()
--

commit 834caa148591ab97e4e6988fdeca3a919acba1a9
Author: David Howells <dhowells@redhat.com>

netfs: Switch folioq to bvecq

This commit switches netfslib's rolling buffer and buffered read/writeback
paths from folio_queue to bvecq.

> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 69e68ef0652a7..c6c850ffd56ea 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
[ ... ]
> @@ -215,7 +217,7 @@ static void netfs_issue_read(struct netfs_io_request =
*rreq,
>   * otherwise we set the deprecated PG_private_2.
>   */
>  static void netfs_mark_copy_to_cache(struct netfs_io_request *rreq,
> -				     struct folio_queue **fq,
> +				     struct bvecq **bq,
>  				     unsigned int *offset,
>  				     int *slot,
>  				     size_t len,
> @@ -225,21 +227,21 @@ static void netfs_mark_copy_to_cache(struct netfs_i=
o_request *rreq,
>  		struct folio *folio;
>  		size_t fsize, overlap;
> =20
> -		if (!*fq)
> +		if (!*bq)
>  			break;
> -		if (*slot >=3D folioq_count(*fq)) {
> -			*fq =3D (*fq)->next;
> +		if (!bvecq_acquire_slot(*bq, *slot)) {
> +			*bq =3D bvecq_next(*bq);
>  			*slot =3D 0;
>  			*offset =3D 0;
>  			continue;
>  		}
> =20
>  		/* Determine how much the subreq overlaps the folio, if at all. */
> -		fsize =3D folioq_folio_size(*fq, *slot);
> +		fsize =3D (*bq)->bv[*slot].bv_len;
>  		overlap =3D min(len, fsize - *offset);
> =20
>  		if (overlap > 0 && copy) {
> -			folio =3D folioq_folio(*fq, *slot);
> +			folio =3D bvec_folio(&(*bq)->bv[*slot]);
>  			if (netfs_using_pgpriv2(rreq)) {
>  				if (!folio_test_private_2(folio))
>  					folio_start_private_2(folio);
> @@ -275,7 +277,7 @@ static void netfs_read_to_pagecache(struct netfs_io_r=
equest *rreq)
>  		.cached_to[1]	=3D ULLONG_MAX,
>  	};
>  	struct fscache_occupancy *occ =3D &_occ;
> -	struct folio_queue *fq =3D rreq->buffer.tail;
> +	struct bvecq *bq =3D rreq->buffer.tail;
>  	unsigned int offset =3D 0;
>  	ssize_t size =3D rreq->len;
>  	uoff_t start =3D rreq->start;
> @@ -408,10 +410,10 @@ static void netfs_read_to_pagecache(struct netfs_io=
_request *rreq)
>  		if (size <=3D 0)
>  			netfs_all_subreqs_queued(rreq);
> =20
> -		if (fq) {
> +		if (bq) {
>  			/* See if the cache indicated this should be cached. */
>  			copy =3D test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
> -			netfs_mark_copy_to_cache(rreq, &fq, &slot, &offset, slice, copy);
> +			netfs_mark_copy_to_cache(rreq, &bq, &slot, &offset, slice, copy);
>  		}
> =20
>  		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);

[Severity: Critical]
Can netfs_mark_copy_to_cache() dereference a freed bvecq across subrequest
iterations?

netfs_read_to_pagecache() keeps an unreferenced pointer in bq.  When a
subrequest ends at the last slot of a bvecq (bq0),
netfs_prepare_read_iterator() -> rolling_buffer_advance() advances
rreq->buffer.iter.bvecq to bq1, so the next subrequest pins bq1 rather
than bq0.  However, netfs_mark_copy_to_cache() only checks
!bvecq_acquire_slot(*bq, *slot) at the top of the while (len > 0) loop, so
when len reaches 0 at the end of bq0, bq is left pointing to the exhausted
bq0 with slot =3D=3D bq0->nr_slots:

CPU0 (issuer)                     CPU1 (collector)
netfs_read_to_pagecache()
  /* subreq N ends at end of bq0 */
  netfs_prepare_read_iterator()
    /* advances rreq->buffer.iter to bq1 */
  netfs_mark_copy_to_cache()
    /* slot =3D=3D bq0->nr_slots, bq =3D=3D bq0 */
  netfs_issue_read()
                                  netfs_collect_read_results()
                                    netfs_read_unlock_folios()
                                      rolling_buffer_delete_spent()
                                        bvecq_put(bq0)
                                    netfs_put_subrequest()
                                      netfs_free_subrequest()
                                        bvecq_put(bq0)  /* frees bq0 */
  /* subreq N+1 pins bq1 */
  netfs_mark_copy_to_cache()
    bvecq_acquire_slot(bq0, slot)  <-- use-after-free
    bvecq_next(bq0)                <-- use-after-free

The same happens on a single CPU if subreq N completes synchronously (such
as NETFS_FILL_WITH_ZEROES).  Pinning bq with bvecq_get() in
netfs_read_to_pagecache() and updating that reference as bq advances would
prevent bq0 from being freed before netfs_mark_copy_to_cache() steps to
bq1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D14
