Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E3628
	for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253627; cv=none; b=eOUKotXa6kZi1FSX8VonLVsyjTZRwfOZoHeojIcHNabv64QQ6EhEB+DYMA0VU7dcVu4j2sCeLg64XtfpXbspxAx8ejhWAusfq+kbBtkuGjIzNOyDLi+iYihO+dNp5Pbdgu0uZ3hARMc9k/UN3ufr+aFJ3U6JyYWA1q8bk0QRAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253627; c=relaxed/simple;
	bh=cWgIly/2P9ZJoZ6MP9sA7WZjxFM6bhp0XJhWv4QbnzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDF99LhG9KrE2Z5BGTcHb1GrCXCBm9VdBDBpzo12Rkd0CXwLqnN/T/+WOusF1+R8pVfA24EaWMR38AaAhxTwj5nsRcEvG4/SpjshS+siaZA2mrRafzvS2ngG5PeYcI/ERn8PtfDg68bTNcV44MoN2ehdZ1nDWKp8v9tCfJQrUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff9gfRih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff9gfRih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50595C4AF0B
	for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721253627;
	bh=cWgIly/2P9ZJoZ6MP9sA7WZjxFM6bhp0XJhWv4QbnzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ff9gfRihuS6EyjqdJzlnJX4DuLvg9YeoZ9LCZ7GZIKlKmbu51VStBjZtf0F10qqge
	 MX8Dwl44/qlTMmTLDrtap5jFhrjQCZYtuP0VCsrtjiHcW/zECPK3aBxycxWVb3KIuW
	 BNNjD4XWZr7BKpj4j8b8OjPQ0TIWRpsZ1e13Z8gkF8qKQ21eWCnNuic/4Ftu7J2aIm
	 c1SnTnhCoI7L9TvdY56lbhhvqSHMv7Klk3h/IGaFf+ycjGn8jbE8Zq/RKgseM+iSnQ
	 Mx25XYCgjQwu+DhhtFx7HtC7krDEeMfoBu2MQ4H9VYT1P5M2cTRkos83tWgOGKiqLw
	 7vZEY1Mq71CbA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65cd720cee2so1180817b3.1
        for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 15:00:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9PnQ+PhRvDk1fZaxtEb78Riuu9fs+3s7yK902NPEWD5N6/SxGB2qPdx2LBkGiYDPBDkby+o88dPhZWDEsNWbgqeMNSw==
X-Gm-Message-State: AOJu0Yyj8LTh9BKodOwDmJeHNFgi4/YEzYZupuM9yCx1AcLEs1Apqt1e
	FsBK+SyL7MIVazPg8bHBq40QED6ZIxxFKWjMyZnpJNdiYtKZzGsrFTWIF1PCYI74zE6exWWr5Qi
	W604X2J8269JoFr+rLSFwVrJ7h+k=
X-Google-Smtp-Source: AGHT+IHpM6MoCAWJ7ceR4EIZRYz4U6IyLmuLmqXEtz1oJGvVuDhKV3AIeu3duOIuLF33tkHM8D/63uLzeqUwGezqM6M=
X-Received: by 2002:a05:6902:2305:b0:e03:3d38:fb26 with SMTP id
 3f1490d57ef6-e05feb1188amr976119276.28.1721253626447; Wed, 17 Jul 2024
 15:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240717102458.649b60be@kernel.org> <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
 <20240717144221.0c5afd01@kernel.org>
In-Reply-To: <20240717144221.0c5afd01@kernel.org>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Wed, 17 Jul 2024 17:00:14 -0500
X-Gmail-Original-Message-ID: <CAFkjPTnTDWrfCSVzvtSszjoerOeWBn8Z6DC4qFMH70Aq7Pqr1Q@mail.gmail.com>
Message-ID: <CAFkjPTnTDWrfCSVzvtSszjoerOeWBn8Z6DC4qFMH70Aq7Pqr1Q@mail.gmail.com>
Subject: Re: hangs after merge window changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks - I don't see anything suspicious in the mount options.  I'll
try and get some time this week to stare at the inode management code
and see if I can work out where we may have a corner case or race
condition messing with us.  I agree with Dominique that turning on
some levels of caching that might keep inodes around for longer
probably will work around the issue for now, but I guess we really
need a stress test of that path to see if can get the problem
reproduced more reliably.

Before turning on a caching mode, you could enable P9_DEBUG and turn
on error messages from 9p to see if something off is happening that is
hidden behind debug ifdefs (debug=3D1 in mount flags should be
sufficient).

On Wed, Jul 17, 2024 at 4:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 17 Jul 2024 13:01:26 -0500 Eric Van Hensbergen wrote:
> > I held way back on adding anything new over the past cycle, so this
> > sounds likely some external change maybe perturbing an older issue.
>
> Ah :(
>
> > What guest side mount options, qemu options and qemu version are you
> > using?
>
> I use virtme-ng, according to ps qemu gets called with:
>
> /usr/local/bin/qemu-system-x86_64 -name virtme-ng -m 1G -fsdev local,id=
=3Dvirtfs5,path=3D/,security_model=3Dnone,readonly=3Don,multidevs=3Dremap -=
device virtio-9p-pci,fsdev=3Dvirtfs5,mount_tag=3D/dev/root -machine accel=
=3Dkvm:tcg -device i6300esb,id=3Dwatchdog0 -cpu host -parallel none -net no=
ne -echr 1 -chardev file,path=3D/proc/self/fd/2,id=3Ddmesg -device virtio-s=
erial-pci -device virtconsole,chardev=3Ddmesg -chardev stdio,id=3Dconsole,s=
ignal=3Doff,mux=3Don
>
> -serial chardev:console -mon chardev=3Dconsole -vga none -display none -s=
mp 4 -kernel ./arch/x86/boot/bzImage -append virtme_hostname=3Dvirtme-ng nr=
_open=3D1073741816 virtme_link_mods=3D/home/virtme/testing-1/.virtme_mods/l=
ib/modules/0.0.0 virtme_rw_overlay0=3D/etc virtme_rw_overlay1=3D/lib virtme=
_rw_overlay2=3D/home virtme_rw_overlay3=3D/opt virtme_rw_overlay4=3D/srv vi=
rtme_rw_overlay5=3D/usr virtme_rw_overlay6=3D/var virtme_rw_overlay7=3D/tmp=
 console=3Dhvc0 earlyprintk=3Dserial,ttyS0,115200 virtme_console=3DttyS0 ps=
mouse.proto=3Dexps virtme_chdir=3Dhome/virtme/testing-1 rootfstype=3D9p roo=
tflags=3Dversion=3D9p2000.L,trans=3Dvirtio,access=3Dany raid=3Dnoautodetect=
 ro init=3D/home/virtme/virtme-ng/virtme/guest/virtme-init
>
> QEMU version is 8.2.1 (built from source)
>
> > Dominique, you aware of anything coming in that might have messed with
> > this?  Maybe the new common code refactoring underpinning
> > readahead/etc.?
>
