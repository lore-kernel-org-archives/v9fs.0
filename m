Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077849;
	b=3sfsxLqnohGyHK7N1p2pynwBMqGaNm50ZjcqOvTinGSTv1P81bhnquEHpXhXvsYDe3L4
	 S5y5LFtWCdsCatxd1h95FGalDs7ym7gteXUqIDSpj1QHODueFHAJ4DoGGfPD7v5d7wt5Y
	 dSaFHxKIVqqdsvSzReoiEhgSCaOTZeW1ksTuPGDJ+PXzSMzCSHJbkDiwvk9ZrB4q1/q91
	 BVSNKanG5KKPvYtQ5DrTeF9vPTV+hNUnKpi8QdfyHIs+CX1E1IRC3nBjequtXfVL2XLH/
	 +TecqF6rqf6gLD6STakA/8pc6axiWPo/YcsCHMBb0kBaABs2H15iVxnekCJCEd04J1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077849;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EiWOBeoDcuTV/mSmzY3hSZUm5c1ycrbHi7PqTmW/uA8=;
	b=Kynz0jQ47htVi08PDLmZY1c4+RHJ4JEzsOeLQJRhwrJ5HAV30PLq5wZje4SWDlm3Av47
	 JSKYw3OG2D/TYQmEaYvsfLQIcclLNWZKuwWMTBRfJFDcFhq7B8Q8E5yEM8zcoeHYPbipt
	 k/4W/NHOjJaBaDlzh4y/mMWV/2QajpLVytRG98JRY54d4TfuKF/HprrVv6StS0Zfpj2ob
	 clM9KoiUrgO5oe0TtuiDarTSMtLyv58cjs4nxGhkTf6TeQrtFRWXSPCI5ov1hGlPOATlU
	 sqoZ2UCVNrbwW7iXv2i9HW+BG0lq4q0QPkSHDoW2FWTUXmd8co3P5Np195iHcuOUAJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GU85UuWr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7A606A324
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GU85UuWr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2231F000C5;
	Thu, 19 Nov 2026 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077848;
	bh=EiWOBeoDcuTV/mSmzY3hSZUm5c1ycrbHi7PqTmW/uA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GU85UuWrn2/ii5zXQP3ft3cis0SqrGV6F5t68jlWzJgOHOoC1sRnOgIAaKQN6cZVo
	 YLwotr990ia3joi4eLcsqHAgJPG67YN7UYeT5amG7YNF1ia1Ezq+XKpPT0McT0+TLh
	 JzskiUskTYqCwB+AzGG3rqULMCoLSLh47WCxHURKSk/r26ldDnjBWR7ZhuKrCw6GSq
	 gnXmhqNPrja0wb6SM+cq+AufGWtkJbI39z1mdrR3jvsNz2h191UwEm/1Gqtb7mcOFp
	 EdDKNX8d5sAVSP4xBi+/OMCtVMON6nyhc2HRQrsEXwlftyoxxnoa4T5fIkrEiOdDRN
	 /TWf12G9A2FPg==
Message-ID: <sashiko-outbox-222702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 02/17] block: Add a function to kmap one page of a
 multipage bio_vec
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-3-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-3-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:44:08 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add a function to kmap one page of a multipage bio_vec by offset (which is
> added to the offset in the bio_vec internally).  The caller is responsible
> for calculating how much of the page is then available.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D2

