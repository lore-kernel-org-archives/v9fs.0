Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E33563F7
	for <v9fs@lists.linux.dev>; Wed, 21 Jan 2026 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026433; cv=none; b=naqKBJjKviwL1fbasZT9ytgL55eC2Xz0vsp11GDoOCE6JCt7AKCOjy57VhYlc1O5OxZMhdoV40ThDbno5UXV3Ix0Pccy43+z8zOVyHRF9w+xwcq/P1xjFk0Mr8kY9Se1qq5DWVZgrJjd/aMcT9qFvc3BI4SwI9e7UmRp/No5VTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026433; c=relaxed/simple;
	bh=2aNkmmpN/maFhoXoFDhcOIJSoaTihCV4ecMI+GcnpNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzlhKx84OAvWgDghZ4Yz3MI2vzcQSoE3gln5/vw304WO5IQfMRJ/P22DjoIlFcENgQNYmJgbLGcPi67lnC2Mjv8sQC5ew+heMjHtxPE0Ji5WRNhiTC2dtO6OSId3YQFa7f9l4ASB4FLTZtGv00llhsHHAv6dXf08VC4N1w7c+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=SX5gHcwz reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=fBFnDvl/; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="SX5gHcwz";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="fBFnDvl/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769027330; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=DkeWrKH0WcCHByM+aqm+Lo33XrX0YtkSj2vD2jtqy8Y=; b=SX5gHcwz/hKkk6jdv6FHM65jKD
	pbqtfRHBer2L4BU906amYZrZxMx6ATM1CgGs1sEv4HWMhAdj0KMef5M6iWqA5Y1xAUMm2cAEM4T/c
	i2Z9a06KMX0t48V+SPb/9hh23BrKljrvtn7qp0h1INzeTRetox2/JgYwJ3yCyOsrvPlF4EX524Sn/
	vQMXoaZeVSsIp0ZvIifd4ZCHFtT7ScTZ4sCAgg0I42WGO61twrCju/n0VVU+3gYF3cGRyOicQWORQ
	HFU3H/VvjLFmKEG7gIK39FfLa3cjMd6XlCQYo/XtD7cFb+x5OqBij/6qKRU8FbO5lny7A+e+aT18C
	ZP3/6BAg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769026430; h=from : subject
 : to : message-id : date;
 bh=DkeWrKH0WcCHByM+aqm+Lo33XrX0YtkSj2vD2jtqy8Y=;
 b=fBFnDvl/KGWE6/0g9fSQryNsQqvm5XjQ2pvlaQJNaYHQDZRCwJVrHglkOTAaIU5tpl13K
 xfVNLnvPk5urowwCchZfG0QjRm8Yi1QxYnA3Wr3eBzEPf3BV8QqPadYte0/XbWLSved7BHK
 Dl+fMsj3MbedxwYI5Q+smo9VVn2g4mFx9xLKau47OyfZ+73b/fCIejkdDFoeapLqY4Lhdy3
 Yoz+QSzN2ienEh0ysOTSl86eCV/oLdYwhuWZObAtFhACpQy26dnyTsabxVdbBYK3Uqy4qvR
 dB5uIDyfQvcjOj93W9F2pQJucO5Rs9XeHN+Krn1ZJOypDUiZPcmZjBjJUgvw==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaJ-TRk25T-Q8; Wed, 21 Jan 2026 20:13:47 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaJ-4o5NDgruk4z-qgaY; Wed, 21 Jan 2026 20:13:47 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 0/3] 9p: Performance improvements for build workloads
Date: Wed, 21 Jan 2026 20:56:07 +0100
Message-ID: <cover.1769013622.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: yu-BLPetUZ8L.U9q79iqXiFO7.VEzLmwbp9J4
Feedback-ID: 510616m:510616apGKSTK:510616sVoWefEZkJ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

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

This first two patches in this series focus on keeping negative dentries
in the cache, ensuring that subsequent lookups for paths known to not
exist do not require redundant 9P RPC calls. This optimization reduces
the time needed for the compiler to search for header files across known
locations. These two patches introduce a new mount option, ndentrytmo,
which specifies the number of ms to keep the dentry in the cache. Using
ndentrytmo=-1 (keeping the negative dentry indifinetly) shrunk build
time to 1m46.198s.

The third patch extends page cache usage to symlinks by allowing
p9_client_readlink() results to be cached. Resolving symlink is
apparently something done quite frequently during the build process and
avoiding the cost of a 9P RPC call round trip for already known symlinks
helps reduce the build time to 1m26.602s, outperforming the virtiofs
setup.

Here is summary of the different hostapd/wpa_supplicant build times:

  - Baseline (no patch): 2m18.702s
  - negative dentry caching (patches 1-2): 1m46.198s (23% improvement)
  - Above + symlink caching (patches 1-3): 1m26.302s (an additional 18%
    improvement, 37% in total)

With this ~37% performance gain, 9pfs with cache=loose can compete with
virtiofs for (at least) this specific scenario. Although this benchmark
is not the most typical, I do think that these caching optimizations
could benefit a wide range of other workflows as well.

Changes since v2:
  - Rebase on 9p-next (with new mount API conversion)
  - Integrated symlink caching with the network filesystem helper
    library for robustness (a lot of code expects a valid netfs context)
  - Instantiate symlink dentry at creation to avoid keeping a negative
    dentry in cache
  - Moved IO waiting time accounting to a separate patch series

Thanks.

Remi Pommarel (3):
  9p: Cache negative dentries for lookup performance
  9p: Introduce option for negative dentry cache retention time
  9p: Enable symlink caching in page cache

 fs/9p/fid.c             |  11 +++--
 fs/9p/v9fs.c            |  10 +++-
 fs/9p/v9fs.h            |   2 +
 fs/9p/v9fs_vfs.h        |  15 ++++++
 fs/9p/vfs_addr.c        |  24 +++++++--
 fs/9p/vfs_dentry.c      | 105 ++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_inode.c       |  13 +++--
 fs/9p/vfs_inode_dotl.c  |  73 +++++++++++++++++++++++++---
 fs/9p/vfs_super.c       |   1 +
 include/net/9p/client.h |   2 +
 10 files changed, 220 insertions(+), 36 deletions(-)

-- 
2.50.1

