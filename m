Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407476FB2
	for <v9fs@lists.linux.dev>; Thu, 28 Dec 2023 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="uxVCRbi1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=hqS9vlxW74O/uIbQi7arUTrVlW5XWZojteCUdw052cg=; b=uxVCRbi1ZL23U5H1/xOMjI9b3f
	JPgVWglffoDQ88AHCSgm8ID0Si04vo8r5DMduwqIPw/1LOA7D0CA0SeArMkN5s2pGloqHyey7nZfS
	ONrRlkYC58l3J09B6LcKOnelUt6CL6Kso69Ud8dBB91/daF7DQdqW8vdfuQzTkr8djKoniPzoOheW
	fdW5rWVxdCGhSiDBf73oetN63hX1DSuHiIYBDiRsZYPlTETIv8WTgeQoEAipB1dPB8emHdn7yIVw3
	FAFYO5hUx8S0JfjKRf4KQjDUCrhG2wZ9jbnfArtY0SB7nf+ODb45YW0hJFVAjxB8hfix2fZA1v01S
	JaZv1MFIATLQFyo+fM3yY0vC7FXrNAFM8qQg5lMfj55kJlDJ/sWgrycfugLgn+HjWDPLiiORm7efp
	80gXP4722RWhb7mNQi8N1MS6cVujcik0JuKwJLgoIF4+gwvymE6fUnEB/3iyr0CRYMKb4iAMLP4s2
	R1RJ5jJTh6pNC3DbvUIG6uEbPH5n5WH0qqBzxQGnOPlWAiiS+VJUMId7WY7ozfdiUkqk9ioAefgxx
	ao8hZXx8m+AUFY2JtLiVM+2CaNjf85V1oE0fN+Fd/+WbqxmfoAqqhtJketfIiyyreIC8obEKqbh0E
	uywTCnaIeCjR3A3hd9bKP4uTovCMCoogXTUSHXakE=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, Greg Kurz <groug@kaod.org>
Subject: Re: cache fixes (redux)
Date: Thu, 28 Dec 2023 11:44:32 +0100
Message-ID: <3936280.6WX1Z9CqS8@silver>
In-Reply-To: <ZYzCERk_dg1-CEjb@codewreck.org>
References:
 <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <CAFkjPT=8CZHATaraBrqAZGDKjQLOp=U1gdgteJ5jpXRGJyBojQ@mail.gmail.com>
 <ZYzCERk_dg1-CEjb@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, December 28, 2023 1:32:17 AM CET Dominique Martinet wrote:
