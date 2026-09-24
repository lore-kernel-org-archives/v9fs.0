Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6AF3F104E
	for <v9fs@lists.linux.dev>; Thu, 24 Sep 2026 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267045; cv=none; b=XhRt4fxUBCvBM6T+9vedZIlLE8SGczDSIAA3lMYQleRlMTG/Sde/ZLETLd/j875qvaH13gW6BxmAX2aUkEbS6xi0jI1PDAonEITq6H3PJPJlK/GhdBs2hiYMqZclAcg9mU3nxad/Knx9t5l5z/dGAl9vlxs5i/W1nXnMy3YN2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267045; c=relaxed/simple;
	bh=m6cxKDEoXosE/zCn8ulR1SmSKjSt+tIz/1re3xa+M1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQHvAGb8KRLdNR94mFls4n8SVull/RUgbPI3tq8y1hAtollBVoSgVlP5tYoToex+Yx2kpPM59huhj+r/fNKGYwWNgVOmeQmz5rPMBWt0MU7OQ0Q4mielSVBugo9OtjGetU29ieLyPUovRxyRdIsuhKiQNLYJfP5eBOS9CbScHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkSWWc/W; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkSWWc/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790267044; x=1821803044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m6cxKDEoXosE/zCn8ulR1SmSKjSt+tIz/1re3xa+M1s=;
  b=DkSWWc/W/XmtqupbrepUSvh4ZFF8pvBn8Rijn6BxgW9H2whkHiUFcNca
   5kbIWIaiPkgKkwPFXO/PNSMQ0Mmks+lm4Yi1sKfZsFz78DEZnQ9C9Ffme
   ETyLgIC3jL4vF1gqtV5QnwsfYfsdDHiIAebLR4GZo0gLBl8RYvY6yeAvN
   lk9fTVPpXNVOvUZ03TnjK6XTzQGyNy4+uCXo0qYLn7yPT+xmvGUOJCT+M
   FktOogHUy4yp+1h/6KUI+qNDY6eKGQ9zB/TZtsczw2xw1IQUX5WWDnfBS
   P1TgFPLRiRy5GEwNI2oNyUTHLNiTneFoBe6apxXIvuLs0tTX4yBHL7daO
   A==;
X-CSE-ConnectionGUID: yfWFiw+jRh2/tezEYq+Vgw==
X-CSE-MsgGUID: RiUE6ur8TdiiSWOtTvFCbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90268870"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90268870"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:24:04 -0700
X-CSE-ConnectionGUID: sl2zOiMLSe+in/LWLPtgMw==
X-CSE-MsgGUID: Ek5ZdVY7RnG+0Xn7juwXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="271897522"
Received: from aborzesz-mobl3.igk.intel.com ([10.237.140.166])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:24:01 -0700
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
Subject: [PATCH 1/3] thunderbolt: stream: Add tbstream_dev_from_file()
Date: Thu, 24 Sep 2026 18:23:31 +0200
Message-ID: <20260924162333.147033-2-alan.borzeszkowski@linux.intel.com>
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

Add tbstream_dev_from_file() which returns USB4STREAM device behind a
file. Expose it to in-kernel users via separate header.

Required by the 9P Thunderbolt transport driver to validate mount
source.

Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
---
 MAINTAINERS                        |  1 +
 drivers/thunderbolt/stream.c       | 16 ++++++++++++++++
 include/linux/thunderbolt_stream.h | 14 ++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 include/linux/thunderbolt_stream.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b..a626e81d1724 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27211,6 +27211,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
 F:	Documentation/admin-guide/thunderbolt.rst
 F:	drivers/thunderbolt/
 F:	include/linux/thunderbolt.h
+F:	include/linux/thunderbolt_stream.h
 
 THUNDERBOLT NETWORK DRIVER
 M:	Mika Westerberg <westeri@kernel.org>
diff --git a/drivers/thunderbolt/stream.c b/drivers/thunderbolt/stream.c
index 25c259dd0760..d6d0aafd5984 100644
--- a/drivers/thunderbolt/stream.c
+++ b/drivers/thunderbolt/stream.c
@@ -21,6 +21,7 @@
 #include <linux/poll.h>
 #include <linux/sizes.h>
 #include <linux/thunderbolt.h>
+#include <linux/thunderbolt_stream.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
 #include <linux/uuid.h>
@@ -1024,6 +1025,21 @@ tbstream_dev_from_group(struct config_group *group)
 	return container_of(group, struct tbstream_dev, group);
 }
 
+/**
+ * tbstream_dev_from_file() - Return USB4STREAM device behind a file
+ * @file: File to check
+ *
+ * Return: Pointer to &struct tbstream_dev, %NULL if file is not
+ * USB4STREAM device.
+ */
+struct tbstream_dev *tbstream_dev_from_file(struct file *file)
+{
+	if (file->f_op != &tbstream_dev_fops)
+		return NULL;
+	return to_tbstream_dev(file->private_data);
+}
+EXPORT_SYMBOL_GPL(tbstream_dev_from_file);
+
 static ssize_t tbstream_dev_busy_poll_show(struct config_item *item, char *buf)
 {
 	struct config_group *group = to_config_group(item);
diff --git a/include/linux/thunderbolt_stream.h b/include/linux/thunderbolt_stream.h
new file mode 100644
index 000000000000..ed4fdba7c7e9
--- /dev/null
+++ b/include/linux/thunderbolt_stream.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Thunderbolt Stream API
+ *
+ * Copyright (C) 2026, Intel Corporation
+ * Author: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
+ */
+
+#ifndef THUNDERBOLT_STREAM_H_
+#define THUNDERBOLT_STREAM_H_
+
+struct tbstream_dev *tbstream_dev_from_file(struct file *file);
+
+#endif /* THUNDERBOLT_STREAM_H_ */
-- 
2.53.0

