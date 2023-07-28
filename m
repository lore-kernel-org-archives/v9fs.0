Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8177C
	for <v9fs@lists.linux.dev>; Fri, 28 Jul 2023 02:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ACDC433C8;
	Fri, 28 Jul 2023 02:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690510172;
	bh=Ret+BePR9nqIq/mJb5VuaqGEst0mgMQLaZuEFmWudjQ=;
	h=Date:From:To:Cc:Subject:From;
	b=qkWhGuyBStVu5kf1RD9bgHQD8g3GJZuM4cpuMoYg3hZkcdW6ursCMXBALcpXijv9N
	 U2zFItnDo6l2AJelQwfW/otvVcvp2mo52NXY8qtYVb+YmVQdIUEl1mNeaTw2d+yvEs
	 VsiRSuMpZMXjWhCuSiGSwowiOBTUtfqq56IvwaXRG9mqds3ATO8MLow0jiKx4zx49a
	 bpkWQkhFun3iVrxp3IIUBWi22WaiU0wr5V9ZEbDKx0cFF0BMSOO1n5lIknsNwEJYTQ
	 wXqTBSfUfMtQl2rr99PYN9GCHs0lliB6XAvIeonx+Q1HyUVtH5OAB5ivSPmFvkYoMw
	 wHrJ8SzC2cEDA==
Date: Fri, 28 Jul 2023 02:09:29 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: torvalds@linux-foundation.org
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs/9p fixes for v6.5-rc3
Message-ID: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+r45bYtt1Kdf9dWo"
Content-Disposition: inline


--+r45bYtt1Kdf9dWo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git fixes/next

for you to fetch changes up to e6ab0b914c12acefbb0880dded48cb930ccab5cf:

  fs/9p: Remove unused extern declaration (2023-07-20 19:21:48 +0000)

--------------

Misc set of fixes for 9p in 6.5

Most of these clean up warnings we've gotten out of compilation tools, but
several of them were from inspection while hunting down a couple of
regressions.

The most important one to pull is 75b396821cb71164dac3a1ad51dda4781ea8dbad
(fs/9p: remove unnecessary and overrestrictive check)
which caused a regression for some folks by restricting mmap
in any case where writeback caches weren't enabled.

Most of the other bugs caught via inspection were type mismatches.


----------------------------------------------------------------
Christophe JAILLET (1):
      fs/9p: Fix a datatype used with V9FS_DIRECT_IO

Dominique Martinet (5):
      9p: fix ignored return value in v9fs_dir_release
      9p: virtio: fix unlikely null pointer deref in handle_rerror
      9p: virtio: make sure 'offs' is initialized in zc_request
      9p: virtio: skip incrementing unused variable
      9p: remove dead stores (variable set again without being read)

Eric Van Hensbergen (4):
      fs/9p: remove unnecessary and overrestrictive check
      fs/9p: fix typo in comparison logic for cache mode
      fs/9p: fix type mismatch in file cache mode helper
      fs/9p: remove unnecessary invalidate_inode_pages2

YueHaibing (1):
      fs/9p: Remove unused extern declaration

 fs/9p/fid.h            |  6 +++---
 fs/9p/v9fs.c           |  2 --
 fs/9p/v9fs.h           |  2 +-
 fs/9p/vfs_dir.c        |  5 +++--
 fs/9p/vfs_file.c       |  5 +----
 fs/9p/vfs_inode.c      |  6 ------
 fs/9p/vfs_inode_dotl.c |  1 -
 net/9p/client.c        | 46 ++++++++++++----------------------------------
 net/9p/trans_virtio.c  |  8 ++++----
 9 files changed, 24 insertions(+), 57 deletions(-)


--+r45bYtt1Kdf9dWo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElpbw0ZalkJikytFRiP/V+0pf/5gFAmTDI1kACgkQiP/V+0pf
/5hFCQ/9Hp1iDIvM58rkGcDD1qkpwi8jHchF3Sn4i6V+gqEams7oqK3phJq3fYsR
6EIuNW5cTSEfWCeusTQxsu1ISRAEHb1QbHVREWsZXma5kucwad1rZCE3PULmrlIv
NucVMBJ09e+rMFeFB78Ej/FgPXHyRAp2Junf4zNtAs+Md9Yc4UYnpLE87EH4M9R/
Ao1QskCKXPWRcu2pEhkxnQxwUQdJyQa/gr6IOmemlkslmnPmBnLN3oEh76lw3Vni
EtzqhK0BxXfldao1laXpr63yXAJoUXfANg2WY3U3gw5VQICqqYEJk5KR5CSWj5KZ
Wn709UxagDPI9aX5NqhY6Z1p+D5R7hV1av5CB0PdOI4vMRaMxzh39JKWsoVFQtX4
XLIOgDpSH6BhFJ5t7i8MCoNKRMhx/iR5Ln+r79sFR8Hwz7j0QnR0bqfdxywfoP3N
eZEYbefIXFZscwFkA+gBxZIKu2Ljbtf6ZCxdhlT/O9jWMGLNV54VmcuXUGlLoaad
cC/Dej7xIM3n1U+DWfsQlW2N47y5WEl8bVvJEpG3uytGMFuZ5rqOF46lkDf41Mrh
W42nX+qeWln/ymZigSm+bCyRKkfM7SGbWlta0fHRsEYLvlBkQSTfpFJIgm5iqcFG
aZLEwrSLAN9hi5zgDPTm49RyE/7Bel6Ib9FnewwxvW1+bmCME5w=
=SXb4
-----END PGP SIGNATURE-----

--+r45bYtt1Kdf9dWo--
