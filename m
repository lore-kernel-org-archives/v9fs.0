Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9A253B58
	for <v9fs@lists.linux.dev>; Mon, 22 Jun 2026 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782092593; cv=none; b=Re7BPO0pX1bL3hKz72YWr1LfWgK1R1zIHHacEUuTBYcvjvG7By1m63cSMWWSODQFrEV+eSkViw3/hzyQ1ykcWzE7KAzIxnvnPI2rfsxz4jpNbAVCvoZMEqeqNqMzuDN2MWbtf4mIs/KwhebVG1orh1nUUuIR3AorfQbTzW4L4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782092593; c=relaxed/simple;
	bh=kDa1A0tf25erq7MXC7hQHhDO5Wlte8+wAI23nUv1oDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVy95FFan6Z0/6JCox9vnbGv7O26l5TAKY8awdRZirchYe/r54scO/JTAY4xBO52zUntlzP/c85Euo9q0lxu7h8pB4yVm2nJsbC0UfBd4q6N0eiUmnxRpI0gXETCvLa5w+o/pBbUC25Aj+WAXIpiEs7YoPPzKVLsqdZfXjxMouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=nvIglVa3; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="nvIglVa3"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id DED3A14C2D6;
	Mon, 22 Jun 2026 03:42:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1782092578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3vV16bual9kqH9On7dH9InKxJ9YZVRVJL9ULkdmmiE=;
	b=nvIglVa3O1O6zp9c/b6OtX6OHPkXJrAu6gTX7swqU8AhX/LfZUWz+JxbnmVaY0qFM6dMFl
	R5M2YiUYz2T89ph5Y/cAGh8vjuurke18ut0vUR0d4LZfNJCeh0fbjY2MGhtg8Kjn0QRoVm
	VEbbpha8XT0v6ygIU73rUBxBO0XcKbdIga7FfODb82T74UXRuDQmZ1LUayVRjwawnuinjR
	wR91Iyljie09YcHHKwAQsBU7El2v6IpqpSLaBSDGy+DMeBj704oMvkHEdWYmDuJDUMSCwE
	WMYV7ebYlJs25LRLPUkUNqa8DG1T1clgYDrTXI+TsAerkr+wv8TXvgmAarTy8g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 80be5a3b;
	Mon, 22 Jun 2026 01:42:55 +0000 (UTC)
Date: Mon, 22 Jun 2026 10:42:40 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal
 signal
Message-ID: <ajiTEOQfjcVvnG-t@codewreck.org>
References: <20260415155237.182891-1-kovalev@altlinux.org>
 <aeA-WpUyfWrYrvaE@codewreck.org>
 <e3e9146a-d820-d35d-cebd-e7e7e4a2fa24@basealt.ru>
 <aeFoRIOUNQZWmTG5@codewreck.org>
 <ajfgZs23wKUUG6IW@codewreck.org>
 <efc4fa29-eae1-0b49-1550-b5dd3b7e28b7@basealt.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efc4fa29-eae1-0b49-1550-b5dd3b7e28b7@basealt.ru>

Vasiliy Kovalev wrote on Mon, Jun 22, 2026 at 01:06:21AM +0300:
> The deterministic path is the syzkaller C reproducer:
> https://syzkaller.appspot.com/x/repro.c?x=156aa534580000
>
> [...]
>
> dmesg fires on every iteration:

Thanks for the quick reply, I've confirmed this repro "works", as in gets
out of the loop as expected.

> On a real server I couldn't reproduce this by hand. The reproducer
> hits the branch deterministically (logs above); why hand-issued
> SIGKILLs don't get there is a kernel signal-delivery question
> outside the path this patch touches, and I didn't dig into it.

Right, from my added logs, when doing it "by hand", I don't think the
thread goes out of the wait_event_killable() the second time around.

I agree it's slightly out of scope, but any behaviour we don't
understand is something that could be subject to change, so I'll try to
dig a bit further as time allows.

> Feel free to revert if anything turns up in the next weeks.

Thanks, for now Linus took the patch, I'll let you know if there is any
change.
-- 
Dominique Martinet | Asmadeus
