Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D379B99
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305786; cv=none; b=Upzk1pEatCdn7PPMBpWEe0OZo7FWhO1xyJ4ngeRPo1J4nnJLjUTJQA+EW+2sPKsELYUh8KvXhRZ71rlw+c8pBrY6hCIIWKue36qDYW0psYf4YHTP99E+P7ofKguaTtRewitkyrQOP15hGV02mU/c/GB7zWdc4sQb1nbpO0G15EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305786; c=relaxed/simple;
	bh=UQXjemTNmaab3+i5ndPMbJu304wMKH95yOGGaDkouNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTk+Ez5YiHediAjeTA+MiPgf0ZXP1Ey1ZCpt9UQ/Tn4MKBiFZ1pgqZE3npXasx514w5lmKxZYGl2fpD1Q2I/cpZ/G0dsRlQfayrwC3IIjYWHK+bEgO5EduZ9kyX4HPl+LESyFk1mhOot8BRIxrjqzLB/ElGA8AUUh5F4TVH0VQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyzsC+G8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyzsC+G8"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e7420697so86380966b.1
        for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721305783; x=1721910583; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8PMQfnrSds7wSv9dhc3TICdPPkxwowHCT9LEcK5mvo=;
        b=DyzsC+G8G+gwjmkQBnMbLimoOvphOryERVV1bcCVi0JRAfw2PQueP/7j+hrBq5RuGD
         BfrUIN7JKzbZcIeK0L4vyX202QX6j84uvNAlMzofuCH84UgrpcY+y23sU6MaZGvC113+
         /msaJqHmq+FAwbN3et8ECAdK2W4NDOnwzOHxF4bAGPCXD6CtDnFYwFLzAcoV98XP1KW6
         L+Hx5JZx1+h4AZjIe0MMsL9I2j+ty6WHB3uq8QwFl+eKDpcJ3/0pDc7diApUNmzsZaN1
         jY/g59xGgyjZi6XMG5x1eLiZRGVA++dnu0Zmp7HLHIXAmsk4jrgmYfTeqiOiUjm9FF9e
         ZDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721305783; x=1721910583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8PMQfnrSds7wSv9dhc3TICdPPkxwowHCT9LEcK5mvo=;
        b=iBk+gZLtateuS6giuBcAnoymteZZI3qBQeY3f3v3PAzs0ipchH2uuUuc2/vpdoCo0B
         vHZsvYYMmVG149mb6oiLKFIPKuzoW8q3HEb39kVvsL+apRFffIR7IiQ1wyl4LodAyc/6
         BBoD4m1oGvvMnnMhpj96GDkAjfkejIwXk8s0TytH+RkSzbiipQOG2ZL0Z5/GKaWghdho
         GbBpyn/164YR193ekDjNHhWYrK6r1Rnt2UDAlygFfMGQIK5lmi2Ui7WveTjIpxOGcx8c
         12mPkwv5KAS5svG996iEZJyAvFS6m+L+nkS7Z2l7lNrjdbVAVUclxs/RUJOFMkwSjYQ7
         /lNw==
X-Forwarded-Encrypted: i=1; AJvYcCWXUSpF0J3uyucd5wHYtHiChvQxBh/kVmnTjNvUkx5v4r92hLd+GK6jH05l0LzWFQEIrRt5yRULPYq3aOTfBdEAU+Mqdg==
X-Gm-Message-State: AOJu0YyY199LurhE+l6BjMPwh6AFVykO+8KwqeFwrKuthAgmBMashx5f
	CQEk4aITEcqK35ydAVbFkp38jvJl8NirUQtONbe5wt1qvEJJNensXuKYMOElUaH11bfVvABgmBC
	1xB/ZEuVxaMpidzcJy7DM4iQStHTezQn8
