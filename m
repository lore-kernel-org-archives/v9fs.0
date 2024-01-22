Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472A4CB5F
	for <v9fs@lists.linux.dev>; Mon, 22 Jan 2024 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962789; cv=none; b=Fv94cKNTVCM3+UGqyO5HAhLBLuYEPeKb+AVsDzgXyuPZ01TM1tGaFgY6o7zkquOYHPTYjPByKMvInWqvZr7ommPzXvYbJtqoWwb7HuDbW+jk6uMmK6CtOWdP5R9XgdJj502rEyXN5o8f2T7HNXoxTEJsvOSMwBG5jbTGprOpk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962789; c=relaxed/simple;
	bh=u1NZ5oJ45qo+iUmBVeXgQl020jMPO7hETF1JUMYSA/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1Q01VVUGnlqduLpE6zjwtK1Bbhvu7WEqP3uEDkBxQa2yq9yPSGnNf7DglQP7VRUs7ml19Sd6Swgy0iV7PXvJtVnXeAkkHZY/08pQCohx5jB7c2IKBkDads1e8eeXjf/9xJeyckqKLj8A2ODCc+9yrY6zL7IkgbfnHFynHKb6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6oKNLdl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6oKNLdl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H/QyaTEJT6yM0W34T+DHhl8mPiadWYAfCey1J2x+wk=;
	b=C6oKNLdl2yTtPQ9oCE6wnalo0EfibNNb+PiXqFAgSlamhzWgIKPWvUZA9ioFRWi6DXpv9L
	diNJCKvazSdr2OO6hso0dq90KeGGYEKpK9EU3dPJMIBgCx+f82mdhYLaJjR3OR/keS/RQ/
	ED9di/NB+JA37zKPi6pYc8GPes6u8qE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473--HGPYFG7OMq08y4wHZqsJA-1; Mon, 22 Jan 2024 17:33:01 -0500
X-MC-Unique: -HGPYFG7OMq08y4wHZqsJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F87A185A780;
	Mon, 22 Jan 2024 22:33:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0FAB4C0FDCA;
	Mon, 22 Jan 2024 22:32:57 +0000 (UTC)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH v2 09/10] afs: Remove afs_dynroot_d_revalidate() as it is redundant
Date: Mon, 22 Jan 2024 22:32:22 +0000
Message-ID: <20240122223230.4000595-10-dhowells@redhat.com>
In-Reply-To: <20240122223230.4000595-1-dhowells@redhat.com>
References: <20240122223230.4000595-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Remove afs_dynroot_d_revalidate() as it is redundant as all it does is
return 1 and the caller assumes that if the op is not given.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dynroot.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d3bc4a2d7085..c4d2711e20ad 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -258,16 +258,7 @@ const struct inode_operations afs_dynroot_inode_operations = {
 	.lookup		= afs_dynroot_lookup,
 };
 
-/*
- * Dirs in the dynamic root don't need revalidation.
- */
-static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
-{
-	return 1;
-}
-
 const struct dentry_operations afs_dynroot_dentry_operations = {
-	.d_revalidate	= afs_dynroot_d_revalidate,
 	.d_delete	= always_delete_dentry,
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,

