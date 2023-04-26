Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86313FC2
	for <v9fs@lists.linux.dev>; Wed, 26 Apr 2023 16:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C61CC433EF
	for <v9fs@lists.linux.dev>; Wed, 26 Apr 2023 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682527529;
	bh=vNWyFjSCdQ0qoIQWjhEsyjxX4mfCg7rJeTy5a+Hx31A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gjVKFxRLQq2ABo70Wt+XfRFLd9Haz5CKkoEJb0nlBG60tSpDleT+NiT4S8ntuzfTV
	 1a1Jo1V4LaEIZFbiIgcUvIxsSElDxtoqvuupJDcc/j+OcPnIxETUwecF9NOhC94lbf
	 dGjPwRMfpWknpxKhFk38KO9fkZNBHx7fYKo/HKHD+Jc6Czzsjm0ZcWgeyRApdmZoD6
	 hnT+jrad3IdBUzAOM6X+sl9v9iN0sC8K+DdlE1zrk57g9fdJ03/tIQZNTtmOPFW/D+
	 vLx827sgG6bRV7SQFNRQTWzUqInDFOcoG2RVv0bnopBBdKTCZ8ABWrBBWwyxZKqbtc
	 R56ALIIObcfiw==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-555e853d3c5so56864127b3.2
        for <v9fs@lists.linux.dev>; Wed, 26 Apr 2023 09:45:29 -0700 (PDT)
X-Gm-Message-State: AC+VfDzHjy/TdqSAWYPVqMYquxTya8zeFacOdZl2mV/TVQHH7PMSHyzQ
	epP9QOgYjKuVOvlNSb3TXS3kkbpZT42mbUB4nNk=
X-Google-Smtp-Source: ACHHUZ7W+RSWN8ee1XW23t02WOrGZqYOZfR3bexqXK16qkxJFF31xbxgrozrJ0VyPJ+EVLQzajLBOxG4dM191Zh7Hv8=
X-Received: by 2002:a81:89c5:0:b0:556:b029:e101 with SMTP id
 z188-20020a8189c5000000b00556b029e101mr6159408ywf.19.1682527528553; Wed, 26
 Apr 2023 09:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230218003323.2322580-11-ericvh@kernel.org> <ZCEGmS4FBRFClQjS@7e9e31583646>
 <7686c810-4ed6-9e3a-3714-8b803e2d3c46@wanadoo.fr> <CAFkjPT=-EvCf1HKT2-k73G4SVBwRDp=YtvfwhNAcjv6BzS4f9Q@mail.gmail.com>
In-Reply-To: <CAFkjPT=-EvCf1HKT2-k73G4SVBwRDp=YtvfwhNAcjv6BzS4f9Q@mail.gmail.com>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Wed, 26 Apr 2023 09:45:17 -0700
X-Gmail-Original-Message-ID: <CAFkjPTmzvxV1O0kwg-wVg9z_WPZnuOL_qEmeja3+SH2yFb+25w@mail.gmail.com>
Message-ID: <CAFkjPTmzvxV1O0kwg-wVg9z_WPZnuOL_qEmeja3+SH2yFb+25w@mail.gmail.com>
Subject: Re: [PATCH v5] fs/9p: remove writeback fid and fix per-file modes
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org, 
	linux_oss@crudebyte.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

going back over the patch series I realized that this same bitops
problem was in vfs_file and that's the fix I remember doing, but it
didn't propagate to the atomic open variants.  Thanks again for
finding this Christophe.

      -eric

