Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13C38735E
	for <v9fs@lists.linux.dev>; Sat,  7 Mar 2026 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772909795; cv=pass; b=sP/ZQxNVQrKgbyvaITlu+11skLRZdGTC/dd6KUQRwDAeFqQBQjNilyitxZtdKXKRERWN1F4vpstZsE7EfJBb9lSUGbUM57g5IJdQm3yS7DMwTEgfgYrTNzix3YpJH1bomIVvqrbZp29vULE1pY34O9Nnx4zgs1bNIeSxLdYIJR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772909795; c=relaxed/simple;
	bh=ipPnoEwRKGay/Kqh3e72TxDAS0WvWm5QHtGzwkgIhmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKfRkZXV6oS/+Uy8RjTrxUpHNCJZGe43UU6yOBVRZWuZhWl8yzi4IjoCqeEnQqK7Rjrcxwt1rR/R6WjwFp3GIgMOarOyvzlyz+KF0vxI9CpD0AT+pveqgshJxduD6jobE0Lcp8ws+T91GJKoI650NoP9T124pR1Zm9K2Lx4S0qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=SqZyTEVh; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="SqZyTEVh"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-389ff6e5885so88584171fa.0
        for <v9fs@lists.linux.dev>; Sat, 07 Mar 2026 10:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772909792; cv=none;
        d=google.com; s=arc-20240605;
        b=OYKwbERtBiWJNrHNVYCB9MWrymlAKyJMitFAMG1+Ijk4Abh39E+QB/GVig3EtnVAb2
         2H9x3FJ8pz6I6kzwikA6XCziL9+EP7+zs4byndnRjCbWnAflHxbKd21166Joky5TQw8a
         ufG0BHaOSgr5LjQ+/NyAFdvLgnIK0DedOqKlH0AkzhL2dPtDa6eUsQGG6pJugAhOcrnR
         OEjmxyIpuaDWjqaMXtm/pKH7QSX+GezdB4TGGvj/IkimJ7Y3Wx5powRkrObfjprcDAQa
         +Z7uVeKMQ6J06038WG+8dEQASfY+VaHbwZxPccT+0XC234oJ1bZlStHispv2kfI17IwE
         BLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        fh=YY6e1a5gL9b+0h4JrPlHTkdfzb7DiBrT5+4jzma1Dk4=;
        b=ESd5C7tMICxD1GvPUwi86bJjgH3bY45vmR5zm4l5MwL/ygTvq9rZBTIxPhs5XPI24j
         9aoW0Chqc4p0p0EuW1O7g/jF1eZdgDmzDRBPOeuWTyWI/IqrUHBO6TsVbEFKr5Bko/4c
         g6v5XTZ5CwXV0e+q076i9ItuU85LfFaKqDvUVP5754ZDssfSxxUp8VzmCHEJqi1AQlV/
         8p3PQRVS7rs+jlVDp9igvLTCq/0Y1Ncr+mid/b4Jsg8W8gtFwMPfxP7MKlbDgukbvk/m
         N7+XrBPrWJK+qYoR8FixWtI09pW7ITi5lEVwTdPQjYVPJ+KdwRNUm7PQjXnOxii6Lqj6
         oUIw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772909792; x=1773514592; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=SqZyTEVhZ3F7inxHVHbc0NvMEIKNoiEbgTdSx+E8r3qeoQTj9oefSZO0QZs6OUZVWT
         M2kZ2SLlXMhWYyBPhv6kEclcE6I//ARb/yyUy1sneWn/tMXFwqa9MzyHmsfU5LcLVYJ0
         CXw7eVXQr/6C60ws8ie8lyFV4fHSLCCcLgXNc5B7fsF1IGNyJkIvguuBMagz8GnawJ1m
         aLLq65ezHYS/beVaLvRLT3c8oC33d8XgoOmiH5mtMu9aYQvkNQslvM3RJNtPOsrHc+3b
         fYelXc0dP8ylFU+SlvMRpb5v1OIiTwWlAXN1AR0GpLX/AbNHr3AXFYHWnScrMC5Pt6wt
         dE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772909792; x=1773514592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=kYV/LET2D5MLBKVnwm1Qugu+6V9vz1BrnOJQYgygzCDCmrr7jQnq6nnWRqX0M186Xo
         uMpTYy3wtaRkcu9z8QojUcNJSxU5RlI70qLbolLLgZTKEHOxJgm98NLKXpKAb3Tji95L
         NvINcImuI4l+fa9p6NZBbpscnj/jCYIsCKie4D4ic5OpXRfE8kWZ+1HjCF0tpo0vRllz
         ri63EF3POoBI3LCv3JieJUE1rULOF1yt3U5ZpLuU9mq2yhcwa+B6Y7helZO1mtmRjaOP
         VYIM5XYpMfNdDwPxv//pKzLo0O7kCOAbEEVC++6EiwBar6vQ/JtCzHGD7iLJZzch3VbA
         hdeg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Lb0CynM4J6VdAGb0OKn+EEsNjJwHTPKDycaZuWLrc54dJsNZbmrLl6+3DjAYcDSutCvs@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd67XU4w9TRUtMl2GSSewI4OPkxjdxjRIlpTUyi3QKvr4Xa6XA
	CAQaiMHkvcvJCX1MCdDrfXQF8vPEBtIKPuzHvc8v/7EShEeqVNPX0KgcCnqg596JZ6/TIdpEi7A
	5ud/C9D0u331TchgsNfzMlwW2SQpSoXK5zDcdd0as
