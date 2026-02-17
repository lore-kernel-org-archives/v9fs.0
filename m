Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43136D51B
	for <v9fs@lists.linux.dev>; Tue, 17 Feb 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347311; cv=none; b=Ukj8JJXmxXs00unlQcICuAxxczdyVM8RDcTbO5kTyb3ffTjbxxej+MtajUtwaVgpnkeeSG8qYj7v/ErFUO+N+e1OcvrYuHZefU1pjS5Ks7wLeJrEpY90SpBXoFb3IgShVbvzBYf9ePc47qO4s02DeJ2/W0NxF93mAgoLpAD03BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347311; c=relaxed/simple;
	bh=R9hrOJFR1uGxZnEDN/ZfgIU4s4NoTDK8f6uJa7jzgG4=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=L5R6IzvvbD4U249B1hdJo4JKKoH3zDNEW2n5kfysUgfjdcy3ENDWPhbrre6IQoBJPVCXX8mgTdmoJ4e0GtKAn37YqB8raYI5kWYyO872lnvT70osnMYvtEmessxXRP9htKA17X1GJmI78LnpQrASq/ijsbyABwu+7yGxkC2pers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOe9e3Wa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOe9e3Wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771347309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdVQx4qStqCQilMDNIxBWv4IbhAkrKSVb9OVK5HOD7I=;
	b=TOe9e3WaXnDwhS/JHkScZI/+YLJHVpEielUTA26l6o7c994EGQiemZN7iJcLO6EpJIxuCV
	f3Vrqr24aYz902p2LKjCYi3mUCwBZkjegonDl92rPE8N7BTy9HJjS0ba+T7yztKGYGAhxb
	tup340U9PDymYmk+SxHcXLCAtQS4T7U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-S6bof5ckPpSgiu2jH2nl3A-1; Tue,
 17 Feb 2026 11:55:05 -0500
X-MC-Unique: S6bof5ckPpSgiu2jH2nl3A-1
X-Mimecast-MFC-AGG-ID: S6bof5ckPpSgiu2jH2nl3A_1771347304
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0FD91955D7A;
	Tue, 17 Feb 2026 16:55:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.225.173])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D88E319560A2;
	Tue, 17 Feb 2026 16:55:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1406915.1771340720@warthog.procyon.org.uk>
References: <1406915.1771340720@warthog.procyon.org.uk> <2025543.PYKUYFuaPT@weasel> <20251227180137.730385-1-pierre@barre.sh>
Cc: dhowells@redhat.com, Christian Schoenebeck <linux_oss@crudebyte.com>,
    ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
    Pierre Barre <pierre@barre.sh>, v9fs@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 9p: fix i_size update race in getattr with writeback caching
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 16:54:59 +0000
Message-ID: <1499182.1771347299@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 3l0o2sBcF2-yASV6LQQSB5wSEcxUTdoSj8qBJ9MM980_1771347304
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1499181.1771347299.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

David Howells <dhowells@redhat.com> wrote:

> > [   60.847671] [append] R=3D134d: No submit
>=20
> Can you get me some tracing?  If you can turn on:

Nevermind, I've managed to reproduce it - but only with the virtio transpor=
t
and not the tcp one.  It also doesn't seem to show anything with afs.

     9p_repro.sh-1399 : netfs_folio: i=3Dd306b44 ix=3D00000-00000 mod-strea=
mw
     9p_repro.sh-1401 : netfs_folio: i=3Dd306b44 ix=3D00000-00000 flush
     9p_repro.sh-1401 : netfs_write: R=3D000001be WRITEBACK c=3D00000000 i=
=3Dd306b44 by=3D0-ffffffffffffffff
     9p_repro.sh-1401 : netfs_folio: i=3Dd306b44 ix=3D00000-00000 store
   kworker/u32:2-63   : netfs_rreq: R=3D000001be WB COLLECT f=3D903
   kworker/u32:2-63   : netfs_rreq: R=3D000001be WB WR-DONE f=3D903
   kworker/u32:2-63   : netfs_rreq: R=3D000001be WB WAKE-IP f=3D902
   kworker/u32:2-63   : netfs_rreq: R=3D000001be WB FREE    f=3D902

Looks like netfs failed to flush an incompatible streaming write.  The foli=
o
was moved to the 'store' state, but no subrequests were generated for some
reason.

*Why* it produced an incompatible streaming write is an interesting questio=
n.
The writes are all done with O_APPEND, so even if the processes write out o=
f
order, there shouldn't be a problem...

David

