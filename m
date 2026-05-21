Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DFC368D4B
	for <v9fs@lists.linux.dev>; Thu, 21 May 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378578; cv=pass; b=HMDkvVJJoqSYIdci5hNQTvteJxb9zQmJ11T8JZltvGDhby7D9vjKFMAahBuGg4WGq0+RNV+/3Bd7y1S/AdRa1rRE7bHyqSyJd+ovWvX+oFQ6XMkWX4lFFyI7aX0XSXylOLVk41kyBnCYiHYuSrGMpH9Fhv4F2luPWMeaiIBbn4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378578; c=relaxed/simple;
	bh=oTJGeDYTACLQP4b7lcnYS7MF/F8SkeHi472hQfd2CPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnoed14J5rO2QVUiQu2qylOOQv+fUAo63srtZYhmNFy0rBhCeFYd60eMd3OfWrngvV44bCub6YHyaewELgi/WZ+WLvsuWGjyljDIHTFqXttVRPAAn7Ug/DjMPAhK/ipPAy4GkU7LwwrOVF3ycgid2jRO2C1wkDEs3ULosAPeBl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePH9aMjB; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePH9aMjB"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-63169437ac7so4775131137.1
        for <v9fs@lists.linux.dev>; Thu, 21 May 2026 08:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779378575; cv=none;
        d=google.com; s=arc-20240605;
        b=lPHjeRsz82k6qt2c1gfaDv3S7RTNIhV9b8M9/4Q4JJD+MuP5PWOE8FLfzJuERR8nU1
         wxHFr62TFTf3QJdMxawE8S5GYrM+k/4caTzU1xq62Bu3j+N7yAFTPsx2X1Gjd1tb1Fvr
         MxSBDlv5M//9NjWqo5dJf+n8RVH5vra7VmySMkZCRvoOFvZ2lqp9ptgsuVWty2LLMFn4
         /IoQmR7D1GUoaBmf9zcplrHMoPNuB7vfB48fcB6GZ7YSuGO6mbSO5su+k2ws2q4QRGcn
         dtNK8i5tMRD712Rx3Yoq37vV4cOUYNXU0sXTeKZIT3NYzqVqjtIIZiTuqpyMblatnUda
         j21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        fh=bJIT+IikoGRnei/EeH3YtieLBS/uKg7VMLKS1OCRL5U=;
        b=K/LkqV07G1NkKujX45QiaKmaAUDbT43lUsxZ+Ou40M2Chwk9R3wXpxcUYcfd+9WnH7
         bQIJBo/ZnRFNeHeLQ1QnAEN0uck9nlfMEp6GH6n5ptal4cjehV/5LM7OuNpGqdIzjDKL
         O/UGP8ZE1saGyE32bXemuN0roKAu6eJdx/Y9tVq029EgEQTUN9n0PiJN9BJqnOMdgiNY
         yBfh2BkssDasnHC0xogo+EspDNVoyEgFboM8o/71Yjp40QhN868zWTWX6Q9MySn1yxV4
         KeZH+U28+4NviuGpc0WKJbrEJQBTy7w+GaxRRsFVUxBuuPZryNlcmYIUZUDhnG1qsgTe
         axTQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779378575; x=1779983375; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=ePH9aMjBkrkGY8hyd9qeuxJInQTbvZGmr+QQs1fjdYIqlwhYf+Wc7i/BE4v51+HuE7
         oATd/aGoNVOVeOHp/lpsb6Szfi0CUmNPcyeJ/IpSGgnvtGF2IsQ+OiJtBKmbTiNJEdrv
         UkeQK00q/N34D6QwKn+SEUt15MBXoW0U7zC+ksAYB3SL9rkZ/4q6Ky8azi5+MRRGvoHI
         OYZLUfGEzW35dfmbpivsfFxJOm3o4mhkaTTfeYZ9kNbDZyX6oPhtgPyXaCjkUtYepR1d
         zGqtS5T9G+3IaK8noemPiFKwjIO+/C8ksscomNeU/pd4KdXOYdzO7nic9Lhh1BfhKDrT
         m/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779378575; x=1779983375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=sJ6+kSRPuuWwxyBDSljIwG5Xs23rSRClFcojYirHhgOvmqzZJDcxSB8zxdqzo4XmXw
         +icHYlYhlkBu9KwacdsoKhVgMcWNFwRn3qnNVyViH3NKH3OzzmSa242TvBaU095Jv6L+
         jOnlZoYKScPYZAeEW6XX2yPg5ho+8FIW/CaJ1NDlA1fn3n9A8N1fDWhGMHvZRSaSZCOZ
         yZygtf+5cKMvCxBC5YQkYcwoPitLE3TsR3CX7YgtNUVP/1ORQPYGIrZTmpq6QTXefzAT
         InwgTfsUOrjDADDfxKDMgj1pGTYqob8r4fPfef3I/ZshW2kMOhzptBGJWZzOMPuE1Py7
         9BNA==
