Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305517CD
	for <v9fs@lists.linux.dev>; Mon,  8 Apr 2024 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712541693; cv=none; b=Mn+E6FPtaGTC+iDsN34lNys0S68bh3U13QbMHdALMuveZ5sTvGyPFBwdxLx4gJwqWXSAQhTRxH9JryfxuxuLG2fOL4MuW2IapzMfXmgkrZjTzhp5uGAN13VgR0qdTuw6ppRRCigalhBb968euAYWDeV3hFPr1d20t34rjOm+0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712541693; c=relaxed/simple;
	bh=FcJkamrfhIYpDM8Uv78oJ38VPypHZJRny909RF+iVp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8fO3rHYUMikOIIEMx+uryMCGr35fVwea2hKd6WWfU7PLaKWnwR1iXpJJsl+oTFPT5V1cFIBRHrTfmHfo7zCdaOoE3fT8aeni1Es6LtHhQISdCtbDi1MFiXj0jR0ugpoaachC2mona5ULzsTSyLBxXHa6NpbN85xIYibnJj2jCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ArjDQyae; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ArjDQyae; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ArjDQyae";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ArjDQyae"
Received: by nautica.notk.org (Postfix, from userid 108)
	id E8C8CC01A; Mon,  8 Apr 2024 04:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712541686; bh=cmDIwoH8ZQ+xb1GLzByQiZ9fXj98z2vLRL2WMrLzXu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArjDQyaeb3NZwjVF9dM4uBW1toUijDtihVQgf2gqLBQY2aaLm8jZKGqc9P3uSgu8L
	 Bx6CKHXa6JiJ2AnKG4dxj/3luLr8o3EX9Qo5Fx/SNuWdbZbMziXMHaFkzJ7jFowMnv
	 OiSH0eAahGdGGz4fgiUXEdJ3wShA7892FX4VoRFlzRzJlbUxkfgsIO99vJFZgqCg4J
	 IPpokq2LFnT/3WMupq97fqwaTwv+en2aiWTAL/fpIvFkahPk2bBDWbHAIQJqjs6Rrq
	 lzkbWF2DqwS/RHolK5IdSREoc6/4ZtS7R5mHRJ8AWnhi0WjyDnBmroWc4cDftPXGWv
	 d99ok/SO4ux7A==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id DED3DC009;
	Mon,  8 Apr 2024 04:01:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712541686; bh=cmDIwoH8ZQ+xb1GLzByQiZ9fXj98z2vLRL2WMrLzXu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArjDQyaeb3NZwjVF9dM4uBW1toUijDtihVQgf2gqLBQY2aaLm8jZKGqc9P3uSgu8L
	 Bx6CKHXa6JiJ2AnKG4dxj/3luLr8o3EX9Qo5Fx/SNuWdbZbMziXMHaFkzJ7jFowMnv
	 OiSH0eAahGdGGz4fgiUXEdJ3wShA7892FX4VoRFlzRzJlbUxkfgsIO99vJFZgqCg4J
	 IPpokq2LFnT/3WMupq97fqwaTwv+en2aiWTAL/fpIvFkahPk2bBDWbHAIQJqjs6Rrq
	 lzkbWF2DqwS/RHolK5IdSREoc6/4ZtS7R5mHRJ8AWnhi0WjyDnBmroWc4cDftPXGWv
	 d99ok/SO4ux7A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d1688979;
	Mon, 8 Apr 2024 02:01:20 +0000 (UTC)
Date: Mon, 8 Apr 2024 11:01:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: v9fs@lists.linux.dev
Subject: Re: ftruncate fails
Message-ID: <ZhNP4SISzZOGwy4A@codewreck.org>
References: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>

Itaru Kitayama wrote on Mon, Apr 08, 2024 at 10:44:51AM +0900:
> With a recent kernel I see below program fails (Bus error) if executed
> from 9p mounted directory, not with the local filesystem (Ext4).

I cannot reproduce on 6.8/6.9-rc2 with qemu and a couple of options.
Bus error would be some problem with the mmap of the executable given
this code? so probably doesn't have anything to do with the content of
the program itself...

A few questions:
- What exact kernel are you running? (or closest approximation)
- What server? (assuming qemu) what mount option? (tried default
cacheless and cache=loose)
- Does this reproduce right after boot/mounting the 9p filesystem?

Thanks
-- 
Dominique Martinet | Asmadeus
