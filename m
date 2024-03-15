Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70193381B4
	for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514420; cv=none; b=Bz+Zg/OhqIxyrwYkHGNuGqvIa4iW6G5wTQTJHzcvJrhzNzmYUCIfOTHOshmrN/nRLKPzQQxI1dEaFaOtwiP8i46htKapd6BYojr7NBeyylCN1WC/fW79dceDa+j3fOv6eLi5b1O6r6vKS4+iMwQmV604dsUWiIfXbW5GbdTp4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514420; c=relaxed/simple;
	bh=52zKLsKuVu414HKsZvISZAM9V23SW81LDNg1enp36JE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=TjEFJrrVFRxJljfi7/rqMW6qveM0Xzoo8dZqGAS6YanRdQbboB0Z8wFRSB6oJJcySov7ZQ4WbQuzECJ0ZrkjQfJT85mAe0U6Rd7aBQceHR+VfyaQui8OO+eplphD/jfwulWC12lFyhZxQxOR2rHSn8ms93KsSMyou5iz+NK1eSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=YTOxGd6r; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="YTOxGd6r"
Received: from eclair (unknown [77.72.50.149])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id E8F98325384
	for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 15:53:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1710514410;
	bh=HLfjg/xUXZQJ+v1yTRbhMuPDMEHqOkYEgSuRM91LW+U=;
	h=Date:From:To:Subject;
	b=YTOxGd6rs3wuEc2KcOWNCAb2GIXNCH3X8AdDrGR+pmQs1AkEAXY4nMaY8lmqT/NSW
	 lpo2Te0lJ53kKPN8QrN7YxL7GCleugCIXIyKcTjbBZFRZZeIQ86iq/F17gGH0MBv2o
	 mhGEk8BOLYvJcKuVhxTwSD3rrcAnaVdI/zmno90U=
Date: Fri, 15 Mar 2024 15:53:29 +0100
From: Joakim Sindholt <opensource@zhasha.com>
To: v9fs@lists.linux.dev
Subject: [PATCH 1/4] fs/9p: only translate RWX permissions for plain 9P2000
Message-ID: <20240315155329.61e33be0@eclair>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-gentoo-linux-musl)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Garbage in plain 9P2000's perm bits is allowed through, which causes it
to be able to set (among others) the suid bit. This was presumably not
the intent since the unix extended bits are handled explicitly and
conditionally on .u.

=46rom 2d9f6cc6b3163d4991aaa6d799c554edd07a6c0a Mon Sep 17 00:00:00 2001
From: Joakim Sindholt <opensource@zhasha.com>
Date: Fri, 15 Mar 2024 15:13:21 +0100
Subject: [PATCH 1/4] fs/9p: only translate RWX permissions for plain 9P2000

---
 fs/9p/vfs_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 32572982f72e..1180d1453a5a 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -83,7 +83,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode =3D stat->mode;
=20
-	res =3D mode & S_IALLUGO;
+	res =3D mode & S_IRWXUGO;
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) =3D=3D P9_DMSETUID)
 			res |=3D S_ISUID;
--=20
2.43.2

