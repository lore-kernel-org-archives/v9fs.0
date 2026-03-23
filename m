Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D830F924
	for <v9fs@lists.linux.dev>; Mon, 23 Mar 2026 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296885; cv=none; b=bZpTwB/YqmNwBlBFxDlxhjkJjhNBjSwn/D6BfBDolAO0K+J1qhFjQhA2X03YXFUXwOFkh9vPsGdbX/tNTLiMp8EBCajwJpnf39cgtZRs1jUUEKjVLHOodqsCdtIh2MdfzbkpI8SGzRJ05LhBpkm5QF+ub5SuEuWioHTtdNSzri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296885; c=relaxed/simple;
	bh=F+ddKRQ39xlfAIr6n3sDo9L+xJ5paXR2AtPlU73aYFU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=hwD2GSXJNSzgbrRVD0v4953c6Qtxbduo9U3Lq/nxVPqbcjt74Su4jP4Qo3tArPqvwVW0nhQiWXQlzQEw+Kh2W39ySl51QHK6WsbsOpMjRXGAdlX9TuSwkbDCJVGOSKzq2oIdj+R/MGV32wlAC/xMhIzvGik3K9uKclhLdyVQ4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ck0nlaux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ck0nlaux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774296883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUVGj/gLaPfVvuJQ5VZBM9LF/E7WLCa5Qqxd3/TmoQo=;
	b=Ck0nlauxqXNcub+Gb4sJdO48F3b+uocYXm+9ZTnPzbq160K/kJv8wm0V/56hXQm10IZ4Vs
	jjzVDev0P3bgXfc45Q+CxFUMfN68KdCR3yUQAqfdij6U8IJjE3OC4M2h9X9vjyz3Yzlo7r
	3Vr/CizjHMVdCxbng0JonOwA6fcOf44=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-abKn93TAPU2bn-bvqjtKYQ-1; Mon,
 23 Mar 2026 16:14:35 -0400
X-MC-Unique: abKn93TAPU2bn-bvqjtKYQ-1
X-Mimecast-MFC-AGG-ID: abKn93TAPU2bn-bvqjtKYQ_1774296873
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62D281955D57;
	Mon, 23 Mar 2026 20:14:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79DED19560B1;
	Mon, 23 Mar 2026 20:14:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2d8ce118-2f7a-4b7f-8786-4581b29cb74e@chenxiaosong.com>
References: <2d8ce118-2f7a-4b7f-8786-4581b29cb74e@chenxiaosong.com> <20260304140328.112636-1-dhowells@redhat.com> <20260304140328.112636-18-dhowells@redhat.com>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>, Steve French <smfrench@gmail.com>,
    Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH 17/17] netfs: Combine prepare and issue ops and grab the buffers on request
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 20:14:22 +0000
Message-ID: <3574143.1774296862@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 1bq8hsMeSOuT4BhnllFF5RxwbHbPi7_ZE8xjuXw_Cmg_1774296873
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3574142.1774296862.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

ChenXiaoSong <chenxiaosong@chenxiaosong.com> wrote:

> I reviewed this patch in your repository's netfs-next branch (it looks
> slightly different from the version posted to the mailing list) and found=
 two
> issues, the following additional changes are needed:

Thanks!  I've been testing the patches further and cleaning them up.  I wil=
l
hopefully post them again soon.

David

