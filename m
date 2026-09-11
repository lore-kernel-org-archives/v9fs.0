Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F06411FA1
	for <v9fs@lists.linux.dev>; Fri, 11 Sep 2026 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114270; cv=none; b=mf4MX8zmadnIyFXdLeZrAmH32THtgKoJOu/vAwgdKqNxcAEqeF4qDfyCayiqtzKd1JRk22qR4JMCPls+wR8/waTlIvqF7uciEf8ZSemrShx1ld+kjg0iq8jed7ezYhBYOim28dNr6/E+nFaMLfko29beSwaxdq/vqqMqu2dFR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114270; c=relaxed/simple;
	bh=9EWyKxpvwDuyXTv1d+2e/EeTIXfhXvw4dndst9H/9BE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=WArXaNCOk+nkcLov/MwLBQ86bPJtvn3SUCdT/rSsFBq6MmkM+yEOU5lNvWvdfxoQQHonLsF7M29E3EZb9NHL6XamkgCJlEYKRdWtYkAsfKjfL8kPGnpCpDd7vL3zBmOzF0HzqzUmeAI2eaE1Lj/yEIXS1z0zL0yoaZQmB6aiRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkYkFk7C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkYkFk7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789114268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KM7H7X1d32hwES9HmLQ+a3yj4IwaejBWYAwsQEvzy9Y=;
	b=FkYkFk7CKASAkCx/A7mtXpCBXz4qxOxae0qy/OBeMpAjz/Av3KyyhXFE+fONvEIU00xp/P
	8Z6kZhgBm01Ev6YrjiIMQib3DKBEkHe3E0TH3JKfDgljeQ8xxulwxw46PFh+fzkKQ+oZ/G
	y0czMQq/JmHTGvaJzda11+8yShoBD0A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-tPEIzxiRNvWbEVqVnvybBw-1; Fri,
 11 Sep 2026 04:11:04 -0400
X-MC-Unique: tPEIzxiRNvWbEVqVnvybBw-1
X-Mimecast-MFC-AGG-ID: tPEIzxiRNvWbEVqVnvybBw_1789114262
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB9AF1956072;
	Fri, 11 Sep 2026 08:11:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 758071956088;
	Fri, 11 Sep 2026 08:10:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
References: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
To: Michael Mulqueen <mike@method-b.uk>
Cc: dhowells@redhat.com, ericvh@kernel.org, lucho@ionkov.net,
    asmadeus@codewreck.org, pc@manguebit.org, linux_oss@crudebyte.com,
    v9fs@lists.linux.dev, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL corruption of file data on cache modes with CACHE_WRITEBACK
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 09:10:55 +0100
Message-ID: <2217384.1789114255@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: X7Xwb9pTQ5ftoaIqsU0zoUteOTzUF8gDUVWxvHN_Rpo_1789114262
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2217383.1789114255.1@warthog.procyon.org.uk>

Michael Mulqueen <mike@method-b.uk> wrote:

>       cache=none       read   0/20  write   0/20  [cache=0x0]
>       cache=readahead  read   0/20  write   0/20  [cache=0x1]
>       cache=mmap       read  20/20  write  20/20  [cache=0x5]
>       cache=loose      read  20/20  write  20/20  [cache=0xf]
>       cache=fscache    read  20/20  write  20/20  [cache=0x8f]

I presume these should all be 0/20?  When I have a cachefiles cache active, I
see:

  cache=none       read   0/20  write   0/20  [cache=0x0]
  cache=readahead  read   0/20  write   0/20  [cache=0x1]
  cache=mmap       read  20/20  write  20/20  [cache=0x5]
  cache=loose      read  20/20  write  20/20  [cache=0xf]
  cache=fscache    read   0/20  write  20/20  [cache=0x8f]

so I suspect on the last one, the data is drawn from fscache, not from the
server.

David

