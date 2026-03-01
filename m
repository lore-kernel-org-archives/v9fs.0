Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794A332914
	for <v9fs@lists.linux.dev>; Sun,  1 Mar 2026 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772377332; cv=pass; b=mszQpBWvEWdcmOm+cJPFBNuOWxPki3H84K2eYQI9+3bvDrZPGvxnmM00elUah9dJJ9nzweEgK8Izvk/ie7lDWKp7mfDSq+nnHdBuLtBftGApo8RD9NFbrDk1azBjspDgKgzDJvWrv+9FmWt9CkO06ZPGyplrJcq36rbdq/jglTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772377332; c=relaxed/simple;
	bh=V37CR9us1N0esOdbbifQtaXVD0Ciudjbj+QVzwLv+pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5qEEENBmtdvjCYvRKwpgrWN6bqc4f4j46u2E2PEedNGjPOUrJN3NU1N1CASrALb1IIwl7I/Ev+VHjwYXd4ir5jILWkiPRpYcmC9ZWBxSWaYC9RC68YBsvbcEqHGUQGe10gM3L3YA2fgUrknVawt95pDJJZJzSh2Eknv1yKrqRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6ojLO+K; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ojLO+K"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso2103368241.2
        for <v9fs@lists.linux.dev>; Sun, 01 Mar 2026 07:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772377330; cv=none;
        d=google.com; s=arc-20240605;
        b=AhY1e9+Voj8ll7IEX5xyIbpq8EFfw0s41CyD5Tz/ZnQJ++A9fQFFtB+8eYhPpy+nCI
         wt/fPvyh2GzM9KFdPiVIG2PoMNWy5G/RS4BrwY5d4iDtCufo5HJ+wWNlxV35oYE3C0QE
         V80LsbGqjnFlmqFZFuIpUGehHeqY8LJEnyJdqV8a++I4J5SWweLt+Njp3rBeSH6cfVyH
         WT/Y41Ic1URDm5kABhVPHd5Q4pnsuMdo4XdDBkmi4bqTPLQZCVFJM5RKzj+VyaePD2ue
         KX5XD1hvtA+OvzYXpdcUMXUNxvQyFLspnYNclTXkdBROJRB7M+kWJH/LMTkic3eJIApG
         +G5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        fh=cQRXMQ+Z+YbYxzh6+p9syJOcRpZFKhNH6xNXwzNzYxM=;
        b=K2QuxVqYobRupILgcNOOj92w9VTiBHLcSLCBnXX24zrDHaUIcaACiWMFH8quBqTDhk
         +R9aGIpk0DHfK6a9tAEp+xOzfGjz+Orjkw4d54NdvH4sNPk3icr+gb3rRFX1qiz7wQ75
         fYO8pCv43Tf6LKYvDzJolh2m4wG1Hb9YTVZCJe7rR3bm0tf+l3wwq8C+lIo19LxkEFAa
         IwMGz/5l0cR89jg7UD9rAihlNAcfzOIt5K6cTC2eiEUbfJuKJZ45YCEFNfHDT/jO6Q52
         UgKZHduNVRvfUPSsU8CWhXaxNhQSKaaq/zA+V7ZOradu8rmtu1cbbTXdThEQdEhdh/d+
         R/Iw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772377330; x=1772982130; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        b=N6ojLO+KaFFJl20u2JDxJDro17JRopLwFVMGhR9ECvFYy7jw2L8019dVqMB7yuDtfF
         8yc9q7CyTSIhFH90SuHWUr5mXATAYzdDG6mSIEvImgyjLxy/Fj+apXqNFLY9sA8TIuth
         rbz+qnU4e82fOVNV6P14lTvmBGfMV2Npgvwn70G9EeDnirss/tnYiI5ZLGPaLG6+X9Ck
         +vNHhKSWEHzxnRd0Rt11ykLowhrWz/ijWHUv035Av4fS2/kp7MFC28Uodsxmd5sWUxbF
         wAVdLWILaezLYl2JDI051jT+3DwGRlvpTgtcsMAcV+l9xijpK5VrlFHfOQHpDAE+gVAe
         fwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772377330; x=1772982130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        b=lwULoBn87+twsslDNRG3sfgyEGPq0pJ09ZRQVpKBnlpBheeYUqScGdZhiyAIXHZsCw
         z5+pa8/JJKfuVfUH0lAV9xv9LW8MQP3SWo3pkfnhVrdqpu64dPvWJ8ja5IiHHWdbPQo9
         bMLAn7uH0Iw4olNtZvqfbC1nFNGGKq4KWPk2l7h2VannzJMo1nZVjk1yfY1qr91M1fVY
         bU3pLOju/pWPyIlTS82IoYawgu/p5ehpEX5eIZ2sNVUjUpk7yrEAAjXxyWmFXidgQ6VT
         kMRfw2k2AFlJy2ciOyO6EYyawNjNwpjRda0auw0IzTgbBdlCxmPc1s5s01vRz3WEHus1
         9iFg==
