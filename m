Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC517106F
	for <v9fs@lists.linux.dev>; Mon, 22 Jul 2024 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677804; cv=none; b=S+0KZjQ16av73UQY7XEIxxR8jBauV1qpEJAzve44O78Ofm+LkX2Pcjq5+gWjqmHe+Jy+OoZncwmM/OzrDwpPFu2cBDm2T41oKTR6fKa7ZY37l7znzi4s2aBCifPhVy2fcy+5iJqaRkytRdXH7lZq03YIm5VahTYxq0bFSW/6tao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677804; c=relaxed/simple;
	bh=qEesoufBH1CtpEhf1yRRxdpihhjMDps1yrV6oxB0nDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6anT44gA6zweY9SeJ8yaNoZbNzIRjOqqw/Rh8FqH5FUHXHbnaXHM8US0/9y2iDudX+v7y3ZoUJpzhdxI9CU0t9oD2C9bPxjY/a0GUfe5AC4mR28ccYed1uvptj1+oz1VnXVtpHvWRJnoMZZaCtJnvUJtuLGp2jmuYRZckNHdEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d6301e7279so3073079b6e.3
        for <v9fs@lists.linux.dev>; Mon, 22 Jul 2024 12:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721677802; x=1722282602;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wO1mMsC6HVEPDDTEKEKbq3z8nsiCbwCukgnwMCIVF+A=;
        b=qNeFTuEO8ivblFQWDpvKLGEg12nE5vl6O5sgc5h3Kx96SkIpk7KTH/vTd3qVw1PTL+
         Oat4DNC8ecKkvPRBk24lfBlOZqEpHKhienHSrmZX2m4+ZBmwqwkV6ojSW6qKdjSeaDfm
         RmQ375DL5wOsf13M6JLHPVSwDKisRlDd8ZR0WnAmjdRFhMxYJ4MdEG+IbU/F7bbjMtsC
         kmdGuzmTVxxjoT1iqD7/MV3ap3naPPOX8vbzr2LVQaSanKGQ1FgA6vpJC8mLv0wOYih9
         KZRADrwTCuSZqahStpqeMsuUWzRBOHF5OYFEKBpNlWNydYA9Bf84sUJUKlCKSRu/4/oW
         VDQw==
X-Forwarded-Encrypted: i=1; AJvYcCUbr7NbOiTszyz2e/qzGGqYy+rN2N0ZX95v18pjE/CCX9aftWYdotJpaoBtfx7FxqqV1lRxtlwvecovcJaXC+Dth9/LbQ==
X-Gm-Message-State: AOJu0YwiuYoQaMguV0EKdAzJoOnDHhxTTwMKyB/1skSgDXxHW8SmIeqy
	0aJIGCX7VAoQrF++CTbPHBIUOktSA4ykIdN9R+xJJ1IeM0qcYoMo
X-Google-Smtp-Source: AGHT+IFKahbDe/mYKpotXiClsAJunP3HAyGiknXO5l6dzz9C8kgzrRd6S9jumpjqZUGEwaGq3qkbKQ==
X-Received: by 2002:a05:6870:d188:b0:260:e36f:ef50 with SMTP id 586e51a60fabf-2638dfb1ed3mr7312696fac.2.1721677801538;
        Mon, 22 Jul 2024 12:50:01 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2610cb01e5fsm1837337fac.48.2024.07.22.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 12:50:00 -0700 (PDT)
Date: Mon, 22 Jul 2024 14:49:59 -0500
From: David Vernet <void@manifault.com>
To: asmadeus@codewreck.org
Cc: linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, v9fs@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH] net/9p: Fix uaf / refcnt underflow for req object in
 virtio
Message-ID: <20240722194959.GB349610@maniforge>
References: <20240709162904.226952-1-void@manifault.com>
 <Zp4DSeHdOU0U1PZC@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wJBzqQ2F6P2dTm1V"
