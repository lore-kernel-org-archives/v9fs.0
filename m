Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C774217F3F
	for <v9fs@lists.linux.dev>; Sat, 26 Oct 2024 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937685; cv=none; b=hWvAXTS19Y4/ueGVdL7otlRJZmixFB8085egs25pdPLG1No9HI8TCBUFiPVyHoMYPFylZ0/tyTzEXR9q5dOIoVY5MB07voPNBGH7a3+P7L9f4Kl9kmhIVkYdQRrOdYQMkTCN/v9PJdnCvyK+SLYP4dgVWIfq5R3IkkEW0OjLv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937685; c=relaxed/simple;
	bh=X180r3VolNsDSEAseUUHv1wHkhm8QzJhMimrE/RUOAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkI1WrFMs3+WByMvZsDaeSj0aOcLMaStrRxP7vHjck8KoYDkvNjBEZmBl01o6vp0Bh5DdC3hTHobcdzOyG6qG8aV9ZV59xoUndTiLGtDqaBjgUtP4pLBejo8rwDOdePVcfKIDNLTW2+Wcaqdx/uX1IJItzLb5h7wZ5OcoYVv4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVpyn3Ye; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVpyn3Ye"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e34339d41bso27291937b3.0
        for <v9fs@lists.linux.dev>; Sat, 26 Oct 2024 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729937682; x=1730542482; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71gq41Y8t4bQ3f//2CCau8OMlyvglDpBna9x3oSUIX4=;
        b=mVpyn3Yep+kZlLYQIIVxElrQ+yxH24/VbEd31Pj2HPLYR3UaQi++EgDu2yyxAfulqG
         LbhFXsVXvy1dxSKUSEk1n1w+Fo5xWhYs2TuCY6MSbf2u7Zb4MXwRiK8PJQtRHRm0bDS3
         lPrP2D9CQNeakGlF3BfEFgYCxo48VIqvroFaBrREVIF1nsrN2gfOTfSBXDWbZy5uIwbS
         YmqrwKVMGMQDE/SkgRqVyDRhmru12c7um2EjvLbBVDUNC91XKvI16xnWUlXcyNT/MVlw
         C+koKqxyzeB18zB9+FxaE2CVp6yQkStQQx+A3WQwMoxEZrNfgyiM7m51Ir/YgVWAy8xi
         uOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729937682; x=1730542482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71gq41Y8t4bQ3f//2CCau8OMlyvglDpBna9x3oSUIX4=;
        b=PC5j3BxLKBDYFickfBUtU9hcWWq/f6ar83wlosP2osSIX2D9cz7tCy4a26foW4Dgmd
         mxp+ULLVSN/oOus4KixMDsVqIu+5NKTpZJAVSW0jBLI19aTESzMk6L0rVRL+zg0lWINS
         9K3QqYCTNB/OswchM5ArkR5cVnCo8/eaJBl9NeqOEhycfGpDza1aO9icQW0bt2T1Gpql
         boj5T9kMndLp1ss4y25sEIke398Zx7ioAeaezlTOi8ABJep7WBgPyIl39mL0Z63FJJRw
         FY/roEF6oIZwrjxe8+z7IfcVDeesbbr0zmFjDnLGv3Cn0i4ZqW29dYTelXthkEmWVqQE
         9auw==
X-Forwarded-Encrypted: i=1; AJvYcCWjvBfEp/GKbfsJZ/eDLzvpTPG7eHLgu1pF/m1bNqxKdOIuYygn+YYMRMdp9lBBI/+IYyip@lists.linux.dev
X-Gm-Message-State: AOJu0YxEE8cz6avqnsvfMpXp3j0ITO8QqqY9/GCYG8oae56JvnWvOyqY
	+BPa0WtxXrCNvPoYfe6PpGqIIgfOOFaYg7eB1PE2m2PKOoy/8NQvQGBAjKOiKeB5svdh1Qj0WgL
	SPHE6zALWqM1wzcZ5s2QdSOzni+0=
X-Google-Smtp-Source: AGHT+IHrgQPbn8ROQAWlohxEuBSu2wy1ei+3mir8xASPD+3lG8R+l571NyrAlVicQR2fdSZ5GwJtG/1/T9mfa7mW7/4=
X-Received: by 2002:a05:690c:f10:b0:6e3:8562:fc0 with SMTP id
 00721157ae682-6e9d871679bmr22807357b3.0.1729937682017; Sat, 26 Oct 2024
 03:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>
 <ZxwTOB5ENi66C_kq@codewreck.org> <1921500.ue69UQ14vC@silver>
In-Reply-To: <1921500.ue69UQ14vC@silver>
From: Guan Xin <guanx.bac@gmail.com>
Date: Sat, 26 Oct 2024 18:14:05 +0800
Message-ID: <CANeMGR4E+MDKDudtfjgTD5yvc-HiC_L7tzsQm=2EbEH1RyPoYg@mail.gmail.com>
Subject: Re: Calculate VIRTQUEUE_NUM in "net/9p/trans_virtio.c" from stack size
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Eric Van Hensbergen <ericvh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Sat, Oct 26, 2024 at 5:36=E2=80=AFPM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> Guan,
>
> it took me a bit to understand why you would change this constant dependi=
ng on
> maximum stack size, as it is not obvious. Looks like you made this becaus=
e of
> this comment (net/9p/trans_virtio.c):
>
> struct virtio_chan {
>     ...
>         /* Scatterlist: can be too big for stack. */
>         struct scatterlist sg[VIRTQUEUE_NUM];
>     ...
> };

Yes, exactly.

> However the stack size is not the limiting factor. It's a bit more compli=
cated
> than that:
>
> I have also been working on increasing performance by allowing larger 9p
> message size and made it user-configurable at runtime. Here is the latest
> version of my patch set:
>
> https://lore.kernel.org/all/cover.1657636554.git.linux_oss@crudebyte.com/
>
> Patches 8..11 have already been merged. Patches 1..7 are still to be merg=
ed.
>
> /Christian

That would be better! I'll take a look at your patches.
Please ignore my patch for the moment.

Guan
