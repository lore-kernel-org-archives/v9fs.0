Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446987;
	b=HKgQqstWCt3z+RV5pACfUv081RW9Nt8hlctDjIZ9hTt+VTcA1cwtV+K6z0UANXkvZQ0F
	 I1ZS/YIirhUS6u0e6lkIinw24tGmeoZpST+qSDRlVjx/YGwijZ5+csa4AkbjhBjG/H/Qu
	 AVg3L8tmBncc0PIRc0vEGOsMhZ3UhGutCjz+gwh3OmWKF68hpOdgVjCg9MwVeuRlY7hNl
	 exOxHCu+WC6n4xf6cwTYO/AF3D0y5e1eSbzdiarbfgQ+C5BXbkScjYD1t7+eY675ptHd7
	 Z2RRfqEuARnTehaKqmOxLrW1tIdkxpgdh06ftVU/NjkYlFiojAjFSGv0JPb8+VWsQtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446987;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TRxZpr5CFHb4+t5v/R4vvN9sjWyGPlgPL2ot1kVesyg=;
	b=dfQsnnA4voHRi3cawjGs4fomTzTkCVrCcBSbI6zTnIpwCkXKGfq5O5EdQ/BLdhooTAPm
	 8VjbY44KUskZU+mu/nFgHSXqygeX+lQddOk2LoxurRc4iU4Ajflw12wTlHQOZJK7xOK4W
	 wqd3rgnNYs4A01gizeQs7YIkKjwaZFyL/j888BZB368CbFhHDv2JSCxqon3JLj+FkcX4H
	 Eu7Yb+Lct+0xp3wSUUM2VX5PFjpc29WNMeCVHFVEVOJ+xS6o2PYpFqHqZqZlitE5Dtcxq
	 YOOWYRRhyH7B0rtNUhUIVRRG6jwLLGkHVC4wO7LyBPsaYdIO7M4swf6AvmtCYByHA+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYVl2JaT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D376606A321;
	Mon, 23 Nov 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYVl2JaT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1541F000E1;
	Mon, 23 Nov 2026 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446986;
	bh=TRxZpr5CFHb4+t5v/R4vvN9sjWyGPlgPL2ot1kVesyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AYVl2JaTRF4mhsxk8IV+hhSTBI4UWjtqrcQ8g9z6Wasm2A7TGpZZyNl8uAFgPZqtU
	 5P49Pk+41bhhvmhkRrvj6qe58tluIsGjsIVftmCWe6SiOK8Ty9tEuNQZXUV+/A0WBA
	 PtBFqEdBCyiDWclD1eWkq5uZ+fLQzdYK1sID2m7C584OaeiO34rw00fzLbeG/EFKk6
	 Rx9rokqm8jztAwa9Dlsyn0IskZFI7HqUgPAsRsSbGVMJKjtVFEHQCfbZQ2UFFXIaP9
	 yvExzj8WtQpDyQ1OPRfWH/OaRVMQJpCASunHwDolcKkKjHQrvZo3Y4bQUdI15J/WZu
	 RNF4SX8vKjRDA==
Date: Mon, 23 Nov 2026 16:16:21 +0100
From: Michael Grzeschik <mgr@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>, nkapron@google.com, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: usb: p9_fwd: Send complete requests to the TCP
 server
Message-ID: <awRYqogEpIWuCN9-@line.checkpat.ch>
References: <20261120061937.98224-1-zhujun2@cmss.chinamobile.com>
 <awOQD-9KMTflKrd4@codewreck.org>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awOQD-9KMTflKrd4@codewreck.org>

On Mon, Nov 23, 2026 at 09:59:59AM +0900, Dominique Martinet wrote:
> Zhu Jun wrote on Fri, Nov 20, 2026 at 02:19:37PM +0800:
> > socket.send() can return after sending only a prefix of a request.
> > The forwarder ignores that result and waits for a response to an
> > incomplete message. Use sendall() so request forwarding completes
> > only once all bytes have been sent or a write error is reported.
> > 
> > Fixes: 673f0c3ffc75 ("tools: usb: p9_fwd: add usb gadget packet forwarder script")
> > Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> 
> Thank you, picked up

gregkh already picked it to usb-next

> -- 
> Dominique Martinet | Asmadeus
