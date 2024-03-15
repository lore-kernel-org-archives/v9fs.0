Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006C3BB32
	for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514657; cv=none; b=DSIu2J7grMtHET9ktCtwEirr91za/fJDYwE09xidcU0pYHbT41GrodwydItBR1lnzvptl0TVpyVuiLWmF40S2+pj5lEDxEHfWSxe+M9Ouj75dIpD11gWLKZeIxZWUjiFMsSjC7X+6v1A5z73cU2MwVyFofoKBxrb0fe4+s9o45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514657; c=relaxed/simple;
	bh=nEVu7fuCd0Axxn/NgWSBiIiasktgmSEMoWeTjYO3hW0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=m5v4P0bc4/rTUUq5BD84EKVHsus/zldIaVEweYexNh6f0Q+LBbqcJ4iINGRuJYW8pEVFLoOKbT6qyV0gCU9QJOSIWpyZVEuMQjuE4RTbWEnWKaVPI3KnXmkFlxxmDX+5iiHche6W/3kYx57oqSgSCZb4xOXa502PT+YmCWQKotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=b0r8S5ma; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="b0r8S5ma"
Received: from eclair (unknown [77.72.50.149])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 41D86325384
	for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 15:57:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1710514653;
	bh=ululPH4EOvh4Rs+hKocpC1akmNCQtsJPs78WVZwWFeI=;
	h=Date:From:To:Subject;
	b=b0r8S5maNlFTvvmMD9X7WRYEa4IxQP1AqWgYhsgYpfPLZybvlS3BHGdW69nCi+SyP
	 saX+IBP2nYzpsePWWXoqF5rF6IShY3LIXa8Z2EkjaXxG3TFbkYGmGbb6wazzaugPkz
	 PGMb4YE3c5EqEoN4kh4HZDNxv9BeD33dE4YCGPFk=
Date: Fri, 15 Mar 2024 15:57:32 +0100
From: Joakim Sindholt <opensource@zhasha.com>
To: v9fs@lists.linux.dev
Subject: [PATCH 2/4] fs/9p: drop inodes immediately on non-.L too
Message-ID: <20240315155732.77dabf51@eclair>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-gentoo-linux-musl)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I assume this was an oversight but non-.L v9fs doesn't currently have
the drop_inode callback declared. This causes effectively unbounded
growth of the inode table and after a good while it becomes enormously
expensive to look through all the qid matches.

=46rom e47d28e0fdc42819e7d7ce9d5e7f5bc8f189aee1 Mon Sep 17 00:00:00 2001
From: Joakim Sindholt <opensource@zhasha.com>
Date: Fri, 15 Mar 2024 15:13:48 +0100
Subject: [PATCH 2/4] fs/9p: drop inodes immediately on non-.L too

---
 fs/9p/vfs_super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 941f7d0e0bfa..23cc67f29af2 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -310,6 +310,7 @@ static const struct super_operations v9fs_super_ops =3D=
 {
 	.alloc_inode =3D v9fs_alloc_inode,
 	.free_inode =3D v9fs_free_inode,
 	.statfs =3D simple_statfs,
+	.drop_inode =3D v9fs_drop_inode,
 	.evict_inode =3D v9fs_evict_inode,
 	.show_options =3D v9fs_show_options,
 	.umount_begin =3D v9fs_umount_begin,
--=20
2.43.2

