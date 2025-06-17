Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612019DF7A
	for <v9fs@lists.linux.dev>; Tue, 17 Jun 2025 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134612; cv=none; b=av7eGg/adYXqDD8dDYBBJo0PqFCiaY7MMNTfE9RCPIimHGJA1v2LJUjr2VVfaVzxOQ499IMtqpWfM+/yO77ULlubFBMoiTmogcRZ+TKe0QKaB+cZKi8vTqikcWBHqkGnvyD1tp644gBMXTCoogF4sTO4t+/qc4Per1n+a/P/3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134612; c=relaxed/simple;
	bh=coN5M7UgkY2OpbkDobN63+woVFkfmnwHWQ9uWlTZHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hp1TotFYhd0vAN+89c4gSnZnPqtx+xPFBiC0FRRVrOx01Bm2VgmalbcLINuNryLiittDivdtmF7f9UFmYBQmDmg4RvMEKH9EsUjGSdZ3wpg68LpbtJ016trtCzOygvrBrUbS++xNm97dUIUghAoAi0zhGbwJJZJMxzpM/QZEW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk7VZoj0; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk7VZoj0"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-52b2290e292so1507175e0c.3
        for <v9fs@lists.linux.dev>; Mon, 16 Jun 2025 21:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134610; x=1750739410; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdKsiLMagRvcTcqea0FT3P7to9kBSQlL+YJdIZTByqg=;
        b=lk7VZoj0rN7mSQ/HG8cDH4Gu4L0CYyadNUd/AX8xQtzgCq8J6sp43NUkJIAmuPTzLE
         rjVZaxApRrxYAAY6mUilQoG1dO5JLNpR67br60vrBXHRJ9LqoGnmRK9aUFCYuY5rEQfP
         eSjxQPcMB+ktjQM5lV93YS2mslcWqylo0Eze4U4iSH0KbABD3oHXqrE/K/JrnOLj8mZA
         cAgA+J+fckGFuRnW2vrkcM3oV9DCNwARupHWlR/niNSRNWXYxhK6nUVzXWEzCo42OGYY
         PP1MoqAJw3GrploWSQkVDW8mL6SIVZj6V8Ao4xi17YiXiiz09xWqq7Q0bKYr1ULE2BEf
         UDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134610; x=1750739410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdKsiLMagRvcTcqea0FT3P7to9kBSQlL+YJdIZTByqg=;
        b=WMFevDCgQ9E0J7ArWsX8EGZYNp9ev70pnK+ygGhQhlXALH+F3BCRa6HEWhDhtT14kd
         56DG6+UFCzaSzcjLqgmHBNrvh6rSrTRXbHj1xgmOzj+RfKFCn5lC+EMcHN5V3MmyUf/u
         PYs/pSN6OhXdINfzrYXlV+V+CgING0uENsk6cTFwJLhql8lUh5aIJOrtPI8lqE3C8YuA
         UMVaGgrF2q+xV63HQL2KmTtZ4sbnSBtNwbeHJJkUvzZfHN4xxFDWJDPuGkp1m90VdgyL
         D/2jV/Y5UX+b9awD6m9kWQGPjHPvwrmXi8pMf8DKTCz6nWHRvOmd4YguR2QrNYyfZRRz
         zkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHURUghpEkQJl//sXkPl233sVtuWFo6AJq59PSmAXvQaxlba8MVc+9tEhv//373WwQ2qrW@lists.linux.dev
X-Gm-Message-State: AOJu0YyO4lsHmIe6h58BzwmHftmlUv2TK8xyZRXewryuopBqgtDK1VI9
	j1IC7n5yD5EhNT7vgrnygIUAXu3/JAVsLsG3dbyUtA8QGiKf6ukCEMoXqUD0p7A/95XHP56B5Wa
	+dWRWaDf/xCNVlrwHeA6B+gcVcZJXlMA=
