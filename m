Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074977;
	b=qGhyCi20DTSlWshxyf+eG4WBraW2VP3NHEu+UGPD3XTCkAkfYQcMOgqbOuF/wUOh9NAo
	 WbM6YL3eYBDRIX/EIPaoXFptcsQgccO8ewsadO+iFswxQQKPbv8oaXL4ldl0Gtd7Tt7of
	 FotjP+jsJybaAtSm2BiX614Ry19MSTWVEMh1pcTi/g1LQqTF8n8v8lnFrSODpgSsieimf
	 ttGsxAwMNufIRE6KrCKkY4mXwxN5sacNb9vbEWaDJ9GoMTxIVSOvVH8ersSmaBSmY+E7Q
	 8G+sY89ycxdjHPTWHsXFtXgVkDgfTfCRxlHkeFfiR0QhWBZAreYAPmOoF0PYuOwzZUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074977;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=76KDCpZ9zZwRKoqzvTJ8qNXCBdc8+u7YztaFuHC39NQ=;
	b=mmhuLJiPV5+DO7tK470HP1r6Od2hJN43GU+QL5WhwTKZOztRrXfa5RMrtH5EUB6r0K42
	 CgO/Pauml03YsacVY1pDRCliOscXRvAhuCjM/J0K2eWuCTZoPlLiVXSNpMUktQkD+Bm6g
	 RBKQ+6RMRi7GTzl2XwwWCfK3k8ZevBSlhF2AQPuPsTd1EAXjSHSGEHbgAPudT+F/e34k6
	 fyL6LhWoHd7SFCj+JkVCMHV5t9if/oAdtGjPOMH94Ict6+Obu/ox9c3XCzrgH4zISgufW
	 fy7tRAltk66F/pmuVh8tgwPNxpOifAYROtBrDWsekxmNjwYyRK7iI625dMu1SvR4x6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aINxQECZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F5606A326
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aINxQECZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024E81F0089F;
	Sat,  7 Nov 2026 18:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794074976;
	bh=76KDCpZ9zZwRKoqzvTJ8qNXCBdc8+u7YztaFuHC39NQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aINxQECZjexNu388uM6+e9J4/sl0LK1AvR2+Vz9u9k5WJsL/4jqt2LHBdzkAQNCQE
	 ytU58N+lv7bFg2EDBk8of8yp9gVnestyi9Kd3mtIODKVMTtA7lQ3OCz+Tzg8gFLwrj
	 yF+VUkMRvTsfw5aVVXPupp76X5BTP5rTv/ZFHZaeRUkPuC8H9tkbFv/rIXaUI89B07
	 8NCqWrR5KT0xlW/fMl4mL0ES3IJGAnDmQnNTa7vUGw/YH3vRN70nR4u3w8rMOpbgpi
	 pPeeJBRAFWeVMsmQ9rNmbyFubK+dpdbi/Co86gWeilVESjVwfjTwlYYaBeFZm0HXwF
	 toECQEnp3Figg==
Message-ID: <sashiko-outbox-203152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 08/15] netfs: Change netfs_writeback_single() to not
 look inside the iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261107160823.1465553-9-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-9-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:09:35 +0000
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
- [Medium] netfs: netfs_write_collection() wakes waiter before
  netfs_wb_end()
- [Medium] netfs: set wreq->i_size to len in netfs_writeback_single()
--

commit 4b137787e59ae6eefb0ddaed87ce3b7cc4ab57b8
Author: David Howells <dhowells@redhat.com>

netfs: Change netfs_writeback_single() to not look inside the iterator

This commit changes netfs_writeback_single() to pass the data iterator
directly to the cache as a single monolithic write and wait synchronously
for the write to complete.

> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> index e041023811ed0..f084a6796667f 100644
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
[ ... ]
> @@ -787,36 +665,42 @@ int netfs_writeback_single(struct address_space *ma=
pping,
>  		goto couldnt_start;
>  	}
> =20
> +	wreq->buffer.iter =3D *iter;
> +	wreq->len =3D len;
> +	wreq->submitted =3D wreq->len;

[Severity: Medium]
Should netfs_writeback_single() also set wreq->i_size =3D len here?