Content-Disposition: inline
In-Reply-To: <Zp4DSeHdOU0U1PZC@codewreck.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--wJBzqQ2F6P2dTm1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 03:59:21PM +0900, asmadeus@codewreck.org wrote:
> David Vernet wrote on Tue, Jul 09, 2024 at 11:29:04AM -0500:
> > We can currently encounter an underflow when freeing an rpc request obj=
ect
> > when using a virtio 9p transport, as shown by stress-ng:
> >=20
> > $ stress-ng --exec 1 -t 1
> > ...
> > [    5.188359] ------------[ cut here ]------------
> > [    5.211094] refcount_t: underflow; use-after-free.
> > [    5.230781] WARNING: CPU: 6 PID: 557 at lib/refcount.c:28 refcount_w=
arn_saturate+0xb4/0x140
> > [    5.247551] Modules linked in:
> > [    5.258476] CPU: 6 PID: 557 Comm: stress-ng-exec- Not tainted 6.10.0=
-rc2-virtme #26
> > [    5.276072] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS Arch Linux 1.16.3-1-1 04/01/2014
> > [    5.294310] RIP: 0010:refcount_warn_saturate+0xb4/0x140
> > [    5.313818] Code: ff 90 0f 0b 90 90 e9 16 07 91 00 cc 80 3d f9 14 83=
 01 00 75 90 c6 05 f0 14 83 01 01 90 48 c7 c7 97 ad 48 84 e8 5d d2 b5 ff 90=
 <0f> 0b 90 90 e9 ee 06 91 00 cc 80 3d ce 14 83 01 00 0f 85 64 ff ff
> > [    5.342462] RSP: 0018:ffffa9ac80a47a28 EFLAGS: 00010246
> > [    5.345307] RAX: b2786dec9d38b800 RBX: ffff9b67e704eaa8 RCX: fffffff=
f84c6e950
> > [    5.361743] RDX: 0000000000000002 RSI: 0000000100005ceb RDI: fffffff=
f84c9ed60
> > [    5.384172] RBP: 0000000000000000 R08: 0000000000001ceb R09: fffffff=
f84c6ed60
> > [    5.408242] R10: 00000000000056c1 R11: 0000000000000003 R12: 0000000=
0fffffe00
> > [    5.425085] R13: ffffffff8452db57 R14: ffff9b67cb3b2f00 R15: ffff9b6=
7c4e33ec0
> > [    5.444305] FS:  00007fb7ba9e16c0(0000) GS:ffff9b67fe780000(0000) kn=
lGS:0000000000000000
> > [    5.464612] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    5.481423] CR2: 00007fffcdf76fe8 CR3: 000000000c142000 CR4: 0000000=
000750ef0
> > [    5.498275] PKRU: 55555554
> > [    5.502138] Call Trace:
> > [    5.505372]  <TASK>
> > [    5.507353]  ? __warn+0xc9/0x1c0
> > [    5.511056]  ? refcount_warn_saturate+0xb4/0x140
> > [    5.520082]  ? report_bug+0x148/0x1e0
> > [    5.531777]  ? handle_bug+0x3e/0x70
> > [    5.543371]  ? exc_invalid_op+0x1a/0x50
> > [    5.557119]  ? asm_exc_invalid_op+0x1a/0x20
> > [    5.564184]  ? refcount_warn_saturate+0xb4/0x140
> > [    5.576789]  ? refcount_warn_saturate+0xb3/0x140
> > [    5.589334]  p9_req_put+0x9e/0xf0
> > [    5.598119]  p9_client_zc_rpc+0x3ac/0x460
> > [    5.611438]  ? wake_page_function+0x41/0xa0
> > [    5.620745]  ? __wake_up_locked_key+0x3f/0x70
> > [    5.631290]  p9_client_read_once+0xd8/0x2d0
> > [    5.644251]  p9_client_read+0x3e/0x70
> > [    5.655285]  v9fs_issue_read+0x47/0x90
> > [    5.668043]  netfs_begin_read+0x3f2/0x880
> > [    5.673140]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    5.676800]  ? netfs_alloc_request+0x21a/0x2b0
> > [    5.679999]  netfs_read_folio+0xde/0x380
> > [    5.685441]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    5.695729]  ? __filemap_get_folio+0x158/0x2a0
> > [    5.713327]  filemap_read_folio+0x1f/0x70
> > [    5.726596]  filemap_fault+0x28d/0x510
> > [    5.737644]  __do_fault+0x42/0xb0
> > [    5.747996]  handle_mm_fault+0x59c/0x13a0
> > [    5.759156]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    5.776631]  ? mt_find+0x2da/0x400
> > [    5.785758]  do_user_addr_fault+0x1fd/0x790
> > [    5.800640]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    5.813852]  exc_page_fault+0x68/0x180
> > [    5.822403]  asm_exc_page_fault+0x26/0x30
> > [    5.933431]  </TASK>
> > [    5.941515] ---[ end trace 0000000000000000 ]---
> >=20
> > The sequence that causes this underflow is as follows:
> >=20
> > 1. The virtio transport returns -ERESTARTSYS from p9_virtio_zc_request()
> >    due to virtqueue_add_sgs() returning -ENOSPC, and wait_event_killabl=
e()
> >    eventually returning -ERESTARTSYS.
> >=20
> > 2. The request is never kicked, so its reference is dropped at the end =
of
> >    p9_virtio_zc_request(). This is the first of the two available
> >    references.
> >=20
> > 3. In p9_client_zc_rpc(), the client is still connected, so we call
> >    p9_client_flush() which drops the second and final reference in
> >    the callback to p9_virtio_cancelled().
> >=20
> > 4. We reference the req object below in p9_virtio_zc_request(), and then
> >    hit a refcnt underflow when we again try to drop a reference in the
> >    reterr path.
> >=20
> > Let's fix this by only dropping that reference if we're not exiting due=
 to
