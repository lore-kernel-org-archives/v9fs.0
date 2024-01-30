Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673385C7C;
	Tue, 30 Jan 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629283; cv=none; b=YPo9zJysW594WPEmsxaMTZQKvJuZx1pSLU6sXo+uWi/bZ64LXa30yDUq47rTFNxK9xVP/fVbit6ILClGbmeLiQs/jxOpXWjlYzoppxKozjj2dZQ/2yrm/rRk7SG71j6x+gGE2qB72uzExX1FhNksQb93gc/Y1zin7fPreqP10Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629283; c=relaxed/simple;
	bh=XU07isL4zhZtqjo/8G3C8vuYx/blxRLGG0HC5gR6DKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skZzyQLl3yz5QlRq9ieW8YqGW1kdHUdS64Zt2n1vyNnAV1K9esOG78MrttPUEmdm/KeJkeTVydXv8CMzkRy9Jv1JIuG71l2eGU2mmpLc+Fcg2Mp/6LNg8O2PTSHVo456FPc7eA5SymMKFlrSdrbEKanAP6K/zQKnoRQYIfCC4vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rUqEa-0005ju-S1; Tue, 30 Jan 2024 16:41:12 +0100
Message-ID: <3f08ca1f-77ac-4636-86d4-52b79d721fae@leemhuis.info>
Date: Tue, 30 Jan 2024 16:41:12 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs/9p: regression in 6.8-rc1
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: v9fs@lists.linux.dev
References: <ZbQUU6QKmIftKsmo@FV7GG9FTHL>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZbQUU6QKmIftKsmo@FV7GG9FTHL>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706629281;d79ede32;
X-HE-SMSGID: 1rUqEa-0005ju-S1

On 26.01.24 21:21, Eric Van Hensbergen wrote:
> I caught a problem in the new netfs code when running in 9p when running
> with nocache mode.  A regression sweep is turning up a:
>  [ 1084.438387] netfs: Zero-sized write [R=1b6da]
> when running my ldconfig test (included at the end of this)
> it reports:
> /sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
> 
> I will try to dig into this later today if I have time, but not sure I'll get
> to it so I wanted to make other folks aware.  I'm not sure how much other
> elements of my test harness are contributing to reproducing the problem.

To be sure the issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced v6.7..v6.8-rc1
#regzbot title fs/9p: "netfs: Zero-sized write" failures during ldconfig
test
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
