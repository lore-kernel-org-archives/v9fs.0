Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B58342513
	for <v9fs@lists.linux.dev>; Thu, 18 Dec 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063609; cv=none; b=eu5SWVaVFWnJk6nQvhAFsGcOllkEUFrqqxEQ0ki1vIj5XAvFbVSfoDDnmV9BsXXwhBYAFz0HsCUjU+Wu0NJqM8hcVKVRGUWUZb4ZIDhpQdDQaEOJ86HuxJL//q3zIUFjaLcFZ8S7AXIQNgSz2lrPbmkRDrJGkQe32/lk38c85Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063609; c=relaxed/simple;
	bh=Zlh5vI+CrN24QeQk/aItHM0Zg8/F68dLTMZnH5LC4AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGyhT4grLmDcHCYl6j325aIM7vhjNqeJhwhve8+QGDrWt0XaoTLBCrYVCJ4i/MHcadTKJsNM1vQfFq4c5gssoT4TgL6xlW5b2KrhkuPYiRke3sFcftqDJHt9AAu8bu06ZE7V/E1dBWisIoMauV4WQyf/+WjtZDAJR0jIWm+zneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCF9oWAy; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCF9oWAy"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11beb0a7bd6so2338539c88.1
        for <v9fs@lists.linux.dev>; Thu, 18 Dec 2025 05:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766063607; x=1766668407; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKSaZufHZUM53KO6BXQdqsfNY+HLu3VBp95+DIcXO1U=;
        b=hCF9oWAy42crMnd+VDgVoj1wMhPGm+hchh0sNMMQifm50aq9g3JVROH0UXu917XVIw
         HoGtmHU9omi7Z8mQOjCjIiN/E+w3EgguBT0U6Sp0LPpEXhfCx58p2qXs2lllseCp+S1C
         f5+psQ7xqVmaZKdgU6glL5Tsk0NHAuhmYebOHRfbrGi7g0SV2MtIntTpgqxsDR8MnqNW
         qlcmQgPV1IZQ8zB5hplMPNqGLGV9vDGo6zgL0+LyHC9sl3aN5N3KcszGY0TrXakYNIqw
         9o19giA1foFhNk4/FCSZXFAFQ2t9NXVHS7bfhqSXXlBu7XVi571MJXnGh+0le3rc9604
         VIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766063607; x=1766668407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKSaZufHZUM53KO6BXQdqsfNY+HLu3VBp95+DIcXO1U=;
        b=JnpKN4f1BFbXHQdxHauB98CkWgVnAvu2MVVc0D7zFsfJnrtUZ2abhGJRXiAyDtDEF+
         3BfV54MWkJS/ZoyTehbcx12RZexytKuHQyhAsLjWMdSJXW4tgmrIfEjpWRE3tfM34aSu
         IOyT6kAoOvCyS7luJ+yvJWd1l5PoTnhxEff5UQ+KoOxKiIzC5MaZCt0VmQoa4ZHwJP0w
         /vt6VCUnye8hj1lWsHq8UCz3FkhsZhEZpjJoHfkoORhlVjmGbLoNXs5IVrYD84mRatf5
         Nm2mcqimYhzy0a3nR0OjnzooOOXyb02Q6UuQIWeORAFes8N5Mki+AJDCuL9NPqkQoSw7
         YXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgRWPphhpEou7Or5lunPs+U5ijB8vR2EatuLtPwjZ7kRxDmnip53ehcQvE+5MmkZ/wrdUI@lists.linux.dev
X-Gm-Message-State: AOJu0YzS8cC9qIXY1V+rvVnkIyfr7SF9QC8oAsWQIUV/sRbgMr1/7yWT
	UiNrLecUf5nCsg8ypzxdFC/f/8wvfJ7QTr1fFivBrwcGfNEAyEqqOf9L+ivVhc7k8r+ojviCwZP
	C4VapiePxEfrtBL+lXu1oVVKGvuxC2yk=
