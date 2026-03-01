Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AC31D375
	for <v9fs@lists.linux.dev>; Sun,  1 Mar 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378402; cv=pass; b=kKkuXj3o/KLaJMp/nfFvVfJj/3ybkwHDrqy6nPJENP9QvOY6AXSQKaRA80usi2kHEOx2wanJZylJT3ifd2l+U3g0WLRQPIlHPeXU6Z/+VLOHfNxMsHc+WTt7DoxQvcg/c7dSNzfcZVlJ4LLgAp7ZvG3DofEObo+L6jF5DdzT0NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378402; c=relaxed/simple;
	bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBSiB7M8JPYf7rX7RieXqaWJaMl/XwvC4J0bbTOMBbzMTB3FIpD/C0Ye/YUsNJDxIMCVVPXjfy3QNhXczN/4ZEzlGOnyyfKteEKN5/sfxgTDKdt9KucoB2CjTicJ6zi98ybO+kK5Aq5GrKtrDPJQhuLjaqg9gnvl6+t/uDG7fMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eou9cqiZ; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eou9cqiZ"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a973a7bdfso3430477e0c.3
        for <v9fs@lists.linux.dev>; Sun, 01 Mar 2026 07:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772378400; cv=none;
        d=google.com; s=arc-20240605;
        b=lhvTP3WAP4f5PA0qC4q+gIwyqC9cX9SkiE8066mCYuJ9WHPswDtYBaG54RFeBcfeae
         MezDHjhx1YGQbbeggcPoX0Q4uYsS5xm/rU2yjgiNEQ5Fi/zWUbcE1mXNqkF1yShVg62C
         GNxFYVC7j2mmQYqSBDyjFJHX/S2FVuPjZMEMEBXt3T132uTZPFDYCUkvz6lT99Re9X9i
         5+NTPkBLR5vyEzxCuTzhtT17j8zUrU/BNLVI/Kc3cMlaJwG348vmm9E4pz0gAPCyYnay
         lvIjkdqNo0Mp+LpFRmNO2UiPp6YYWwZnQz8UB2mGYdCjSHDn5fBl369V81fJbMNq8evN
         MqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        fh=YWocrgld5r5E1VDDap+5qMGkGDnR8Eo7XaWhLDWBj9U=;
        b=ADZlxcS/U8/vhBOWcKt84ItICfKkQa30wOmwCk8gANxNCJTCw1wuMbHfcuXoFAgcUS
         h2NetLSiCt1qtDKGs5SqmYmYyd9GFFVFNUXaUtmr585m9cEE7YsX+SqnLvGxzZddZsNQ
         IjK92SEsl6tTTzy//ettfjvREQzGEN9X3lDvYXT/En5PT+1Yfuv3TxHOhBZri5akFfwe
         b59i1Scs+d9m9tzRwkLp97iJ3+iDuUGa35Lne6T84XlUSGj7JJt97+h8ix8tnw8MJinL
         ZUvLwHgj/orB9xTutzVXhwL+R+f4vl0GUxxTfo2zlun6fv3M4tZbPN01TslIdsciH3rF
         4zGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772378400; x=1772983200; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=eou9cqiZWk6qHGF2PZGx5GD8KewsY5HvCPPZvYtIlwRvb9AuNvnvwGrXbObPnv4ANW
         FOObYbNZzJZmwMGMaZtgjCwr/Hf3Tsv2k0CgFpsN6u9MesHnH/XjcJFwd7kof5AsSEyJ
         kctC9ReXA2f/xKwDt3P8E4OGLb9GfAz14waB1m3RgLDK9NTjMRjruNMn2LxI8bap/ATZ
         0E7oMYGDnuxQXwDeuiOv9THy66HFlfizPDXlToMLVC9c3GRp8+T5YyGC3RyaFoqoeEg5
         wDTQsrM6/So2usZg4RbE2jsL9ug+yJQLRj3lhpc3Ve28j8XBpz6Vsp9nb569XE5mEEUR
         XlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772378400; x=1772983200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=qMLf7AMskRy/tMtPltGvQQ7BPYI8ya4vOIt5yNrDUc8PYPm+4p8KIiz3V5Bs5IF0f1
         YBJFk2SyUfZUaX88h191Su0o7g9dmzE+bze1nMftUyHj205cKNSHH+4yP2k77o7snaeQ
         JQpW2fwCX2OQB/KWdbNWiMyI92rIDP0/xyyZqFEmpaCmiopn8BW/8PrgfgfmG2KJiru5
         Ok4m3d18WT6xylihriUps4T4JppjzAGnEm17WZTFtPHGo7rVwEJ/EO0NuJG51vdv/9NR
         t7nQDlK74PEFzrOAqEHSYG4GHJkKCK0jVsTjm8MuHlr6TGDEbuVedf1AQo5Q6uTT19kB
         eKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEqPbxEX9f4aZgZPK2clKQxeiOaW2nGyBspQTX8aNpW4042+E2kn7YDW52eXdBbPThcg/t@lists.linux.dev
