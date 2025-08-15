Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6319066B
	for <v9fs@lists.linux.dev>; Fri, 15 Aug 2025 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231153; cv=none; b=Nv1NJiLEnihvhCEZbgGN7lxH0xzWdUp4r34LLg1Ag8TUtm5CtE7xX0UKvl5Zu39KsRw6S9IcK25AVDU/GCx5Y+ztTWierIVvTpt9J5+dPh5BT0KhM0lrI56eG6b/4Kc5uHWDuKXVxM49r32sw701lrHkb8b7oyZTZqT9fkGpa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231153; c=relaxed/simple;
	bh=6Su/4ICEFMXxE5YIF0eyd5d/RZWpfGNcsKNLkcohfCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3HJ9X0N4FwlG4mHagY9x9sWDNzJDkFI41GV3rrH159UKHgH+qz1yjDntQEaoiWEpw/hoGqcSNGVgvDAQTbbZfK06+OxZZ/kOZjQmWe4KFy5e97yyQCGp3tarcvnEKK+61InSm+tUdP1Y54nT9daHrw/wp5EZjAu1JDGtnqq+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=oBVThm7k; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="oBVThm7k"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 57AE814C2D3;
	Fri, 15 Aug 2025 06:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755231149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/O5W5IOKngfp28halyE5E9P1CzNRQ/QhoUFw+fRJYSc=;
	b=oBVThm7kmnIEamdSl/D/A9hWaQuwFsd5QvwLmwcZ5IdiPBVjJHN7Cfd97PUtQyd5HOfX4q
	kJgiThm8zW/Kmy0IbcsuweSNrmvmJ7/O4HsXCA9TaCC1HM3UM/gD9WEu88Nvo+QRIBRRad
	axAwiOIh0DQE+3sC5kymT5e8H6W9XvKDPbZYEDr6YF57lh4rn1xh+wjIPZVQfYPWOO1RB3
	zb8mYeZaDNPDgJ4Gp3dfYmrsiGHs9WMQ9Gx/7+GTKEtFRwSYUfW9quSp6zxjBNOTweoA8x
	s3F7c86ugdUV2y9RgaEvFR1dqGNfGvSUhdagHW6Zpu838R2T9fqw7E/v0JpYKg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 143bc026;
	Fri, 15 Aug 2025 04:12:25 +0000 (UTC)
Date: Fri, 15 Aug 2025 13:12:10 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Subject: Re: [PATCH 0/3] fs/9p: d_revalidate changes and using it for
 uncached mode
Message-ID: <aJ6zmlp0XHKW5f-a@codewreck.org>
References: <cover.1743956147.git.m@maowtm.org>
 <Z_13l9hPolrDrEnj@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z_13l9hPolrDrEnj@codewreck.org>

Dominique Martinet wrote on Tue, Apr 15, 2025 at 06:01:11AM +0900:
> Thanks for the patches; I think it makes sense overall. We've had
> problems with files modifiede on host while guest was looking at it
> semi-recently and I thought it was fixed but it either came back or I
> missed something...
> 
> Just a note so you don't wonder what's happening that I won't be able to
> give them a proper look for ~a month with real life getting in the way.
> 
> If someone else gives it a fair review I can probably pick up this
> thread up for 6.16 but otherwise it probably won't make it, the landlock
> part will probably come even later...

Sorry for the delay on this as well, I've just given a very quick test
and this looks fine so I'll grab this for -next

Since I didn't wake up in time for 5.17 it'll wait another cycle, but
it'll get here eventually.

-- 
Dominique Martinet | Asmadeus
