Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5641FC9
	for <v9fs@lists.linux.dev>; Sat,  4 Nov 2023 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="uCDAV8L7";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ziDvt2eg"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 80932C01D; Sat,  4 Nov 2023 04:39:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1699069165; bh=bqVJARalMpuZfvwuVrtAyfyj2tFBWs+NtWZpQL9dz3E=;
	h=Date:From:To:Cc:Subject:From;
	b=uCDAV8L7JRxlQ6QZMMDq1yxnOPmLLcBsdVOtSzJG2HBE+9defjMQ/ixYCOMfALSOM
	 mKlp6/5gF7HblOhePDlCZPzm6D9yptHxzh5zmdiyg6XBKAa78dP08XUIFYK88QFW3o
	 qrv1jWcINzD7aFX6LfxHUgl1dUbFQEtWNGq1lKnmYLCYsuWHodQoMo2hvvmoTophyh
	 eWojZxuuxTRmcJNnmZUFvRbylc5vq3CrTd6KmJMNFLDEtoGvWXS0NuA5HjkT0q20Zj
	 /SIekEW+B0nvTmtENIsrwIVHp2wa9fXEAUcsITpp6WkvpAg2t1T3ED1R/n6QfhOYTF
	 JLgi/sTmiFOqQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 62FA8C009;
	Sat,  4 Nov 2023 04:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1699069164; bh=bqVJARalMpuZfvwuVrtAyfyj2tFBWs+NtWZpQL9dz3E=;
	h=Date:From:To:Cc:Subject:From;
	b=ziDvt2egvZRt8SrbNo0+N3AIYbLRfHkcqzpLNcVIicwn3aQ0eNuWeVfJLGLGNoHL8
	 0r0QjvcaG7RTnTTvIqA2Goui6npuzI9JohPmgylxkepZR+9XdlxRKNcTBTQCUlO003
	 hN1YfCl/V1vXJN2PycVNUW3nDMyUIHz5Kfp6QVfIxFvSIkqptrLaY34mB2yuvx4U2q
	 CMSkk1ejpOwB4Ry/RWE69OOb5QQ3jKq/h4/R5Wtq35b5XYSLVun9VFmWDSGM+FquQg
	 rdSHbZz6HUjZx6O3+HA1ckhasq88aJwMQQNoyIR4PIwfPsrijggcAeW284HAQBu0z4
	 Z7gVHfVm9fZMw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 7c6e001d;
	Sat, 4 Nov 2023 03:39:20 +0000 (UTC)
Date: Sat, 4 Nov 2023 12:39:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.7-rc1
Message-ID: <ZUW82S8bGg2BAeNU@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.7-rc1

for you to fetch changes up to ce07087964208eee2ca2f9ee4a98f8b5d9027fe6:

  9p/net: fix possible memory leak in p9_check_errors() (2023-10-27 12:44:13 +0900)

----------------------------------------------------------------
Bunch of small fixes:

- three W=1 warning fixes: the NULL -> "" replacement isn't trivial
but is serialized identically by the protocol layer and has been tested
- one syzbot/KCSAN datarace annotation where we don't care about users
messing with the fd they passed to mount -t 9p
- removing a declaration without implementation
- yet another race fix for trans_fd around connection close:
the 'err' field is also used in potentially racy calls and this
isn't complete, but it's better than what we have.
- and finally a theorical memory leak fix on serialization failure

----------------------------------------------------------------
Dominique Martinet (3):
      9p: v9fs_listxattr: fix %s null argument warning
      9p/net: xen: fix false positive printf format overflow warning
      9p/fs: add MODULE_DESCIPTION
(^ I've just noticed DESCIPTION -> DESCRIPTION typo, but I guess it's
understandable enough and I'd rather not rebase the branch just before
sending the pull request (that last memory leak patch came in late
enough) -- please say if you'd rather I fix it up and I'll resend this)

Hangyu Hua (1):
      9p/net: fix possible memory leak in p9_check_errors()

Marco Elver (1):
      9p/trans_fd: Annotate data-racy writes to file::f_flags

Sishuai Gong (1):
      9p/trans_fd: avoid sending req to a cancelled conn

Yue Haibing (1):
      fs/9p: Remove unused function declaration v9fs_inode2stat()

 fs/9p/v9fs.c       |  1 +
 fs/9p/v9fs_vfs.h   |  1 -
 fs/9p/xattr.c      |  5 +++--
 net/9p/client.c    |  8 +++++---
 net/9p/trans_fd.c  | 21 ++++++++++++++++-----
 net/9p/trans_xen.c | 15 +++++++--------
 6 files changed, 32 insertions(+), 19 deletions(-)

-- 
Dominique Martinet | Asmadeus
