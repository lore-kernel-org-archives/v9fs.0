Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E232620
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265321; cv=none; b=taRRXtiPAF+XEl/BrPW4optn0zSaAYQTcPh2uc/lSepnqgbfLcHCcVjJZDy+EOaqzzFhAO5YN617YsQ3GEbKy+WRsGHjsAPWiSZUYTeMIeyoAxPq1QlLIaTlCrcMuO2j6E2PeG8Gyl1SviMDrXxdNyqVt91QouM4Ps+z88l3wZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265321; c=relaxed/simple;
	bh=kyZHKNexqbaTvINDnSG7o+9qbFCU9/FBahRKSEpRBBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgFIFoqy8NolLhoFHNZpJvx/4JsHltVVxDfJTtv1e7NYwEidPCGk45TslyVJKCxbgncuxgIZdO2u0VsnpnXrV9uoBIrU8OKmgUQAYxMUq7Yv2IrSUjQ134VgLUPqHs2Q4JnV6kLOIUkXYGpHEUBg4Yaa2yQnaFAxEbXSkywY0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=IgIRylUt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="IgIRylUt"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2A9CB14C2DD;
	Thu, 18 Jul 2024 03:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1721265316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v41elBeHbuG4fiYvQyONqpyY5ae1DXfmoMpkwePlI24=;
	b=IgIRylUt/PScuSVrg9grTSAgwLlbQ4zfrxVrTJF0Mc/qpRPvcWrMFZwYUDZEKF7nN8RIa+
	nLa+14VJoeWUK28vAusO8oYZqGkIiOVJ22PSLFGDsyOViQnpQAgPF8EcSrMqU5/HVNHxls
	bObNY9CQyQ15vXziiysvWiBJbmxzngM5fEYz+JsS+ljzbQYairtizP9/x6bVH2XqsmsPXT
	dTlEzVIG8ktosJjq2eMCdo+5XODKbpLq1V6zKwtwbaAgC0xA87koQqgqdSSpB7yoHC0HHw
	iEIQEt5wd19sShnK6i7weIdP7sXRxTWOHE/zRYs55oRR2O6z5mTadXLxc/sTfg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8fb27d31;
	Thu, 18 Jul 2024 01:15:12 +0000 (UTC)
Date: Thu, 18 Jul 2024 10:14:57 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jakub Kicinski <kuba@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	v9fs@lists.linux.dev
Subject: Re: hangs after merge window changes
Message-ID: <ZphskWZb_pkxMVvW@codewreck.org>
References: <20240717102458.649b60be@kernel.org>
 <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
 <ZpgtXjz3pbJKUjL7@codewreck.org>
 <20240717163051.13e41526@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717163051.13e41526@kernel.org>

Jakub Kicinski wrote on Wed, Jul 17, 2024 at 04:30:51PM -0700:
> On Thu, 18 Jul 2024 05:45:18 +0900 Dominique Martinet wrote:
> > Eric Van Hensbergen wrote on Wed, Jul 17, 2024 at 01:01:26PM -0500:
> > > I held way back on adding anything new over the past cycle, so this
> > > sounds likely some external change maybe perturbing an older issue.
> > > What guest side mount options, qemu options and qemu version are you
> > > using?  
> > 
> > Mount option if any would be much appreciated, yes.
> > Also, what version you upgraded from to limit the limit the search a
> > bit; the previous 6.9 tree?
> 
> Between networking pull requests. Basically
> 528dd46d0fc35c0176257a13a27d41e44fcc6cb3 to 
> 51835949dda3783d4639cfa74ce13a3c9829de00

Thanks, this includes this commit:
7180f8d91fcb ("vfs: add rcu-based find_inode variants for iget ops")

I think that's our most likely candidate at this point, adding Mateusz
and others involved in Cc until I find more time to reproduce.

@Mateusz, Jan, Christian - sorry if it wasn't the culprit.
We're seeing new hangs in find_inode_fast between the above two commits,
see the extact hang traces top of  the original mail:
https://lore.kernel.org/v9fs/CAFkjPTnTDWrfCSVzvtSszjoerOeWBn8Z6DC4qFMH70Aq7Pqr1Q@mail.gmail.com/T/#t


> > Also couldn't find much infos about the CI in general, given the traces
> > I don't think the workload matters all that much but it can give
> > something to start with e.g. running from initrd and mounting 9p or
> > using 9p as rootfs; that shouldn't make a difference but might as well
> > try to reproduce from something close to the actual netdev CI given the
> > low reproducibility.
> 
> What CI does is described here:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> it's fairly simple, virtme-ng just runs kselftests inside a VM with 
> the host FS mounted via 9p-virtio.
> 
> I'd offer running experiments on the exact systems, but this week 
> I'm partially AFK (at a conference).

Thanks.
You're not doing anything specific, I'll hopefully be able to reproduce
it running similar workloads at which point I'll try to improve the
reproducer and get a closer look if Mateusz or others didn't beat me to
it.

-- 
Dominique Martinet | Asmadeus
