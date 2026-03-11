Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43723C4F2
	for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245421; cv=pass; b=BkzDOGk4hTTPuYj9BWSDhdfAKOiQplQAY924SXt4gLm/yQGXSdP21kFAQkRfDl2+FPwgln4fYRPexu7ZSueuM4Jn44X05lf3/StWDT6aNdBsQYI5RyLy4FSSUnWfuOuLr/vXtzOx/jU39hFPm1W9Mmyis7wFRkGRuwhTVQG4Y7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245421; c=relaxed/simple;
	bh=RINC3OxukObTWwNgLj8cUCMQfmLKMyUKoc5ifoxu7lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVYMLbO3gWWGwppInvz/Nllv14dpX5jdr77YGk1VtT7cy5wphKwvs93hafdYo9Q/NtbEpJNjgVHu5Cqapg23nZiEIPv37nVDakR4LTJEzEUYelYhTLEq2nfJlwGzEgfB/TS+ZBi3qOTeaPvfGPUxzaQjA2qRFwGp2BBcYI48aTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=YnX21jAf; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="YnX21jAf"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dcdf60427so89319e87.3
        for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 09:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245418; cv=none;
        d=google.com; s=arc-20240605;
        b=Ut+YBT+lWcq6wgjzluGC7+Dtk64iVBIYefYNPztnpn7eCQsaO38/tzEqUrngPHPVkD
         F1wjWHKGWD+QOEmdOvxnmMz/P7aWZ1IIseZLyA+7a3KAbXdav0ozQ/73Az1zGp0YmTA4
         BKMR99UdPytpdkIu3Jiys1gMFsg4yNz3ZFXyad7lVVSzrUyndnS2YDQKuEWb9EsNFql/
         RaJYNfmp+fBH/YbifhqMVnWEQL3LJA6xUtEH3AWcrD8upxr/rgShGP3JaNDWhKK1skT5
         ISKexRHcsnJgzYL9ZqHKqzGhyX9prauO0zZvy4rsr6Iyoif/JzGt9NM5K5rekKinQNy+
         K9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        fh=6TKR8NjPQTDtF9eV2U97mgwv+r6Lu0z6MG01lPviGpQ=;
        b=UfRypULWS98iFtAMOWbFx0cgOk6sBnJrfocMzEd0bT2HfK/uSfmsQge2OBbcB4wAqP
         1VK5KmpcSsLXlvBFTGGqVS9korTTEHgTcHXfOEA7jtc2bJrRzlG6Q71qvfi2wzQHdqU4
         4y8BpYRUUq2SvusNcttXJ49OWbp6fMlkTs7oBbsULshvGWTDau0BFwpFkSEyuZGMzHeB
         Nsny09tzsM17mP3pSU5TYqXCwGnjjjMegHQhrlMPQ36H7JlkxRTp5VuzCEwdF92hhPOx
         Gn1dOcagSsQBxGPYa6/HuKElA4ydGPmQwdERWiw+k65MheTyFmK6ENPlT/DjBn04GgXF
         0OPQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1773245418; x=1773850218; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        b=YnX21jAf7tC8gS/GaYV9U0ybpAsavOfDY1mG39u+fTa664XbGSGmYKpUDm1+htank/
         jTpDKuP8FhOYFQZ1J65IbdlVVRB/ABkk4ndZwA1MYYaRb4zrg0tX26l8S3O0KAXXC7hD
         NEFlmOqSnou3pbUJNM2vAIOOZHEK1ph9d1v2P3G9aDqnkAafFBtFD7zubXAW3OgrOgCi
         XBDkvj1r1s0tjCcdOUDlGEGeXXvfpza/ibo/DVTmWs8tKKaSK8jAWDwLM+31Eh3AyL76
         5JW6iVY9OVWiiU564ntH7FuCU5nkVeZMPCfwuGfKtgXN46txZzZbile3Fd1jIXWkDlti
         AGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245418; x=1773850218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        b=r6i2NW6bPcJ5EXB1yJguFZUTvboDmwnMgMsQLYAu11PJ1+Yd2MPcRaY3Q1y6jQBeG1
         ITgluVr/a5KZgIHiYy8QFMkffjrAJrutZGF4qSmt2ZeD+kCCMjYMWBFCtArQqpUx7ti6
         Y8ZG2HbkXn0YbEasEmhR/cZYMG3DLpyK6T/xA7DqXcySUsXbM/kWHAWPLcNHdNo71MYw
         9N2Y/9/mAVHJLENwbrdxT0OFdQ55E7v33C7jLRCDsNCU/5OFCf89ZYRbTfhYCkj4x24X
         3P5+QodqTDzZHNSMM/OyGqZNK5WI3AvfzZ6LI1HcoJEaixf/dxGmI/rL+5sO4DFIlWz/
         WPPw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Ios0BLdFamjwmfd8/fPHE2K3DeR8HimStoV39FjTjL2RCETjgUiZvLuorD6EkiROpMMm@lists.linux.dev
