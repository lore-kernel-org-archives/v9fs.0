Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15ED1AE01D
	for <v9fs@lists.linux.dev>; Mon, 18 Nov 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950627; cv=none; b=H19pJjgDHxVoKQVOrZm8LVfVBAK9yjT6O+pj6w3Ywnfrm5Ns0P9JkP+5mY1umfc0qFsKf2yXXiyiA49jxt3xVW6JW5pxFmAd3Y4FVopaSaYGVFezrHQBDQODK4tr85RtevITcuw2oh83/So7MCqHMuypB/qmSxnHwMXzTFB+Bh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950627; c=relaxed/simple;
	bh=gIYTphgBS/75KlW4jAzpUBgWBLopebYpIzbUsi6RdAU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bwpMyRVf/LntB8ZzGdoj9dzfyZhBtaybS9cJ4EMeMsEmIOvAZubFbnCaYn4x6bLTXFOsV2d09Nauu5+WIesGxau7OmzMH24F3IKwB7Mx2lR4mtWrjOux7ALZI3NnG4AV6EBbvfozH8zSr7YbPyiH9jz8ax6RX090pR+gzFmOBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuzlO3WO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuzlO3WO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731950624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIYTphgBS/75KlW4jAzpUBgWBLopebYpIzbUsi6RdAU=;
	b=ZuzlO3WOk3mRYOwGHu0OjoL74z3zT+GjA+yvnNdOZT92/AdZvu+oaZxEauaYnWYzf02I8x
	yJsdczcPucKkmXGxT72WTew8uBSemBNV6nil5N5/dbryDsSK4OWpL6GThmGyaIDco7OTT+
	dw4Mcb2X1E8kGp70AInNDa5okHvnZrs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-PLDdk2NYMnGQEVEymQMxGw-1; Mon,
 18 Nov 2024 12:23:38 -0500
X-MC-Unique: PLDdk2NYMnGQEVEymQMxGw-1
X-Mimecast-MFC-AGG-ID: PLDdk2NYMnGQEVEymQMxGw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 678801956064;
	Mon, 18 Nov 2024 17:23:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 311F91944CC9;
	Mon, 18 Nov 2024 17:23:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6739490e.050a0220.87769.0000.GAE@google.com>
References: <6739490e.050a0220.87769.0000.GAE@google.com>
To: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, akpm@linux-foundation.org,
    asmadeus@codewreck.org, ericvh@kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux_oss@crudebyte.com, lucho@ionkov.net,
    syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_open
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <949457.1731950611.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Nov 2024 17:23:31 +0000
Message-ID: <949458.1731950611@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git 2aece382e1dadd03231e3133c17ddddd6c6f75bb

