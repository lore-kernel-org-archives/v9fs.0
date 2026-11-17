Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938018;
	b=ZIkCHgc8Xlpj1Z/jROzyQXS+pbsySV8tt69XQ0q0XsLOk0SU+WRMCWxBRVkWooU7p/fK
	 O/uXkTz7t6UlYy/k+DIRm1Rf+ykNpLpE/S65scYHIJSCqx/d1/Y4Zhx4lSE5MNaLeuWIY
	 7WlWCGLYc8KtcL2F2ZmHjGruu6h5MU8vFWLc2UuOoKwlN3ackbZmIJp8CW9RF20p+KqGr
	 k1+GC7msRAC0nSTNfPL61PmvD318DxrIfJ3Y/BkEEFAxOZ1gkBpgCFSstPlvwOqdLsdAP
	 0BZXAUlP2yV5EwPhSowjezJGY06lGkyqiva+mzPLdNaJeHqtvJb6nx5qphAPmcqqMvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938018;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=icri+Zhp94uhsDCmhWLzm4TrfQukmhesi6xwpk04Gbc=;
	b=bCx8MFqxUBivpaqYgVohhINoZfgz0KhMut7gGQNWOwPreZMpPhJdRTkIg5TYmsAjxILK
	 rsJG7LEJpIy/8vpr5NtAiVP+CH9uWVFmYfELdJb6JD6QJZaSAoMbxqhz1S5WUTEKcVJHp
	 X1aN3icPILd1Le8rSSk15na/TYP7fD27N4xzPGmiDwKfkuFTC+a+YNVXUa7dZj3/J9bLc
	 vC7Z+AUnUiOIONdLO58xXAAf20GaxAK3tvRIk4/jS0hnf2rS1BMrsxsV5bQeUmJMBNvSb
	 HzDRexeNQg3MznzcxwxArJsCy6YotbK4QVbPq+55sPmFKyKTPUhm+6R49VU5G1mI0sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieFFr42E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA7606A31C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieFFr42E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F07F1F000C4;
	Tue, 17 Nov 2026 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938017;
	bh=icri+Zhp94uhsDCmhWLzm4TrfQukmhesi6xwpk04Gbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ieFFr42Eg6W5sbr+3QlyjK0F3tNQ09uNBh8b+aB5/GmF+5qgIx7KcF73bDZCnWqlh
	 heQRNreTCBcANIyiL652arGtY5yrATYWkxjofn3joZzBmerwfvET4UZ0O10Brn3Xfb
	 V52nGtXIai50gWX49WEvL2Ntnv1acffhTCZcoM8fqn4EZW5sSmZERsiJNH8E1QGeG4
	 8CK7E0N3Z1UFuP/6SktLxeMxngRt0U59jSMMp3YHx7HblFZvu/nX/eV7KED45rj4wv
	 iJIizMWK/bvuch72Vprs5U+7St28vXM8iFxgV1dyyAp33dEvM3BZlveJ5+UFu8H1CE
	 ubg3euT/EhCgQ==
Message-ID: <sashiko-outbox-219291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 09/17] netfs: Change netfs_writeback_single() to not
 look inside the iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117171958.2982801-10-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-10-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:53:37 +0000
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

commit 90dc9674df74e46678b038bf8aa77c3be41e113a
Author: David Howells <dhowells@redhat.com>

netfs: Change netfs_writeback_single() to not look inside the iterator

This commit changes netfs_writeback_single() to pass the data buffer
iterator directly to the cache as a single write subrequest and wait for
the write to complete before returning.

> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> index 63b0e2599c3c6..0fcfb5ab49bdd 100644
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
[ ... ]
> @@ -789,36 +667,42 @@ int netfs_writeback_single(struct address_space *ma=
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
Can netfs_writeback_single() return to its caller before the collector
worker releases NETFS_ICTX_WB_LOCK?

Because NETFS_RREQ_OFFLOAD_COLLECTION is set, netfs_wait_for_write()
sleeps on wreq->waitq while the collector runs on system_dfl_wq, and
netfs_write_collection() wakes NETFS_RREQ_IN_PROGRESS before calling
netfs_wb_end():

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
  /* next WB_SYNC_NONE writeback */
  netfs_wb_begin(ictx, true)
    --> false (NETFS_ICTX_WB_LOCK still held)
                                        netfs_wb_end(ictx)

An immediate subsequent WB_SYNC_NONE writeback on the same inode (such as
a second afs_dir_writepages() pass after dropping validate_lock) can see
NETFS_ICTX_WB_LOCK still set, re-dirty the inode, and abort writeback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D9
