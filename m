Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5D242D6A
	for <v9fs@lists.linux.dev>; Mon, 16 Feb 2026 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771266990; cv=none; b=GPZm3AJlwvU164bosWhRyo4TTUQVmOvm6KfctXvZ1csw0LVKHW/3rVcRTwzddGR/F7Ga6mmO8cArDdme0yJSg6QhEXtvlJVxhL8mgpra6UjA3M/BwUB+yzoX1ZnWiBm+xLR6XUQ8viqy/5SAP6PhIO3VXi2mvGjGtendg5A+MLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771266990; c=relaxed/simple;
	bh=QRv2RNDiDu27KKeWxAQIcWuH/Q4/aQSzGkg6+PP/rcA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XshJFgMrgSd7MJv3mvx0sDcggej6F00zFLihdx4Qzdz9gczRjdOk1I33CRfR0eMe+Wxh9rUtlipHZqaCIHWkZB4L/QfmGRET4PT37iegwmI/rcgA8Xf0GpEMQNpb2o1CaFoVig+VU52Lf2ltEUIm7+szTXU/8xNN/N4k5Ja4I/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcC0nr1R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcC0nr1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FE8C116C6;
	Mon, 16 Feb 2026 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771266989;
	bh=QRv2RNDiDu27KKeWxAQIcWuH/Q4/aQSzGkg6+PP/rcA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WcC0nr1Ra/bOfB+zxY1lm4HYjMoRZoHzOvkX3/DsWizUm0B7RyvFJIejP3oizhkvv
	 utEu+Hes+VWUJPZpcIcZCg8DZ8Gl/rY6K5+n6aJAcTOThDpg2u/N3XavWXKS2/wOsB
	 moyPWPu8qIe2DIqNc+4be5jn6C31QLTiR5pUyvl+0XrqSPbholeiQxvKsORD/wnLbE
	 UEmVyaxAQxtCYofnnTH3e065/wOKn3WLOvWB8ymN31RajvvvmHfYVr7IKMFKVDDTNQ
	 LHTPanD94SJR7uCIdIkUOiDWsTtYx9PeMlGEr/Y0XF+2/ajseHf1kSAd3F4M86W3t2
	 1afBYioIUtpJg==
Date: Mon, 16 Feb 2026 10:36:23 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Dominique Martinet <asmadeus@codewreck.org>
cc: Stefano Stabellini <stefano.stabellini@amd.com>, 
    xen-devel@lists.xenproject.org, jgross@suse.com, v9fs@lists.linux.dev, 
    ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
    sstabellini@kernel.org
Subject: Re: [PATCH v2] 9p/xen: protect xen_9pfs_front_free against concurrent
 calls
In-Reply-To: <aZGOHNhDe1PPJCRO@codewreck.org>
Message-ID: <alpine.DEB.2.22.394.2602161036160.359097@ubuntu-linux-20-04-desktop>
References: <20260129230348.2390470-1-stefano.stabellini@amd.com> <aZGOHNhDe1PPJCRO@codewreck.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 15 Feb 2026, Dominique Martinet wrote:
> Stefano Stabellini wrote on Thu, Jan 29, 2026 at 03:03:48PM -0800:
> > Changes in v2:
> > - move priv->rings check above the loop
> > - replace list_del_init with list_del
> 
> It looks like I didn't reply a couple of weeks ago but I did
> pick it up and just sent to Linus now.
> Thanks!

Thank you!
