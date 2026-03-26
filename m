Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7D392C42
	for <v9fs@lists.linux.dev>; Thu, 26 Mar 2026 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523445; cv=none; b=c6Srzo5B6x60HA7m/qQOo6An1N/q1ch9mQ4s4wP5d0ToaY3j/Gfoqyh9Qxd2kXGH/K0ZFULEIgQxB4844s+AUAXA6wUYR8e4seQN0ZYBm6sZ0rutsCOCoPSiMVryXluf3G+76dGWS+X/t/Isr9OlJbGE539AGaceqfPnjtzbrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523445; c=relaxed/simple;
	bh=jBdoDVkrHo4frDWBxHqqyQ2bl1+2xzRX8rlOxpufM+I=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=iagWd1yA7fyEDzVzcBzZtrt+Oa/dqVQ9obEQ1s6eledPOyX6+GgrIjKr2BIfh+FYeTnavT9ACVhEMwXncAak0sP43sAWzJjWMPtaukbZxyhdsINbLH6uc+KfldYcVXhkhrnyG1eJ1oO73adizCc2dcHaWjc7HFxv/21AKbX9A34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEcAVX93; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEcAVX93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774523442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXxdqkbQLA4ehuUOQdRt5Ygk7PCXPrYtxEdT8qB7Hzo=;
	b=JEcAVX93nkRpXqHmPFGkUkafXMBJeamzKL0xgm6oy4o/XOyAui8fTqTFoAYe9BLfKh/mmr
	Fm/3/hABlRpZ/LCWm2Xjota0dytOBWV5Td10ZrTiNSExk9QWNAbCCRV7vbWZbXDs1mO4BS
	NbYXK2O6aNwWD52yYV91ucZ85tJVZYo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-bIDBd2wNPAC8eDxXKK0CqQ-1; Thu,
 26 Mar 2026 07:10:37 -0400
X-MC-Unique: bIDBd2wNPAC8eDxXKK0CqQ-1
X-Mimecast-MFC-AGG-ID: bIDBd2wNPAC8eDxXKK0CqQ_1774523434
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DEE71955D5B;
	Thu, 26 Mar 2026 11:10:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E68F18001FE;
	Thu, 26 Mar 2026 11:10:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+yaA_=gpTnueByzFNYrqNL_qSC2rE4iGDjLHtJap-=_rhE3HQ@mail.gmail.com>
References: <CA+yaA_=gpTnueByzFNYrqNL_qSC2rE4iGDjLHtJap-=_rhE3HQ@mail.gmail.com> <20260326104544.509518-1-dhowells@redhat.com> <20260326104544.509518-8-dhowells@redhat.com>
To: Aditya <dev@adityakammati.me>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
    ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Trond Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    NeilBrown <neil@brown.name>, Paulo Alcantara <pc@manguebit.org>
Subject: Re: [PATCH 07/26] cachefiles: Fix excess dput() after end_removing()
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 11:10:25 +0000
Message-ID: <510331.1774523425@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ZRtDFz1pFd-72Wt4poAkcfs9hBkcJhc-XaeuACePwNU_1774523434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <510330.1774523425.1@warthog.procyon.org.uk>

Aditya <dev@adityakammati.me> wrote:

> Why are this bulk fixes

I'm not sure what you're asking.  Are you wanting to know why the series
begins with a collection of fix patches?  If so, it's because the main patches
(08-26) are dependent on them being applied first.

David

