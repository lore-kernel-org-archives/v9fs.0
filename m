Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5F22D7A9
	for <v9fs@lists.linux.dev>; Sun,  1 Mar 2026 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378146; cv=pass; b=n6Sz0MYLn9VTErxUU5vOlvkm5XZWmxEwROQA5gSjbexujHtF4ZnEBJFdeZ1je7m2YbEHwxsC8hoj2LodOKLF6OdhCasHdGNp1FKRDKwFCUv1H5ZjoJYdU+k9IJweMKeLwdj9zZiU0rT9tUwLkIRLV67aftWJZLGVJSTOPldp5J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378146; c=relaxed/simple;
	bh=dK8JGyYdEozW0hh/3EWXgMcj1Vr2HLjTATqqOgadHrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtFR0Ly+JdDQ6gLLezS92gC/Cpc+0Rgr2VqShZhO9yqGp92p+yhSx7730SLg8efbvkjBgOmqt1EQg7YhoQkMQdOPEr+2fyyyUHNMu7UO1CcwNvE2caQd090LKAifPrajTEwwc94hEJlLm5EbghBOb0E33QOg3/+upOrJ6P6XJ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUEhOuj5; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUEhOuj5"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5673804da95so1602782e0c.0
        for <v9fs@lists.linux.dev>; Sun, 01 Mar 2026 07:15:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772378144; cv=none;
        d=google.com; s=arc-20240605;
        b=dZ17hDXsgwaonn+3/9tqXHotS8aWgb+TFC1vaAKedtQi/5pOM0uUMk3mmFtxp0Mjkp
         NdNzk4cPpQ1Egjl8LMYP9tYJBQrdixIw+GlPfUJMmTFubcdWRQmLvwYCvP3KFptGgqrp
         QnSNQjYbD8SX93xgkYxvnmV3KtVsXxDJpPN1tHWmCxgZOat4Z0/yNsovMt27qeCjMrCG
         1n1lfOFgC5v2pa7ck0m3OD3XeLc/bI95WOidGEhhMFKmdeb8QJlVDSCR0BnHrfm4+9DK
         ApRnW5uODYH6LnjZS6MHA1xsl3mBK93ZppA7+CjkXk+jHiYAAP3OXs45Eq168s8H2eio
         QEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1nkyX5w5KMhDfO8wL4au5byg+U9cvBh7Yz6qo0nwRk=;
        fh=IRwRHmbIjdbWwTjMnmcNEUaf5RCT+tiHMRRtfi1rc9c=;
        b=Armh09ZvF7SueQ3QrxZ3cy1sZQHzxaA8XsFxxGbGg/5S3Oz4pbzc5BvllBScq53W/r
         UjKvgaOb7fjhKUGLXcp02N/8sFEBpyTYrZQd1COvXe2D0pH8DreZgA4xRdbp9xC3e/8f
         04+muFd0Nk37fHIjSKak8NsdxuHf9tEwQOFU75bzP645bvhNlUtOPH3be7+fTBEdMONe
         /bb7F1uryj8vTjrxO/0QaFDHKtKarG8JYA6FFdmECwgTJ7t9xXhEaCZ54soKTQMzRKfL
         U49dHqrdJ8YuBSKHhi+L4JWytTPNAko/SG0meZp2JjTWoU89miWShivxERAy5BQEHam0
         s47w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772378144; x=1772982944; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1nkyX5w5KMhDfO8wL4au5byg+U9cvBh7Yz6qo0nwRk=;
        b=RUEhOuj5UlzlwHyNa0eVLg/BE2ilumYgDsuWDHtchItbxBwpl1A/ZC+l8aqVSGdNzP
         gZqm25P70i82ZCXOdzs/u3+Vi2NZAWl2neei1JnsLd0+BdwKbHEFWlIkcpNOR/ZapEaR
         yPUgL0dZrLuqKbeByZOhms8mVVMFdEYwsrQFvNGFZHTzjHKlx9ZFHNb1mzsn/BcSAZY5
         2awR7xrvIxpN/+zLF2K/2RVvIZKtCSkeh8PoKnCi1loV/aTu7ISacexUfIPWMFhwblWI
         q/SsQLAcpwrfj+HcxiV178xjAVLrcqTADep1Dnmkj9PhZses0vgT+aXr+ECin/q4ci30
         3a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772378144; x=1772982944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1nkyX5w5KMhDfO8wL4au5byg+U9cvBh7Yz6qo0nwRk=;
        b=w4nlYszdnD2ZtLxfOfUaBHlDYhgQDUTXy68oDtuv04LC7fVIh1yrcvBEhUmTBijCl2
         1aa7+bL1Rpjb7hM1fqLhNckguM+hJrCQzH7zNB4aCbPus4v0iQjZoLvGX9LeEL+TjRKZ
         bIwCZJXvH2IU33tLZ9tOEFdfy3mAxpybRukNOIMKasc7U0n9F552vu+DncPHYK7T3SfU
         4R+RwPXhZdfHNFaJo318zdONYMnkpJi9GXJ34ZVLFDEKOFeXU43aq+sAbEtGSMgLElXu
         aPgeRtKdnbux36VL/VNMfIaL6BlqLTE/ss7biDRPN4lz/FV1+CaUakzvblRoYXa/7/DC
         tzQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfLc/XvTUY/NA3c/zNC66wTnygbncMnIvTCObBXI0EMCdH7ryOpYbOWj0jRITafMKBRN4A@lists.linux.dev
