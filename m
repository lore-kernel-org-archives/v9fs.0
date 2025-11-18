Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC2377E94
	for <v9fs@lists.linux.dev>; Tue, 18 Nov 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483488; cv=none; b=eKZox+id2oI/g8S2QJS+QDQ1YEFMnykIEiJicD8MnH9T27e7QOCbBE5Ql87YsktufTSOznMCPgdo3quxgB1wPTtxk13ScFDD6I39/W+eL9oTzWLxpz7e5qUs2Ud/G6ffl2ZMrX+Lo/mgfci7sCl3vBGb7jFkohqqYwIAsJh1APY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483488; c=relaxed/simple;
	bh=4RtECNvLywbzhncQAV7DxlF/biLommhukEMIgucPMzw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=EDL5tGvCIz6z4bZDTqdNsRBqPs9VXBuRtKcoUMTOj/8+J7T1679ezNFzwxnVjon6yNY82FAv8Zp7mCIHR9fal6bRHeLWoxtAQ/j0KtFPHhPS+GDio8yjDzWPZXbvxZsupoRJ0J7X5Sf1EgeZK+FMuyQvaUB5aBm0sxDx6jNLFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMaeP9rv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMaeP9rv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763483485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RtECNvLywbzhncQAV7DxlF/biLommhukEMIgucPMzw=;
	b=VMaeP9rvRYZLSnhpxQkxNWt34MKAIRoTdBJTVNWYX2QeSPsSp2Hq+TwgTwQTW2r50Gu83R
	QUsDZ6lEZQ7muq9ms4UR/arI8RrV4ZWwJvtcy0Ld9iwwee8eYvKSdtu/E6Gvvt7vdHo8/D
	hNhOstQ50ZDxTzBrIlxY9XlnpvftcFo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-F6CGGqJIOTuKzJBaocnSMA-1; Tue,
 18 Nov 2025 11:30:40 -0500
X-MC-Unique: F6CGGqJIOTuKzJBaocnSMA-1
X-Mimecast-MFC-AGG-ID: F6CGGqJIOTuKzJBaocnSMA_1763483439
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A51C180056E;
	Tue, 18 Nov 2025 16:30:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB1A1180058A;
	Tue, 18 Nov 2025 16:30:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <691bd66a.a70a0220.3124cb.00ae.GAE@google.com>
References: <691bd66a.a70a0220.3124cb.00ae.GAE@google.com>
To: syzbot <syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, asmadeus@codewreck.org, brauner@kernel.org,
    ericvh@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org,
    linux_oss@crudebyte.com, lucho@ionkov.net, max.kellermann@ionos.com,
    syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] INFO: task hung in v9fs_evict_inode
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2202485.1763483433.1@warthog.procyon.org.uk>
Date: Tue, 18 Nov 2025 16:30:33 +0000
Message-ID: <2202486.1763483433@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

#syz fix: netfs: fix reference leak

