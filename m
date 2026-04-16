Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7F3DE451
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349302; cv=pass; b=I8dIWJOBTrKF6JzL37/UWfSeBweN7NQ36537GQmrNe9kOm+BBR+Oo13hILQOJHO5uzf0mtRBsSaQkwkEn/uBT9xdj252j+js9CdvwNKIP9CIAcJlBk88LSRQtpU1NkbpRFjaSbvmLDWFfnnj8AgMFvVa/4owsGmsJN6lrZk5uBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349302; c=relaxed/simple;
	bh=MPSStrB5WQZXjuD8LVCQJRe2/QVXDyCuUjmphyPyAE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GPqajYoGVz7/Ogw6B89TG6IBSzlzNtwkqZjowSQ4n7+9yjgPEx0ISv8RCP1i4mHSKNf2GJl0Mrd4uTzUbtJsZ1ovMM3zTWFL9UL2V4GqjOwbmThk4y2Y1Q7LDNAigfpdCTu5WeIwAO2pgr4aUVLVd1bD7WeRTZh5lhiMb5EUY44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeMPlua3; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeMPlua3"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-953acf7ae20so459103241.0
        for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 07:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776349300; cv=none;
        d=google.com; s=arc-20240605;
        b=PPK9WdsyzXP60fKxTokm3d8NBdNqqrlBMdc67X2+hRcMOejr7WiLo4qS0FYVZ9dO5E
         x07LUWXE5YRTrJkMPUrfxTEuudLqPRZzePtQuykPQJS1Zt0lM5unRMoIM5R+/GAhSQG+
         96xpaRPG2m4TR9ClYQuO0fuuGBpVl8uvq+45B52Mc7snkOp4h77icdWO7UFmyjOAuSyD
         hSvfDxT4MgP07xCGf3HqzANKiLn0/mW1nD9NqPhDM0N2AcMMoQU6nXlu6Tg1luhrLqqv
         9KjnlO1B9Z7OC9PTDoNFVZCQEhZhanZe4OcbowfWmsnVt9AJ7zZmg1SLbgFGa9n5U7Np
         I7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        fh=Y6N7nnd5Pgf8Sq+GgMUWAnw2kz1nWEGuss1BvClWwa4=;
        b=J1ANx65cPM5dGg9NW5bGXOlO5Xf7LqC8sXFW2s6GX29jWqJd/ywJL+OGo7QRHZMBkK
         pt2CrRIWxngF1plm5TB7ryhippTghT9blp2bhdhUnd7zXt5D+FNwW0un3PVZs9J+Yogm
         vPzNsDpxyVkJMSracf0xs/11k4fW16/+Ku3jALY1GCoFom9dQX6YaqeNOLp5XLiuVe5q
         T371gkqKHzeVE7YorPuRvCVd+f7hAdkTTuSSG0s+K5J71skAim9AvMEyd3EZvNNzO+PK
         7nAJL9mJFaI1PLq6NV1B4A+sCLg6liJ4DnE6t9Xqdg0OFu+2FZmVWGBGZ+vNGZ/H4mMy
         Cd3Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349300; x=1776954100; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=OeMPlua3Z3TT5Q1TqctrFMg1ptjPcOLwMAet1GqQdTFpZk5lq8GU5WCpvI4IF3Dlu/
         tDswPokH+ud26HlGSQN5J8xEV0JmiOc8GqyFAiQiOYG93asF27LuUokElBNr5rG5Q+A1
         oy7j9jlLnhAOITEZzRUgSvJ4FklKoszHcubZTj5PYeQ4pl/xfJsgcGw/p1wV16GIFvgp
         KEQrc7wEVrguUBOcBA2kM7WFHE1PuBq9AAbTY550Pd3Dwfbh18Z/0wSFm20W2NWdS85R
         Dc1eFfuuWv1DMv+QkSm1wPI6y7gsu32yABSesdgidHIN9oJV42XG9mi+sEHhrrAP2D+r
         xWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349300; x=1776954100;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=KCEAUOi4I47sEYFBni2o7XKOXp7lYM6SWuJYUYB434/gU4z22ZgVXx9ix4sO/3lSAF
         tTX8NzT16dUUmWuBmeQ6xq9bx3ra7wKg4PUwcgXAx8ENjaWIN07MkxPwjWSG/sN0LtO5
         GdBz/2zcd9VvFC7UvZxbhD0zKsiPRuKYK8t1FSPRmf/ejQ9o6lbjDn26kEoWiHMYXtZC
         gVTc1ixufd8G6BrfLEABcmLAeEVy/rOao/Mh5M5vaMSD/haQG1GNwvOIuY7WbDTc3tAy
         Cz59MS/P2xYRDmthW3gTyKQYwL7xzoqc3os7BnDlvhJwqPMN3jXMyxX/HcKFuuSXDLl9
         TVOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fmiYxPRilEGU49L6sFgYxB9SgrbOlEaTFhyYb1czTQK9gbZJe7Da1Ivw9BIIEVSsvIIeL@lists.linux.dev
