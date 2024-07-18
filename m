Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D281386B4
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302830; cv=none; b=G1GMrueCn2P6ja2LR4V0Sl5bSvhZuraTuPSsfCu53QUknppPsYBlIZldoQeQqFVc4cDSnvQH3grg4Z17kbgiV6cT7USVR/3vscjf9GXzA+fUK8cruvntjO+i5uzzTEZTAAkhmKkQfBOjiioF+x7SGUdaN45ppCm46AQzFvzUxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302830; c=relaxed/simple;
	bh=s5GnnNyUSCVp4bUj1hk1on5X8bLKK0Bj2cnZuDotdmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SudYA4KkteUIpTy34u5CnEHFkHg8G9+GqDwiNpxEtVMpCBy8IT9Szm7poiLErhRnadmk2CUFMF9SdRtB9Ylqf2qQ/FCmu49tSF0ioFiC6uAfHyQbVFJrxSTqfdu5X2enB3FlCyJdQJ/wBq8dNoiaHUa/insvG7J25W9b30RgjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmv5t2hK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmv5t2hK"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611baso451661a12.1
        for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721302827; x=1721907627; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT2t4hZXyMVsO/cDvHO8hvzlbPs5p/KCUV+I7eizyPU=;
        b=Rmv5t2hKaWq116YxJpe86a+fajmejY7CeW/8YKLRFW31ymYwluBmAVfiOCWqseIuk0
         x9RzuOtGtJ7eDDPli7s9a5w2UB/eF/X1+ewcR8mRxUQbexc+2Tn1NQKn9m21FVgPrJTM
         GSwHJ/5FEA4ERMppiPGZKl6dIkmV39P+T5Q6I062zoUSyvgLqZa4OnKlip/qPqmr0Ab2
         0JStZlK4phdtR1fDnV7DAu3U46Juwacx1eYmZq9PAqQ2kdJP+29ut78EKVrkhqiAl7Kl
         zhmOLkvndEBZ0JXz6rHh9RrZxd+vX2TmYwvfTke0wps6mMY0DVa1nrg7wo1NCao18jkK
         rHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721302827; x=1721907627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fT2t4hZXyMVsO/cDvHO8hvzlbPs5p/KCUV+I7eizyPU=;
        b=R8SBg4I2viDx5jLJJzug005s7Nt9trY/f3xqCP5hlfiN/4RXCDvYCTCb50Cy1+gHgZ
         GW/W6MV9dcwx4F9tOS+2cI4uZZWE5gFaALMzjc7Gh81AnYjWV+evBZE+BvSTjD1/vFDc
         F/sPXPs5UwFBsDTTxx3Y8dYkScUlhoFXk3FinFax3cErwD0Vy2bEMpSGP3f4euUOCdny
         P0CThWULHSH9F0pasJouxJi7VYq7erjO2Gpr/IJKLf1/llXNPYrtkbXKRhWrlEMOQEw7
         ZWGQ7jcaWvxMPrsgCcUM9d/lxmi+I1bcwg9kT7Wt516YlEs/VTTOQv1uYmbt8RuBwtWb
         bVhA==
X-Forwarded-Encrypted: i=1; AJvYcCUXVMvHv5ZJSXw2VtemizSD0WFIq1cCVelQhgqZZalEW0n3zl9BNOL+PcBXbCNPir8B5cI0TtU3EFY6fXpEDUESWZDYbw==
X-Gm-Message-State: AOJu0YyC/aW3HtNAvg9qdBpUzEInK0qSnIANnrnW0GeZsh1kL6R+hyn6
	V0mZMj7Ms1OWWkdEsRzwbVkn2uAcMK83cjR2KXKrKJIvTR8JrUkq0tTutq+ZmtRS52NVn71Ufq2
	DaciQHzrFrTEq2K/LLemoW0x+F8M=
X-Google-Smtp-Source: AGHT+IEbIgVps5fT4cvn4buG7traDmHNYf/siiGAYa+TJXr9lfWo0n9I5xRKU3LFDihY2Q3LAgcBjL/zT9+GSangM9Y=
X-Received: by 2002:a17:906:6890:b0:a77:d1ea:ab3b with SMTP id
 a640c23a62f3a-a7a01154f2bmr328182166b.25.1721302826833; Thu, 18 Jul 2024
 04:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240717102458.649b60be@kernel.org> <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
 <ZpgtXjz3pbJKUjL7@codewreck.org> <20240717163051.13e41526@kernel.org>
 <ZphskWZb_pkxMVvW@codewreck.org> <CAGudoHFzCFP04a5XfjWVaTjuFJ+Fw8XA83TWWqj-AwRbJHoiMw@mail.gmail.com>
 <CAGudoHE43w_gNNiV9YCg-tkiaORHUPuWP-_Znm2uXQtA+oS+iQ@mail.gmail.com>
 <20240718104203.3auoqtj63345rapd@quack3> <CAGudoHEoqrCgQ8=N+ioFegA-toRjTE+XvLdbtAqsvqhLuTLmNA@mail.gmail.com>
