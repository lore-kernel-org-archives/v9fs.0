Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079243;
	b=XenVaXZip8bq5wVBvksKXz2//SXWp3UKS+1qaxBjoY9VJlolTM1jmRyws18OXmRXGU+Y
	 L8dBjSFiUYSqpXHN1CGgem3uP4ioRx/PAc9RJlFpkezZfr/tPJfpYsQQtVRgTjFdrlAiE
	 sreTRuSV9sSPos/GvyIkSHQWnCZG4yBk4/hJeG6ducAarZDd+BGN30pE/7Zi2RJ9T9xuC
	 77DVGOou8ocrpEGOYwMOR16vZIKdBEkQopmjVkOHfzEs9cpynYukoUjqDbfpKEVrfG0qp
	 o4yvYUD1ICscHdvQWhmHHQIhmdMcDBRumn/g+y4CqCKclICnEJEHWJ78mSS9woJdWrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kVLaSTguRXetG5RzDi1HhjdcLYMMwjESdu/PZl6WWVw=;
	b=KaStBPcJqD0uCvBUdNk8WHORSfK7sJCJr51MISOKh54f1XnkAz4d43jBh+aLaE7zD4d9
	 HsL06/jfTePaTEGHtWzajqudvjpEmBQ0GUF+WIn+/0P+55azuQtexjD2vsA1UTClFNlv7
	 7k8EIM/4drNwg+qODAZTUfSh2k/EEkrJ9lkTaWJGShpzSWdIVbq07LtHF7kEg7OM9KM7H
	 1usN7uRMElkBd/PFwoopV1y/TG/bOvw9gJd37Y7cZjZiG63iasurdSB9kZKlYxgtHBY1V
	 UK5bRIVEu9qV65mu4Xi9hbmkPvbScWtmIJM4R9XnZMGwLWmH5lCu2h212mp/ELypyQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5b1Q8g2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887B1606A325
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5b1Q8g2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DE41F000C4;
	Thu, 19 Nov 2026 09:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079243;
	bh=kVLaSTguRXetG5RzDi1HhjdcLYMMwjESdu/PZl6WWVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K5b1Q8g2OzYiS3RJT71PrnmUlCCxrJnSdfSkq7sRC7CP3llnvDleYVfpu0jtsR597
	 qzVL6GomctcoZoEhXAH79C0rYmfAXZOHy0f/aHojjukH/V+SxCZkg0UGs3uCA2r02o
	 Ne+DzuptazsOLG2CSofcrG5JYiHyOVAq/XRt9fPRvboLzp9uX5tsTZgtibudlElGOI
	 5iAMwEwXWPmGl4OZ1drOq3qEigVj2/Xc9SxQIMqR4kNN6hewVu/To6TsiW+UUoqDQ2
	 ZkomUgJx1jCdPzAXekrAjHjL3AFHzJSaIJ7KNZvDMPzAVpEbjjyuXdFgfwvtlVdMCd
	 MaHEdLtouIH4g==
Message-ID: <sashiko-outbox-222785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 04/17] netfs: Add some tools for managing bvecq
 chains
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261119083851.3306418-5-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-5-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:07:22 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] netfs: dangling prev pointer in bvecq_put() when next node
  survives
- [Medium] netfs: false OOM in bvecq_alloc_buffer2() when pre_slots
  fills first node
- [Medium] netfs: bvecq_alloc_buffer2() stops page fill early on
  BVECQ_HIT_OOM
- [Low] netfs: direct access to private semaphore count in
  netfs_stats_show()
--

commit abff4f06be20b79f4ce9a5e857e386c2486d016a
Author: David Howells <dhowells@redhat.com>

netfs: Add some tools for managing bvecq chains

This commit adds helpers for allocating, populating, refcounting, and
freeing bvecq chains along with emergency mempools for request and
subrequest allocations.

> diff --git a/fs/netfs/bvecq.c b/fs/netfs/bvecq.c
> new file mode 100644
> index 0000000000000..b140cd47a1faf
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
> +			if (tail =3D=3D head) {
> +				tail->nr_slots =3D pre_slots;
> +				count -=3D pre_slots;
> +			}
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
> +			goto pages_oom;
> +		}
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
Does checking BVECQ_HIT_OOM after every alloc_pages_bulk() call stop
populating tail prematurely?

When bvecq_alloc_one() falls back to an emergency mempool, it sets
BVECQ_HIT_OOM in *flags.  Under low-memory conditions where zone
watermarks are not met, alloc_pages_bulk() falls back to allocating a
single page per call and relies on the caller's loop to fill the remaining
slots, so breaking here before tail is full leaves a 29-slot pool bvecq
with only one page populated.

> +	} while (count > 0);
> +
> +out:
> +	return head;
> +
> +pages_oom:
> +	/* If tail is empty, discard it. */
> +	if (tail !=3D head && tail->nr_slots =3D=3D 0) {
> +		tail->prev->next =3D NULL;
> +		bvecq_put(tail);
> +	}
> +oom:
> +	if (!head || (tail =3D=3D head && head->nr_slots =3D=3D pre_slots))
> +		goto discard; /* Allocated no pages */

[Severity: Medium]
Can bvecq_alloc_buffer2() fail with a false OOM when pre_slots fills the
first bvecq node?

pre_slots is allowed to be up to BVECQ_POOL_SLOTS.  If the first bvecq is
allocated from an emergency mempool (max_slots =3D=3D BVECQ_POOL_SLOTS) with
pre_slots =3D=3D BVECQ_POOL_SLOTS and size > 0, setting tail->nr_slots =3D
pre_slots leaves unused =3D=3D 0 and want =3D=3D 0, so alloc_pages_bulk(gfp=
, 0,
pages) returns 0 and triggers pages_oom instead of allocating a second
bvecq node.

Also, when pages_oom discards an empty non-head tail node via
bvecq_put(tail), tail is not reset to tail->prev before the oom check
tests tail =3D=3D head && head->nr_slots =3D=3D pre_slots.  If the second n=
ode
fails its first page allocation while head only contains pre_slots,
bvecq_alloc_buffer2() with BVECQ_SHORT_OKAY will return a buffer with zero
allocated pages.

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
Does bvecq_put() leave a dangling prev pointer on a surviving successor
node?

When an interior node in a chain has an extra reference held (for example,
via subrequest or retry pinning) and bvecq_put() frees the preceding node,
the loop breaks when refcount_dec_and_test(&bq->ref) returns false on the
surviving node without clearing its prev pointer.  A subsequent backward
walk such as iov_iter_revert() -> iov_iter_bvecq_revert() will then
dereference the freed predecessor node:

lib/iov_iter.c:iov_iter_bvecq_revert() {
    ...
		if (slot =3D=3D 0) {
			bq =3D bq->prev;
			slot =3D bq->nr_slots;
			continue;
		}
    ...
}

> diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
> index 9a607c4e62dda..07c5f91657683 100644
> --- a/fs/netfs/stats.c
> +++ b/fs/netfs/stats.c
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
struct semaphore in include/linux/semaphore.h is marked "Please don't
access any members of this structure directly", and its count field is an
unsigned int protected by sem->lock (formatted here with %d).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D4
