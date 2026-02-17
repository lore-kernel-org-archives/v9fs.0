Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87F36B047
	for <v9fs@lists.linux.dev>; Tue, 17 Feb 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340733; cv=none; b=MVUC3Qc+8ypbPtv2C4v8O6na2z8kW80yD1+/N+YNizR3cf/5hLaBwAvk4rYyKZXj5ob3Gf7n/7lny/KIJzYr/JNEoRJzBkGoI9jiF2zdZ7RH/P8drqLuqk1T8netLi0yhv7QKpUG9JPtwmBi5fnZzNSWCI8JiuUgPKVTjxWVNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340733; c=relaxed/simple;
	bh=/E7iNn/G5H08RBwESyllriYiSxeRliwuS+tMibS/AdE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=P4EIIMf1crzGSOt8Dlat0U+9nMHymzNt4wp4CtHrsgbKNUK7SP9wlNBWzYFlOfFHuFdti1S69feeIrhPrV+g8NnejqixED5FQtK0GCltvqH/tQZ6/o7FC98hPg8OMrxCCaiWn9IBslc77qVG6mR1Jyl7giu39J+b+VVjMpULReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgR/I2ty; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgR/I2ty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771340731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSnCin/edfE6MFy/lILxss09Y2rcGzFWTtP2aGj20ws=;
	b=KgR/I2tyJFJP31yN8qPZDbXjaMdLKXAbqiZPPOqRZf3gvRCGAwvsJ0nmAUdSPWlsQg1CRB
	zrcDOKK9JWBne6ha62vt4bSc9pWuzlIoD9ZOKviwyW99L/MQwnYDsMzk4TpDiTUo0OiHx8
	XKOMH702wizBH5Umfd8gJVmaidKiUQk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-WQqYEVv7MN2zElE-RzB2og-1; Tue,
 17 Feb 2026 10:05:28 -0500
X-MC-Unique: WQqYEVv7MN2zElE-RzB2og-1
X-Mimecast-MFC-AGG-ID: WQqYEVv7MN2zElE-RzB2og_1771340726
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A3DE1955D89;
	Tue, 17 Feb 2026 15:05:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.225.173])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45D581800370;
	Tue, 17 Feb 2026 15:05:22 +0000 (UTC)
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
Date: Tue, 17 Feb 2026 15:05:20 +0000
Message-ID: <1406915.1771340720@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: g63AkOheHn-zeFTs_BDyMEcCxhtQS__BJXsTOmlEbGw_1771340726
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1406914.1771340720.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> For cache=3Dloose I couldn't reproduce, but with cache=3Dmmap I could rep=
roduce
> data corruption, folio writeback hangup and the following error message:
>=20
> [   60.847671] [append] R=3D134d: No submit

Can you get me some tracing?  If you can turn on:

echo 65536 >/sys/kernel/tracing/buffer_size_kb
echo 1 > /sys/kernel/tracing/events/netfs/netfs_read/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_write/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_rreq/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_sreq/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_failure/enable

run the test to generate the issue, then get the trace:

cat /sys/kernel/tracing/trace | bzip2 -9 >trace.txt

and grab whatever it said in dmesg, particularly if it mentions R=3D<hex-nu=
mber>.

Thanks,
David

