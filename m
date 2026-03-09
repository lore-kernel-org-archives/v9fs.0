Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4DD3B8945
	for <v9fs@lists.linux.dev>; Mon,  9 Mar 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075034; cv=pass; b=Jf81BIjj4ZG6VA1nJSbqbApnAsgarz+Oo6Kl/Svv/qIgJvys54JNszqwTyJt9ZKZK6PaG3PJUaGIzG05Tj+KOAl96bOMEvYMTjmUwvDVB0mybgeU2opSAVwG+DjB2h7zcN/Qu/6DY59NgL/ec1cG4uua+pf0LnCknS89YnGMT7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075034; c=relaxed/simple;
	bh=dElGlCWfTDUCaV3zjXVrwEshlrdMTwzM4Mn069fiLm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peu//1p6xu3KctojSddy9Iu7xTmegeglWqHR/aF6PYWD1ndUhLSBnYvvcx7cGSizgG5X6o0VXL4/UXX8xK65vtyxmG4AcbaGNCWzCazZP+LpnD82baIR332Be2s+hEsPkgcvJItslGHAgUYnof10VmxewvlgvWpI/zJDWidQ8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=UcjeJYuJ; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="UcjeJYuJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a13d40c760so3265218e87.0
        for <v9fs@lists.linux.dev>; Mon, 09 Mar 2026 09:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773075031; cv=none;
        d=google.com; s=arc-20240605;
        b=PP/wyt0prZIjNjJATRfr7qTMnoIvxu5rp1VlA6DKL8Xse6h2XBYfXRvtI1yQV+Mq+6
         JowZl5BWQD7Vj7Na0QGloCLfS9jziPPriz9AHzPrbuZ125BF1Wu1pfLxGnOG7KsQhB4F
         MIPlXCWJMlWczpSAZeUVd+BtTvBvKsnaj0m/qXbH6u+W9ttCQHavbRfwT/fKe1jVyfx6
         Vn8fcOeHBGhpRWLE9r0O/EJkZ/zISDD7LLOH9i7VX2c8ppUPN0+fye59tyL0onafFzl4
         Y+ichSVMxxZqb6M5mkKwV/FRmotvxZ3CyJQNlTZfHSIiWDbMkdGSQowEF5NZuQnjN/+n
         ZAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        fh=dU3cHowreCV8no2rdnTEVK/OudE6UUSQIki8qwhinIo=;
        b=TH4QaJGg/VchEnpYkgcJzmsml/C74qKDqGEyts0Ix9HdsFLO1FlQcuUkRfO5tzSclv
         pY3xPtS8/sQM3xkeUZeia0DwPysm1nuStJnRi6zkYouUYOI++gl3nuQPX2JtISJokUZS
         4joGMvygEfWL/S6zSCgPR44F9+uCq/XGtxipzrVydKOHU6+FbFvWa415dj1+qWLSqIdl
         4S40THMTMCv1WZNT5U0ZgywNLZLUTSyR92Jh4A6S2OMxcykfN3Ob5H6Z+O9nOXSryyXp
         sVZHgVixaIfdexVXFfSI1iRHLJJoCejgH2CfWvVkBHlSiK/SYPF5sZB6DZFtTzIJuDBB
         jZ9A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1773075031; x=1773679831; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        b=UcjeJYuJZzFQG+SJZgTxVUgESAKbc5A28ur9OMNPuF2pMc0wbg4Hbfp4nqWmb7NqQw
         vK9Enuslwy4eBGwz19ywhs9uKL7bHA58IWKMtu+AYqWTNfFsrUy2o18mWHNZWPXu/hdf
         orpPmdClhc5tWl9UmlCbFGlSPgmftpz1aNwYqmenL6BICWoe4Eca3oKHAXQmqOefCy+M
         dNvW4vtUGUAGjslp/ap1ZVpr73Ir4hp0KVZ35fCv4yVfhBAI5R27Zw++MHkd46wqG36n
         HuANY2rlRpjE0lrlT1jGr9w5zaLmjdm0ullPsqA0syR2oARIoE05PPg8bAtGb4OkSofK
         CKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075031; x=1773679831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        b=F0AHZ2T5ztOKjmCi9PnjT0Wp5VTgGh6Vnzdx1XsFdemzv50nOfXsdgVxMrFk5/MyNu
         Oi2P5kcyJFoZK6b+IRX/sM9zRpVq7XeSkylnvlir7HROh80zW2LrlKo0GgbrUo2Elvkg
         NtAYzZWykbjOZAg1wAGljm8wqzbcdVGKwsOb6aFK6Fjd96RrQ2WWIQ16Mwv8amMU7ieP
         yQXNfZ1khl1dkJuuee1cv5atuyPy9YJwNy6MImEdV7izu3czqbypcBA26a8o5ikdIYVS
         8jXrGd4I5IArXjzGmoLkdk0CqfEwoS0PhD+pMD5+jH4RsLgDPsblJyerBk9P7vwfFJ5D
         dDGg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ruqLYg/pxbNUg9TYkmfbuI5FkYsVaSQaPxbRUMIaP1BODDDQgsybU9nsrajVVBYmkBL4@lists.linux.dev
