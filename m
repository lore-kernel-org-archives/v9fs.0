Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801A332ED3;
	Tue, 21 Apr 2026 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764505; cv=none; b=V8SrULfcOtmxqqyBlWhdlq7eUXk2V4wNv6/L786lDwBa1vjnRFrFG538Vl0jJLgup5EiG2z3RmS3qV+o2yZsdhy6g3rsSlvtmDIMOU0qcfGDC3UugUZZ5+fdk/7NvyK6eHxFV+WKs9qVq8lQzq6MuK/vyzADVORSSqZwh6EPCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764505; c=relaxed/simple;
	bh=JtZM9aTSz8yK4rHeAwrmAl94o0eBk1H1KWyGvEsBPBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eqbVkDg7MAEQaVwmg5T459XewdL+p0AXOl9QwHCnNFNLuOu5dXesRrApeOvI2+3FUwGSRvbXZO43nrNDsf2C4TizjbkIlbQHMZEneFqQ5IUwsARscIYqJLjbIbYjJAEkBDnB7pv4MzbiTSW1W89O8mX1gtily5HMSApcev30yqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=D45rKCkE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="D45rKCkE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=1AZv7glXXlYuoeujUmkd6+9Sul8gz7rUm4PpTOVY99A=; b=D45rKCkEC2hIDeqTr9WECulTgl
	AOnqCCQhghQUkvm+OvznY0fh8Zq3CdpVOUq5Z60tNI8mGLPPpqRmeqxiedlpwypF4V3KXEj7/gIq7
	oXJTE+j8ZEndv0j+4PwphZhw96xbmvXXXAL1FwV7waF098b1c7jBa5Al7Gbnde0scL3Adf1YsBSEA
	rzl5Du/urztC75pT7lICcfC5MlVNYOtz/BLh6z4mUl3wOcOrBL0ZKCKnkqcqDK/wS3pEkmUAnlOMI
	ZSMJY+5/dbAVUGpJ9o5Rge0zzzKpPZGMJNB5EUgqw+Lj2ZJz6IuXt6a4xoGtlCZ2vi7ENzIO2XifM
	1bHlJCUQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wF7bf-000lLt-2U;
	Tue, 21 Apr 2026 09:41:24 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 21 Apr 2026 02:41:09 -0700
Subject: [PATCH v2] 9p: skip nlink update in cacheless mode to fix WARN_ON
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-9p-v2-1-48762d294fad@debian.org>
X-B4-Tracking: v=1; b=H4sIADRG52kC/1WNQQ6CMBBFr9LMmpp2kKpdeQ/DAugUxkUhLRIN6
 d1NceXyJ++/t0OiyJTAih0ibZx4DmAFVgKGqQsjSXZgBaBCozQaeVtkoxwqQ+iNN1AJWCJ5fh+
 SR/vb6dU/aVjLsxATp3WOn6Oy6cL9CTcttXQD1mfX1B1dL3dHPXfhNMcR2pzzF7DeRnmnAAAA