In-Reply-To: <CAGudoHEoqrCgQ8=N+ioFegA-toRjTE+XvLdbtAqsvqhLuTLmNA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Jul 2024 13:40:14 +0200
Message-ID: <CAGudoHE6qMb=+-a-DGHVB3CB=ZyjV7uj17uWYqEfnB9wbgNW2w@mail.gmail.com>
Subject: Re: hangs after merge window changes
To: Jan Kara <jack@suse.cz>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:57=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Thu, Jul 18, 2024 at 12:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 18-07-24 06:08:45, Mateusz Guzik wrote:
> > > > Previously it was interlocked with the inode_hash_lock.
> >
> > I agree.
> >
> > > > Easiest & safest way out is for the lockless lookup to never block =
and
> > > > instead fallback to locked operation if it can't immediately get th=
e
> > > > inode. Another options is to take advantage of the invariant on
> > > > i_state:
> > > >          BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
> > > >
> > > > and not fail to find the inode considering this value.
> > > >
> > > > That said let me chew on it.
> > >
> > > I'm going to have to do dayjob stuff, will look into reproducing it
> > > later (if i'm correct about the bug it should be viable to add some
> > > artificial delays to make it triggerable much easier).
> > >
> > > But should you repro in the meantime, the code below should do it (i
> > > don't know if that's specifically what I'm going to submit though):
> >
> > Maybe it would be more elegant as:
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index f356fe2ec2b6..d0c39e71e403 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2291,6 +2291,16 @@ static void __wait_on_freeing_inode(struct inode=
 *inode, bool locked)
> >  {
> >         wait_queue_head_t *wq;
> >         DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
> > +
> > +       /*
> > +        * If the inode is already unhashed, evict() may be past the __=
I_NEW
> > +        * wakeup. Return immediately to avoid sleeping indefinitely.
> > +        */
> > +       if (unlikely(inode_unhashed(inode))) {
> > +               BUG_ON(locked);
> > +               return;
>
> this is missing spin_unlock(&inode->i_lock);
>
> > +       }
> > +
> >         wq =3D bit_waitqueue(&inode->i_state, __I_NEW);
> >         prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> >         spin_unlock(&inode->i_lock);
> > --
> > 2.35.3
> >
>
> Putting the check here was my first variant, I don't have a strong
> opinion on this front. Whatever immediate fixup can get massaged. For
> something to actually commit I was thinking a little nicer, see below.
>
> While the bug being here is on me, I do think the current state
> avoidably facilitated it by implicitly depending on the hash state.
>
> In evict() you can find:
>         spin_lock(&inode->i_lock);
>         wake_up_bit(&inode->i_state, __I_NEW);
>         BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
>         spin_unlock(&inode->i_lock);
>
> This should probably move to a dedicated routine to pair up with
> __wait_on_freeing_inode (and yes, I know there are other spots which
> wake up based i_state) -- this much could be done in the fixup. It
> would also asserts on the unhashed condition so it would be apparent
> this is the invariant for (dis)allowing sleep.
>
> Longer term imo it should have something which provides the definite
> "no wakeups past this point" indicator not dependent on the above,
> maybe a dedicated i_state flag combination.
>
> This brings me to lack of VFS_ debug macros which would allow for
> generous sprinkling of asserts without affecting production kernels --
> someone(tm) should look into it.
>
> I'll try to find some time in the evening to repro and validate that
> this is indeed the issue though.
> --

Now that I had some caffeine I see we both messed up here -- bailing
on the unhashed status without I_FREEING is not necessarily equivalent
to doing this after, so the check indeed should land in
__wait_on_freeing_inode.

That said, assuming testing passes later, I'm going to submit this
(with maybe some word-smithing):

diff --git a/fs/inode.c b/fs/inode.c
index f356fe2ec2b6..e1082d61c093 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -676,7 +676,18 @@ static void evict(struct inode *inode)

        remove_inode_hash(inode);

+       /*
+        * Wake up waiters in __wait_on_freeing_inode().
+        *
+        * Lockless hash lookup may end up finding the inode before we remo=
ved
+        * it above, but only lock it *after* we are done with the wakeup b=
elow.
+        * Should this happen there will be noone to wake the waiter.
+        *
+        * Use inode_unhashed() status as an indicator whether blocking the=
re is
+        * safe.
+        */
        spin_lock(&inode->i_lock);
+       BUG_ON(!inode_unhashed(inode));
        wake_up_bit(&inode->i_state, __I_NEW);
        BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
        spin_unlock(&inode->i_lock);
@@ -2291,6 +2302,16 @@ static void __wait_on_freeing_inode(struct
inode *inode, bool locked)
 {
        wait_queue_head_t *wq;
        DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
+
+       /*
+        * Handle racing against evict().
+        */
+       if (unlikely(inode_unhashed(inode))) {
+               BUG_ON(locked);
+               spin_unlock(&inode->i_lock);
+               return;
+       }
+
        wq =3D bit_waitqueue(&inode->i_state, __I_NEW);
        prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
        spin_unlock(&inode->i_lock);

--=20
Mateusz Guzik <mjguzik gmail.com>
