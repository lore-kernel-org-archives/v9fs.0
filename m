Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2F29422
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274892; cv=none; b=FM7zwEV/az1GioYJO007frs2JzgJDg1+nBMjsja0SnZZ457B4mcW7P1Yc5WD2XLzJ/x7Nj/sH32/d/OLE7rCa8eU/YvX+CzUp8IiXvrmfjK7wEHASj7wInvaWiK1WgZxEY3mdc2KTTxweYGS4/jlgfkW7j64XjQ5Lq+gnVdNxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274892; c=relaxed/simple;
	bh=WO9lBUfLq74Z/VrXdEXmPngTMZBWuwTnkFJhFK0ybQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnxnPQvjNc18jpua4WNvvvR/BNGiqxkBFmGsGiOmnK+XwTya0rnPmlo931t0QSYXodyhH2l3U1FeEndgdIxVNDxWxcFix5/VSfhFrRum2WdX9T3aWX4fbJDmKb3GIeiJP9K84H1fXP6Ph/xZaoDjfF1ytDPqImB481jm4MlCLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIWFG/ur; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIWFG/ur"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e85cb9b4so37229366b.0
        for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 20:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721274888; x=1721879688; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+TDyi9dPysEnaDES3GZ4s8X3WByQSzfd+FrTU5Z+Uc=;
        b=JIWFG/urGAKH0pnWfDWVyOMjd1gjqCkNdAqYP/Esu9X8JNH40JVG3BxdryxSYTGrEA
         GO/Y6k3G8+pR1qUyOctnJ4tRkYrybAOzh/aD1pmn1+oJ/cbqJ39MdJAa2FgUCOrt50Bv
         hLX8zSsSJ/3g/3cI46mSd0f9tC7f/vcOPe/GbO1ES2iOTEaPCDLrnElZOZGqbEpWW8Fd
         ZQ2vRsIMIn7p8M3HwI7mCaRhl0VfsvTD22SIFt4NtT5tX8gFPsKtQiJXp156YkGJDuNz
         Mu4enSxqw3ITgdQzxhpk+1+jZnqG5edygQ9mk906oK4x4+IuWTLYxsA1VQfwg2VufmhL
         f4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721274888; x=1721879688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+TDyi9dPysEnaDES3GZ4s8X3WByQSzfd+FrTU5Z+Uc=;
        b=PXFacHcpoBzqzpvvca6vhkTz/nMBdY6LkcV/WtK3JToEYZF0b0z14swJbeAMOuozgP
         eJiCb4nunvnw3eTrIbXJ0rik2s2dFfyMwk/OyQhjSh6xZ5yD++xVitaQjdZ+fpXxW5xE
         LZM2kYL5bzXsGLRTk6Ng+A2Bz/wjCv3ZWdVIdyeraFOJQU/B5AmucwFNnB1yrtrl7DzI
         EvVyGqUnCb86kC2h7PrTgKc6Ir/BOB/CykPEw51EkFEjACNBgvz/FZBCBWJB4xcAXB2C
         SnGjfnXisd0UEJwt/xyLV9xLiqLX6hUVlVmT24b+RVC2AWGJaQNhNAFiac9S9kRy1rnk
         T9CA==
X-Forwarded-Encrypted: i=1; AJvYcCXCFoLtI0IXL0uLkKajbjKJnaqxMdzh2ui51H+aDlfszA/6SPnxazjbSqpIydb8xW+EHE7VgXfZgTS9RKbsZ5rmOL2UKA==
X-Gm-Message-State: AOJu0YzFsNKeLgRUxJNfhi1mlm85wMvjIa+Ek1Q/FB33dnfUOeXoQMMx
	UKTKZ52o2YtQKAVykWE8lhjIlsHeAzerttJD0YwwtloCcao+SRml12OsSQVJlDLf3at0H6N4rRu
	Oa3WOHwXk6omECGT21AhpTZXi7KoEpzgoS6M=
