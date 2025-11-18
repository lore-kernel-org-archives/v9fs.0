Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB7222587
	for <v9fs@lists.linux.dev>; Tue, 18 Nov 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483464; cv=none; b=I8wpf684fhFkADVdUOEkYGA/s3ccSKOcdXJvK6LyRhIH+3Wuv5ao8Fe980qph0WS+XBiSphxB+W15nWqIYVn+G+m1iguHAzOMU8ZytBlj9qAuDGrrjAEsrtmcPCxePm/B4xA07jznzrqw2GPYSR/ED/kcbsSaVcmJ2mO+vPIWB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483464; c=relaxed/simple;
	bh=8UlkwDQF21jUeicW6cfnxchowA/tYndNXKnykStl9hc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BBD+/xfA73/DsNGY3Dlz9cAq6CMuBw6hhbpw/w/K5ujzuGpx745GhL7ye8/pPAKgThDztbtt0+WaZNhp+lir289vCvqUzZ22/tpM6VstmK3AxkasNJP0rVZODbfYGP+fNpIaO7sJX9YvBzJZIAp+Sr+yHxj5RJT6sPEALMT5DDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqPiTapa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqPiTapa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763483461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UlkwDQF21jUeicW6cfnxchowA/tYndNXKnykStl9hc=;
	b=XqPiTapayXXdL6CeN6kaLOZgcTXIqsljyIZTXndRMhMsbyrsonf3fHxu47mFCsGs/V28RN
	HphQ0XmJ2YNcbg9mbkD7gYv6zJ2kjFxnX3B0SC8BIXWPYumUB07lCU57Ahqv1ULg3l24Rb
	CNneGhZGAKt7OQ//x0Fq1ExcU1Mf7ng=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-Z3NwlUSTOKiFmanMOcTQ3w-1; Tue,
 18 Nov 2025 11:30:58 -0500
X-MC-Unique: Z3NwlUSTOKiFmanMOcTQ3w-1
X-Mimecast-MFC-AGG-ID: Z3NwlUSTOKiFmanMOcTQ3w_1763483456
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 065201955E87;
	Tue, 18 Nov 2025 16:30:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D350C300A88D;
	Tue, 18 Nov 2025 16:30:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+-da_s=r2-1WynNkg024uxFE2PEHTp=9_uJP97fskvQyA@mail.gmail.com>
References: <CAKPOu+-da_s=r2-1WynNkg024uxFE2PEHTp=9_uJP97fskvQyA@mail.gmail.com> <691bd66a.a70a0220.3124cb.00ae.GAE@google.com> <2200414.1763479511@warthog.procyon.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com,
    syzbot <syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com>,
    asmadeus@codewreck.org, brauner@kernel.org, ericvh@kernel.org,
    hdanton@sina.com, linux-kernel@vger.kernel.org,
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
Content-ID: <2202506.1763483450.1@warthog.procyon.org.uk>
Date: Tue, 18 Nov 2025 16:30:50 +0000
Message-ID: <2202507.1763483450@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Max Kellermann <max.kellermann@ionos.com> wrote:

> Indeed, that's the same symptom I had; my patch is the fix.

Thanks :-)

David

