Received: from e3i432.smtp2go.com (e3i432.smtp2go.com [158.120.85.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78763195FA
	for <v9fs@lists.linux.dev>; Mon,  4 May 2026 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927059; cv=none; b=AebRPVUYQvDAKaciCMxZ2UNQjoxnEM1/3GcGT+iwRpB0NxjW07H/dC3xJCYhZq3tPk4399MBVF4144jdOF97rgX7KUtfC1WBwpY1p3p0jNbBow4B3ML2ZSoaRaEaWJQYx8SX0dbkci1MixMpBCjvh9YUwD81lVb/iwKw+0ZXQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927059; c=relaxed/simple;
	bh=u2HYfcja/d+pjHWbNbckX8D9a2gqBvN6zmE0axOF82A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzIM64IrE47iv1fMQCRm5qlVA3s53LnaZqz72zyGkeLWEST008a5iXpntRMsI32n+rkQVXqZ1oiiJWNob/UShl9ENTnNSdAwIg04TWZi0my8jqRH1sBPexvVUbUtaRKCic+r30X7KJzrecz6x540Q5S0XBMDMGN57rXkUJtN+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=emQ6uzuK; arc=none smtp.client-ip=158.120.85.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="emQ6uzuK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1777927056; h=from : subject
 : to : message-id : date;
 bh=mV7a+m0YYP7z4oY7su4TQFc86hoFqZn+cXv8ETIwXIM=;
 b=emQ6uzuKnh58hBeoXi5G4cLGifnMLQAar7WcidYKRERHGNfby+bMx3r2z/0ZIL8W+Badp
 7mYQA2u1YusfH3vpgjFpElMNtDSggduK86URpoTk6xWK9FEaieDoAnKLx4VPbFuKhOiBxdQ
 CMiCc0LBmq8m4eYok3qnjW4Abqm9bUVxt1qApm0O4vShgqQI1ox9bQ4XKfGgCzC6Z6Addmo
 LxYQm1J3m+HAS5Y7v1nCFNRlBk74rmWY/lhA0bcfbM/CkXJvcTro4cIUj9DNRZ1sSpBYesQ
 oxSGpNyy3CfuNINor6yw+gLjBzHdcvM1HZU97cTekIeTmJvPQeyRkEQ0Ampw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1wK02i-4o5NDgrvVHP-rTL7;
	Mon, 04 May 2026 20:37:28 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v5 0/4] 9p: Performance improvements for build workloads
Date: Mon,  4 May 2026 22:15:50 +0200
Message-ID: <cover.1777923233.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616s4Qe5DmHKk
X-smtpcorp-track: kbUeYLZ2Xp97.2p7ycUkp3kmB.Fl6jgAYTJ14

This patchset introduces several performance optimizations for the 9p
filesystem when used with cache=loose option (exclusive or read only
mounts). These improvements particularly target workloads with frequent
lookups of non-existent paths and repeated symlink resolutions.

The very state of the art benchmark consisting of cloning a fresh
hostap repository and building hostapd and wpa_supplicant for hwsim
tests (cd tests/hwsim; time ./build.sh) in a VM running on a 9pfs rootfs
(with trans=virtio,cache=loose options) has been used to test those
optimizations impact.

For reference, the build takes 0m56.492s on my laptop natively while it
completes in 2m18.702sec on the VM. This represents a significant
performance penalty considering running the same build on a VM using a
virtiofs rootfs (with "--cache always" virtiofsd option) takes around
1m32.141s. This patchset aims to bring the 9pfs build time close to
that of virtiofs, rather than the native host time, as a realistic
expectation.

This first three patches in this series focus on keeping negative
dentries in the cache, ensuring that subsequent lookups for paths known
to not exist do not require redundant 9P RPC calls. This optimization
reduces the time needed for the compiler to search for header files
across known locations. The two first patches introduce a new mount
option, ndentrycache, which specifies the number of ms to keep the
dentry in the cache. Using ndentrycache without value (i.e. keeping the
negative dentry indifinetly) shrunk build time to 1m46.198s. The third
patch enable the negative dentry caching for 24 hours by default on
cache=loose.

The fourth patch extends page cache usage to symlinks by allowing
p9_client_readlink() results to be cached. Resolving symlink is
apparently something done quite frequently during the build process and
avoiding the cost of a 9P RPC call round trip for already known symlinks
helps reduce the build time to 1m26.602s, outperforming the virtiofs
setup.

Here is summary of the different hostapd/wpa_supplicant build times:

  - Baseline (no patch): 2m18.702s
  - negative dentry caching (patches 1-3): 1m46.198s (23% improvement)
  - Above + symlink caching (patches 1-4): 1m26.302s (an additional 18%
    improvement, 37% in total)

With this ~37% performance gain, 9pfs with cache=loose can compete with
virtiofs for (at least) this specific scenario. Although this benchmark
is not the most typical, I do think that these caching optimizations
could benefit a wide range of other workflows as well.

Changes since v4:
  - Fix potential uninitialized access in v9fs_issue_read() and
    v9fs_vfs_symlink_dotl()
  - Fix potential memory leak in v9fs_issue_read()

Changes since v3:
  - Go back to s32 ndentry timeout option, rename it to negtimeout so
    its easier to grep
  - Bring back the missing 4 letters for *_TIMEOUT_* macro name
  - Fix some alignment/space issues

Changes since v2:
  - Rename v9fs_dentry_is_{expired,refresh} to ndentry
  - Some grammatical fixes in couple of comments
  - Rename the negative cache mount option to ndentrycache. Using
    ndentrycache without value enable infinite caching while
    ndentrycache=<time> enable caching for <time> milliseconds.
    This allows the option to be unsigned.
  - Make it more obvious v9fs_issue_read() is only called on dotl
    symlinks

Changes since v1:
  - Rebase on 9p-next (with new mount API conversion)
  - Integrated symlink caching with the network filesystem helper
    library for robustness (a lot of code expects a valid netfs context)
  - Instantiate symlink dentry at creation to avoid keeping a negative
    dentry in cache
  - Moved IO waiting time accounting to a separate patch series

Thanks.

Remi Pommarel (4):
  9p: Cache negative dentries for lookup performance
  9p: Add mount option for negative dentry cache retention
  9p: Set default negative dentry retention time for cache=loose
  9p: Enable symlink caching in page cache

 Documentation/filesystems/9p.rst |   5 ++
 fs/9p/fid.c                      |  11 ++--
 fs/9p/v9fs.c                     |  27 +++++++-
 fs/9p/v9fs.h                     |  28 ++++++---
 fs/9p/v9fs_vfs.h                 |  15 +++++
 fs/9p/vfs_addr.c                 |  35 ++++++++++-
 fs/9p/vfs_dentry.c               | 105 ++++++++++++++++++++++++++-----
 fs/9p/vfs_inode.c                |  18 +++---
 fs/9p/vfs_inode_dotl.c           |  62 +++++++++++++++---
 fs/9p/vfs_super.c                |   1 +
 include/net/9p/client.h          |   2 +
 11 files changed, 261 insertions(+), 48 deletions(-)

-- 
2.52.0

