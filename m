Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996E55E41
	for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798555; cv=none; b=msleRYxRijJBnyhtNFFnHPedRYcB5qqCQn4U5+iIJsiyWaesyA4HfYMLZ7mQYenyDa5DFzmZ/T8q+KD2Og6wvknCInErCIfJiidrk79UhaazU3m4ZEljTdLTF8tq7xYrN77gQP7zldtaPmugFVJTcf53t66GIGoLsKxAfFbxmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798555; c=relaxed/simple;
	bh=6P3rFkrW9HnhkfagqhtOgoRhL4elj2LsX7y/ud/bmu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=iC2oXQ5IyEeyelpFgB0HPtHxxIEciawPBUtUvHQOgqaTK9NiubkjacQ3VAyfGsTfE2Fqtb6RbgrvyTXwt2Dwk3f5pyq4Y59caghiCfRRp0YLwWFUfe7I1mKoN65bx65mYCXWUx6L73+q1Tv2LFlDw4G1HxvscMWRRLLHdkfEsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=kSKE6E0q; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="kSKE6E0q"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 0C50F240101
	for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 22:49:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710798547; bh=6P3rFkrW9HnhkfagqhtOgoRhL4elj2LsX7y/ud/bmu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=kSKE6E0qPCkaTlCXA/wiBBzScwBereuFojP25NmQ+TAGvmFv5MQfzZHJ6dQ3toFCn
	 sC9l1PM7s0LgM4E0mhlwHKHdCm0iTcizxuSUH2J5dkHwwyD0NoIEyrnrR9nWOKBUGn
	 eGdns7ohxr3JdPSC5SLQd+5uhLlsAEpPkN++hdwj/jOqtuGqe0Yt4lp18PQYswhI4n
	 pk4jete9+GdXN+byBIZAMtLkJIDa0kt8SJtGpy1KsS5DXI1QJiRBRzijzS5Hm/06Wv
	 t4SQWzALLqyUgCHD23r5OZ8OQ9LN0m4CB+GO/Fidha+iT5XlroQdc8o2kD3XTGD7+d
	 KX8dC883Y3IAw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Tz7ly5gmvz6trs;
	Mon, 18 Mar 2024 22:49:02 +0100 (CET)
Message-ID: <ec51cc1d-beaa-4aa1-a54d-e503223dd365@posteo.net>
Date: Mon, 18 Mar 2024 21:49:00 +0000
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
To: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
References: <0000000000002750950613c53e72@google.com>
Content-Language: en-US
Cc: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
From: Charalampos Mitrodimas <charmitro@posteo.net>
In-Reply-To: <0000000000002750950613c53e72@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

please test uv in v9fs_evict_inode

#syz test 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..5d046f63e5fa 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,8 @@ void v9fs_evict_inode(struct inode *inode)
      filemap_fdatawrite(&inode->i_data);

  #ifdef CONFIG_9P_FSCACHE
-    fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+    if (v9fs_inode_cookie(v9inode))
+        fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
  #endif
  }