> > -ERESTARTSYS, as the assumption is that the reference will instead be
> > dropped later when we flush the request.
>=20
> Thanks for the patch!
> I hadn't forgotten about it, I'm just not convinced this is the only
> problem we have around these refs or how to fix that, and haven't had
> time to look in details...
> looking again now I think we can sum it up to a p9_client_flush problem
> instead: basically dropping your 3. instead of dropping the 2.
>=20
> If the request really was cancelled we'll get the flush reply before the
> response and that'll drop the second ref in the cancelled callback,
> which would also blow up, but afaik qemu doesn't implement this so this
> code path so this was never tested.
>=20
> And this also made me notice our cancelled callbacks are all over the
> place with rdma and xen not doing anything about the ref, so let's make
> that ref dropping common, so we can remove the virtio callback
> altogether - I'm now starting to doubt if any server actually implement
> cancelling flushes, it might be worth testing with a synthetic fd mount
> as syzcaller does..
>=20
> So something like that (untested)
> ---
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 5cd94721d974..51ce3bd4aece 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -616,9 +616,10 @@ static int p9_client_flush(struct p9_client *c, stru=
ct p9_req_t *oldreq)
>         if (READ_ONCE(oldreq->status) =3D=3D REQ_STATUS_SENT) {
>                 if (c->trans_mod->cancelled)
>                         c->trans_mod->cancelled(c, oldreq);
> +               /* reply won't come anymore, drop the "receive" ref */
> +               p9_req_put(client, req);
>         }
> =20
> -       p9_req_put(c, req);
>         return 0;
>  }
> =20
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 196060dc6138..5184730a2639 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -737,8 +737,6 @@ static int p9_fd_cancelled(struct p9_client *client, =
struct p9_req_t *req)
>         WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
>         spin_unlock(&m->req_lock);
> =20
> -       p9_req_put(client, req);
> -
>         return 0;
>  }
> =20
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 0b8086f58ad5..1c1fd9fbecc9 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -195,13 +195,6 @@ static int p9_virtio_cancel(struct p9_client *client=
, struct p9_req_t *req)
>         return 1;
>  }
> =20
> -/* Reply won't come, so drop req ref */
> -static int p9_virtio_cancelled(struct p9_client *client, struct p9_req_t=
 *req)
> -{
> -       p9_req_put(client, req);
> -       return 0;
> -}
> -
>  /**
>   * pack_sg_list_p - Just like pack_sg_list. Instead of taking a buffer,
>   * this takes a list of pages.
> @@ -793,7 +786,6 @@ static struct p9_trans_module p9_virtio_trans =3D {
>         .request =3D p9_virtio_request,
>         .zc_request =3D p9_virtio_zc_request,
>         .cancel =3D p9_virtio_cancel,
> -       .cancelled =3D p9_virtio_cancelled,
>         /*
>          * We leave one entry for input and one entry for response
>          * headers. We also skip one more entry to accommodate, address
>=20
> ---
>=20
> I'll try to find time to play with it a bit more overnight then send the
> patch proper and ask syzbot if that fixes this one:
> https://lkml.kernel.org/r/000000000000c18c15061dcff478@google.com=20
>=20
> But if you could also test that'd be great.
> Shall I keep you as the author for the above, or would you rather just
> be reported-by given the patch is different enough?

I appreciate you asking -- I'll leave it up to whatever you feel comfortable
doing as the maintainer. Happy to keep my SoB on if the patch is close enou=
gh
but whatever you decide to do is fine with me.

Thanks,
David

--wJBzqQ2F6P2dTm1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZp635wAKCRBZ5LhpZcTz
ZC6mAP9BbffHgNeIysY9e7fWRxuDChtb146TdCR44C0UcW2VOgD5AZBzqmHDNWQd
C/bjTm/sGHzklOZJ65yWR2ZllPyeUA0=
=2rhT
-----END PGP SIGNATURE-----

--wJBzqQ2F6P2dTm1V--
