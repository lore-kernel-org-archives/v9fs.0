Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE23538A1
	for <v9fs@lists.linux.dev>; Tue, 18 Nov 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479527; cv=none; b=eK3O+tKG/bMjtJBEbPZ3jdwEr5QO8p/Rt+Mkbw2cFsbaL13GxWc8qMhKKHYoomfcUft+3tf60Go8V2n8F/aHulvrB3N+0GNVHE7gONgm1mWRhMeWYbpOJloK3/Fnw0jHuPSaxn2WkIrVe69YTO/EVv/Ivt3Qnv/jN0xEaxhdfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479527; c=relaxed/simple;
	bh=TCNBwf23ZtSWk9ye0+gtzlXJSfmQIwHsXlHakyOOCIY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=pIX4d65gcQoyz+G0PoQhToZabynGg1256cEs6QgeURvGbfTphr3SImsXPx9/dWFE91dGjTp9hvbvBdfmeAVpFpEfOVgS8RYiP9BWVvcVXUM0y5+fr1Fen7/JCA9M1TVwwtc3AuwV9TU8rwLesAPVKO6WSulHWnxdgyADlRNOGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VylEWhtz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VylEWhtz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763479524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gGRk87902URR685IUOQ7sszBx2cgT79ChcYOFg+C/1M=;
	b=VylEWhtzwZ2qa+lXup9fmoYhWIgsrAXZmlQ3cOJHv4YOLI3vEY53OpHY/eGBA7kIYLIbm+
	E8MdAMbdPe/aeGL6eFSMhgt3hRQ6I6J/sZFwEFYDMPPyIhkWAff3p+nb5k6nBVAucPyEt5
	UUDF7z9cesyJeMJLy24L2UdS5Cr/Ycw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-L-clbklIPbyq5Xtu81QS_w-1; Tue,
 18 Nov 2025 10:25:19 -0500
X-MC-Unique: L-clbklIPbyq5Xtu81QS_w-1
X-Mimecast-MFC-AGG-ID: L-clbklIPbyq5Xtu81QS_w_1763479517
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78F271956052;
	Tue, 18 Nov 2025 15:25:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A10B195419F;
	Tue, 18 Nov 2025 15:25:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <691bd66a.a70a0220.3124cb.00ae.GAE@google.com>
References: <691bd66a.a70a0220.3124cb.00ae.GAE@google.com>
To: syzbot <syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com>,
    max.kellermann@ionos.com
Cc: dhowells@redhat.com, asmadeus@codewreck.org, brauner@kernel.org,
    ericvh@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org,
    linux_oss@crudebyte.com, lucho@ionkov.net,
    syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] INFO: task hung in v9fs_evict_inode
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2200413.1763479511.1@warthog.procyon.org.uk>
Date: Tue, 18 Nov 2025 15:25:11 +0000
Message-ID: <2200414.1763479511@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

syzbot <syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com> wrote:

> syzbot suspects this issue was fixed by commit:
> 
> commit 4d428dca252c858bfac691c31fa95d26cd008706
> Author: Max Kellermann <max.kellermann@ionos.com>
> Date:   Thu Sep 25 13:08:20 2025 +0000
> 
>     netfs: fix reference leak
> ...
> dashboard link: https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9

That sounds reasonable.  I don't know if Max has a blocked cpu message for
comparison?

David

