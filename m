Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993D442FAB;
	Tue, 15 Sep 2026 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455268; cv=none; b=bEOWEA08bLgOUPn5VN325o8Txtv5jRTlfyI4Z62LIBadiOHplCh5OO02LPlsOE1axuZmACHf398aYbrqumlWRixAT8RGgMrjHIPzhENuZG861K1ekLL44WpvpJL80CVe/U/ScaddkdOmwErVOAaUoQCFnvQT06kclWvfJWy8BxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455268; c=relaxed/simple;
	bh=LZcF7NCuxlWh9+Ig9a9EKaty9P7HgGZefW9VxC15zf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uih0IZ5GSAF0hIRReiGaN6GIRh9eyqe1MbddUZ4XVWh453I2tsCf156kjFF25oHyaQlfU/RwJqGRSCNWtkbT0p8GbkPoMVtzhsUmSHF1/5fssVDBDJlg3rIYG9H141QuyLaIhbeXHWV5A4UIkj8LKKKqVAsBce03qHv/Vv9C8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSXjOvT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSXjOvT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C51D1F00899;
	Tue, 15 Sep 2026 06:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789455267;
	bh=KvbLiQQNH6ksHrcZe2JqliEMxc4J/fYcWtrJF+/fk4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RSXjOvT7x2J6axAolM4ymdpP5bCsUYjtmp/oelbjYGVzdXmNvBaHEz0eGolZex/Pb
	 Q8gwZfzOhw/vvzX5yDO52X8dV2Cuuzakevv4gQXmj/Vxddd/rRQ2shLKkvaLy35x3h
	 T3FATL5oeLohyP3h6D4Y9qCY8Qai1RKPN1X6u0+gTuLitg3A2N3ISsXgoGVQfoVIB3
	 E9BMTRhRlFl0QRZqkqnJTgliUpAbGz68XGKCME5ei2Udw7ZVlvmG2nbbzTonzMD+uW
	 1pPq/oN30EjCTHxUV0jr/XIG3v82fIN0A5H12mrAXL4hTc9jTcsGBvu19bs/EL2AK1
	 spg6Xuh4iLg2g==
Date: Tue, 15 Sep 2026 08:54:22 +0200
From: Michael Grzeschik <mgr@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Subject: Re: [PATCH] net/9p/usbg: Fix use-after-free on usb9pfs_clear_tx
Message-ID: <aqjflEL_79A95MGc@line.checkpat.ch>
References: <20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn>
 <aqZichSBFZgqFn8F@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqZichSBFZgqFn8F@codewreck.org>

Hi Dominique

On Sun, Sep 13, 2026 at 05:44:34PM +0900, Dominique Martinet wrote:
> I'm honestly not quite sure what to do with this and others UAF usb9pfs
> patches -- you acked the first one I replied to, and the tag match is
> obviously correct so I picked these two, but I'd like your opinion on
> the rest for two reasons:
>  - There seem to be plenty of rough edges around usb9pfs, and frankly I
> don't consider this a trust boundary (the usecase being developping
> embedded devices, you trust the server fully, so whatever happens
> in corner cases doesn't matter)

I agree that the edges are there and need to be fixed.

>  - You had a rework in progress (before leaving Pengutronix, which I can
>  totally understand you don't have time or want to keep carrying going
>  forward, but is someone else from Pengutronix taking your place?)

I am actually carrying to improve the series. I just now got some time
and started to build an setup where I can easily test further changes.

Also my leftover patches are also tested and ready for updates on the
list.

> For all I know this is also correct, but I'm not sure slapping a bandaid
> is the way to go, so I'd really appreciate if you could have a look at
> this[1] and "net/9p/usbg: clear stale request context after abort"[2]
> [1] https://lore.kernel.org/r/20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn
> [2] https://lore.kernel.org/r/20260802152148.810390-1-marsy12010123@gmail.com
> 
> If you tell me to pick them up I will, and if I don't hear back from you
> I'll take another look hopefully before the 7.4 deadline, but I honestly
> don't have enough time for this so the most likely outcome will be
> /dev/null

I just acked the two and rebased my further work on them.

> Thanks (and sorry Yizhou Zhao / Chengfeng Ye)

Thank you for caring and sorry for the long delay. Things are in
steady motion, but will hopefully smooth out soon. ;)

> -- 
> Dominique
