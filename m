Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD28C2FB
	for <v9fs@lists.linux.dev>; Tue, 17 Jun 2025 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750129315; cv=none; b=CjhLXJiWBgOdj+refW9Je6JsckA71cQ/JIllRDSGH1kU+wceJcDobf7b4slyi+IMEFoPlHMKxWGQfXr+uwXd5aYDmea/1UBFagQBuoWL6it7lMrtlovyGR0saAxLLOYrBhl8M9/H3cWlpK24i5s/ZMIGTonyRbN49R72zAvJBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750129315; c=relaxed/simple;
	bh=+nsuOjHKSn+wU7zKSuad9aE9Iy7woMm2OR7+pFpohD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbJSCVcskO2RKsI0DC4mY+RHlpcEZz6784QciqAA9k7MjpSZovNse/rz33GtUpNaahGYceKsCKCo1GrH/5L9zq9jga6x3u421CkxWfm94Ne5LtHyl7VXjSwJ5gKvYx3MPmPMHunFlV61qynh64HIEsXfXWeqCPCOgEtd5YT2X/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNbfbwoM; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNbfbwoM"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53145c74e15so902653e0c.0
        for <v9fs@lists.linux.dev>; Mon, 16 Jun 2025 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750129312; x=1750734112; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u75Z/m51HLoqvQuvmxYYX48fqhq+BQTGNtp2KTyT5vE=;
        b=YNbfbwoMF6sERmjetz43kLAXF7JDG47XuII2Y9yo5u3MVVqXRz4+Ak3/+WnTYZLxlo
         tBXrU8zXwI14AyiziAaJ7SoH4k/F/r6CsHAcgwnM3+Fqtdtn5hs+DjK0QEsZVWcj2duy
         YVql9zn1OM7zM+K1InlOJ/ApOVsLzMKiKfP5L8bVqVrjHGHXC8jw0LVyQRIj3UQsdcHB
         1BdT7Cs0cm7+WDetuGxWAf2NEbHDkSvVvZSYyh57xFZQhRvlHdVj3U4Ypnok/B39OuAr
         4zREhmf4FjnyLdnD0Yg6iDJcJ4Jh5snceX9KcS7owCKKzqtfmfvwqKqP3IATFPJih0L8
         9Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750129312; x=1750734112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u75Z/m51HLoqvQuvmxYYX48fqhq+BQTGNtp2KTyT5vE=;
        b=UEvHtrqIGacIo0L9+4iAysZ2q5Us44D47dLL4TeH2p9jAVjj2xSLSKpth6iRC0XtBN
         FcxmMs96PRefZE4+6hXv6XRwmyCZ5yY+te/mWHwRDfRZxmECm5dquqyQM3qIcn48+WrK
         xJTWSn0TEDkWYRo+BEHbevwFOYfDl1l+DFeQHAJ+YbUyT6+OP3/pQ7EFFqeJtBl8cTsD
         kdV4QMaqMLpvYpYt8TABNi4OPndodZN7g/o/X3Zpm7nBLKEG5TIiM2RDjaNb/AaUAydW
         67CI/tFo+QA3kdnzt9qRzlQOzoP7yyGhn7vHrIHcHvhZ0G5plecyvt5OPRvINRPpnMQi
         QWIw==
X-Forwarded-Encrypted: i=1; AJvYcCU9LT0lpnNzWNI8sBUI/XGT0TDxrPmi6QnLu8MQ7E0RO+azaehymiJk6f0iFlmR3XUpTf8v@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl3WVddosp7DeOE0PxGZOk0LoYoMFLC1qoq+M/KjmiRrIvVciy
	D0p/k1d9NEgyoP8YirFj12gt3xqxNlOb1a6FR6Pxfow8DP3yphf5DVgCeHDMG29ziqGLjPAk4Wb
	1rl3t4C5Nex4PEQywHW/JU9tOFGdrWGE=
X-Gm-Gg: ASbGncs6otwE4s/USQkhMRZodPmGpt1NSNPUyNZCoxKf/WWmOHpefxhm47v8nApe0W/
	6iFnorNyr0Vb7Wm25nhnQra/k7fkTkj5nRt12k9E77MuzfQZ+I9u3oU5dPUKyFQ5WNwo6EW04xN
	xrXXLeqM3zCrmZbJkYgVtEVkGBaGeZE+GiqWACmArffC4=
