Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923E3B287
	for <v9fs@lists.linux.dev>; Mon, 22 Jan 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924217; cv=none; b=fNLSPixxpgXFMHMSyVmO3CbO6JI+kx1EOaY5+ZW9EhPTY23ChI6SHxw7R9g/S7qjSiAgUGthf6q9mqXZf+z5mTCN46dA1pzSuKcreqtrCN6Le8nVy6OMMaSyhpxnS0NYuIMEkVygD86W2GOpHHmZRZjRiF/3P/Wr9lQ5V1aYEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924217; c=relaxed/simple;
	bh=kFnATUc6YR+2EBGeiZ34YCxV4uvK7zx2v+t9COfwuaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dX41hiF2CN00wdpfqPq+TeTS9OmuXTI4a620almeCa8ApctDrhNQiZn5fWBgbv6BDbPRKFQVCd7R1TqWWbiALwx5qJeXFwGaubW7DDMTgobEpCfwg2bzFiM8lL6VE/HAO8yHkegFDMZS6sTln8ihkib73PwPz3zs3vG/zEcNxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gh9NK/GY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh9NK/GY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705924214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qWBG3EUB+eR+nnWK36e3AyikYbZKtHzO5qoTjiHlzFA=;
	b=Gh9NK/GYe804+99OMyP7/2n8XBvc0SJr63Espxk84gFjniL4ZxCFt7ZS+mrvhRU21V092q
	BNh7c8gz+vNcwdknqyEqkjGVXp2JZNijqp8qErvdWIUIUOTn2sYnOrsc02KSNfEV4ZuhnE
	Xuc0GuGB7+4jtpSI3eRZRnr2YoMDIlI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-dkNhJT87Mlyeyizr-tyMEA-1; Mon, 22 Jan 2024 06:50:12 -0500
X-MC-Unique: dkNhJT87Mlyeyizr-tyMEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0238684852A;
	Mon, 22 Jan 2024 11:50:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E527B111E40C;
	Mon, 22 Jan 2024 11:50:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netfs@lists.linux.dev
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] netfs, cachefiles: Update MAINTAINERS records
Date: Mon, 22 Jan 2024 11:49:59 +0000
Message-ID: <20240122115007.3820330-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Update the MAINTAINERS records for netfs and cachefiles to reflect a change of
mailing list for both as Red Hat no longer archives the mailing list in a
publicly accessible place.

Also add Jeff Layton as a reviewer.

The patches are here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/

tagged as netfs-lib-20240122.

Thanks,
David

David Howells (2):
  netfs, cachefiles: Change mailing list
  netfs: Add Jeff Layton as reviewer

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

