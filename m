Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051272003AF
	for <v9fs@lists.linux.dev>; Wed, 23 Oct 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727547; cv=none; b=V/tha7CoiPto/ANp3WGwLj6cemiCqzrYW5ogsDpmQWiLaNaoIZjmZmNaCvK+qKeaOZI2npSXvEShTE8/mdpseQBdHCtFwHO/h3d7qshPSMZ75wcCYNFGoseWV4o4j1heKzS5eIQWfxvp9m/9dfT1QOghg8J6PD+tWG/+R2bbHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727547; c=relaxed/simple;
	bh=1a/Bd6MVgtny3x6qYfGD1H0MSVQ/x7ApD2BNdRoVBjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqFvFNvjCREfAP5txJb6MQluGMTgbx7AZiLba7geRL1DtgL3YHTT3CiLH53jNcMwsFtEt4RfB4LIZS4Upol+b+1auN20hzN81J7lw6Oo/UctVkCb2UGdaDBy1hPTfs5HM2q0AZKt+jy+bhTZddP8tTobPBqI9thA6xqX0Pz/Fn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=aNmWzHQp; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="aNmWzHQp"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 95AF214C2DF;
	Thu, 24 Oct 2024 01:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729727545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCSeVIizETL3AZftJfJ4jkpxwztAnC+IPubkBSbvaD0=;
	b=aNmWzHQpdqtaCpcPJ+Bo19UVr2Q73v1wQYWATcRXp0mh23C6dPqhdUFl8VTWovTEX0KzqI
	uv3d1ofEX1WVggbsw4VaTL/Aa433qLOJSKeIXXj0Sifp/O9cYUkO5oua6sfLqCx+MGTNwK
	L72BRY8gYnX/Oo5Hfh7e0E/rLByTOc/PIZdEAtHtCM80HWmEodQsmc8Bho+xaxppHdxIcD
	t2yqZXgaHmnJKepP+B08wI9cKVuGoYWsflJo+kgmZCwoLFFHKPnaaDkaO+wzWAPkezqIf5
	Zf6+MXnVHDk2osRJndOFYMWKCOHH41maVLhBjnbyokCAA8l+NiFsYzqpuGBx5w==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 129c9a46;
	Wed, 23 Oct 2024 23:52:14 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Thu, 24 Oct 2024 08:52:12 +0900
Subject: [PATCH 3/4] Revert "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-revert_iget-v1-3-4cac63d25f72@codewreck.org>
References: <20241024-revert_iget-v1-0-4cac63d25f72@codewreck.org>
In-Reply-To: <20241024-revert_iget-v1-0-4cac63d25f72@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>, Will Deacon <will@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=1a/Bd6MVgtny3x6qYfGD1H0MSVQ/x7ApD2BNdRoVBjY=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBnGYwuBF/ECwjzn/a5TaI2xjpsECqsuVnI9ymMv
 yXRWunPSeeJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZxmMLgAKCRCrTpvsapjm
 cFzPD/4/lWbe3id79E4xDe688DeGhvsWIY9ghzSh2A5Ski6zbjtXFQk7dVIxnMupZOKIC0XYXl6
 0V/uzW/fpcpif7PNkS8iVt6VAFzNpZN5/Pw+X/SwQU/r0WZElhXQr/oF7z42WlHv9+PHEZEfgmq
 4EJeYJ+gBVAZF+CKyCte7hTY4dWkBe/JQ+rMxDp4tbNZG9qITxDVC8b9CVJKe3hhHWDveaYv0lW
 BoDRA8t+yN/EgL2bG3mC/YJz8iZ3BJUXARtmiVNddP2GBMTpQitSpt6y4QwcL/HJHXWNs1AAa65
 Q1tMZs45n2aR+RgM26m2Yjh50xwPMk/9ir1wXVcfo3Gfyi6Te8wXzkDFrQO35Gvs5uoKWsvpZ3h
 HibBBoeScRMn90UkwYKbHKlBqY0jyW3MUM1d2msAu/HCMPLBsixotP3UpsY883xvIPOexQTKzax
 BGgJFzR0a2yKA0hs+JyJA5cwrG8wxxAG9jZUP5JPgbvhl3CgfLe7F4oLzRPfJhpFv/4DNZZvubM
 vsQLyz5JTtVGSexKifx5QbKjqPyj36lm1bA/59LyOGOitbvXKP5P/1RLi+VZt4br/jPXiEFZqAe
 Mxx4TRSxypxZ7U/Jym9nV0MOMZw3jaBrPKjCeSZxLpEmXv5hXoCIOwSTb4HxH/wblpmnUIJO0S0
 pg5wa8iVEJr3dhg==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

This reverts commit 11763a8598f888dec631a8a903f7ada32181001f.

This is a requirement to revert commit 724a08450f74 ("fs/9p: simplify
iget to remove unnecessary paths"), see that revert for details.

Fixes: 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")
Reported-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20240923100508.GA32066@willie-the-truck
Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_inode_dotl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 2b313fe7003e..ef9db3e03506 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -78,11 +78,11 @@ struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 
 	retval = v9fs_init_inode(v9ses, inode, &fid->qid,
 				 st->st_mode, new_decode_dev(st->st_rdev));
-	v9fs_stat2inode_dotl(st, inode, 0);
 	kfree(st);
 	if (retval)
 		goto error;
 
+	v9fs_stat2inode_dotl(st, inode, 0);
 	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	retval = v9fs_get_acl(inode, fid);

-- 
2.46.0

