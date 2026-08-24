Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF137E5C4
	for <v9fs@lists.linux.dev>; Mon, 24 Aug 2026 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600870; cv=none; b=IIy3wnmv181L4xQtXk1nSdeQ/ylTxTCfMZkdwds9P8T9pYfxg1b6tZxhKur6Xl5kSPDU9h9GbHFbar4Z4E8T/50RwQ6crVB62VN5qLKznWNKqX/oqH+yhE77VQdErbZE9S7Ro/VX2QLcVDaw2UHTwSJoqjBcLiAGvlMlQ5GY7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600870; c=relaxed/simple;
	bh=FOanywWJLH1vJk/XnFKvHh4Z+cJY9CVeC96eTSsFN9Y=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=CeS9Q1dzSYo0poydJ2BHFQu1fo5uXl8djuHI5DNVPD/ZrG4J8y3b13EImsH3ROSrDJSfA7NxWwbpwO5Wv9hY4T1z3ZMRBfB4z+UcOtlFeDoku9FQX7xafZX33yIZOtaSYC3pdCenEVK8FQgVd9Ws0oxL9xg034qQXI+YzQjxW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH89aReI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH89aReI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787600868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qU5H5HsiL1oxbfqE/+7Bg2lwE3XezcgSQ9LHhL9wLs=;
	b=GH89aReI2YQ6SVZsKD1PrHKTx6BTF45dMSMDc4gWx6FifIJXfLEcJz2TkF/GPkfDlD2SbR
	eSa+YDect3dbmUEIjUGuEMknRu28RZSaM5vGOb6FhopD40zsfB9SZSNh8+icwQu4JzqWOQ
	ucUMZmTAYFnE7Sqqwfnpo1/aRvisocg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-9XFVDZNVN-aHPcQHKQgWyA-1; Mon,
 24 Aug 2026 15:47:45 -0400
X-MC-Unique: 9XFVDZNVN-aHPcQHKQgWyA-1
X-Mimecast-MFC-AGG-ID: 9XFVDZNVN-aHPcQHKQgWyA_1787600862
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D45F184B396;
	Mon, 24 Aug 2026 19:47:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8E871944B2A;
	Mon, 24 Aug 2026 19:47:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+1jF5qPZUhCevwbu7zQDEVWss6gMdoDMhqKqH3k7v=WStRtEA@mail.gmail.com>
References: <CA+1jF5qPZUhCevwbu7zQDEVWss6gMdoDMhqKqH3k7v=WStRtEA@mail.gmail.com> <20260824144130.759997-1-dhowells@redhat.com> <20260824144130.759997-31-dhowells@redhat.com>
To: =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FAur=3DC3=3DA9lien=5FCouderc=3F=3D?= <aurelien.couderc2002@gmail.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: READ_PLUS in NetFS? Re: [PATCH v10 30/35] netfs: Simplify read abandonment
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 20:47:30 +0100
Message-ID: <771538.1787600850@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: KEHxww4bg4x3uA27JZIUbxcu3NrL0FS_b8-411OqjNg_1787600862
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com> wrote:

> What about READ_PLUS, i.e. sparse file reads? If you do this kind of
> work of handling partial abandonment, can such a work also benefit
> READ_PLUS?

READ_PLUS is NFS, right?

I'm not sure it would particularly help or hinder.

The VFS/VM only asks to read contiguous regions and netfslib breaks that up
into subrequests, but currently netfslib doesn't know anything about sparse
reads.  What I'm looking at with Ceph, for example, is that Ceph knows wher=
e
the gaps are and will clear them before terminating the subrequest.

Partial abandonment is for when some sort of fatal error occurs and we cann=
ot
finish the request.

David

