Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536B3AB269
	for <v9fs@lists.linux.dev>; Mon, 20 Apr 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695496; cv=pass; b=oapF5DnXOhjqsIHdMAR6hngyMmbWmFvZTxKQ9TJas5/GR1bqrD+svlJY9Ssr7C/bXtfwzhs8f/yij/ugY7qDCIs2GUmOMI9TupRx0nAvNWbb1Z380VLADMMuZr+tsjuH6wosC29nnJJrf/r7VJeNF/1/oK6sOzHm8IJyuYPY9XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695496; c=relaxed/simple;
	bh=kqPRzU1r8Upp5TYgefpiWZ9RVnkrVKI+N7GY819VmUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFXcJhOm/+2N0UBabcvd7/sAfTBRd/k5qwdc0OqN4Alot6YxDuUFpAxPkXFIkSc0SBGXUz4/iUtIpxEdbJCeOQGua9FILbK/34kR7DFaFVDJZFQ3qCDQwV2j0pS8LyI55GsjqW7YnZtlTXWxsgwosxojGH3o+DDDl2IrKLyPJR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGFqUsO5; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGFqUsO5"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56739adfa1aso2340587e0c.0
        for <v9fs@lists.linux.dev>; Mon, 20 Apr 2026 07:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776695494; cv=none;
        d=google.com; s=arc-20240605;
        b=aiC9eOI5s11XZXHXINdfp3tTOkKLshxQq3qSnpdZxXMbkiJrxAfJNOFCfzjwWtJw7A
         10Ck59ybxp6N5R+ClnG8q0AB7Cf0CXwA2QCXvQaIOEHB64yPfqk/ukbBDaWFUYVHa1VU
         lSWz85SH90BpHVNEqHpcePUjlpz5XJBcSLCfWyoHCYlMILtR97wEajX+TcXr3jINupSd
         w5I0pRpXEAlMXiW0edsN2y2A9BoHP9l4F2A5JkvvsI0tzRC8JTrdpkNQBMqzF1kXs1kc
         XfJNXBLo/xfB38tzLoixri0JygnvybBJjNR4R06+Ibvty0p69uEGAH6NIAKRAIRIa1gv
         42NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        fh=7mjFreQLLePXbyhIYvo8GcNwwTaKfMB66MaGZHCTBmo=;
        b=Y5xa7xFjJKoRVhmD54K8eJESKpkXu2/5Styu108AunQn7Rh193Fz+6lIRcmT4ExcF9
         heOhNTJbqipxQ9lqsNxhA/1IYGaeXvB3AVvZk3mqdDaltZ6gj1qQ5ued0qUQtpsqt7wF
         wcuesegl7hqRsZ32yW5fw42kVRq7Za7tX0BIhbSD6z4EzgUbpeBHp3nlE1FKWSpNsl6h
         6G7BZFmc9h9zVKtNUfaT9qDANo/+bvVY+qCAskTprm4TGOg3hlIcvMzKDzOP2fdPtTtC
         DkazhPs80QIjROsI5TO9dqvJjZPAnWvcUVYlmm0yfRNLD6oj1z6GLZ1jsp/YCrBv5dLM
         7DiQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776695494; x=1777300294; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=bGFqUsO579jKt+4QLU5K8qN4nb5sYUgm73Uri+tyEYPrOBpuTzBD2PK0NT2hgqK+EU
         xPWdejDY6RxIyMp4XF6loohWSyTjCXrvf8Y4sj9eH5f3tCobPFT1U6smV9+EpdHZLS17
         etm1D/xRh9FLAwLn9vxF0b6GOLJD5Z4G4V8HkqYoy/dBZriLbEpwtcE7uywo52jl5RKI
         1v3zrkjBjUqLYXzszdro/ASblVBLxcvTv9OGgUOlPYflskqKseD6udIstweo0WtNg66I
         TiyNx5dhkaMkLd9BcPnQv4mcPBUS0d5eIgmlaNsBuXfhQNLkAom16E6BsloYMTWRJTz9
         y5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776695494; x=1777300294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=ddeoGWgqWyhtzA7BVwNUXyMrbBUcLnRpaTnCF16JzILI8XnGFjMEzaXsrq47dGlwDs
         ec1n2Eb3t+8EyYc4w4IWK1xzlHyTWHjwnkZtqtFrf/gPjTMa7VatB2TID3ZrJzc7Lz69
         WIUdX6j7II1IMbKMYyRDGk6zrywxooK34uhir847tbeL8SfwTDuDvzlWd+YSv0D3iefa
         oTei37Xg5gUoU7/QYTPMhEeyltOBsXmyM6nT53zjpZJXKbBZCsNyee0KAkyLprj7RNT3
         nG5j2FfMPMj/lmMHGHFx7tjvrGL9lRQ98grq8Hk2SMULFHfzTaDB0EuyLGDCwJG0NsB7
         W94w==
