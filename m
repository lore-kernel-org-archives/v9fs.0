Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37913E0C75
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789343148; cv=none; b=thx/3O8zErq2mvHWnvaPTV0tY3KvNr5s0ig+3/3lck1H/gZJBz5BlBR4iW5xvKsR2ShTW/jqhYlvtzfVaoKl0YWEiEou0Xjh4cYkg5BDog03AO4tVxWKwK3QS4V/RZpQNWaZgaZvuimZc9wrOo3zL82C2T8pQFhzE4Ta65UZ/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789343148; c=relaxed/simple;
	bh=pIvyuvQzIUwAk7xF8c3nNL20NcXbjGHOFvR2oLZAO3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoEJs+EC5EtocwkTJ2gjUrbGNQrYA+e5gzpPKT1UV1PDtHDxCvj9RM5bEM8kaPcyDMCLNpBEefSSS9sf+Y4op0dxkvD2XLTK6lCyfsIv0uMvoJ7qoLgshgc+tKXmWH6mfSQe5oYEFX5GZs9XEkvmkcFoVgIzf/s8cPMHFgZ9IHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=C4htPd/w; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="C4htPd/w"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5BF3F14C2D6;
	Mon, 14 Sep 2026 01:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789343140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h44ylbH2rdPCaOucz8jQTCsVnOEZX7O3Bowqom7l/mo=;
	b=C4htPd/wOczkji4TjN/XiA8yqWBsqIMVvz3VEzddINH9T7+w00nDn/4Vt6BASQT/2OOmfQ
	8LURq+hfwdjTCEzDauHRQWmLgAxBSVVcLq2Uv9N4crn3+qAa6aGxB11MNfI/pueVIVW2po
	tqV2KulPVbVbs8YfoEuNceqA0WmxX0f92BGszwpHyBVi/6UrBotcXSUHnUOIC9TXr3NwQj
	8SM+uqNhse794MO8M5/Xx09tAiVfP8S/Uo6JqYIe+GtSgf7yn1xZstDagyVa7XTMq3SdJI
	A3YD9GqM27NfC6gLz+HOM/1Mw1/oXg91Sf3Bxfvxq3LCCSicszG1m/+ikMcmJQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b3313532;
	Sun, 13 Sep 2026 23:45:36 +0000 (UTC)
Date: Mon, 14 Sep 2026 08:45:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] 9p/xen: Use array for data rings
Message-ID: <aqc1kSDTP1_2HPjx@codewreck.org>
References: <20260913192740.29668-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913192740.29668-1-rosenp@gmail.com>

Rosen Penev wrote on Sun, Sep 13, 2026 at 12:27:40PM -0700:
> Store the fixed set of Xen 9p data rings in the frontend private
> allocation instead of allocating a separate rings array.
> 
> This keeps the data ring storage tied to the frontend lifetime and
> simplifies the allocation and cleanup paths.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: switch to normal array.

Thanks, looks good to me, picked up.

> -				for (j = 0; j < (1 << ring->intf->ring_order);
> -				     j++) {
> +			for (j = 0; j < (1 << ring->intf->ring_order);
> +			     j++) {

^ now fits in a single line within 80 chars so I've rewrapped it

-- 
Dominique
