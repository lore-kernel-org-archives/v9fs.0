Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD536154454
	for <v9fs@lists.linux.dev>; Sat, 26 Oct 2024 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729926467; cv=none; b=g6KGuGqG6J8j1HRA9kKxMiaRQohSKjI1hsH84UKI8IxDoem2ZYPqfmVpouBL9l7sMV1kPo4sR+KAQb9aCiC3Vd3Bxti35fCvEZkO2zA/E/HI1VGerhQQ0KFx/8o3ldAO8TfG/qgRN3/r0IwUImyzuYODn4a/XT5Kz+g3CI8mi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729926467; c=relaxed/simple;
	bh=hoTSZJngHiober32o6tA8UtxNG2+oOVmktAiLr3qtAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qi+nxNFtv69LVLJEdDJ2s0GmtdNcwsbmenK6fgofBj4W7WcKHp8B6j5aI6/fTZbiSrdI6QJMCmALLQVdemL6SfadLPzYCaBchClaF7WvNh5SB99jh9LQQCMa8D6EdAlB/4oxbTh5MR4ONFxpPtDlohSX+8gxhCk+LF8+ZIbmy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i09g715Z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i09g715Z"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e5fadb5e23so24842147b3.3
        for <v9fs@lists.linux.dev>; Sat, 26 Oct 2024 00:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729926465; x=1730531265; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUPGuf/B41PecwUAIA/RMCoEgGV/IQ+8muJ7AxScygU=;
        b=i09g715Z7Tk5kJYKjbpiqq0bS2HNcs+QyUTkVjMLFkXdS8QhxTD4sjKMr2mVOwkYXR
         9DjwrPM8sTMzeKA3CY2Nkl1JTULgEir4jdsn8KDC2JwGVHXF1hggjWqAB0mjJVHUUycF
         i2/+xAUKBi8iTP9Z8DFvBwTH+UMxQeGUd2ab8QXmIqXjxax22K0hvyy3NzGdsYWzYDGK
         5MzfvIWb6wZpgdQdzvsYV4QHpfUiNOOh563WP+vdzb1ZYiaIpuE7OLLXkIGTXUzyfg0E
         oyfp0tmyeP+1sOuNu+G3Q/HlSBxXQ14R1WtCrEmrdl+VxiZQ4nQ4Y6eXPFOeJX97251p
         9UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729926465; x=1730531265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUPGuf/B41PecwUAIA/RMCoEgGV/IQ+8muJ7AxScygU=;
        b=hc51VTl+1wXCWZVeKs78GomGVL4Xjrn9yCAAD+hY9fEtpId6UUr7ISNm95OSK8x8oK
         pDVDUQIFzZKvbFYD/qHoLaMlsFWu8DmmNYJcqMwOIMcsujR5k9xfCy4czo4XYfzI1Lqf
         YLkhtr99450VY+iyFdGQrTRFvvp2ZiWxwdhk8cgcsyPcf4jyr5KqYqQU1Rmmfrp87qsX
         wPoJg10iYL9Z3fG8hRzcd6qQ4x1TTi4eJeUddrO+FR5O3Xwyu6wUbsad1fVyej1mdCgB
         WjX3ZI4hh+PozWFIQay/NiVvEyVSWeDna+I7Uw6mPjnOxzB14griqR0QfM3qu2ub03Jl
         s7zw==
X-Forwarded-Encrypted: i=1; AJvYcCW0ToSOjfhWe1KGua19St2f+ISHqxzUfnrmsWtVjgR0TkNI06OiraSaxwmmgAcaDefmxw+6@lists.linux.dev
X-Gm-Message-State: AOJu0Yw92RmD5zeHnpmcvJqYlPCJAWwtpv4Y4uMOASYnDfR38k75qh03
	NCr+M/G8abQr/jKTinLBRdqDV8Eh+5gMWT6rFeosrm9ey8npqXmSXM+iT6z8P4l0KzculsHgXTh
	cxcB4ga/nMDu18x0ET6BoNYqmc/M=
X-Google-Smtp-Source: AGHT+IET2IlY+4eh0HPZYUUUvl4s1re/vs3sYpmb6Nn5gfXnazvVed7Zg6Rl5kP5EAKc4wxaV6XzRaS1lkhe7v106SA=
X-Received: by 2002:a05:690c:c94:b0:6e3:2cfb:9a86 with SMTP id
 00721157ae682-6e9d89970dfmr22427307b3.26.1729926464709; Sat, 26 Oct 2024
 00:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>
 <ZxwTOB5ENi66C_kq@codewreck.org>
In-Reply-To: <ZxwTOB5ENi66C_kq@codewreck.org>
From: Guan Xin <guanx.bac@gmail.com>
Date: Sat, 26 Oct 2024 15:07:08 +0800
Message-ID: <CANeMGR4TFdLnrH-=S7ZNacaOendJvm_ocbvN-Md8A6rAQdmkhg@mail.gmail.com>
Subject: Re: [PATCH] Calculate VIRTQUEUE_NUM in "net/9p/trans_virtio.c" from
 stack size
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Eric Van Hensbergen <ericvh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dominique,

On Sat, Oct 26, 2024 at 5:53=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
>> Have a look at other recent patches on https://lore.kernel.org/v9fs/

Sorry I'm new to Linux and didn't find out the exact workflow from the
numerous instruction files.
Thank you for pointing me to the examples!
This is greatly helpful.

Guan

P.S. Patch attached:

> Guan Xin wrote on Sat, Oct 26, 2024 at 12:18:42AM +0800:
> > For HPC applications the hard-coded VIRTQUEUE_NUM of 128 seems to
> > limit the throughput of guest systems accessing cluster filesystems
> > mounted on the host.
> >
> > Just increase VIRTQUEUE_NUM for kernels with a
> > larger stack.
>
> You're replacing an hardcoded value with another, this could be made
> dynamic e.g. as a module_param so someone could tune this based on their
> actual needs (and test more easily); I'd more readily accept such a
> patch.
>
> > Author: GUAN Xin <guanx.bac@gmail.com>
>
> Author: tag doesn't exist and would be useless here as it's the mail you
> sent the patch from.
>
> > Signed-off-by: GUAN Xin <guanx.bac@gmail.com>
> > cc: Eric Van Hensbergen <ericvh@kernel.org>
> > cc: v9fs@lists.linux.dev
> > cc: netdev@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> >
> > --- net/9p/trans_virtio.c.orig  2024-10-25 10:25:09.390922517 +0800
> > +++ net/9p/trans_virtio.c       2024-10-25 16:48:40.451680192 +0800
> > @@ -31,11 +31,12 @@
> > #include <net/9p/transport.h>
> > #include <linux/scatterlist.h>
> > #include <linux/swap.h>
> > +#include <linux/thread_info.h>
> > #include <linux/virtio.h>
> > #include <linux/virtio_9p.h>
> > #include "trans_common.h"
> >
> > -#define VIRTQUEUE_NUM  128
> > +#define VIRTQUEUE_NUM  (1 << (THREAD_SIZE_ORDER + PAGE_SHIFT - 6))
>
> (FWIW that turned out to be 256 on my system)
