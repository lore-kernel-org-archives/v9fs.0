Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6F3AEF34
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340752; cv=pass; b=hk+ZctTd5fU3WsybFsfWdlHoeZiZXL+duamvIBEqP3vTEtXG2S7PSqsl+hxiyAFLjG8W0wYHlE7UT03/HvGWSYgc7ZLpIoc3+/aJMyHQOBZu5Fvtx+p8SogH0zVpCc0n14d5Ilmh0iau0hZBSthDEbQZMhGRFU4GVFMhCsJhNBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340752; c=relaxed/simple;
	bh=Bw7/eU46XNMmEAY5yaZoewjP327xtGOJwYlC+oEFeMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4Qge5vc5wZCgGzv6gAmeXU0yIwoE+/eRs8/BDyNd6oETk+2T8jW9gmLCw6lH3n66UJajv0zTqUIwR4n1hBsuzoC1ViTGp3Upmmz3zQblFfsIihoFlvNDuRgJpTysFAKGIwal1sSddbjiqk70hW+b8l/dLbCx7ns4ZgQsejdGOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7Cy9dJu; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Cy9dJu"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-6058ac0ebceso5253837137.2
        for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 04:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776340749; cv=none;
        d=google.com; s=arc-20240605;
        b=YVgspgDtgIQji4X6GWSbfWV5FejtvZsBECjd1F7lxDUMG1gGveooNbib+lkrTIEEOL
         OWADOA+R57M/2pcGiCEd6ZC4gsaD7TldR2npshZpYhXEB3QLlhGcUw7wr8kRIOwAwmge
         CdM1xvo8FUJUWVOZcFWn7Ja4gY2nGU4OA02ZLNAG0MdE0+T4dL68Vu2GsJBLGwCBaQL3
         t1LWQczICAGglbTolz3sfu4l4M2NNZnIdkFVq7aAAJ3+kdMDTsQWcShv8VsU5kdmulXZ
         vrOyov5Bjx3nX6M9Btm3d0cw5SvBp/NYlEpHHYYbOaNAKGFPoSUwuArg8cy3nJRzgnTB
         du7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        fh=quxF2dMHpgxdLb6FE9GZyNNXE1praJm6wNWtdZtXkd4=;
        b=XBEw+lSd2FBoKzMnVT3Er4RrvbM6SQ1nfjJNEn9S2TMSMLTezixW7Li8Yz9hkZLW6z
         bl9Dhynow0N0UYA01XyXWum58RQ/hBuyrer/ZaPRrPEYcov0EA3ybBXdJPJWkpynmOBk
         9p9iyR45Tbd6c9jWKNyrrfQyErPaQJVU1IGUuwblyWktaO1pI7eu6cbp63uhV2DVfv5Y
         oSiK7LCbRtsFgsACeW7b957QZw0assGMFZtlTsOcB99qRrgrCkWwwAPxhbsPrIH1nWZM
         8Jb1TxPp7ZezUD2liTV8aAcY2RXPoIEhvAzcVr0r0Xw6zedTXbHGkurUQeGmdoWSD9bI
         qQIw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776340749; x=1776945549; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=a7Cy9dJu8T2kaHOb7ZcZWKa9z4RuZe2pSnVAljV9WdISe7LiJ8IQOJ6vxbi4ZcqN8W
         p4IGCE0t4uFl70UPN40t6dGYRWbPlbhQ3r12npcKNNEBn8PPnXgYnWWtlnFvHOnlbV3A
         d0XiYI1fDSeloM45aQvxPH9oW/bpGrslC51x7Wm5iL4PZ2Sdw7g/vHo0uiUlOmXIdfbi
         YzOrBTXzBhlgfBTYB9k7a2BU7SASuIu8furwjRrVuw8gA+ZiJ9w12ltHE/C5hNVcp3Za
         qi7z2niAui3U6+weRp6loxthQraDm/OOjWlugo25sHDwXokbutQxLfrTKK68uk5YHy4w
         P06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776340749; x=1776945549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=WqhPuKzl0bNfMsJxZb2tLB38MneuMB8hEuYOsXCPXQHCCSDD9WyEQ+3JfhKRfnvFcL
         yQjCUonFh1fV8yX30TQpP01WjrVP2Cxvd2Y2voT8KBTaygb5pw/idGCNye5lIrfidqLV
         vqCQYF6hxeN8s3jnJYy+lPKD9sCwSdkO7ARSNUdnrqkZCd5FMbV3aTz+QzfZt2GwA6k6
         VFq1INScWElVeLHkMFviybkvRLTRib/tM877sQVPbHGO4Y0Z5a70jdG7HcRAF2KdZjP6
         aVkTxGfF/t5W9Qrqb8eNLcPQLJURdGcC5SI10SlipL7enyWUhmF4RbUvp4qRIRvSg+YH
         Xr8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Bjv4jVjfQKjS9u0R/3qyfBtbxpg+hG5Cups/k2f862C6v+ZE2W/S61GfGVjMd5dZ/hcZD@lists.linux.dev
