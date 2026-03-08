Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4424A044
	for <v9fs@lists.linux.dev>; Sun,  8 Mar 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772951479; cv=pass; b=MP6zq3d+MLGG7fJdO7g8nfO2+XQpkyqWK5BXCoFb13rC/+63s7kZYZr1r7Oegu5qmX05O9bcVcegY2BmlE9o9UvmYLyUf60aG6CNO67nSZZosGpfqzxsiNrExp/3IuerZRVEuhsqQr1Ac9buhN36PXQCuf5y6BmAiheO87uWvVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772951479; c=relaxed/simple;
	bh=bqMEOQ0Ckcrgyric5QOWebyRcZKyiXhkKZw3Ukws05o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BI5YrYedZbb9qHOHWrFdXixqlYXV8vb//1Xnbe8J2jL0CSHTNQbr6nce+dLJrx974acEWqH1Ayti0l9MWESnoAQ64VTgygw7TPmqdnstxKmgWqTnOF8uoRwuYFXrAcZJXE+JO5EL1xwZfIrgLXVMmKYQVNqKZWFsa0XuTL6mmuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY6x3S8p; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY6x3S8p"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56af30dde0cso1247562e0c.2
        for <v9fs@lists.linux.dev>; Sat, 07 Mar 2026 22:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772951477; cv=none;
        d=google.com; s=arc-20240605;
        b=F+UrV1+w4naldGQKEE94RS4lJN7sBkU8Wa5qFSYpWxMOuzITHZbN83x8iciPv1G16n
         c49wnm44URg1VZeX92ldlQhL8BNZipuQSvB8bkAJFUfD9xCjS1mSV/2Hc40ere1jI1pQ
         F/wA/IZSQITMX956mhyMQXnM8Z1bI+I/98X2oCEtwn1+6iqNuIWdsagbX8Ys/H6tBRJY
         wwMEsKnag48hfTETCkjW3ANETichHh1qy5OF0kLva1aPk8wjH8j9A/qPTVQkl+DCX4r6
         tHCRjKiyhBOkZZdnBJWMRGneTlM/R9YhwAVZzw/v79lutyMC8otsj4/RzRN5FHmp5xsZ
         d9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        fh=+IBgPT5AuzZ7GSM7j2PmPcmotcpG8/lsNxadGbXcZMg=;
        b=YhdB9ESNRZxztnm6EY/6TmHaGA7vOO4eMgbHjhRE/+7uLq7fn+Dtrxv6LkIDBYiL6R
         LIytMT5arf/uBU7MwqokyHmAM7Qqgh70CPWeckNdBpF0vS9InCLYMiFg55qkWOlK8P53
         loCQ64jhCiS3lsMNPV59pcoDgaiLXfTe3MjggyDiP0cHG6Llphs0hhUZkqUPG/3NBcT2
         otlnKo8js9Jx8SwicyFaBdhrr114XRJhvFUX7KdkT7vIucgfh1vv79k1Sxo4mdUm2of/
         z6A2j7eoTRYXPgqwiUl8UmoMFEVlEoYy5EVOUpuU1fQd4Qb92+lNokOomiNULkZ24/vV
         TnrQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772951477; x=1773556277; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=LY6x3S8pCIfbk5YNWPPE3wII3LPou2MSvcMlEbe005o1/ttqWZQcuXoaX0LDZZJpxo
         D68J4bR3JS7h1PMgZFd6gBapEk3KGkWK++LuCGNUarCm8vQK+kaYBQT05998zzazucjq
         Id+dd09KyfKEzESUrVmxBzFm9nfgH42YAQbXOEChu7hwhXb/XdG33ChjPazVZCdd1mvN
         dIUD5RHXqawGVDcIcjVwBqy3UNTxK+Ec9b0zFJMv03nD1OyWX311V84pon7qUTNcAwx7
         0Ec0qKfZ7db1pFcaaju5mEA+oHMJPCi5Sq+MfBCdZldeOxQHEf6/rWvr7j6eJWdARUrw
         EYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772951477; x=1773556277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=oNaqzoiQpf9HuQ2q08lvGnAoX6uTFG8aOBEtpdhwRcipOiepHa5JV6HClADHRBP7zD
         BhbqiSUBNuoKhVxsW5Ve6YDfMIsdiV1ebZ/b96xAuSymh2kY+qQUjuSJocFLnIPTVyU3
         6VHnJ8KPmtLMc3ep2zaAn0VDKjT47LM2wxCSHHRgKrAxTlX3r+ag9fc+UwYmeDg/Te1f
         aAwRa7OF/d5xqpGePBuaU8mvAcKQlFBvSHaZ4VLKN+JrjdnBv0ij/CaH4bS0BEadYSYh
         4d54t3nPW/Uey7u/qciifoFekpmGMRkbtYn7RxO5CFhSlBkhFVKdBI+6PHdqI9IPT4Cb
         1zCg==
