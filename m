Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F512F380
	for <v9fs@lists.linux.dev>; Thu, 28 Mar 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638547; cv=none; b=hW4slINci56yGFYbwhtEG177xx8QGy/HBQp+2DG/HA2WCwvvHaoTvTZIg6v3l/826t0kkwyNbCEVzPRk4URdkwyxNgPKUQH4/jKX21t2NCtgeHFTC6kKkkr4PdH2HD+pE9BmJcjriwy9bltR0gy5BQmjVdkRckpu8SmipqtQdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638547; c=relaxed/simple;
	bh=JFfuIwTto1z7MS7nnln4LR8/+h4loFqGWiLeb37pbWk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=j7jR0JOHzZTPBSyKdE+KwJQyEkPhezOImQBAnoM1NBL1ovG7BV0x+pTqEzfxNdDU9Fg5z229UkT8eD3GtPfQz6MMYdLaB8QTxJOkxaq0P+Qbukv3Yi6hbAaYm87AFb7rCZlwIj3Q+ZH95JC6Sl5HFd9LSs3/Nt2Da3FQEmefAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDOoOqh0; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDOoOqh0"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711638541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6EXppsp0SqfXhUvwyW2Fa7seB5gsci0z6C4/wm5D4Qo=;
	b=WDOoOqh09nAZc+LV6muTk7BOHe3AGEguJ7NqQWoVumRfE945j9rZpVwthoZF1RMSFP8rpC
	hpADTtwSbDcde6QUkZXH8i6S0SyGaZB+Yb1STSqRIx0yW6ooGQTyDNli386SEr2VTp0Gtg
	Z3YIGrAC4E+jutUj4KGe2cmmeX8eXwQ=
Date: Thu, 28 Mar 2024 15:08:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <145fc52b2452095c44260825670141d0d3b42c7d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 2/4] fs/9p: drop inodes immediately on non-.L too
To: "Joakim Sindholt" <opensource@zhasha.com>, v9fs@lists.linux.dev
Cc: "Joakim Sindholt" <opensource@zhasha.com>
In-Reply-To: <20240318112542.18863-3-opensource@zhasha.com>
References: <20240318112542.18863-1-opensource@zhasha.com>
 <20240318112542.18863-3-opensource@zhasha.com>
X-Migadu-Flow: FLOW_OUT

Slowly parsing through these, thanks for the fixes.
This one has a bit of a problem in that we don't have a v9fs specific
drop_inode anymore (either in legacy or .L). The release of the fid shoul=
d=20
be=20handled by v9fs_dir_release in both versions of the protocol.=20

I=20had convinced myself we could just use generic_drop_inode because we=
=20
decoupled=20clunking fids from the dentry/inode structures and just handl=
ed
them directly in v9fs_dir_release -- so really by recovering the inode=20
structure=20every time we were just forcing churn in the inode alloc/deal=
loc
routines that seemed unnecessary (even in the uncached mode).

Was your concern the performance of the client side lookup of the inode
based on qid or the server side based on fid and can you give me a bit
more information on what you are seeing?  Are you not seeing fid clunks
for certain conditions (ie. transient fids, etc.)?

    -eric


March 18, 2024 at 6:22 AM, "Joakim Sindholt" <opensource@zhasha.com> wrot=
e:
>=20
>=20Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
>=20
>=20---
>=20
>=20 fs/9p/vfs_super.c | 1 +
>=20
>=20 1 file changed, 1 insertion(+)
>=20
>=20diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
>=20
>=20index 941f7d0e0bfa..23cc67f29af2 100644
>=20
>=20--- a/fs/9p/vfs_super.c
>=20
>=20+++ b/fs/9p/vfs_super.c
>=20
>=20@@ -310,6 +310,7 @@ static const struct super_operations v9fs_super_o=
ps =3D {
>=20
>=20 .alloc_inode =3D v9fs_alloc_inode,
>=20
>=20 .free_inode =3D v9fs_free_inode,
>=20
>=20 .statfs =3D simple_statfs,
>=20
>=20+ .drop_inode =3D v9fs_drop_inode,
>=20
>=20 .evict_inode =3D v9fs_evict_inode,
>=20
>=20 .show_options =3D v9fs_show_options,
>=20
>=20 .umount_begin =3D v9fs_umount_begin,
>=20
>=20--=20
>=20
> 2.43.2
>
