Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD61EA80
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300292; cv=none; b=lZUhqoAOX22sAiY21xPW7A1I7X6YLyBIwvovAFmWnEN3Op8ZEWdQpxiWdu8yW7tb3ONHYHVpy10n6siVkzocDuEmKyXTr5SCSRzeePwsQHLr5Ighj5ksu3bK704d9J/ShjxUSQm5b35aLoy+rjFSirKF8jrqvKO7E+Jn57u98+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300292; c=relaxed/simple;
	bh=4df8de7jy4bkvAVmHuwbSs6TnBVPqwbkH65RUGN5ioo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8R5e7ihJdDB5hLFY+aTe1P7C1sY4KSOi9cvGMKesPxg9FUKAj71JUkGdUTqnG05gpYMxZLVx3TqLABBGiC8uAb5ubGQlzVjFAqHlFIo679qn8wHyoF1rp8qtG2wUmVVVTLna2YIgVfQxk03IWfqxZrRoOZRJxT2Y5B94uuAETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6iXk9Ek; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6iXk9Ek"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77e392f59fso68880466b.1
        for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721300288; x=1721905088; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mxx8nlBqYiujr9zHSI0c2F284edTw0RoAO6Td5bd7E=;
        b=g6iXk9Ek8g9+vdKtw4+MnEiSOOcbVZYTef/iUDywEnzWZHGvNM1N5yr0b0C2nQIaCf
         j4EFYG4QZ1dN7nbxpKbTf7t+OwegysK5DFWTa81uNwnUdsR7GooJGeWhAYYS1fdlOhbK
         RGSA4mGdFdAgOPinHNDMPqh20o68dd/u+T7f0rGGALQ/4E/aEDcLXA2xrkqKfx6QVzl5
         4Pl/rWJPavoeMJwBQoEa2+9QB+c9fglIsdOPg2haoGje+7OHnrlDsFbxb0NfT93yNkmD
         nF/wlW12QWdGvc21XwXHEeOwdb8eFN7ooCsOoixlBJ0R9K7w+W6leF8q0jtOpfbcKsKC
         vjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721300288; x=1721905088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mxx8nlBqYiujr9zHSI0c2F284edTw0RoAO6Td5bd7E=;
        b=Lyzuf74CCfMO6oG18dkxP+YWSIU6DrgHKYqA/Kqi3tQPcmuudrcW59kdREu+x/RBDD
         q6M3X/b7dzZfeT65PHaK2oux2L9g8FBWz7Kfg3Ixudnjy2xjHehvqClgZ/gmE5Zpy+Hl
         H4A/tHBOlrH8s+qi+vWOl3ypuXPpN156Zss634vIkxqWkK4l7hUDmyGstNfCBd2ZUqK1
         1YTD5jg/XTv8HhIQWoMqWUKEEBdPGHfMYBhZYUTjUJQ7CMcDFai04JxSB+BsW5nDfmmR
         7Tv8vvFWaUBY4bzVXH4ILi3ElL6Jg1MMKoEShh7sBWA5doY8rWV1lvoZnFKOWrEUvPBC
         Ldew==
X-Forwarded-Encrypted: i=1; AJvYcCV0dsG4Kb9xp5/8vsuuy6Qk57Ym6c9qfMxy+zYPJg2n/h7j4tCZdWzEWoDoUVD5UTGNxoDFEfZu6r1u4tldUNig/FGpyA==
X-Gm-Message-State: AOJu0YzyU2bHqByZV9MCOLqMLFUVBChVe7V9vgRkYk0yWJV4Rh5xvg+k
	UTlpjh/QVGVkescwl8p3np8LyczzpQ+LIX2Ko5zNLAwJA2ROKP9Hzz6hz1SPUV+36kixn7zERsn
	/yPYO5YS3KgV4CkfxTBZq/mgfOAo=