X-Gm-Gg: ASbGncs/HQWIOXWe8B76AQ06uDlaOr3YZhwG02i+BxfoBrvy9ga1+USQailPzJTYAGX
	wJExWqMqrqne9/mRzzPNdksKobIi7BLNPBMYK80PQiYIAWku90cvrIFCcrkt69ANftrU076xoz8
	wRxAMK/aBoDVTYl/jP0EF6J2pFY1z+gWbPMdzE9rlS6vU=
X-Google-Smtp-Source: AGHT+IHTmBxbg43YFIE3hUpcQPBuc9uhECGzAwz81EpCiNKZAp9dAkImEX4ozSqVERNQsnuQ2oWLSFxJZYEP55GTnqU=
X-Received: by 2002:a05:6122:547:b0:531:236f:1295 with SMTP id
 71dfb90a1353d-53149b13c25mr7399510e0c.5.1750134609942; Mon, 16 Jun 2025
 21:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616132539.63434-1-danisjiang@gmail.com> <aFCh-JXnifNXTgSt@codewreck.org>
 <CAHYQsXR43MGM826eHtEkmH4X2bM-amM29A38XUj+hMbNF2vDJQ@mail.gmail.com> <aFDrBwql20jYrvp1@codewreck.org>
In-Reply-To: <aFDrBwql20jYrvp1@codewreck.org>
From: Danis Jiang <danisjiang@gmail.com>
Date: Tue, 17 Jun 2025 12:29:58 +0800
X-Gm-Features: AX0GCFvdy8vwc6GGsH1z6dEO-kWs183kySUYlgW7khdw1zEVOhnXzoycfuBIxxU
Message-ID: <CAHYQsXRhFMEhgPvY_6PVjD=oiWf3DWgLCr78xy-fWvxZwAMT3w@mail.gmail.com>
Subject: Re: [PATCH] net/9p: Fix buffer overflow in USB transport layer
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, Mirsad Todorovac <mtodorovac69@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 12:12=E2=80=AFPM <asmadeus@codewreck.org> wrote:
>
> Danis Jiang wrote on Tue, Jun 17, 2025 at 11:01:40AM +0800:
> >>> Add validation in usb9pfs_rx_complete() to ensure req->actual does no=
t
> >>> exceed the buffer capacity before copying data.
> >>
> >> Thanks for this check!
> >>
> >> Did you reproduce this or was this static analysis found?
> >> (to knowi if you tested wrt question below)
> >
> > I found this by static analysis.
>
> Ok.
>
> >> I still haven't gotten around to setting up something to test this, an=
d
> >> even less the error case, but I'm not sure a single put is enough --
> >> p9_client_cb does another put.
> >> Conceptually I think it's better to mark the error and move on
> >> e.g. (not even compile tested)
> >> ```
> >>         int status =3D REQ_STATUS_RCVD;
> >>
> >>         [...]
> >>
> >>         if (req->actual > p9_rx_req->rc.capacity) {
> >>                 dev_err(...)
> >>                 req->actual =3D 0;
> >>                 status =3D REQ_STATUS_ERROR;
> >>         }
> >>
> >>         memcpy(..)
> >>
> >>         p9_rx_req->rc.size =3D req->actual;
> >>
> >>         p9_client_cb(usb9pfs->client, p9_rx_req, status);
> >>         p9_req_put(usb9pfs->client, p9_rx_req);
> >>
> >>         complete(&usb9pfs->received);
> >> ```
> >> (I'm not sure overriding req->actual is allowed, might be safer to use
> >> an intermediate variable like status instead)
> >>
> >> What do you think?
> >
> > Yes, I think your patch is better, my initial patch forgot p9_client_cb=
.
>
> Ok, let's go with that then.
>
> Would you like to resend "my" version, or should I do it (and
> refer to your patch as Reported-by)?
>
> Also if you resend let's add Mirsad Todorovac <mtodorovac69@gmail.com> to=
o Ccs,
> I've added him now.
> (Mirsad, please check lore for full context if quote wasn't enough:
>  https://lkml.kernel.org/r/20250616132539.63434-1-danisjiang@gmail.com
> )
>
>
> Thanks,
> --
> Dominique Martinet | Asmadeus

Sure, you can do it and add me as Reported-by, thanks!
