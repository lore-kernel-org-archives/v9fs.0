Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9445BE8
	for <v9fs@lists.linux.dev>; Mon,  8 Jan 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btwPkE6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35ACC433CC
	for <v9fs@lists.linux.dev>; Mon,  8 Jan 2024 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704723156;
	bh=pD5SBbFuLG2AhTBrtzXTDBmE5eg/gBHBBfJ6Kj9j4ng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=btwPkE6QvmiWgtuZEjFqP5R4G19IDfgzIpVMB5snR2MhwaHgA7LXwcOAnUVHo22pb
	 D1gAijxbl53cOhBiiBGz2CDuDzN5nAyJSaiE1SYWI1mcOD1RQn2PZKAJHmB6uvQlhw
	 FlEQHW3VVOGrTghU2+MujtqbFaLhwEaJwYGVoQyD/YkSFDPVyoESqsAKZ/h6thTYUH
	 rZtxUH/gfqFvO9jX1sKWhkA7YLSE2QJ3hUcavz9ZFWPYWNHW22c3ofTj/hNLK0U/zS
	 UOALce8k+/x1LZEv6bvc1glNhSxwC7huD7JJq2uX7GnsufvYPPEXA+TU0KKhnavCQm
	 QrZ64Rijit4BQ==
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1068264276.3
        for <v9fs@lists.linux.dev>; Mon, 08 Jan 2024 06:12:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yz1v8cp6ZxHcx4eu1fdVOH6cPOpYfsXFEwJwetbkdW4LOXoSclb
	FyubNIGwRCW5tKl1ybjtGOfkM3kTBhBKxLpcAWw=
X-Google-Smtp-Source: AGHT+IGCF5gUSuRELWRDjGsDePINR6sB1QgKOzrl5eVzJyP1wO+lTceHs3j+2kA2LJNSYKeiJr8ajm8sRVBox9FxZN8=
X-Received: by 2002:a05:6902:562:b0:dbd:5536:33f3 with SMTP id
 a2-20020a056902056200b00dbd553633f3mr1392931ybt.39.1704723155968; Mon, 08 Jan
 2024 06:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240107-fix-nlink-handling-v1-1-8b1f65ebc9b2@kernel.org>
 <ZZvaRt4T-RjOBoS2@codewreck.org> <8004884.rDQMAZhJ5Z@silver>
In-Reply-To: <8004884.rDQMAZhJ5Z@silver>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 8 Jan 2024 08:12:24 -0600
X-Gmail-Original-Message-ID: <CAFkjPTn0HFnnZk8rt7m+mfLyPofMxZC6EzaoFChoyRVdVnwM6Q@mail.gmail.com>
Message-ID: <CAFkjPTn0HFnnZk8rt7m+mfLyPofMxZC6EzaoFChoyRVdVnwM6Q@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: fix inode nlink accounting
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: asmadeus@codewreck.org, linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
	rminnich@gmail.com, lucho@ionkov.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 6:08=E2=80=AFAM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> On Monday, January 8, 2024 12:19:34 PM CET asmadeus@codewreck.org wrote:
> > Eric Van Hensbergen wrote on Sun, Jan 07, 2024 at 07:07:52PM +0000:
> > > I was running some regressions and noticed a (race-y) kernel warning =
that
> > > happens when nlink becomes less than zero.  Looking through the code
> > > it looks like we aren't good about protecting the inode lock when
> > > manipulating nlink and some code that was added several years ago to
> > > protect against bugs in underlying file systems nlink handling didn't
> > > look quite right either.  I took a look at what NFS was doing and tri=
ed to
> > > follow similar approaches in the 9p code.
> >
> > I was about to say the set/inc/etc_nlink helpers could probably just be
> > using atomic (there's an atomic_dec_if_postive that we could have used
> > for the v9fs_dec_count warning), but this isn't our code so not much to
> > do about that -- I agree it needs a lock.
> >
> > I didn't take the time to check if you missed any, but it won't be wors=
e
> > than what we have right now:
> > Acked-by: Dominique Martinet <asmadeus@codewreck.org>
>
> That's actually a good point. For these tasks atomic inc/sub/etc are usua=
lly
> used instead of locks.
>
> I would at least add local wrapper functions that would do these spinlock=
s for
> us.
>

I'm good with adding local wrapper functions,  I imagine these aren't
used in the kernel because for regular file-systems maybe you want the
warning that your inode link accounting is wrong.
I suppose we could be naughty and not use the kernel functions (which
themselves are basically wrappers).

      -eric
