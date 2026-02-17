Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E831076A
	for <v9fs@lists.linux.dev>; Tue, 17 Feb 2026 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339722; cv=none; b=aw/FD+ZEziEvufrNtLcLOPKez8/nO2dujQ4+ij6oZvHMdillKqNE4/gsHHJmM8k1rtvIInoRit71XOvPoh31FdZQsqRX6uIhEM1SCguM1065SH3U27VxrslGLIl4MGoJaZALPtrFMTSJSe2d9t++65RGOKUMiY7tIBHxNjpqG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339722; c=relaxed/simple;
	bh=OrTFABK9LZ6F4Wf6TeVFi5KNuV9aYACVoYkZOjW87Es=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=W5w5/sqpE9gHJHFxfEdqfeFV8pfxaOo+Czg01Yyy7REXa/JP/Uw9qAcBjx3zavkwExq/J5izfkc1YSuCMV7ElBPUR3VIa46m9FBh6m/cwSF/pnm3Iima2UtPWo7t34Ch+/ehy48HWNm+5i/VMeoa93ZmvqqmsCu+glbmdq++NTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHxNTdSy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHxNTdSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771339720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gtk+iypRymX/b8W3W+eyKDme9AzPKzBinCazw2yRtH0=;
	b=fHxNTdSyHn4cbaqR1v061PgCy1/lZhnffK+PuWKWrTb2YFDRc3saVC3H8gUJUT1aNovXI1
	3mK61N9VjKqdmdoyFCkLOaKD9icLKNGMB+bRKwUOilB2E7kTGGl8qo/XAvbMu1FkQidDKY
	YXyQ/xkn4q71LIiIwpubnxCoikjyZKo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-2I3I9Oe0NNWW_y23JLrhvg-1; Tue,
 17 Feb 2026 09:48:36 -0500
X-MC-Unique: 2I3I9Oe0NNWW_y23JLrhvg-1
X-Mimecast-MFC-AGG-ID: 2I3I9Oe0NNWW_y23JLrhvg_1771339715
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A240195DE50;
	Tue, 17 Feb 2026 14:48:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.225.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F43F180058A;
	Tue, 17 Feb 2026 14:48:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2025543.PYKUYFuaPT@weasel>
References: <2025543.PYKUYFuaPT@weasel> <20251227180137.730385-1-pierre@barre.sh>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: dhowells@redhat.com, ericvh@kernel.org, lucho@ionkov.net,
    asmadeus@codewreck.org, Pierre Barre <pierre@barre.sh>,
    v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 9p: fix i_size update race in getattr with writeback caching
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 14:48:30 +0000
Message-ID: <1406626.1771339710@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7fwjXMK8bxxuBtRF7mxcZYmRQUOmXGoSFlqeRr1Icuc_1771339715
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1406625.1771339710.1@warthog.procyon.org.uk>

Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> do
>   echo $i >> foo.txt &
>   ls -lha foo.txt &
> done
> 
> sync

Did you want a wait somewhere?  There's no guarantee that the asynchronous
processes thereby launched have done anything at the point sync happens.

David