X-Forwarded-Encrypted: i=1; AFNElJ9fwkRH2K6Lbk0z1IBXbLz0veHsp/x/nL3Ks8iJ9xXu3iyo+TUDXOSsdXM0qLDYb0v+CENI@lists.linux.dev
X-Gm-Message-State: AOJu0YxkLrcQscd5ded+qT4vyFm0YXt4xUXAf3f22V7Amiei4Im4BhZO
	keuzRd+O9Ns/pwkrVxnMZRJRxLxz7KjWJJXuxXNrQSsl89diFHCdIuvWyEboqIpCBg+VzKdhZGm
	NzvYzc2ZwuR+RJA7NglnGPrtJjuzEIZ8=
X-Gm-Gg: Acq92OF2WjPgUm+aTS2BhK2tGpy5NO9RlbHn2MdsOFD0vOgoHW8Ghktf36UOvx14Fqx
	BFgw/SRve7XAsqEXWoz+t2YHgJFHui7TkrU+uX5dfFWMBxD2cLUCvnBVxZJVubixNSTNoNeWpjs
	EAzshNMehecfM8n88fhM6PDgbK7r+BM4uz5iqa3lT/+kqfbjAWrBXQmxEKVtgwdzg0FptTHYUrU
	DzQ8+PCU11AqUeQwqmTHMKmTQ5bxa8cSEVhdUTH9DUDLaXRwTZbyZQgpOvUWSPwwqF9p/NvLztH
	VoZxrqNulVtHGOMt9QPNLr5lvtbYXZzXnJkh3ynNlBzowFXO7KB+md0=
X-Received: by 2002:a05:6102:1591:b0:650:a9f6:4d29 with SMTP id
 ada2fe7eead31-67390b66b29mr2592164137.13.1779378575543; Thu, 21 May 2026
 08:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <20260521-grube-leitfaden-0e5420c9bedc@brauner>
In-Reply-To: <20260521-grube-leitfaden-0e5420c9bedc@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 21 May 2026 21:49:23 +0600
X-Gm-Features: AVHnY4JMLUcx8yOSfS2Q9vtP8tvb48vFjP_vPMN644Wd5G5CD5CLlCbq3u4DVJI
Message-ID: <CAFfO_h4Em26Hfbv-DWF+9dNS8TBuGpfWjWFBUhLr7jYCKzj3_Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 4:54=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 03:07:12PM +0200, Christian Brauner wrote:
> > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > I came upon this "Ability to only open regular files" uapi feature su=
ggestion
> > > from https://uapi-group.org/kernel-features/#ability-to-only-open-reg=
ular-files
> > > and thought it would be something I could do as a first patch and get=
 to
> > > know the kernel code a bit better.
> > >
> > > The following filesystems have been tested by building and booting th=
e kernel
> > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REG=
ULAR that
> > > regular files can be successfully opened and non-regular files (direc=
tory, fifo etc)
> > > return -EFTYPE.
> > > - btrfs
> > > - NFS (loopback)
> > > - SMB (loopback)
> > >
> > > [...]
> >
> > - I've added an explanation why OPENAT2_REGULAR is only needed for some
> >   ->atomic_open() implementers but not others. What I don't like is tha=
t
> >   we need all that custom handling in there but it's managable.
> >
> > - I dropped the topmost style conversions. They really don't belong
> >   there and if we switch to something better we should use (1 << <nr>).
> >
> > - I split the EFTYPE errno introduction into a separate patch.
>
> So I've massaged this series a bit in that I moved OPENAT2_REGULAR into
> the upper 64-bit and internally use a __O_REGULAR bit. After having
> thought about it makes a lot more sense to move the openat2() only
> features into the upper 32-bit for the uapi space. I also ported the
> selftests to the TEST* framework to fit with Aleksa's recent rework.

Thanks for fixing up!

Regards,
Dorjoy