netfs_create_write_req() initializes wreq->i_size via a separate
i_size_read(inode) call in netfs_alloc_request().  In afs_dir_writepages(),
the caller only holds down_read(&dvnode->validate_lock) when reading
i_size to pass as len, while concurrent RPC completions in
afs_apply_status() can update inode->i_size under cb_lock without holding
validate_lock.

If wreq->i_size does not match len and len is not a multiple of
cache->bsize, cachefiles_issue_write() skips tail padding because
start + len =3D=3D wreq->i_size is false:

fs/cachefiles/io.c:cachefiles_issue_write() {
	...
	/* We also need to end on the cache granularity boundary */
	if (start + len =3D=3D wreq->i_size) {
		size_t part =3D len & (cache->bsize - 1);
		size_t need =3D cache->bsize - part;

		if (part && stream->submit_extendable_to >=3D need) {
			len +=3D need;
			subreq->len +=3D need;
			subreq->io_iter.count +=3D need;
		}
	}
	...
}

cachefiles_issue_write() then strips the unaligned tail, causing
cachefiles_collect_write() to hit WARN_ON(len & (cache->bsize - 1)) and
invalidate the cache object.

>  	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
>  	trace_netfs_write(wreq, netfs_write_trace_writeback_single);
>  	netfs_stat(&netfs_n_wh_writepages);
> =20
> -	if (__test_and_set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
> -		wreq->netfs_ops->begin_writeback(wreq);
> +	for (int s =3D 0; s < NR_IO_STREAMS; s++) {
> +		struct netfs_io_subrequest *subreq;
> +		struct netfs_io_stream *stream =3D &wreq->io_streams[s];
> +
> +		if (!stream->avail)
> +			continue;
> =20
> -	for (fq =3D (struct folio_queue *)iter->folioq; fq; fq =3D fq->next) {
> -		for (int slot =3D 0; slot < folioq_count(fq); slot++) {
> -			struct folio *folio =3D folioq_folio(fq, slot);
> -			size_t part =3D umin(folioq_folio_size(fq, slot), size);
> +		netfs_prepare_write(wreq, stream, 0);
> +		/* Allocation not allowed to fail in writeback. */
> =20
> -			_debug("wbiter %lx %llx", folio->index, atomic64_read(&wreq->issued_t=
o));
> +		subreq =3D stream->construct;
> +		subreq->len =3D wreq->len;
> +		stream->submit_len =3D subreq->len;
> +		stream->submit_extendable_to =3D iov_iter_count(iter) - len;
> =20
> -			ret =3D netfs_write_folio_single(wreq, folio);
> -			if (ret < 0)
> -				goto stop;
> -			size -=3D part;
> -			if (size <=3D 0)
> -				goto stop;
> -		}
> +		netfs_issue_write(wreq, stream);
>  	}
> =20
> -stop:
> -	for (int s =3D 0; s < NR_IO_STREAMS; s++)
> -		netfs_issue_write(wreq, &wreq->io_streams[s]);
>  	netfs_all_subreqs_queued(wreq);
> -
>  	netfs_wake_collector(wreq);
> =20
> +	/* TODO: Might want to be async here if WB_SYNC_NONE, but then need to
> +	 * wait before modifying.
> +	 */
> +	ret =3D netfs_wait_for_write(wreq);
> +	if (ret > 0)
> +		ret =3D 0;

[Severity: Medium]
Can netfs_writeback_single() return to its caller before the collector
worker releases NETFS_ICTX_WB_LOCK?

Because NETFS_RREQ_OFFLOAD_COLLECTION is set, netfs_wait_for_write() sleeps
until the collector worker clears NETFS_RREQ_IN_PROGRESS, which happens in
netfs_write_collection() before netfs_wb_end() is called:

CPU0                              kworker
netfs_writeback_single()
  netfs_wb_begin(ictx, ...)
  ...
  netfs_wait_for_write(wreq)
                                  netfs_write_collection()
                                    netfs_wake_rreq_flag(...,
                                      NETFS_RREQ_IN_PROGRESS, ...)
  /* returns to caller */
  /* next writeback on inode */
  netfs_wb_begin(ictx, true)
    /* sees NETFS_ICTX_WB_LOCK */ <-- false lock conflict
                                    netfs_wb_end(ictx)

An immediate subsequent WB_SYNC_NONE writeback on the same inode can see
NETFS_ICTX_WB_LOCK still held, re-mark the inode dirty via
netfs_single_mark_inode_dirty(), and abort the writeback pass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D8
