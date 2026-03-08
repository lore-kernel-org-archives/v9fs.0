Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62D38B7B2
	for <v9fs@lists.linux.dev>; Sun,  8 Mar 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772989825; cv=pass; b=JCPkA2hPaI1RdpJ35+DP+GALw8sMX2b+tifympuyQp6me5yzdqzayItO99p9sUsebXORtkFWekOtOxQsENEye4QmIEgIhzLTqvbfJQMZ5sqfk3T8l7cBEOoKR0UyfRltURexppAnsJaxMAuwfU1S2l1poFk9Vwa5gxiyziucwME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772989825; c=relaxed/simple;
	bh=mPpVNiloCu6uzQI1WxZPytR2t4HpF2nlFZDXYS8kVTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4iiQeLZsWJUHrbAitpqOkbFqI/+iDh+NYPc7+4u9vNzmcrHL3mk+GZUn5EDoFfwAZ3bsYvh6s6lXpi0YduNXMZubZGKzKHgi1geHSOabs+iqSkTapWI2CFIMA8PkllCDSiGA05tTSQyMbROVhIk6WrEUdD6dCiWCIWU7rQwzno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=rkNHNVY3; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="rkNHNVY3"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a1330ac6c3so3654860e87.1
        for <v9fs@lists.linux.dev>; Sun, 08 Mar 2026 10:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772989821; cv=none;
        d=google.com; s=arc-20240605;
        b=h23Iwyb/jHJxKEyEbhUFpYkQm1DJUVpjl1wSbpJ70rwemlzoAT0rvj7QfFBrQIRcGE
         Ska3NqKeMVCGaZcLSJpC+LaBujFuo6QJjgDLwIZ2EKcMPKNlH6LzAKiYLGX6OXaA0WzF
         8QGm/X+6A82HMgS5DhQ6GZc94JFOAEGK6HzH6nkrIndZWe89Qg1NDohw0veG3C/479g1
         KxmIkPPSAfrPad7AnygQ3PPzaJxU+ZoHw5cuHXh5ZtEQ1ZMNYEowSO/jkcQoWngX55DS
         q5ukDWI8UOqMYWTPLO7iaK7+QcYvOxFUj/NclAZRH+5oFrmPd+rEL0MCH9KqCYgZyViq
         M06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        fh=18UJB1Yi8qRCubgLI/n9DnyAIO+sHqG4m5MXvOc22Hs=;
        b=ibEOMxYNyQLvdVJ+M2n3S6uM2kUWPDVMqvr8PO4Mr90wz76meSxsTgM73Ls1RkkLjp
         znT0CvvIJGTKZI1EDzI9M1V2Gf1YcbiQV/5wFjD76i+60xSrHaCjRqinebjxRLpfkuu1
         SYVsYtKX+HGo8aUbftNa0YQScJv91eRJWaUU0PbNEkwqroTjYWSkDUfzonobTdy7fbwB
         7WBelmS/wreovcgjfZD+3mH+afNaEtsAWN4tDZWcxNhqOPMQkJSXBHlnNYMZ+ejnyMqP
         A+wY4RWLWbXMZSfDZHBKKMUW3OeYXZ3vu9yJxnGpR0ZdrezT8SW61P/Kxh/7mAtkn5Rc
         rCoA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772989821; x=1773594621; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=rkNHNVY3S6GL1IRmDUzZDsGTamb3/JlqCwNiIRPlrHH1HXS6yJVEwsTHQATyTI7Sfy
         qH5aT9kZcoy54PIdYRJLGBk9d1u+LbsiZOf+Z9kR9rluPQhwlBIZ3hWfE5c5rG5o75Zq
         x8tAZJ++9Ae/9dxe16+ntCd/W1uZuaMctO7LDm72FwcdMHRlO2K7oQkdEDuYKydWgLCF
         DxpgGQO+yOvIZMt2ygwaR6wSShvOykxQ9PeXsZMyoyMJ4PgUTwrnJ0lQOjVrfT+tGOyo
         tM9nj4HAzkoCogNlVaBjJlmq+9Ap/PphSvPoRPIMRWl+l0cDwjDEjFJiUMyOaDT1Oo/A
         br+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772989821; x=1773594621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=QbwjriymJ9Na7hRUpvOk8Ztxlx8Lfm47e4SlRLScbLtA3nPSD3vAlVir1Bmtx8nBl5
         2U+XAAqV6V1jrs1ETn+pIPhLDfiWSP3scvJoV0nl0Faql/0N2/LPaHiNv5cmZ72FArhe
         v2gxr8fHWNHe8nbhd/G6whgvIBpCpI519kyyXKV6P4GoG6/ovJnMefBT8/2mLCP+bNCT
         qNZZ/4xwRsOGYRg4kDDqQbaeVjtsfy4rKbsOCP/+UF9fKX2jbcx4XoYDHfsc0olXu9/P
         9MGk83SnEI25su0U3jPH0Y07tHSwR6tRNAksSJyFoUJeb7X6lo8e2vjV2wGl0raNYa57
         0oWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4gMT/eEYjLYVHsxL4Z0xli/ri9Cx8WR+//fZX1TLD7qE3z4umM5FV3kKjKNWtA2FYxbWW@lists.linux.dev