X-Google-Smtp-Source: AGHT+IH3O0bo9lTKoYDcGH9D7lVDop32g1C5r70VHXuxW/nd9qbrLusDr29m441OZsEZGw0CB3nvZH1Gj9WsqLJ29zk=
X-Received: by 2002:a05:6122:3bd0:b0:531:3900:8551 with SMTP id
 71dfb90a1353d-5314989a8eamr6802796e0c.8.1750129312186; Mon, 16 Jun 2025
 20:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616132539.63434-1-danisjiang@gmail.com> <aFCh-JXnifNXTgSt@codewreck.org>
In-Reply-To: <aFCh-JXnifNXTgSt@codewreck.org>
From: Danis Jiang <danisjiang@gmail.com>
Date: Tue, 17 Jun 2025 11:01:40 +0800
X-Gm-Features: AX0GCFtKyrfm9TIjR5SftUPZL2VQwc6OnrGk3iuj5hx40J4WFoWm2EVEyMO3TCo
Message-ID: <CAHYQsXR43MGM826eHtEkmH4X2bM-amM29A38XUj+hMbNF2vDJQ@mail.gmail.com>
Subject: Re: [PATCH] net/9p: Fix buffer overflow in USB transport layer
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 7:00=E2=80=AFAM <asmadeus@codewreck.org> wrote:
>
> Yuhao Jiang wrote on Mon, Jun 16, 2025 at 09:25:39PM +0800:
> > A buffer overflow vulnerability exists in the USB 9pfs transport layer
> > where inconsistent size validation between packet header parsing and
> > actual data copying allows a malicious USB host to overflow heap buffer=
s.
> >
> > The issue occurs because:
> > - usb9pfs_rx_header() validates only the declared size in packet header
> > - usb9pfs_rx_complete() uses req->actual (actual received bytes) for me=
mcpy
> >
> > This allows an attacker to craft packets with small declared size (bypa=
ssing
> > validation) but large actual payload (triggering overflow in memcpy).
> >
> > Add validation in usb9pfs_rx_complete() to ensure req->actual does not
> > exceed the buffer capacity before copying data.
>
> Thanks for this check!
>
> Did you reproduce this or was this static analysis found?
> (to knowi if you tested wrt question below)

I found this by static analysis.

>
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transpor=
t")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
> > ---
> >  net/9p/trans_usbg.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> > index 6b694f117aef..047a2862fc84 100644
> > --- a/net/9p/trans_usbg.c
> > +++ b/net/9p/trans_usbg.c
> > @@ -242,6 +242,15 @@ static void usb9pfs_rx_complete(struct usb_ep *ep,=
 struct usb_request *req)
> >       if (!p9_rx_req)
> >               return;
> >
> > +     /* Validate actual received size against buffer capacity */
> > +     if (req->actual > p9_rx_req->rc.capacity) {
> > +             dev_err(&cdev->gadget->dev,
> > +                     "received data size %u exceeds buffer capacity %z=
u\n",
> > +                     req->actual, p9_rx_req->rc.capacity);
> > +             p9_req_put(usb9pfs->client, p9_rx_req);
>
> I still haven't gotten around to setting up something to test this, and
> even less the error case, but I'm not sure a single put is enough --
> p9_client_cb does another put.
> Conceptually I think it's better to mark the error and move on
> e.g. (not even compile tested)
> ```
>         int status =3D REQ_STATUS_RCVD;
>
>         [...]
>
>         if (req->actual > p9_rx_req->rc.capacity) {
>                 dev_err(...)
>                 req->actual =3D 0;
>                 status =3D REQ_STATUS_ERROR;
>         }
>
>         memcpy(..)
>
>         p9_rx_req->rc.size =3D req->actual;
>
>         p9_client_cb(usb9pfs->client, p9_rx_req, status);
>         p9_req_put(usb9pfs->client, p9_rx_req);
>
>         complete(&usb9pfs->received);
> ```
> (I'm not sure overriding req->actual is allowed, might be safer to use
> an intermediate variable like status instead)
>
> What do you think?
>
> Thanks,
> --
> Dominique Martinet | Asmadeus

Yes, I think your patch is better, my initial patch forgot p9_client_cb.

Thanks,
Yuhao Jiang
