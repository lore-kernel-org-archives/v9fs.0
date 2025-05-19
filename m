Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061372868A2
	for <v9fs@lists.linux.dev>; Mon, 19 May 2025 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662562; cv=none; b=PS8hidZHGQ56ny2iUEhXselPiO70TNO1RoSYqy+iLhGI3eLfdHJOqJfL64dTRoj6DZfWUtlDhiWOv1+6mRaGh5Mujv7QSg1Oj636nxX1lRWhVk7hDuJ4/jmhZynAC+NvjMqHtmqAMYJ3L1U5HQREEz3BiBuwRjGfOvse1VWPZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662562; c=relaxed/simple;
	bh=UQ0cVD8PWkvT8jlhZUV+XUvdN47Ob5Qg52MRqqt3PNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJufw2XqzaU3dnbWXq7eDHWR5VAyPdqtyxegdUbmNZ9JHaBDrPsBfzijCQJBWdAsicGrhZp2V1E243tMe91jm5uYX1zaEJuz02fs4NzrpEl4dyrzDeScVRIw7FmNALw+J7bpSfpWTyfVGy1ZMdQ7Q+q1K5FDHZY3x71LxhRm7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAznuWOz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAznuWOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrkXwa+wnuaa+7IehaO8eRWWRLKAWBjLnJR/skFweO8=;
	b=TAznuWOzH/Rm7Z9mBRN72bFJGdNeO10gtBFfrrURo6YIuNVh/K8SKTe2RprhqmaSsrdIvS
	T+11VIJpA6CjQ+CbNK6NN6wBv4HiXJ/QyxOZzZMZCR8xggpXr7e3/wENhB25+4UtdrFajp
	PWKOZ/kmSkvNYqkJt7sEOpa4USaQL0M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-zX5ujFk8PWm6jiFe1yfATA-1; Mon,
 19 May 2025 09:49:17 -0400
X-MC-Unique: zX5ujFk8PWm6jiFe1yfATA-1
X-Mimecast-MFC-AGG-ID: zX5ujFk8PWm6jiFe1yfATA_1747662556
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DCD3180045B;
	Mon, 19 May 2025 13:49:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 156FB1956096;
	Mon, 19 May 2025 13:49:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] fs/netfs: remove unused flag NETFS_RREQ_DONT_UNLOCK_FOLIOS
Date: Mon, 19 May 2025 14:48:06 +0100
Message-ID: <20250519134813.2975312-11-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Max Kellermann <max.kellermann@ionos.com>

NETFS_RREQ_DONT_UNLOCK_FOLIOS has never been used ever since it was
added by commit 3d3c95046742 ("netfs: Provide readahead and readpage
netfs helpers").

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c | 14 ++++++--------
 include/linux/netfs.h   |  1 -
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 23c75755ad4e..173433d61ea6 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -83,14 +83,12 @@ static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
 	}
 
 just_unlock:
-	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
-		if (folio->index == rreq->no_unlock_folio &&
-		    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags)) {
-			_debug("no unlock");
-		} else {
-			trace_netfs_folio(folio, netfs_folio_trace_read_unlock);
-			folio_unlock(folio);
-		}
+	if (folio->index == rreq->no_unlock_folio &&
+	    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags)) {
+		_debug("no unlock");
+	} else {
+		trace_netfs_folio(folio, netfs_folio_trace_read_unlock);
+		folio_unlock(folio);
 	}
 
 	folioq_clear(folioq, slot);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 3f7056d837f8..5f60d8e3a7ef 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -266,7 +266,6 @@ struct netfs_io_request {
 	unsigned long		flags;
 #define NETFS_RREQ_OFFLOAD_COLLECTION	0	/* Offload collection to workqueue */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on completion */
-#define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
 #define NETFS_RREQ_FOLIO_COPY_TO_CACHE	6	/* Copy current folio to cache from read */

