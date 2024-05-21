Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D089130A66
	for <v9fs@lists.linux.dev>; Tue, 21 May 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301460; cv=none; b=tHY9bBz0YPuB+PAxjV6V5QTuJuKrIv3R8pmcCFaizCaL0jmnBBQEHmiFcNyiYbtOkUXtxPYywUP/WegcDm92TrZmV+BBIPtrCkX5T2mJHpWZwUnYe1viaiSqtncZk/Jl9gE4zCT8pO6KgUH8COZH9zXUZpXlCTVW4lZp6+IMxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301460; c=relaxed/simple;
	bh=CTILGHjgaGkYQSxM0cSn6nRvwmlTHgeaKOp0IO0HWxw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=tJo7Ku0lctX/feUcf5vwFlGtBN4RwHJ2+P/JPmeKwlcfdqZMYWYqnwn21AUJlyT+GExaGS3vazBqy2hAHe7A+iqOz6QzvnMCuA5J0XVSAa33j0OflJBT3vcDasAn0jxhXFH/SGWfroczApEWtbAin17zbPllHqmPldHnsfS8FG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bElEqSr8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bElEqSr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716301457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rhtyKrz2w4HaVXBZrxE7MjJzIMil2OihfH05cUBp8po=;
	b=bElEqSr8EIEPpgPb8O4n6PoiR/HTeucA7V/7eggF4kK9LLqvI1QKOjgC+Qgd1XskX+U3eJ
	RxaoE7Q1HWA+J5k9CmYUnzVa5KbfYmnwcvsHal/f3JxRUQ5y5kf2SvU33OuUjVgYiJ5zOz
	FRMlvcqq82cdf/NeF5vlk+wiUHgkKqA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-4qhM56d0MkiChBK8q-pIRQ-1; Tue,
 21 May 2024 10:24:11 -0400
X-MC-Unique: 4qhM56d0MkiChBK8q-pIRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41F4E2802297;
	Tue, 21 May 2024 14:24:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 890021C09480;
	Tue, 21 May 2024 14:24:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zkr8i9XxpkJ9AABZ@codewreck.org>
References: <Zkr8i9XxpkJ9AABZ@codewreck.org> <0000000000005be0aa061846f8d6@google.com>
To: asmadeus@codewreck.org
Cc: dhowells@redhat.com,
    syzbot <syzbot+df038d463cca332e8414@syzkaller.appspotmail.com>,
    ericvh@kernel.org, linux-kernel@vger.kernel.org,
    linux_oss@crudebyte.com, lucho@ionkov.net,
    syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Write in v9fs_free_request
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <300530.1716301445.1@warthog.procyon.org.uk>
Date: Tue, 21 May 2024 15:24:05 +0100
Message-ID: <300531.1716301445@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

asmadeus@codewreck.org wrote:

> +To David as I need help with netfs

I'll look at this in a bit, though it may be tomorrow.  Just fixing something
in cifs at the moment.

David

