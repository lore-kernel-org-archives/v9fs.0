Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10D26E71F
	for <v9fs@lists.linux.dev>; Mon,  5 Jan 2026 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599675; cv=none; b=lgGpR109j2l/9WWWhWHsd9KRP14tSoJC2CPpaUgeRu8t/W2HS27Nb7mrpg3jXAh1pIuvysaZC4jPTq8DPwGZ6/GV07zuyXp9/wzZef64sszDsWicO7cM7I0Nv1ugR0ZqS0Zr3Rzql8SLQwCRZIqW0hRtcgRFaYDfy67uvVKEr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599675; c=relaxed/simple;
	bh=XdpaRgB2FIMRDcyBl0p2UOoQ5I3izyBFSThcwXcEH+0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JEqaX+Sh/WKUaZRPz8vWe+Tzo7d5Iw2meRXnudqRbT77WlDyfz55VxhLsS/jN2shN1Ebo2N5JlfexkPpYur8Bp4ISx72YmiNUcKM0yF5jNLE/mVGBP9hwzVPQ8lgXmbomIO4GupHhilRCgHHY6DuAOBUdRteMjgidTE33ancI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYw2q7JD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYw2q7JD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767599673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LotQ/PBNidMKhV1jA1z2rV+QzNLCbCF65XX/DJUR/sM=;
	b=aYw2q7JD8A78dzZfjOw8rGlKOd+pLLzNoHZdWblhJa+9HsRYHhYGcOQCrZ/m8If5pGaK6O
	PKVBn0oKcBrpJ02uXRMHxsBcEUXgtyovDIzS0qlN869QHYQxM0f5jgSL9OzfHzf9/+4Avk
	7QS4KtocW9/tpCN2kZ4oyHX7Ffq7Gt0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-zEPZr97zMvmb9a19-_WbJA-1; Mon,
 05 Jan 2026 02:54:29 -0500
X-MC-Unique: zEPZr97zMvmb9a19-_WbJA-1
X-Mimecast-MFC-AGG-ID: zEPZr97zMvmb9a19-_WbJA_1767599668
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB1DD180035A;
	Mon,  5 Jan 2026 07:54:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3966619560AB;
	Mon,  5 Jan 2026 07:54:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <5951517.DvuYhMxLoT@weasel>
References: <5951517.DvuYhMxLoT@weasel> <aea6cd1d-ff2b-4288-8196-edfdfd1539f6@app.fastmail.com> <aUxqVn0DO7ee9K2_@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: dhowells@redhat.com, Pierre Barre <pierre@barre.sh>,
    Dominique Martinet <asmadeus@codewreck.org>, ericvh@kernel.org,
    lucho@ionkov.net, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 9p: data corruption with cache=mmap under concurrent stat/write
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1696784.1767599663.1@warthog.procyon.org.uk>
Date: Mon, 05 Jan 2026 07:54:23 +0000
Message-ID: <1696785.1767599663@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> > > 2. Both getattr and setattr call filemap_fdatawrite() which initiates
> > > 
> > >    writeback but doesn't wait for completion. The subsequent server
> > >    stat/wstat sees stale file size.
> > > 
> > > Would using filemap_write_and_wait() instead be the correct fix?
> 
> ... you are seeing a 2nd issue? getattr() output should not be related to 
> mmap() access.

getattr() may flush outstanding dirty data on an inode so that the stats are
correct - but if so, it should wait for completion.  If you look at cifs and
nfs, those uses filemap_datawait() or filemap_write_and_wait(), rather then
filemap_datawrite().

You might also want to check flags & AT_STATX_FORCE_SYNC and flags &
AT_STATX_DONT_SYNC.

I really ought to make afs honour AT_STATX_FORCE_SYNC.

David

