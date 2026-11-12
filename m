Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445408;
	b=2dJ4663MJohzhpzmb+ZLerv+50hTBVNBUCYDONF/DflEDVpk9n1ZzSb2Zm30orICJHsi
	 kBLzixEH2H2gdeN/BBGireZiDN1XTy9Km9cdJb8mksK8DsntGj6WZLG+cjaDqF40XWA2N
	 KG4w8Mv0gKHVNV5GTmS4TsUuUxCo3jvOsq/XhWy1eXs4yR94mTSlRPMwigoWjBfHzmr1M
	 svj1aZ7n/Gjt/QoXtSXXV9yQT84vSe86HTdT3eQtWHv+xq+erBL8EmrovmiHF/6vToCQs
	 Ez3lRhYD5Cvc3PlX4Wtq3b7KQCnhDR6pyZ4BAtyYftzC/lBwJE5xFdMrimruRs6Q0mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445408;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=521kRB5ll/heKoGL0W0jC5X0Hv+lpjnJaTp3H/DZRNI=;
	b=te3fjQX388uJoeR13EbzN/DdvnmTb0Kny5On2KhK30dbuwh+i7p3xfR+dkNwhBBIEeip
	 qa3cOdLVEL/nnIucIgUhK+mlhcS7DbipQhYC7szAl6As2L/IlHwDMK+CSqBQ4WVVR0Rfi
	 sb+jZwYMjuQm226wk3tHMlH6ti107sKUyCX4cx5byU05rJaEDmqEjUlZBppqakpfOkXsC
	 O1AO/hNv/M/n4CScXXQg6xiy1uQS5w2SXeiG3iZW+g/UxAW28+0wjK8dHC7ttL+Y8MP88
	 Hel0UqHP0m6VO2yhYsq5JSfk9hXmycOOyemtRF6shTPZaXhXeS1ogb0boMk9bILwlXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMoJNn6r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF7606A321
	for <v9fs@lists.linux.dev>; Thu, 12 Nov 2026 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMoJNn6r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC101F00A06;
	Thu, 12 Nov 2026 01:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445408;
	bh=521kRB5ll/heKoGL0W0jC5X0Hv+lpjnJaTp3H/DZRNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMoJNn6rVpiHY3EOdCbBW+yw4XtQgd3x79/mbUlRbnGW1lIXl80zCU7Hh7jQ9pUjt
	 NP4+8sukwkmWbroFT+Eu9bkMXRJr9lF435MyARWH4yNjMuzvzmpdR6hzR4jRbu/JNN
	 EynlEm/YYgzpUVUoAKq4Fj0gE37snO+npMpPVLLlzAehXa38V3+sbEtvUA8pYyJyOH
	 Npw4S5M/sp/Uy9ddzCoDiDWoSL9sc8i2HmhfRF2fhG9pAA+KBJ1xMGFXETmJ+vQtP6
	 U4sg8OsR1bY65aAme6JDPD+D717y6BYalZ7IAJk05jMSziXTM/Df05NxP8fl0bvVAs
	 UHTihch4lQz/g==
Message-ID: <sashiko-outbox-210029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 14/17] netfs: Switch folioq to bvecq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261111203034.2126314-15-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-15-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:03:27 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Critical] netfs: use-after-free on spent bvecq in
  netfs_read_to_pagecache()
- [High] netfs: premature bvecq deletion race in folio unlock functions
- [Low] netfs: commit message mismatch for rolling_buffer_delete_spent()
--

commit e56d7d03f56d46856c2af8166a341d7fbaef3849
Author: David Howells <dhowells@redhat.com>

netfs: Switch folioq to bvecq

This commit switches netfslib's rolling buffer and buffered read/writeback
paths from folio_queue to bvecq and pins bvecq segments on subrequests acro=
ss
retries.

>      (6) rolling_buffer_delete_spent() has to clear the bvecq->next point=
er
>          before putting the bvecq to avoid rolling up the entire list.  O=
n the
>          other hand, rolling_buffer_clear() just needs to put the tail.

[Severity: Low]
Does this description match rolling_buffer_delete_spent()?  Rather than
clearing spent->next, rolling_buffer_delete_spent() clears next->prev and
takes a reference on next via bvecq_get(next) before calling
bvecq_put(spent), leaving spent->next intact for subrequests pinning spent.

> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 69e68ef0652a7..c6c850ffd56ea 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -131,6 +131,8 @@ static ssize_t netfs_prepare_read_iterator(struct net=
fs_io_subrequest *subreq)
>  	}
> =20
>  	subreq->io_iter	=3D rreq->buffer.iter;
> +	if (iov_iter_is_bvecq(&subreq->io_iter))
> +		subreq->bvecq_pin =3D bvecq_get((struct bvecq *)subreq->io_iter.bvecq);
> =20
>  	iov_iter_truncate(&subreq->io_iter, subreq->len);
>  	rolling_buffer_advance(&rreq->buffer, subreq->len);
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

[ ... ]

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
Can rreq->buffer.iter.bvecq and the local bq pointer in
netfs_read_to_pagecache() be used after free when a read subrequest ends at=
 a
bvecq segment boundary?

During readahead, rolling_buffer_bulk_load_from_ra() pre-populates the chain
of bvecq segments (bq0 -> bq1 -> ...), where rreq->buffer.tail holds a
reference on bq0 and bq0->next holds a reference on bq1, while neither
rreq->buffer.iter.bvecq nor bq in netfs_read_to_pagecache() holds a
reference.

Unlike iov_iter_folioq_advance(), iov_iter_bvecq_advance() only advances to
bq->next at the top of its loop:

