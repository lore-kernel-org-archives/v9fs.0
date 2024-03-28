Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696E127B67
	for <v9fs@lists.linux.dev>; Thu, 28 Mar 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639030; cv=none; b=F2l1XRpM69bAFqtE2RIgPXE11TLUQHEMRQsPKtO49q38wdz4ZeCnqpcfBRlipPEIouYy0HMLabztS5VEGXgFPEVrMlhuqjUqlMvbn5Rk/2hw+DPW3cK8c+RMx7Cg5bAt35O53B2aBpXtfWgBVFEwHFZEyps/DBpswUc7tHVn+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639030; c=relaxed/simple;
	bh=QQjLBj2C0qQKA5i/iZiQq6ajP7ELeJUF6DhYJP7iQjY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=FmDZxXx2Tqxrb73tEv3Z7dr3ARck1xDw1Lmg4oyN06JRFOFo9xkqVd+mGf8zoGPBlw0/T2Nhhtw5Cx/5JPgPx6J9FeZNvH6LaawFA/l/9HRjjALgqizkbhjIUOjpsP2IisRnyfE3QTV0g+EszInCIvARqo9+8WHJ00w5MD15gFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NifsqhM1; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NifsqhM1"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711639025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXggh5/kcSlBOy0okYkks8aUrI4wvQzi55n43pRbQZ8=;
	b=NifsqhM1EO47z3laL4aEGqv9Fw+ya9JMSFaky+AvWGR46nFaSjmJEpLeO44++lqLLVHHQu
	PTfcN49fbyxO62MB3pREkLG+4nC65hifJ+ooMceTDKFX8Sr+i2i5zKB528ofJh5ZV3AVyM
	M8hiXQGSCOG7IPYlL/upeqtJX9PYLvI=
Date: Thu, 28 Mar 2024 15:17:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <a0261e53e93304837656bd8b7d7817b10e299b97@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 2/4] fs/9p: drop inodes immediately on non-.L too
To: "Joakim Sindholt" <opensource@zhasha.com>, v9fs@lists.linux.dev
Cc: "Joakim Sindholt" <opensource@zhasha.com>
In-Reply-To: <145fc52b2452095c44260825670141d0d3b42c7d@linux.dev>
References: <20240318112542.18863-1-opensource@zhasha.com>
 <20240318112542.18863-3-opensource@zhasha.com>
 <145fc52b2452095c44260825670141d0d3b42c7d@linux.dev>
X-Migadu-Flow: FLOW_OUT

Which server are you testing against?  I'm wondering if the underlying pr=
oblem
might actually be i_nlink being maintained incorrectly by the server whic=
h would
lead to inodes lingering since that is the primary way the generic_inode_=
drop
differentiates.  It is possible that we could could add an v9fs_inode_alw=
ays_drop
in for legacy if the servers weren't reporting i_nlink a compatible fashi=
on
although that might result in never caching legacy 9p2000 (which is proba=
bly
what most legacy folks want anyways).

    -eric
=20

March=2028, 2024 at 10:08 AM, "Eric Van Hensbergen" <eric.vanhensbergen@l=
inux.dev> wrote:
>=20
>=20Slowly parsing through these, thanks for the fixes.
>=20
>=20This one has a bit of a problem in that we don't have a v9fs specific
>=20
>=20drop_inode anymore (either in legacy or .L). The release of the fid s=
hould=20
>=20
> be handled by v9fs_dir_release in both versions of the protocol.=20
>=20
> I had convinced myself we could just use generic_drop_inode because we=
=20
>=20
> decoupled clunking fids from the dentry/inode structures and just handl=
ed
>=20
>=20them directly in v9fs_dir_release -- so really by recovering the inod=
e=20
>=20
> structure every time we were just forcing churn in the inode alloc/deal=
loc
>=20
>=20routines that seemed unnecessary (even in the uncached mode).
>=20
>=20Was your concern the performance of the client side lookup of the ino=
de
>=20
>=20based on qid or the server side based on fid and can you give me a bi=
t
>=20
>=20more information on what you are seeing? Are you not seeing fid clunk=
s
>=20
>=20for certain conditions (ie. transient fids, etc.)?
>=20
>=20 -eric
>=20
>=20March 18, 2024 at 6:22 AM, "Joakim Sindholt" <opensource@zhasha.com> =
wrote:
>=20
>=20>=20
>=20> Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
> >=20
>=20>=20=20
>=20>=20
>=20>  ---
> >=20
>=20>=20=20
>=20>=20
>=20>  fs/9p/vfs_super.c | 1 +
> >=20
>=20>=20=20
>=20>=20
>=20>  1 file changed, 1 insertion(+)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> >=20
>=20>=20=20
>=20>=20
>=20>  index 941f7d0e0bfa..23cc67f29af2 100644
> >=20
>=20>=20=20
>=20>=20
>=20>  --- a/fs/9p/vfs_super.c
> >=20
>=20>=20=20
>=20>=20
>=20>  +++ b/fs/9p/vfs_super.c
> >=20
>=20>=20=20
>=20>=20
>=20>  @@ -310,6 +310,7 @@ static const struct super_operations v9fs_supe=
r_ops =3D {
> >=20
>=20>=20=20
>=20>=20
>=20>  .alloc_inode =3D v9fs_alloc_inode,
> >=20
>=20>=20=20
>=20>=20
>=20>  .free_inode =3D v9fs_free_inode,
> >=20
>=20>=20=20
>=20>=20
>=20>  .statfs =3D simple_statfs,
> >=20
>=20>=20=20
>=20>=20
>=20>  + .drop_inode =3D v9fs_drop_inode,
> >=20
>=20>=20=20
>=20>=20
>=20>  .evict_inode =3D v9fs_evict_inode,
> >=20
>=20>=20=20
>=20>=20
>=20>  .show_options =3D v9fs_show_options,
> >=20
>=20>=20=20
>=20>=20
>=20>  .umount_begin =3D v9fs_umount_begin,
> >=20
>=20>=20=20
>=20>=20
>=20>  --=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  2.43.2
> >
>
