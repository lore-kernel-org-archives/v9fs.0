Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37B1BDC3
	for <v9fs@lists.linux.dev>; Mon, 20 May 2024 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190376; cv=none; b=n5/Y9YlZjB4A0qewFENcrPegdBd+/5dZtCIoTv6qQM+AzOo2RGBVJnlhN4anSbtC09xD55jpbATxGRQb2cN0rs8/Sa7KXzMl1uJ48nHMlGr/d++5QSEAJrZk3BHe1blzRnyEUogcUWxbLE/aE1+VS4G8+g0LF08mVQH0yWcfpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190376; c=relaxed/simple;
	bh=FFamMafNUgPmRC2roNs5YTBIj9RyU3l/0sZQ9xCXCLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0fsanVV69YREHpGODlcy6FVC+1ZKGXsuCbRXO18HoE4HpYHAlohmj+ngiyYcXatV/yCs5D8hAfZmEj87AyJ/VsKc/GKKQkdVUi3+GnxGFu/VTduut5eL1uYj8VS0CeOgVKYd//+L9im4f6TEoBP1bqCQAHBehXpSug2i9L8ac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=c4J1a2ke; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="c4J1a2ke"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id F276814C2DB;
	Mon, 20 May 2024 09:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716190368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vbBcX66RghTnkz2dmYVbCbRBKn2ffe8qZ0JA8PcrWg=;
	b=c4J1a2keNzTDzZHGaRFZjMhWSoqA9vmA+S6H/IEyHyB/aNWouO9ao4pzJ1cfy0VQQqLQUJ
	1uy+90nuQC5qYy82ZgUdyORwXbc+W5zcHQ79s/zm1fLr6uF6SpKCB6sT1DYeX4tvJw/lGI
	/d9LnXoHHNyWuWoKmTxKO9WA+ZpvGInL2Li8c7xTLB1gK8WPQL5iVWECLuok8e5A1slGq5
	nDpdf9sIhgYE3UEKXM9WxfPg15J1yRd13X6vx0qXzC2cfHIf77Ik5VnNYDaHzWynCwwsiy
	E0NOTKXdRMSrb6HyyuozvKKUlTVpsNplv1gMeVBcWMtdqZVGmUwS2JV78fsY9A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 88b285a3;
	Mon, 20 May 2024 07:32:42 +0000 (UTC)
Date: Mon, 20 May 2024 16:32:27 +0900
From: asmadeus@codewreck.org
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+df038d463cca332e8414@syzkaller.appspotmail.com>,
	ericvh@kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Write in
 v9fs_free_request
Message-ID: <Zkr8i9XxpkJ9AABZ@codewreck.org>
References: <0000000000005be0aa061846f8d6@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000005be0aa061846f8d6@google.com>

+To David as I need help with netfs

syzbot wrote on Sun, May 12, 2024 at 12:42:33PM -0700:
> UAF in
> Workqueue: events_unbound v9fs_upload_to_server_worker
>  refcount_dec_and_test include/linux/refcount.h:325 [inline]
>  p9_fid_put include/net/9p/client.h:275 [inline]
>  v9fs_free_request+0x5f/0xe0 fs/9p/vfs_addr.c:128
>  netfs_free_request+0x246/0x600 fs/netfs/objects.c:97
>  v9fs_upload_to_server fs/9p/vfs_addr.c:36 [inline]
>  v9fs_upload_to_server_worker+0x200/0x3e0 fs/9p/vfs_addr.c:44
>  process_one_work kernel/workqueue.c:3267 [inline]

> Freed by task 32641:
>  p9_fid_destroy net/9p/client.c:889 [inline]
>  p9_client_destroy+0x1fb/0x660 net/9p/client.c:1070
>  v9fs_session_close+0x51/0x210 fs/9p/v9fs.c:506
>  v9fs_kill_super+0x5c/0x90 fs/9p/vfs_super.c:196
>  deactivate_locked_super+0xc6/0x130 fs/super.c:472
>  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267

That's a tough one: netfs took a ref in v9fs_init_request (netfs op's
init_request) and expects to be able to use it until v9fs_free_request
(net op's free_request()), but the fs was dismounted first and we kill
the kmem cache at this point so we aggressively drop any dangling ref
there as there's no way of waiting.
(this is corroborated by "9pnet: Found fid 1 not clunked" in dmesg in
the syzcaller logs)

The other two recent kasan errors are similar:
https://lkml.kernel.org/r/000000000000b86c5e06130da9c6@google.com
is pretty much the same (it's just that the decrement here hit 0 as
umount was in the middle of doing it?), and
https://lkml.kernel.org/r/000000000000041f960618206d7e@google.com
is yet another step faster (netfs freed the last ref while the cache
was being emptied and destroyed the fid first; which is possible because
we're not taking the client lock at this point as we weren't expecting
any other access after umount)

David, got an idea on how we could wait for these async writebacks?


Notes:
 - David removed v9fs_upload_to_server in 2df86547b23d ("netfs: Cut
over to using new writeback code") (and c245868524cc ("netfs: Remove the
old writeback code")) in master, but the problem is still present
conceptually.
 - layering wise, 9p (fs) depends on 9pnet, so 9pnet cannot call into the
fs code; the wait has to be in v9fs_session_close() before calling
p9_client_destroy or earlier


Thanks,
-- 
Dominique Martinet | Asmadeus
