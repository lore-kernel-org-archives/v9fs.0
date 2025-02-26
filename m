Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260CD21D3FC
	for <v9fs@lists.linux.dev>; Wed, 26 Feb 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583290; cv=none; b=Wm0oRc6V53elGsL1Ez6xXDMA9qJXVEJBMl+p6rLXP2bUqtmBMdst9KPjr1cAuB5amXI4TBDMJf9QJwNU2qi79Vca2hQ8wlbkjmUVWpRYTPxIuqnDdS+/QyamHbcD5yArBjUCitEIPOEvwfulBk0RuRmdQVISDLUhTDvZuD5ByeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583290; c=relaxed/simple;
	bh=kGuDluKlBGVXw7uhB+/9lut/CvhX3J7r0WIB6MvbzaM=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=o5BaEb0dWUdRbCANATn4b57G+b7B/G2g8Q/Qfz6CB7ePkt2A9Q/nBWEXddPyVGtMSaeVSM9ax/zB3s2lHLPYZKGerkqhEP3jWu0UFAroKNzJGliFkCqTVBi7MXPmYAQHwLicutqe3UesXskthtu4KzfgPTgC9K2OOgneXn7FDJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpV+3gfG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpV+3gfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740583288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXbyCdmoziShPeJAChKxNKhUqohQ4PH+KJxEBCv0dis=;
	b=CpV+3gfGxu0iBE6OHhv1QWEnIkM6W3GxCT1mIcq+FmvVSY1mM4PWOOo7qELa2pXvOb59pw
	5er+D+cUxkfV25qFlKD0qy3nWLsE5hbUwUYtrdE2f65+TAjaPqRuDSfrMG285TWvbTN8XR
	qPjFnArsfHXuNZWhlxrleDnJroEuyY4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-iwyn0p17N66pFYe-_2Gb-g-1; Wed,
 26 Feb 2025 10:21:25 -0500
X-MC-Unique: iwyn0p17N66pFYe-_2Gb-g-1
X-Mimecast-MFC-AGG-ID: iwyn0p17N66pFYe-_2Gb-g_1740583283
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48D2E1800264;
	Wed, 26 Feb 2025 15:21:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66FA3180035F;
	Wed, 26 Feb 2025 15:21:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <2602345.1740576046@warthog.procyon.org.uk>
References: <2602345.1740576046@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Steve French <stfrench@microsoft.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ihor Solodrai <ihor.solodrai@pm.me>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
    v9fs@lists.linux.dev, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix unbuffered writes
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2616590.1740580941.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Wed, 26 Feb 2025 15:21:17 +0000
Message-ID: <2635841.1740583277@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

David Howells <dhowells@redhat.com> wrote:

> Fixes: 9dc06eff2097 ("netfs: Fix wait/wake to be consistent about the wa=
itqueue used")

Actually, you can ignore this.  It's for a patch that's not upstream and c=
an
be folded in.

David

