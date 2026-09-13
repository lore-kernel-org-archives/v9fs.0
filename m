Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E48038C40C
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789287327; cv=none; b=EiBeCeedaEv7rgCic845mKnAj3uJf1zgbpsRJB2AF50lyFYPjZdpIZRR/kFU+gfLxe5hz6YdlspI43x8XsRgnygvfLiDkRkhCNfSjXx8wqt3+vbXSW3L9YGxw/mETYVB9gdVvNYULUP1D1pnWpRSJl6l8x8idSAaFd1ePAUlEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789287327; c=relaxed/simple;
	bh=ZwX/sKgD4G0VcC4XB1mDDk2M+5z62rV/m7lm8c/UpSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQHy896vUF6J9FsWMigXsgr9o9QgrDehYg7JzkV7ITQ/K3HNI/r3YYCqVQRj65JGmc40iG1cIJFEd8vXRgu8rnhwE6MKtInyZG+WoB1/FZdHYvIY6OmNkDKhNYyT9hirxaJHQqCTTIpPA2yA6FHdoy7kLeBMufXwAAde6iSf7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=zdd5PH1A; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="zdd5PH1A"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 240A314C2D6;
	Sun, 13 Sep 2026 10:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789287322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dNwiMx4hsnzXWsqlz16b37QsaalOt2bbFOd/Ze1iAQM=;
	b=zdd5PH1AHt8amEEtXEnufc2EzB3aaiKzE3TOs+egOvIkK6oiPMmhXU3HEjvXgmePQkmjGz
	3cuhbgB6Rz4aMdjCsE4FhUqgBzwb2lvBVmuP7LHQyGQ8F8l+Nj19zbCXFMUKev80naGU8L
	9veVYLD0Slj42savNP9y5L5CcpvrJlpeurmm7LgTQzsxUJIVeVvfpIzQokigeETQJ5Uvcy
	bZlEx8vk12JkgfU7S090JYNCglJ5aecl6seHO4il0hGsE7WAXDrvmAurLswA4eXYo3le7X
	ikRbHDDZ5Hfx7o2eVQbU05FyrCBnYL4ZKjxxaN/ggZ90YPIq7IURSANOdudZ1Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2ec5db01;
	Sun, 13 Sep 2026 08:15:17 +0000 (UTC)
Date: Sun, 13 Sep 2026 17:15:02 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] net: fix typos in comments
Message-ID: <aqZbhtKEsHe2KY1c@codewreck.org>
References: <20260904112100.34541-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904112100.34541-1-hemanth.selam@gmail.com>

Hemanth Selam wrote on Fri, Sep 04, 2026 at 04:50:59PM +0530:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Thanks, picked up for 7.4

-- 
Dominique Martinet | Asmadeus