X-Gm-Gg: AY/fxX6P9zn1vdvRG60mYk3mRoNUl16YkP9TSQiMndPaXa9WQa7gIhSQ0Fy99T0Kiyb
	XL3BfEWrfeCb2x6rcHSeOy1gvO/IGZlAAYULS4Yqs10nXopb9qy1R8mRHEsxzJ1VqDY+d1IVDCX
	FA+EdpJo1mi5XepQgpvlo/8loZ1DbBdbJxCwFxH95/2LQuwryxMcviwouu/xQ+LfEwfJfxSbruY
	rgvKC6pivEbSR57xL6I0UuvLSGc17WH8PvXv4abF6ESTjsoBJJpNv7D7rqtZaX/BuakE6ClkX/S
	IeHTkys=
X-Google-Smtp-Source: AGHT+IELtLR6Joc1DuUuiHj6CgvjF1He93ndU3Run4qFx30DyREZolxHID92eyZJtDgcqpmxM7rczyL5rYYc7GqI/Ao=
X-Received: by 2002:a05:7022:619d:b0:11b:9386:a38e with SMTP id
 a92af1059eb24-12062163989mr2754630c88.21.1766063607000; Thu, 18 Dec 2025
 05:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251218071012.7740-1-islituo@gmail.com> <aUP55AOY3L_TLkE3@codewreck.org>
In-Reply-To: <aUP55AOY3L_TLkE3@codewreck.org>
From: Tuo Li <islituo@gmail.com>
Date: Thu, 18 Dec 2025 21:13:12 +0800
X-Gm-Features: AQt7F2qeRVBDCuwpjbiWdi-vb-bWGUtmI-PKMi1TSpkXQbHW9yYQXaIdQQhh3_U
Message-ID: <CADm8TenzjtK7pHVJnVuxjK=rWAumhY7oZf+yoZ7OV6aSdd+2gg@mail.gmail.com>
Subject: Re: [PATCH] net: 9p: Fix a possible null-pointer dereference in p9_cm_event_handler()
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 8:56=E2=80=AFPM <asmadeus@codewreck.org> wrote:
>
> Tuo Li wrote on Thu, Dec 18, 2025 at 03:10:12PM +0800:
> > In p9_cm_event_handler(), rdma is checked in the RDMA_CM_EVENT_DISCONNE=
CTED
> > case, indicating that it may be NULL. If this happens, a null-pointer
> > dereference can occur when complete() is called:
> >
> >   complete(&rdma->cm_done);
> >
> > To prevent such a potential null-pointer dereference, add a defensive c=
heck
> > before invoking complete().
>
> In practice it doesn't really make sense for rdma to be NULL here
> though -- and we can make sure of it by assigning client->trans before
> creating the cm_id and get rid of the other null check instead:
> -----
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index b5ceae1cccbb..f2d81f3ef255 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -145,8 +145,7 @@ p9_cm_event_handler(struct rdma_cm_id *id, struct rdm=
a_cm_event *event)
>                 break;
>
>         case RDMA_CM_EVENT_DISCONNECTED:
> -               if (rdma)
> -                       rdma->state =3D P9_RDMA_CLOSED;
> +               rdma->state =3D P9_RDMA_CLOSED;
>                 c->status =3D Disconnected;
>                 break;
>
> @@ -541,15 +540,15 @@ rdma_create_trans(struct p9_client *client, struct =
fs_context *fc)
>         if (!rdma)
>                 return -ENOMEM;
>
> +       /* Associate the client with the transport */
> +       client->trans =3D rdma;
> +
>         /* Create the RDMA CM ID */
>         rdma->cm_id =3D rdma_create_id(&init_net, p9_cm_event_handler, cl=
ient,
>                                     RDMA_PS_TCP, IB_QPT_RC);
>         if (IS_ERR(rdma->cm_id))
>                 goto error;
>
> -       /* Associate the client with the transport */
> -       client->trans =3D rdma;
> -
>         /* Bind to a privileged port if we need to */
>         if (opts.privport) {
>                 err =3D p9_rdma_bind_privport(rdma);
> -----
>
> What do you think?
> --
> Dominique

Thanks for the clarification.
It indeed makes no sense for rdma to be NULL here.
The updated fix looks reasonable to me.

Sincerely,
Tuo Li
