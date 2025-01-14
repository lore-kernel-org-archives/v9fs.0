Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8723244B
	for <v9fs@lists.linux.dev>; Tue, 14 Jan 2025 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890351; cv=none; b=bYj92Ox/YmI3FhdOJV3VBV4IhgCnPjU6O9p4dvrGomIoCstaiT+E0YLvcQE1joTcZl5zuTMIHhXe3qspg2WqZipf5LBpwTO5+mLJfc8O7laaNEzdIf7pWX8ZzK+pbnEC1iy7BfZ0qgubivdBggZUsUIWfy6NF2kOtLXGgiwgtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890351; c=relaxed/simple;
	bh=ADA5oCHs78OuwQ4RF+o+OI9i4WZ5jXrWM4/kZdxXlfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxZRNJMvEUSVKVOn/9PJL4u03m5GH+NyHrPbAgonr/NyxeHQuHM6WIv6kVJ78CFOrR5qt/E7ZzmZQD8JB6EjPZ7hSOO+y9x/vPZ0Un1cBKn8zgOkKD5uijM674rS7z894rnvDrGORIPlBTjdNoKjGXoSrt/0Fwzpb6rphd3sv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sBwEws3z; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sBwEws3z"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 971DA14C1E1;
	Tue, 14 Jan 2025 22:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1736889861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESDv8yFsH4FZV7GOvZw29gwBNFMFNwHKFsEMqUuriDg=;
	b=sBwEws3ztYoBlAD+7MkmVO9GRHT/13K72ywxEuqCkSUgXb1lAXCe72xEPET49hII1Hi0YU
	S6pgRZg2iDW5Rp2EXb7NNacn5CyQqSkNk90p3y84WSVyA6WC9bD/hkxI8wB7d33pHTC/G5
	73rGFTo9rBpfhIUmDboKwp6dLZbefLP22Sb4mueUre3sxRsX5FlYoyVzOoE2DNj9BVNOu9
	Ubjpe8GaF+sFWqBLfgwrYyuF3/nQOyHtza6dNdjN6DV3TtkgUFY+9jYkxfqNFT1umxB+V1
	dN2cRsM6smFuDeoPIBkre2g9vx/oXkpr14UQMS1WVnE0AgRmxSI/l7+BYYBUBA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 875711ae;
	Tue, 14 Jan 2025 21:24:18 +0000 (UTC)
Date: Wed, 15 Jan 2025 06:24:03 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Joshua Murphy <joshuamurphy@posteo.net>
Cc: v9fs@lists.linux.dev
Subject: Re: -otrans=tcp with IPv6 address?
Message-ID: <Z4bV8_e_gZUgG7Et@codewreck.org>
References: <87ikqhcdpr.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikqhcdpr.fsf@posteo.net>

Joshua Murphy wrote on Tue, Jan 14, 2025 at 09:01:04PM +0000:
> It seems like it isn’t currently possible to mount using an IPv6 address
> and -otrans=tcp.

Right, the current workaround is to open a socket before calling mount
and pass that socket with trans=fd

> I think the issue is in p9_fd_create_tcp in net/9p/trans_fd.c as it only
> validates IPv4 addresses and returns EINVAL otherwise.

I haven't had time to do anything about this for ages, but patches are
welcome!

-- 
Dominique Martinet | Asmadeus
