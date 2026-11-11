Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368058;
	b=xjgg5OaHpuoqJEDi91aRRsjtsR3wctO4w/z04Qh77K/WJml9T34hQrE3+4bzIOzuqv57
	 osdByA+YoT05nKSMHMc+x7T/D72zF+4iRWIeF6loNbQKc21d1GrnZuBYNBY4oxKH452tS
	 93ugMPcNL0fB1MhVpKGnJKP32kvQc9/eldjnsgV0ohh8tEbDx7LBQ4DE3bIVpH1Ds6Gp9
	 ix5NOsbLaJhf7c5+OO920fD7KhxmP2eh7CQ+U15n30hwWkA8t80XiqV123Joa03XfGFKE
	 2+cu/EAYMlcbBwBLQ+jBtcXC7y+05+GrL2iLu3ywzmU2jZY45TaQoFORjMD5wCDql6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368058;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pS9OX84/PxeOC9j+2IlNqJ03/s9dcjLMQjBpL6kljYU=;
	b=aUR82TkIu0Wh8h9aFqifGIXWqE0ZKP9UhNlmmV+9Jt7n5YcerSGIJeTo7Hhzjun3X6zk
	 YfyWRhyChz0CIw50sh69/tEdZCU6KjSBF9RlUOCZCRHk/sngXt36M9JUoLlFtVZAMtILy
	 x4PaVYvGQFSiutYNmx4jyjOnG/jayjXVa+oDdVMf0XOWEjnQG9tRs3ii0sbo3wpFKimXW
	 Fgl/9JDj5znvTXzPuWvYPSndjh07djqdWIUi8obqnYRyKOGzyIQh5+1ElyThSdZpc/zkT
	 TGpTRVrcXnv6k28Yss0IvtTyJCNObTvKC0kpTd11MyQpwQ6obY4vudZ3X3F3W6t2GMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfOiDDDy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128D606A31C
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfOiDDDy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA011F0089F;
	Wed, 11 Nov 2026 03:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368057;
	bh=pS9OX84/PxeOC9j+2IlNqJ03/s9dcjLMQjBpL6kljYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jfOiDDDyEK7e9oF1gqnFWZ3cJLpf2R+rIo7wWX/qfDOEYG1Gem4yt2j03stjFL7gR
	 vlw/nbg9xQD1VmUAjw0OQDF64Q9k67BGeb1DGPZLPp8is0kWR492qxVnQoA/HIDwCG
	 RmE7kuaycgDY26wXX/OG8Ib63pnQQh+GDf5Y2Koa3esZ3IV6JVtfWd+QKXCqnKG8hY
	 b3NosExhKLWVsJk66EdozvYR12sn1sa2SWcBqS7Pq6+4dvw4Oy4jaGMYz/We44iFLJ
	 csRPZb5CC3yO6VUXKTjgsyfqJ66S9zEM1l7UZ3wpmQ/1j/N4nM5e6bPd4/zbZGUzQn
	 RHF5SNrJF5MwA==
Message-ID: <sashiko-outbox-208203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net/9p: publish fd cancellation error before status
Reply-To: sashiko-reviews@lists.linux.dev
To: usualtree <1340399194@qq.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <tencent_10059585FDBE07269A8A28C34F0D2574C00A@qq.com>
References: <tencent_10059585FDBE07269A8A28C34F0D2574C00A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:34:16 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] net/9p: Signed-off-by trailer uses handle instead of real name
--

commit a32079abdb296b813661b18de6c966dc330ce262
Author: usualtree <1340399194@qq.com>

> net/9p: publish fd cancellation error before status
>
> p9_conn_cancel() publishes REQ_STATUS_ERROR under req_lock, but only
> sets req->t_err after dropping the lock. A waiter in p9_client_rpc()
> can observe the error status and read the initial zero t_err before
> the transport stores the actual error. The zero value skips the
> transport error path and leads to parsing an empty response instead
> of returning the transport error.
>
> Store t_err while moving both pending and unsent requests to the
> cancellation list. Add a write barrier before publishing
> REQ_STATUS_ERROR so that the error store is visible before the status.
>
> Add a read barrier after p9_client_rpc() confirms REQ_STATUS_ERROR and
> before either the debug log or the error path reads t_err. Keep the
> existing post-wait barrier for normal response ordering. The new
> barrier covers a signal-interrupted wait where the second status read
> is the first to observe ERROR.
>
> Keep callbacks outside req_lock and preserve the existing list cleanup
> behavior.
>
> The issue was reproduced in QEMU using an fd transport mount and a
> temporary delay after the early status publication. The waiter
> observed t_err =3D=3D 0 before this change and -ECONNRESET after it. The
> delay and observation instrumentation are not part of this patch.
>
> Kimi assisted with the reproducer, fix, and validation, based on a
> request to find and locally verify a small 9P upstream fix.
>
> Reported-by: Rahul Priolkar <rahul.priolkar@asu.edu>
> Closes: https://lore.kernel.org/lkml/20260911092132.3328659-1-rahul.priol=
kar@asu.edu/
> Fixes: 11c10956515b ("9p/fd: fix issue of list_del corruption in p9_fd_ca=
ncel()")
> Signed-off-by: usualtree <1340399194@qq.com>

[Severity: High]
The Author header and Signed-off-by trailer use an account handle
("usualtree") rather than a real name, which does not meet the Developer's
Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_10059585FDB=
E07269A8A28C34F0D2574C00A@qq.com?part=3D1
