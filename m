Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E47C
	for <v9fs@lists.linux.dev>; Sun,  2 Apr 2023 00:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3914DC433D2
	for <v9fs@lists.linux.dev>; Sun,  2 Apr 2023 00:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680396151;
	bh=CCY5QICc5wcGg1tYLJstemDPyT9rUFxA9FkfhfUAWdI=;
	h=Date:From:To:Subject:From;
	b=aQUhj9pbAygPkTabE/9RWQsts4DmDfA6nl8u6qhca1NDBNY62R0Qjlg7aa8Ktlp6G
	 dfiFvq9Xtsch4VCEBXqHYP6AECHZFapA0Ud490qVKiyC0eXbmwJrDzUCf6MIH5TX1D
	 UMjNA+9PzH2YhZmIBqZLaAACGNqeyGN9tr08rG4VR7CP9royX/lFkZeP6YRa6odC01
	 7FwJykEDInUNzvbZu0cp8VfZfM8DRpJTqNLfbg37B/PG9343UeRcCFIzJhgnYyls+8
	 DQ4SqFMSaGKlJ/83f1fCqQCn9W784zNgBSNv18W6WoiepyNEDQjVdxTnMSEJsl1e7S
	 tnF4Ih8lCJlyw==
Date: Sun, 2 Apr 2023 00:42:28 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: v9fs@lists.linux.dev
Subject: [zyytlz.wz@163.com: [V9fs-developer] [PATCH net v3] 9p/xen : Fix use
 after free bug in xen_9pfs_front_remove due to race condition]
Message-ID: <ZCjPdIkEQ0ALhdUU@7e9e31583646>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

----- Forwarded message from Zheng Wang <zyytlz.wz@163.com> -----

Date: Mon, 13 Mar 2023 22:43:25 +0800
From: Zheng Wang <zyytlz.wz@163.com>
To: ericvh@gmail.com
Cc: lucho@ionkov.net, alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>, 1395428693sheep@gmail.com, netdev@vger.kernel.org, linux_oss@crudebyte.com, linux-kernel@vger.kernel.org, hackerzheng666@gmail.com, v9fs-developer@lists.sourceforge.net, edumazet@google.com, kuba@kernel.org,
	michal.swiatkowski@linux.intel.com, pabeni@redhat.com, davem@davemloft.net
Subject: [V9fs-developer] [PATCH net v3] 9p/xen : Fix use after free bug in xen_9pfs_front_remove due to race condition
X-Mailer: git-send-email 2.25.1

In xen_9pfs_front_probe, it calls xen_9pfs_front_alloc_dataring
to init priv->rings and bound &ring->work with p9_xen_response.

When it calls xen_9pfs_front_event_handler to handle IRQ requests,
it will finally call schedule_work to start the work.

When we call xen_9pfs_front_remove to remove the driver, there
may be a sequence as follows:

Fix it by finishing the work before cleanup in xen_9pfs_front_free.

Note that, this bug is found by static analysis, which might be
false positive.

CPU0                  CPU1

                     |p9_xen_response
xen_9pfs_front_remove|
  xen_9pfs_front_free|
kfree(priv)          |
//free priv          |
                     |p9_tag_lookup
                     |//use priv->client

Fixes: 71ebd71921e4 ("xen/9pfs: connect to the backend")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
v3:
- remove unnecessary comment and move definition to the
for loop suggested by Michal Swiatkowski

v2:
- fix type error of ring found by kernel test robot
---
 net/9p/trans_xen.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index c64050e839ac..df467ffb52d0 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -280,6 +280,10 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 	write_unlock(&xen_9pfs_lock);
 
 	for (i = 0; i < priv->num_rings; i++) {
+		struct xen_9pfs_dataring *ring = &priv->rings[i];
+
+		cancel_work_sync(&ring->work);
+
 		if (!priv->rings[i].intf)
 			break;
 		if (priv->rings[i].irq > 0)
-- 
2.25.1



_______________________________________________
V9fs-developer mailing list
V9fs-developer@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/v9fs-developer

----- End forwarded message -----
