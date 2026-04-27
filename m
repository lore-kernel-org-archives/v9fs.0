Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6313D34B6
	for <v9fs@lists.linux.dev>; Mon, 27 Apr 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299477; cv=pass; b=Iah+Fg1C+4lCPmpQ8cC/Vbb59u0hnJ51JqzYoJAglZZ2gp/RGMdaMV+iaMUzKVXHeBZHW6A1FWNidGHAfFFxd0ddFpzX65WNdq14XpAz+OwKML5MmQo6JI6E4OiqFDf1Qxf9k4yfXr4Gj7p1AGVPnYMUy8GmWXmA7Pd9nGdc6zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299477; c=relaxed/simple;
	bh=dCas8RQKsBsKm7RPEue3wRPtJ4lneFcySX6TUqGbvVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqZo1as4Kb+WtIp1eWNbvsC9HwMGG6lheEIk6FGLm7hREBvv1i06DCULRfJguUyjYoxzUS3bD9Zdto+CgpsiwleORXzQ0qaDhtETCiwhCDzKdLFVcCDz/MbAuMmUr8U7HLcQkJmk1ATm6nkJ6eCfiGuKTCvYu+uBQz4+uwJcWxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/+bTgEV; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/+bTgEV"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56e91f17a99so6646230e0c.3
        for <v9fs@lists.linux.dev>; Mon, 27 Apr 2026 07:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777299475; cv=none;
        d=google.com; s=arc-20240605;
        b=hHBcjURIbuZe2fPShRk18fQl1tHEYLzutX+xt7IrAtXs5YCDx0KQDwHnOiixkNyO9R
         Ab/boGav3Xzfwj7o4mu9hcO98ola1+0TbaLsQUiAWWSgIUai2Yf6siZ0Js4UT1NXjQgI
         exJ+bFYizYfi1GX+1IfG0Oha/UCxoGsTdQ1UjyoBRVYMqs82oOjBIsvudUAEPEvX7PWu
         L4zw3m8crLZu4AiC3KdBlzucbiVgkI+yRTRrKgKWkdoXLjiFQ4hL9Ucwx2mZtYFBi5M2
         mkLnrr2FPrQEUL6ER1zAFrAHK8j7P+AZFGoapG35YHm+8OCWlNSIRnQeQKIjhGLKT9n8
         Hzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        fh=GND27+uStaea54z3WT4rDdILpGSZyKKsDwf4N5mDQDU=;
        b=iXqCWXUHpxQjYemQNMqQalXkAWGr+N4EWKRXANTHs0PV494fGAXd5ozMZJoL3ye8/a
         08WJjxq8UuQp7GNY45vJpr92myyRn7KKBgM8pkGQNKKbkzDAlHNMLBcJBrn6eSVTSu+T
         RS21wwDhL3lgIZgQ9CeQMu+YeMNgZLBy6RHvRTjoB+TYyQE7EJYKw9H6UsaDmbxKL5pb
         4FWHEg6RIGjBcsP2IYPKgvMsE1EmJUwl68g2eqqyt8aHVJvXwlrq8wQXxkELOGROI//Q
         IPtPygFQHhgJg/goYnckf/WIg+MMHt1GTb169KYgmh8rV1blNyo6KTB3ruYsnAFhSOow
         NV+g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777299475; x=1777904275; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=b/+bTgEVwo5J6HwyHJ5sI1qkp9lTyqmPvYf8V6w8LGj5QzZm3uPgu8q/sSAhIl16vR
         SOiz5A4ulL0rQ+CLSFN7KVFtqDx3Fis5daTgSNAIEXDYD9pkcJ0uvOl1HMsoi2pXmquD
         bPUeJGAFvhGEWmyVTnR7NCBV944HTrwyvahYIgTO9iMt88WnclaLKL4YJakaB4z9pUIg
         9Dr5aaYAc376zONCj5YLi5zlbjHo6mFicfRx+FeBswIwtwK6dVRslUfsce3tzpPne0RP
         DVd91gqe1cwSKrIEngWH1H+qYHE71QlXrtsd2FKGjzgRWDTJAk/gJ6bQvYeGWVenm7/D
         BR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299475; x=1777904275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=EK029xLNYYsWdM/SOosELiwc0ALJxjJ9pnZAuPzeJW68fB5HCTDab5z3FJMB22Ctmi
         DFjhi4xv7g8N+Dh8uheNdtWjeyHizbfjgRiweDdrIT7wBlQ3kdfuuc6w9PjjYa2tfnhg
         dcOtgjI74tg4heatbNuoFrVmVDndiNdnb19lVKAAsu6AjpNYodaowdNpukQM7N79ADor
         etZR6+V+wyVK9yEInRrVs9+9BlE7LxyUfgiFB6Qd+dJT0ijLMNpelZPgYNs/jt4uxuD3
         uYYO7dGOurFkEDw0MfjK5c8i30e4F7J27VGLaswhAo/tQk9uZiaS3eo9igDiMONNR+O/
         rwiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9f6Rdt7ubOYWAPUe8rF/zDST6GSQEdSZ1E1gvc2saomxoeM4KhK0IJ3GUuT6M1u3KMqUCv@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7iSYz/H/4v4kxsqUbxj9Dt18+TFrG/HLSam22QZaTjH9Jrnsx
	XoAC4CgfAZM7zVRsHlCRbEizvkiMt4+8dFvnbHc4YL+1IABqVCn+wWfZobVaZWiQi71e1q3Oi3w
	QcsRo8dlN7urenlTF5bCxd0nAuPe01Ek=
