Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933022A80D
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776307877; cv=none; b=VCvMlkHS42jl3onDMPVEFbQhVi5BdHNw1SicqdLSj6dg+H5ZG8HzY8PIQdXqoEQX7QG4xVG8B7NMfIJ27ANEORxr/csf7CpUdnWzZOJgJiLwhMrTjliJ7IQgonFP4HazT8sBmA7KUVtdLp/mQcXQ6xoIQEgRP7BnInSmxRmgGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776307877; c=relaxed/simple;
	bh=y+Ef5kH15T2AjREG9WQzH8MNHkHoe+kN7ICTGcQy+Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mg46TVpdvPx0PqdrU7D/hZg3ZsxbPEOmCiia7ZaAdNwDt0jEAxs/j/vvg1C0KvnjwQVWUtUFRtfQ/Pkkist6Z3YNDt8bNq9SPfJQj07Mhqnv5UxVa8zylPNzMnpLoYeUoqQHrIdmy1Qtvpoe4xUdmRswPKEwILsrlEpkg6mS1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=biPZPh4t; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="biPZPh4t"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7C81114C2D6;
	Thu, 16 Apr 2026 04:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776307873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=2NB+91A3mwaf9NC5STh1hest8k+EshMt+yzn+tknsVE=;
	b=biPZPh4t3/awuznRBtAzsjetfIirxn579q07N8v4qBW5MIeLFGsaQ/gOdj/SVxKwsT5Mmi
	D3ydCCUB3nx6RzB6iXK1U8oboqwsrStWJxjMMTUzWgxDGYJe3dekNFT4i0M8iY/uHnEOUm
	DQjo0xEPMLJ4PeVuIRGEp3XsmK/msMAlwmVwHkxJHEwJhj6TwA+hpYw0Si/WUguZUIYPeA
	xcNBzTh1plxoNkMrAr2AH5cA7r4cllioORzH8CvOeajTGku3/ZjNyEs5areJ8LfEsRY4Aq
	WwjeT51DvnvrMMBaDHfNfXdyPIB6n8Y7nheqo2vCp369YerfYmH1RMgJDq14HQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0d4300c3;
	Thu, 16 Apr 2026 02:51:09 +0000 (UTC)
Date: Thu, 16 Apr 2026 11:50:54 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Baran Arda <baran9arda@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/9p: remove unnecessary extern keywords from header
 files
Message-ID: <aeBOjl59tgjvGkU1@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260410202651.60818-1-baran9arda@gmail.com>

Dominique Martinet wrote on Thu, Apr 16, 2026 at 10:55:09AM +0900:
> Sure, why not, will send in next batch to Linus

Actually scratch that, many of these are not function
definitions but external variables, the extern

This also conflicts (trivially) with the negative dentry cache patch so
it's not worth the effort, I'm dropping it for now

-- 
Dominique Martinet | Asmadeus
