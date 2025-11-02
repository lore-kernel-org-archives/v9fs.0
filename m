Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655E1A256B
	for <v9fs@lists.linux.dev>; Sun,  2 Nov 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762115129; cv=none; b=hUNm2EOwApTQaqrpO+iPuiIkvU2q/CsAsPQ3kU/YVtlkexmPadV7BLbrxcijgovXsXoSolnA+f14YT557Er/4nbNBuSPzHOqJBu5YlyoVBjjFQ0i0mT0pUboyUKDpPjTY7ANo3neAKIKH29QRk87NT21TTEQ5hkDL9+8b2Omfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762115129; c=relaxed/simple;
	bh=xhNaYFHtX32EHR1+ANZlyo5loPnLj+8vK7w7wrGMbdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhuDWu9BpYay9xTzfqtnRLaRG876QHgZwOMQpgbJwDsLO67hD7xSQRP0lduxwwMwk+jhkYDwxjTsICau2FT+x72sFD1h1ZuvyAXarkwxofGdI05yLrcqE7R4F6x6aaXYbz4431+MneLj3mQGts461Ia6OCjWef1ZiWploDhTdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=XhKr1Q4n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oGFIbLDL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="XhKr1Q4n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oGFIbLDL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1313CEC00F2;
	Sun,  2 Nov 2025 15:25:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 02 Nov 2025 15:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1762115127; x=
	1762201527; bh=1iKTideb7IrRgxtR7/0zW5I0FermYyGDRouHa/7r5XY=; b=X
	hKr1Q4nEKWggkuuu/M5Q4pycIUA15X+1ft8fa5LHb8ymNF9Nz9cOrMUyQbFxUBsA
	IIJKrWV/HfYFRObMgXGAR7zAZrj7JbVGZB1DSsPcF3AH6lvZU+36hoyZbjWcAUJO
	jyjvtjdVYHTRYSkwALDMRqoDHkS1KE0fNz2dNEgmHsQyp1VsPpOiGBu1WTctiTiy
	5nybHD6PAuI2rHP2lyYDv2k4B7HIALNJRYyVsF0CgywMID9nkw8YD1zdfx0xcGQK
	lJuRgCj2BW0QeuaKUijwl++bmB00TX3JW/NY48Rdfin8pc6TzTu+YdvpKVjV9QgE
	+2Kciz8KUhb57X1KV0cEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762115127; x=1762201527; bh=1
	iKTideb7IrRgxtR7/0zW5I0FermYyGDRouHa/7r5XY=; b=oGFIbLDLY1yYG9MJH
	7b8fzm2U8qAnyrKCOqFn16yQptqtcbdIWpPOfymr6l1+h60v2tveNsab7m5MvbXr
	+jFEWJWP4qsr+QG25RC+PmK8wHbz3g6RiKOF0whX+97SLSu/vj/TR2NCF+Iz4Bvi
	fv/TIjuqsa2h84BhhCtnhYykntI9o9KylrqVVVsHnF+s0ourY+GgYSmfE/04W1RC
	cmsJlIDcSudaPF9NMT4cnKXNY3L18fUGcOdh1lgG4cYid3vpq2U+VYuVFCsNeMJo
	N5UeRcltTjO8YYOrLEwoqgLywfEC2jBYa5WG/D0B7Y4PNP+qzOUOV7vwiOLDfG0B
	QliBw==
X-ME-Sender: <xms:Nr4HabBFXC_lD96Xr8s1Wnis3uFD8psGG39J4YnA4QWIdkBJAwl0Iw>
    <xme:Nr4HaVMNl-a1XrqkqKWfrtfP2eDH0RlK3EVOnmizIZE5vAxujAIsqvXRK3dcASE0C
    iAgybPKB_XB6syysV_53QO5IHrXFnua20SZOEckBkb0ZocawJ7PicM>
