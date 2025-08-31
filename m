Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FE221275
	for <v9fs@lists.linux.dev>; Sun, 31 Aug 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668103; cv=none; b=I42xQoipYSffiqfP7xVM3IRiMB1gFSmBLpKjKUUXKEYxVC4pXt9N/ZQmleTE3yVb6kPnwhRLxnSh5wf7pvAz4NcsGpUqfE16liAIsmmk8geqNtFHFKwNzc7twJYebJu83GplupcsnRJq41Zb3isGHskAjMxATQ5PIBodI+WgfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668103; c=relaxed/simple;
	bh=KneoWpxXGFhvxupsexdJXwJWsXpS5UsqWVZ1XconUfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIgLhMElo2wBQR+agOct2txuALQzRGFrN36kS8Y0heK3oWQjX0mlNLWz/9YWTb0im9OMGUyk29ukm3Q1lPGhpbc9i4LsLRZw/e1AQkP94UE80Ah8/CYJpyEVDtIB2T8VsAr11yq+mH8Qq+oWCrWnkWeoCaGCSGT31M6o8zge0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=vUhYrDjY reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=iUgmsAin; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="vUhYrDjY";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="iUgmsAin"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756669001; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=fjKbadbZ2hBFy0VfkFE4ZYB0g9U3OWHoNFKBHGHXGes=; b=vUhYrDjYdXaj4PqDdjzCFnfFhY
	Sp2tEd0wcLy2Yyg0umGWKdU1vvBFT7wN4vEkO452bjZtczKMABcrzATghmme/EpmNgzowbIOC2EqO
	f1Rypi/1FlvVoRXXYMxuu404Z5DfUHMTiDbVILgBx2tASMjOMkQPh6rriBwlMwSySt4y1PrKcVyEm
	s0AxnG8HmYnICxlHgjFNzr1LO/NlYCW98F2OaMddVw63p3W0+Hcor/mquTGqOptfRoeiBWyOZkwRI
	TDFbr6Ukez4uPxdv6JePjpTxiKVS/E4DgGPgiJq7Iy07Ye+NqHjNrlesSL/FN6H0143+JOtB+m99B
	oqmYZhew==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756668101; h=from : subject
 : to : message-id : date;
 bh=fjKbadbZ2hBFy0VfkFE4ZYB0g9U3OWHoNFKBHGHXGes=;
 b=iUgmsAinLHx1PD05tQd0FW5TxWM29d4pBW2qhNjBzM2wARvtNd9uM50WC6N9cNskQ8R51
 3vVIfMiCA+mHtWJQd3AKeZ9JUHDn6uAYUnXwJX8WbJUGvVSQyRU9h8zyeNNxDi5WgU832Ry
 GGbsKWfDOmFLG5SEbVxTmL+mjulLwDgAC240dG8LOtaSr6p13/aeKUmG1vbxulrWstQeNRM
 miwkdQMEhCqoYZ3G7t/NmC7uuARNrfaqnB9Vbo672mkY7bC/Yawhxqz+JZGKbL0xhhW9mBE
 VT+jvRVWmuwInjvqR8+EiQUWK4ACCLeCVj4qe5rO2Vxl2MCa3W/ep56+a1JA==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYp-TRk4DY-U4; Sun, 31 Aug 2025 19:17:55 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYp-4o5NDgrhYew-mlAi; Sun, 31 Aug 2025 19:17:55 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 0/5] 9p: Performance improvements for build workloads
Date: Sun, 31 Aug 2025 21:03:38 +0200
Message-ID: <cover.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: KercmsiHjoTR.Dz_JS-R1Dkzn.7H7pNAo8Vje
Feedback-ID: 510616m:510616apGKSTK:510616sDeqWC-WNQ
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

The last two patches are only here to attribute time spent waiting
for server responses during a 9P RPC call to I/0 wait time in system
metrics.

Here is summary of the different hostapd/wpa_supplicant build times:

  - Baseline (no patch): 2m18.702s
  - negative dentry caching (patches 1-2): 1m46.198s (23% improvement)
  - Above + symlink caching (patches 1-3): 1m26.302s (an additional 18%
    improvement, 37% in total)

With this ~37% performance gain, 9pfs with cache=loose can compete with
virtiofs for (at least) this specific scenario. Although this benchmark
is not the most typical, I do think that these caching optimizations
could benefit a wide range of other workflows as well.

Further investigation may be needed to address the remaining gap with
native build performance. Using the last two patches it appears there is
still a fair amount of time spent waiting for I/O, though. This could be
related to the two systematic RPC calls made when opening a file (one to
clone the fid and another one to open the file). Maybe reusing fids or
openned files could potentially reduce client/server transactions and
bring performance even closer to native levels ? But that are just
random thoughs I haven't dig enough yet.

Any feedbacks on this approach would be welcomed,

Thanks.

Best regards,

-- 
Remi

Remi Pommarel (5):
  9p: Cache negative dentries for lookup performance
  9p: Introduce option for negative dentry cache retention time
  9p: Enable symlink caching in page cache
  wait: Introduce io_wait_event_killable()
  9p: Track 9P RPC waiting time as IO

 fs/9p/fid.c            |  11 +++--
 fs/9p/v9fs.c           |  16 +++++-
 fs/9p/v9fs.h           |   3 ++
 fs/9p/v9fs_vfs.h       |  15 ++++++
 fs/9p/vfs_dentry.c     | 109 +++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_inode.c      |  14 ++++--
 fs/9p/vfs_inode_dotl.c |  94 +++++++++++++++++++++++++++++++----
 include/linux/wait.h   |  15 ++++++
 net/9p/client.c        |   4 +-
 9 files changed, 244 insertions(+), 37 deletions(-)

-- 
2.50.1