lib/iov_iter.c:iov_iter_bvecq_advance() {
    ...
		if (slot >=3D bq->nr_slots) {
			if (!bq->next)
				break;
			bq =3D bq->next;
			slot =3D 0;
			continue;
		}

		len =3D bq->bv[slot].bv_len;

		if (likely(by < len))
			break;
		by -=3D len;
		slot++;
	} while (by);
    ...
}

When a subrequest ends at the end of the last slot in bq0, both
rolling_buffer_advance() and netfs_mark_copy_to_cache() stop as soon as the
remaining length reaches 0, leaving rreq->buffer.iter.bvecq and bq pointing
to the exhausted bq0 at slot =3D=3D bq0->nr_slots:

CPU0 (issuer)                     CPU1 (collector)
netfs_read_to_pagecache()
  netfs_prepare_read_iterator(sreq0)
    sreq0->bvecq_pin =3D bvecq_get(bq0)
    rolling_buffer_advance()
      /* leaves iter.bvecq =3D=3D bq0,
         bvecq_slot =3D=3D bq0->nr_slots */
  netfs_mark_copy_to_cache(&bq, ...)
    /* leaves bq =3D=3D bq0,
       slot =3D=3D bq0->nr_slots */
  netfs_issue_read(rreq, sreq0)
  netfs_maybe_bulk_drop_ra_refs()
                                  netfs_collect_read_results()
                                    netfs_read_unlock_folios()
                                      rolling_buffer_delete_spent()
                                        bvecq_put(bq0)
                                    netfs_put_subrequest(sreq0)
                                      bvecq_put(bq0)  <-- frees bq0
  /* next subrequest sreq1 */
  netfs_prepare_read_iterator(sreq1)
    bvecq_get(iter.bvecq)         <-- use-after-free on bq0
    rolling_buffer_advance()      <-- use-after-free on bq0
  netfs_mark_copy_to_cache(&bq)   <-- use-after-free on bq0

[ ... ]

> diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
> index 6e8ea534230df..91b42820c8925 100644
> --- a/fs/netfs/write_collect.c
> +++ b/fs/netfs/write_collect.c
> @@ -130,9 +130,9 @@ static void netfs_writeback_unlock_folios(struct netf=
s_io_request *wreq,
>  		return;
>  	}
> =20
> -	if (slot >=3D folioq_nr_slots(folioq)) {
> -		folioq =3D rolling_buffer_delete_spent(&wreq->buffer);
> -		if (!folioq)
> +	while (!bvecq_acquire_slot(bq, slot)) {
> +		bq =3D rolling_buffer_delete_spent(&wreq->buffer);
> +		if (!bq)
>  			return;
>  		slot =3D 0;
>  	}

[ ... ]

> @@ -166,15 +166,15 @@ static void netfs_writeback_unlock_folios(struct ne=
tfs_io_request *wreq,
>  		wreq->cleaned_to =3D fpos + fsize;
>  		*notes |=3D MADE_PROGRESS;
> =20
> -		/* Clean up the head folioq.  If we clear an entire folioq, then
> -		 * we can get rid of it provided it's not also the tail folioq
> +		/* Clean up the head bq.  If we clear an entire bq, then
> +		 * we can get rid of it provided it's not also the tail bq
>  		 * being filled by the issuer.
>  		 */
> -		folioq_clear(folioq, slot);
> +		bq->bv[slot].bv_page =3D NULL;
>  		slot++;
> -		if (slot >=3D folioq_nr_slots(folioq)) {
> -			folioq =3D rolling_buffer_delete_spent(&wreq->buffer);
> -			if (!folioq)
> +		while (!bvecq_acquire_slot(bq, slot)) {
> +			bq =3D rolling_buffer_delete_spent(&wreq->buffer);
> +			if (!bq)
>  				goto done;
>  			slot =3D 0;
>  		}
> =20
>  		if (fpos + fsize >=3D collected_to)
>  			break;
>  	}

[Severity: High]
Can this race with the producer and delete a partially-consumed bvecq segme=
nt,
leaving the remaining folios in that segment permanently locked or under
writeback?

Previously, rolling_buffer_delete_spent() was only called when
slot >=3D folioq_nr_slots(folioq), which tested the fixed capacity of the
segment.  Here, bvecq_acquire_slot(bq, slot) tests slot < bq->nr_slots, and
it runs immediately after slot++ before checking fpos + fsize >=3D collecte=
d_to.
Because the producer updates bq->nr_slots before setting bq->next, while the
collector reads bq->nr_slots before reading bq->next in
rolling_buffer_delete_spent(), the collector can delete bq0 while uncollect=
ed
folios remain in slots k..max_slots - 1:

CPU0 (producer)                   CPU1 (collector)
netfs_write_folio()               netfs_writeback_unlock_folios()
  /* bq0 has k slots filled */      /* unlocks slot k - 1 */
                                    slot++ /* slot =3D=3D k */
                                    bvecq_acquire_slot(bq0, k)
                                      /* sees nr_slots =3D=3D k, false */
  /* fills slots k..max_slots-1
     of bq0 */
  rolling_buffer_make_space()
    bvecq_append(bq0, bq1)
      bq0->next =3D bq1
                                    rolling_buffer_delete_spent()
                                      /* sees bq0->next =3D=3D bq1,
                                         deletes bq0! */
                                    slot =3D 0 /* on bq1 */
                                    /* slots k..max_slots-1 of bq0
                                       are skipped forever */

Those skipped folios in bq0 never have folio_end_writeback() called, hanging
writeback on the inode.  The same pattern is present in
netfs_pgpriv2_unlock_copied_folios() and netfs_read_unlock_folios().

Checking slot >=3D bq->max_slots (or checking slot >=3D bq->nr_slots only a=
fter
verifying bvecq_next(bq) is non-NULL with an acquire load) before calling
rolling_buffer_delete_spent() would avoid dropping a bvecq that still has
unprocessed slots.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D14
