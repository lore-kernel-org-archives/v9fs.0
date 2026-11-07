Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070071;
	b=zLVtIlNicJfQ+jxFz4q9SCQPUKFfi/rUgA7iE3Y/cFZv67vhhhrCN+LlhOcxDc638M1p
	 IzVYY5/Hjck2AMnznkPPNX2XiemtES0acZpObHKnQA8w4pd3axdLEGab9oaCmRvupuale
	 4q123Pri1tKLQKFrzTaDpgBt332Ek4P/k93wPWFSMJpLd9RPg4AVULkesxiljRaS5FpWZ
	 9xqjRUqDZD5l38l2+BmcDJ1W092mZDnWI2tdD6uoS8x3V5wAuFiMSZc0JpQxKNG2Vw2SA
	 M4y0Za4vFdfF1KEigXiTwVqGoOK4Y9YVApF3TkeegdkoLrkAlN3OR9k3SnuWBxFznLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070071;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sAqMRWw+Cx9Umq4B3+xjlkeyqmhaIpTBFUvpatAww7k=;
	b=rftKjk7zr1ks0uUuRy9yvpjDfur2p7QxFGS3r4o+oWShytxS8TGCSRjfM9W9fwgQiJgv
	 YgwiPccIK9K/jF2BBbh5foDANeJ9vwXE1vkjtt2u8UMqUOkWpjLgmyynXzcynIWfKUKwl
	 0NxPcP26ZEAUmLW7DkQL81G4vI/YDm2DVnBnF9C8finNt+hbqspkimurM4Nns1UC9OAWA
	 Ql+MYgoyyRqskSRlXpuiPWc9xEp22hv5Gq3Q6CrQeSU9g895ijIzZfnLZPHd605uEuiSX
	 MSYRqw30+z/mZXh2zQS3BLW/jxOhuiO9nCjVT/PFdjnytviwG8Gf28xAXWlz48BHGnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6vQkuJ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD93606A326
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6vQkuJ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD851F0089F;
	Sat,  7 Nov 2026 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794070070;
	bh=sAqMRWw+Cx9Umq4B3+xjlkeyqmhaIpTBFUvpatAww7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6vQkuJ6Oh6cizic3R5hi5xR7P0ffxMXoDCB+qOqudMjiRYEbvBQicDUAysZ4Mv4H
	 YPbN/Wp9U32gwmAQV7qBMt38YGQ4AvnqBAULmYZWGFXlFqW7jJRPalVZbQQhGcHPYR
	 DHd9CV8Jp/UeXg39TMXxTeHJjtkyLb6HS/G9j+vpW8nfQkNAdVXURi/ByEmkO/dHzn
	 aYr1NVgMOKIHKt79GJPSEsOqCW4flp6ay+Jhvh/XI2DNgR7rPRe0bD9wywljnoi92y
	 o5dcJv0d+LeG1PW2MWjpXXgl9uMFLR5zJKHcRJBQw0Bi1TYn7pC4+9KaxgzvDrWXQn
	 N3TqEkFsJki9A==
Message-ID: <sashiko-outbox-203073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 04/15] iov_iter: Add an API document for the bvecq
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-5-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-5-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 16:47:49 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add an API description document for the bvecq structure.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D4