X-Gm-Gg: AeBDievSSkWxT20WX7NtcOQ+qM1dNCqbKaVITQKeBmm29qxif0FXyPZ7byPIYu41ZT4
	hroJVX+rNWx26pAwQovuFNrqCcVGxhAuodIblnR67uEdSNW8duwitdQ91vjnXq8wAbWcMidTwRY
	2wG6zWk5icsjLHtfAuDO42/94S3H5QhXs0r0bGBO/aGZ7zKW0ibLNO89316BEKHMqqdnv1X7VY6
	ACkSJ5JCKQIQBQUMDYCkIYRJ+M1vmcgc0yJ0o5wqNNvs6ELdHw3SyVrF3bKKNiqf8rjqJFIELl5
	HG1CuG/WBQ8nLwMNgBI08LwPm1MHt5v7aZqQKsqhGBsFdSD/A6Lu
X-Received: by 2002:a05:6122:8d3:b0:56c:d5cd:1e7c with SMTP id
 71dfb90a1353d-56fa58856b1mr21307327e0c.5.1777299474612; Mon, 27 Apr 2026
 07:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 27 Apr 2026 20:17:43 +0600
X-Gm-Features: AVHnY4JD2JZaiwDyyuW_kBt_sHjEkoUZKURjGdK7nlj6KmXsjRIqpl4zFGzklnA
Message-ID: <CAFfO_h5B=Ox9S=Xc=az2vQwowffohch-mkvSggYAfNXaVuv5GA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Florian Weimer <fweimer@redhat.com>, brauner@kernel.org, 
	Alejandro Colomar <alx@kernel.org>
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

On Mon, Apr 27, 2026 at 7:28=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Dorjoy Chowdhury:
>
> > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generi=
c/errno.h
> > index 92e7ae493ee3..bd78e69e0a43 100644
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -122,4 +122,6 @@
> >
> >  #define EHWPOISON    133     /* Memory page has hardware error */
> >
> > +#define EFTYPE               134     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
>
> This is what POSIX says about EFTYPE, in the Rationale for System
> Interfaces:
>
> =E2=80=9C
> [EFTYPE]
>     This error code was proposed in earlier proposals as "Inappropriate
>     operation for file type", meaning that the operation requested is
>     not appropriate for the file specified in the function call. This
>     code was proposed, although the same idea was covered by [ENOTTY],
>     because the connotations of the name would be misleading. It was
>     pointed out that the fcntl() function uses the error code [EINVAL]
>     for this notion, and hence all instances of [EFTYPE] were changed to
>     this code.
> =E2=80=9D
>
> So I'm not sure if reusing this name is a good idea.
>

Thanks for pointing this out. I had started out the patch series with
ENOTREGULAR and it was discussed that EFTYPE was a better and more
generic error code which is also used in BSD systems like FreeBSD[1]
and MacOS[2]. I also agree that EFTYPE makes sense. We can of course
change to something else if everyone agrees.

cc Christian Brauner who originally suggested EFTYPE for input on this.

[1]: https://man.freebsd.org/cgi/man.cgi?errno(2)
[2]: https://developer.apple.com/documentation/foundation/posixerror/eftype

Regards,
Dorjoy
