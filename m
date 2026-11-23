Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467177;
	b=jDw2nqV+JYHq/X8TKCVDHi2i5GsdO+vsFyDvVKjxUJMLOgZfqWkXxVHPHdgui/YjA5B1
	 SB3t8HJi5VhlKX0gHWOsI+3A+acGplm+GTgnZFgekiUR7YecDgSto5A3J5DlRrXj8hjto
	 EWa2GzoAXKfGQEEQusfFUaFpkFuW/BFbq0q8R4Ab219TB3vA98Wdg+tzcRNsKMF1MtN+T
	 cwUKXCR1exIz8270C3pPqK+kW34uTOaZKMK30EJbE1ZV/uPYXlBLIThQCACk4eeOebrhL
	 crhprKFWmTjSsd3XnX5GYQL7ceKSv5heUpqYgpARURykeJZbU94iDehqb0a9IoaKxPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467177;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lHnfd3KvdsnNbiZjU/lJnPPSvZ1d+GfQrcVTFXHwsuw=;
	b=b0DDKIgc0YU78vs7JYIP9Ns5Bf2FEUinRlkxdsZxCotTK8X/ABDB7EspoeNq6bMHMniD
	 T7BIimtBRhQ6ZmlarlPddWq2cYYGhA+tabrbi+4p8vmmlflNS3wKr96OOTksP5xu3ei9a
	 Ymafb+fnmH3kNmDU/YuWxwv+JIYdCNQoR7dPhwE+fIBow8x+usU2ff+wtGv5m24wVLXCb
	 +nob9TRyzMMJ4pQZJG41UNsqHhn5HpbAKWWhykjt4ehLoEbgL+n5/8rQs0+zzqeAjrvTW
	 2T3RZgQDTZ8HAkUWCbQBzM51WdZyPYAyLmXCvdts6PZ+s1eGnY+kXTtQ/gHQi5pL3Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMUsuCSO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B21606A680
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMUsuCSO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1086E1F000E6;
	Mon, 23 Nov 2026 20:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795467177;
	bh=lHnfd3KvdsnNbiZjU/lJnPPSvZ1d+GfQrcVTFXHwsuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aMUsuCSOqLWbROXs22+0cKdJkE94fdQoh6FYrVAAzrfLv3eo0/FhKLMSyk6GzCDZF
	 N8NX2YAxKKxnitYY2PAHPc8+Nlv4yePaLKXlnxs5hSfCDYijsnnaBGyS6CW2AKtPe9
	 PKBipr9aHzJhciGrAcaHBVfmCxMrSLH7KgRIdhyYx3bQJqnsldAZEqnIDllkH3ACi4
	 dxS7z/8TkFY0NGeRYSf1ZiX9oFqbu7Rugku4OIaX4CHEgHqkdzftasb9S0xg6Wr/Io
	 phSCONE56tb0WSwngDb62PIfs5a8Jq+09dZBRl7e5TLdjAX0GiSyE3nOYZDkGMylZX
	 TzGboUvyEhq7A==
Message-ID: <sashiko-outbox-230031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/5] 9p: bound zero-copy error replies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261123204257.3055515-1-lian@is.s.u-tokyo.ac.jp>
References: <20261123204257.3055515-1-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 20:52:56 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Sashiko has reviewed this 5-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123204257.3055=
515-1-lian@is.s.u-tokyo.ac.jp