> Eric Van Hensbergen wrote on Wed, Dec 27, 2023 at 11:39:19AM -0600:
> > On Wed, Dec 27, 2023 at 2:11=E2=80=AFAM Dominique Martinet <asmadeus@co=
dewreck.org>
> > wrote:
> > > I'm not sure multi-walk is possible in practice: even opening a file
> > > directly through e.g. cat /mnt/long/path/to/file will have the VFS ch=
eck
> > > permissions along the path, so the VFS will need to stat all elements
> > > along the way.
> >=20
> > Well, the server will do perm checks (ideally on walks), so do we really
> > have to?  Feels like overkill to check in both places, in principal we
> > expect/assume server perm checks.
>=20
> The server should definitely check as well, yes.
> I'm not sure it's possible to tell the linux VFS that the server already
> checked though; ultimately the plan back when I was working on 9p for my
> previous job was to plug in MPI-IO into a user-space client library
> (e.g. https://github.com/martinetd/space9 -- now unmaintained) so we
> wouldn't have to deal with the vfs...
>=20
> But once again, if you can manage to tell it that, I'm all for it. Some
> servers might not check properly but that can/should be fixed when it
> comes up.

I would rather see this as a brave kernel option for people who really know
what they are doing, not as a potential default behaviour.

With QEMU there are two distinct behaviours: 'passthrough' permissions vs.
'mapped(-*)' permissions:

  https://wiki.qemu.org/Documentation/9psetup#Starting_the_Guest_directly

Where 'passthrough' means guest sees the exact same permissions for files as
host (9p server) does. In this mode you could probably leave it to server
doing the permission checks. However 'passthrough' mode is discouraged for
security reasons, and one of the 'mapped' permissions modes is recommended
instead, because we had several security issues in the past which showed th=
at
it's not a good idea using 'passthrough' (whereas 'mapped' was unaffected).

With 'mapped-(*)' however guest should do permissions checks. Because in th=
is
mode file permissions on host are different and separately handled between
host and guest. So host sees something else than guest does.

> > it did strike me that inodes are only unique per filesystem and I doubt=
 the
> > servers guarantee uniqueness across underlying mounts - but in principa=
l we
> > shouldnt have to rely on looking up inodes by qid.path anyways=E2=80=A6=
=2Ehowever
> > nothing I=E2=80=99m planning on should make this worse, but something t=
o keep an
> > eye out for.
>=20
> We've had collisions a few times -- most "real" file systems I'm aware
> of pseudo-randomize inode generation but in particular tmpfs inode
> numbering is linear per mount so it's very easy to trigger collisions.
>=20
> qemu mixes in some bits from st_dev to avoid this:
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/9pfs/9p.c?ref_type=
=3Dheads#L881

Inode numbers are always just unique within the same file system. And that
makes sense. If a unique file ID is required system wide, then inode number
must be combined with the file system's device ID.

And yes, that's what QEMU does (combining inode # with device ID) when opti=
on
`multidevs=3Dremap` was supplied when generating qid.path to avoid file ID
collisions on guest. Unfortunately qid.path field is currently too small to
just use the device ID directly, so a little trick is used: the so called
'Exponential Golomb' algorithm is used to generate a much shorter device ID
that can be put into qid.path instead.

Note though, this behaviour is actually off by default ATM, controllable by:

 multidevs=3Dremap|forbid|warn

 https://wiki.qemu.org/Documentation/9psetup#Starting_the_Guest_directly

By default (multidevs=3Dwarn) QEMU would currently only print/log a warning:

  warn_report_once(
    "9p: Multiple devices detected in same VirtFS export, "
    "which might lead to file ID collisions and severe "
    "misbehaviours on guest! You should either use a "
    "separate export for each device shared from host or "
    "use virtfs option 'multidevs=3Dremap'!"
  );

> > > >      - QUESTION: it seems like P9_QTLINK and P9_QTSYMLINK are no
> > > > longer used, can these be recovered?  I was thinking of reusing one=
 of
> > > > these to mark unlinked files which we could do a more comprehensive
> > > > compare for if its actually necessary.
> > >
> > > Since we don't support reconnects, unlinked files have been working j=
ust
> > > fine with servers that keep the underlying files open (e.g. qemu)
> > >
> > > What's your plan exactly?
> >=20
> >=20
> > See above, mark fid/qids that are unlinked with a different type I thin=
k.
> > I=E2=80=99m gonna look at how other filesystems handle this case before=
 doing
> > anything.
>=20
> local filesystems don't do anything - the inode is just kept around, all
> the way down to disk afaik (disk-mapped tmpfiles flush data to disk so
> there must be some way to address them...)
> (The last iput with nlink=3D=3D0 calls evict_inode which does required
> cleanup)
>=20
>=20
> NFS doesn't delete the backing file but renames it - silly renames -
> you've probably seen some .nfs1234 files around if you used a mount
> point, the client won't let you delete them while it's open:
> rm: cannot remove '.nfs000000000000f42300000001': Device or resource busy
>=20
> And it's unlinked when file is closed (DCACHE_NFSFS_RENAMED check in
> nfs_dentry_iput). That's necessary because the connexion to the server
> can drop at any time, and reconnecting needs to be able to open the
> file again.
> Servers will also scrub these files after they're been unused for a
> while.
>=20
>=20
> For 9p since we don't handle reconnect I think we're fine just not doing
> anything -- servers that don't close backing files will de facto keep
> the file existing through their fd. There's a process with the file open
> so we have an open fid somewhere and the inode won't get killed either.
> When the last fd is closed the inode is evicted and we'll have all fids
> closed so server will release its fd as well and backing filesystem will
> cleanup appropriately.
>=20
> If we want to handle reconnect at some point (CEA/Bull did that work but
> never tried to publish it...), then we ought to do silly renames as
> well, but servers really need background cleanup as well or it'll end
> up full of .nfsxxx files...
>=20
>=20
> > > We don't have any way of driving protocol changes forward (and there's
> > > no compatibility negotiation on client connect...), but I recall
> > > Christian also was looking forward to some other changes so we might
> > > want to try to move this forward again...
> > >
> >=20
> > Well, those bits unused (I think) so shouldnt be protocol change.
>=20
> Right, I didn't realize it was just local use -- we can do whatever we
> want in memory yes.
> I'd avoid reusing the bits and define some new ones at the end of the
> permissible range to make the "can come from server" and "client mess"
> separation but leaving this up to you -- ultimately as long as there's
> no conflict with what's on wire we should be fine.
>=20
> > However we can bump to
> > new protocol when necessary (9p2023?  its been 23 years, why not?). big=
 on
> > my list would be qid.path -> 128 bit and qid.version -> 128 bit and may=
be
> > include filesystem uid in qid to differentiate underlying mounts and ma=
ybe
> > i_generation.  This would help with cache maintenance and uniqueness
> > concerns.  I=E2=80=99m also thinking of how we might handle security di=
fferently
> > (use kernel TLS, public key auth integration, etc. although those might=
 not
> > require protocol changes).  i=E2=80=99m also in favor of dirread senant=
ics for
> > cache modes so we retrieve attributes with the file list.  What other
> > things should we be considering?  maybe time to start putting together =
an
> > RFC.
>=20
> Right; there's plenty to improve if we start...
> My free time is basically rock bottom as it has been for a few years so
> I probably won't help much, but I wouldn't push back.

I use to gather ideas for 9p protocol changes here:
https://wiki.qemu.org/Documentation/9p#Protocol_Plans

One thing that comes to my mind that's not yet on that list: server side pu=
sh
notifications, e.g. to inform guest that something changed on a file/dir gu=
est
currently keeps open. That might improve consistency when both on host and
guest changes are made and caching being used by guest.

/Christian


