Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732427E049
	for <v9fs@lists.linux.dev>; Sat, 14 Mar 2026 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773473072; cv=pass; b=aQOsao2LXpB6D29TLmryO8Hm7oucXGTw/oo7Wr2agW7k9D2c7wzzManNM92KPSACwwFbOnh5iLOLEkUZkAmfQuJNU/n/KteL0vEnbzvmz+PQQJltTFuu2oxBxR+ctYPwerhxMfJlsyu/MrSrZQ0ZX0FPrBUPjW718xflFNKJM+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773473072; c=relaxed/simple;
	bh=qd1mApvWSGdixoIc5To2ikkz4kciaMH/nUOF9Qefu6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSqnEWsp9Hdu2rSDZT4+5sp6ky4NgdgPnJAimXFZJfQYFgqLeInzWOc7CUq3X/5L13m21wpf6QwZHAxHiXpr78K4BjwOWTBubSN6ss8gaYzRwFXyPj2LdRVTfKQo9q/NsIjAVzyIF8bLIHH8mr0gTwVhomJrZcCCbqU43JIE+Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYDd7j2b; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYDd7j2b"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae88e16485so20819265ad.0
        for <v9fs@lists.linux.dev>; Sat, 14 Mar 2026 00:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773473071; cv=none;
        d=google.com; s=arc-20240605;
        b=TujywXVbk8YXvpI32WRq78XhRUJcNfrcsCttxi4KS3+apB14xJ7iP0g9tJtc+GOpeP
         gBh8U4Jte+DzMz3GeiqB+uM39wnBfFNGZwKkJE4SznuGD+DNcloJE6Y8WKsE6V15QcLw
         /h2H3Lb6z73pD8ETpyO5biMUhTmtxsiQgLWLhBy5ksQjV06m3RFCuvc84p8F5MCsYnTz
         i8cVKZfetzF/4ueOnW9QS9gepBl74wzgjxb8QTqZzmEqGugu78S5UyPBHPiUJbKgZfnF
         PMpMM13xUleD9CIyWOQ23HlTMvcLlZXsC6aLSNpCA64feCtDhyfyNO7uTKcvLA4yMTG/
         LtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qd1mApvWSGdixoIc5To2ikkz4kciaMH/nUOF9Qefu6o=;
        fh=HipF1Yd7cNeBSXYM1jnZjqikuxevheaTZgfqPDmhvMY=;
        b=JN4//1t3uYX1T1IfuZzMMFeEtEayfpqeQ3PpAWrq3y3KrpuYtyYijWVD8DSQ+gwUBl
         KHKlmKMXwUXNW0spmaGTjdKQgtQ2gJQUE8UMEmG3GGESqtYIZHEvq5kTQErZiCyVtAgl
         b2tfWr0hEGKNLKYE3QCBHgipLMccxedQPbSGDk1TdDLFQfQN9d5DNMGsyXTWNe/thX4Z
         dk8rrMzrFERYcfBjgDkLtoXR+T7fvfDME1SBlVh+u90O9sNAdhh3axf6ickrb/MKzg/p
         FP8AJq+ar3rKWnT7A8hND+Rm3ulmRIDb7P8OqLnVw9sG+RTA9dJtWaxgCUDdrQysC25F
         RVFw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773473071; x=1774077871; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd1mApvWSGdixoIc5To2ikkz4kciaMH/nUOF9Qefu6o=;
        b=FYDd7j2banOb3WZJ1xDN/4dZokEfIOQ7XTUDdkhpMNVUQyCTF8baKOQFEZS4YVQFSU
         M2fDZJ+OgJESFqDwaI3TNHOP9haBY0AsDYt40KkzmxWWXlTNG1x4Ec2I84YS8sjhfoL+
         LOwiHSce1shoP2gRP3F8msIXQvkVJ6WDm2WF4LCiXoOGsW32TiXDYpMHa67Mly5f6JAz
         4CRB2LzCVRkda675GQ9XViMsHSHOIxsJHwrzKL8qmK5DmuenoOebIcUYY1uqPVKqfCob
         03ECuykLaxW6iUevvkyh/T2kbuRNeMtQL7HH+qaZcmM92GOmB1yEtEQ+ipCxeEHquOs+
         T3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773473071; x=1774077871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qd1mApvWSGdixoIc5To2ikkz4kciaMH/nUOF9Qefu6o=;
        b=tWkrkdHWODp+3sso5SHdP4B+XJYfQ7uS3DB2RU8706A5GWa7+zQHPvbHr/Sgp5esFe
         Gcvhc8Daot3P/fQHAUKSykfrlF3ZYxiGdyxrtEPjaoNwwRmprg+9IY5SzreA0h0p23Jd
         P178ihYoOHtaF0aXku8kFInJcKpv2P1c7oo1uxmhDCoS+jdTXAXh8ejM4UiXbEdHbxcG
         ivqV/U5lmpuhm/ducIiUUdCVDyfRI29rm4NyE2n1RskD2BXI3O+wQZ/1Qgvnoy7rmizE
         5BXaAht8mvsg02k4y7VtgCzKEhzeRz8/tvMLe9o+erobZg8WPu+shLHkeWNN/c8zPc+L
         djJg==
