Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2ED288DB
	for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514826; cv=none; b=sCrKcWijxITnqZJM79Lsb9QHPlx0ChW5xvgHOHXw7QBjSFh9RBTFVB7b7kMZkQocOL1putahoz9BzwmNQSrOjDPz5sXtazUnYSkBFAcYexGt75739gkl/Z+uCgc4ZbAoVFvB5eb4jOE7VOyQTCVy0tqv5dTQqyEuS9cxZ0XBaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514826; c=relaxed/simple;
	bh=U/t5JdSj1At5NyGpm1NteCiuKbxvHb34wkUCXrXTB0Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Dw7Igqw8MLCATMKTAu8b0ux7AVfPBCtoWbygcOK7Zi2ZPo2w6YUVc5RdGW5cPbgxXbAp+cC3TxjODL4hfOSi+Xq46gvVyhUVsRtZxJqSpYFyGTM+QAJp1UATnHLinBMuM3w7m07Sw7zMn/+8xu+lOxITxOwRBP21eoTMhOCSRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=XAYalJjf; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="XAYalJjf"
Received: from eclair (unknown [77.72.50.149])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 94A3D325384
	for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 16:00:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1710514819;
	bh=r3v10BIBZ3mmuS7/Ve2m/PKl2dhu67IxrlFhRJSL8PE=;
	h=Date:From:To:Subject;
	b=XAYalJjfs0v/NTVlCHCJzW+UQBfwWJw40cODfCHx1HxyEnezcwjlgf88+okbk9j1Y
	 qGka42PV44myi1VqGTttPxQhhIRnb/ro+QcKeU92yTTCZ/t/nEanbU80ZoRLPl0bV4
	 FpVZuauaZxRddnTOf4/qAV60AXY8B5AlE2ynH+B8=
Date: Fri, 15 Mar 2024 16:00:19 +0100
From: Joakim Sindholt <opensource@zhasha.com>
To: v9fs@lists.linux.dev
Subject: [PATCH 3/4] fs/9p: translate O_TRUNC into OTRUNC
Message-ID: <20240315160019.2c273cd4@eclair>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-gentoo-linux-musl)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This one hits both 9P2000 and .u as it appears v9fs has never translated
the O_TRUNC flag.

=46rom 108c0a96284563812dcb701f52bc5ef554f281fc Mon Sep 17 00:00:00 2001
From: Joakim Sindholt <opensource@zhasha.com>
Date: Fri, 15 Mar 2024 15:18:09 +0100
Subject: [PATCH 3/4] fs/9p: translate O_TRUNC into OTRUNC

---
 fs/9p/vfs_inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 1180d1453a5a..8f2e0fcfb303 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -178,6 +178,9 @@ int v9fs_uflags2omode(int uflags, int extended)
 		break;
 	}
=20
+	if (uflags & O_TRUNC)
+		ret |=3D P9_OTRUNC;
+
 	if (extended) {
 		if (uflags & O_EXCL)
 			ret |=3D P9_OEXCL;
--=20
2.43.2