X-Gm-Message-State: AOJu0YyE1qnq9MxOR+0FOIe5wRhTV50ityuaAZ0npKmnzNeNZp0SFLxl
	GoOQ6Y33vPIvITuSTlxbDP7IyvLkcHT+l4RCvpCRH7aeIQHuhnYH66qsw5aRooTnZ3lSYmkIRlb
	9Ch2hTQL+L3LdA5IjIHnZ8zVEaEtlVF0=
X-Gm-Gg: ATEYQzxGah+14Xt1pGzKtzZ5AkQYY7GIfdgUtuZgqvW58jTrzSNynbsl8c58RMMaSdD
	zuY+aA9c/iA/kFuG4W+E6U9szC6oDKYUADMqUoYe3+iQnpVxbkRHOmRgIB+cj224lGWhCXMpCrh
	QmWiMrLJYEajRqBqWBB1DgV/a05qJYNa+1AUm2CGsSJbqF0WlAF1KrpJo7g6j3Fr9xJmnvAT1Fa
	oq63Z5KRf11DMp34VPe4vKhY+UHsx45meclv7Gu2CmbQOKPXjFvAxtvLF7IBuCYE4Lxvf0a1aMe
	hU0Jn62YcnjebHH56KD3k6Bzw1TM9wsN+4N8rMI34Q==
X-Received: by 2002:a05:6102:510f:b0:5fd:efb0:8563 with SMTP id
 ada2fe7eead31-5ff324dc589mr3714118137.26.1772378143761; Sun, 01 Mar 2026
 07:15:43 -0800 (PST)
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
 <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com> <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
In-Reply-To: <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:15:32 +0600
X-Gm-Features: AaiRm51uGb22GXl5p3FqZ7NC0pcEYjsHHjv8pL49Bl-0u37YWrXpqgAvLnlZ9vg
Message-ID: <CAFfO_h4brg90tMNp6VAzs5Lo8Lbu=DK2csjDqr2zspOygKEFCg@mail.gmail.com>
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

On Sun, Mar 1, 2026 at 9:10=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 21:01 +0600, Dorjoy Chowdhury wrote:
> > On Sun, Mar 1, 2026 at 8:47=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sun, 2026-03-01 at 20:16 +0600, Dorjoy Chowdhury wrote:
> > > > On Sun, Mar 1, 2026 at 6:44=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > > >
> > > > > On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> > > > > > This flag indicates the path should be opened if it's a regular=
 file.
> > > > > > This is useful to write secure programs that want to avoid bein=
g
> > > > > > tricked into opening device nodes with special semantics while =
thinking
> > > > > > they operate on regular files. This is a requested feature from=
 the
> > > > > > uapi-group[1].
> > > > > >
> > > > > > A corresponding error code EFTYPE has been introduced. For exam=
ple, if
> > > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the=
 flag
> > > > > > param, it will return -EFTYPE.
> > > > > >
> > > > > > When used in combination with O_CREAT, either the regular file =
is
> > > > > > created, or if the path already exists, it is opened if it's a =
regular
> > > > > > file. Otherwise, -EFTYPE is returned.
> > > > > >
> > > > >
> > > > > It would be good to mention that EFTYPE has precedent in BSD/Darw=
in.
> > > > > When an error code is already supported in another UNIX-y OS, the=
n it
> > > > > bolsters the case for adding it here.
> > > > >
> > > >
> > > > Good suggestion. Yes, I can include this information in the commit
> > > > message during the next posting.
> > > >
> > > > > Your cover letter mentions that you only tested this on btrfs. At=
 the
