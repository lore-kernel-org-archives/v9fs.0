Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079541;
	b=eses3xb7DoPXe00YrJlpXlyDYRQ5g1+95i3e7cXOKzVgjWCqeCi8xJqQtvT8ht2GB02Y
	 0MG31VTZdUMeylTieuwBaPBVyVw+OOloKjhCMURVDrIXGGwiiuxexMwJ7eXIfVydv6JEk
	 qa6l+dLR/hLYo0rFXNgVM+nHZIRB5N4oo4wVlmiHUm78FM4rf9kxDKJvDcMZhhRdRXQY8
	 7ZtAQlk3zShtgLracLca1gleRvWF7mck0ME5jMwWLnNQCANs/TmLS1GkYgzaOSJ5F8PAB
	 iheOeyMw3sH9k4QOCApCOevJGk196NYHuXOD5wwesms4E6IlR9d2mBqIQhL8HTJc+Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079541;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gZc3mAGDzFKLcolxwcmc6s6wid/PprViqoMa1baF7J8=;
	b=NwDkTFtSDWWtR4TSe5iM1naTDRtyB/AVvolViFYwRbULG0m+NNW1swxSC3nZ6BbWDRBF
	 Kz8QeofG8Mt7u7bkPr/1bTD0wGmlPNB/GyEpaTt6I448Ft6xweIIp+rN35GMNtgGxhSnp
	 CD8/u16LjbEUjJdH9x1oPnLCL/+kCKKYeD2mww8AbLMk0/THWjm5aSTSPsu7YGD6GFISs
	 5sZIqc1yj+3n1W5xJycpEOz6HAc5dPJE0xywaK7z3piRqeGUJCe2SPPepr76KUv5T5Lu/
	 4oy45pzMNK41uFH5bFXgq74CDewyK2+jegCs1i9MKR7BjO+9SB4CgnxvsdIgdGamklQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX7d6+N6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E8606A32C
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX7d6+N6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE79C1F0089F;
	Sat,  7 Nov 2026 19:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794079541;
	bh=gZc3mAGDzFKLcolxwcmc6s6wid/PprViqoMa1baF7J8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aX7d6+N6Lm6lT95DfDHP+zjvkcLTVZRHrHl4WmjJmCwbks37hvE4El/kU9v3HUdTN
	 kQFPf6xR2ZKTzhE00nUKq34HMMecQQZ+rurTxioYFLdoJ5gOA91z8RCFQmcUv1vxcI
	 xA8qsVLhHsMxxhu33Rv3L2SZpEMGwtrrcLvuHyn3zFFj82n0kVh4oZatfMB9mGWfpY
	 CiWnhgWjYemeYJcrWGUvNCTZ/WCkBgty1xhwRHrq75+EjZ70JOYbvOGUdT18pU7FIS
	 SXz7X/+ZJwHKBpfQTfKm9lCpiIHs7hj6V37HtHsUXiHGY6U8LxPpxH6X5hRNN/OKoV
	 7j7uHa8RzinVA==
Message-ID: <sashiko-outbox-203207@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 12/15] netfs: Switch folioq to bvecq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261107160823.1465553-13-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-13-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 19:25:40 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Critical] netfs: use-after-free on bvecq boundary in
  netfs_read_to_pagecache()
- [High] netfs: use-after-free in netfs_reset_iter() on subrequest retry
--

commit 5744e4078be45f40cce041679e9567cd02a0f062
Author: David Howells <dhowells@redhat.com>

netfs: Switch folioq to bvecq

This commit switches netfslib's rolling_buffer and buffered read/writeback
paths from folio_queue to bvecq.

> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 69e68ef0652a7..61b44af6774b7 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -215,7 +215,7 @@ static void netfs_issue_read(struct netfs_io_request =
*rreq,
>   * otherwise we set the deprecated PG_private_2.
>   */
>  static void netfs_mark_copy_to_cache(struct netfs_io_request *rreq,
> -				     struct folio_queue **fq,
> +				     struct bvecq **bq,
>  				     unsigned int *offset,
>  				     int *slot,
>  				     size_t len,
> @@ -225,21 +225,21 @@ static void netfs_mark_copy_to_cache(struct netfs_i=
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
> @@ -275,7 +275,7 @@ static void netfs_read_to_pagecache(struct netfs_io_r=
equest *rreq)
>  		.cached_to[1]	=3D ULLONG_MAX,
>  	};
>  	struct fscache_occupancy *occ =3D &_occ;
> -	struct folio_queue *fq =3D rreq->buffer.tail;
> +	struct bvecq *bq =3D rreq->buffer.tail;
>  	unsigned int offset =3D 0;
>  	ssize_t size =3D rreq->len;
>  	uoff_t start =3D rreq->start;
> @@ -408,10 +408,10 @@ static void netfs_read_to_pagecache(struct netfs_io=
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
Can a subrequest ending at a bvecq boundary leave rreq->buffer.iter and bq
pointing at a spent bvecq that gets freed before the next subrequest steps
to bq->next?

In netfs_readahead(), rolling_buffer_bulk_load_from_ra() builds a multi-bve=
cq
chain (bq0 -> bq1 -> ...) upfront with refcount 1 on each segment.  Unlike
iov_iter_folioq_advance(), which stepped to folioq->next as soon as slot hit
folioq_nr_slots(), iov_iter_bvecq_advance() only steps to bq->next at the t=
op
of its do-while (by) loop:

lib/iov_iter.c:iov_iter_bvecq_advance() {
	...
	do {
		if (slot >=3D bq->nr_slots) {
			if (!bq->next)
				break;
			bq =3D bq->next;
			slot =3D 0;
			continue;
		}
		...
		by -=3D len;
		slot++;
	} while (by);
}

netfs_mark_copy_to_cache() does the same in its while (len > 0) loop.  When=
 a
subrequest ends at the end of bq0, both rreq->buffer.iter.bvecq and bq are
left pointing at bq0 with slot =3D=3D bq0->nr_slots, and the next subreques=
t's
subreq->io_iter copies rreq->buffer.iter before advancing:

CPU0 (issuer)                     CPU1 (collector)
netfs_read_to_pagecache()
  subreq1 covers all of bq0
  netfs_prepare_read_iterator(subreq1)
    rolling_buffer_advance()
      /* iter.bvecq =3D=3D bq0,
         bvecq_slot =3D=3D bq0->nr_slots */
  netfs_mark_copy_to_cache()
    /* bq =3D=3D bq0,
       slot =3D=3D bq0->nr_slots */
  netfs_issue_read(subreq1)
  netfs_maybe_bulk_drop_ra_refs()
                                  netfs_read_unlock_folios()
                                    rolling_buffer_delete_spent()
                                      bq0->next =3D NULL;
                                      bvecq_put(bq0);  <-- frees bq0
  subreq2 prepared for bq1:
  netfs_prepare_read_iterator(subreq2)
    netfs_limit_bvecq(&rreq->buffer.iter)
      bvecq_next(bq0)             <-- use-after-free, sees NULL
  netfs_mark_copy_to_cache(&bq)
    bvecq_next(bq0)               <-- use-after-free, sees NULL

The same happens on a single CPU when subreq1 is NETFS_FILL_WITH_ZEROES and
completes synchronously inside netfs_issue_read().  Once bq0 is freed and i=
ts
next pointer is cleared, subreq2's iterator is truncated to 0 bytes and the
remaining folios in bq1 are never populated or unlocked.

> diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
> index 4347c99452d83..76cede046dcb7 100644
> --- a/fs/netfs/rolling_buffer.c
> +++ b/fs/netfs/rolling_buffer.c

[ ... ]

> @@ -205,44 +205,23 @@ ssize_t rolling_buffer_append(struct rolling_buffer=
 *roll, struct folio *folio,
>   * don't return the last buffer to keep the pointers independent, but re=
turn
>   * NULL instead.
>   */
> -struct folio_queue *rolling_buffer_delete_spent(struct rolling_buffer *r=
oll)
> +struct bvecq *rolling_buffer_delete_spent(struct rolling_buffer *roll)
>  {
> -	struct folio_queue *spent =3D roll->tail, *next =3D READ_ONCE(spent->ne=
xt);
> +	struct bvecq *spent =3D roll->tail, *next =3D bvecq_next(spent);
> =20
>  	if (!next)
>  		return NULL;
>  	next->prev =3D NULL;
> -	netfs_folioq_free(spent, netfs_trace_folioq_delete);
>  	roll->tail =3D next;
> +	spent->next =3D NULL;
> +	bvecq_put(spent);
>  	return next;
>  }

[Severity: High]
Does freeing spent bvecq segments during collection cause a use-after-free =
in
netfs_reset_iter() when a subrequest spanning multiple bvecq segments is
retried?

subreq->io_iter is initialized from rreq->buffer.iter (or wreq->buffer.iter)
without taking a reference on its starting bvecq segment (bq0).  If a
subrequest spans bq0 and bq1, transfers enough data to finish bq0, and then
fails with NETFS_SREQ_NEED_RETRY, both netfs_collect_read_results() and
netfs_collect_write_results() unlock the completed folios in bq0 before
entering the retry path:

fs/netfs/write_collect.c:netfs_collect_write_results() {
	...
	if (notes & NEED_UNLOCK) {
		if (wreq->cleaned_to < wreq->collected_to)
			netfs_writeback_unlock_folios(wreq, &notes);
	} else {
		wreq->cleaned_to =3D wreq->collected_to;
	}

	// TODO: Discard encryption buffers

	if (notes & NEED_RETRY)
		goto need_retry;
	...
}

netfs_writeback_unlock_folios() (and netfs_read_unlock_folios() on the read
side) calls rolling_buffer_delete_spent(), which clears bq0->next =3D NULL =
and
frees bq0.  When netfs_retry_writes() or netfs_retry_reads() then calls
netfs_reset_iter(subreq) -> iov_iter_advance(&subreq->io_iter, ...),
iov_iter_bvecq_advance() dereferences the freed bq0 from subreq->io_iter.bv=
ecq
and cannot advance to bq1 because bq0->next was cleared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D12
