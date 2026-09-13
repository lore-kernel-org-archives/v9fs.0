Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEEF35F16C
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316132; cv=none; b=f1zrlPktJ7o1kp7fnDk0He5JHqnkvuLeW3VjbV6dfqxBELqYsF6S/J6d7R2sUuQhOcm6zhX/QuyzAxLURhzyBEVkRxQZ5ZCfWNTcSQslhBu0QPDtEQnLDgJCFKD3szOLx0SVmh2i2PssNKAG1ZlCH375pwTaT25S13fHb/5ObDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316132; c=relaxed/simple;
	bh=3KFYohht0JQwZND8fzTLLtwwjHHVcAiSCne43zkFVZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga50LYGw6NfvkrHeJEb9MKp/Cuaa6rFCY/axGMwtmUW2CoS1RHDprtyVHlagIk7ZGvkTZTl+tFvU2Y2m4H0pFL1SLwgJOyckAmoP4KVKxeEl7XjhvJ3Yk+X8yPhkHgQZNwXFlC5qE+2eH3knaTsNeE+pzQQqatyOGBYRgO3jnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sNwKMBXt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sNwKMBXt"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CE09214C2D6;
	Sun, 13 Sep 2026 18:15:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789316123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UCD3YyhdFHmDduZ40c/fILTYv44HdWYg6GwS/dIe/bY=;
	b=sNwKMBXtZ2/PecdpgYRyPZowXNV+aaIKuM1RNiOwrG35ep0MX6Ndn4LP4pXra629FcgzMv
	GHXlnHz159kf3lIv87GSSdxDY5g/BuY88rS5T8BvV1mVW87Mf8wbtX/WLOlEjEQnjy1aKZ
	25DbZYBa3toAak6TFBdiwdavHWCCfkRyjtvYbdCTdhovW+j38OoHjJALDLGMOcZir9Jwqm
	2yg6aCaO/bagPNbnb0U957E1kD1wHNrSJ+omO18wGA/0y3sOqTYMlrj0RO4o1cgSZQztNH
	hkbS34yeuv9mHFRl0cTX/tOFSDtvaQPfiZJwHL3m9NtibgTA0ef9VjN066FAQQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 27475403;
	Sun, 13 Sep 2026 16:15:20 +0000 (UTC)
Date: Mon, 14 Sep 2026 01:15:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Rahul Priolkar <rahul.priolkar@asu.edu>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 9p: fd: p9_conn_cancel publishes status before t_err
Message-ID: <aqbMCR3_s2m_A9we@codewreck.org>
References: <20260911092132.3328659-1-rahul.priolkar@asu.edu>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911092132.3328659-1-rahul.priolkar@asu.edu>


(I didn't read 90% of that mail)

Rahul Priolkar wrote on Fri, Sep 11, 2026 at 02:21:32AM -0700:
> Conflicting accesses
> --------------------
> 
> The conflicting read is in p9_client_rpc() at net/9p/client.c:612:
> 
>     if (READ_ONCE(req->status) == REQ_STATUS_ERROR) {
>             ...
>             err = req->t_err;          /* racing read */
>     }
> 
> The conflicting write is in p9_conn_cancel() at net/9p/trans_fd.c:182.
> In the same function, req->status is published at line 169 or 173 before
> the lock is released at line 176 (abridged):
> 
>     spin_lock(&m->req_lock);
>     ...
>     WRITE_ONCE(req->status, REQ_STATUS_ERROR);
>     ...
>     spin_unlock(&m->req_lock);
> 
>     ...
>     if (!req->t_err)
>             req->t_err = err;          /* racing write */

That looks like a bug, if someone cares we could set all the errs first,
wmb, then set status to error before dropping the lock; at this point
I'm starting to wonder if we could just run the cb under lock but either
way I've given up on fighting with connection teardown bugs.

Please send a patch if you have time to check what you're doing
-- 
Dominique
