Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395620;
	b=PtsYn8lBv4BIX24WXI3haB0DhPNpoCM9nHQHp0B8+fLSdVxszguVR5r+vaq8qybdAB/V
	 jgWnp8TXUJX1CXvh/RIH+3TD9Ae6MGSsdO3xzZxygRSWXJDoq+RBh/TNB/fm9ofhhILjz
	 b0gI9f2/uztYg8gdUw59A6AQnDHTTyynu9A2NYyO8SbXgZq/coL7KKSD9GJePmwtWpUFb
	 a3q/6fp0YYTqZKXgMtLU+yU9v8j+7UjFR38S7aOYk3uVVWinyc2BxK/Th4ctJ36Pv9kOI
	 C+O/88H4mIrlTBzzV8AdyWegbKURA6ofZCwdM2+yPPauWsIlCZHGqoYDn5yqVxbAUvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395620;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=82UKgW9q7fdHJGNxFuYkS9f9oni4yYQAehGXY4eGJO8=;
	b=X7jOVTSTfUDrE8WWIl2MUNNIimfEUhjz0Tyb5VVP+q0+qAO3BMFn3BzpdlBwAyu2WFfV
	 zKaiBZVf+xZGMwgkxVCFmW0LqfEcart6LEbeZeXUtL9xwNiZhE04Bi8uoA9gUGDg/+9XF
	 ElkZMcN2FyJAQR9IRYfaJfG/f5ygQkVxB6CkqbuDh+u9+2wrwly6UCvoklwj0y/5oF+Qg
	 hH/BMzKIKTlpUllPDYu9jIIMzY5cnBTXbgoVkkAE6dFXNIAtrgWxI/PYcKLPQvK+nRkqC
	 pm6SHgpWRChqt2cTc9rB241ZYigeyxUGrILMySX5/pBfPKGivtunVlQT+bGttU1B3vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=SYMO9gUL;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A51606A33C
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 01:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A51606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=SYMO9gUL
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D028C14C2D6;
	Mon, 23 Nov 2026 02:00:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795395618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=82UKgW9q7fdHJGNxFuYkS9f9oni4yYQAehGXY4eGJO8=;
	b=SYMO9gULck/EMtV+eBS3tT+qNeooPRQGxbp7VkxiSqnisKDF6vN9+2rt9/KUhAAaD0twNc
	8YYJmcZxM8J1ugfC940GIDRoAx/QlMHVKALg7bSaE7xjPjKyaXM6vvNYdlRwEjQqxSxG5f
	eDxEfdXd4Mn0tHt1+X154PsXaC/S5Xf+QzFVhrQXXEkfC1Wu9HQjnvPgeZt+qmyW3Ffjue
	6kThehA1dWhIx09dFN3xQ5Zf78TLKnYyZT0w5b7Qr2GXWldWbEg6vtb7xCRV6+ZG0Ba2b3
	c6ZXKj4fOEY7qLAP+gBgP2vq/ldAwZY1gE16uTDEE0RiFq3VUk3QGENUeIeXPw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b575b958;
	Mon, 23 Nov 2026 01:00:14 +0000 (UTC)
Date: Mon, 23 Nov 2026 09:59:59 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: mgr@kernel.org, nkapron@google.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: usb: p9_fwd: Send complete requests to the TCP
 server
Message-ID: <awOQD-9KMTflKrd4@codewreck.org>
References: <20261120061937.98224-1-zhujun2@cmss.chinamobile.com>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120061937.98224-1-zhujun2@cmss.chinamobile.com>

Zhu Jun wrote on Fri, Nov 20, 2026 at 02:19:37PM +0800:
> socket.send() can return after sending only a prefix of a request.
> The forwarder ignores that result and waits for a response to an
> incomplete message. Use sendall() so request forwarding completes
> only once all bytes have been sent or a write error is reported.
> 
> Fixes: 673f0c3ffc75 ("tools: usb: p9_fwd: add usb gadget packet forwarder script")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Thank you, picked up

-- 
Dominique Martinet | Asmadeus
