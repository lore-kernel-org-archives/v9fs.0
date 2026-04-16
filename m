Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949F3E276D
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352939; cv=pass; b=HvfconrkfELt060I5p0EWm34v5vp2S+XWw7sQtsDdO4fgMPSkeqFEIv72g4K3ALqkVEkO8sPSV3ymnyExjp4DXeGfdZDFNTRC/vE/R4p1RvNnz9GvKoC4S9I6iBszM6oEPeD4wbZ+lRviC6IC9l/dQyc1f+wZ08OKlcVPG+cyO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352939; c=relaxed/simple;
	bh=d8h0wpCxAz5qr8QgJAWyo5NPmRw20h5MEF24J15IyVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nppMNHPk41dyNGTamniaRxswWpT3KVxfcSmXFTSdUwotd7nlusiDB10NsgXwwVbsMvCD5lDVN9QaynCoZATJfPlIKxzBAPfHuSA6HI6mi0icejiW0y5YrSycTayXVdMTecllR6Heuba+ZPtmkSh4QDrEpocbtOohnaApVRVIQ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4FWCXJd; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4FWCXJd"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-956995b5bb6so1395424241.3
        for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 08:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776352935; cv=none;
        d=google.com; s=arc-20240605;
        b=A57K63+6IhkpTIM9hrcrJbxStRuAwp27zPHeKBokKUzMlZ7KEwEjvxKR5M0CzN9oEC
         G6dBCpFXiTEkR9oQrz6fi5EELhquP9EYoAGBfV3UjajXaR5uKAFd/XccvzOVBAXHQaMW
         u3ALmCQ51/EU0GBqXODGWX2AtJ4TRvXnZNSc22g7uZudvVCzkS0qzVWmj3aIVnRGLABf
         9hgTMFmDstcmCDhxtKqiRQQtNoKsDCBP6UXgeINsJTlM5yUcsq04MZW9mx2xP9KVyscV
         AAUMsUDsKJH4vE/A+S0wGaqQbJFP3lVp8PF2DxIMhHOPiPuE6bwBCKxGBrn5b/ICsbU5
         W6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        fh=99gfEUc+vJRUjD4THYgbSKOfwEpzA1OjuVCG95djJg0=;
        b=HZAieWk0slPBsFxVkv/Enroph7H3KsM5L6gDE4G1m4BnNEg74g5b4coFCpjo5JUtTa
         GA2sCJt6rPCELErdJ0biywZdz7XXyXp7+zSmchgab8C/2Nsf+4aTDNRXk4FdSzkUg0tc
         RtOH0G1yH4J1xYgb4BOFBSWhSpTb/IdhQ0GEoycsqORqgsIfrefXCCScWVr8nx2cTbCO
         YVE8lOQYcIJKSjxiF6Yga29OKoqNzRZkKyUNwu6uuZb2t3OeIuNHiOZ2vbXfYpKHG1/q
         Ot/GZAh+agZCy++jKhmm60u9ehA+DIsWoOdVP6aQ5ItKbIpQlMgcRNnwTke5Hmuc7ijN
         nqCA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776352935; x=1776957735; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=k4FWCXJdETRJ11r9AtP2fThBUV87gATa3LOWWW4CX5ZByobTreHZm+pd4sq3hkQ+nU
         9Lnby5CSy2aCJpOf9wZ2Xcf8rWCv+JHR5JFxlyRSoJ5vpR8s+7Pezm1B3VGWJMK/HGjf
         H4gzQIT9FdGfyBccgs5WGdQZTAidaOJfUAD5FdGc8PRaP49f/O8ZFG9dTA054BOO5zIE
         nK/jsXenlJjJV5rUe6f/V3bntWCVzp6nD07U5DXiaZF53s8GeBLI5s7UJv65ZwzbuGwD
         nRFpNvUoskyn/H7XcsFiyYvsssZ2rZsKSXhiXc8bz+Von2JgKEIkfvp7J3ScevkKM5XM
         RKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776352935; x=1776957735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=lgx4Umd72kJ+PuiSfXLYABDQNet/aZ9xImX7MVN3Urd/iW2O0aDSoda9zjzWGC4CGa
         26/J4aBUKzKCzJB02hp4JgV8UTT6HalC8CbeixV0bt2gk/cZDkANAhuHlkVnbngxdpK/
         0+sRXqnY8EM+PwbpoF6TGgNZjiuggVoZ2OabWxZTSxU44r1CV6Zu9x+VGvrl1kwOauEx
         ynfsuuqwVs1jXolhA7vhv6LTzInkc80MTrZt58UuR4N8r7yOyDouwpt139zsOUrqdDaQ
         HBCSr0DWIW+Y3x7xvmD3Ru27BshIBvqSxXQyShJrk4pV7B19A8ko4zATr4xgic/EhehV
         dQXA==