X-Forwarded-Encrypted: i=1; AFNElJ9fMz3mY42Ke5epiR1j1FqyEPAyLaAhgw44Y4wQ2GgHoIkWFOqxkJSSGX+e/WhkSV8/p/Yc@lists.linux.dev
X-Gm-Message-State: AOJu0YxIsIrQwGNAaG+IvzvCT++S/bhoy7836OPtDpf7YcutBBNy8W1q
	aCiMTh0pzYAe81uR7mJNiBMC7QBTu9hrRJETO15e2Ke8uRD9dQoH6PmZLw45O7flQ3F9zyE59d0
	O3AgRBNIl5LDiwF/VN4qy/bsWS5eCRYI=
X-Gm-Gg: AeBDies67vzTn22053Y7CaG8PoNVFqTjpxu+Y6Jff4wspXhSzuGFho47KtbJ4w/DO0U
	aCGfGu/RtkGnK9HoWJ5X6oNYyiIy9YfuQAWZ/r5ArBFo1OXLE5cOLVhlqWGR/xAy3wQQvigKes7
	qlwqVjtqhIWEtrXwKG+7BHmc0R2VEMIPBHr/jI/+suaI0kkgAvamsV7WrmDJicKQIHPqr39cBQm
	p5RQ76p6oLM5FC6ZXhS1TEzSCvJqT3wTTijyqMxD6H143GLH2EEtqdLf1g2igDHFq3UWIkhi1/J
	DpFnlHuzwBJOa6PXOagV/PCVgJviKfw9W8bjsW/eagMoyUXAFXde
X-Received: by 2002:a05:6122:4d12:b0:56f:9512:145 with SMTP id
 71dfb90a1353d-56fa5a39aa7mr6593038e0c.13.1776695494119; Mon, 20 Apr 2026
 07:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
 <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
In-Reply-To: <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 20 Apr 2026 20:31:23 +0600
X-Gm-Features: AQROBzDP8Lx2bqkiL-O80tZkD0rFOUG8sjvNKKIkhcPgFqdc6FHkIJDo6D1Xn7k
Message-ID: <CAFfO_h5FH36eqYuuoYy2eVRXGytmQHLfz5p7fLi+3wHmQN9MnA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
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

On Mon, Apr 20, 2026 at 7:20=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 09:22:03PM +0600, Dorjoy Chowdhury wrote:
> > On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > > I came upon this "Ability to only open regular files" uapi feature =
suggestion
> > > > from https://uapi-group.org/kernel-features/#ability-to-only-open-r=
egular-files
> > > > and thought it would be something I could do as a first patch and g=
et to
> > > > know the kernel code a bit better.
> > > >
> > > > The following filesystems have been tested by building and booting =
the kernel
> > > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_R=
EGULAR that
> > > > regular files can be successfully opened and non-regular files (dir=
ectory, fifo etc)
> > > > return -EFTYPE.
> > > > - btrfs
> > > > - NFS (loopback)
> > > > - SMB (loopback)
> > > >
> > > > [...]
> > >
> > > - I've added an explanation why OPENAT2_REGULAR is only needed for so=
me
> > >   ->atomic_open() implementers but not others. What I don't like is t=
hat
> > >   we need all that custom handling in there but it's managable.
> > >
> > > - I dropped the topmost style conversions. They really don't belong
> > >   there and if we switch to something better we should use (1 << <nr>=
).
> > >
> > > - I split the EFTYPE errno introduction into a separate patch.
> > >
> > > ---
> >
> > Thanks for fixing up and picking this one up!
> >
> > >
> > > Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> > > Patches in the vfs-7.2.openat.regular branch should appear in linux-n=
ext soon.
> > >
> >
> > I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
> > git.kernel.org.  Maybe this hasn't been pushed yet?
>
> Nothing will get pushed prior to -rc1 which is due this Sunday.

Understood. Thanks!

Regards,
Dorjoy