X-Google-Smtp-Source: AGHT+IGXTICYod+zKa1S6TICThzTD9rYRugOpDGGR49sKW2td/kptrfNSbYGRu1DyrZwHrXsO/EGxBjrGTQlR20A3go=
X-Received: by 2002:a17:906:f152:b0:a77:cdaa:88a3 with SMTP id
 a640c23a62f3a-a7a01147193mr247255566b.27.1721274888223; Wed, 17 Jul 2024
 20:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240717102458.649b60be@kernel.org> <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
 <ZpgtXjz3pbJKUjL7@codewreck.org> <20240717163051.13e41526@kernel.org> <ZphskWZb_pkxMVvW@codewreck.org>
In-Reply-To: <ZphskWZb_pkxMVvW@codewreck.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Jul 2024 05:54:35 +0200
Message-ID: <CAGudoHFzCFP04a5XfjWVaTjuFJ+Fw8XA83TWWqj-AwRbJHoiMw@mail.gmail.com>
Subject: Re: hangs after merge window changes
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 3:15=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Jakub Kicinski wrote on Wed, Jul 17, 2024 at 04:30:51PM -0700:
> > On Thu, 18 Jul 2024 05:45:18 +0900 Dominique Martinet wrote:
> > > Eric Van Hensbergen wrote on Wed, Jul 17, 2024 at 01:01:26PM -0500:
> > > > I held way back on adding anything new over the past cycle, so this
> > > > sounds likely some external change maybe perturbing an older issue.
> > > > What guest side mount options, qemu options and qemu version are yo=
u
> > > > using?
> > >
> > > Mount option if any would be much appreciated, yes.
> > > Also, what version you upgraded from to limit the limit the search a
> > > bit; the previous 6.9 tree?
> >
> > Between networking pull requests. Basically
> > 528dd46d0fc35c0176257a13a27d41e44fcc6cb3 to
> > 51835949dda3783d4639cfa74ce13a3c9829de00
>
> Thanks, this includes this commit:
> 7180f8d91fcb ("vfs: add rcu-based find_inode variants for iget ops")
>
> I think that's our most likely candidate at this point, adding Mateusz
> and others involved in Cc until I find more time to reproduce.
>
> @Mateusz, Jan, Christian - sorry if it wasn't the culprit.
> We're seeing new hangs in find_inode_fast between the above two commits,
> see the extact hang traces top of  the original mail:
> https://lore.kernel.org/v9fs/CAFkjPTnTDWrfCSVzvtSszjoerOeWBn8Z6DC4qFMH70A=
q7Pqr1Q@mail.gmail.com/T/#t
>
>
> > > Also couldn't find much infos about the CI in general, given the trac=
es
> > > I don't think the workload matters all that much but it can give
> > > something to start with e.g. running from initrd and mounting 9p or
> > > using 9p as rootfs; that shouldn't make a difference but might as wel=
l
> > > try to reproduce from something close to the actual netdev CI given t=
he
> > > low reproducibility.
> >
> > What CI does is described here:
> > https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-C=
I-style
> > it's fairly simple, virtme-ng just runs kselftests inside a VM with
> > the host FS mounted via 9p-virtio.
> >
> > I'd offer running experiments on the exact systems, but this week
> > I'm partially AFK (at a conference).
>
> Thanks.
> You're not doing anything specific, I'll hopefully be able to reproduce
> it running similar workloads at which point I'll try to improve the
> reproducer and get a closer look if Mateusz or others didn't beat me to
> it.
>

I think I see the bug -- find_inode_fast can race if evict calling
remove_inode_hash and issuing the wakeup.

Specifically it can find the inode and only get the lock *after* both
removal and wakeup are done. At that point one of the set flags is
I_FREEING, which is a sufficient condition for it to block.

Previously it was interlocked with the inode_hash_lock.

Easiest & safest way out is for the lockless lookup to never block and
instead fallback to locked operation if it can't immediately get the
inode. Another options is to take advantage of the invariant on
i_state:
         BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));

and not fail to find the inode considering this value.

That said let me chew on it.
--=20
Mateusz Guzik <mjguzik gmail.com>
