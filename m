Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394791;
	b=cqvqYKzq6PrApobkpC4wWuNU//6vqvehBU4obPrnUQ1rRK5UxBmLJWhZU/PATbYDJFTz
	 3qTk4UkfPrrJ6OZ0ViWqTuehY47bTSPplRk0ut99vmi48eFpfi/5UhWgiyV58NY01pHUM
	 nOkValDmE6L5HtrXm0BTDno3csMKTs83kcbdFKT9pKA+tVxkzWN6Hxq6sN6DFx2qYGdix
	 CFSd5uq4jco8+RjXouxSGS4E6zRNQ4bm7xBT+7P4AWgCBeS/SbAM5Gxe7neOBRDkSCLZ+
	 91RookIf/eTKaYj45727JUYfncN530DkYLSXRK4QZ7NWuyOttNKNdNG90NSMbX0RKCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TM+dWC6XSykhdT4jgOfhnAuWSmeY6qnSURZHzc45mo8=;
	b=2AvWrYi/KRPLs2g0hC++QV34gxULz2AnOTzlkRxVK4+Aib9O4L3iGR0Qfrib0TLhXenS
	 GabeaNU5CITrMIWjufsM+ILr7Jn/vRad+0IgZ6tHK5hmYppN4P498L5iz3HqHxwxReDLA
	 QyrwengEBEGecmNYZCB5RuOT59yWaEnlyj/gVTB5O8KeIMgmmtFddfrmQ+aH/gxwBrDWt
	 otZrD52BQ4C9Th5re07fWA82qEWYPul6r8Q7IKHT9DqEcqOor2JH91Q3GdFwUJpZTaN5o
	 FOIdnKMtvMDIG2Z8pjVqdaTwiuywEKp3HSJvF7UdRUBJTr75Yo8QWQCyhcj4keIxXlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CP3vgFtY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA76606A332
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CP3vgFtY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EAD1F000F2;
	Mon, 23 Nov 2026 00:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795394791;
	bh=TM+dWC6XSykhdT4jgOfhnAuWSmeY6qnSURZHzc45mo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CP3vgFtYTplRUK4j4F4Ci9rurQIvUFCW+4vaA8MoEFvL0MzIxutlTxdVJ/9j3psCX
	 8e2p4KgqTl+sbNR5BeV3b0c5HiamMdhR3Cr/N72OE8ujN/MV87/GlbV6nVPStpGBGv
	 K78yV6t1Ihz2Ud2e5qDRym3BiKmU0oHKcctTYi7QJW7sFdt1WQzTSMxNrY3SmiolYl
	 qMVzVtIxOZOWtlpgrHsKsp/vka/N18zT2pBDCfJ8ktPo6xNdjCkp+ll0KLpJ+OrUSP
	 /0njQUctoX3TbBBbyD0rzI8l93YwKuGIYnz+XdjTlFTxEnqUCW2GZG7U2V0uf4AIiK
	 xJbe4v3QbGXGg==
Message-ID: <sashiko-outbox-228488@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net/9p: client.h: clean up kernel-doc warnings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261123004425.1770155-1-rdunlap@infradead.org>
References: <20261123004425.1770155-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 00:46:31 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Repair all kernel-doc warnings:
>=20
> Warning: include/net/9p/client.h:52 Enum value 'BeginDisconnect' not desc=
ribed in enum 'p9_trans_status'
> Warning: include/net/9p/client.h:90 struct member 'refcount' not describe=
d in 'p9_req_t'
> Warning: include/net/9p/client.h:132 struct member 'fcall_cache' not desc=
ribed in 'p9_client'
> Warning: include/net/9p/client.h:132 struct member 'trans_opts' not descr=
ibed in 'p9_client'
> Warning: include/net/9p/client.h:147 expecting prototype for struct p9_fd=
_opts. Prototype was for struct p9_client_opts instead
> Warning: include/net/9p/client.h:243 enum fid_source { FID_FROM_OTHER, FI=
D_FROM_INODE, FID_FROM_DENTRY, }; error: Cannot parse struct or union!
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123004425.1770=
155-1-rdunlap@infradead.org?part=3D1
