Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446058;
	b=2TRS/rx0QOTKhsEJoCiLWXGBQZLWLD4/gQPvctLY1mikhRbOaAUQjEZCMDYuPwPaQ4w2
	 jY5UNCyJcra+vMbFolQzXobW/JgoDty8Im8NdMejX98jKJaZ8PCv5b9NgjKh8TpVxQNRA
	 lv1+BSzPnWZgeoAxNYCxsQRV4mKFV1LAJUFLkZLRVMwvkkUi8zUo7DKjp4QTnekV+qVwo
	 QBA5SQjAWLiiLyb+x6/7e8sOEenLwoul+UsfIFvO/yX6gpqlXYq7kIRYSo/iIiBJCDqJA
	 PE1VRtJQ0ohm0Hr2VFiHbPJh0WAxJD663YL8JD6kwHScFNdg4kv/BDz8fcmjiIFuCqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446058;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LewGmTLyXVKDsIvmvm38B07g3LPMOzYtEn4CDhXQEWQ=;
	b=evjCznDpbVjrlxM8l2yXi4t0tg65sHETiIAnzEesEpxxAWVRr2T02usGMdfY2nG/X2lx
	 DV/7C5DRUHmA+8jrELGEf5OiTNrjeDASh+bxtjzhOplVuEkN32jtnmr3Ckm6f9YynGTP2
	 Spyt28IivSsESeHi+X2UbwcIkNj0+UGIsnovs8H6g2lA2NylfISyQwdfBebkKuSen+NGD
	 hKDkdrZMP03TWZS3xws26Wc+2QCdtAYbTczGh/3aKBEBGboQ5TfMGhJwXdHvCSrCnMqAx
	 wpXUDGNvD6175WOGiFDMrfwyqjDpFcyJSCXKxFEY7PQs2P9Z1THFGuHfMwJR1l0MDeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4nRaMKq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAB606A324
	for <v9fs@lists.linux.dev>; Thu, 12 Nov 2026 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4nRaMKq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F2F1F00A06;
	Thu, 12 Nov 2026 01:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446057;
	bh=LewGmTLyXVKDsIvmvm38B07g3LPMOzYtEn4CDhXQEWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4nRaMKq9ajB5sFxjayyGJoorMov8afrApjoM9Vz9zmnLx/07BIXtdcDTgeAAzTOi
	 CSVzNlpKUHYK1pjLgM0Gyn1t2M57JWhLFc+2lR/3aB0yRBpxhe0lg6UMVTwluZOHJJ
	 WlveeovtCe2Ec7/wO9rqh/JGQ4LTSRWbNl6I7HFFKrXN4f4QGC5sTWN2AlA60LI96t
	 MwWRcJdXUJnB20fNvgnaBiBoqHZurqiu7er07v6M7Ew8hNrYuGWDcj9Zkpv563JMfw
	 MCgvwCjkOGjAvcIDHVhhks9C1SHywEotz//W8YrkT/5l60xzmruJ4Q+Lkb/yo6L+eR
	 2b0SgOYMeXvSA==
Message-ID: <sashiko-outbox-210048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 17/17] netfs: Remove folio_queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-18-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-18-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:14:17 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D17

