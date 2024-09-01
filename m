Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15812273F9
	for <v9fs@lists.linux.dev>; Sun,  1 Sep 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725175032; cv=none; b=ZJ0Mlb4lXMufzVB0og6a4/bJY/FRlehmp1jVx8BhzkFsZfmC5wTqJMDA43iIKACIkXZ9nrMxMOyNc5IeNzykcMS432rDS+uQyaxKtWXQNnCQfXrahlZpnHJLsBGuk56POtIouhC86SvY8v4EeX1LBPsUjGyu90Gssy8Cy9Pa4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725175032; c=relaxed/simple;
	bh=vpA9rSaUpAhVMPr+dAxn2EdpbhzfiLUuNmvKKqtR77c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h6IhFblA0kQixRGKOOKZYv+EPDs5h3Fp8AQrtjj4jpKg/P2YSrmeNHQjB96+vGBnyZCqv+QG7yXjkMzgskA/UukDHjwww6Uupb+9Tx/BcygYCbuzRuV4IVHEovrxLDejdq+VsunjntjIOP12CAAwuyNlFYVYhprJtKAxuX6P8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=k1ErmVLJ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="k1ErmVLJ"
Received: from fpc (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3BFAA4078535;
	Sun,  1 Sep 2024 07:17:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3BFAA4078535
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1725175020;
	bh=vpA9rSaUpAhVMPr+dAxn2EdpbhzfiLUuNmvKKqtR77c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k1ErmVLJLph5onD2rnbZh9zU4oWfgeOtKkn8DUGJ5CHWfsUBh/mG8Q7OxKkZtFAvR
	 tj0L67wblpmt/HT/mpBi2EfBDmNzvGgeBQKiBgRdtBVr8+cD8BqmI2lKoklDtE1nQq
	 M7CbVeg++hb0xClxpLf/xHEjYrkzldAVpMs0n/3c=
Date: Sun, 1 Sep 2024 10:16:55 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	xingwei lee <xrivendell7@gmail.com>,
	sam sun <samsun1006219@gmail.com>, lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] 9p: cap xattr max size to XATTR_SIZE_MAX
Message-ID: <20240901-075b24ce58df695232e3d345-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4091309.WcpKHNDlqE@silver>

Hi Dominique and Christian,

the issue is still present in upstream kernel [1].

Considering the remark from Christian that limiting the allocation to
XATTR_SIZE_MAX seems too Linux-specific, maybe just fail silently with
__GFP_NOWARN flag passed to the allocator and return ENOMEM? I submitted
the patch [2] sometime ago which looks still applicable to the mainline
kernel. It was superseded with current discussion.

[1]: https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
[2]: https://lore.kernel.org/lkml/20240202121319.21743-1-pchelkin@ispras.ru/
