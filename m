Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A4389118
	for <v9fs@lists.linux.dev>; Mon, 14 Sep 2026 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372962; cv=none; b=tWXj3jKqSW3ptPEAb7aFH2NeQFC+f8MJf1beb0eRSMQ0maltqTwfp5C7Idp/NChwmvr4PADkt36SiU5EPnIckYFY4mwtdkz19EesbSNidF8KjNNOw7xyyT6w4d1fh/ryLYhLFKJrhuGn6VnBGCYLx7PmC2UAXXmh26n4q+wlMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372962; c=relaxed/simple;
	bh=0XLfn5ETNRGKggTXVZ0vSfnDmVHRy2UStC/YLmtpyww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8QPYiSPFIdTBwXEh5Xb5RLkYctTtVaNI5cQTwLpY2zg4HcQIxDsGvgtM80VokvuqXlE8LVJukuOjdpT3oQYpI4ANql49U9lXtSFMcfdPwa1Tn9e+wreqvcBPiKU1VC+cFcrqxqhSRRQbrvYou0Cn/SwaTdCMzXRKnS7aecgGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=flzqS/rZ; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="flzqS/rZ"
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:582e:0:640:200:0])
	by forward500a.mail.yandex.net (postfix) with ESMTPS id 9BB52C167A;
	Mon, 14 Sep 2026 11:02:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp) with ESMTPSA id R2O3LwPhESw0-bD0vkspT;
	Mon, 14 Sep 2026 11:02:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789372949; bh=TA2ifMI0GSkmTZhSSNoU056Ug53BH422mvnKFRL5cKE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=flzqS/rZ4Jb8SNEzow7JEyC+uCTfIiePOU1LZc7KB9A+ULgdaovtsSYdY+proYm6u
	 DOlsJr5jhI0/3I79IYw8w0xdzUOfpdMp2BtKhg0GY4n64sHJ5HnKfBhL6zybncoYJg
	 izQdih99Fy/KXLVc1IdXqpO+qb21fLyVGx1UUrIo=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <f297af9a-4a05-4c59-9dc5-9e00b58c3281@yandex.ru>
Date: Mon, 14 Sep 2026 11:02:27 +0300
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: simplify v9fs_cache_session_get_cookie()
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev
References: <20260814040826.1213127-1-dmantipov@yandex.ru>
 <aqanPLWK-hjvPrhK@codewreck.org>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <aqanPLWK-hjvPrhK@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/26 4:38 PM, Dominique Martinet wrote:

> I find it more readable to split the two e.g. keep the replace separate
> from the fscache call:
> +	strreplace(name, '/', ';');
> +	vcookie = fscache_acquire_volume(name, NULL, NULL, 0);
> 
> (this is fine because strreplace does a replace in place as well as
> returning the string)
> 
> If you're ok with this I'll change in place, this doesn't need a v2

Sure just do as you wish.

Dmitry
