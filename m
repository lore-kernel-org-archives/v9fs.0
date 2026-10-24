Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833868;
	b=HA3/PqT8ZNzhUdGOfkG3Ek2DUcb9GcSI4qQBegUtSwLmD2HeUjx7aTrKUmdmV6vDkojO
	 zxc1XX9O3SplHxfWA/rFH1IbY5M/9K0rV8biP214GjEFowDF4CaFnwP5cZJwq3s3+ELuX
	 7XiAG7maG1DUV7qVmVhzc22Vam+AlpYXeaWbe2WdIvgJ+cbFGwMOyrmTwSl8yWij2Gbye
	 JN9vt5J6eMmhLFGKOtfJrUpZ18905wveLep/5uUGpBPNQ9pNdQdYVnDYCbMCs7z+oVmsI
	 90LjzSyYzJqQhND0njH4zwT3ExYbEJLQ4XjzS/1ZQqrWYn3lluBWZbyxqbfA6IOuWEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833868;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=20g1n67mgcse/OFwAHllQ4Px0lcCgzfEPHkfT4WiPA0=;
	b=qClKlnX2f8S1mSd5DAlxKYzj1Z0D9IT7RxqhN6xzSW4JsL/zxnn3ThlA0RvgbfDRKzmq
	 U3IUQ469k4wjXtIllH4UmkJQle8Bmsb9b/N+Fc03vKL1maGxS1pD2tSTQCpkIimo87nwG
	 ztK2s/HU8vj2skbvYaw0UbB4/dnPYeFtppavgBFxLjn1TOof+lzAL62RDW1KsD6M9Mpoi
	 yhr0tB0GdPzgJGk2o10jTJQjUipL9w4UD4pJ78sHL2EahzXy1vVaZQv4Lj5Anm9712lRm
	 UORF4+1G4qu7EDniaSw0cmZUapCAq6CdhtmB30hPRrL4tn6PcjazeETyF61x1Y0KKmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fdDKC/+Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01244606A31A
	for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdDKC/+Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3591F01825;
	Sat, 24 Oct 2026 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792833867;
	bh=20g1n67mgcse/OFwAHllQ4Px0lcCgzfEPHkfT4WiPA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdDKC/+YV2Z7dNP7kMwFqhc/3pVevs9uilMiJewrkVMu9DsH0XPe9ubClt9/5FwJZ
	 ZQcjEy0AYLoAY8HvCRSs8fKdLcz2Y6MZwvf7CWFvIOzg5FT38y/21W6l4qGA6zcyzo
	 Ycj2kYeVXSmXhx2CR+grwGFj/EOkqM2yAaDPucz/hQ0dJdz7lU9ILkspY3Eg+I41U5
	 bqIMHKockyo8JDkrcB/aeKXaM5tcGHZCbStS1AY9WfGHXuSf6z0nKqEyMCozvHUncc
	 bczWuBo1EnzAwBfkPpvsvxIQWJa+PJ3uxIKmdD0FGp8K1A3PAW9lnOXEl67fPdfNhw
	 LUuRCvqKTRLnA==
Message-ID: <sashiko-outbox-183608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] 9p: fix typo in file header comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankit Thakur" <codeankit.thakur@gmail.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261024092154.1844-4-codeankit.thakur@gmail.com>
References: <20261024092154.1844-1-codeankit.thakur@gmail.com>
 <20261024092154.1844-4-codeankit.thakur@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 09:24:26 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Fix the spelling mistake contians -> contains in the header comments
> of vfs_addr.c, vfs_dentry.c and vfs_file.c.
>=20
> Signed-off-by: Ankit Thakur <codeankit.thakur@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024092154.1844=
-1-codeankit.thakur@gmail.com?part=3D4

