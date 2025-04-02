Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7E18DF80
	for <v9fs@lists.linux.dev>; Wed,  2 Apr 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613858; cv=none; b=CKIdWUeKppVGg8AcNImQmNvpxVGrECCA8eGFSXAH/NTf1btSKB9rmcoD9iedOYUYQGuyDwIhqhQHHM0CYY6bZDaFG4OLJzIlGC5QI7ugbwGmN5a7AcwNvDw0yuiGW4iXCZv9OXOtQgYdapnqX1y9jRNHiMUoxXiKLujO4BgPpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613858; c=relaxed/simple;
	bh=xEaasgmA8rD+DB8VhcWCdrDZeQhRBH1jjbOX1u8DirQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QyYJtHHs0obU+ow498R0ntefkvuaxp+6gfXkiGVKXr8rSZKgnF0xL4FSgoliD4EBag8Bnj/6hLgZ7uJQcXOAnT3g9rW1du1E8dWrlpK4uvCBxZ7T12GpctFsvPZ3eNvKbsTrP9lPfMJm6iOLVCiK9INyEinmg7FIHCsosl5Joh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoUtQoiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoUtQoiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743613854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XiTG0FByjC9Rs16rt52doAGprRUtZJNgSviOZz6x1o8=;
	b=PoUtQoiHfQMZv/UQgVZwa+p3hXnrw4bszBL8ETO1CjnqBNM64v7tGfWR3Xr0ty9g3uADDf
	WexN6NZ0bVIq3tAAlE6I8lK5MlMWDstACuCFi/dB4LVCb0e3rtEH9j0eUSGPhnN5/IY7ba
	AusxTcR0LiEzc/0vL+13ySgX/ASpoVc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-2p6AgTrvMp695wiKCVs6Iw-1; Wed,
 02 Apr 2025 13:10:48 -0400
X-MC-Unique: 2p6AgTrvMp695wiKCVs6Iw-1
X-Mimecast-MFC-AGG-ID: 2p6AgTrvMp695wiKCVs6Iw_1743613843
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47E8E180AF52;
	Wed,  2 Apr 2025 17:10:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB43D195DF85;
	Wed,  2 Apr 2025 17:10:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250402150005.2309458-2-willy@infradead.org>
References: <20250402150005.2309458-2-willy@infradead.org> <20250402150005.2309458-1-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
    dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
    v9fs@lists.linux.dev
Subject: Re: [PATCH v2 1/9] 9p: Add a migrate_folio method
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <803464.1743613839.1@warthog.procyon.org.uk>
Date: Wed, 02 Apr 2025 18:10:39 +0100
Message-ID: <803465.1743613839@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> The migration code used to be able to migrate dirty 9p folios by writing
> them back using writepage.  When the writepage method was removed,
> we neglected to add a migrate_folio method, which means that dirty 9p
> folios have been unmovable ever since.  This reduced our success at
> defragmenting memory on machines which use 9p heavily.
> 
> Fixes: 80105ed2fd27 (9p: Use netfslib read/write_iter)
> Cc: stable@vger.kernel.org
> Cc: David Howells <dhowells@redhat.com>
> Cc: v9fs@lists.linux.dev
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>