X-Gm-Message-State: AOJu0YzIkiyNylvTCLiTC/8NCJ4V7CHdzn0WGAOulAPHJVf5HR7fxV5H
	x4cG9h3BIXQC43V/1sMs/hx/n7I9A5ubLUuiQJdFKntc1F6dZpXfrbj+lOSi++02MZBGvZGgrm8
	yrP9DuBs8Tgh709ZVa0rBz/prImb1kwhSUv96GkRb
X-Gm-Gg: ATEYQzxbKgty72DSxrzGQ0htHD22XL79sMK0BE/j+cJE4iQAibfqIHGJ+z9tJGvWwkS
	MR4zZNLAxFG3evoyQOboJp2Q3QkSWDYMvnk4HRjhpUrPx1SvbbY3a91tJCpV7mter0W9Whgr3m6
	28Ti0aovdCHiWHucRYezwve1HrUKYq80wB5Ga+dwh7pL6JnOUMbHGXzM/Tm4Q2tgnU2exsXv6mt
	EyhivNHJVDkWhS2FOQaOM5jL/CAgYCyceGWHG8us+WjfoXQIq3wRWrFp8facI3S0O8lH55olH3q
	ceiCFsOZXKwdtds=
X-Received: by 2002:a05:6512:33c9:b0:5a1:3d7f:8fbb with SMTP id
 2adb3069b0e04-5a13d7f930amr3518616e87.2.1773075030208; Mon, 09 Mar 2026
 09:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com> <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
In-Reply-To: <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 9 Mar 2026 09:50:18 -0700
X-Gm-Features: AaiRm50Rb5608a_d1ziKt7e3a5xZPZu4oB7F4zw8iu_Gm1KsPQukeeL-PdrpHz4
Message-ID: <CALCETrWjb+V-zrMT412MtmgDCx9y8simJBQ7+45C9MtdiSMnuw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
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

On Mon, Mar 9, 2026 at 1:58=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sun, Mar 08, 2026 at 10:10:05AM -0700, Andy Lutomirski wrote:
> > On Sun, Mar 8, 2026 at 4:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy1=
11@gmail.com> wrote:
> > > > >
> > > > > This flag indicates the path should be opened if it's a regular f=
ile.
> > > > > This is useful to write secure programs that want to avoid being
> > > > > tricked into opening device nodes with special semantics while th=
inking
> > > > > they operate on regular files. This is a requested feature from t=
he
> > > > > uapi-group[1].
> > > > >
> > > >
> > > > I think this needs a lot more clarification as to what "regular"
> > > > means.  If it's literally
> > > >
> > > > > A corresponding error code EFTYPE has been introduced. For exampl=
e, if
> > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the f=
lag
> > > > > param, it will return -EFTYPE. EFTYPE is already used in BSD syst=
ems
> > > > > like FreeBSD, macOS.
> > > >
> > > > I think this needs more clarification as to what "regular" means,
> > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > >
> > > > Use-Case: this would be very useful to write secure programs that w=
ant
> > > > to avoid being tricked into opening device nodes with special
> > > > semantics while thinking they operate on regular files. This is
> > > > particularly relevant as many device nodes (or even FIFOs) come wit=
h
> > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I=
/O. Consider
> > > > implementation of a naive web browser which is pointed to
> > > > file://dev/zero, not expecting an endless amount of data to read.
> > > >
> > > > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > > > where that fd is a memfd?  What about files backed by non-"fast" di=
sk
> > > > I/O like something on a flaky USB stick or a network mount or FUSE?
> > > >
> > > > Are we concerned about blocking open?  (open blocks as a matter of
> > > > course.)  Are we concerned about open having strange side effects?
> > > > Are we concerned about write having strange side effects?  Are we
> > > > concerned about cases where opening the file as root results in
> > > > elevated privilege beyond merely gaining the ability to write to th=
at
> > > > specific path on an ordinary filesystem?
>
> I think this is opening up a barrage of question that I'm not sure are
> all that useful. The ability to only open regular file isn't intended to
> defend against hung FUSE or NFS servers or other random Linux
> special-sauce murder-suicide file descriptor traps. For a lot of those
> we have O_PATH which can easily function with the new extension. A lot
> of the other special-sauce files (most anonymous inode fds) cannot even
> be reopened via e.g., /proc.

On the flip side, /proc itself can certainly be opened.  Should
O_REGULAR be able to open the more magical /proc and /sys files?  Are
there any that are problematic?

--Andy