X-Gm-Message-State: AOJu0YybMApC0E9DqieiIXucYK7aLlWiC4+ve2C0mb7yDGmD3u9a9UaX
	+r/ejvRS/b6s3tMiyjmMz8UcoFx2cOKBYKA7jhY7hN9Q42StpfLZWdSlhJMl7KJP7pN6MsU/Cg2
	4Y+MGpNvDVcDYbYzIurMa90AG5efZZ+c=
X-Gm-Gg: AeBDies6Io665KERAuMfyIb5EfegOdHBKGpjX/7om4eGgQ4jXVcI8NJ7HAEj5A6P9aA
	h/ZLYGiLSaDKwT0+xGsnZOvlXF8mw8JLQ1Cpcyz0Eh8oa/Zzy+ibw/HKW4APtmypqDFlQVaMSbz
	BJohukdi+Wz6q+WQTeDY9FIi4w3utmpXmMhICJbwdcurvfgaeCYQDTfFFbYJ9XfIrnu8RnzWFjs
	c1DTG0hm9CgVbn2SnZnzbnAouOeYvs7zAtRO4XNzGprUh9mBmzjIx16rY+2FqnfHY9697VuUefE
	JR37uhde5rx/EPnjfXpXLL+OWMR33wcYmBm69MS5GQ==
X-Received: by 2002:a05:6122:608f:b0:56a:8f7c:49aa with SMTP id
 71dfb90a1353d-56f94725c32mr1843622e0c.4.1776349300022; Thu, 16 Apr 2026
 07:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
In-Reply-To: <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 20:21:28 +0600
X-Gm-Features: AQROBzCVSNvQ07toCtw3F1sHPLg5Z_-nre3iq90Dw0MflD8nQqdsL_RQ56rFZc0
Message-ID: <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jori Koolstra <jkoolstra@xs4all.nl>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:52=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> On Sat, Mar 28, 2026 at 11:22:22PM +0600, Dorjoy Chowdhury wrote:
> > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/u=
api/asm/fcntl.h
> > index 50bdc8e8a271..fe488bf7c18e 100644
> > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > @@ -34,6 +34,7 @@
> >
> >  #define O_PATH               040000000
> >  #define __O_TMPFILE  0100000000
> > +#define OPENAT2_REGULAR      0200000000
> >
>
> I don't quite understand why we are adding OPENAT2_REGULAR inside the
> O_* flag range. Wasn't this supposed to be only supported for openat2()?
> If so, I don't see the need to waste an O_* flag bit. But maybe I am
> missing something.
>

Yes, OPENAT2_REGULAR is only supported for openat2. I am not sure if I
got a specific review to not add OPENAT2_REGULAR in the O_* flag 32
bit range. But as far as I understand, for the old open system calls
we can't easily add new O_* flags as the older codepaths don't strip
off unknown bits which openat2 does. It's not easy to add new O_*
flags for the old open system calls since that could break userspace
programs. So I guess it's okay to add OPENAT2_REGULAR in the 32 bits
range anyway? (Also lots of code paths take 32bit flags param right
now and those would need changing to take uint64_t instead but this is
of course not a reason to not add the new flag outside of the 32
bits).

Regards,
Dorjoy
