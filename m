Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA515278E;
	Wed, 23 Oct 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668154; cv=none; b=GpiaVdOdV0yIrJ13DMopwzHGNOlOYXAyZa+yQaTFpc0xFJ2fupIj4cRs0kamChq6cMyxsJnnztSQfDII5CtAL1wiKEFTrrkzkWly0/YcTmOj4XwIZWMKQpPRsJaM0reKFvD61YObAgNgufzIRPJxuF2ZGi1jc+8OpfPdtlV6oSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668154; c=relaxed/simple;
	bh=sFv3EiwOOEVRpu7p1CenvFdCSUOODoW6zxjJVHYD3t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp8UAt87Q4bh2ZFWIbIqjXy9sTPUnePH1MP0yyg0JwI1plqkY//rTf8/Ufq8DvLj4PYh1XeX+DuspGTxhTfb+FKJKy6zw/4fN5g67GtRu1UtMKON2KZ+0RaK5bgqEyiJkmk00Nz84AUA8RX8FDCO3nLRkdUNHna3tRFa+Lr+fCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=qiHyLiv0; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="qiHyLiv0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=mN8Y2550Y23LuHYG423su/I1RnywXe35ewFMA0Rljj0=;
	t=1729668152; x=1730100152; b=qiHyLiv0uGXMioBQEQSNnCuwfaQQ2XpP4YHmebul9EIlMUh
	AZs6gG6Sba29TUtqwhJarBc75/WStJWl3cR5hG3JBG1jnb3K3k3HZqd0yZWnmsVIN670+CSNmSTmY
	7cnaqYr8URZokvIIngIpksO+JWswbcM95ByQ4hfVH1wHzDi6X2+aYqhu0/Hbcyh9a9SYkLcXLMmGq
	GhVD5137cbqlxce23Ur6y0YwEzAuqOqo/E27oKCUigO9RseEcIXROWddxPlfGtRfrUzTSKGdq1nY3
	e4Lk3vNKxVrDami6C83MZw9VR/zAARy/VJFhlUkrvn+K2eRb3iGYR0Eq2iHiOokA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t3VhL-00013X-Ml; Wed, 23 Oct 2024 09:22:27 +0200
Message-ID: <26f5505f-185a-43a9-8eda-4fb36c0f07c4@leemhuis.info>
Date: Wed, 23 Oct 2024 09:22:26 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
To: Dominique Martinet <asmadeus@codewreck.org>, Will Deacon
 <will@kernel.org>, ericvh@kernel.org
Cc: lucho@ionkov.net, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, oss@crudebyte.com,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com,
 keirf@google.com, regressions@lists.linux.dev
References: <20240923100508.GA32066@willie-the-truck>
 <20241009153448.GA12532@willie-the-truck>
 <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>
 <Zw-J0DdrCFLYpT5y@codewreck.org> <20241022150149.GA27397@willie-the-truck>
 <ZxgudMCSgbDOEjpD@codewreck.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZxgudMCSgbDOEjpD@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729668152;d70de52b;
X-HE-SMSGID: 1t3VhL-00013X-Ml

On 23.10.24 01:00, Dominique Martinet wrote:
> Will Deacon wrote on Tue, Oct 22, 2024 at 04:01:49PM +0100:
>
> [...]

Dominique, thx for taking the time to take care of this.

> I've also confirmed reverting the 4 commits listed by Will do fix both
> behaviors (along with a fscache warning when hitting the duplicate inode
> file, but that's expected):
>         724a08450f74 "fs/9p: simplify iget to remove unnecessary paths"
>         11763a8598f8 "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
>         10211b4a23cf "fs/9p: remove redundant pointer v9ses"
>         d05dcfdf5e16 " fs/9p: mitigate inode collisions"
> [...]
> I think that's the sane thing to do, let's first go back to something
> that works and we can try again if/when someone has time - [...]
> 
> Thorsten, is there a preferred way reverts should be done?
> In this case it'd probably make sense to squash the 4 reverts in a
> single megarevert? At the very least getting anywhere in the middle with
> the uaf isn't something one would want... And they all made it in 6.9
> together so there's no benefit in splitting them for backport either.

Will might be the better person to ask, but since you asked me: I think
I've see a "megarevert" recently from the corner of my eye, but that
made me go "huh, that is unusual". My perception might wrong and in some
situations they might be a good idea. Not sure if this is one to to the
UAF. But that would only be relevant during a bisection or for everyone
stupid enough to backport only some of the reverts (if I understood you
right). I guess a proper patch description and a common Fixes: tag for
all four should prevent that.

Ciao, THorsten
