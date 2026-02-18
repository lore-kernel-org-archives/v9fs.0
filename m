Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAC2BDC0E
	for <v9fs@lists.linux.dev>; Wed, 18 Feb 2026 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423475; cv=none; b=lY1ZSTjA8Vwa6QSoeZn5mG9TNjdHTaF2uReqLIWOF3mlIPqp0JHeDkPyHRDnjOjoRohoipscVJ59uf1wd8UijT6Tg7+iHDVvawU1ZqS/iJhAiXsyjNnM8R9JMJkcBjhA3tn/LMLpP+5pyuWcu97decto6GrXLKQfY+aasBXFhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423475; c=relaxed/simple;
	bh=TNZzbSLJhHLTzkHSvKQf5s5IcDsMqmtRT4dhHYEn0Ks=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=hV1i05OUo05P5t5LPqJ2Gj7FYZepddo9XnSsc/yD3ZJ6Tg51pb9l7O52161jb63mVJHD6zbhnK6aRojTFQfhVZt3/em4/8FFRlA1Q1gU7/daHDUICMkx07t/1O0vDzleflseXtAC0a5L+AtinRpoWdlEA5VZAXVaWMpY/+5t4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AW6IEmyM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AW6IEmyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771423473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B5lItI2HMNC3I69sNatNnLq8/92gRiDlJ/JCPKXC0A=;
	b=AW6IEmyMpnUZvryOxcroCjy4mZCaXBmXf4T2IdhkFG0KZ0OK2sYl7SlABnJK3RicESuElM
	rcdcZGlclTKPE3Ru18PQ2uiGm6V7XPrIuHAK412LIG2Mdam5nfymDoCbWfQmN49HiSnxBq
	Q9sY7ic7qC/ewyshkvul6Qua8c8My7w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-LmxqVnvwNDO9SftvJawgog-1; Wed,
 18 Feb 2026 09:04:29 -0500
X-MC-Unique: LmxqVnvwNDO9SftvJawgog-1
X-Mimecast-MFC-AGG-ID: LmxqVnvwNDO9SftvJawgog_1771423468
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61934180063A;
	Wed, 18 Feb 2026 14:04:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.225.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAABE1956095;
	Wed, 18 Feb 2026 14:04:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2393940.ElGaqSPkdT@weasel>
References: <2393940.ElGaqSPkdT@weasel> <20251227083751.715152-1-pierre@barre.sh>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: dhowells@redhat.com, ericvh@kernel.org, lucho@ionkov.net,
    asmadeus@codewreck.org, Pierre Barre <pierre@barre.sh>,
    v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: fix data corruption with writeback caching during concurrent stat
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 18 Feb 2026 14:04:24 +0000
Message-ID: <1643438.1771423464@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 0kzu7ucDeUc0xSXksQ29xRzlDRYt1L0eOQNMsEJJ2u4_1771423468
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1643437.1771423464.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> > -=09=09=09int retval =3D filemap_fdatawrite(inode->i_mapping);
> > +=09=09=09int retval =3D filemap_write_and_wait(inode->i_mapping);
>=20
> Haven't reviewed thorougly, but this looks wrong to me. The point about w=
rite-
> back is not having to wait for completion.

You should do this if AT_STATX_FORCE_SYNC is set and otherwise not if
AT_STATX_DONT_SYNC is set.

> > +=09v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb,
> > +=09=09(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : =
0);
>=20
> And this measure alone (along with the same change in v9fs_vfs_getattr_do=
tl()
> that is) would not fix the misbehavior you encountered?

As mentioned in response to v2, I think this is the wrong approach and that
you should compare the retrieved stat->length to ->netfs.remote_i_size and =
not
update ->i_size if there was no change.  Ideally you'd also compare mtime t=
oo,
but you don't know what mtime changed to:-/.

David