X-Forwarded-Encrypted: i=1; AFNElJ+LEIasjG1v4gKKogLNmIesDXFM5LAUYneCTRlSf0iimp8ds2KNGnkM6tfDMdnUbULE3hQe@lists.linux.dev
X-Gm-Message-State: AOJu0YySeaC+D71YRF2zbttJpFhQi9sfN2YnlF69yBERk7HnW3Sfq4Iv
	1E1xjXU8we5/SXMYR8VvFbIV83K3TX+fEmy4CD/Nfl3LZpr2rj5/uoUJMLykgMEgyM1jlNyV6BK
	UQg+0BBs+pF4L5BMoyxEso3EIJEleVlE=
X-Gm-Gg: AeBDiev2owESeE6pOFUMg1D2Zgg8Jlo8wdFzGcBaIKWgqkgRqljd4PBXw1Lg6+u2oOi
	/xzelkUs3qGoyyvVLhTZxHrhvOLlgRRdQoTdiGfkAif0FxSf5f7eXlECdE19I2fhgHVAK8fMp1i
	hAviiQQ/sN6CY9hCJxc2mEWhUpzLwQroBHcf3qUP+tm+qJTBwprIB+x1GCvF7DnpYVSiGCy11V+
	IMdQkCD7bw/t2+1QP+MBekGv9PfIn0IZDqpZE7UDx0h4dhdNx1eU1lyRjtDdF+zuJUKrqPIm7hw
	6PZL6eoyEotvORwJZKcvaHkdkNx6GQVNJI86mguBsQ==
X-Received: by 2002:a05:6102:4194:b0:610:48e8:8c4a with SMTP id
 ada2fe7eead31-61048e896d0mr7561251137.24.1776352934841; Thu, 16 Apr 2026
 08:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com> <20260416-abgraben-seeweg-a44ce660957f@brauner>
In-Reply-To: <20260416-abgraben-seeweg-a44ce660957f@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 21:22:03 +0600
X-Gm-Features: AQROBzDwlhonUu0OdB2GZDkt71Qp2GPutRABZHn8dYTEqH0ntcAPsZO_it5641c
Message-ID: <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
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

On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > I came upon this "Ability to only open regular files" uapi feature sugg=
estion
> > from https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> > and thought it would be something I could do as a first patch and get t=
o
> > know the kernel code a bit better.
> >
> > The following filesystems have been tested by building and booting the =
kernel
> > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGUL=
AR that
> > regular files can be successfully opened and non-regular files (directo=
ry, fifo etc)
> > return -EFTYPE.
> > - btrfs
> > - NFS (loopback)
> > - SMB (loopback)
> >
> > [...]
>
> - I've added an explanation why OPENAT2_REGULAR is only needed for some
>   ->atomic_open() implementers but not others. What I don't like is that
>   we need all that custom handling in there but it's managable.
>
> - I dropped the topmost style conversions. They really don't belong
>   there and if we switch to something better we should use (1 << <nr>).
>
> - I split the EFTYPE errno introduction into a separate patch.
>
> ---

Thanks for fixing up and picking this one up!

>
> Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.openat.regular branch should appear in linux-next =
soon.
>

I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
git.kernel.org.  Maybe this hasn't been pushed yet?

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: master
>

I guess you wanted to mean vfs-7.2.openat.regular here?

Regards,
Dorjoy
