Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2C18EA8
	for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515256; cv=none; b=PE4dpBsLjqNoS2bIjUdHgw4f8W9A+pKnEpjQxrlJBHDQMYd9e/7eC3NSreVN7SiM0xubfAwKbIZnp5k5zhu3MQGgYcQbgh4iEfrV72Ml7V0pmWSEf1SucD8JcUSSWW0s/qh+O8IzO+NkI1pGEReYcKQkRjqgZyR6ibrEY7t8YPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515256; c=relaxed/simple;
	bh=xAlwaMTLrAqn5JDuJUjWSgUI3T8P5MmTp9lu8Qes24A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=VmJZLzK1ETuYLd/J2OPPZBGHhR5+JIgvHsxTbzkZiJUhIfoBHtnNcFImGt5eN68Hnkbj7YlGBYWLmzyXczwhiJ92kwJVAezdg2TzzUgST5Ns1cc3Rb5LOHt/mKA8G4jLmRkmHDR5D0+64HpcieyQ9DhdShvO6zxRI81Pczn4IoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=w3e9H2gB; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="w3e9H2gB"
Received: from eclair (unknown [77.72.50.149])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 6173E325384
	for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 16:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1710515249;
	bh=uHAg2i8BiREE1/hVf6UEHSVHbuy7lJ15VwnJzCn/EII=;
	h=Date:From:To:Subject;
	b=w3e9H2gB6rZKTaIh9y6eRKG48qNTdOqsux+Ful28sOvc3f3UoqWAVRtg+j34Y7Bit
	 5h1BrntvRrXHShIG/DFHYU641LuAJhFPl60jbzrZ0lVTY++1muEkW9nKAoEG0u2bI3
	 Pnvq/GdIuWsDMTyv66bx81To5n5+ZZTNLHFcW168=
Date: Fri, 15 Mar 2024 16:07:28 +0100
From: Joakim Sindholt <opensource@zhasha.com>
To: v9fs@lists.linux.dev
Subject: [PATCH 4/4] fs/9p: fix the cache always being enabled on files with
 qid flags
Message-ID: <20240315160728.647c299b@eclair>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-gentoo-linux-musl)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I'm not sure why this check was ever here. After updating to 6.6 I
suddenly found caching had been turned on by default and neither
cache=3Dnone nor the new directio would turn it off. After walking through
the new code very manually I realized that it's because the caching has
to be, in effect, turned off explicitly by setting P9L_DIRECT and
whenever a file has a flag, in my case QTAPPEND, it doesn't get set.

#define QTDIR       0x80
#define QTAPPEND    0x40
#define QTEXCL      0x20
#define QTAUTH      0x08
#define QTTMP       0x04
#define QTFILE      0x00

Setting aside QTDIR which seems to ignore the new fid->mode entirely,
the rest of these either should be subject to the same cache rules as
every other QTFILE or perhaps very explicitly not cached in the case of
QTAUTH.

=46rom 7ee510d31c0b6074dbd8bc27c1fb86f12270f851 Mon Sep 17 00:00:00 2001
From: Joakim Sindholt <opensource@zhasha.com>
Date: Fri, 15 Mar 2024 15:19:10 +0100
Subject: [PATCH 4/4] fs/9p: fix the cache always being enabled on files with
 qid flags

---
 fs/9p/fid.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 29281b7c3887..0d6138bee2a3 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -49,9 +49,6 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry=
 *dentry)
 static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_f=
lags,
 	unsigned int s_cache, unsigned int f_flags)
 {
-	if (fid->qid.type !=3D P9_QTFILE)
-		return;
-
 	if ((!s_cache) ||
 	   ((fid->qid.version =3D=3D 0) && !(s_flags & V9FS_IGNORE_QV)) ||
 	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
--=20
2.43.2

