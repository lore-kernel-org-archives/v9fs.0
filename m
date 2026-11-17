Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937919;
	b=jUTap31P+cJNLsmx/yekN2fmNimf2k/1RY5AEgwoQWP21oylnePmpkWEsFnZyGp0c5pE
	 SyMb2j9vdARRdb2T+0CfjyckuvZ/rCsi1YbtiYlGQCVP9UWenszEw6R4SPoChuFwJ5j+f
	 xMvz2Rin1MRMrFdFrENfNPHhU889yxBKElRLOg/DehjCuuZDXNoGhGdbee/uMP+Jib/yV
	 GRvKTAJLCW76n/NOOLhQAJXhAbe3BpkhvRPmsOJ7fnmbYCBOSjWaIEOFoCrCEE9iQgK8U
	 lV/lP6jtuXzZMOaiSQoQDBPsphu03Q12FXWELOo//c9iaDENYmxtp2x9eYJhI2BGR3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937919;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ydTnGjyesYZ/x6zPgzkdhW46SOaCgAIzeISNeRjwFEo=;
	b=A7UkCylrvzerjbvceHgdBzVCFRlHrFgf3Xypqbhyw8wr4FBh9BcSkFFdg4YLA+121WXu
	 Rfn73Msh0N7T36QS7vwb52g8tJfjizanTMfaugYhjwA6IvkrbUbWbq4itUvCq0MUk13ly
	 C5sDmaFNDG6zPW5QadaI1lfWm+KRTOb1Od5u8gKhXUY8Nq3jjp1ti3YV93UA8sOyGIxbc
	 pT74AGuiWAQAnSsrctCHPsqABnaN5oksBiN9rfOOZBFPw/abZsCFbDS9UKK7PgsIOxmVb
	 viigi6/0N1VTfjayuTDNjWBTybs0nNDWfdnRzha6WiUsy3wmwcjMNAProT9PRgpznnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjPQ6faz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148D606A31C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjPQ6faz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1701F000C4;
	Tue, 17 Nov 2026 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794937919;
	bh=ydTnGjyesYZ/x6zPgzkdhW46SOaCgAIzeISNeRjwFEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjPQ6fazyr5GGY1dgzguzvX46R5SOnXRPfcWZ58RT9DQUdhI/N7MguAOwLzkN9Xtt
	 2fr8mxlqB7dlYyFGt9Qqwg9cWXItEYtaUCNxp8uf9aBWTxzFYL/axENhAk4As1gaIA
	 NagW6Sw4TI+7AtY9F2z23pr+NZW4qcFhyEhzgmY+a443nk6OGs9Io1kcCxuBQpklog
	 8PEr8qY3EpTB6Dy0cd7dgfCa8mYf5afQrjobn7mYXQ1eU2JGU0cIxC0WLPR6przA+i
	 oMa4NJRYyhMbl3mhRcOMin3/7iEXvMyq7l4SEYVmr4uj7LrkMts6BnDvClB09SMTzm
	 DNoVdR67gHFDQ==
Message-ID: <sashiko-outbox-219277@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 04/17] netfs: Add some tools for managing bvecq
 chains
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117171958.2982801-5-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-5-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:51:59 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] netfs: dangling prev pointer in bvecq_put() when next node
  survives
- [Medium] netfs: bvecq_alloc_buffer2() returns empty bvecq on page
  alloc failure
- [Medium] netfs: bvecq_alloc_buffer2() stops page fill early on
  BVECQ_HIT_OOM
- [Medium] netfs: false OOM in bvecq_alloc_buffer2() when pre_slots
  fills first bvecq
- [Low] netfs: direct access to private struct semaphore count in
  netfs_stats_show()
--

commit 98d0ef34f6cf6f54725f27653fd3ae0e910be6c9
Author: David Howells <dhowells@redhat.com>

netfs: Add some tools for managing bvecq chains

This commit adds helpers for allocating, populating, reference-counting, and
freeing bvecq chains, along with request and subrequest emergency mempools.

