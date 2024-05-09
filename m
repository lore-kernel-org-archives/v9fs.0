Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46DDDA9
	for <v9fs@lists.linux.dev>; Thu,  9 May 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274939; cv=none; b=aV1eJVUMj3ODLCoM5TgS82VYpxVdxPufebMwwWxsuU4En27otgGf/T61dCqcjVF5iZ/vLWPEwK9rshW5z/3FNddJDMpK0l7DhiuxaPOo/xTG4/Whl/rIYfPJNsGP/NFfAWnrmAj3W5obuPCxlMxruj4XA5S3uvx1Dlg5fbQQccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274939; c=relaxed/simple;
	bh=I2b3mZDphqAOw1CzA9XXn8owOPYBXLxuDEHOZbykNDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdTUbNNMnCfmP6yzKKWaJxHVGl/Zr99KNePqNbrK1bBuvgbn235ZpGSftFMJtcXwAXkwI6p+DqHgxK/VKN+h5LsA0s6kWyLdnNVXpAyMNX1yPfTFJbfdrJu17AN9R6oOtXIhmmC8m9kT/YhKqhG2jyTE6EWP4vm+U/jbslZ62E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HIE23ZeU; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HIE23ZeU"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 368533F5E9
	for <v9fs@lists.linux.dev>; Thu,  9 May 2024 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715274934;
	bh=R13CNUyH1MbzjMY2CalRPAAS/uvh6wjQHgeABBOaJzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=HIE23ZeUFGpNub4mkJjolnmcnjKRiYIZCcxlle7qzx0QxPHfaQSaalKI6TzYaWHJi
	 bLy2UvHNP5D7B3R4aW3+t/KG8h59aUSqA4sPFiaH7lvjNC3gzhv51blx0XD+bI0L/A
	 tX+msuNNXItnYmoBpCRrGkFQJIxCZbw5kQMPRrWJ1OlrwOLptZepvDtHw0T9EPRg9S
	 qnSS1wBFZB//Cu6J1M6PCBa8OtAz+16pQ5d1G5zF0WmqDHbVBAjniJWshKu6Q8m+ku
	 6QRzxKzQUTpg3I36rLwEU4KHB2eyEt0YvDTY30FUAp2A7NO+4mOBXSL1NF75qAB+wp
	 7gCLpXmZF7L7w==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a51fdbd06c8so76393066b.3
        for <v9fs@lists.linux.dev>; Thu, 09 May 2024 10:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715274931; x=1715879731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R13CNUyH1MbzjMY2CalRPAAS/uvh6wjQHgeABBOaJzE=;
        b=YXVYcz9zFdcg8dUGn8eQRD7CF2xRY65B3WKvE4hwrYQuAzlU+05Bp9LM2WBcIytosQ
         nOMeZFkIfdi9Y9xxAf1sskGCK68oT+QKkeO4PZDWA+8ASEIY6C4uyJdvtZco0fKTRETE
         Ctpur+dQSrZcKnAJelR2Ki/065GXqb1mSv7EvjZNkEdlQSmRzu5sQxT5jqzTW24LEtCw
         QqSaJh9Iy/WNaIqTZm4V66QRaKZkVhZkPZjfid67SOSCyIWJUOXdb2XKFxbZSbbyRCco
         n9xFUCSMB5soFM1aWc3f76oH6tFaDmyUITqYzc1LgBv5C+dXAweVFtc0MpK4Xhc3aWXo
         886g==
X-Forwarded-Encrypted: i=1; AJvYcCXRPH49KVZiY6NSqmRAcntmjS144oBdCIg/8R1Pkr774lLxP2JN4Jx01X/IPh40Qn9qjj02hqSSMNHbPEpmIy6uJDQTIw==
X-Gm-Message-State: AOJu0Yz2lktlvggIIJiGetpT9n3CxqdwO6Asxo4NCZTipyNdEn+yRWuY
	n1Xl8i7Ga99wLt33ei7xL+RYhjXYHIR3EwOnt6r+3vbnWA0tx/5q200b6EZIYKatCF0AoKc3AWc
	J3iQC5YlRqyxAeGu9yCp5XTSvLnpK0icLsmk5LBrxIEbG6D87f6uCiZRrVAyysZTmDjY=
X-Received: by 2002:a17:906:3849:b0:a59:b02a:90dc with SMTP id a640c23a62f3a-a5a2d66ac03mr15004966b.54.1715274930678;
        Thu, 09 May 2024 10:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRId3ZK7jZnEUqxnKrbYMBDrOXsoSZ6C8TgHiChCG3zHZRXUk/mhnLLXZdmjv+NVtyVoseaw==
X-Received: by 2002:a17:906:3849:b0:a59:b02a:90dc with SMTP id a640c23a62f3a-a5a2d66ac03mr15001366b.54.1715274929765;
        Thu, 09 May 2024 10:15:29 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm93194566b.129.2024.05.09.10.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 10:15:29 -0700 (PDT)
Date: Thu, 9 May 2024 19:15:27 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <Zj0ErxVBE3DYT2Ea@gpd>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221132400.1601991-41-dhowells@redhat.com>

On Thu, Dec 21, 2023 at 01:23:35PM +0000, David Howells wrote:
> Use netfslib's read and write iteration helpers, allowing netfslib to take
> over the management of the page cache for 9p files and to manage local disk
> caching.  In particular, this eliminates write_begin, write_end, writepage
> and all mentions of struct page and struct folio from 9p.
> 
> Note that netfslib now offers the possibility of write-through caching if
> that is desirable for 9p: just set the NETFS_ICTX_WRITETHROUGH flag in
> v9inode->netfs.flags in v9fs_set_netfs_context().
> 
> Note also this is untested as I can't get ganesha.nfsd to correctly parse
> the config to turn on 9p support.

It looks like this patch has introduced a regression with autopkgtest,
see: https://bugs.launchpad.net/bugs/2056461

I haven't looked at the details yet, I just did some bisecting and
apparently reverting this one seems to fix the problem.

Let me know if you want me to test something in particular or if you
already have a potential fix. Otherwise I'll take a look.

Thanks,
-Andrea