X-ME-Received: <xmr:Nr4HaQaZkG8PO0A8TwKM2ILomUu9CTv6rTZ1qf8gu9_vLiFSAY3XOg76zX3g9WAcMIeA5B61_8VvUhLHIZhoEssAUJsUksw6BsS3ZwgrJzJIzAGNElKsHg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtoheplhhinh
    hugigpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopegvrhhitghvhhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpd
    hrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepvhelfhhssehlihhs
    thhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:Nr4HaUv7gZPV_89agdcEwh1cHp1hVbCP0WiDIhjVasV9hOb48hFDjA>
    <xmx:Nr4HaSMwt69gWFKq4F8hBcjvTjQKiIE6_ni2mpqfCI1UIPB9wwbL-w>
    <xmx:Nr4Hab4Ps6--uPailh-gRwjoCaGCy1wfy-3p88GazjnocV2B5stqDw>
    <xmx:Nr4HaYTekgRjnx0tkGvvbO9ufJ67f8WqP584eKgD5Go-SZW7zzl6DA>
    <xmx:N74HaQTWaXXlz9qqFtQ4t6p3_J1vktWlFt67sW1GjnRgzj8s_cldhTiB>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 15:25:25 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev
Subject: [PATCH 1/1] fs/9p: Do not open remote file with APPEND mode when writeback cache is used
Date: Sun,  2 Nov 2025 20:24:39 +0000
Message-ID: <ed2d3f0045f538e8ddbd2d0a151e31767dda87e8.1762115015.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1762115015.git.m@maowtm.org>
References: <cover.1762115015.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When page cache is used, writebacks are done on a page granularity, and it
is expected that the underlying filesystem (such as v9fs) should respect
the write position.  However, currently v9fs will passthrough O_APPEND to
the server even on cached mode.  This causes data corruption if a sync or
fstat gets between two writes to the same file.

This patch removes the APPEND flag from the open request we send to the
server when writeback caching is involved.  I believe keeping server-side
APPEND is probably fine for uncached mode (even if two fds are opened, one
without O_APPEND and one with it, this should still be fine since they
would use separate fid for the writes).

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

I haven't done a bisect to figure out if this regression was introduced by
a change or was this behaviour always present - 6.14 has the same problem
and 6.13 did not compile for me due to some problem with bool / true /
false being a keyword in c23, and it could not compile with c17 either.

 fs/9p/vfs_file.c       | 13 +++++++++++--
 fs/9p/vfs_inode.c      |  7 ++++++-
 fs/9p/vfs_inode_dotl.c |  6 ++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 612a230bc012..ff95dfb30583 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -43,14 +43,18 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
 	int omode;
+	int o_append;
 
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
 	v9ses = v9fs_inode2v9ses(inode);
-	if (v9fs_proto_dotl(v9ses))
+	if (v9fs_proto_dotl(v9ses)) {
 		omode = v9fs_open_to_dotl_flags(file->f_flags);
-	else
+		o_append = P9_DOTL_APPEND;
+	} else {
 		omode = v9fs_uflags2omode(file->f_flags,
 					v9fs_proto_dotu(v9ses));
+		o_append = P9_OAPPEND;
+	}
 	fid = file->private_data;
 	if (!fid) {
 		fid = v9fs_fid_clone(file_dentry(file));
@@ -61,6 +65,11 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
 
 			p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try opening O_RDWR\n");
+			if (omode & o_append) {
+				writeback_omode &= ~o_append;
+				p9_debug(P9_DEBUG_CACHE, "removing append from open mode in writeback cache mode\n");
+			}
+
 			err = p9_client_open(fid, writeback_omode);
 			if (err < 0) {
 				p9_debug(P9_DEBUG_CACHE, "could not open O_RDWR, disabling caches\n");
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 8666c9c62258..b68d76eb54a6 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -789,6 +789,12 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
+		if (p9_omode & P9_OAPPEND) {
+			p9_omode &= ~P9_OAPPEND;
+			p9_debug(
+				P9_DEBUG_CACHE,
+				"removing append from open mode in writeback cache mode\n");
+		}
 	}
 	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, p9_omode);
 	if (IS_ERR(fid))
@@ -1393,4 +1399,3 @@ static const struct inode_operations v9fs_symlink_inode_operations = {
 	.getattr = v9fs_vfs_getattr,
 	.setattr = v9fs_vfs_setattr,
 };
-
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 1661a25f2772..43580905b092 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -285,6 +285,12 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
+		if (p9_omode & P9_DOTL_APPEND) {
+			p9_omode &= ~P9_DOTL_APPEND;
+			p9_debug(
+				P9_DEBUG_CACHE,
+				"removing append from open mode in writeback cache mode\n");
+		}
 	}
 	err = p9_client_create_dotl(ofid, name, p9_omode, mode, gid, &qid);
 	if (err < 0) {
-- 
2.51.2
