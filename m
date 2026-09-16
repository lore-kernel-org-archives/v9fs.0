Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA564307A0
	for <v9fs@lists.linux.dev>; Wed, 16 Sep 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598757; cv=none; b=t9xOOi8bhzBd1Gelo4HbOgRUu3IFzK+whYINwa6aQNlFpldJnTEVf9IEumyGox/H7CDhh4Z/oMSV5zubRCvaF9LO5ZQGg594+yZYqMgBxZ/fcPrKh23/XhKgy0eZxjiYrNRjt7KbwPvguMfFNId/DO+pc9KRAtXtOOXpcoGQTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598757; c=relaxed/simple;
	bh=QPJiK86gWczwyhvPZ/RtOdPnY9Fb/B11shcZsNCWri8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx79I+hwbb6DWM6PXr0xFApsEt2gEn6sh7rTI6yEdRWBIdD/vC6oZpS+0aaD3w9vdNBBy9sOxjJo9m5Ob5PP5AtWBSDyNAUDfS7hKDM93s9nMpcgu4nr8cQfmkuUtsxL/3nMBWBX/nZ0pvUfZciUJmnY8Ut6luPAMTQUMBEv2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=fs+hCgF7; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="fs+hCgF7"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id DB2DB14C2D6;
	Thu, 17 Sep 2026 00:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789598748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0vKeMZP5O8XjD8NFaFZ+hYELsVn/1VFNg126B2KHt0=;
	b=fs+hCgF7/LuEowH7wAbL5nKlzv1OH24p621QUlYZTo82FfDXJDAQNz7UiSEmskKXiH1nt8
	zoqvDKRXSrtfstBCHKE07HMZ94E+S7viRMOTd3h9oZs+EM6xTFsufAegiuM3taPCCtqaWa
	9dGTGnZ8hoZ7y0NuvdCy2S19ING1ImYye2oqJ6JYPH6P5zwHMgtyKQgn9FCFjOm0sorVKp
	4GPZYbkaugumFBF9TrTMGowagXIRYJBjC+8sEJIOteShopY0rC1tTAfKGr32qiCdvKVFIH
	aTnyUWlO6t6ERwO9VQEPHqH5hEAm4R3gg5u4laVBFv9Q0Qy1ZTuMx4DPDmVdmw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1d946a2e;
	Wed, 16 Sep 2026 22:45:41 +0000 (UTC)
Date: Thu, 17 Sep 2026 07:45:26 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
	Haobin Wu <853555@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, willy@infradead.org,
	dhowells@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [PATCH v2 2/2] 9p: skip directory entries with names longer than
 NAME_MAX
Message-ID: <aqscBuQli__0XUv4@codewreck.org>
References: <20260916135403.15789-1-853555@gmail.com>
 <20260916135403.15789-3-853555@gmail.com>
 <3910569.MHq7AAxBmi@weasel>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3910569.MHq7AAxBmi@weasel>

Christian Schoenebeck wrote on Wed, Sep 16, 2026 at 10:02:08PM +0200:
> > +			if (namelen > NAME_MAX) {
> > +				p9_debug(P9_DEBUG_VFS,
> > +					 "skipping entry with %zu byte name\n",
> > +					 namelen);
> 
> Fair to say why:
> 
>   "skip dentry: name length %zu > NAME_MAX"

Agreed.

I'd also say to keep this as P9_DEBUG_ERROR rather than VFS: it should
be rare enough and nobody will enable DEBUG_VFS immediately, this keeps
the message at the same log level as it was previously

(P9_DEBUG_ERROR is not printed by default, but I've been meaning to
try to change that eventually... Someday™)

> This is only handled for 9p2000.L so far. For legacy 9p2000(.u) this should
> then also be limited in v9fs_dir_readdir() IMO.

In practice this was already the case because of the processing in
p9dirent_read(), so I have no strong opinion here, but I do agree it
makes more sense to be symetrical yes.
If done it should be noted as a behavior change in the commit message
(or split in yet another commit) though

-- 
Dominique Martinet | Asmadeus
