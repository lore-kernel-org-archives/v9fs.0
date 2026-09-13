Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080CA38B7D2
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289098; cv=none; b=EMS7a+asBETE9RbRWWh9h/vCKLueBsW8SKaU+jlRMxweMWJrCVEYH9vnUetTT05yJhIPjJ35Y/kVqeGES/kcGE8EYZ1GuioODfEBI01w8Cw3StLOMsbPDx9AO3lYozFZ0M1Ti6cYYUjimbYtstTXQEnRgEvbFaDSgZIvQQ0EMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289098; c=relaxed/simple;
	bh=8m0PPlyNNCSEtp7TRfILqQQEhHq6E+jzOoqCB2lsZoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKi2QsLRciSWekyWa/FX7YPq5noutsdeqiVjHfMB+rcoR/VF6oSYnAJshrygoRLLea1VkPaZ8Eel0Uhv6hf/+n8dqlVfiC7Mkqn1JdwBke79AhOMOcP+PyMJ9NkPXUaA532j0ltjfS+6jwwtVhObAjTutrE+TjQQWfJiv0Szn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=JTRDLSLF; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="JTRDLSLF"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AA92F14C2D6;
	Sun, 13 Sep 2026 10:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789289095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DuX0dyVxOsJkrFTZmTmdfvbvbh0Mi2dz3PNH36mjDyk=;
	b=JTRDLSLFywKYdpWPG2scTup0cA5vWC7aGYr/VfZ7fslOwzKmM8FQDWgjZ/kTKr5GpzS9kx
	awSXmGJXQakSLxj48Z0XpPTPNYA5urh2oaLx5EyTi38bN8qHHVKqAImInG/gR5AWroxRJz
	1BaqVshBwsOTv1R0oPOYKoDYtfhog2BWN3qrUltXEvk1h+auDHdWmCBxUkJWTeW4yOnwxa
	4p0S/4i4bcR4KMYNqZS3YOvwgD4246fu/OPE9bsaKCv3r3apXFdDrA5hWtaaKV7SfyvkOE
	QtNAjvDR3qmm8HH6DntI5Gq2o/2qVU+xQvL6TphVWHX6duUYet4Xe3qny6w3Mw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 26127b29;
	Sun, 13 Sep 2026 08:44:49 +0000 (UTC)
Date: Sun, 13 Sep 2026 17:44:34 +0900
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
Message-ID: <aqZichSBFZgqFn8F@codewreck.org>
References: <20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn>

Hi Michael,

I'm honestly not quite sure what to do with this and others UAF usb9pfs
patches -- you acked the first one I replied to, and the tag match is
obviously correct so I picked these two, but I'd like your opinion on
the rest for two reasons:
 - There seem to be plenty of rough edges around usb9pfs, and frankly I
don't consider this a trust boundary (the usecase being developping
embedded devices, you trust the server fully, so whatever happens
in corner cases doesn't matter)
 - You had a rework in progress (before leaving Pengutronix, which I can
 totally understand you don't have time or want to keep carrying going
 forward, but is someone else from Pengutronix taking your place?)

For all I know this is also correct, but I'm not sure slapping a bandaid
is the way to go, so I'd really appreciate if you could have a look at
this[1] and "net/9p/usbg: clear stale request context after abort"[2]
[1] https://lore.kernel.org/r/20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn
[2] https://lore.kernel.org/r/20260802152148.810390-1-marsy12010123@gmail.com

If you tell me to pick them up I will, and if I don't hear back from you
I'll take another look hopefully before the 7.4 deadline, but I honestly
don't have enough time for this so the most likely outcome will be
/dev/null

Thanks (and sorry Yizhou Zhao / Chengfeng Ye)
-- 
Dominique