X-Gm-Message-State: AOJu0Ywl/kuO+TE1A07SAjUMAOIxei9T80h+ZBDG1SgfEb+nhL/MFZK8
	+QPU9IgjtAGhZGOHG0Qlq8nD2MmhdGEdEKgpkJv5+nd4wxIPf093C0ioivQFiwTguC0Y1daLnlq
	7nYXTLZPwspeRSddIxvkL9z8pSELN8VhT3F+z8aGp
X-Gm-Gg: ATEYQzyebGn6b4I75Jvf3uwUJuaVWe3Fdnmw6C+Yk5F2wmmlSTpRMl67duAaAq3UKqv
	UBlsXB47p5t/aUhF+ZnOViNyMtNnfp2MXmW9tvvBSz8l+HjZp2zU1j8PdamgooX6O7n/voSKsXd
	MwSwmbU4u/F9YGrqT0pCrzZbb28ksXNt1qNQXFbKomMb6+/SCG2uxp/Qn7RHa+2LlIjADjs00w4
	O/nZpKPlJvlFfKUsFyeMa7R+rxtLgAjmguvsT/H5j3jDpReFFak7bhZn+OubhR5akpDOCZ4bgXg
	IgZq
X-Received: by 2002:a05:6512:712:b0:5a1:4835:306f with SMTP id
 2adb3069b0e04-5a156baf0a8mr762062e87.19.1773245418128; Wed, 11 Mar 2026
 09:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
 <20260309-umsturz-herfallen-067eb2df7ec2@brauner> <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
In-Reply-To: <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 11 Mar 2026 09:10:05 -0700
X-Gm-Features: AaiRm51EXHFpn1BAVpxsTY5E2VQC7PD0Lwp6wdRjddj9MKMq4N9OfHTiuPJrR94
Message-ID: <CALCETrVMF3VBr0cuEYOg-M_u+hX77Jfdujv3ZMtLGCzHgOcsGA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
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

On Tue, Mar 10, 2026 at 9:49=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-03-09, Christian Brauner <brauner@kernel.org> wrote:
> > > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > > I think this needs more clarification as to what "regular" means,
> > > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > > >
> > > > > Use-Case: this would be very useful to write secure programs that=
 want
> > > > > to avoid being tricked into opening device nodes with special
> > > > > semantics while thinking they operate on regular files. This is
> > > > > particularly relevant as many device nodes (or even FIFOs) come w=
ith
> > > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk=
 I/O. Consider
> > > > > implementation of a naive web browser which is pointed to
> > > > > file://dev/zero, not expecting an endless amount of data to read.
> > > > >
> > > > > What about procfs?  What about sysfs?  What about /proc/self/fd/1=
7
> > > > > where that fd is a memfd?  What about files backed by non-"fast" =
disk
> > > > > I/O like something on a flaky USB stick or a network mount or FUS=
E?
> > > > >
> > > > > Are we concerned about blocking open?  (open blocks as a matter o=
f
> > > > > course.)  Are we concerned about open having strange side effects=
?
> > > > > Are we concerned about write having strange side effects?  Are we
> > > > > concerned about cases where opening the file as root results in
> > > > > elevated privilege beyond merely gaining the ability to write to =
that
> > > > > specific path on an ordinary filesystem?
> >
> > I think this is opening up a barrage of question that I'm not sure are
> > all that useful. The ability to only open regular file isn't intended t=
o
> > defend against hung FUSE or NFS servers or other random Linux
> > special-sauce murder-suicide file descriptor traps. For a lot of those
> > we have O_PATH which can easily function with the new extension. A lot
> > of the other special-sauce files (most anonymous inode fds) cannot even
> > be reopened via e.g., /proc.
>
> Indeed, I see OPENAT2_REGULAR as a way of optimising the tedious checks
> that userspace does using O_PATH+/proc/self/fd/$n re-opening when
> dealing with regular files.

Can you give a brief decription or a link to what these checks are and
what problem they solve?

--Andy