X-Gm-Message-State: AOJu0YwVQt6gbaaCKperiex7hJeoDNhYPm68l/b+GEbFOcyOBV9RxF92
	qovoCg/K42aiJy1hHmJcAtsaDjvBUdZZiAqr7fK/+ow3AH9FlOWO0OBHtGu8gqUSQHf+evrW988
	Ai25ZnLVUiAL42U7XCi3SeqfwhFmckgE=
X-Gm-Gg: ATEYQzwY4sh12uyuqwJ3isL32YTbEz5z6DGWijUgsz50iZqKbzIziQMi4Txtknpcb2E
	bUNbGFYkyCVtHKgQ6BLt+BEoLb1rJiV8T1Tfypz9fPMDj3Tzmy+pI1oG3jQ1pXdE+gpPf504mvN
	z0H4na5IVYJ/F6evFiFc/c2WLDjbSQmcPrFFcwEZf3n//MwwbR8vsheuvpPIa2PFZO782OEOhxp
	T7ThRlErDQj/NXpNp8G3s7bPlULpS346e9HRNpUZPbXswGxnJr6VznMvSgPtMIoSqS7dlQhs2DM
	9PD12e7cQSMbuKV2qqTz2SWK3tC8pTAs42E45Ct3Lg==
X-Received: by 2002:a05:6102:160c:b0:5ff:1981:aba6 with SMTP id
 ada2fe7eead31-5ff31fab9ffmr5005001137.0.1772378400433; Sun, 01 Mar 2026
 07:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com>
 <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
 <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com>
 <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
 <CAFfO_h4brg90tMNp6VAzs5Lo8Lbu=DK2csjDqr2zspOygKEFCg@mail.gmail.com> <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
In-Reply-To: <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:19:49 +0600
X-Gm-Features: AaiRm51DyMEBRNPI1HVDhCyC4qT7r77uNpEMtKgft97OSaudIMk11BvPwkDJ_3M
Message-ID: <CAFfO_h59LQSjncu_4YE5YB+mt-FL2c1GN-jF_WtoKj1u43DcuA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
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

On Sun, Mar 1, 2026 at 9:17=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 21:15 +0600, Dorjoy Chowdhury wrote:
> > > >
> > > > I only added a kselftest for the new flag in
> > > > tools/testing/selftests/openat2/openat2_test.c in my second commit =
in
> > > > this patch series. Where are the fstests that I should add tests? I
> > > > think you added the wrong URL above, probably a typo.
> > > >
> > > >
> > >
> > > I did indeed, sorry. They're here:
> > >
> > > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> >
> > Thanks! This is a separate git repository, so I guess for both
> > manpages and fstests I need to submit separate patch series for
> > O_REGULAR. Do I need to wait first for this patch series to be merged?
> > How does it work?
> >
> >
>
> No, you can submit them in parallel, but they probably won't get merged
> until the kernel patches go in.
>

Alright. I can look into submitting patches in parallel. Thanks for
all the info!

Regards,
Dorjoy