X-Google-Smtp-Source: AGHT+IHSUblkXB20+rvjEj7IeJ5SNOZOjxbNIrchhaa2LxrDstTEGET9cQX9Smqk8vk5UxDQ3TEW2SvpE3JTt514BWM=
X-Received: by 2002:a17:906:7f0d:b0:a77:e7cb:2979 with SMTP id
 a640c23a62f3a-a7a0130e68amr303894666b.51.1721300287841; Thu, 18 Jul 2024
 03:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240717102458.649b60be@kernel.org> <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
 <ZpgtXjz3pbJKUjL7@codewreck.org> <20240717163051.13e41526@kernel.org>
 <ZphskWZb_pkxMVvW@codewreck.org> <CAGudoHFzCFP04a5XfjWVaTjuFJ+Fw8XA83TWWqj-AwRbJHoiMw@mail.gmail.com>
 <CAGudoHE43w_gNNiV9YCg-tkiaORHUPuWP-_Znm2uXQtA+oS+iQ@mail.gmail.com> <20240718104203.3auoqtj63345rapd@quack3>
In-Reply-To: <20240718104203.3auoqtj63345rapd@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Jul 2024 12:57:55 +0200
Message-ID: <CAGudoHEoqrCgQ8=N+ioFegA-toRjTE+XvLdbtAqsvqhLuTLmNA@mail.gmail.com>
Subject: Re: hangs after merge window changes
To: Jan Kara <jack@suse.cz>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 18-07-24 06:08:45, Mateusz Guzik wrote:
> > > Previously it was interlocked with the inode_hash_lock.
>
> I agree.
>
> > > Easiest & safest way out is for the lockless lookup to never block an=
d
> > > instead fallback to locked operation if it can't immediately get the
> > > inode. Another options is to take advantage of the invariant on
> > > i_state:
> > >          BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
> > >
> > > and not fail to find the inode considering this value.
> > >
> > > That said let me chew on it.
> >
> > I'm going to have to do dayjob stuff, will look into reproducing it
> > later (if i'm correct about the bug it should be viable to add some
> > artificial delays to make it triggerable much easier).
> >
> > But should you repro in the meantime, the code below should do it (i
> > don't know if that's specifically what I'm going to submit though):
>
> Maybe it would be more elegant as:
>
> diff --git a/fs/inode.c b/fs/inode.c
> index f356fe2ec2b6..d0c39e71e403 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2291,6 +2291,16 @@ static void __wait_on_freeing_inode(struct inode *=
inode, bool locked)
>  {
>         wait_queue_head_t *wq;
>         DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
> +
> +       /*
> +        * If the inode is already unhashed, evict() may be past the __I_=
NEW
> +        * wakeup. Return immediately to avoid sleeping indefinitely.
> +        */
> +       if (unlikely(inode_unhashed(inode))) {
> +               BUG_ON(locked);
> +               return;

this is missing spin_unlock(&inode->i_lock);

> +       }
> +
>         wq =3D bit_waitqueue(&inode->i_state, __I_NEW);
>         prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
>         spin_unlock(&inode->i_lock);
> --
> 2.35.3
>

Putting the check here was my first variant, I don't have a strong
opinion on this front. Whatever immediate fixup can get massaged. For
something to actually commit I was thinking a little nicer, see below.

While the bug being here is on me, I do think the current state
avoidably facilitated it by implicitly depending on the hash state.

In evict() you can find:
        spin_lock(&inode->i_lock);
        wake_up_bit(&inode->i_state, __I_NEW);
        BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
        spin_unlock(&inode->i_lock);

This should probably move to a dedicated routine to pair up with
__wait_on_freeing_inode (and yes, I know there are other spots which
wake up based i_state) -- this much could be done in the fixup. It
would also asserts on the unhashed condition so it would be apparent
this is the invariant for (dis)allowing sleep.

Longer term imo it should have something which provides the definite
"no wakeups past this point" indicator not dependent on the above,
maybe a dedicated i_state flag combination.

This brings me to lack of VFS_ debug macros which would allow for
generous sprinkling of asserts without affecting production kernels --
someone(tm) should look into it.

I'll try to find some time in the evening to repro and validate that
this is indeed the issue though.
--=20
Mateusz Guzik <mjguzik gmail.com>
