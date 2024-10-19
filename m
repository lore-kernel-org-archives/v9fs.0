Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6D29AF;
	Sat, 19 Oct 2024 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729315742; cv=none; b=ceWq/TmPVaj9PHJNtcqVEplJNgbNiYjqOSqJS63Zo8cN7ie+/5jRmS5FVRUuJl8Lhc/q71Jp6t4eAK16RgwkMPSSa5r5QYixyVrsKZR4XVgNjSESio7eoEhaYXoIaH9LkSUQbLHRak15AkDxq+IRsO8/JSr+Wb4QmAgnOBNHCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729315742; c=relaxed/simple;
	bh=9drtG3/cH4RiYcuYy/wzZPCuMwYPjfonb7/fKLLqggk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCGfBSUO8UIh/I2IXk5s1vQnXps+XRxwmImq3qOoUDZw99LL7b2OoQnd2agvBeuCtyh1nQxZYBAG5JJHrmz6ZkmrCg+T78rdiMZ0BuOVFGlXuPP3ptIItdvhsJwZv0YjKF6wlu5/TwMnOz51zpsPG4oBlvbFhXZJ99ZNPjdyHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Kkv4AU+Y; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Kkv4AU+Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=nVFGjf04is2fecvjXt6D+ulwXScKCzZWDCMOsjNplQg=;
	t=1729315740; x=1729747740; b=Kkv4AU+YjwyWe5HiQR0HRfG/GgZTYQIP0X4hRV0eSPBEB19
	cbP2Eex/L23TUmTnJMIctU+pK/aBEeZ6Bj5a+o3GewSIgPT5McYqXmIg4vzvK/f452WeHEXpSc7v5
	ipU4EctWCiPXiSrixV1oBeWShglV1FbZkWtAhTECs+IO443ltOKpTX9UCUAdt7sRiKAG2zWhSH8Pu
	3m78ZMbiF8ivHhrj7p0nhXYCv0M6S0XFpuZWOB6o1O0b7dKu+rymxpV3obTchPLPtehidP4yuS5W1
	USdeh1akoRSnA/RawCeflzn/zcuEKg0xiz/KIZ5ujjvGWkobwnJ37jdLvFVmoAEA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t221I-0003ZW-Jy; Sat, 19 Oct 2024 07:28:56 +0200
Message-ID: <3f388aaa-b449-4026-b50e-87d9033d09cc@leemhuis.info>
Date: Sat, 19 Oct 2024 07:28:55 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same
 name
To: Vlastimil Babka <vbabka@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Pedro Falcato <pedro.falcato@gmail.com>
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com>
 <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
 <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info>
 <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729315740;6a3e10a2;
X-HE-SMSGID: 1t221I-0003ZW-Jy

On 18.10.24 23:38, Vlastimil Babka wrote:
> On 10/18/24 8:54 PM, Thorsten Leemhuis wrote:

>>> FWIW, seems to have been picked up into 9pfs-next
>>> (https://github.com/martinetd/linux/commit/79efebae4afc2221fa814c3cae001bede66ab259).
>>> Seems like we're just missing a PR to Linus?
> 
> If was Dominique, not Eric, see:
> https://lore.kernel.org/all/ZvBIl8b9RRK9jgtJ@codewreck.org/

Ahh, sorry, missed that. Apologies again.

> Can you send it as mentioned in the email? :)

Dominique: thx for sending that PR!

Ciao, Thorsten

