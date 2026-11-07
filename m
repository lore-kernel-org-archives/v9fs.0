Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794069965;
	b=gKtT0UtT9pBJ6+7GOXzugptMQxz9mNiDP3sML7KTNf7STVuWf2BjaULObQLp/RcS1xH1
	 Tubn9DczWURkmRlrfFDwbN/irqcRSR1gt5NRrSrkRynVspz8HotjpsviiFArj1yumMabW
	 xRZXHw5GE6lYJDLpyeKQwB3uc6r8/qtxmVCPRgw5lI/UesDWJbX8vKq8s4M9ADybaz756
	 rA5wrXj9Nf1qI5n5LNXM1UaPiFu48dU4XsKlJs3Efq2mausHfzAGLSrg74F8HrcnVtzMu
	 iLBwOdUXcLmAFwnVqMThDd1y1c+pmgzO8sr8ydrgUsK8Q1NlanDiJbKsqcjRjAdZ5TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794069965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A/xNfTGRrZtLpXrlezsr0jRntXukcewjnZgVZLITfpw=;
	b=r8a1tptxKLHUsDHmtwUAaybOVwFZySGMX7+MQQ0T5k0Lc2xzfUEmcNCPfNAU9L8krhP1
	 5CiIIMGaQTFHuL6AFdQH+6RNdWNYqlEpBKuU//xiFSb3+yjghscFSfFCiOPoFLUD2umDG
	 q3XJ+1XYtcWB1mbK9y0DgmUz9Bo7fcpyIohTRI4nqd7W/VGoadyHPtCBbytpn8zTOET3l
	 DN3YmswyLXYIaAT76g+DNXF1OHMRASfM0CFgFPFoswPkoAijoBIOBweD0pMpXSZk+ZiGR
	 rdLpURFIz5dqSF/Sge0gJAVaMDuorJY1slqPWmJ4NaCGFTXGjYgxPaNoavv78nrY+EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVdwz+Pj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08BD606A326
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVdwz+Pj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4675B1F0089F;
	Sat,  7 Nov 2026 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794069964;
	bh=A/xNfTGRrZtLpXrlezsr0jRntXukcewjnZgVZLITfpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVdwz+Pjlb4bq99uPiCJVkzZbanU7tjhwUTUpI6b6J8o8+y7FblqFI7aTcG57pYDU
	 9Yf1SSpLmk+x2vuINzhyC+ySOmjZcd2Tbuz8w8qDUZU/I8v5+SEe2Gl0aA3ggWaDFm
	 MQ/j5Em5SxTQgiFeXxgRKvgI9p9yKSsEmzM01o+J1NOv2qFA41BPRO+flNiOeTeFgw
	 Hj8LSWjZ4Sh3L8Sk8n1+Ii3iUvWk3rXUlA9IN5p4dm9bJTtvm9ZdtJGKlchwWaoN67
	 I4AnSunIrneFRaQhdYIdgmfEcRR6kzjxETYhv9uZeXKDQzzsxhoY2UMGPuHNq6D8Xo
	 VsgYUO49AtODg==
Message-ID: <sashiko-outbox-203072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 03/15] netfs: Add some tools for managing bvecq
 chains
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261107160823.1465553-4-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-4-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 16:46:03 +0000
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
- [High] netfs: mempool deadlock in bvecq_alloc_chain() when
  for_writeback is true
- [Medium] netfs: uninitialized mem_type and bv[] in
  bvecq_alloc_buffer2() when size is 0
--

commit 7b4f77e4cd79aa76c73be1af04e2001e239881a3
Author: David Howells <dhowells@redhat.com>

netfs: Add some tools for managing bvecq chains

This commit adds helper functions for allocating, populating, expanding,
and refcounting bvecq nodes and chains, along with a mempool for writeback
allocations.

> diff --git a/fs/netfs/bvecq.c b/fs/netfs/bvecq.c
> new file mode 100644
> index 0000000000000..06adb44ea93fc
> --- /dev/null
> +++ b/fs/netfs/bvecq.c

[ ... ]

