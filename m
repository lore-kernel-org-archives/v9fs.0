Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAA284880
	for <v9fs@lists.linux.dev>; Wed, 25 Feb 2026 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772028567; cv=none; b=siwQXhXxOtmHx5X885VvqdoaYOzhHwjySUL7VV9xrbXaKB706nqcHWSAKV1bWd4vz6m2KNOIzrc7XFjZWyb3lT5sW0NOzFbuioaQXYX4OSymtPZwZ0N5PsRRr2FLE5IbAojqUJyRqhFZvbAb9QEz1yFu0R6iMDkFUutT/VBgyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772028567; c=relaxed/simple;
	bh=L3wSEtQ46VYDko/mjBKNcnpTX/+QbBHfzFWYpMTC/YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdTB/SBgEkbY1Rq8jjxUFT/O8TzVSgYXTxROAF7Kf976mnPmjaBeyvszxJVBk7tE7hC5VZydKhFryOGes7Mg541zbNJLVKkTcWSOHQm67fySsRc+8Xs/OPZNtS4mjeZKYspxzzFmi1AA2llc3p85adCkmeRIlEuZnPLVtXYe3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=di+83ABv; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="di+83ABv"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8FAE214C2D6;
	Wed, 25 Feb 2026 15:09:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1772028557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c+o/hZLQn6dZpyidv0Y9UPdQXsC3soJ6wAX/WHerWP0=;
	b=di+83ABv315S24KlMXDt5kq8Pe8MDylBnr+Miv+G/pvA6raL5/mYc682iovxtmgBjZFna3
	tkMj4yt3YHzozIOpUSEi8FIEUnJZ3/GV6ft7HWQnZmS5Ukoh89CpGNrnAZ8OQrmHYO3/Go
	IS9kaKl08Dbu7HiVrr0cF5H+ltozcBSmMBA5FAWWCb7OUBX0Y4rnv+iyz8GrfeA46i3xDI
	FRCNqtIFvyGpaMhzj/OJtEblxAQNZra5Abcl9Zu3TvAGir3LMJDgCg33OjyFmB6t15iYQC
	sI3PE/lVZUFLkWyi4clEs7MNeyxgYr5i/igbZSr/edg2BtyJkG+5RV6w8NERIw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9cc9affc;
	Wed, 25 Feb 2026 14:09:13 +0000 (UTC)
Date: Wed, 25 Feb 2026 23:08:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Sasha Levin <sashal@kernel.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	sandeen@redhat.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: fix memory leak in v9fs_init_fs_context error path
Message-ID: <aZ8CeoJuTXYzdoTN@codewreck.org>
References: <20260225135745.351984-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225135745.351984-1-sashal@kernel.org>

Sasha Levin wrote on Wed, Feb 25, 2026 at 08:57:45AM -0500:
> Move the assignments of fc->ops and fc->fs_private to right after the
> kzalloc, before any fallible operations. Previously these were assigned
> at the end of the function, after the kstrdup calls for uname and aname.
> If either kstrdup failed, the error path would set fc->need_free but
> leave fc->ops NULL, so put_fs_context() would never call v9fs_free_fc()
> to free the allocated context and any already-duplicated strings.
> 
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Looks correct to me (and there doesn't seem to be any side effect of
settings ops in the error path)

Pushed to my -next branch, will submit eventually.

Thanks!
-- 
Dominique