X-Forwarded-Encrypted: i=1; AJvYcCUUlMuOJkNMAWa+QsaAJETba9zxKemENpTiGzX21iNBa1E0hHjaWtwxglPiHTDHFYxcPMVj@lists.linux.dev
X-Gm-Message-State: AOJu0YzJw9vR9VN4ZJz4+Vao9NvVoOGA1C4uLY9Xhum2V0CI9ySPm3Eu
	KfYcoVrdNJdd0PvVbuXGf319tziS7hr1i0apdR2O7/VLKUltE76wyhz8rmPRs1Z2MZxQD5Qibkv
	B5DRsVxXKynrIEXuUL0D4QX4WUb67xus=
X-Gm-Gg: ATEYQzzUtss10rtXT6OH3mdIf5hhQuWqvihRGJoA7lAws6XooaCL7FKk5F0p4Tbl+zN
	5Y5ztTCxM2Q2sBO5riTlT6vEHE4WVqI+ct1N2yaDxzLmSMwMgwkK/BwTBNrGaI67krpWU62TF02
	Y+W3Zhz0uSzp33VGm0K+NH1wnsdq0ZcdBgdfqaJIp9IqGgmS5hMJfWcFGsRIJNXg9RbItr6B2gS
	cwOq86I0b1CwXXYxVU4LtRx5zj3rMkgfpeLrVTz+dSSqw2cianwqFnQNx+b7f6di1p+Il244BWV
	HwgdzkA=
X-Received: by 2002:a17:903:19e5:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2b0445a8fcemr11849235ad.15.1773473070880; Sat, 14 Mar 2026
 00:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260313171659.1225180-1-jhj140711@gmail.com> <abT5tabfYV9a9RF_@codewreck.org>
In-Reply-To: <abT5tabfYV9a9RF_@codewreck.org>
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Sat, 14 Mar 2026 16:24:19 +0900
X-Gm-Features: AaiRm524CjQgXxwQSi91n87psT0kd7Ixm0ZGTwgZZypsCLtk7Hh1FbeoE-z-Zz8
Message-ID: <CAP_j_b9i2n+ZUriWceZJgAKz_MeGMFkRiOz7yCYE4as4T6auVQ@mail.gmail.com>
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
	m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org, v9fs@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the careful review.

> Just to make sure the problem is the usb9pfs struct being freed, not the
> p9_client itself which is still alive after the usb device is gone
> (until umount)?

The issue I am addressing is the stale use of the usb9pfs->client
association after the transport has been closed. I am not relying on
early free of struct f_usb9pfs for this bug.

The lifetime mismatch here is that struct f_usb9pfs belongs to the
gadget function and can be reused across mount sessions, while
struct p9_client is per-mount. On the close path, p9_usbg_close() did
not detach usb9pfs->client, so late TX/RX completions could still
follow that pointer after close, including into a later remount that
rebinds it.

> I'm surprised free_func isn't called after unbind, which should stop the
> queues (through disable_usb9pfs)?
> or are the ep being disabled not enough to ensure the callbacks are not
> in use? (e.g. disabling prevents further calls, but doesn't wait for
> currently running/queued requests?)

My understanding is that the unbind/free_func path is different from the
close path at issue here. This patch is not trying to change or rely on
gadget teardown ordering; it addresses the close-side race where
usb9pfs->client remained attached and the completion paths still
dereferenced it.

That is why the patch:
- clears usb9pfs->client under usb9pfs->lock on close,
- detaches any pending TX request from in_req->context, and
- makes TX/RX completions bail out once the transport has been detached.

So the intent is to prevent late completions from using a stale or
rebound client association after close, rather than to claim an early
free of the gadget object itself.

Thanks,

2026=EB=85=84 3=EC=9B=94 14=EC=9D=BC (=ED=86=A0) PM 3:01, Dominique Martine=
t <asmadeus@codewreck.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hyungjung Joo wrote on Sat, Mar 14, 2026 at 02:16:59AM +0900:
> > p9_usbg_close() tears down the client transport, but usb9pfs keeps
> > using usb9pfs->client from asynchronous TX and RX completion handlers.
> > A late completion can therefore dereference a client that has already
> > been freed during mount teardown.
> >
> > Clear usb9pfs->client under usb9pfs->lock when closing the transport,
> > detach any pending TX request from in_req->context, and make the TX/RX
> > completion handlers bail out once the transport has been detached. This
> > keeps late completions from touching a freed or rebound p9_client.
>
> Just to make sure the problem is the usb9pfs struct being freed, not the
> p9_client itself which is still alive after the usb device is gone
> (until umount)?
>
> I'm surprised free_func isn't called after unbind, which should stop the
> queues (through disable_usb9pfs)?
> or are the ep being disabled not enough to ensure the callbacks are not
> in use? (e.g. disabling prevents further calls, but doesn't wait for
> currently running/queued requests?)
>
>
> (Also, thanks Michael for looking -- I'll let you do a first review
> before looking deeper)
> --
> Dominique
