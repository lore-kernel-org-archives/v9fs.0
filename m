Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080107;
	b=NSIA5TyhqB7iX6QXxH/FdrOjR0xem6vaGKl+wpcl5QLXLmqgE6CZlvhAnmsPVEqF4m7a
	 CFAnwUOq0Da/B63lq3jXMKDAPiH9u6TmgqFLXb3LTObE+4sHSCgkad3ohcLY0f1wRmAF3
	 WFaZrBH8cllX1cvWueBIZmPKeGpVpK4YxCAU6nAtP48sSRcmoz2wkmlGaXehVbddivC22
	 6i2ys7c7w+2tO9+hjpSifGlZZPTUz/Y/vWkz7DvJqWJ0596fLDDwhOXCXZsmrfLbStNF1
	 8NV99ZP2nIFpuZn4E+zDq1rIiFie9UGxibSZCHiP5r2S7Mg9pkgm483WhIbJqsGWfow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Nc7p3kXZgdNMvvR16ijm4lxBtJcF23gaXobopE4g4Vk=;
	b=HrGmvc764nsK6ATK6BD9qQrORAnT3m3dGaH7crTFznzqCtIhIplDm9k3XUJcWPg6fBJk
	 R/PhtgAKYbRxvXqKliBpNOQQwIMgs3HqnDcgQImqDH2w+ZaWuVV8uE5Bi/oc9RFU5CIQ4
	 bXf1cRKmj6uCSPYUbT5Q/aryMiv/6tuxqOUINTlMMO6mrtdxTB63m1qip1HUSX2dF2ejy
	 gmODX05kdsaxrm45rpO5d4OrYB1UEoWCHASifxDS3k0IGi2T4TmwDCQW5WidKj/vhnY0r
	 2FlyoMD8JgiEACAEJ+1SEmYgz7MIu8ucL37bBxv8w+LHU7NClC1/PwQmHHet3Kd9ZPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIpct+ZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37538606A32E
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIpct+ZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0661F008A1;
	Sat,  7 Nov 2026 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080107;
	bh=Nc7p3kXZgdNMvvR16ijm4lxBtJcF23gaXobopE4g4Vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIpct+ZPZyv21KIYnxtgRDBzVWXpKzih1BdKiS+nABLprfvaIBNI0dBz/WFjpAgPJ
	 LXHXeg63tatwe13nlAzgaXj7juJgn7TgV+K0HQZbfhxv68VWdZtOAIZ1CkI6MUrOg+
	 +C96ub2ohAqKrQya10QjPs7rACup6MViKWBbc4Li5SP/YV7BIbmcw8PaMnQuFydGUA
	 3I+KbQBt46xBA4/japmrip319rIQrSEsvZNVcz6q5emTyHygKo/l46qQNXsZBWEf1v
	 2b3BBRIIjdDI3MC2VyVT5h8PiNY475miMrei1COY4Gp4YLBsprD+9xh499xxvWVPCh
	 +yDfDTaLATjxw==
Message-ID: <sashiko-outbox-203215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 15/15] netfs: Remove folio_queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-16-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-16-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 19:35:06 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Remove folio_queue as it's no longer used.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D15

