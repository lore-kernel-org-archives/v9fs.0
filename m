Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C013145B00
	for <v9fs@lists.linux.dev>; Thu, 16 May 2024 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861195; cv=none; b=JSQe4V5qwtiABP2DUZrFCWWaSmQGPTgVKyyNeWg6HaL4ox79E1bczV4czOLHf7vfKnSUYSY+SsCyDk2szb3QZKGl7O++hnKMkkN7ltDbZog6IFtiyHCnHZomsbLg2oHELZAsVbTEj6Stx+J+zmpExEX/os0HH7HlQScGuOSdSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861195; c=relaxed/simple;
	bh=4NjjwSr4Ahv0C5KPcCIAl9LPHi84Ps/jY77lOeIowL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icNSDpjAI0I6YDVnJcdNlI4i5tZMyLmNCnMEes/goBLbt//S0rmi8yp9ygyY6kaDxd1me2gBo/cX0p6kodSA1qwV8xFrRovTTa1V9VO+eANTbC+03o+xZj3fzrh4fLStYq6KpLmIFE63DUqsbCeFfpq5pbIxZ1KGDElD7thXp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=SmX3PKSl; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="SmX3PKSl"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8F5C514C2DC;
	Thu, 16 May 2024 14:06:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715861186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibK20Oi6M32rpg7TSWRqlsDzrOFnl8LL6s8Vh9NS0vk=;
	b=SmX3PKSl+Z11NjrYS3W5QFj8msIUV1tXW2MkYAlJ+Eg6quIn71l11Vy25IiI/dxpQuokII
	WlM+coLUHPrQbp6mIANJmbEuwPsv0/wkKfpMKqKlyOZEhq0zl1u8uPrkRASNPMFlNBqwoR
	FIiGCEs+bA39ZsBRv9CMRkDUe4GRHGTyODQ8cUul/jhNOzTyXLOnC+juYfaO5e8vZe1B+k
	iKed2t1Si/oWJZrIs/i/f0uQBESSSq3q+PcyUWTCVI58eDGSz00r9uYGuwDDTai1/a28Ul
	q6T/yixfxYpVthUC0y0C6oyQmMkZpyeAh9w1sE3PgtMp3BLZtjXYlGu5YkowlA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3a491bde;
	Thu, 16 May 2024 12:06:19 +0000 (UTC)
Date: Thu, 16 May 2024 21:06:04 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net/9p: fix uninit-value in p9_client_rpc()
Message-ID: <ZkX2rG5D2dnit9dB@codewreck.org>
References: <20240408141039.30428-1-n.zhandarovich@fintech.ru>
 <ac84eefc-e024-40fb-a92d-3109f686d122@fintech.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac84eefc-e024-40fb-a92d-3109f686d122@fintech.ru>

Nikita Zhandarovich wrote on Wed, May 15, 2024 at 08:18:19AM -0700:
> Gentle ping on this issue as it is still open. Thanks in advance :)

Thanks for the ping and sorry for the inactivity -- your patch came in
the middle of a rough patch (ha, ha..) with a couple of regressions that
drained me and we didn't get any other outside patch this cycle, so I
didn't prepare a pull request for Linus.

(In theory, it should have made it in one of Eric's pull for 6.9-rc5/6,
but I guess it slipped through his mailer as well)

I'll queue the patch to -next now and send it next week if nothing else
pops up.
-- 
Dominique Martinet | Asmadeus
