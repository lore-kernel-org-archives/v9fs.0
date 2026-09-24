Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E503EFFA6
	for <v9fs@lists.linux.dev>; Thu, 24 Sep 2026 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267051; cv=none; b=tnzrbkg7PxGpe1Lk+Dv8pRGFxqgKRQpsNwCoCQMmfcr/GVLXVQfsrM3zefJ+y8AgnLfsXBgewTOtbhwv1LNT8FAbFZ8JPxWLmWsn9ihsRPg3EJ5bjDtnFvviriJ/IbyCn3Xo6WE1bCjV0jDeBrwg274eSeifr4zvqNXvPoevfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267051; c=relaxed/simple;
	bh=FhGk2HhpUvAduRtmcq1/sDWlni9c97uqUG0t/PQsHCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Or9uw3lGYzNcX5cP2SJliTr/LHARzEnWCJdbTCYUBAJZ7C3ykxL5dRAH9zEVMZAXp6LaE15WB7iOZN3EO7NmdH3ZuDYaFrWanyDbUp0+ucb8GRqTwnvPj3S3snEdJUfLmLIoGQ6Ko1cR4BvfpqzdJ6JXFBJJiHrde19x5t7Ppeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hr0//+Ml; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hr0//+Ml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790267051; x=1821803051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FhGk2HhpUvAduRtmcq1/sDWlni9c97uqUG0t/PQsHCU=;
  b=Hr0//+Ml7Xq/riog2T/DK5pLi/LiSQG9/Jceb9PwREYcwxiBWNO5THV5
   qCls3JI9rRMzsBProtZO4cpYbbDx6pvKYvBn/q+dzUKHSyJkbxyjHkbYJ
   E8kqcEgDnCr27HCDjKh8jobnEb34+MWpbLGZAu/o5L/uEmCpe49zZb12k
   gbrVXIaB3SwMG42QJzBUdoLScDtcbpigSX5sd2lhaJoNC8TqsFYu1JO8f
   x1VszrtFcA/A2XfWv/NZz+gVpYZSO/YY0eb1M9nKJXeznmfqdbw9vJ1oD
   b3ZXOnmrZkdMnC8FdN1Nt9nr6iZhOGtTs49sOGl0qKIgFa4IG8MvUQnRj
   w==;
X-CSE-ConnectionGUID: yRIr5YOsTpCHZKf3qgAhfw==
X-CSE-MsgGUID: 12ShGh+YQm+Or/HGhC4XGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90268896"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90268896"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:24:11 -0700
X-CSE-ConnectionGUID: /DjJqnKkT/6JY5DfO7D3Kg==
X-CSE-MsgGUID: wfvFi20dQmC8nwhI3lFQMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="271897547"
Received: from aborzesz-mobl3.igk.intel.com ([10.237.140.166])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:24:08 -0700
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
Subject: [PATCH 3/3] Documentation/fs/9p: Add Thunderbolt transport documentation
Date: Thu, 24 Sep 2026 18:23:33 +0200
Message-ID: <20260924162333.147033-4-alan.borzeszkowski@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924162333.147033-1-alan.borzeszkowski@linux.intel.com>
References: <20260924162333.147033-1-alan.borzeszkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With new 9P Thunderbolt transport added, update documentation with
simple usage guide.

Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
---
 Documentation/filesystems/9p.rst | 39 ++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 3f65db648db0..d79082b320ba 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -50,6 +50,24 @@ mount points. Each 9P export is seen by the client as a virtio device with an
 associated "mount_tag" property. Available mount tags can be
 seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_tag files.
 
+Thunderbolt/USB4 Usage
+======================
+
+Establish USB4STREAM between two machines (see Documentation/admin-guide/thunderbolt.rst).
+Export filesystem on server machine (e.g., using diod). Example::
+
+	diod -f -n -S -e /srv/shared -r 3 -w 4 3</dev/tbstream0 4>/dev/tbstream0
+
+Mount remote filesystem on client machine using::
+
+	mount -t 9p -o trans=thunderbolt,aname=<exported_remote_dir > /dev/<USB4STREAM_device> /mnt/9
+
+where USB4STREAM device is 'tbstreamX'.
+
+Example::
+
+	mount -t 9p -o trans=thunderbolt,aname=/srv/shared /dev/tbstream0 /mnt
+
 USBG Usage
 ==========
 
@@ -112,16 +130,17 @@ Options
   trans=name	select an alternative transport.  Valid options are
   		currently:
 
-			========  ============================================
-			unix 	  specifying a named pipe mount point
-			tcp	  specifying a normal TCP/IP connection
-			fd   	  used passed file descriptors for connection
-                                  (see rfdno and wfdno)
-			virtio	  connect to the next virtio channel available
-				  (from QEMU with trans_virtio module)
-			rdma	  connect to a specified RDMA channel
-			usbg	  connect to a specified usb gadget channel
-			========  ============================================
+			===========  =========================================
+			unix	     specifying a named pipe mount point
+			tcp	     specifying a normal TCP/IP connection
+			fd	     used passed file descriptors for connection
+				     (see rfdno and wfdno)
+			virtio	     connect to the next virtio channel available
+				     (from QEMU with trans_virtio module)
+			rdma	     connect to a specified RDMA channel
+			usbg	     connect to a specified usb gadget channel
+			thunderbolt  connect using USB4STREAM
+			===========  =========================================
 
   uname=name	user name to attempt mount as on the remote server.  The
   		server may override or ignore this value.  Certain user
-- 
2.53.0

