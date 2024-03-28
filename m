Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C53BBDC
	for <v9fs@lists.linux.dev>; Thu, 28 Mar 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656222; cv=none; b=ZaE2Td0wpbB95toP1EIcTX9lf9wse4Nox4Crua8DIOvTPtpMhtn59wteRZqx5CWsHOLxUedwmmPWDtX5gTCcf31V9k4Ljq91LyG+rrFrLwiscWiJF71fjA79B1QxUuLp3nZDP2qZXA1ADOz1qvwOTo2Z9aJahiVL5lVE8T2fA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656222; c=relaxed/simple;
	bh=Inx5Ha2iR3SN1u+aPKMmoVMw9cCEZiHB3zQezTO7yPg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=iwc2trymipRpV2surD2Adp0i7pPMleKsI1n9UOcBXhYgosEid6OLJt9yacZ/M1499vsxTmw5orLg0GRzQxie2D5yZVD78fBv4Lft31XaTpE27LgIf84C0KsdZSgqJ+EqaqfAawy4DaJwrkPejuKnkf05mA4LvCs6+g4jvtMf84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N1snRDzI; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N1snRDzI"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711656217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rCtnLPFuqJwMoV3P1xZL5Mbd1A7R9dCH3xTvyLj+9U=;
	b=N1snRDzI7qi0bCD2aXFRXTZGtdYy8V1WPFj2LOw2Yg7jFo7IsAitshAU26RXwV1ww8nHHi
	ga1kUi93FOwYShdaVK1fk0L8DFlFJ1lC8ZbtT0ez/iIHSCaD+YDibLpUye9d1IsbhoT0F0
	uoT4AHk+9O0dOy1cjDGP0kITYWBvVGc=
Date: Thu, 28 Mar 2024 20:03:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <4d7d7f9020fecc66d34c3b925591371e2aeac42f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 2/4] fs/9p: drop inodes immediately on non-.L too
To: "Joakim Sindholt" <opensource@zhasha.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <6a4f3bed800f9f5021e17311e6d7288f9a2b56c6@linux.dev>
References: <20240318112542.18863-1-opensource@zhasha.com>
 <20240318112542.18863-3-opensource@zhasha.com>
 <145fc52b2452095c44260825670141d0d3b42c7d@linux.dev>
 <20240328163753.eb3541f4c8595de40f5e3c82@zhasha.com>
 <6a4f3bed800f9f5021e17311e6d7288f9a2b56c6@linux.dev>
X-Migadu-Flow: FLOW_OUT

Also digging a bit deeper -- looks like for legacy we set nlink to 1 alwa=
ys.  So server doesn't have anything
to do with that, and it may be a problem in the newer code that we aren't=
 coping properly.  I guess I need to compare a legacy trace to a dotL tra=
ce and make sure that's right -- a bit worried about how directories show=
 up since they should have 3 nlinks (. and ..) and this code looks generi=
c.

     -eric


March 28, 2024 at 2:47 PM, "Eric Van Hensbergen" <eric.vanhensbergen@linu=
x.dev> wrote:
>=20
>=20Not sure if your server source is public or not, but it would be usef=
ul to test against it and see what I see. It's possible a mismatch with t=
he nlink stat information could indeed cause inodes to stick around even =
under memory pressure and that'd cause all sorts of problems.
>=20
>=20The newer kernel versions have much better qid->inode mapping stuff t=
hat should provent some of the weirdness in the implementation before (th=
ere were lots of inodes with duplicate ino_num because the way we crushed=
 the allocated inode number with the qid.path) so its definitely worth te=
sting against the latest and greatest if you can. I will try and allocate=
 some time to revive my regressions against 9p2000 and 9p2000.u servers s=
o we catch some of this earlier in the future, but I'm not sure I would h=
ave caught any degredation.
>=20
>=20 -eric
>=20
>=20March 28, 2024 at 10:37 AM, "Joakim Sindholt" <opensource@zhasha.com>=
 wrote:
>=20
>=20>=20
>=20> On Thu, 28 Mar 2024 15:08:59 +0000, "Eric Van Hensbergen" <eric.van=
hensbergen@linux.dev> wrote:
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Slowly parsing through these, thanks for the fixes.
> >=20
>=20>=20=20
>=20>=20
>=20>  This one has a bit of a problem in that we don't have a v9fs speci=
fic
> >=20
>=20>=20=20
>=20>=20
>=20>  drop_inode anymore (either in legacy or .L). The release of the fi=
d should=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  be handled by v9fs_dir_release in both versions of the protocol.
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  My apologies. I didn't realize that it had been changed in the nex=
t
> >=20
>=20>=20=20
>=20>=20
>=20>  branch until after sending it and I haven't had the time to check =
how
> >=20
>=20>=20=20
>=20>=20
>=20>  it's supposed to work now.
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  I had convinced myself we could just use generic_drop_inode becaus=
e we=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  decoupled clunking fids from the dentry/inode structures and just =
handled
> >=20
>=20>=20=20
>=20>=20
>=20>  them directly in v9fs_dir_release -- so really by recovering the i=
node=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  structure every time we were just forcing churn in the inode alloc=
/dealloc
> >=20
>=20>=20=20
>=20>=20
>=20>  routines that seemed unnecessary (even in the uncached mode).
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  I agree that the alloc followed by immediately dropping it from th=
e
> >=20
>=20>=20=20
>=20>=20
>=20>  cache is a waste of cycles. This was just the most reliable way I =
knew
> >=20
>=20>=20=20
>=20>=20
>=20>  of fixing it without impacting anything else.
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Was your concern the performance of the client side lookup of the =
inode
> >=20
>=20>=20=20
>=20>=20
>=20>  based on qid or the server side based on fid and can you give me a=
 bit
