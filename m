Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3024211
	for <v9fs@lists.linux.dev>; Mon, 23 Oct 2023 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="JoAGkMLw";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="yTkF16U1"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 446C0C027; Tue, 24 Oct 2023 01:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698104248; bh=PAQp5SIrJ7XuUtekxxpfQVf8Z9TTes94CioyEDOPYG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JoAGkMLwF/hU60s6Sgh6rf6EguqlKFuoHACG0Fy8iSD+CB2vnarVD57Z++VTvSxAe
	 xCNg8/ezhNR/eerd763GH06GEG2fjtZ7UdP0g//Kj/hYtR5zfVIkC2YUxqnkniHvLY
	 jYO0BBOKNLelxt6ZVXTeCxmq57ssiPf2r+PjlCO9s1K/AZQYAGncXc3tghwCOE4Rnb
	 +dQdkHTp9MNOo9fOOnD6MwFCytqnTjIBqTwKj0gSenKAqFp8M8LEl4oLGpmNcGRwKR
	 jrm9szAuoRa7U64tQVtaQtjEfGyA96vtgHPih25D18Gj5h47sIFsr39GbU5ZuL53fK
	 roNPIulDdFgOg==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id D30EAC009;
	Tue, 24 Oct 2023 01:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698104247; bh=PAQp5SIrJ7XuUtekxxpfQVf8Z9TTes94CioyEDOPYG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yTkF16U1S0b5LURxbJwpDpE8+qs0L83azlbkQc8rpwPkYLUiztpmKeMRFHxtjkwEO
	 uPiqz3RQGZO7C4oVxea87MzcKR71nqC8b7HgbhaiPh8A3voiGHGEYfi8XeCVdfXBdN
	 QGv0WKg/jWAB64PEbFEc18LG4kFh5OzMcnn0VVgT3o/c/mmC7TH+2iEO+9ne0CPsxI
	 9Hg9gNFAjAEQHOQVL8ylY97Wlw4a11NQKhnhPEdlEHqdoNjxMPsQsvtPYqx5aY4DO+
	 3VDoLhOChf5YgixX329Sk8PgD6Oq/2wJ85b1Vok7JZQp3uQX3p6nQAbRefi4NRCT24
	 79aw9kHvY/ulg==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia (OpenSMTPD) with ESMTP id 0a3de4cb;
	Mon, 23 Oct 2023 23:37:17 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: v9fs@lists.linux.dev,
	ericvh@kernel.org,
	linux_oss@crudebyte.com
Cc: lucho@ionkov.net,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 3/3] 9p/net: xen: fix false positive printf format overflow warning
Date: Tue, 24 Oct 2023 08:37:04 +0900
Message-ID: <20231023233704.1185154-4-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023233704.1185154-1-asmadeus@codewreck.org>
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use a local variable to make the compiler happy about this warning:
net/9p/trans_xen.c: In function ‘xen_9pfs_front_changed’:
net/9p/trans_xen.c:444:39: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 8 [-Wformat-overflow=]
  444 |                 sprintf(str, "ring-ref%d", i);
      |                                       ^~
In function ‘xen_9pfs_front_init’,
    inlined from ‘xen_9pfs_front_changed’ at net/9p/trans_xen.c:516:8,
    inlined from ‘xen_9pfs_front_changed’ at net/9p/trans_xen.c:504:13:
net/9p/trans_xen.c:444:30: note: directive argument in the range [-2147483644, 2147483646]
  444 |                 sprintf(str, "ring-ref%d", i);
      |                              ^~~~~~~~~~~~
net/9p/trans_xen.c:444:17: note: ‘sprintf’ output between 10 and 20 bytes into a destination of size 16
  444 |                 sprintf(str, "ring-ref%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/9p/trans_xen.c: In function ‘xen_9pfs_front_changed’:
net/9p/trans_xen.c:450:45: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 2 [-Wformat-overflow=]
  450 |                 sprintf(str, "event-channel-%d", i);
      |                                             ^~
In function ‘xen_9pfs_front_init’,
    inlined from ‘xen_9pfs_front_changed’ at net/9p/trans_xen.c:516:8,
    inlined from ‘xen_9pfs_front_changed’ at net/9p/trans_xen.c:504:13:
net/9p/trans_xen.c:450:30: note: directive argument in the range [-2147483644, 2147483646]
  450 |                 sprintf(str, "event-channel-%d", i);
      |                              ^~~~~~~~~~~~~~~~~~
net/9p/trans_xen.c:450:17: note: ‘sprintf’ output between 16 and 26 bytes into a destination of size 16
  450 |                 sprintf(str, "event-channel-%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is no change in logic: there only are a constant number of rings,
and there also already is a BUILD_BUG_ON that checks if that constant
goes over 9 as anything bigger would no longer fit the event-channel-%d
destination size.

In theory having that size as part of the struct means it could be
modified by another thread and makes the compiler lose track of possible
values for 'i' here, using a local variable makes it happy.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
While looking at warnings with W=1, I noticed this one in net/9p.

This is silly but shouldn't hurt, num_rings is never changed so there is
no risk of introducing a race here, it's just helping the compiler a
bit.

net/9p is also now warning-free at W=1

 net/9p/trans_xen.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 1fffe2bed5b0..79e91f31a84a 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -382,7 +382,7 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	struct xenbus_transaction xbt;
 	struct xen_9pfs_front_priv *priv = dev_get_drvdata(&dev->dev);
 	char *versions, *v;
-	unsigned int max_rings, max_ring_order, len = 0;
+	unsigned int num_rings, max_rings, max_ring_order, len = 0;
 
 	versions = xenbus_read(XBT_NIL, dev->otherend, "versions", &len);
 	if (IS_ERR(versions))
@@ -408,15 +408,15 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	if (p9_xen_trans.maxsize > XEN_FLEX_RING_SIZE(max_ring_order))
 		p9_xen_trans.maxsize = XEN_FLEX_RING_SIZE(max_ring_order) / 2;
 
-	priv->num_rings = XEN_9PFS_NUM_RINGS;
-	priv->rings = kcalloc(priv->num_rings, sizeof(*priv->rings),
+	num_rings = priv->num_rings = XEN_9PFS_NUM_RINGS;
+	priv->rings = kcalloc(num_rings, sizeof(*priv->rings),
 			      GFP_KERNEL);
 	if (!priv->rings) {
 		kfree(priv);
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < priv->num_rings; i++) {
+	for (i = 0; i < num_rings; i++) {
 		priv->rings[i].priv = priv;
 		ret = xen_9pfs_front_alloc_dataring(dev, &priv->rings[i],
 						    max_ring_order);
@@ -434,10 +434,11 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	if (ret)
 		goto error_xenbus;
 	ret = xenbus_printf(xbt, dev->nodename, "num-rings", "%u",
-			    priv->num_rings);
+			    num_rings);
 	if (ret)
 		goto error_xenbus;
-	for (i = 0; i < priv->num_rings; i++) {
+
+	for (i = 0; i < num_rings; i++) {
 		char str[16];
 
 		BUILD_BUG_ON(XEN_9PFS_NUM_RINGS > 9);
-- 
2.41.0

