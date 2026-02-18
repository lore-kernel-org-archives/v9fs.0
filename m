Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE042FD698
	for <v9fs@lists.linux.dev>; Wed, 18 Feb 2026 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422096; cv=none; b=Yj9QwrHr8G7Seg20sPCyOPIV88ilPRfbLo79BQKRuyQ+SYsptrfMsrOs2ljRWAXtqfvyTsfucadobk/etREgMHbI+/7nwIIemG/UmI5cazFNGoi5LiQ5Tp3y70qx0V4ZBeIJeiGk9TDNH3dA/wj8p8nf0qr3Du93dpq501UkTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422096; c=relaxed/simple;
	bh=KNHnUIVOfeXh/kBrD7UrbZs2NbRp+HcrDfvJgP9yLgk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=I+JlbQdtBrZbaA12T7RB8E8ECuZ+V5+rg7q/Acl46DhWywr44y59HYe4SKNCo6dCU2WF+oFjNZr2a8nGrrSqzoBL2PIlfHKTxQhV8FgNBaf9C7fLTwNx07dvJc+mQHnF/oQt214dGOJCMQXK7epIb2yuEHvFqCtWVM1gDL+aGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mxa1CqmE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mxa1CqmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771422094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNHnUIVOfeXh/kBrD7UrbZs2NbRp+HcrDfvJgP9yLgk=;
	b=Mxa1CqmEaN2V92GDrl8QFFHqolvsBWPqBSRXMMiLC6O5a0dtbCXsS+Ay2CR2oG78i2Q3t4
	wcrC3V1ngxPru+1ZWnHKh6wqgcydqMj2XITp9UB5xHtInSK4DcsPTsodgbVhJY+VubyuBh
	VdPkAJPrc8HB4smvlIXF+li7B3VOPnU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-nbp9YrhgMs2_bNi4rDFRbw-1; Wed,
 18 Feb 2026 08:41:31 -0500
X-MC-Unique: nbp9YrhgMs2_bNi4rDFRbw-1
X-Mimecast-MFC-AGG-ID: nbp9YrhgMs2_bNi4rDFRbw_1771422089
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 879EB1955D4D;
	Wed, 18 Feb 2026 13:41:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.225.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B56861954115;
	Wed, 18 Feb 2026 13:41:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1642497.1771421883@warthog.procyon.org.uk>
References: <1642497.1771421883@warthog.procyon.org.uk> <20251227180137.730385-1-pierre@barre.sh>
To: Pierre Barre <pierre@barre.sh>
Cc: dhowells@redhat.com, ericvh@kernel.org, lucho@ionkov.net,
    asmadeus@codewreck.org, linux_oss@crudebyte.com,
    v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 9p: fix i_size update race in getattr with writeback caching
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 18 Feb 2026 13:41:25 +0000
Message-ID: <1642566.1771422085@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: rnZRSuLonLE_UHyAMgaKq5ElgZ2GN7-S8MUSlYdxfUs_1771422089
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1642565.1771422085.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

David Howells <dhowells@redhat.com> wrote:

> A better way is probably, in v9fs_stat2inode() and v9fs_stat2inode_dotl()=
, if
> the inode isn't new, compare the values for stat->mtime to inode->i_mtime=
 and
> stat->length to v9inode->netfs.remote_i_size and if they differ mark the =
inode
> as being remotely modified, invalidate the pagecache and reset inode->i_s=
ize.
>=20
> If stat->mtime =3D=3D inode->i_mtime and stat->length =3D=3D
> v9inode->netfs.remote_i_size, then don't alter inode->i_size.

Also, you'd need to update remote_i_size upon successful completion of a wr=
ite
RPC call to increase it up to the end of the write.

David

