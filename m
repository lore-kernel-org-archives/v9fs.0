Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66614387F
	for <v9fs@lists.linux.dev>; Thu, 16 May 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861544; cv=none; b=Z2Xy2kzwHJ/0pesgHR3nPXwSErPXWTrg1+uEeSE4ymTyQWOPlVcb/3My9WZFLtNKj6/gaMWDuAImpek83tngj+1An3CgnZhv2vkcVeeFyR66WUMPfEVp3EtyY5Ami2mn0LZYAMtI41fy+DIkdHO3uHF0N9talgD1GjLScAIvcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861544; c=relaxed/simple;
	bh=yd3RiHUFy7zfTSgmQ1WSCtW6/oAp050pweWOMSsmDCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m08I5+rxglsBm+9hd8s6yUYzcr3mmEKuAEb3pw3EnjsfSbW+r9pqixciHek4oy9RxQ5Erhk9btQzJjhoUf6+OzQ0i8++b+uia3kS+BAQKL6eQIqeZy66ad0qJYmrwk+MhQPCciDYuc1YphwTvHzTRWbNq9a0Xi9fVLw6hdXJMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=1CCe0fuZ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="1CCe0fuZ"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9502114C2DC;
	Thu, 16 May 2024 14:12:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715861542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TvJHkSHUdH2P2Seqev+GV3ax8Kxkw+tvnlR4BM6vtCM=;
	b=1CCe0fuZ1RNbM4AJBlUYQh2HEp2ixarEasFI7WmeocH3v9Jdpt25TQVfosChai6pfU4gJ0
	MjTS2grc1VA3ZtPrWFGh9gAIvkEDoBrOt/huEjkcVaeMF0tFqOSmfXbpQWpBZYqY9Uo+OK
	/XLBb8oJEbj38vvmUoE0aZFtImjKxZg0+7aEP/qR6VXfamnqVLINCDy+aTTovh17DtH+Ao
	2mGyN45kAl3veiAcvBxC3XDULnCsF5vAxAEJCBGv6bxBYyEIvIQ7yHBLCf8Km33vlnmylm
	NVneM7MtViJh/0biHcybMMIRpQP5ZbhCtSbgCqf4yQRfdp0UsQgQYNjtVyBXdg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a3770269;
	Thu, 16 May 2024 12:12:15 +0000 (UTC)
Date: Thu, 16 May 2024 21:12:00 +0900
From: asmadeus@codewreck.org
To: lee bruce <xrivendell7@gmail.com>
Cc: syzbot+1527696d41a634cc1819@syzkaller.appspotmail.com,
	ericvh@kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	yue sun <samsun1006219@gmail.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in
 p9_client_destroy
Message-ID: <ZkX4EA3u1DEvROoH@codewreck.org>
References: <000000000000041f960618206d7e@google.com>
 <CABOYnLyFSHNg7Sq+vsJr=P-8ydMEf1M+KCFMvufPS6z09UiupA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABOYnLyFSHNg7Sq+vsJr=P-8ydMEf1M+KCFMvufPS6z09UiupA@mail.gmail.com>

Hi lee,

lee bruce wrote on Mon, May 13, 2024 at 04:59:50PM +0800:
> Hello, I found a reproducer for this bug.

Thanks for the reproducers; I don't have time to look at them short term
but I'm sure they'll be useful either when I find some time or for
someone else to help.

Just a note for future mails: it'd be great it could could set the
reply-to as well as the cc to your mails, so we'd get this mail in a
thread with the original report (easier to se which is what if someone
replies to either thread)

-- 
Dominique Martinet | Asmadeus
