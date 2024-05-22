Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDF01CAA6
	for <v9fs@lists.linux.dev>; Wed, 22 May 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412341; cv=none; b=QZUJ8BjOitIWUkfSjCUPhjug/6msqcHsTh4h2wWSTLV0226UFyxDivWRi+VLnWc6iH27B/MutnTemZXxt8O6QFtlBvC3nZleQXVsIVQ5PzEgFodmXbZSz33ZDzw3O1nQQIL13m5FiIYQ5MXG6egSY48mslWcQpgD927UO8OUPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412341; c=relaxed/simple;
	bh=DYwtOowSorQf8W/s1eRFLYfspBNq5BINeak1ohYZ0f0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=jky37LRhn9lZRwRck/PAtHhO8VCF0rxuugtnpK8XMXoqaB4x5x9Ka6i4GzKnnmRmRbzzCTj306wdLvIg3U2Fi9LCg5OIArvjmkNztgkRLZM+WpZ51lPa2DlMSLlzGm9ow9YrnID/JDnrPQpfLsU1yQbLTGAovE6YwFK0M5QCZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tliw7wvT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tliw7wvT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716412338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=e5HgR1UJJHE4pqNLP7HJRqo1yRZdPdGaAXEqWOstEzk=;
	b=Tliw7wvTn3g0/mYHB3BcH/xL2sqlYJ1P+xhjTkzOJp2KCojLGGJ/cb0bcozDNpcAlkRaVo
	becUwZnH0HwBZTdHVhXasFXX0EF1oTYHJC8B6bNkMImd2HT/42R0+mBO+z5b1Vq41a7y19
	s+ob2YNwnaVW1otSMPzh/FwX71+Gfik=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-jD23OcejMCWzTI9Q9-d0Eg-1; Wed,
 22 May 2024 17:12:17 -0400
X-MC-Unique: jD23OcejMCWzTI9Q9-d0Eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B79A3C025BA;
	Wed, 22 May 2024 21:12:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44C0E100046D;
	Wed, 22 May 2024 21:12:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>
cc: dhowells@redhat.com, Christian Schoenebeck <linux_oss@crudebyte.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, v9fs@lists.linux.dev,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: Enable multipage folios
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <463765.1716412334.1@warthog.procyon.org.uk>
Date: Wed, 22 May 2024 22:12:14 +0100
Message-ID: <463766.1716412334@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

    
Enable support for multipage folios on the 9P filesystem.  This is all
handled through netfslib and is already enabled on AFS and CIFS also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/9p/vfs_inode.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 7a3308d77606..8c9a896d691e 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -295,6 +295,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 			inode->i_op = &v9fs_file_inode_operations;
 			inode->i_fop = &v9fs_file_operations;
 		}
+		mapping_set_large_folios(inode->i_mapping);
 
 		break;
 	case S_IFLNK:

