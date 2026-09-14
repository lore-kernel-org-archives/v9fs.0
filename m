Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF003AEF2D
	for <v9fs@lists.linux.dev>; Mon, 14 Sep 2026 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429477; cv=none; b=qJfUSxF2rHg4z2cX/Mwp8G2dL2DerYqEJGgNkUPOtUCNYALGAG7dD5eQrx1dVwLVFND4tTQG7/hSd3eqwlTANz1GVHkmU3eqdbairzjGHEL/IOauKbP7o/R0yCebd6E/tMsoEYni7X39iL+/rpZG1qzq30hdkYJwwXzd0XqQWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429477; c=relaxed/simple;
	bh=+mQmuYbvMAABI5mXvtT0r+L8m/W+a+NShZiCRqeu7z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3WSnisQUXOe5jw+CLwsffCwIIVdX1D0k45+lgpnkFAtwauB0KxCZ2ztARLCIak2zF3vBpNwEAaTxcpbWesN10Yg22PjU2J8eet6KWBjSIccWJbCZ5mVHsRn+IByyVOzjJbn+jPthCf+rnENSw0Od/pHmwuYuQgo4+k8noTzJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=THa9PXiF; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="THa9PXiF"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 90C8C14C2D6;
	Tue, 15 Sep 2026 01:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789429470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oaB8NZhovJJ1eQqwIkUHdwHBkbfNsV/MCy4vtpAR5jw=;
	b=THa9PXiFgddcLyznyljllZ/YQtIzUOuw3ZV3JbskdPcs8L07akT0bcUV6YX26MaoD+H4Xf
	mI6wV4YFOzpgT/g5FSilTb3+wH05J/rDPSgpeHwwtOsoFiJQxQoAHWrWsSoPjQhjPSXkNt
	1gtxlwazkd79iSfh3GT/RKTRC1+xd8HwzzqmhWeUXlz+Y3CsvL3jZKqAAjpT2MYem/jZ2C
	zjuDGJKhLdcHCPP3DnuQ5p9Oi5sZN/dcMyeIKEo5uBcywbRNcCsuWWyPZcqXkAICMn8qhH
	NThdGz2Xzz7H5VfZOSCMmFMOEGEhJMAJEwR9nZVSepx8leUVQSEmkLrqQqwnYA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2a4026b0;
	Mon, 14 Sep 2026 23:44:26 +0000 (UTC)
Date: Tue, 15 Sep 2026 08:44:11 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: skvarlamatus@gmail.com
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stefanha@redhat.com, sgarzare@redhat.com
Subject: Re: [PATCH v3] net/9p: add vsock transport
Message-ID: <aqiGy_7S_cYs_6or@codewreck.org>
References: <aqautUJPkTMvmIGU@codewreck.org>
 <20260914175156.75298-1-skvarlamatus@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914175156.75298-1-skvarlamatus@gmail.com>

skvarlamatus@gmail.com wrote on Mon, Sep 14, 2026 at 07:51:56PM +0200:
>> Do you have/use an hypervisor that cannot do virito 9p (or virtfs) but
>> has vsock or something like that?
> 
> virtio-9p is only supported by Qemu/KVM. Vsock transport works on any hypervisor
> with vsock support and allows using userspace 9P servers.
> The motivation behind this patch is primarily driven by podman machine's
> use-case, which is file sharing on Windows [1] [2].
> The hypervisor there is Hyper-V/WSL, which supports vsock for host-guest
> data transfers [3], but not virtio-9p or virtfs. Having vsock transport in the
> driver would simplify the codebase and make the use-case more flexible.

Okay, thank you for the explanation -- I'll add a blurb to the commit
message with your links for reference.

> > On a similar topic, do you have an actual server that works with vsock?
> 
> Podman implements its own 9P server in Go using the p9 library [4] with
> vsock support via virtsock [5], but it runs as part of podman machine.
> For standalone 9p servers, I only know of diod and example implementations
> of various 9p server libraries (i.e. [6]), but none of them support vsock.

Right, diod has an open issue[1] for vsock but since there were no
obvious client available either it was never done.
I don't think it's difficult to do (probably more work to add the option
parsing than the actual vsock support), but for now I was able to verify
this works with diod + socat as described in the issue, so this can come
later if/when there is interest for other hypervisors.

[1] https://github.com/chaos/diod/issues/148
-- 
Dominique Martinet | Asmadeus
