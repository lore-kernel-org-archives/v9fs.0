Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0728DB3
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721275741; cv=none; b=A7WJPb3C3bxp/tNER0GMa2Lo1uIPVIw1PCeGLJjGRrlyzi1hW6YiNu5B3sE2O1hpFFzznM8B94c9TT4hxAtHT+0G5Kfd35Sk4H1+Wsvjl9VcNZ0ViXb5lENrOHbJSt9TlRCPbFfK3n2vUmfg7Gfh8GUf1D5V43bsPHAmHYF3sY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721275741; c=relaxed/simple;
	bh=O3ZMm7jHvlvG8AYFypxXLl+W7RHQVu2x0OMvAQlKQWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyQfGCjT05pbzWjWoMeZ9FqaWt90OK1AEHo0xMU7s5qgZ4NBI+XSTCXhRrH9bLB2X84rEp58XIIip6BmQIcVFrJ23t7e1hdOfq/Dvl26B9YJUmjRKGy1rjEbQMLqhwOfI1S2NfN7C9f+jGKQuA9DZWEiTcjjG7ToyBYYtl44Wxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMVXJ1aQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMVXJ1aQ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77dc08db60so32314466b.1
        for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 21:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721275738; x=1721880538; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD5jh901cH/CbJCAGfnJLC6lVpkIP11l//uqloPuGJw=;
        b=cMVXJ1aQxD4OimXJiCi29+2/VaB0kCM03DtJYHuh1FzhuqhKQgSZjdaoggr4/e+bjF
         +YSb7fTfY8Y4csH9YjuDd9IfIrTCg0VRPC5287NV7UNePWos5S35xsSmwHDBEyZiUxvO
         6U/u1Ul3Sx4BMlG2DB4G/pbKiBem13EieDVElCFrl/IHFYJXUhtAA0QM4/cGSu3ntuzx
         Aj+dIvsLivaDXbebwq6MB053C2EUHdY7YmktUoUnXBZDenVfPlH6+BmJTP1xJ0KkFMtF
         97iJg9akSa2aKxasMBOcaqlMhmGWutgAg2sXLY6kotA+N15j7bUSeoEgqxR6bQrkN1Bh
         4dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721275738; x=1721880538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yD5jh901cH/CbJCAGfnJLC6lVpkIP11l//uqloPuGJw=;
        b=AoWT2tiUByPSawwU5nWnsEBGexz/nMq//sh4QIAwQFkc7Uwxark2S+dJbG5oHFYJ0Q
         gpHx8c208CYY7gAxksPvX0AIaTtYK0SZa2jkfQ7jr4YyZp3LsUA9Q47mnIgFTMumPvWS
         WaBCJ+xBuRQ49+BR/KYFmvUqoXh35k9E4VYq07Y5bQNjG9d2pixQUUKreZ7cQ+925isD
         oV047a54Yzrp/8HxrAeoTrcvX656aGujpFsb59+BJR93BiMJmgLcBCRlBjehOPv5A49B
         mTv+x7AHrqZxjPulBFllAOFXzF05LSmpja4i6JM64stiAM5nfEtI7aUhBsNfvXbXZScx
         YPBg==
X-Forwarded-Encrypted: i=1; AJvYcCURqRQ8qVEKfkqvOpzkMV2WUqkoghQItlOod9AjRVB8W6c7hzh/Pos1/4wlL6exB7iSwKqAffXL/lGoc63wgwOtR6O0Rw==
X-Gm-Message-State: AOJu0YwsL1eCgRpJoCC27wY/h1hkntgNJ0vTUR6yAkh0IWlws65PYfwU
	afErWQItLEsJQdDtTNlSELbtJDACgsOhqLbdEO/biQ2FKIjaJU6jKZD5KUq6y6p3hlhqGYWsl5l
	aNi0T/uaq8qaRSbnx+LvUIiRHwJk=
X-Google-Smtp-Source: AGHT+IFpjQ3aH68bUK0xLHO7ityrgGQ6ywCEX6H/A+14x1X2AdDj7bXYsGNc+sCNPJAh42qN3FMPYs5BXcoQ2nCglH8=
X-Received: by 2002:a17:907:31ca:b0:a7a:1273:bc63 with SMTP id
 a640c23a62f3a-a7a1273bd3cmr110642566b.0.1721275737882; Wed, 17 Jul 2024
 21:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240717102458.649b60be@kernel.org> <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
 <ZpgtXjz3pbJKUjL7@codewreck.org> <20240717163051.13e41526@kernel.org>
 <ZphskWZb_pkxMVvW@codewreck.org> <CAGudoHFzCFP04a5XfjWVaTjuFJ+Fw8XA83TWWqj-AwRbJHoiMw@mail.gmail.com>
