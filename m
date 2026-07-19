Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172B78F4A
	for <v9fs@lists.linux.dev>; Sun, 19 Jul 2026 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784433838; cv=none; b=TEnMt7BCRbcnVr5xiJR6sXEaPBA21Iwfht56ovdTghA87anX7RSkhzWF4n2KRvXi2BvKTM4EPqhGStqMduzdU1hKq++ghFQyLdIIf836u0gO4siT8+meCmYUHD6N0xRiIYEnCmGH1vzbhNXvz6jDvZgSwgkQEHKbvJiM6Em0NyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784433838; c=relaxed/simple;
	bh=n7ct/VAP6g4Sck65eF/mdDCobwbWBRo/Rd9yZL7H9+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frpkByeuhdUiXtiTHTmziW+iC+MAE38k1PcpNqfQoATWfpB9Xv0WmN572Y1A3L+j/SqRhgTFzO6NSPyUQmDhU/cpny77TP2KQX4ORNdrHDTFW84jrG7wNUQArMWigBBx0W/danMqWFNulJe5aUynQ5ZuOv2wtB6EhfU3EW8Etlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xiaxs+xY; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xiaxs+xY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784433833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sCcCuY2na2wZIYGwcY05Wr84TQQ+PgKbwKFFTMEg7pI=;
	b=Xiaxs+xYvmbcePfr3dCtOR+896mDwr1e7FLfkl8kP3/9AGRsC+e/fDWV4oQufEfvqCSfC/
	7FRJzxz5MDJxP9dltUEWxicQBhJ+Co0X4fjk6GKUzKYRmzyVyLIAifEaxR763lYCZEAJzd
	qrWXHBIlKV53OPkHp9zeVF9SYrYHWkI=
From: Jackie Liu <liu.yun@linux.dev>
To: ericvh@kernel.org
Cc: asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	v9fs@lists.linux.dev
Subject: [PATCH] net/9p/usbg: require an exact match for device tags
Date: Sun, 19 Jul 2026 12:03:46 +0800
Message-ID: <20260719040346.88295-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

p9_usbg_create() compares only strlen(devname) bytes while looking up the
configfs instance named by the mount source. A source that is a prefix of
an instance name therefore selects that instance. For example, source
"foo" binds the "foobar" channel instead of failing with -ENOENT.

The configfs layer passes the instance name to usb9pfs_set_inst_tag(), and
the transport already uses full string comparisons to keep these names
unique. Use an exact match for mount lookup too.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 net/9p/trans_usbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 419cda13a7b5..884d6f4af50c 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -391,7 +391,7 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 	guard(mutex)(&usb9pfs_lock);
 
 	list_for_each_entry(dev, &usbg_instance_list, usb9pfs_instance) {
-		if (!strncmp(devname, dev->tag, strlen(devname))) {
+		if (!strcmp(devname, dev->tag)) {
 			if (!dev->inuse) {
 				dev->inuse = true;
 				found = 1;
-- 
2.54.0

