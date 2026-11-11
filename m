Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432207;
	b=RoU2OQjQFdDAWhsn10SHAm04kT9uJJeSNUKOcavwA58YHD27bU86mz8UwdkHH1DQUmH3
	 B8xtUmo6/e6pZHAI2NR2PxWDPis4BpUkwWucKt06IluZPOUcH4B9WJQMLRRbvaQ9xgUVJ
	 6BtT2Rb65sXjkppGdjOsCDPyi3W2+C0oKNMHpxDkTHGkiQD8atmDSqTagFj5Wg5LFFU48
	 4dPjcJZdS2UwKOJ23N/FCSIlc4eP+WyCqN8fTzrMQ1NVB7MDK/xZibZOq2e/0V12jQWOW
	 icgUNC5V+RFqcrE9WKTRYrR5SB9tJnLPty6WSJX0mr9UUPL0xHZuEKUbX0DBOo7u4eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5O/6CbMIp3tVmYZd9g0oyC/1sJldG9BxEuFTTbq6yEQ=;
	b=4rZ7QrikYvFBtpAMrNfMV4RxD+oSyVlGs4E1D3PhbsVEAa9XJMxko3u5Y4aUfDFTzxoI
	 Vw+8ik/PVqg5idjJgK+iZQRFKoLa9CXlWfRX+66YbwW+weJqkw8efGB11WhAmBJT7FyRR
	 lt/76O1F+M6KgExBz8AkldM7yoBz9JJvl11NqE59n4KCIjoSdlf34r6PKIJjklgnbyGcW
	 Go95dujS2N2izW5v9YlONv0jRY4kpHWk9cQc7zQ0TJKr6Je2tL4ddMFxTiZDX6otkBvZQ
	 6zFcVZ2a1Ti/f43z/3MMw/QBH41/294aDk+LAkmGf2YEYdiV0Iwdl1YJdKJyKY9I2ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEq8U34J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48164606A31C
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEq8U34J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC261F00A05;
	Wed, 11 Nov 2026 21:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794432207;
	bh=5O/6CbMIp3tVmYZd9g0oyC/1sJldG9BxEuFTTbq6yEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEq8U34JDJkJKYTjH63iEDt4/+dRpymwzTjx/gPNg1utjJpnSbiMYZdjD+697HgcC
	 AE3w1nHelv2M+s+ywFkDQW69oHwkDhsDHj11VolddH9I3rq97lxY5CV09ndooTcmH5
	 JEaQHvO4KDA9yjgkGXNsKmoRvGuI/aBPVfZaRjJcsJFAayLii33dCaW1zCchJGdA0L
	 munvs6b1UUKwdnBOFghZKLw/QKfq3yb4Z30VAzv+mx+M4fVNxmMvoZTRKlkECpJOZ6
	 BVVFrHPJs0VFsuOzlzC8hnmZOZlWBsiKVNTHbN7DKgPOzDQschRhcVW/ZQbH7JKEAl
	 Q5BS+0bnzBNzA==
Message-ID: <sashiko-outbox-209701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 01/17] iov_iter: Fix kunit test to remove __init and
 __refdata marks
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-2-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-2-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:23:26 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Remove the __init marks from the functions in the iov_iter kunit test so
> that they don't get removed after the module is loaded or if the test is
> built in as the tests can be triggered through debugfs too.
>=20
> Also remove the __refdata mark which is unnecessary if the table so marked
> doesn't point at any __init funcs.
>=20
> This was found by claude-opus-5-5 run locally.
>=20
> Fixes: 2d71340ff1d4 ("iov_iter: Kunit tests for copying to/from an iterat=
or")
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D1

