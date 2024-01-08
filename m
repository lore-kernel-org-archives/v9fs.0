Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25214A8E
	for <v9fs@lists.linux.dev>; Mon,  8 Jan 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="D0vpJnOO";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="D0vpJnOO"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 6EA2BC01C; Mon,  8 Jan 2024 12:09:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704712190; bh=XF5g63PxgUfcpdhZm7KbjtFAwZYlqAklUlv7vcrbkUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0vpJnOOoJWIkhkTlf819dMpz1fgMNkafsPkwn9gfyDhdHkc57oyyKfkkCqlQMQw8
	 pG28nVTSef3HGgED9V8kjXsBWnGsbHdFGkYZLtFjy/lEJ5mX2rDmtIESwJ8yMDF1cg
	 QarwsgrM4OD71QJparO/1ku3EFgwtkH/u6NO/FVxKzMsFpNxcXKRw8Z5J4aaJZounp
	 O4e/SoBKL1HlY0oBy5U4UoYkGRfbp0isksL7RyRBHO0quLRy5RZ6Zwvev4ROVzyLpH
	 n60eL/uznVyajz4fbgk2GsBWva/s2uRYD4QMcMkaEEbuobli2g4ola31Tu8BgBFkLd
	 557z2UT8rdDlA==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 9D91DC009;
	Mon,  8 Jan 2024 12:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704712190; bh=XF5g63PxgUfcpdhZm7KbjtFAwZYlqAklUlv7vcrbkUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0vpJnOOoJWIkhkTlf819dMpz1fgMNkafsPkwn9gfyDhdHkc57oyyKfkkCqlQMQw8
	 pG28nVTSef3HGgED9V8kjXsBWnGsbHdFGkYZLtFjy/lEJ5mX2rDmtIESwJ8yMDF1cg
	 QarwsgrM4OD71QJparO/1ku3EFgwtkH/u6NO/FVxKzMsFpNxcXKRw8Z5J4aaJZounp
	 O4e/SoBKL1HlY0oBy5U4UoYkGRfbp0isksL7RyRBHO0quLRy5RZ6Zwvev4ROVzyLpH
	 n60eL/uznVyajz4fbgk2GsBWva/s2uRYD4QMcMkaEEbuobli2g4ola31Tu8BgBFkLd
	 557z2UT8rdDlA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id ccc77bd4;
	Mon, 8 Jan 2024 11:09:45 +0000 (UTC)
Date: Mon, 8 Jan 2024 20:09:30 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	Christian =?utf-8?Q?Sch=C3=B6nebeck?= <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/9p: Improve exception handling in v9fs_session_init()
Message-ID: <ZZvX6sQLkgm0kOTN@codewreck.org>
References: <7203d3fc-f1e4-4fb1-8dd3-068b0ec6c752@web.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7203d3fc-f1e4-4fb1-8dd3-068b0ec6c752@web.de>

Markus Elfring wrote on Thu, Dec 28, 2023 at 09:01:49PM +0100:
> The kfree() function was called in up to two cases by
> the v9fs_session_init() function during error handling
> even if the passed variable contained a null pointer.

I don't see the problem in calling kfree on null things (especially on
error path).

The only bad pattern I see here is that it relies on implicit
knowledge that aname is null before the call (which is true because
v9fs_session_init is only called immediately after kzalloc); is that
what your coccinelle script was checking for?

Anyway, as far as I'm concerned this is more churn than it's worth, but
I'll defer to Eric if he wants to take it.

Thanks,
-- 
Dominique
