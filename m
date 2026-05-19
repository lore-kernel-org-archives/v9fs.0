Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F515352026
	for <v9fs@lists.linux.dev>; Tue, 19 May 2026 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194162; cv=none; b=nnbyLridqnljmi/zns3q0r3TwokFrVfF3lJqyf7Hb5qolDTEfS7OnNjglXnjtzknjSMIs++1sXLpv+5DxkF36tJYXHqx4eu4Z7RrqsA4LWP0CfKwmu+OfRElh2n8dYkHezHt1WFYJfqhQ5C7KXcoKQSlt6AFvHxwDPehz5DGq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194162; c=relaxed/simple;
	bh=v2IJJKa65PGELO+zy+ENnwYxaK4FHBgJetKS55J4vis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7OmErcukuZiPkBJeFLOdiWPalBYlFDH8JbmXolg5xKWFG6YPXjCmGBhk/4PWQlFMjt8hjkUDcN9N4Go6KUYOBjB8fRRIQSUSbVl7E/lPyC0mdq6ZY4+KHK0v4gN4xbiyygwSgQaG2/nYf/dgIRLB4QVX2Ycs+DgXcpm4Ha+oU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=hTYfUCeH; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="hTYfUCeH"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9708414C2D6;
	Tue, 19 May 2026 14:35:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1779194155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JDmLr7pMdRJfXYzICEsaNOuMVwfLxAfSSJysngH1uU=;
	b=hTYfUCeHvISkDIOVYy3FQ/HQQWUiCdmqd4V85+jzpX4aelDii7BHEDnYC48CqdXlnO2sqq
	2NzkVPp8WT5OTG3XkClXz5v6MRGS1n5J11TvOc9njznmGQhhAH1LKPxMxIR33u0EgGUXd8
	VgCfIuRrcNzJMG/CIyGsGxPIgr5xwjKNS/0mLaJnLxV4Cyi+FEadpvc4gQXPf2c62Cn9i+
	MAkjrWBZXrQHWYwvtHDICnkH7EfHV9t3udZ+b2D4Ggn5D34kkT+qER8L8zZC7Di76pYgRs
	nLx/cMuxJJUzXE49SN+nYbmt508vKtANta8LJRL0RG/CTLN6EbkzTWn4cAGr1w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 74cd3d4c;
	Tue, 19 May 2026 12:35:51 +0000 (UTC)
Date: Tue, 19 May 2026 21:35:36 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal
 signal
Message-ID: <agxZGDFdOHnODKqO@codewreck.org>
References: <20260415155237.182891-1-kovalev@altlinux.org>
 <aeA-WpUyfWrYrvaE@codewreck.org>
 <e3e9146a-d820-d35d-cebd-e7e7e4a2fa24@basealt.ru>
 <aeFoRIOUNQZWmTG5@codewreck.org>
 <bd83eb25-3142-3d91-f605-4d6f01182d03@basealt.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd83eb25-3142-3d91-f605-4d6f01182d03@basealt.ru>

Vasiliy Kovalev wrote on Sun, Apr 19, 2026 at 11:22:11AM +0300:
> On 4/17/26 01:52, Dominique Martinet wrote>
> > So if I understand this right, with a sane server, the tag will be used
> > until umount or a reply (to either the flush or the original request)?
> 
> From what I tested — until a reply. Tested on latest master.

Thanks for all the tests and following up

I'm still a little scared of this but I can't fault what you've found,
I've picked this up for testing When I Find Time™ and will submit to
Linus hopefully for next cycle if you don't hear back from me

-- 
Dominique
