Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98D7BB13
	for <v9fs@lists.linux.dev>; Tue, 19 Mar 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843509; cv=none; b=Sj73GcJVgJcVRkGv95hga0AZSNgaxuLUu4oTBWhGFfM6R+o51RQea6wzos02pNsPeHT5P8egmRoN003qEwfP+41D5XbRBTLuIvOKAbIw5AY1fjJ8uQHcjhaYMIC9VM1cYP71JH71tTh6L5wr543fiKkPcB6WYn2/yNqQNJrlPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843509; c=relaxed/simple;
	bh=JQZMLijPAqdk/zouBBIhNjFbmM+dcBbxL2f7l4d0ge4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tm1HBlaALBgLQ18IpHpkA5W3FvJfU9Dew3G4PIdaBC1A/QfVCkGRZwtW+ZtiWnZUvuS+FM3DaVXnLT3F14Sc1ncfnUsYoj12dpaRgUUTxZmbtrjYbqPxCZJxGlEsk4STdnxtIAYippzy62zZSEYjBj9DCDJPRLpv0rosh9Zd41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=SAVt26NG; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="SAVt26NG"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id BD947240029
	for <v9fs@lists.linux.dev>; Tue, 19 Mar 2024 11:18:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710843502; bh=JQZMLijPAqdk/zouBBIhNjFbmM+dcBbxL2f7l4d0ge4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=SAVt26NGXgc5KlHubKGNBf5ptJyQZh2U/p/po/oZNe6Zm2IsZDQhm5JAgvIW3d6c8
	 UHrpxQMsPGiq4XFUwWmR4lJm7oCGbxFV5XwnIzh52BZkLspus2BYwC0jG/HGcrq+sI
	 +TxSX7j4AeUE9dP6V10kL2BPxkM25lvz2Bk7/fCMTM6T4CWG8s15pAJzisoU+L6LjI
	 AkhXG8UIRnCaBafJl0BA9GJ4AueLzruM4TpCWvPZucZP4bk0n05HlbBNATWhKF0W/u
	 GW4rncSLaCaaYUO28C3BDLxnkGjPDYNFgniPWNbWZD9FwRoCJVJyCyDvc9I5HY7cwo
	 02soYd5IXT4fg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TzSNX5hsMz6trs;
	Tue, 19 Mar 2024 11:18:20 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
Cc: asmadeus@codewreck.org,  ericvh@kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux_oss@crudebyte.com,  lucho@ionkov.net,
  syzkaller-bugs@googlegroups.com,  v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
In-Reply-To: <0000000000002750950613c53e72@google.com> (syzbot's message of
	"Sat, 16 Mar 2024 04:15:32 -0700")
References: <0000000000002750950613c53e72@google.com>
Date: Tue, 19 Mar 2024 10:18:19 +0000
Message-ID: <m27chy8qz8.fsf@Charalamposs-MacBook-Pro.local.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


please test uv in v9fs_evict_inode

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..5d046f63e5fa 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,8 @@ void v9fs_evict_inode(struct inode *inode)
 	filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+	if (v9fs_inode_cookie(v9inode))
+		fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
 }
 
