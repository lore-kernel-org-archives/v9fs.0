Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D719A298
	for <v9fs@lists.linux.dev>; Fri, 23 Aug 2024 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443736; cv=none; b=qoE9w4nsVmJlF9rcJ4+vp5Ydsw/7Cx0CLBD6tu6qDzSWYjImoltbVVQYRWIAQF5OtQo+wm0aJOVzeB8cLdSl4zFTIOEqSB7QN5iey1nSPYN+1s/qVanfocgANCv76aenfoJeKIBlPaTbR04JmJ5wiqAOft+XdBZj3Fla0aa6IRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443736; c=relaxed/simple;
	bh=ht8EIVhw2/1il8Rsom6afgUGDhA62o/6wQOgoApvk7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBvqdIgBed0evUJtJnTZEqkFq8qWETYv+qXFBJ/w4Lw0VIlx+g137QQJJKTqt+xLszEDuQoIR720qa71bkjKUwgil5nocwcoODKuxVWkCCB+WLM/ygYBkrU3Z1cyW97EslnAwT4PIkZnJpavD2vET2fCH0jaxa9+kH8ZG06Dp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ebc02KxX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ebc02KxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4tfOtZ3an7b1aGGuqLauY14dten5jR69+zwwl0cSBE=;
	b=Ebc02KxXo1EZcK0jc2JKJsAi2xzewLgsNhLSslVIokS+1h+AOXFI6dT5Xz08w3EGim8xwm
	0bUqTVTDoLjM7omnTNgsY7cE9WUVoV8IO2OzeUg0RaslhgJ1zCU0SrPBJgegwy1z9YBHab
	NOQ+9GgxW8kzMy9ZNwv5i7j5rq6xq8Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-JPiGnaA-NR6p3XE_f4cFaQ-1; Fri,
 23 Aug 2024 16:08:49 -0400
X-MC-Unique: JPiGnaA-NR6p3XE_f4cFaQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 385D61955D50;
	Fri, 23 Aug 2024 20:08:47 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8E451955DD8;
	Fri, 23 Aug 2024 20:08:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Paulo Alcantara <pc@manguebit.com>,
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
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 3/9] netfs: Fix netfs_release_folio() to say no if folio dirty
Date: Fri, 23 Aug 2024 21:08:11 +0100
Message-ID: <20240823200819.532106-4-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fix netfs_release_folio() to say no (ie. return false) if the folio is
dirty (analogous with iomap's behaviour).  Without this, it will say yes to
the release of a dirty page by split_huge_page_to_list_to_order(), which
will result in the loss of untruncated data in the folio.

Without this, the generic/075 and generic/112 xfstests (both fsx-based
tests) fail with minimum folio size patches applied[1].

Fixes: c1ec4d7c2e13 ("netfs: Provide invalidate_folio and release_folio calls")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240815090849.972355-1-kernel@pankajraghav.com/ [1]
---
 fs/netfs/misc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 554a1a4615ad..69324761fcf7 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -161,6 +161,9 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	struct netfs_inode *ctx = netfs_inode(folio_inode(folio));
 	unsigned long long end;
 
+	if (folio_test_dirty(folio))
+		return false;
+
 	end = folio_pos(folio) + folio_size(folio);
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;