X-Forwarded-Encrypted: i=1; AJvYcCVsLBtfIBK7SolkyQOhW5f4zWIOwY8hHKSHC+iR4PPfrBj6mvt7eqasVxzMUJDTHqjT4JM4@lists.linux.dev
X-Gm-Message-State: AOJu0YxDq5BNcONSlLJrfzSOQP9iuYxadxI7KBhpb1z8fZOZPTLQfWSn
	/GkRiRKlNtiQdSuX/Xl/w1fh+L+ZCSqoWsnN3g6yiuVkA73HGcdyh5W5TWY+5HBZExh/7rQNpwa
	FXQYD7bR/XbZJvRe/0HPDbppxkZCuN3A=
X-Gm-Gg: ATEYQzxTiUTz8EIlceesGedFdqu86/iEc90FXzwocarj0rAxHX6sySSs6gJ5n7sSggr
	hjw+MKS/gFfPdmopoTLosKNcmMd9cuq9yVezr9L1me+73KeOZSQ3RAGjGJEfv2kDrey8F9p52ar
	3d/i2711im4mEd9wd6HqjFR6ITR4Av5+Ny1c/Hk96YT6wKKydOKbUJtwoyqSP6+9Xr2RUDWRk6Z
	gE+QkVWl4gSJJfBZCD6eLw6/DBdkNbB5vxU9VDG8XOxUKfL4Wl+NVPoQ6B4DnxIqOJUn3HDuB9B
	emZ47CKCb31Jne5IleZp4Cv+ugTW7Nfe0UBc2e4bwQ==
X-Received: by 2002:a05:6102:cc6:b0:5ff:1445:88ff with SMTP id
 ada2fe7eead31-5ff322714abmr4377922137.7.1772377329579; Sun, 01 Mar 2026
 07:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com> <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
In-Reply-To: <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:01:58 +0600
X-Gm-Features: AaiRm50b25Ilp0U_HqmXYGEDuiLaRPqAldbyxEp-tlfkTSKlimm7-yBVSXDXKJs
Message-ID: <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com>
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

On Sun, Mar 1, 2026 at 8:47=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 20:16 +0600, Dorjoy Chowdhury wrote:
> > On Sun, Mar 1, 2026 at 6:44=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> > > > This flag indicates the path should be opened if it's a regular fil=
e.
> > > > This is useful to write secure programs that want to avoid being
> > > > tricked into opening device nodes with special semantics while thin=
king
> > > > they operate on regular files. This is a requested feature from the
> > > > uapi-group[1].
> > > >
> > > > A corresponding error code EFTYPE has been introduced. For example,=
 if
> > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the fla=
g
> > > > param, it will return -EFTYPE.
> > > >
> > > > When used in combination with O_CREAT, either the regular file is
> > > > created, or if the path already exists, it is opened if it's a regu=
lar
> > > > file. Otherwise, -EFTYPE is returned.
> > > >
> > >
> > > It would be good to mention that EFTYPE has precedent in BSD/Darwin.
> > > When an error code is already supported in another UNIX-y OS, then it
> > > bolsters the case for adding it here.
> > >
> >
> > Good suggestion. Yes, I can include this information in the commit
> > message during the next posting.
> >
> > > Your cover letter mentions that you only tested this on btrfs. At the
> > > very least, you should test NFS and SMB. It should be fairly easy to
> > > set up mounts over loopback for those cases.
> > >
> >
> > I used virtme-ng (which I think reuses the host's filesystem) to run
> > the compiled bzImage and ran the openat2 kselftests there to verify
> > it's working. Is there a similar way I can test NFS/SMB by adding
> > kselftests? Or would I need to setup NFS/SMB inside a full VM distro
> > with a modified kernel to test this? I would appreciate any suggestion
> > on this.
> >
>
> I imagine virtme would need some configuration to set up for nfs or
> cifs, but maybe it's possible. I mostly use kdevops for this sort of
> testing.
>

Got it. I will try to figure this out and do some testing for NFS/SMB. Than=
ks.

> > > There are some places where it doesn't seem like -EFTYPE will be
> > > returned. It looks like it can send back -EISDIR and -ENOTDIR in some
> > > cases as well. With a new API like this, I think we ought to strive f=
or
> > > consistency.
> > >
> >
> > Good point. There was a comment in a previous posting of this patch
> > series "The most useful behavior would indicate what was found (e.g.,
> > a pipe)."
> > (ref: https://lore.kernel.org/linux-fsdevel/vhq3osjqs3nn764wrp2lxp66b4d=
xpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6/
> > )
> > So I thought maybe it would be useful to return -EISDIR where it was
> > already doing that. But it is a good point about consistency that we
> > won't be doing this for other different types so I guess it's better
> > to return -EFTYPE for all the cases anyway as you mention. Any
> > thoughts?
> >
>
> There is a case to be made for either. The big question is whether you
> can consistently return the same error codes in the same situations.
>
> For instance, you can return -EISDIR on NFS when the target is a
> directory, but can you do the same on btrfs or ceph? If not, then we
> have a situation where we have to deal with the possibility of two
> different error codes.
>
> In general, I think returning EFTYPE for everything is simplest and
> therefore best. Sure, EISDIR tells you a bit more about the target, but
> that info is probably not that helpful if you were expecting it to be a
> regular file.
>

Good point. I agree. I will fix this and return -EFTYPE for everything
in the next posting.

> >
> > > Should this API return -EFTYPE for all cases where it's not S_IFREG? =
If
> > > not, then what other errors are allowed? Bear in mind that you'll nee=
d
> > > to document this in the manpages too.
> > >
> >
> > Are the manpages in the kernel git repository or in a separate
> > repository? Do I make separate patch series for that? Sorry I don't
> > know about this in detail.
> >
>
> Separate repo and mailing list: https://www.kernel.org/doc/man-pages/
>
> ...come to think of it, you should also cc the linux-api mailing list
> when you send the next version:
>
>     https://www.kernel.org/doc/man-pages/linux-api-ml.html
>
> This one is fairly straightforward, but once a new API is in a released
> kernel, it's hard to change things, so we'll want to make sure we get
> this right.
>

I did not know about this. I will cc linux-api mailing list from the
next posting.

> I should also ask you about testcases here. You should add some tests
> to fstests for O_REGULAR if you haven't already:
>
>     https://www.kernel.org/doc/man-pages/linux-api-ml.html
>

I only added a kselftest for the new flag in
tools/testing/selftests/openat2/openat2_test.c in my second commit in
this patch series. Where are the fstests that I should add tests? I
think you added the wrong URL above, probably a typo.

Regards,
Dorjoy
