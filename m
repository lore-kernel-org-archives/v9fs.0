Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440356;
	b=atqYGIDhstu+KGcTY5C8gKzFOWGJAUDqQ+dgonJjcMFCwm65DnT8J/be86TyL2GrCask
	 u+uw/T0OM3WfV2e6RtiPwgfWtd4xkyPqdTb0vb1GUbH3LTcdNcwl0HfByUkN91TjLBMvS
	 WZb8Iw+mia45AbcDTDV4bbdKSg2/vAvv0f2kb8AaUWjMPpl+wqBD4P6I+hj8VX4B5qVxe
	 3i6IXUh9XJPBjYvTlit+kXYw1L1HlFT1a6FUhZvV4rkblC/TFracP74SQFDr+2jpaCVfL
	 tYBlmB5WzrnENGTBcKLryTDcIfVWSLPpIXM2JDrEl2JvrC+dg2YVzHpA8HihEx22dSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440356;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8q1wyN0BPRdLfhUQ3WkumMCB8GyTclExX0ljh8ksGDg=;
	b=QhIHwailyV2LJCiOfYfkf4XpJkbx5B/C0bdnebyryCzpcFXcTZeQSflt/ey2nidBZc9c
	 T9JSl9jjiH3D2m3pK62XHFDe64/olHsjugfZlxVbOqSKT3qAOY7lmioO7TCBWDJqYRwtd
	 7hUd0NwJ9+RkoSrTwRla+76BOA7e4CQ9uiBT690zE51i4JaDWLhyVPXuaSWbzEun6J81G
	 u1HUMKYVpfVHqxPSCynO4Wgv0gY6y1PYIv75ak0h64idtyv7ERlqUzktICAHSpOEGY0QG
	 LIC/QeeMBTADwld8X6XBORo7mUeLsYhPoQS4A7FMXAtPpegm+OxnoCxm2MRVKu4pvBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xz4yeIaw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08252606A321
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xz4yeIaw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753331F00A05;
	Wed, 11 Nov 2026 23:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440355;
	bh=8q1wyN0BPRdLfhUQ3WkumMCB8GyTclExX0ljh8ksGDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xz4yeIawKx9/2FJAmV6JXY+eEEbzGKad7b54Hukf7ce6K9Q8OjEVBnJHQ3W8jzV1T
	 hIIrDaLXQNxf+Xzcz0+NMWivYUsWXjKlzf6DzoQV+gBMR/ytXbHCX5sVdmoX6+jZUW
	 W1ZSiXnhadHmBr9U4KSeg0E7Fj85sUIYL/DRIF9mtCtFXghdbD2WhE/zjbfYTgcwkv
	 CdML0jzZ5h9Mi6k2CXW7cHBmULefNBdw7eg+DkTAdb+ENeU3XP4tOtCJ930ymZurLW
	 axwPTJQl7/Qs6MKc5rP4Ko4cQGhVMzrZxxmQpl97py5WTnWvdgDf3tfqB05gxYVBBN
	 cZ4bDTCSa6gAA==
Message-ID: <sashiko-outbox-209861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 10/17] netfs: Pass the write length to request
 creation where appropriate
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-11-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-11-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:39:14 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> For unbuffered/DIO writes and writes to single-type objects, pass the
> length down into the request creation function so that wreq->len gets set
> correctly.  For buffered writeback and pgpriv2 copying, this remains 0 as
> we don't know in advance how big the request will be.
>=20
> A subsequent patch will use this to set as the i_size on single-type
> objects (e.g. afs directories) as we don't care what the old i_size was a=
nd
> we don't want to see inode->i_size in the netfs file changing due to
> third-party invalidation before we update fscache to say how big the obje=
ct
> is going to be.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D10