X-Gm-Gg: ATEYQzxuEq08LcdgoPGQLcKrQDtZWYepeQT7Qqz/hOLPpkZk9lWVjhrAfgxHF9zrCOC
	f4C6wp3tHqRdW0tfHTO5anMdHcTbZNf6hRvEKlqvtio69JOV+Kf51AF8SbiOz9EvW3hLReR6Jgh
	9Gsrc50hB0F+7krQKzll3CRLja/482uJ+hgJ66Pis0Cf2UkZcnsqZFWl2KxBuTd1kNp/bee9ey9
	bm2b33n3C3+6uLToF80XuImm7aA6gBG3Fa3hikAAlMSbBNLms6bnVhgL3D2NxOzC3yDngtfu5pX
	bwD4SZSf
X-Received: by 2002:ac2:5694:0:b0:5a1:1de6:bc66 with SMTP id
 2adb3069b0e04-5a13c93d9e3mr2016793e87.18.1772909791880; Sat, 07 Mar 2026
 10:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com> <20260307140726.70219-2-dorjoychy111@gmail.com>
In-Reply-To: <20260307140726.70219-2-dorjoychy111@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 7 Mar 2026 10:56:19 -0800
X-Gm-Features: AaiRm51B7g_JMhlZIdflpWCsx5DmxAmpibsspywnWIGz_sEa1ctulidKDYlHz5s
Message-ID: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being
> tricked into opening device nodes with special semantics while thinking
> they operate on regular files. This is a requested feature from the
> uapi-group[1].
>

I think this needs a lot more clarification as to what "regular"
means.  If it's literally

> A corresponding error code EFTYPE has been introduced. For example, if
> openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> like FreeBSD, macOS.

I think this needs more clarification as to what "regular" means,
since S_IFREG may not be sufficient.  The UAPI group page says:

Use-Case: this would be very useful to write secure programs that want
to avoid being tricked into opening device nodes with special
semantics while thinking they operate on regular files. This is
particularly relevant as many device nodes (or even FIFOs) come with
blocking I/O (or even blocking open()!) by default, which is not
expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Cons=
ider
implementation of a naive web browser which is pointed to
file://dev/zero, not expecting an endless amount of data to read.

What about procfs?  What about sysfs?  What about /proc/self/fd/17
where that fd is a memfd?  What about files backed by non-"fast" disk
I/O like something on a flaky USB stick or a network mount or FUSE?

Are we concerned about blocking open?  (open blocks as a matter of
course.)  Are we concerned about open having strange side effects?
Are we concerned about write having strange side effects?  Are we
concerned about cases where opening the file as root results in
elevated privilege beyond merely gaining the ability to write to that
specific path on an ordinary filesystem?

--Andy
