Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0320E440620
	for <v9fs@lists.linux.dev>; Tue, 15 Sep 2026 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456171; cv=none; b=AGH4EygrYJaxmI5o5mYNzW/EkN+uhXy1CcARU6Y6A47Kd6s3cLpPl1LViqYr+JM1jwfXP2cw7oCSYsddxrJScgXFzAtwlvjrtozx+FcY0Pli84ReM9wCpGDHzDgEiLDP1YD7lv8sAPLj+ytDzHCiGv500YfqPpm6JUoi7UtpHns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456171; c=relaxed/simple;
	bh=zeWgHcoA+7eglTikukOUTmjeAqgmaZOiPJv96a4uDdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBocfkPRiOJRFsOodFuEJBBk/QuFBIqkPQL83C62HOBiy0B2ynSvpmpsg+7dY5AId2tRv9LUcH/XSKlldMktjIf5LPpNOrk1kxyamLa5OjPti9n70HCpSFv/JXFrMtksp/8P6a7kyJqPPYcgHpbKH5uUov4goegwArSsjD/G8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Pq0itti6; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Pq0itti6"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 42E6E14C2D6;
	Tue, 15 Sep 2026 09:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789456166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fCEjRGvqmfU4DBZcQR+nvqqf7oRsqSZ0AziZW3psYs=;
	b=Pq0itti6CckBBl20MVkOgB2buEDwXPGtTRjYjFKsG1YMhLxD0UbS/s1eybw7vi0Q7HEfmy
	6gEwH2c9a+IF9kz0wot9P+deTm9ND8lt72YLuwDF2YxAsiKlLFYUT/4OQLqOrU+PJ60KcN
	JoDrXx94X12amCQtP18oV1QwajFq21VdKuZSSLM/PFtYHT70K8Fo+98gseJaVgD0INi2+Q
	DEfNdjrZrQRL+ysrDvU0h2mb7i/UO8WYHoNgryUjUThjpKkFAP8q20eRW8GrVUBVsjAQJ9
	+xmqGNZdMbpk8yqMiR7l3l7aJ27K1qG1lko4y6naPzqgZD6TnQLkN7sf84C2iQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 75a35172;
	Tue, 15 Sep 2026 07:09:21 +0000 (UTC)
Date: Tue, 15 Sep 2026 16:09:06 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Michael Grzeschik <mgr@kernel.org>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Subject: Re: [PATCH] net/9p/usbg: Fix use-after-free on usb9pfs_clear_tx
Message-ID: <aqjvEj1ySKWCZz4U@codewreck.org>
References: <20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn>
 <aqZichSBFZgqFn8F@codewreck.org>
 <aqjflEL_79A95MGc@line.checkpat.ch>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqjflEL_79A95MGc@line.checkpat.ch>

Thank you for the acks!

Michael Grzeschik wrote on Tue, Sep 15, 2026 at 08:54:22AM +0200:
> >  - You had a rework in progress (before leaving Pengutronix, which I can
> >  totally understand you don't have time or want to keep carrying going
> >  forward, but is someone else from Pengutronix taking your place?)
> 
> I am actually carrying to improve the series. I just now got some time
> and started to build an setup where I can easily test further changes.

That is great news, thank you!

> Also my leftover patches are also tested and ready for updates on the
> list.

I'm afraid I've lost track of them, I could dig them out but am more
likely to fudge something up than not, so could you resend after
rebasing on top of https://github.com/martinetd/linux/commits/9p-test ?
(that should contain all of the pending patches I picked up so far,
including the two you just looked at; I'll add your Acks later™)

> > Thanks (and sorry Yizhou Zhao / Chengfeng Ye)
> 
> Thank you for caring and sorry for the long delay. Things are in
> steady motion, but will hopefully smooth out soon. ;)

No worry, I've been MIA a few months as well - I honestly didn't expect
you to continue (seriously) so this is awesome news :)

Cheers,
-- 
Dominique Martinet | Asmadeus