> +struct bvecq *bvecq_alloc_chain(size_t nr_slots, gfp_t gfp, bool for_wri=
teback)
> +{
> +	struct bvecq *head =3D NULL, *tail =3D NULL;
> +
> +	_enter("%zu", nr_slots);
> +
> +	for (;;) {
> +		struct bvecq *bq;
> +
> +		bq =3D bvecq_alloc_one(min(nr_slots, BVECQ_4KB_SLOTS), gfp, for_writeb=
ack);
> +		if (!bq)
> +			goto oom;
> +
> +		if (tail)
> +			bvecq_append(tail, bq);
> +		else
> +			head =3D bq;
> +		tail =3D bq;
> +		if (tail->max_slots >=3D nr_slots)
> +			break;
> +		nr_slots -=3D tail->max_slots;
> +	}
> +
> +	return head;
> +oom:
> +	bvecq_put(head);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(bvecq_alloc_chain);

[Severity: High]
Can bvecq_alloc_chain() deadlock on netfs_bvecq_pool when for_writeback is
true?

Under memory pressure, bvecq_alloc_one() falls back to
mempool_alloc(&netfs_bvecq_pool, gfp).  Because this loop allocates
multiple nodes from the same 100-element pool while holding previously
allocated nodes in head, a single request needing more than 100 pool nodes
(~11.3 MiB) or concurrent writeback threads exhausting the pool midway
through their chains will sleep in mempool_alloc() waiting for elements
that they themselves are pinning.

> +
> +/**
> + * bvecq_alloc_buffer2 - Allocate a bvecq chain and populate with buffers
> + * @size: Target size of the buffer (can be 0 for an empty buffer)
> + * @pre_slots: Number of preamble slots to set aside
> + * @gfp: The allocation constraints.
> + * @for_writeback: True if allocating for writeback
> + *
> + * Allocate a chain of bvecq nodes and populate the slots with sufficien=
t pages
> + * to provide at least the requested amount of space, leaving the first
> + * @pre_slots slots unset.  The pre-slots must all fit into the first bv=
ecq.
> + * Note that any memory segments set in the pre_slots will be freed as
> + * specified by BVECQ_MEM_ALLOCED.
> + *
> + * The caller should assume that the pages allocated may be compound pag=
es
> + * larger than PAGE_SIZE and thus occupy fewer slots.  The pages have th=
eir
> + * refcounts set to 1 and can be passed to MSG_SPLICE_PAGES.
> + *
> + * Return: The first node pointer or NULL on allocation failure.
> + */
> +struct bvecq *bvecq_alloc_buffer2(size_t size, unsigned int pre_slots, g=
fp_t gfp,
> +				  bool for_writeback)
> +{
> +	struct bvecq *head =3D NULL, *p =3D NULL;
> +	size_t nr_per_bq =3D BVECQ_POOL_SLOTS;
> +	size_t count =3D pre_slots + DIV_ROUND_UP(size, PAGE_SIZE);
> +
> +	_enter("%zx,%zx,%u", size, count, pre_slots);
> +
> +	if (WARN_ON_ONCE(pre_slots > nr_per_bq))
> +		return NULL;
> +
> +	head =3D bvecq_alloc_chain(count, gfp, for_writeback);
> +	if (!head)
> +		return NULL;
> +
> +	p =3D head;
> +	do {
> +		struct page **pages;
> +		size_t unused, want, got, slot;
> +
> +		if (!count)
> +			break;
> +		if (WARN_ON_ONCE(!p))
> +			goto oom;
> +
> +		if (p->nr_slots =3D=3D 0) {
> +			/* Need to clear pre slots and pages[], so just clear all. */
> +			memset(p->bv, 0, p->max_slots * sizeof(p->bv[0]));
> +			p->mem_type =3D BVECQ_MEM_ALLOCED;
> +			p->nr_slots =3D pre_slots;
> +			count -=3D pre_slots;
> +			pre_slots =3D 0;
> +			if (!count)
> +				break;
> +		}

[Severity: Medium]
Does calling bvecq_alloc_buffer2() with size =3D=3D 0 and pre_slots =3D=3D =
0 (for
instance via bvecq_alloc_buffer(0, ...)) leave p->bv uninitialised and
p->mem_type set to BVECQ_MEM_EXTERNAL instead of BVECQ_MEM_ALLOCED?

When both size and pre_slots are 0, count is 0, so the first if (!count)
check breaks out of the loop before the p->nr_slots =3D=3D 0 block zeroes
p->bv and sets p->mem_type =3D BVECQ_MEM_ALLOCED.  In addition, passing
count =3D=3D 0 to bvecq_alloc_chain() rounds up sizeof(*bq) alone, which yi=
elds
max_slots =3D=3D 0 on 32-bit architectures (or 1 on 64-bit) when not alloca=
ted
from the mempool.  If the caller later populates slots in this node,
bvecq_put() will leak the pages, and bvecq_expand_buffer() will allocate a
new bvecq node leaving the empty head node unused.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D3
