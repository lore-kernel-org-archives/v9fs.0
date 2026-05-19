Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332254DA537
	for <v9fs@lists.linux.dev>; Tue, 19 May 2026 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193302; cv=none; b=PfyGye9DyMHxS2E3dD3DDMlh9jFCzaeVUJXdcYA/PFNW8qWl5nCnM9YK0WYTT1iOGuUdeuPY1z+r+CvthCdQGmgVr7V1IVPE4FycPNK2cMOuRBM0BI7KmDFhE94TfTc5XCcB7yzYbaLX85SwBseFnyc64aLWuEYYAGOIbXyB57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193302; c=relaxed/simple;
	bh=zFh639qGz3CEz/3Gvm6szzdZ9VJbRCiu8Zjxvv3Nvho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUmEJzGSONJiFXQM65l0dVaT5dVJnAVKUaiwtobJ7UlFSXaMdg3uq8aXqkwIUxTgflpFJo6NbTA1o9IK9KRvZTuup1t7c1XIoqhNTSM2ReU1gP9uyylnD/DnzrotU6sWcJcQd19jOnXrlXovpYiOihz/3Ye/yQOK2IoIy43km+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=twIqwkEn; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="twIqwkEn"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 60AF214C2D6;
	Tue, 19 May 2026 14:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1779193297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=paOQL+N3fqGK+M295z44zR/gj6eiXSuES86oNJZmkNs=;
	b=twIqwkEnh2aP66ys9fq0BbMH/rrAUxkntjWLRUti+VSXeK44nW1S5zu4z/HgptIzQ4lwjj
	d/b7/uswXw8wJRYhnHlEBtDP/QcjupSOy4Ee3l10aZywj2talH/w+7qfBugBQYlL5+zii8
	azezgPryLyHUfsaybisQIYQ5cyrwGYI8rmU3eqKgOBV+G/sUaYJeumRhrWDjLm4bbKdrPp
	B6yNOvusDZ6+FxaVkRsYOuR5WFurG4qoBzYcLdsIq9cYI62Y2wRA4pIC5TtBIvO+1Wk7fe
	2mU/S/Np5lOh7k+m82TYpoW7aG6av7++EltuJda21BFRNI5xUxhlcAoCMM0gKw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e5384688;
	Tue, 19 May 2026 12:21:33 +0000 (UTC)
Date: Tue, 19 May 2026 21:21:18 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhongling0719@126.com
Subject: Re: [PATCH v1] 9p: Fix mkdir to return NULL on success
Message-ID: <agxVvu6on5BXqb2J@codewreck.org>
References: <20260511061830.38373-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511061830.38373-1-zenghongling@kylinos.cn>

Hongling Zeng wrote on Mon, May 11, 2026 at 02:18:30PM +0800:
> When mkdir succeeds, v9fs_vfs_mkdir_dotl() and v9fs_vfs_mkdir() return
> ERR_PTR(0) which is incorrect. They should return NULL instead for
> success and ERR_PTR() only with negative error codes for failure.
> 
> Return NULL instead of passing to ERR_PTR while err is zero
> Fixes smatch warnings:
>   fs/9p/vfs_inode_dotl.c:420 v9fs_vfs_mkdir_dotl() warn: passing zero to 'ERR_PTR'
>   fs/9p/vfs_inode.c:695 v9fs_vfs_mkdir() warn: passing zero to 'ERR_PTR'
> 
> This change does not alter the runtime behavior since ERR_PTR(0) and NULL
> are equivalent. However, it improves code readability and silences static
> analyzer warnings.
> 
> Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
> Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Thanks, I've picked this up with s/Fix/make/ in the commit subject, as I
(subjectively) don't consider this a fix given it's only a style change

-- 
Dominique