X-Gm-Message-State: AOJu0YyrsgUKWM+6+NovidB7SmizA1gt2nJfYmVRh5wojMpSk8d8R7tM
	cdOuKjBWULQaZrsdqsOaHVkqI0cFlliQb2k3FaPlakoq7T36x6/cLM7QSN8Wk5fd1KZO6ZfGRlM
	ugzSee+g5T2FNSmwBUXTT6z7dhTn226s2djZBvScZ
X-Gm-Gg: ATEYQzzwWYBXx+zjwe84Q19Mn/VVJduDpJwXH2B+UYYEPYhrO2bKNLVvjVWowj/NJtT
	cJiIeju7G/iCKiOerhpgQAg47z8Oecnk/n2sDqyJD3nXa6qlXQICR72Djr+eq65QS5xgKXH8fF0
	v13wdMysMOunfp9za1hzP1zWmnBe7S31M+ge6lzJgbylvBfnTOwsnQ2pp39iEmMNBuq/OiYIwIu
	/Q0oDSwvdAhXEUOkNOvrVjZnaexHVMyCno/mpzwDVRhp3MBFmvLFeQP4xf8amh7TupJJMk56lIs
	czNeXp5KiDaL6mw=
X-Received: by 2002:a05:6512:10c1:b0:5a1:3539:1181 with SMTP id
 2adb3069b0e04-5a13ccc6854mr2584241e87.20.1772989820622; Sun, 08 Mar 2026
 10:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
In-Reply-To: <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 8 Mar 2026 10:10:05 -0700
X-Gm-Features: AaiRm53NE6RSEVl9G8ylA7uki0xCjhtuxwfA8HvbEL_OVbVZXAi0saXeclsKpvo
Message-ID: <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
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

On Sun, Mar 8, 2026 at 4:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@g=
mail.com> wrote:
> > >
> > > This flag indicates the path should be opened if it's a regular file.
> > > This is useful to write secure programs that want to avoid being
> > > tricked into opening device nodes with special semantics while thinki=
ng
> > > they operate on regular files. This is a requested feature from the
> > > uapi-group[1].
> > >
> >
> > I think this needs a lot more clarification as to what "regular"
> > means.  If it's literally
> >
> > > A corresponding error code EFTYPE has been introduced. For example, i=
f
> > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > > like FreeBSD, macOS.
> >
> > I think this needs more clarification as to what "regular" means,
> > since S_IFREG may not be sufficient.  The UAPI group page says:
> >
> > Use-Case: this would be very useful to write secure programs that want
> > to avoid being tricked into opening device nodes with special
> > semantics while thinking they operate on regular files. This is
> > particularly relevant as many device nodes (or even FIFOs) come with
> > blocking I/O (or even blocking open()!) by default, which is not
> > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. =
Consider
> > implementation of a naive web browser which is pointed to
> > file://dev/zero, not expecting an endless amount of data to read.
> >
> > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > where that fd is a memfd?  What about files backed by non-"fast" disk
> > I/O like something on a flaky USB stick or a network mount or FUSE?
> >
> > Are we concerned about blocking open?  (open blocks as a matter of
> > course.)  Are we concerned about open having strange side effects?
> > Are we concerned about write having strange side effects?  Are we
> > concerned about cases where opening the file as root results in
> > elevated privilege beyond merely gaining the ability to write to that
> > specific path on an ordinary filesystem?
> >
>
> Above the use-case, it also says:
>
> "O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
> which opens a file only if it is of type S_IFREG."
>
> Since we allow programs to open a directory under /proc or /sys using
> O_DIRECTORY, I don't think we should do anything different here. To the
> VFS, all of the examples you gave above are S_IFREG "regular files",
> even if they are backed by something quite irregular.

That's certainly a valid and consistent way to define this, but is it usefu=
l?

--Andy
