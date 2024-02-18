Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE6EAFC;
	Sun, 18 Feb 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708251066; cv=none; b=uwOK8AFiuQWGpXR5pUccMVPWq2xt67nm4D7ljuTPDzKV5rYxgdeARloWclVl9UYxHL5kbu946BmmoVgmF2qe3wdHnUdMoLoSUcr40soan/hvEEvvb0TTdARslY/zYRTzZn3fpSp3NBop1Y3YnHlxNBtSTAcyOk3krpazBWw8Dz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708251066; c=relaxed/simple;
	bh=LH2pk2O9a946uQ/BFniQjv+L4XqDHsLzIzh+V9bf2W0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kImB1BcxCHE9GD3sc+cnpkGlJcASb/P0Zg8zXJTuKSQtJlHMJqr2hvQNuh8OQM6dpKFU0adRdMePbjgwsOc8Sr5pIOYB32vOlHrGCZJhLVTFdO34BywRVJcsyTzwWIC0VIwW6GFWTcA7g+YvuPUdGXsUJIhR7iNlJh2U7MsZoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rbe8O-000647-8s; Sun, 18 Feb 2024 11:10:56 +0100
Message-ID: <da06b67b-aa4d-4e5c-ab37-fdf3c08243f7@leemhuis.info>
Date: Sun, 18 Feb 2024 11:10:55 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs/9p: regression in 6.8-rc1
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: v9fs@lists.linux.dev
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <ZbQUU6QKmIftKsmo@FV7GG9FTHL>
 <3f08ca1f-77ac-4636-86d4-52b79d721fae@leemhuis.info>
In-Reply-To: <3f08ca1f-77ac-4636-86d4-52b79d721fae@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708251064;6ba26617;
X-HE-SMSGID: 1rbe8O-000647-8s

On 30.01.24 16:41, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 26.01.24 21:21, Eric Van Hensbergen wrote:
>> I caught a problem in the new netfs code when running in 9p when running
>> with nocache mode.  A regression sweep is turning up a:
>>  [ 1084.438387] netfs: Zero-sized write [R=1b6da]
>> when running my ldconfig test (included at the end of this)
>> it reports:
>> /sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
>>
>> I will try to dig into this later today if I have time, but not sure I'll get
>> to it so I wanted to make other folks aware.  I'm not sure how much other
>> elements of my test harness are contributing to reproducing the problem.
> 
> To be sure the issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, the Linux kernel regression tracking bot:
> 
> #regzbot ^introduced v6.7..v6.8-rc1

#regzbot introduced 153a9961b551
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
