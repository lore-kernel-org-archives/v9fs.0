Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355E3FE22
	for <v9fs@lists.linux.dev>; Mon, 22 Jan 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927168; cv=none; b=O9yB0tbs8FykN1AzQmKDavY3KXdNlXmdXobC7sHrZQBjHkW2oXTKGVTsu1cl/2aajUV45WCOjMrzc2cgTSJs9NVxvyrTHqhsO0PVoYtpX2rxEjdd/cXMeSfWDF7P6vFOVbrQy3TPaL5tI7NYVKax0Thc4N+tZK+EWbd4jfQx8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927168; c=relaxed/simple;
	bh=BGYCQmdxuK36T0p5PfoL1bkyJdAK5JMIMZ5+TCMUjLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZXgaD8KxeEapgoR3Pu1wDhGGM9Nd0OXkb6C1b0tVxZswCJINhExmr2QVpvOkXxWcvhHKwDfPHJEqn5PEs9UANkuq1+bVh1l4dD3ZJbjYY3siZQCWM9PHAp3JoOrDHbxByIEwcZVLnoYSrTbjBzCfwmckiCbzeRx2y0p/ax75mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7A7wpnF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7A7wpnF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EbxtrFCFvcK5IiuVsAPW/KUPjjRaC8uqKzNdD5mRDM=;
	b=I7A7wpnF9PS6V0kWAppp1OcOMFrANO2dUfeKcZPrQZ+U/ZKau5YCqUDy7dzzROs/Agu9pe
	mLenogfO9tYutVcTrb3copza0yzavWwd9A0xB2nc85tzzch1ENsgAJNC4d8aQypUK15Xco
	B03A4im6EOjxGw9ExlgOU8IWE5XC2Qw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-cT5bUUrvOPuNd97vS-GVBg-1; Mon, 22 Jan 2024 07:39:19 -0500
X-MC-Unique: cT5bUUrvOPuNd97vS-GVBg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9CAD88D283;
	Mon, 22 Jan 2024 12:39:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E643B492BE2;
	Mon, 22 Jan 2024 12:39:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 10/10] afs: Fix missing/incorrect unlocking of RCU read lock
Date: Mon, 22 Jan 2024 12:38:43 +0000
Message-ID: <20240122123845.3822570-11-dhowells@redhat.com>
In-Reply-To: <20240122123845.3822570-1-dhowells@redhat.com>
References: <20240122123845.3822570-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

In afs_proc_addr_prefs_show(), we need to unlock the RCU read lock in both
places before returning (and not lock it again).

Fixes: f94f70d39cc2 ("afs: Provide a way to configure address priorities")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401172243.cd53d5f6-oliver.sang@intel.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 3bd02571f30d..15eab053af6d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -166,7 +166,7 @@ static int afs_proc_addr_prefs_show(struct seq_file *m, void *v)
 
 	if (!preflist) {
 		seq_puts(m, "NO PREFS\n");
-		return 0;
+		goto out;
 	}
 
 	seq_printf(m, "PROT SUBNET                                      PRIOR (v=%u n=%u/%u/%u)\n",
@@ -191,7 +191,8 @@ static int afs_proc_addr_prefs_show(struct seq_file *m, void *v)
 		}
 	}
 
-	rcu_read_lock();
+out:
+	rcu_read_unlock();
 	return 0;
 }
 

