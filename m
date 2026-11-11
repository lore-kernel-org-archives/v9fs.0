Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440219;
	b=YZccc4b9YsO+vihPULGV3FOdRH0kA2UGvx4nhuDU8XE5SGdY+55fS6jx2Ws6EwwZzt6O
	 CiAcnQYdfr0XgvkClD3JhCWBsMzIH+pVPN6TXpbMNqz12tSYCwdw8TYZI9BlxBcLAEwOT
	 JeUtthAD3ktBp2IXdvn5fOJfwEIV8rEI41isC5RsoK7EXyMi7J4ecPyhoZhAtwbJ0NpI1
	 F7KbADbpIK6tDG+2Ef0EDfcLKYORXIWzfV+YSeAepr4vsrgjqQagtuBtsmcVncM6SsTi/
	 vEnvYYV3H+/FodVBPBZSbWwxtB70OgNcQbi7dGobzaHbwJQoxl/kf8KtjC3njpAZGoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ACve3uaf0d//wFhU2P4xybDYpknQ+pbxW+mIZeqGI7g=;
	b=zLIRoh1D0P4Bg9ANP4ZKWxcxy8oi9SPlyjH5UkohAkduF67AEsjNIq3W+h+pPwnyucwR
	 O7+9thWsW7C9freVQXgo0npg4RiD7X9KaQuRXQ9RUOfkDDLqzvRSbSWUBiHI6Q8/AjnVe
	 8ozA3HnQS3LrfV/UkDdOIaZEHfSBruZE6w6Ru93Br7DqWdqz6UsihLVqi6BhXz6raILom
	 lwYW//5eb9FRh/4gWlHvNSrCPmX4xE/kGY71sZ03t4zhwLc9Bwr4j+IFTdU8nTUkSApxK
	 3Ysn0cy6iPmHT+h/6QMxUskdChnv46dkOJShZy7kWmddlOcV80Ro1bA1NNpS1yxjRFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRQc7IVZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18377606A326
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRQc7IVZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFC71F00A07;
	Wed, 11 Nov 2026 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440218;
	bh=ACve3uaf0d//wFhU2P4xybDYpknQ+pbxW+mIZeqGI7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BRQc7IVZPpHp91fiy4cFD82JI8fLqvRhIjzEqGQs8+wzUTwe9aeInqyrZCXJjdLsJ
	 dNq5vmH1KE3QLEmjEF4+Y1Mk2B9s86ZkoFCPYhQG9CLsVezT1Ir9xeeAB66hbFB7UU
	 +1b3i+y2yKXSbUGWl9a7ROaeDBX3Zt3BRzb6rERQg6HxNbX0+DWxHS84ZE2T0D/qG5
	 YzCGp8/SN3+bckYXQePoHd4vktTBJGm1yHYTxuJeaxX7Fo/BOv0dKMuKrRhg76fQMY
	 1k0BelSNk7lO7eLOUAueCrAYV/ZRb+q8m7Gu7PETHZFsmOEaK45eCWPb95WXPlX7Pp
	 mx86FtOQzM8Kg==
Message-ID: <sashiko-outbox-209860@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 09/17] netfs: Change netfs_writeback_single() to not
 look inside the iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261111203034.2126314-10-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-10-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:36:57 +0000
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
- [Medium] netfs: netfs_write_collection() wakes waiter before
  netfs_wb_end()
--

commit 6578826ffb6d0041f876eafa90bcd2bd1b096881
Author: David Howells <dhowells@redhat.com>

netfs: Change netfs_writeback_single() to not look inside the iterator

This commit changes netfs_writeback_single() to pass the caller's iterator
directly to the write streams as a single monolithic write and wait
synchronously for completion instead of iterating over the folios
individually.

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
> +
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
Can netfs_writeback_single() return while NETFS_ICTX_WB_LOCK is still held
by the collector worker?

Because NETFS_RREQ_OFFLOAD_COLLECTION is set, netfs_wait_for_write() sleeps
on wreq->waitq until NETFS_RREQ_IN_PROGRESS is cleared by the collector
workqueue, which happens before netfs_wb_end() releases NETFS_ICTX_WB_LOCK:

fs/netfs/write_collect.c:netfs_write_collection() {
	...
	netfs_wake_rreq_flag(wreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wake_i=
p);
	/* As we cleared NETFS_RREQ_IN_PROGRESS, we acquired its ref. */

	switch (wreq->origin) {
	case NETFS_WRITEBACK:
	case NETFS_WRITEBACK_SINGLE:
		netfs_wb_end(ictx);
		break;
	...
}

CPU0                                  kworker
netfs_writeback_single()
  netfs_wb_begin(ictx, ...)
  ...
  netfs_wake_collector(wreq)
  netfs_wait_for_write(wreq)
                                      netfs_write_collection()
                                        netfs_wake_rreq_flag(wreq,
                                          NETFS_RREQ_IN_PROGRESS, ...)
  return 0;
netfs_writeback_single()
  netfs_wb_begin(ictx, true)  <-- sees NETFS_ICTX_WB_LOCK still set
                                        netfs_wb_end(ictx)

An immediate subsequent WB_SYNC_NONE writeback on the same inode will see
NETFS_ICTX_WB_LOCK still held, re-dirty the inode via
netfs_single_mark_inode_dirty(), and abort the writeback pass.

Should netfs_write_collection() call netfs_wb_end() before waking
NETFS_RREQ_IN_PROGRESS, or should netfs_writeback_single() omit
NETFS_RREQ_OFFLOAD_COLLECTION while it waits synchronously?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D9
