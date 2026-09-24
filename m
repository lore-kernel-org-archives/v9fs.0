Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1863CF673
	for <v9fs@lists.linux.dev>; Thu, 24 Sep 2026 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267042; cv=none; b=t/BMnLDbPjwKeIw8Wue7nzez3sJVhm/8233OnVtWOHZ+iVtb3FuWXrHGn+3E2kLDbpiUOUpz41NQEjwAS7jTEu8GmMaDx4FDSQbeI4ibxFz2G7wEO2uINQaHStk2hcv9DUEPDV23Q8nTHurpol24yNwnUDEZXiblf1/zy9zk3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267042; c=relaxed/simple;
	bh=rqio99upVAJ7C6Rf092hVZNKwWV3ukao8wbrKGSv4sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FiOm0vUGnbdtBMkY5O7XhH3bu73Ibhlrs1AQOsaupVWOEg3y51C8vd3zcGXzHbZh3T12cnYzecPUeAsnXc6jjnlyMNdCb7jGeQUFGNRHrUGSFxboLhBZIqrESmRTom/5CQmXCL+AxpMXWCFveshIAN0JvP5aO+2emdCaydcm5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HR6d0dgu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HR6d0dgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790267041; x=1821803041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rqio99upVAJ7C6Rf092hVZNKwWV3ukao8wbrKGSv4sk=;
  b=HR6d0dguNCx17wBKp17LS2jGeozpnmWHb0/bPVmyj5kOtTo9z+w66FxH
   CpzU5sH99BUu0e9ARAH3pfgBOwHXcHWADdAJE71hA4R/zwiQeXZ8SCdC2
   w9lBa1V/5jgdIaSqlSB1c8Z9P//Z5Y88oFzbRY3jEenZ8yryg4vGXcpTp
   i6KdUr+BLj6uQ/1LBFPMtdVm8z37GkrsfjCfZiJq7wPnWGDELnDoylvkc
   E4PXRsFGcjILUgpw+3G+xJZg72jYoU+38O/EuxGesDpLbxx+bqvYco+Jp
   51efKOwdDVIKW3gF2lbtz2z8PcehbwoJv00kSmvDvRUq6yXP2PGN6FeqY
   A==;
X-CSE-ConnectionGUID: x5n9oVLvQVGPYAm2B/xgaw==
X-CSE-MsgGUID: OfC1oGG4S/yp+wXpwVe0AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90268856"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90268856"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:24:01 -0700
X-CSE-ConnectionGUID: ICPaz6zwRRKjcA4JsbiaSg==
X-CSE-MsgGUID: kUju4Il1QIKhhalZTmUVbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="271897486"
Received: from aborzesz-mobl3.igk.intel.com ([10.237.140.166])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:23:58 -0700
From: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	mika.westerberg@linux.intel.com,
	andreas.noever@gmail.com,
	YehezkelShB@gmail.com,
	corbet@lwn.net
Cc: linux-usb@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux_oss@crudebyte.com,
	alan.borzeszkowski@linux.intel.com
Subject: [PATCH 0/3] net/9p: Add 9P transport over USB4STREAM
Date: Thu, 24 Sep 2026 18:23:30 +0200
Message-ID: <20260924162333.147033-1-alan.borzeszkowski@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds trans=thunderbolt, a 9P transport over the
Thunderbolt/USB4 DMA tunnels exposed by the tbstream character devices
(USB4STREAM). It's designed for simple host-to-host file sharing over
single Thunderbolt/USB4 cable.

Today the only practical way to use 9P over a USB4 link is trans=fd
which, due to its design, cannot fully utilize USB4STREAM capabilities.
Thunderbolt transport offers a simpler mount (no fd redirection required),
busy-poll support and substantial throughput increase compared to FD
transport.

User may mount 9P export with following command:

mount -t 9p -o trans=thunderbolt,aname=<exported_remote> /dev/tbstreamX /mnt

Thunderbolt transport achieves a median 1.21x more throughput compared
to FD transport under same conditions, and the advantage grows with
concurrency: 1.03-1.09x at 1-2 threads, 1.14-1.27x at 4, and 1.34-2.28x
at 8-16.

As an example, 4K random reads, 4 worker threads. FD transport achieves
~53k IOPS, Thunderbolt transport ~66k (+24.7%). 4K random writes follow:
FD ~28k IOPS, Thunderbolt ~33k (+19.4%).

With busy-poll enabled, throughput drastically increases for
single-threaded workloads. 4K random read, 1 thread: FD transport 12,345
IOPS, Thunderbolt 12,843 IOPS (+4%), Thunderbolt + busy-poll 22,262 IOPS
(+80.3% vs fd). Normally, busy-polling trades lower latency for increase
in CPU usage but measured system CPU usage was lower (23.1% -> 15.2%).

Above is replicated in more practical example: simulated file-manager
style copy (drag&drop in GUI) of extracted Chromium release repo. Copy
from 9P client to 9P server took 22m29s for FD transport, 21m52s for
Thunderbolt transport (-3%), 14m50s for Thunderbolt + busy-poll (-34%).

__Technical details__
'fio' based benchmarks: random read, random write
ioengine=psync, direct I/O, bs=512-128k, numjobs=1-16, rsize=128M,
runtime=60, ramp=5

'GUI' copy simulation: one extracted chromium-156.0.8066.9 release, 4126
MiB, cp -a --no-preserve=ownership.

Testing was done between two hosts over a single Thunderbolt 5 cable,
with diod as the server (version: 1.1.0-24-gde51d1e), fio (version:
3.36) on modified v7.3 kernel, Ubuntu 24.04 LTS.
Every transport ran on default settings: "msize=131096, cache=none,
version=9p2000.L". Each scenario result is 3-run median. Between each
run, 9P FS was remounted and page cache was dropped on both server and
client.

Alan Borzeszkowski (3):
  thunderbolt: stream: Add tbstream_dev_from_file()
  net/9p/thunderbolt: Add native 9P Thunderbolt transport support
  Documentation/fs/9p: Add Thunderbolt transport documentation

 Documentation/filesystems/9p.rst   |  39 +++-
 MAINTAINERS                        |   1 +
 drivers/thunderbolt/stream.c       |  16 ++
 include/linux/thunderbolt_stream.h |  14 ++
 net/9p/Kconfig                     |   7 +
 net/9p/Makefile                    |   4 +
 net/9p/trans_thunderbolt.c         | 348 +++++++++++++++++++++++++++++
 7 files changed, 419 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/thunderbolt_stream.h
 create mode 100644 net/9p/trans_thunderbolt.c


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

