Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5435AC03
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019878; cv=none; b=CBxF4znCl+BE6NIiKIH5Ci0xs10uAq/cCpuv9fTzGhR16zzv8Z/uRdbIcZDhSrC4bR4eOOidDIpYluYCavC8u8Dk5/WUlb5u30j81dTCW6xeyDztBwiggdpIO3UtY0r4Oj5zI/5/MF2wdJi067c1++T6b34UNt9HDZcdoOhUba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019878; c=relaxed/simple;
	bh=Bt22vBcD4ShsZyrhdaVOvgDgama59NpCJTOTxGGPdGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvQ3XPzNb3XGxPU2vk2Peh+uJ5HLICBmAzQvPpWRwFe7/eOi5NuwI8AJ3r7iZr8fsvVHmgT2BVO6++Ng5YnVuZUJn2Lc0EA0x9spHiYEFreXyWYQd6U50oonxtP0+HQLmuyubRxu2euHhpeUKyu5oD69nIVeI6QwcE8vVLFyXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=P0Y2FnM7; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="P0Y2FnM7"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6CC2C14C2D6;
	Fri, 29 May 2026 03:49:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1780019395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OgXq+wegT4B9o1JAUAKWO9qEvT34X0SawOFUrZXXQM=;
	b=P0Y2FnM7qspRylU0duSx0DTDZQPuP08qHEuTs5Y4ZpyuW9R4C/seFTQBYFgkimG36cGQfe
	QNVpMB96oC//D+Jp28KFgCFSlQ9xkUFX6ByJdIhWWe62EiuLnREPMQfvmLBkjqABsXyGin
	/F1SHEWVH2IW3jCfKsEtqSMwrlORi8OnzBGhozXGFVjj5W042S/+rsgHDKbICgW5XU7dkO
	Q8nnEljbvg5J4/Kw2dQJeZzbYcwDM6eOQGxN9ZMo8KGrmuuL+THGKUmWjcRH4h2/u8JtFv
	ENprxWepdUSW6tbLuMWz866kANcIUG/5EPwXnJ5KXBSQhLAb96MNGyyxKoXwbw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c7b30409;
	Fri, 29 May 2026 01:49:52 +0000 (UTC)
Date: Fri, 29 May 2026 10:49:37 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: =?utf-8?B?S2jDoW5oIFRy4bqnbiBOZ+G7jWM=?= <khanhtranngoccva@gmail.com>,
	linux-fsdevel@vger.kernel.org
Cc: "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Subject: Re: [BUG] 9p filesystem does not honor turning off O_APPEND if a
 file handle is opened with O_APPEND
Message-ID: <ahjwsYmrhwFW3mkX@codewreck.org>
References: <SE1P216MB12443CDB57EA1BD32A45FAEFFB092@SE1P216MB1244.KORP216.PROD.OUTLOOK.COM>
 <SE1P216MB1244C510206B0E41478E1843FB092@SE1P216MB1244.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SE1P216MB1244C510206B0E41478E1843FB092@SE1P216MB1244.KORP216.PROD.OUTLOOK.COM>

+linux-fsdevel@ in to

Khánh Trần Ngọc wrote on Thu, May 28, 2026 at 06:55:45AM +0000:
> I recently found a bug while interacting with 9p filesystems on
> WSL. If a handle is opened with O_APPEND, then this flag can no longer
> be removed using F_SETFL despite 9pfs misreporting that the flag was
> removed successfully. The underlying filesystem continues to append to
> the end while the O_APPEND flag is gone when F_GETFL is called, and
> the seek cursor continues to progress as if removing O_APPEND actually
> worked.
> 
> If removing O_APPEND is not meant to be supported, F_SETFL should have
> returned an error (EPERM seems to be the most suitable as that handle
> may only append data).

Thanks for the report, it's definitely a bug, but I'm not quite sure how
to deal with it...
As I see it (setfl() in fs/fcntl.c), we have two choices: flag every
inodes as S_APPEND so the IS_APPEND() check fails, but I'm afraid that
will have other side effects somewhere; or we need to update the
check_flags() file operation to pass the filp (or at least
filp->f_flags) so we can decide if the O_APPEND flag changed...

Thanksfully only nfs seems to be using check_flags(), so I think that
way is likely to be the easiest, but it's likely to take a bit of time.

If someone closer to the vfs has an opinon that'd be welcome.


(leaving the rest of the original mail below for anyone not on v9fs@)
> 
> Tested environment:
> WSL version: 2.6.3.0
> Kernel version: 6.6.87.2-1
> WSLg version: 1.0.71
> MSRDC version: 1.2.6353
> Direct3D version: 1.611.1-81528511
> DXCore version: 10.0.26100.1-240331-1435.ge-release
> Windows version: 10.0.26200.8457
> 
> Original issue: https://github.com/microsoft/WSL/issues/40649

Thanks,
-- 
Dominique Martinet | Asmadeus