X-Google-Smtp-Source: AGHT+IFnICTJMBVFKwqNnsVbfQniX5/IDvNYZrVBXRY5s+DkkPNxA+OQ5mxDp+MWqXnGXU1Zrh8gKXhvoUPtkMnev1Y=
X-Received: by 2002:a17:906:5612:b0:a77:b664:c078 with SMTP id
 a640c23a62f3a-a7a01192dd6mr323774366b.27.1721305782578; Thu, 18 Jul 2024
 05:29:42 -0700 (PDT)
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
 <CAGudoHE6qMb=+-a-DGHVB3CB=ZyjV7uj17uWYqEfnB9wbgNW2w@mail.gmail.com> <20240718121609.rtowlgt6ydmz44zf@quack3>
In-Reply-To: <20240718121609.rtowlgt6ydmz44zf@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Jul 2024 14:29:29 +0200
Message-ID: <CAGudoHEX7dmJxaws9Sw4+cHZQ0jfmZno9=Y_XsVZgKSSDs4xhg@mail.gmail.com>
Subject: Re: hangs after merge window changes
To: Jan Kara <jack@suse.cz>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 2:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 18-07-24 13:40:14, Mateusz Guzik wrote:
> > On Thu, Jul 18, 2024 at 12:57=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.c=
om> wrote:
> > >
> > > On Thu, Jul 18, 2024 at 12:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > >
> > > > On Thu 18-07-24 06:08:45, Mateusz Guzik wrote:
> > > > > > Previously it was interlocked with the inode_hash_lock.
> > > >
> > > > I agree.
> > > >
> > > > > > Easiest & safest way out is for the lockless lookup to never bl=
ock and
> > > > > > instead fallback to locked operation if it can't immediately ge=
t the
> > > > > > inode. Another options is to take advantage of the invariant on
> > > > > > i_state:
> > > > > >          BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
> > > > > >
> > > > > > and not fail to find the inode considering this value.
> > > > > >
> > > > > > That said let me chew on it.
> > > > >
> > > > > I'm going to have to do dayjob stuff, will look into reproducing =
it
> > > > > later (if i'm correct about the bug it should be viable to add so=
me
> > > > > artificial delays to make it triggerable much easier).
> > > > >
> > > > > But should you repro in the meantime, the code below should do it=
 (i
> > > > > don't know if that's specifically what I'm going to submit though=
):
> > > >
> > > > Maybe it would be more elegant as:
> > > >
> > > > diff --git a/fs/inode.c b/fs/inode.c
> > > > index f356fe2ec2b6..d0c39e71e403 100644
> > > > --- a/fs/inode.c
> > > > +++ b/fs/inode.c
> > > > @@ -2291,6 +2291,16 @@ static void __wait_on_freeing_inode(struct i=
node *inode, bool locked)
> > > >  {
> > > >         wait_queue_head_t *wq;
> > > >         DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
> > > > +
> > > > +       /*
> > > > +        * If the inode is already unhashed, evict() may be past th=
e __I_NEW
> > > > +        * wakeup. Return immediately to avoid sleeping indefinitel=
y.
> > > > +        */
> > > > +       if (unlikely(inode_unhashed(inode))) {
> > > > +               BUG_ON(locked);
> > > > +               return;
> > >
> > > this is missing spin_unlock(&inode->i_lock);
> > >
> > > > +       }
> > > > +
> > > >         wq =3D bit_waitqueue(&inode->i_state, __I_NEW);
> > > >         prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > > >         spin_unlock(&inode->i_lock);
> > > > --
> > > > 2.35.3
> > > >
> > >
> > > Putting the check here was my first variant, I don't have a strong
> > > opinion on this front. Whatever immediate fixup can get massaged. For
> > > something to actually commit I was thinking a little nicer, see below=
.
> > >
> > > While the bug being here is on me, I do think the current state
> > > avoidably facilitated it by implicitly depending on the hash state.
> > >
> > > In evict() you can find:
> > >         spin_lock(&inode->i_lock);
> > >         wake_up_bit(&inode->i_state, __I_NEW);
> > >         BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
> > >         spin_unlock(&inode->i_lock);
> > >
> > > This should probably move to a dedicated routine to pair up with
> > > __wait_on_freeing_inode (and yes, I know there are other spots which
> > > wake up based i_state) -- this much could be done in the fixup. It
> > > would also asserts on the unhashed condition so it would be apparent
> > > this is the invariant for (dis)allowing sleep.
> > >
> > > Longer term imo it should have something which provides the definite
> > > "no wakeups past this point" indicator not dependent on the above,
> > > maybe a dedicated i_state flag combination.
> > >
> > > This brings me to lack of VFS_ debug macros which would allow for
> > > generous sprinkling of asserts without affecting production kernels -=
-
> > > someone(tm) should look into it.
> > >
> > > I'll try to find some time in the evening to repro and validate that
> > > this is indeed the issue though.
> > > --
> >
> > Now that I had some caffeine I see we both messed up here -- bailing
> > on the unhashed status without I_FREEING is not necessarily equivalent
> > to doing this after, so the check indeed should land in
> > __wait_on_freeing_inode.
>
> Yeah.
>
> > That said, assuming testing passes later, I'm going to submit this
> > (with maybe some word-smithing):
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index f356fe2ec2b6..e1082d61c093 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -676,7 +676,18 @@ static void evict(struct inode *inode)
> >
> >         remove_inode_hash(inode);
> >
> > +       /*
> > +        * Wake up waiters in __wait_on_freeing_inode().
> > +        *
> > +        * Lockless hash lookup may end up finding the inode before we =
removed
> > +        * it above, but only lock it *after* we are done with the wake=
up below.
> > +        * Should this happen there will be noone to wake the waiter.
> > +        *
> > +        * Use inode_unhashed() status as an indicator whether blocking=
 there is
> > +        * safe.
> > +        */
> >         spin_lock(&inode->i_lock);
> > +       BUG_ON(!inode_unhashed(inode));
>
> So this is going to trip on XFS I'm afraid. XFS is not using VFS to hash
> inodes and sets inode->i_hash through hlist_add_fake() and
> remove_inode_hash() does nothing for it. So XFS inodes return
> !inode_unhashed(inode) all the way until they are destroyed. Now this is
> fine because these inodes have no way to get to __wait_on_freeing_inode()=
.
> Also the !inode_unhashed() check looks a bit weird just a few lines below
> remove_inode_hash() so I'd just drop this check.
>
> Otherwise the fix looks good to me!
>

I'll poke at xfs, worst case I'll drop the assert.

Fixing the bug aside, perhaps I should elaborate that I'm bothered by
the fact that the initial condition indicating whether one can go to
sleep *still holds* after there are no legal means to do the wakeup.
The added assert merely tries to document the side condition which has
to be checked separately, but is indeed optional and it may happen to
get messed up by filesystems which don't use the inode hash.

Doing something about the entire ordeal landed somewhere on my TODO
list after the bug is sorted out.

Thanks for feedback.

>                                                                 Honza
>
>
> >         wake_up_bit(&inode->i_state, __I_NEW);
> >         BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
> >         spin_unlock(&inode->i_lock);
> > @@ -2291,6 +2302,16 @@ static void __wait_on_freeing_inode(struct
> > inode *inode, bool locked)
> >  {
> >         wait_queue_head_t *wq;
> >         DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
> > +
> > +       /*
> > +        * Handle racing against evict().
> > +        */
> > +       if (unlikely(inode_unhashed(inode))) {
> > +               BUG_ON(locked);
> > +               spin_unlock(&inode->i_lock);
> > +               return;
> > +       }
> > +
> >         wq =3D bit_waitqueue(&inode->i_state, __I_NEW);
> >         prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> >         spin_unlock(&inode->i_lock);
> >
> > --
> > Mateusz Guzik <mjguzik gmail.com>
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--=20
Mateusz Guzik <mjguzik gmail.com>