> > > > > very least, you should test NFS and SMB. It should be fairly easy=
 to
> > > > > set up mounts over loopback for those cases.
> > > > >
> > > >
> > > > I used virtme-ng (which I think reuses the host's filesystem) to ru=
n
> > > > the compiled bzImage and ran the openat2 kselftests there to verify
> > > > it's working. Is there a similar way I can test NFS/SMB by adding
> > > > kselftests? Or would I need to setup NFS/SMB inside a full VM distr=
o
> > > > with a modified kernel to test this? I would appreciate any suggest=
ion
> > > > on this.
> > > >
> > >
> > > I imagine virtme would need some configuration to set up for nfs or
> > > cifs, but maybe it's possible. I mostly use kdevops for this sort of
> > > testing.
> > >
> >
> > Got it. I will try to figure this out and do some testing for NFS/SMB. =
Thanks.
> >
> > > > > There are some places where it doesn't seem like -EFTYPE will be
> > > > > returned. It looks like it can send back -EISDIR and -ENOTDIR in =
some
> > > > > cases as well. With a new API like this, I think we ought to stri=
ve for
> > > > > consistency.
> > > > >
> > > >
> > > > Good point. There was a comment in a previous posting of this patch
> > > > series "The most useful behavior would indicate what was found (e.g=
.,
> > > > a pipe)."
> > > > (ref: https://lore.kernel.org/linux-fsdevel/vhq3osjqs3nn764wrp2lxp6=
6b4dxpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6/
> > > > )
> > > > So I thought maybe it would be useful to return -EISDIR where it wa=
s
> > > > already doing that. But it is a good point about consistency that w=
e
> > > > won't be doing this for other different types so I guess it's bette=
r
> > > > to return -EFTYPE for all the cases anyway as you mention. Any
> > > > thoughts?
> > > >
> > >
> > > There is a case to be made for either. The big question is whether yo=
u
> > > can consistently return the same error codes in the same situations.
> > >
> > > For instance, you can return -EISDIR on NFS when the target is a
> > > directory, but can you do the same on btrfs or ceph? If not, then we
> > > have a situation where we have to deal with the possibility of two
> > > different error codes.
> > >
> > > In general, I think returning EFTYPE for everything is simplest and
> > > therefore best. Sure, EISDIR tells you a bit more about the target, b=
ut
> > > that info is probably not that helpful if you were expecting it to be=
 a
> > > regular file.
> > >
> >
> > Good point. I agree. I will fix this and return -EFTYPE for everything
> > in the next posting.
> >
> > > >
> > > > > Should this API return -EFTYPE for all cases where it's not S_IFR=
EG? If
> > > > > not, then what other errors are allowed? Bear in mind that you'll=
 need
> > > > > to document this in the manpages too.
> > > > >
> > > >
> > > > Are the manpages in the kernel git repository or in a separate
> > > > repository? Do I make separate patch series for that? Sorry I don't
> > > > know about this in detail.
> > > >
> > >
> > > Separate repo and mailing list: https://www.kernel.org/doc/man-pages/
> > >
> > > ...come to think of it, you should also cc the linux-api mailing list
> > > when you send the next version:
> > >
> > >     https://www.kernel.org/doc/man-pages/linux-api-ml.html
> > >
> > > This one is fairly straightforward, but once a new API is in a releas=
ed
> > > kernel, it's hard to change things, so we'll want to make sure we get
> > > this right.
> > >
> >
> > I did not know about this. I will cc linux-api mailing list from the
> > next posting.
> >
> > > I should also ask you about testcases here. You should add some tests
> > > to fstests for O_REGULAR if you haven't already:
> > >
> > >     https://www.kernel.org/doc/man-pages/linux-api-ml.html
> > >
> >
> > I only added a kselftest for the new flag in
> > tools/testing/selftests/openat2/openat2_test.c in my second commit in
> > this patch series. Where are the fstests that I should add tests? I
> > think you added the wrong URL above, probably a typo.
> >
> >
>
> I did indeed, sorry. They're here:
>
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>

Thanks! This is a separate git repository, so I guess for both
manpages and fstests I need to submit separate patch series for
O_REGULAR. Do I need to wait first for this patch series to be merged?
How does it work?

Regards,
Dorjoy