X-Gm-Message-State: AOJu0YyMvDvp7JjnmGRZRdXI2YNoAMkXXOi9jvW31s1j1h0vIfNeKH26
	nszYdJ35pcWsl8ikF+3+EBaEb/YMRQXu5eSXobI9ShwSxcb3tTIZyMCYlv6Pa7xyAMZNgJmIhgi
	3KjTKjyLR9aiA//BHafG4p7WJlFRjZ5g=
X-Gm-Gg: AeBDievZvJz5O+gfadnPmL6ED7pasTKQZPsibZ5NkbpO/7NVCj1VxvugCnRWQImJEBr
	zCN0nCBI3O5HsYklDt03nT6vCrugzqR2KqkpSqJRkSp4rRf9kSUtac75puco2aTFuGZ8kT6pVmQ
	fRVry33lnxYDQCnj76dK8aSDLTTShHG5PtUtTXuCtPM3GwIUpNRF/OKTD+kAZyZ97i6T8Gn89YB
	u0NZD2ymqVkBeOhhs/6qMWS9razzKXtIZwEt5Yq164KH9Irh7PMMIusqR6kPfoggkakj6dz7Egw
	bn1Rc/ortfOk1yoV2pPro1qlOoE+1XMxPlgv8O6neA==
X-Received: by 2002:a05:6102:6a94:b0:607:a3cb:4573 with SMTP id
 ada2fe7eead31-60a00c36c76mr12126981137.26.1776340748680; Thu, 16 Apr 2026
 04:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
In-Reply-To: <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 17:58:57 +0600
X-Gm-Features: AQROBzAEjiDzwaGAEKhFLRhObmxO2qMMzryZZhbLCURVPls0DvUuWHW8g_k7mMU
Message-ID: <CAFfO_h5kWCYszymaY=tPAbpU=PjLFxsND+CWSYtypN4iuW+qPw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
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

On Thu, Apr 16, 2026 at 5:41=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-03-28, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
> > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > as it doesn't make sense to open a path that is both a directory and a
> > regular file.
> >
> > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
>
> Aside from the nit below, feel free to take a
>
> Reviewed-by: Aleksa Sarai <aleksa@amutable.com>
>

Thanks for reviewing!

> > diff --git a/fs/open.c b/fs/open.c
> > index 681d405bc61e..a6f445f72181 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -960,7 +960,7 @@ static int do_dentry_open(struct file *f,
> >       if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
> >               f->f_mode |=3D FMODE_CAN_ODIRECT;
> >
> > -     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> > +     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2=
_REGULAR);
>
> It's not clear to me why you dropped this, I didn't see a review
> mentioning it either. (General note: Ideally the cover letter changelog
> would mention who suggested a change in brackets after the changelog
> line so it's easier to track where a change might've come from.)
>

Thanks for the general note. I will keep that in mind.

The review was from Jeff Layton in v5
https://lore.kernel.org/linux-fsdevel/5fcc2a6e6d92dae0601c6b3b8faa8b2f83981=
afb.camel@kernel.org/
" 1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips
open-time-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
  but does not strip OPENAT2_REGULAR. When a regular file is
successfully opened via openat2() with this flag, the bit
  persists in file->f_flags and will be returned by fcntl(fd, F_GETFL)."

I think it makes sense to strip off as OPENAT2_REGULAR is an open time
only flag (like O_CREAT and the others already), right?

Regards,
Dorjoy
