Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96C1FDE
	for <v9fs@lists.linux.dev>; Sun,  9 Apr 2023 22:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBC4C433EF;
	Sun,  9 Apr 2023 22:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681080291;
	bh=xRIsVFSUrsQQOjJBLZt8laCBY+KJ3A93MXq+5RhRXKA=;
	h=Date:From:To:Cc:Subject:From;
	b=lu+3r6ogZ93Y2Qb6CJHxlCZAroRkfS1vmFRo9JoT3HT0LGNgDVlK9QVfJ6B7HJqYy
	 VSD2a/+EZ3jYYfArE74vHKFgQISEkHmzd8swc9eOACtmoaRqqyL67k+7JCGHpzCyC+
	 gPR3Fb0ssB0hEN7qMaCqCBNHzROUypmXOv/L8EKCSvnrPQVtLNuDjZOOky82AaS6ZN
	 15anlmmZ+vt5BQlaLfiqL7G+Vueq+7FTLz5qDTTQWX5mhJPNkDWH+datHxT1BiqaU9
	 vT5mvfaTYsbi9Vao7CE0GNhKryEoclMDbMkw6ZOkIPnJdN+iWXjOdMTcM591Lz3Bo8
	 lMTIPFQ2klXWw==
Date: Sun, 9 Apr 2023 22:44:48 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: torvalds@linux-foundation.org
Cc: v9fs@lists.linux.dev, v9fs-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.3-rc7
Message-ID: <ZDM/4C0PlbbzV/0R@7e9e31583646>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6iTrNcIrToWOugJ"
Content-Disposition: inline


--p6iTrNcIrToWOugJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.3-fixes-rc7

for you to fetch changes up to 347dca97f75d461ac2ac256b68e495dfc6f14d61:

  Update email address and mailing list for v9fs (2023-04-02 23:53:41 +0000)

----------------------------------------------------------------
These are some collected fixes for the 6.3-rc series that have been
passed our 9p regression tests and been in for-next for at least a week.
They include a fix for a KASAN reported problem in the extended attribute
handling code and a use after free in the xen transport.  It also includes
some updates for the MAINTAINERS file including the transition of our
development mailing list from sourceforge.net to lists.linux.dev.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

----------------------------------------------------------------
Eric Van Hensbergen (1):
      Update email address and mailing list for v9fs

Ivan Orlov (1):
      9P FS: Fix wild-memory-access write in v9fs_get_acl

Zheng Wang (1):
      9p/xen : Fix use after free bug in xen_9pfs_front_remove due to race condition

 MAINTAINERS        | 6 +++---
 fs/9p/xattr.c      | 8 +++++---
 net/9p/trans_xen.c | 4 ++++
 3 files changed, 12 insertions(+), 6 deletions(-)

--
Thanks,
    -eric


--p6iTrNcIrToWOugJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElpbw0ZalkJikytFRiP/V+0pf/5gFAmQzP+AACgkQiP/V+0pf
/5ii2hAAjfk8de0uwQsZqnoBcsnvPIHBq5RyIrSF6XT+fG6FBMmxuz1pgY8jnn7V
g4jQt+jlWiPdjDRQ2O51eGVlk+bybnaQaljEfoJ0gT5Y5rxSTMJB8shQCvpf3Mkk
x1W3qSCe1CQWCiA1QBz2nwDBBcKmSNkCxkOyvc/1tqAKZNzp0+BYwNR+Y4dmnK29
l6+pK3udZe++CbRDUv5as0k1F4CtNzyH7gyOD1Lb5gJvzhpN9RqdKOnR1IXSaJrD
E4QPL2bnII0U0w6TAz4a0cZ5oPGNEJDBPRSccIY+ulCRELBdYbhce2wV7SjIk/0l
/2frC/0OV8T2c9rF6QSQHZDaKjSQ0xoYvL1AZjcDOnFCcKU7olGOo3eRaLaC7Ax1
DLbOFtOuWnvh6fFzbPU3PoKc+G4116e4bgKDMBUhdECFB+aSRGChdKNStTHu6RGP
X+Yt52406T8KFU1SB5FYrn02hLFa5TMJMEBPFxoyXcowi16Hkoi6J+oTMdLWaLTx
gWH7prJZBLyVDg7Nm+WZ6MvSMByoAk+I4m0CPSfsHCHdlDKdxdvlJZ6grUPpHTBY
/jMkKznn/N/nCKNahH0qb8H96qiDEpslGIn8j4GWvXYiv+kG/1rfwDR4jEzrEJ9o
Dvry0glHuTNK/WmB0b2U+3sCAwxyW0dpfggO0nMZ7ujo3nqQsiQ=
=sXMH
-----END PGP SIGNATURE-----

--p6iTrNcIrToWOugJ--
