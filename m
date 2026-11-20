Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168094;
	b=Yf2VFU+XHocqJHM4Nh5s28XT1g4pKqCfBmtOf5qp/Ptns+jVy+hCR8dJCHVyOz6WC6dh
	 HUWtYMY2ekD8aE2vGOmA6XpHpBtL8bOg03FcJwIBzobCY3AU0tlEFVyJWT2h7ZCQ6rnuQ
	 15G4vbLaHHpNcYycpPYCwi/J6J/hG2y3owuoe2W5RvJ1kVSBhTOQmnjj27u4zCcLSgAbS
	 W1yTc9slM3wyU5ShJHRNgJfa/nhC4X8P3cD1rzBEP/yUBSHb8kHQtpOiXUVVzxSgiQp8f
	 3ChgMLA0AMTOQeGUb2iKPq/0FM87LiVTup/nT+WpaDpM4Bpz3GnskxT7CQUrQQJB5Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168094;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pWjVCa7tCXDDTN1Ib7afWClwYQ+0Kmu6D6EaxjYX7RA=;
	b=R38fB4j/KXnkiRZROWqQgBmjFoH6326xNrGIzT6S8M0dvF9zae30RGuYSMa4CjoB55HY
	 fki3X8vDwdGWzI1aN2Ch7om5rVr/+8S8pVvNvjZV6MIDG2F2SQTt/Xp2fwaJnKpgCipEC
	 M5oRR0RSCP8HCX2O4PqNCMOTIEu+Q8PwCKNodM2GCe6MUWlZ8rTqb9LP2AskXKhJeUyf5
	 C+TWjzE0NdkpjfbOBchPJRmmYJ9lQPwFZLGdmf8GgQnBKaqQbgQiJugJSdE+jkjeFZNRq
	 YN70KKlXfe+rpNFEOL30GfwCfrY2+7oOfcTzcm57ikbToAHiZsGljLAtap5RmaA79Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxRqifY6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58331606A325;
	Fri, 20 Nov 2026 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxRqifY6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961941F000C6;
	Fri, 20 Nov 2026 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795168094;
	bh=pWjVCa7tCXDDTN1Ib7afWClwYQ+0Kmu6D6EaxjYX7RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZxRqifY6TNUKPcyFiugkpxplrERO0TP3BHmsQtsalgMyiNQMTrc3GhHWvkV4qbfQ6
	 tdrmqvKTGdGWE6m78OReujbVgHOXFgcekEhevRDEYlhUKq/nS/K9pXsB9PD44yWbrB
	 vDqb/WE5VaBgzEpfMJKPDEGY3kO0h+HUbM8yr7vIJQHcOiTC6UB9Spd/26H49HJglx
	 uQCi/81FMb0UT0Iwe9oTbdZ3EQuAS6GIi2tI876nP6QCqjy4AGvEkAN3lwYadEYpbF
	 3HNoYV8mElKhHaUmJKRlOIArOho8MHm44VwjUdLgQIWVZIHLZwAh8KtWSPcb2h89vA
	 4r5IkHN2Gznww==
Date: Fri, 20 Nov 2026 10:48:08 +0100
From: Michael Grzeschik <mgr@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: nkapron@google.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: usb: p9_fwd: Send complete requests to the TCP
 server
Message-ID: <awAXLky2Aa6y-RZ5@line.checkpat.ch>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120061937.98224-1-zhujun2@cmss.chinamobile.com>

On Fri, Nov 20, 2026 at 02:19:37PM +0800, Zhu Jun wrote:
> socket.send() can return after sending only a prefix of a request.
> The forwarder ignores that result and waits for a response to an
> incomplete message. Use sendall() so request forwarding completes
> only once all bytes have been sent or a write error is reported.
> 
> Fixes: 673f0c3ffc75 ("tools: usb: p9_fwd: add usb gadget packet forwarder script")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Acked-by: Michael Grzeschik <mgr@kernel.org>

> ---
>  tools/usb/p9_fwd.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
> index 12c76cbb046b..d5ffb2f0c5ab 100755
> --- a/tools/usb/p9_fwd.py
> +++ b/tools/usb/p9_fwd.py
> @@ -124,7 +124,7 @@ class Forwarder:
>              data += self.ep_in.read(size - len(data))
>          logging.log(logging.TRACE, "c2s: writing")
>          self._log_hexdump(data)
> -        self.s.send(data)
> +        self.s.sendall(data)
>          logging.debug("c2s: forwarded %i bytes", size)
>          self.stats["c2s packets"] += 1
>          self.stats["c2s bytes"] += size
> 
> 
