Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF420B06
	for <v9fs@lists.linux.dev>; Wed,  3 Jan 2024 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bikmZJlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6747DC433C7
	for <v9fs@lists.linux.dev>; Wed,  3 Jan 2024 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704321785;
	bh=lEPfNgH2AD2aIalPmctqwU8SgSPmTv8obGMo/0YK8vg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bikmZJlqWHht3wZfV2AnSHaSOsiyWcTM5VNKmi2029/eOLPdyND+K1uRKhU+CC8iU
	 Q+rUDwWGPXzgO9G0h6xhVSf99y7Hbe/XqDFzKIQUTFHzLPWw1c85VMs8i8xzekGmwR
	 Ndvzh3mWmZqfEDDg0QNOI2ISuSi+8Gd+pEczs8x+0Nt8LHn+KMvR079GW0TaOR/4X0
	 fiOUTfgXC7LvBRPWLOnnhLNWZ2yRVnCTITKusodMOvXW3IeraGB2b78rO1Lpy2e8bM
	 NfexjjhiFcWg3bzl4YV07Rqx9dOB13T6Y/ANJYq5s5VYJ8G3iLqPQP1fbC8oOPzoQ9
	 q72wxlIaCuYSw==
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbdb8e032f7so764860276.1
        for <v9fs@lists.linux.dev>; Wed, 03 Jan 2024 14:43:05 -0800 (PST)
X-Gm-Message-State: AOJu0YzcmynI9YbYB4AICEh97JNgJrbNqWeMBZNTfd0tQOyywNYPQjHJ
	KXZn3FLDjFH86bbKXU3jbVnkXRX0yw9eb9T4+g0=
X-Google-Smtp-Source: AGHT+IHXYvAgVsxz1w7rye0TVO0yJ180lghxQ/0ezR3js8AaDHFrKyh0+kyVgvI7N9ngnKdRY8CCQpTaHCC2MA6OzhY=
X-Received: by 2002:a05:6902:532:b0:dbd:b081:964b with SMTP id
 y18-20020a056902053200b00dbdb081964bmr1102767ybs.28.1704321784666; Wed, 03
 Jan 2024 14:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZZWi6fbgy8oGwR1D@FV7GG9FTHL> <ZY7qr1Dy_aS716dC@FV7GG9FTHL>
 <ZZXCiSlrAMI5sMr3@codewreck.org> <CAFkjPT=61yygntbhSJMMWeK4JBrm85EZpz387aPHD_xmHVBbog@mail.gmail.com>
In-Reply-To: <CAFkjPT=61yygntbhSJMMWeK4JBrm85EZpz387aPHD_xmHVBbog@mail.gmail.com>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Wed, 3 Jan 2024 16:42:53 -0600
X-Gmail-Original-Message-ID: <CAFkjPTktfEwcH5fa-JooR+8OV_bbEX3u8niKS7TQcNU5G2WUCg@mail.gmail.com>
Message-ID: <CAFkjPTktfEwcH5fa-JooR+8OV_bbEX3u8niKS7TQcNU5G2WUCg@mail.gmail.com>
Subject: Fwd: cache fixes (redux)
To: v9fs@lists.linux.dev
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ooops, didn't hit reply all.

---------- Forwarded message ---------
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Wed, Jan 3, 2024 at 2:52=E2=80=AFPM
Subject: Re: cache fixes (redux)
To: Dominique Martinet <asmadeus@codewreck.org>


On Wed, Jan 3, 2024 at 2:25=E2=80=AFPM <asmadeus@codewreck.org> wrote:
> > Moving up the stack a bit, we use the modified qid.path to hash the
> > inode, but then we also assign it (overriding the allocated inode numbe=
r
> > on the client).  I'm gonna say this is wrong (definitely wrong in the
> > case where we are allocated inodes willy-nilly) and we should probably
> > continue to use qid.path to hash, but then keep the client side inode
> > number which is guarenteed unique on allocation.  Or do you folks think
> > we should align client-side inode with server-side inode to help with
> > debug?  We should still have consistent qid->paths regardless.  Thought=
s?
>
> I ended up suggesting something similar above without reading this
> properly, if I read this correctly I think we agree -- use as much bits
> as we can internally and keep it coherent, then just downsize for
> getattr if required.
>

One gotcha here and I'm inclined to maybe ignore it.  readdir uses
qid2ino to populate the inode number for directory listings.  So, I'd
need to convert that code to lookup the inode just to extract the
client-side inode number.  But this is all client side, so maybe not a
big deal and we aren't even using the readdir code right now in .L so
its not really on the critical path.

The other problem of course is that the inode hash is also an unsigned
long in the kernel. So really same problem applies... But I'm inclined
to switch to using qid.path to hash anyways as I think it makes the
code more understandable and we can get rid of weirdness like +2 and
get guarenteed unique inode numbers.

The other thing that needs to change though is v9fs_mount needs to use
iunique to grab a new inode number versus using qid.path from the
mount which means the logic there needs to change to using iget so we
can insert the mount point into the hash table.  I'm assuming that
just works, but gonna reorder my changes to try doing that first and
see if anything blows up.

        -eric