> >=20
>=20>=20=20
>=20>=20
>=20>  more information on what you are seeing? Are you not seeing fid cl=
unks
> >=20
>=20>=20=20
>=20>=20
>=20>  for certain conditions (ie. transient fids, etc.)?
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  This is what I'm seeing in slabtop on a system with no caching ena=
bled
> >=20
>=20>=20=20
>=20>=20
>=20>  on a 6.1 kernel. I never tested if it persisted on the 6.6 kernel =
but I
> >=20
>=20>=20=20
>=20>=20
>=20>  assume it would.
> >=20
>=20>=20=20
>=20>=20
>=20>  Active / Total Objects (% used) : 2738808 / 2788118 (98.2%)
> >=20
>=20>=20=20
>=20>=20
>=20>  Active / Total Slabs (% used) : 89853 / 89853 (100.0%)
> >=20
>=20>=20=20
>=20>=20
>=20>  Active / Total Caches (% used) : 164 / 261 (62.8%)
> >=20
>=20>=20=20
>=20>=20
>=20>  Active / Total Size (% used) : 1071558.97K / 1084648.27K (98.8%)
> >=20
>=20>=20=20
>=20>=20
>=20>  Minimum / Average / Maximum Object : 0.02K / 0.39K / 16.01K
> >=20
>=20>=20=20
>=20>=20
>=20>  OBJS ACTIVE USE OBJ SIZE SLABS OBJ/SLAB CACHE SIZE NAME
> >=20
>=20>=20=20
>=20>=20
>=20>  1235968 1235915 99% 0.06K 19312 64 77248K lsm_inode_cache
> >=20
>=20>=20=20
>=20>=20
>=20>  1200339 1200339 100% 0.75K 57159 21 914544K v9fs_inode_cache
> >=20
>=20>=20=20
>=20>=20
>=20>  62136 54815 88% 0.11K 1726 36 6904K buffer_head
> >=20
>=20>=20=20
>=20>=20
>=20>  49400 45639 92% 0.20K 2600 19 10400K dentry
> >=20
>=20>=20=20
>=20>=20
>=20>  26368 26364 99% 0.03K 206 128 824K avtab_node
> >=20
>=20>=20=20
>=20>=20
>=20>  26222 15713 59% 0.57K 1873 14 14984K radix_tree_node
> >=20
>=20>=20=20
>=20>=20
>=20>  19162 18337 95% 1.20K 1474 13 23584K ext4_inode_cache
> >=20
>=20>=20=20
>=20>=20
>=20>  ...
> >=20
>=20>=20=20
>=20>=20
>=20>  What this is not showing, and it's really rather difficult to show=
, is
> >=20
>=20>=20=20
>=20>=20
>=20>  that it also causes a large amount of CPU usage on any file operat=
ions.
> >=20
>=20>=20=20
>=20>=20
>=20>  I'm not sure if it's simply because the table is enormous or if it=
's
> >=20
>=20>=20=20
>=20>=20
>=20>  because most of the qids v9fs gets to contend with are identical o=
nes
> >=20
>=20>=20=20
>=20>=20
>=20>  from a whole host of synthetic file systems that it then has to it=
erate
> >=20
>=20>=20=20
>=20>=20
>=20>  over linearly.
> >=20
>=20>=20=20
>=20>=20
>=20>  The v9fs_inode_cache grows until it takes up all available RAM.
> >=20
>=20>=20=20
>=20>=20
>=20>  And snatching this one from your second mail:
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Which server are you testing against? I'm wondering if the underly=
ing problem
> >=20
>=20>=20=20
>=20>=20
>=20>  might actually be i_nlink being maintained incorrectly by the serv=
er which would
> >=20
>=20>=20=20
>=20>=20
>=20>  lead to inodes lingering since that is the primary way the generic=
_inode_drop
> >=20
>=20>=20=20
>=20>=20
>=20>  differentiates. It is possible that we could could add an v9fs_ino=
de_always_drop
> >=20
>=20>=20=20
>=20>=20
>=20>  in for legacy if the servers weren't reporting i_nlink a compatibl=
e fashion
> >=20
>=20>=20=20
>=20>=20
>=20>  although that might result in never caching legacy 9p2000 (which i=
s probably
> >=20
>=20>=20=20
>=20>=20
>=20>  what most legacy folks want anyways).
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  I'm running against a regular old 9P2000 server that I wrote mysel=
f. No
> >=20
>=20>=20=20
>=20>=20
>=20>  extensions of any kind, so there are no links. I don't really have=
 any
> >=20
>=20>=20=20
>=20>=20
>=20>  objection to the kind of qid.version contextual you implemented in=
 6.6
> >=20
>=20>=20=20
>=20>=20
>=20>  and would actually quite like to use it in the near future, but I
> >=20
>=20>=20=20
>=20>=20
>=20>  wouldn't be terribly sad if you removed it either.
> >
>
