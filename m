Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589E21BD9C8
	for <v9fs@lists.linux.dev>; Mon, 14 Apr 2025 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665004; cv=none; b=GdaMOKls/pG9QFu/8dCSL5glTDXLvnsfpTZjohSXK0MBvduXfmI0jtm+vPB1RMDqx0HiVOfiTn8rfIKYifheOxYoXMmaMYLQ5BJhiF4htovd1S98I+seO2yupsOE9YCEjBXJqvGVoHxhjpbuCSUJR1Jub581WECD+lQ2Ld0FzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665004; c=relaxed/simple;
	bh=2UPO3yHI7yqwqn+4C1KTEtSMtGW6rSFJ2UYLJOY0p0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuG7iMR2FD2e+Jj/CRZG0zUlNUkAsqJWKm9QbnQx8jvLjXZPuTCWsHzRYdxCErhODiZT02WKDP9O9qQ5lNfqhVruQ3cIgh9MytudoJD0plZPY/Vi759AbF5AHXjNbjMOcGJ9g6A6T+j7AftQHDgtwHyUiIzZHIaC5VWJNWU0wAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jJeWdD6p; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jJeWdD6p"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2488C14C2D3;
	Mon, 14 Apr 2025 23:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1744664490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaZI5Eed2dE/mW769+1TQewrzljsqbdj/kq7EaXDvdE=;
	b=jJeWdD6pvfKbwkjXPTb4Lkqc454CJLxd6cpr/psrcmgLI8hBb2ZL7W2iHIrKvpNIjzlwb3
	mj+j4mpEJJIN0QbiWo9B3D0mMooLNccfcF7TAg02lrOhWxIQ+tmxH8roAmcvepDC5/waxm
	iu2W5htGch6BKQFpW+/f79IjHU6K02ynHcuElz7Lgj+R0Oa70hr3ifSPNrEeTkcnHCc/aL
	CMGL6JJDuPRrN1l8wMCjTNRnzicTDEZwjQZQfk9BedwpW1dBheRq8uRsjFyouopZsLvZUE
	rRp3glBkIhDTW7WOALCvoaT313Hu9FIaFzj47re2efIb85CKQd6XMbzouWHBFg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5484be5c;
	Mon, 14 Apr 2025 21:01:26 +0000 (UTC)
Date: Tue, 15 Apr 2025 06:01:11 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Subject: Re: [PATCH 0/3] fs/9p: d_revalidate changes and using it for
 uncached mode
Message-ID: <Z_13l9hPolrDrEnj@codewreck.org>
References: <cover.1743956147.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1743956147.git.m@maowtm.org>

Hi,

Thanks for the patches; I think it makes sense overall. We've had
problems with files modifiede on host while guest was looking at it
semi-recently and I thought it was fixed but it either came back or I
missed something...

Just a note so you don't wonder what's happening that I won't be able to
give them a proper look for ~a month with real life getting in the way.

If someone else gives it a fair review I can probably pick up this
thread up for 6.16 but otherwise it probably won't make it, the landlock
part will probably come even later...

Sorry for the delay,
-- 
Dominique