X-Change-ID: 20260126-9p-50d206e2f6f6
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eryu Guan <eguan@linux.alibaba.com>, Yiwen Jiang <jiangyiwen@huawei.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2984; i=leitao@debian.org;
 h=from:subject:message-id; bh=JtZM9aTSz8yK4rHeAwrmAl94o0eBk1H1KWyGvEsBPBM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp50Y/VesljEpa6r/Tx1dCF9nHcEYwr+11jlF5b
 ZOtuIAPc9aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaedGPwAKCRA1o5Of/Hh3
 bU6WEACm9YISEbR6uyUkeMKR+ckR8bxwJqzqeIGTd3Z2Bu4liCzmIe0xul/aUjucn8hTc1taKPj
 qgGot3mH/Ejd1jVLR5YDTJl2rRg7QGQaOnHQBapU50XUDc/Fcu5D6oQYduCfP7NzNqKRXsXDDI5
 AWqZijYErdFYlKY/GOSSDBX4qIDaQSvIT/1ZeSqLaCphyFqcG3u90HsY9twxBoRHFtGBffCiuuK
 o2oZIZ/teDw0ApGvxOTd2KG+GEfvf4+0FELwr5AshnkkBNyRa+FdtDb2GYNMxHCGSGJpfJuRqKm
 FKHDTBc+3X6Yljz0vSfQ1EFE/Lihag4fjgLiAtlLsT9pgv5H2xTqbwgApy6Hqs5aMuw9tsWS2Eo
 o7w77Rk1h6qtCX2xmGKiz/zxvwRtRjAgC2ytOViMBluGpGC1GzDFpnoz0B0TIBlqqJctG8cckdy
 YUa82mmRf+Wij3QAwQeSQhNUU1avNIq2VcWowYVusZHdWqLGjOx3vOSFfgckOCR6I20AOAV1qvB
 SzmXDa7qV02bbDgM3u8QDRgwAoHhYk0XAe6VIsFjwvFtlkfPQbB6eGVDEYIQvFxP3zDHDiLNE85
 TJJRsBTOZGfxD9NtCOiaumMlsl7I/efw1+OI9G2vv1i7wur8u9+krkKWK5wtILsI9G7zOaHP2HE
 BOI2CwfO1zhXGLw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

v9fs_dec_count() unconditionally calls drop_nlink() on regular files,
even when the inode's nlink is already zero. In cacheless mode the
client refetches inode metadata from the server (the source of truth)
on every operation, so by the time v9fs_remove() returns, the locally
cached nlink may already reflect the post-unlink value:

  1. Client initiates unlink, server processes it and sets nlink to 0
  2. Client refetches inode metadata (nlink=0) before unlink returns
  3. Client's v9fs_remove() completes successfully
  4. Client calls v9fs_dec_count() which calls drop_nlink() on nlink=0

This race is easily triggered under heavy unlink workloads, such as
stress-ng's unlink stressor, producing the following warning:

  WARNING: fs/inode.c:417 at drop_nlink+0x4c/0xc8
  Call trace:
   drop_nlink+0x4c/0xc8
   v9fs_remove+0x1e0/0x250 [9p]
   v9fs_vfs_unlink+0x20/0x38 [9p]
   vfs_unlink+0x13c/0x258
   ...

In cacheless mode the server is authoritative and the inode is on its
way out, so locally adjusting nlink buys nothing. Skip v9fs_dec_count()
entirely when neither CACHE_META nor CACHE_LOOSE is set, which both
avoids the warning and removes a class of nlink races (two concurrent
unlinkers observing nlink > 0 and both calling drop_nlink()) that an
nlink == 0 guard alone would only narrow rather than close.

Fixes: ac89b2ef9b55 ("9p: don't maintain dir i_nlink if the exported fs doesn't either")
Cc: stable@vger.kernel.org
Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Skip v9fs_dec_count() entirely in cacheless mode — server is
  authoritative, so it fixes the WARN and closes the race class.
- Link to v1:
  https://patch.msgid.link/20260126-9p-v1-1-dc234d53ae87@debian.org
---
 fs/9p/vfs_inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 97abe65bf7c1f..197a155a4e8b5 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -488,10 +488,19 @@ static int v9fs_at_to_dotl_flags(int flags)
  * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
  *   than EXT4_LINK_MAX (65000) links.
  *
+ * In cacheless mode the server is the source of truth for nlink and the
+ * inode is going away immediately, so locally adjusting i_nlink buys
+ * nothing and races with concurrent metadata fetches that may already
+ * have observed the post-unlink value (nlink == 0).
+ *
  * @inode: inode whose nlink is being dropped
  */
 static void v9fs_dec_count(struct inode *inode)
 {
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	if (!(v9ses->cache & (CACHE_META | CACHE_LOOSE)))
+		return;
 	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
 		drop_nlink(inode);
 }

---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260126-9p-50d206e2f6f6

Best regards,
--  
Breno Leitao <leitao@debian.org>

