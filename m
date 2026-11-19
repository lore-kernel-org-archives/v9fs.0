Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079392;
	b=FXGlHzeaAvzNUXGzqTqAjH7MZZkuL/xK57vPb+JBAPZiMkiKrIOvrWjW4YWfyXcgwVPN
	 PHxyYOREa1jypNFKB5fp1KbetPLxcEmGHi4URdus4N4rHp1YYCrdRTqSsjpDT5UPSijU/
	 QzIVpq/gYemPrwQSIG8pGhLa5GVXYBjNzviOKEl9ymOQ/WR1o9mzA4jsqBzLjppc2MhR4
	 vEmvXmGY6WnJlRpIeLTZ0X+TsAA4u2sGfz7aNJ9xw2seX8qEXL61TEUizns5pfJZjJ+ND
	 5q5g+oaylsVmBC+uSeRerNxN6Y7YbmjPdfgM19JRXNhu0UIQKDsjljX7OlN5MtwP5yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079392;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ngO0BUE6HtNT/KiSJWlnS9FjS0coEFjn4rBq27zsN8k=;
	b=eSkMruIMA42ezkoqMUWy+P7oXaoGBzErOzlrUEJUXgqGx/1c0287oOA55ix8knKo8DRN
	 smGJ9fPjNqlcqDyP6CIhCEMMhJ4TUUwqayp7iX0gYQ9TAGeqQRujhlmHSbZvV+fZ5oh7a
	 lWgVVlM44NqIjNSBX+AOmbpIiOrYDg/UagNNXqqffP7P0MNG6kkh/3qmx7CKEHHKdc9Os
	 SAysF52bSj6zclSiuM1pIx8bMZgBCyNQJv8j7JAeUeGxwNTnPe3QKZlCH30YEGABMFtxs
	 +Ju/tLPivWPKpswagKLcr24cEC+fNtswn9piL+chfbG9AuwerUtuIk25+ppBbeGnPlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaBn14fu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA981606A324
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaBn14fu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354831F000C5;
	Thu, 19 Nov 2026 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079392;
	bh=ngO0BUE6HtNT/KiSJWlnS9FjS0coEFjn4rBq27zsN8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HaBn14fuidCDI6gCQPcSTR9icB9kFPZBSvA5PbA+DbENzobyF2n9PtTGbecaCu3Tl
	 Vjgcp5mHWGP8AWv/y8FtTyoEyrGLwNeW/8ZZKg1FwyT03TGKOwjwm7Plcq2QrxcDbQ
	 OcT/tha7qHPOHI9iJWuYr+VidaN7Ymt7iTPnKY/b2Yr35l+4YtzA0GWFdA3di1avjX
	 LIZgiT2e2wF3Igtu1Grn3VpGTesuthmWuc1mbt0tjFEZA4TVVVgTY2fK1FnbEO8Z2O
	 5gUSAUV10ZnhQ+DIgXdgrPuvwRJaZ5MRAfjKP3djr65lzO1YKhGVMGlCv8OFZifFVR
	 BUEZaCBuhNypw==
Message-ID: <sashiko-outbox-222790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 09/17] netfs: Change netfs_writeback_single() to not
 look inside the iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261119083851.3306418-10-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-10-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:09:51 +0000
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

commit 551b21c53964c5580e9753fdbf5df8744277ee38
Author: David Howells <dhowells@redhat.com>

netfs: Change netfs_writeback_single() to not look inside the iterator

This commit changes netfs_writeback_single() to submit the entire buffer
iterator as a single unsliced subrequest per available stream and wait
synchronously for the write to complete before returning.

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
Can netfs_writeback_single() return while NETFS_ICTX_WB_LOCK is still held
by the collector worker?

Because NETFS_RREQ_OFFLOAD_COLLECTION is set, netfs_wait_for_write() waits
for the workqueue thread running netfs_write_collection() to clear
NETFS_RREQ_IN_PROGRESS, which happens before netfs_wb_end() releases
NETFS_ICTX_WB_LOCK:

CPU0                                    CPU1 (kworker)
netfs_writeback_single()
  netfs_wb_begin(ictx, ...)
  netfs_wake_collector(wreq)
  netfs_wait_for_write(wreq)
                                        netfs_write_collection()
                                          netfs_wake_rreq_flag(wreq,
                                            NETFS_RREQ_IN_PROGRESS, ...)
  /* returns to caller */
  netfs_wb_begin(ictx, true)
    /* sees NETFS_ICTX_WB_LOCK set */   <-- spurious lock conflict
                                          netfs_wb_end(ictx)

An immediate subsequent WB_SYNC_NONE writeback on the same inode (such as
afs_dir_writepages() after releasing validate_lock) can see
NETFS_ICTX_WB_LOCK still set, re-mark the inode dirty via
netfs_single_mark_inode_dirty(), and skip the writeback pass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D9