In-Reply-To: <CAGudoHFzCFP04a5XfjWVaTjuFJ+Fw8XA83TWWqj-AwRbJHoiMw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Jul 2024 06:08:45 +0200
Message-ID: <CAGudoHE43w_gNNiV9YCg-tkiaORHUPuWP-_Znm2uXQtA+oS+iQ@mail.gmail.com>
Subject: Re: hangs after merge window changes
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 5:54=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Jul 18, 2024 at 3:15=E2=80=AFAM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> >
> > Jakub Kicinski wrote on Wed, Jul 17, 2024 at 04:30:51PM -0700:
> > > On Thu, 18 Jul 2024 05:45:18 +0900 Dominique Martinet wrote:
> > > > Eric Van Hensbergen wrote on Wed, Jul 17, 2024 at 01:01:26PM -0500:
> > > > > I held way back on adding anything new over the past cycle, so th=
is
> > > > > sounds likely some external change maybe perturbing an older issu=
e.
> > > > > What guest side mount options, qemu options and qemu version are =
you
> > > > > using?
> > > >
> > > > Mount option if any would be much appreciated, yes.
> > > > Also, what version you upgraded from to limit the limit the search =
a
> > > > bit; the previous 6.9 tree?
> > >
> > > Between networking pull requests. Basically
> > > 528dd46d0fc35c0176257a13a27d41e44fcc6cb3 to
> > > 51835949dda3783d4639cfa74ce13a3c9829de00
> >
> > Thanks, this includes this commit:
> > 7180f8d91fcb ("vfs: add rcu-based find_inode variants for iget ops")
> >
> > I think that's our most likely candidate at this point, adding Mateusz
> > and others involved in Cc until I find more time to reproduce.
> >
> > @Mateusz, Jan, Christian - sorry if it wasn't the culprit.
> > We're seeing new hangs in find_inode_fast between the above two commits=
,
> > see the extact hang traces top of  the original mail:
> > https://lore.kernel.org/v9fs/CAFkjPTnTDWrfCSVzvtSszjoerOeWBn8Z6DC4qFMH7=
0Aq7Pqr1Q@mail.gmail.com/T/#t
> >
> >
> > > > Also couldn't find much infos about the CI in general, given the tr=
aces
> > > > I don't think the workload matters all that much but it can give
> > > > something to start with e.g. running from initrd and mounting 9p or
> > > > using 9p as rootfs; that shouldn't make a difference but might as w=
ell
> > > > try to reproduce from something close to the actual netdev CI given=
 the
> > > > low reproducibility.
> > >
> > > What CI does is described here:
> > > https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests=
-CI-style
> > > it's fairly simple, virtme-ng just runs kselftests inside a VM with
> > > the host FS mounted via 9p-virtio.
> > >
> > > I'd offer running experiments on the exact systems, but this week
> > > I'm partially AFK (at a conference).
> >
> > Thanks.
> > You're not doing anything specific, I'll hopefully be able to reproduce
> > it running similar workloads at which point I'll try to improve the
> > reproducer and get a closer look if Mateusz or others didn't beat me to
> > it.
> >
>
> I think I see the bug -- find_inode_fast can race if evict calling
> remove_inode_hash and issuing the wakeup.
>
> Specifically it can find the inode and only get the lock *after* both
> removal and wakeup are done. At that point one of the set flags is
> I_FREEING, which is a sufficient condition for it to block.
>
> Previously it was interlocked with the inode_hash_lock.
>
> Easiest & safest way out is for the lockless lookup to never block and
> instead fallback to locked operation if it can't immediately get the
> inode. Another options is to take advantage of the invariant on
> i_state:
>          BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
>
> and not fail to find the inode considering this value.
>
> That said let me chew on it.

I'm going to have to do dayjob stuff, will look into reproducing it
later (if i'm correct about the bug it should be viable to add some
artificial delays to make it triggerable much easier).

But should you repro in the meantime, the code below should do it (i
don't know if that's specifically what I'm going to submit though):
diff --git a/fs/inode.c b/fs/inode.c
index f356fe2ec2b6..6faeac55c3ec 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -912,6 +912,11 @@ static struct inode *find_inode(struct super_block *sb=
,
                if (!test(inode, data))
                        continue;
                spin_lock(&inode->i_lock);
+               if (unlikely(inode_unhashed(inode))) {
+                       BUG_ON(locked);
+                       spin_unlock(&inode->i_lock);
+                       goto repeat;
+               }
                if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
                        __wait_on_freeing_inode(inode, locked);
                        goto repeat;
@@ -953,6 +958,11 @@ static struct inode *find_inode_fast(struct
super_block *sb,
                if (inode->i_sb !=3D sb)
                        continue;
                spin_lock(&inode->i_lock);
+               if (unlikely(inode_unhashed(inode))) {
+                       BUG_ON(locked);
+                       spin_unlock(&inode->i_lock);
+                       goto repeat;
+               }
                if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
                        __wait_on_freeing_inode(inode, locked);
                        goto repeat;


--=20
Mateusz Guzik <mjguzik gmail.com>
