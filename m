Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080A3E1693
	for <v9fs@lists.linux.dev>; Mon, 13 Jul 2026 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934957; cv=none; b=l+FxZtquzMYAAspQna9W7Zw2/xpsKMeqiwXnrITzCHz6+wFeWQoALQdjvaltJkbxITxouhzXLKSQt7sqnJ2NKSd9lwB+RiNgKfgq9xhov9zK7h7Q7fDFiNn1wwxCRnkJ2lPBffDHBi+ANHGHDfkIO/4GZpkrZ1yVl59BXqjMNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934957; c=relaxed/simple;
	bh=0nA11BXnZhy6beyXpGTVp/GXCqhu2s5d2WRd/Cwo5Ng=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=iRsk87EjgALJlqi2O508LwBh203Ja5MytPh3TZuu9tTbv7ESg5BzyCXKoGGwTDjfQBV+kgE3gJEShyx5UsJ6JSZCOnOyHylEa7EpmkU8okCyKD7yB35HjUmkiySDd84aUhxqD6ofIRJxgREZP7ayEPc902C25CAYZhyz6UJZMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GN3RInUZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GN3RInUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783934952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2PxznJxxcUHJSFe/GCh1hYyXPLmFNfjYwV+riV2lLZg=;
	b=GN3RInUZabOnPl3JAU9I9E9FPn8igOUBeckA3pILudnic8Y5TAFp0NHjxVdPOs9fmiw8am
	XRk9zfW46XGEnMU+cfED7jjrC4DYPVqai1nLMFntIEtrcGg30WRWIgbrfe2n/h2vW236PT
	TiCQjQtoLAGa83fXK5V3fe8HN6YPLPs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-5eqAlzAFMpOB6iUZCkVQuQ-1; Mon,
 13 Jul 2026 05:29:09 -0400
X-MC-Unique: 5eqAlzAFMpOB6iUZCkVQuQ-1
X-Mimecast-MFC-AGG-ID: 5eqAlzAFMpOB6iUZCkVQuQ_1783934947
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD42E1955DD1;
	Mon, 13 Jul 2026 09:29:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3144195604B;
	Mon, 13 Jul 2026 09:29:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <akfHGcqke9qixd3Q@codewreck.org>
References: <akfHGcqke9qixd3Q@codewreck.org> <20260702090941.1298188-1-brho@google.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: dhowells@redhat.com, Barret Rhoden <brho@google.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: treat read return values of 0 as EOF
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 10:29:02 +0100
Message-ID: <2237820.1783934942@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: cjPKwE-5HRcxdkkNn57MtQFRTIYkyXE4mYczLoaPAD8_1783934947
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2237819.1783934942.1@warthog.procyon.org.uk>

This is kind of a weird situation.  We're caching locally the content of files
aren't really regular files and probably shouldn't be cached.  I'm not sure
what the best way to deal with that is.  I wonder if there's some way to
detect that and mark then non-cacheable.  (Assuming the server can be told not
to even serve them).

Can we detect that the EOF length doesn't match i_size and set a flag to say
"don't cache" in netfs_inode::flags?

David

