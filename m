Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136BA253C8
	for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 16:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAE7C433CB;
	Mon, 17 Jul 2023 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689611346;
	bh=J5f/y73gbpYzAPzzqE3aQSPO6NaFKpqMLlK+5QoR/ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jbsob+5eNtbIFKANOFOdj+SVGklOF2uuGBVENNkiCnH6O4NdsDh1SfnY0TFd4im4E
	 3geBuWgHoO0mRJ5BV/zvHzfnHBFK0wWd0Rhf5FrRn49iDiIvbTIpnw6Qiv0sgDavlV
	 3AJi5EJ+4BJVmhlUhVRPQ7MWLg9oMQkIQ2c5JmFyRVJ/SEfmuHViZl0YYIVc8Xehr7
	 ht1lBOOz6vtH9ZS7eagxjA82K9jzMb+7Bl5A+yxQcPlVr+Q41S/eVgyGUIMUv503Ob
	 D5ZMMMB9oU8VhWC/l1z014kyx9NCc9OFC93JO5cA27UK9MY71Yw4PhTM2q2NuOcqgh
	 2X94XS0ev7iRA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 17 Jul 2023 16:29:01 +0000
Subject: [PATCH 2/3] fs/9p: fix typo in comparison logic for cache mode
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v1-2-0683b283b932@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=J5f/y73gbpYzAPzzqE3aQSPO6NaFKpqMLlK+5QoR/ac=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBktWxPBdEw2pHkHpJf4Xrs3jq2I1uQxbOZVPS9P
 0SXZzDTniqJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLVsTwAKCRCI/9X7Sl//
 mDCRD/9ikTI1Hr1beF9eb5g7a/YtQi7qfsc5Y7ivQJ7Y1EVQc2SnXcCmMNcL1QMqqPS/Mi9GOmc
 Knfagji4/igxXJxzv5X/3QQfyTsAnHUeU66Lza2/bqXbStwdyrPMxOxd0/DkWjHPe+yEKhZZyTT
 gTFyUze61f5frLrmupDaHkqbum5R8zbpns4UmKMOxcHh40QGfMmwFCJa3lVate72qecFe0HZ2im
 ECX19Mv5XSRJ0CkQu/DyFFyFGGNNRE2Lb12vdoj4jN0Ve4CEsuxIdeLjuSscy/INnPFahg9KOMM
 Q/5NpaPq9VHrAqqgRMM6kqI+W3qzj9FlTg8BtWEeEvKZ48/owazDkYRzwJyT4u93INDREraNfw+
 I/v4QvmgI52LHDB4Bg4Jx4KIMW6iuqD6MOPJJNBrlAayGwhhpWq/r+nSrqWhJQeSsH6/O2J9U7V
 WG3DDqqxeZHzUqJaZNqqNueStcIl4i3qT+T7hHpSREX8d/UYqzw9Pgzfq1EGMpsQ+Rxy+f0FJZd
 YF0EvBRrJyvNfxmcCnwb6KGMHn4ndXYaSSumXr9D7oOag+btXlwjfpYngzhyV7b0BFr72pG+wD2
 Y/vSlcQNXpSEPh1463LeNfg8wEnXGipjJvuo2EhMYPHb3zy/0/Vtefp1y/P0DKgaF8yUOs7pucP
 KwXH+8uf62IF9yw==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

There appears to be a typo in the comparison statement for the logic
which sets a file's cache mode based on mount flags.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/fid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 0c51889a60b33..297c2c377e3dd 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -57,7 +57,7 @@ static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
 	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
 		fid->mode |= P9L_DIRECT; /* no read or write cache */
 	} else if ((!(s_cache & CACHE_WRITEBACK)) ||
-				(f_flags & O_DSYNC) | (s_flags & V9FS_SYNC)) {
+				(f_flags & O_DSYNC) || (s_flags & V9FS_SYNC)) {
 		fid->mode |= P9L_NOWRITECACHE;
 	}
 }

-- 
2.39.2

