Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF439AE6
	for <v9fs@lists.linux.dev>; Mon, 12 Feb 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740403; cv=none; b=f3OMLnDBTaE6EHekZIVKETVfHzCTzsIhknV1G0WQD4DpjIM4qRRCj8RDR4aL0+r3Dsr3PyUoMeZsP0G6zqw77Z7JEPVfKRTLm1mWEhsaG8qm3U6GDqrTIjFEB6RSmc0TnuhQkk9KpbzHCwtIOLdf/E0o2Flccmgjdu+KPkHtI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740403; c=relaxed/simple;
	bh=Pn5zogiyPRiHjXIT/y50rDh7mRTjVLMfDrtm3VkFkpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keBr+mKVooXBSB2fwiEwvk7JXt4MPTZ/2GifqndbyQMmMjNmL1Z5/IG1760W6eVHRxiyGWD8tn4SoJVAuadCr/dJ33+9yZnlQrLJxfy9Jwx5DDtNuCFZGtGKA0QqUPILuTXKnwdGGjVINUiXIaPiHPhYkr74VioItPI4uxYSWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=shfULbcj; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=shfULbcj; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="shfULbcj";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="shfULbcj"
Received: by nautica.notk.org (Postfix, from userid 108)
	id A807FC01D; Mon, 12 Feb 2024 13:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1707740054; bh=J9uKAK0vRpnU3LG0TXjxtthvlxNYsEtRU9Q3s7bTbsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shfULbcjjvJc+CGzQIdeNTsxa7oxRkdaseyz3xhkO62eYAIfrFlf9DLahaMpyEW8L
	 RhYMngabxuVP8bkLcrhQgPDZljuiyzZ874JqdntsjVd+yGzSoK7A2zCT367kWy8FIz
	 f9O9Pm+xN2+eEo6lJgNIYsCAbDqQ35POt1UWLo0IZ17inFPVT5bedo8L5zC7kgOvXk
	 QbJZmbYEtS7qN7GVuBzaE8oLzFJpEfsxMRdNn61rdjimAYueflX9EVNSbnTU67f/oA
	 APM5OD03bYqJ15PWwSenhSvd0myshJBUxm/p9OpsQhMJvIgVaXsUOplZmhp+uSQpf1
	 GSmFCgk2zY2/A==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 07381C009;
	Mon, 12 Feb 2024 13:14:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1707740054; bh=J9uKAK0vRpnU3LG0TXjxtthvlxNYsEtRU9Q3s7bTbsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shfULbcjjvJc+CGzQIdeNTsxa7oxRkdaseyz3xhkO62eYAIfrFlf9DLahaMpyEW8L
	 RhYMngabxuVP8bkLcrhQgPDZljuiyzZ874JqdntsjVd+yGzSoK7A2zCT367kWy8FIz
	 f9O9Pm+xN2+eEo6lJgNIYsCAbDqQ35POt1UWLo0IZ17inFPVT5bedo8L5zC7kgOvXk
	 QbJZmbYEtS7qN7GVuBzaE8oLzFJpEfsxMRdNn61rdjimAYueflX9EVNSbnTU67f/oA
	 APM5OD03bYqJ15PWwSenhSvd0myshJBUxm/p9OpsQhMJvIgVaXsUOplZmhp+uSQpf1
	 GSmFCgk2zY2/A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3ceb6d61;
	Mon, 12 Feb 2024 12:14:04 +0000 (UTC)
Date: Mon, 12 Feb 2024 21:13:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] 9p/trans_fd: remove Excess kernel-doc comment
Message-ID: <ZcoLfSBNtfgmeKaI@codewreck.org>
References: <20240212043341.4631-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240212043341.4631-1-rdunlap@infradead.org>

Randy Dunlap wrote on Sun, Feb 11, 2024 at 08:33:41PM -0800:
> Remove the "@req" kernel-doc description since there is not 'req'
> member in the struct p9_conn.
> 
> Fixes one kernel-doc warning:
> trans_fd.c:133: warning: Excess struct member 'req' description in 'p9_conn'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Sorry for the lack of reply, I intended to take the patch when the next
""real"" patch comes in but it doesn't look like we'll get much activity
this cycle so I've just queued it up to -next.

Thanks!

FWIW, I contemplated adding
Fixes: 6d35190f3953 ("9p: Rename req to rreq in trans_fd")
but that's basically been forever so I don't think anyone will care
about backports -- and I'm both surprised and ashamed I didn't see this
W=1 warning earlier, I thought I regularly build with that...

-- 
Dominique