X-Forwarded-Encrypted: i=1; AJvYcCVJf33YrxvRjmrGLF6lr4NpR+0OjzlnGj5EGkHH49zAZcbVBSwxKwQ8zv7JLXDHewz6cfgS@lists.linux.dev
X-Gm-Message-State: AOJu0YwSJlNDtQzaG1OBT5EuI8LAkuYzgMYhnky1yP5aJTco1W5cqDMF
	bOcjyZav+JbHjEl9+vqHXj2rLuv9C8f1vQKq0KyD3KiVvWLGcGvg98VDEhZLWbX4PNON5PRmlsy
	3P6lh85DuKqwES7XeRHfBayS8meiWL04=
X-Gm-Gg: ATEYQzz7aIdOzfchC4Y2nmZPQ+UbbMufsi5Huv2hxwXVyjhwGvN0fwn9TL8MXgSahlA
	krfaGst1/biSjSgh2aGP024Z4RjiVYqanGM/HpxiYO595Dz6/Jiytofso+QIz7KBTqhiGIVNcnI
	GJSNQ0sMWONH7gRtm8BjJtZ0b+HCxdT+deHmW99KP4SSPbg9eYesNR7dc0hd8ruQYDFZY71j/3Z
	9M/5oFf1WN5Kgh/Qhh467QZqUsk66X34tCYnOFPHDBHx7kWRNYipGFIUYrpKYL+fAuUtMQA1B7F
	rS17FMaiaxqcDT1cOVcsP1+KDFCGa1c+s3Wj1HIXtA==
X-Received: by 2002:a05:6102:41a6:b0:600:11e1:2a4b with SMTP id
 ada2fe7eead31-60011e12bf3mr732622137.34.1772951477120; Sat, 07 Mar 2026
 22:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
In-Reply-To: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 8 Mar 2026 12:31:06 +0600
X-Gm-Features: AaiRm51WCqo6sYLOpIV6hZ1XNIYME3jM_VRhuXhqPcz8hjUnJuRMBp96SANcO1M
Message-ID: <CAFfO_h4g-QtE1gsp3nw7+BUYnRj29au=pYs1goEnppbdU-8DbA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Andy Lutomirski <luto@amacapital.net>, brauner@kernel.org
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

On Sun, Mar 8, 2026 at 12:56=E2=80=AFAM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gma=
il.com> wrote:
> >
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
>
> I think this needs a lot more clarification as to what "regular"
> means.  If it's literally
>
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
>
> I think this needs more clarification as to what "regular" means,
> since S_IFREG may not be sufficient.  The UAPI group page says:
>
> Use-Case: this would be very useful to write secure programs that want
> to avoid being tricked into opening device nodes with special
> semantics while thinking they operate on regular files. This is
> particularly relevant as many device nodes (or even FIFOs) come with
> blocking I/O (or even blocking open()!) by default, which is not
> expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Co=
nsider
> implementation of a naive web browser which is pointed to
> file://dev/zero, not expecting an endless amount of data to read.
>
> What about procfs?  What about sysfs?  What about /proc/self/fd/17
> where that fd is a memfd?  What about files backed by non-"fast" disk
> I/O like something on a flaky USB stick or a network mount or FUSE?
>
> Are we concerned about blocking open?  (open blocks as a matter of
> course.)  Are we concerned about open having strange side effects?
> Are we concerned about write having strange side effects?  Are we
> concerned about cases where opening the file as root results in
> elevated privilege beyond merely gaining the ability to write to that
> specific path on an ordinary filesystem?
>

Good questions. I had assumed regular file means S_IFREG when
implementing this as mentioned in the UAPI page:
"O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
which opens a file only if it is of type S_IFREG"
I think Christian Brauner (cc-d) can better answer your above questions.

Regards,
Dorjoy
