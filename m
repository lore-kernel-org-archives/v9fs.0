Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47772219A80
	for <v9fs@lists.linux.dev>; Fri, 24 Jan 2025 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711531; cv=none; b=DS9t0eNc+UODFOxS0Vl++j3q7jNyDUP6+q1NEvadG0vWQzWsdlSIYejY/UsJB25laWc9TTOaesQK5la+XhrXm6dVIZQNFJ8EzoRZxxhvOukp3F0ekBzxGCjDHdzJZWYYed9NY4rjD93IYvU8NjABhC4aYZwP76i6XwgqrWZwYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711531; c=relaxed/simple;
	bh=heMykMP84HxglhMvRYTotO8Dy18zau3k/Uc8oZ452rI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=pd1ysKxpZTAhmXhgPqPopyZUKvUMu7dECy1U16VwX9O6RANIejj5wC8bWXBgjZuZ/nrcxQTPDZ6b57pTZEFxKOpIP3if9yCMSh3VujC7z9OhcbiOset/5blRW3CMnNO99spuCGBxxGeTzTUWvfgC5CXIzw8FXsy+DcYfXtx5qcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsOyB+I6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsOyB+I6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737711528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heMykMP84HxglhMvRYTotO8Dy18zau3k/Uc8oZ452rI=;
	b=fsOyB+I6cOWC9OaNpFAwuWegm1mowa47YAJ2SdVNHoEnT7QYuYYvefqmUdaxGrBmFWeFag
	zGPS6dMmgwIcadKHbcP0JiJKfuDvhBi3GZAN4psRFCEK8tT/BX731fwfGnvZa5L+9qZiAX
	SjR87P3FmZWUA4XP9ny9OsAUFpaZQRY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-_npeT4EEO_CS74jm8UolHw-1; Fri,
 24 Jan 2025 04:38:44 -0500
X-MC-Unique: _npeT4EEO_CS74jm8UolHw-1
X-Mimecast-MFC-AGG-ID: _npeT4EEO_CS74jm8UolHw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47D1119560B2;
	Fri, 24 Jan 2025 09:38:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5FBA30001BE;
	Fri, 24 Jan 2025 09:38:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6792ffb7.050a0220.3ab881.0005.GAE@google.com>
References: <6792ffb7.050a0220.3ab881.0005.GAE@google.com>
To: syzbot <syzbot+1f18c9b1bb51239d82f2@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, akpm@linux-foundation.org,
    asmadeus@codewreck.org, brauner@kernel.org, ericvh@kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux_oss@crudebyte.com, lucho@ionkov.net,
    syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] BUG: stack guard page was hit in sys_openat
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2479146.1737711515.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jan 2025 09:38:35 +0000
Message-ID: <2479147.1737711515@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t ca56a74a31e26d81a481304ed2f631e65883372b