On Tue, Apr 25, 2023 at 5:01=E2=80=AFPM Eric Van Hensbergen <ericvh@kernel.=
org> wrote:
>
> I swear I fixed that, must have been one of my fixes got dropped in
> the process of churning over this patch.  I'm quite concerned that
> this is coming up during the merge window because I'd really rather
> not punt this patch series another two months.  I'm going to apply the
> fix as an additional patch which hopefully Linus will accept with the
> rest of the series.
>
> On Tue, Apr 25, 2023 at 12:11=E2=80=AFAM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > Le 27/03/2023 =C3=A0 04:59, Eric Van Hensbergen a =C3=A9crit :
> > > This patch removes the creating of an additional writeback_fid
> > > for opened files.  The patch addresses problems when files
> > > were opened write-only or getattr on files with dirty caches.
> > >
> > > This patch also incorporates information about cache behavior
> > > in the fid for every file.  This allows us to reflect cache
> > > behavior from mount flags, open mode, and information from
> > > the server to inform readahead and writeback behavior.
> > >
> > > This includes adding support for a 9p semantic that qid.version=3D=3D=
0
> > > is used to mark a file as non-cachable which is important for
> > > synthetic files.  This may have a side-effect of not supporting
> > > caching on certain legacy file servers that do not properly set
> > > qid.version.  There is also now a mount flag which can disable
> > > the qid.version behavior.
> > >
> > > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> > > ---
> > >   fs/9p/fid.c            | 48 +++++++++-------------
> > >   fs/9p/fid.h            | 33 ++++++++++++++-
> > >   fs/9p/v9fs.h           |  1 -
> > >   fs/9p/vfs_addr.c       | 22 +++++-----
> > >   fs/9p/vfs_file.c       | 91 ++++++++++++++-------------------------=
---
> > >   fs/9p/vfs_inode.c      | 45 +++++++--------------
> > >   fs/9p/vfs_inode_dotl.c | 48 +++++++++-------------
> > >   fs/9p/vfs_super.c      | 33 ++++-----------
> > >   8 files changed, 135 insertions(+), 186 deletions(-)
> > >
> >
> > Hi,
> >
> > this patch has already reached -next, but there is some spurious code.
> >
> > As, I'm not sure what the real intent is, I prefer to reply here instea=
d
> > of sending a patch.
> >
> >
> > [...]
> >
> > > @@ -817,9 +814,14 @@ v9fs_vfs_atomic_open(struct inode *dir, struct d=
entry *dentry,
> > >
> > >       v9ses =3D v9fs_inode2v9ses(dir);
> > >       perm =3D unixmode2p9mode(v9ses, mode);
> > > -     fid =3D v9fs_create(v9ses, dir, dentry, NULL, perm,
> > > -                             v9fs_uflags2omode(flags,
> > > -                                             v9fs_proto_dotu(v9ses))=
);
> > > +     p9_omode =3D v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
> > > +
> > > +     if ((v9ses->cache >=3D CACHE_WRITEBACK) && (p9_omode & P9_OWRIT=
E)) {
> > > +             p9_omode =3D (p9_omode & !P9_OWRITE) | P9_ORDWR;
> >
> > This code looks strange.
> > P9_OWRITE is 0x01, so !P9_OWRITE is 0.
> > So the code is equivalent to "p9_omode =3D P9_ORDWR;"
> >
> > Is it what is expexted?
> >
> > Maybe
> >         p9_omode =3D (p9_omode & ~P9_OWRITE) | P9_ORDWR;
> > ?
> >
> > > +             p9_debug(P9_DEBUG_CACHE,
> > > +                     "write-only file with writeback enabled, creati=
ng w/ O_RDWR\n");
> > > +     }
> > > +     fid =3D v9fs_create(v9ses, dir, dentry, NULL, perm, p9_omode);
> > >       if (IS_ERR(fid)) {
> > >               err =3D PTR_ERR(fid);
> > >               goto error;
> >
> > [...]
> >
> > > diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> > > index a28eb3aeab29..4b9488cb7a56 100644
> > > --- a/fs/9p/vfs_inode_dotl.c
> > > +++ b/fs/9p/vfs_inode_dotl.c
> > > @@ -232,12 +232,12 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, st=
ruct dentry *dentry,
> > >       int err =3D 0;
> > >       kgid_t gid;
> > >       umode_t mode;
> > > +     int p9_omode =3D v9fs_open_to_dotl_flags(flags);
> > >       const unsigned char *name =3D NULL;
> > >       struct p9_qid qid;
> > >       struct inode *inode;
> > >       struct p9_fid *fid =3D NULL;
> > > -     struct v9fs_inode *v9inode;
> > > -     struct p9_fid *dfid =3D NULL, *ofid =3D NULL, *inode_fid =3D NU=
LL;
> > > +     struct p9_fid *dfid =3D NULL, *ofid =3D NULL;
> > >       struct v9fs_session_info *v9ses;
> > >       struct posix_acl *pacl =3D NULL, *dacl =3D NULL;
> > >       struct dentry *res =3D NULL;
> > > @@ -282,14 +282,19 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, st=
ruct dentry *dentry,
> > >       /* Update mode based on ACL value */
> > >       err =3D v9fs_acl_mode(dir, &mode, &dacl, &pacl);
> > >       if (err) {
> > > -             p9_debug(P9_DEBUG_VFS, "Failed to get acl values in cre=
at %d\n",
> > > +             p9_debug(P9_DEBUG_VFS, "Failed to get acl values in cre=
ate %d\n",
> > >                        err);
> > >               goto out;
> > >       }
> > > -     err =3D p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_fla=
gs(flags),
> > > -                                 mode, gid, &qid);
> > > +
> > > +     if ((v9ses->cache >=3D CACHE_WRITEBACK) && (p9_omode & P9_OWRIT=
E)) {
> > > +             p9_omode =3D (p9_omode & !P9_OWRITE) | P9_ORDWR;
> >
> > Same here.
> >
> > CJ
> >
> > > +             p9_debug(P9_DEBUG_CACHE,
> > > +                     "write-only file with writeback enabled, creati=
ng w/ O_RDWR\n");
> > > +     }
> > > +     err =3D p9_client_create_dotl(ofid, name, p9_omode, mode, gid, =
&qid);
> > >       if (err < 0) {
> > > -             p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in c=
reat %d\n",
> > > +             p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in c=
reate %d\n",
> > >                        err);
> > >               goto out;
> > >       }
> >