> diff --git a/fs/netfs/bvecq.c b/fs/netfs/bvecq.c
> new file mode 100644
> index 0000000000000..8ac2dc2352585
> --- /dev/null
> +++ b/fs/netfs/bvecq.c
[ ... ]
> +struct bvecq *bvecq_alloc_buffer2(size_t size, unsigned int pre_slots, g=
fp_t gfp,
> +				  unsigned int *flags)
> +{
> +	struct bvecq *head =3D NULL, *tail =3D NULL;
> +	size_t count =3D pre_slots + DIV_ROUND_UP(size, PAGE_SIZE);
> +
> +	_enter("%zx,%zx,%u", size, count, pre_slots);
> +
> +	*flags &=3D ~BVECQ_HIT_OOM;
> +	if (WARN_ON_ONCE(pre_slots > BVECQ_POOL_SLOTS))
> +		return NULL;
> +
> +	do {
> +		struct page **pages;
> +		size_t unused, want, got, slot;
> +
> +		if (!tail || bvecq_is_full(tail)) {
> +			struct bvecq *bq;
> +
> +			bq =3D bvecq_alloc_one(min(count, BVECQ_4KB_SLOTS), gfp, flags);
> +			if (!bq)
> +				goto oom;
> +
> +			if (tail)
> +				bvecq_append(tail, bq);
> +			else
> +				head =3D bq;
> +			tail =3D bq;
> +
> +			/* Need to clear pre slots and pages[], so just clear all. */
> +			memset(tail->bv, 0, tail->max_slots * sizeof(tail->bv[0]));
> +			tail->mem_type =3D BVECQ_MEM_ALLOCED;
> +			tail->nr_slots =3D pre_slots;
> +			count -=3D pre_slots;
> +			pre_slots =3D 0;
> +		}
> +
> +		if (!count)
> +			break;
> +
> +		unused =3D tail->max_slots - tail->nr_slots;
> +
> +		/* We can put pages[] at the tail of bv[] as the elements are
> +		 * smaller and we won't overrun if the slots are filled in
> +		 * ascending order.
> +		 */
> +		pages =3D (struct page **)&tail->bv[tail->max_slots];
> +		pages -=3D unused;
> +
> +		want =3D min(count, unused);
> +		got =3D alloc_pages_bulk(gfp, want, pages);
> +		if (!got) {
> +			*flags |=3D BVECQ_HIT_OOM;
> +			goto oom;
> +		}

[Severity: Medium]
Does bvecq_alloc_buffer2() spuriously fail with BVECQ_HIT_OOM when pre_slots
fills the entire first bvecq node and size > 0?

pre_slots is permitted up to BVECQ_POOL_SLOTS.  If pre_slots =3D=3D
BVECQ_POOL_SLOTS and the first bvecq comes from the emergency pool,
tail->nr_slots equals tail->max_slots, so unused and want are both 0 while
count > 0.  alloc_pages_bulk(gfp, 0, pages) then returns 0 and jumps to oom
instead of looping to allocate a second bvecq for the buffer pages.

> +
> +		slot =3D tail->nr_slots;
> +		for (int i =3D 0; i < got; i++)
> +			bvec_set_page(&tail->bv[slot++], pages[i], PAGE_SIZE, 0);
> +
> +		bvecq_filled_to(tail, slot);
> +		count -=3D got;
> +
> +		if (unlikely(*flags & BVECQ_HIT_OOM) && (*flags & BVECQ_SHORT_OKAY))
> +			break;

[Severity: Medium]
Does checking BVECQ_HIT_OOM here stop filling tail after a single page when
bvecq_alloc_one() used the emergency pool?

When bvecq_alloc_one() falls back to the mempool, it sets BVECQ_HIT_OOM and
returns a node with BVECQ_POOL_SLOTS (29) slots.  Under low memory (or when
CONFIG_PAGE_OWNER or __GFP_ACCOUNT is active), alloc_pages_bulk() falls back
to allocating only 1 page per call, expecting the caller's loop to iterate
until the array is filled.  Because BVECQ_HIT_OOM is already set in *flags,
this check breaks out of the loop after populating just 1 slot of tail and
leaves the remaining 28 slots unused.

> +	} while (count > 0);
> +
> +out:
> +	return head;
> +oom:
> +	if (*flags & BVECQ_SHORT_OKAY)
> +		goto out;
> +	bvecq_put(head);
> +	return NULL;
> +}

[Severity: Medium]
If BVECQ_SHORT_OKAY is set and alloc_pages_bulk() returns 0 on the first
bvecq node, does this return a non-NULL head with zero buffer pages
allocated?  On later iterations where bvecq_alloc_one() just appended a new
tail node before alloc_pages_bulk() failed, jumping to out also leaves an
empty trailing bvecq (nr_slots =3D=3D 0) attached to the chain.

[ ... ]

> +void bvecq_put(struct bvecq *bq)
> +{
> +	struct bvecq *next;
> +
> +	for (; bq; bq =3D next) {
> +		if (!refcount_dec_and_test(&bq->ref))
> +			break;
> +		for (int slot =3D 0; slot < bq->nr_slots; slot++)
> +			bvecq_free_slot(bq, slot);
> +		next =3D bq->next;
> +		netfs_stat_d(&netfs_n_bvecq);
> +
> +		if (bq->from_pool !=3D BVECQ_USE_NO_POOL)
> +			mempool_free(bq, &netfs_bvecq_pool[bq->from_pool]);
> +		else
> +			kfree(bq);
> +	}
> +}

[Severity: High]
Does bvecq_put() leave a dangling next->prev pointer when bq is freed but
next survives because it holds an additional reference?

When refcount_dec_and_test(&bq->ref) succeeds on bq and then returns false =
on
next, bq is freed while next->prev still points to bq.  Any later backward
traversal from next, such as iov_iter_revert(), will dereference freed
memory.

> diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
> index 9a607c4e62dda..07c5f91657683 100644
> --- a/fs/netfs/stats.c
> +++ b/fs/netfs/stats.c
[ ... ]
> @@ -88,10 +89,13 @@ int netfs_stats_show(struct seq_file *m, void *v)
>  		   atomic_read(&netfs_n_rh_retry_read_subreq),
>  		   atomic_read(&netfs_n_wh_retry_write_req),
>  		   atomic_read(&netfs_n_wh_retry_write_subreq));
> -	seq_printf(m, "Objs   : rr=3D%u sr=3D%u foq=3D%u wsc=3D%u\n",
> +	seq_printf(m, "Objs   : rr=3D%u sr=3D%u bq=3D%u foq=3D%u bqs=3D%d,%d ws=
c=3D%u\n",
>  		   atomic_read(&netfs_n_rh_rreq),
>  		   atomic_read(&netfs_n_rh_sreq),
> +		   atomic_read(&netfs_n_bvecq),
>  		   atomic_read(&netfs_n_folioq),
> +		   READ_ONCE(netfs_bvecq_pool_sem[1].count),
> +		   READ_ONCE(netfs_bvecq_pool_sem[2].count),
>  		   atomic_read(&netfs_n_wh_wstream_conflict));

[Severity: Low]
include/linux/semaphore.h marks struct semaphore's members as private
("Please don't access any members of this structure directly"), and count is
an unsigned int updated with plain accesses under sem->lock.  Should
netfs_stats_show() avoid reaching into sem.count directly (or format it with
%u if exposed via a helper)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D4
