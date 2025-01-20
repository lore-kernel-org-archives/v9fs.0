Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD63188A0E
	for <v9fs@lists.linux.dev>; Mon, 20 Jan 2025 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403958; cv=none; b=jbEl5RZxgP0vL1AZWX8OxNSqC4Hdw7tlav1yBoSdyLVEtw/5HiC3H1ttHUPdeLvlKG27aa2/ZLaTtP+rXQsu2MUA0AZyLzEtBGq9sXI5uHcqEkIQrXvJZhg+8XhfWwsViMwJIhkTsRmPmtQOyF6/ltJV2c8de2+9+rN2LZvTNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403958; c=relaxed/simple;
	bh=6O3LV9KDXKKJJFVKLY/Q6dL2MgXkDdEHWl2Ke+V1e1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J1ID752tmylbAFr5QuvRVLPyM9NJdUqVkR2msclyg308ZDU/EOQvnmQN4qDl57AciSCQ3ewmSGV21FJI73IRsqPFGCI9sZJhCvFOQFX0rcCfCQA3vLNxc2xDg+8Fzrnu0RRCMl/L1PoQclpJpJuMzBiCMbPQNAi3eyZbwQqH/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=SXzGIAqU; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="SXzGIAqU"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EE281240104
	for <v9fs@lists.linux.dev>; Mon, 20 Jan 2025 21:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1737403947; bh=6O3LV9KDXKKJJFVKLY/Q6dL2MgXkDdEHWl2Ke+V1e1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=SXzGIAqUygQMnhNpbeNmN2sQx/9oykt67wF8xPtxLQYk8cxnb7SnrRYkgd8v/Ok8G
	 ZyfO/vWEyVRdDFN4XaWuQ8kBVojLfWU4AdamxoPpHWBRiwcibeIPdqyx/3T7X95BgY
	 8Lb16Ry3CxNeLrF1lCFgUxWFcwdRjNSr1VbHbbuZZt9JQBKv1gwjKY6BTJ99tyqZQ3
	 /Psx9qkuGFd7fSqSR79vmw6tZP52k7pfFXEW6BcWScbRQz16rH2Hdx2tToko3SipbY
	 OxGilHG3NbusF5P4iWgHVBkysxOjEKqQ+cTIIvlCxIcKBt3I9i3IFy6jE/hNaWwL0+
	 lsUWnSBoLwdqA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YcM2L6Kpzz9rxM;
	Mon, 20 Jan 2025 21:12:26 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org,  lucho@ionkov.net,  linux_oss@crudebyte.com,
  v9fs@lists.linux.dev
Subject: Re: [PATCH v3] net/9p/fd: support ipv6 for trans=tcp
In-Reply-To: <Z45L7uHk5PCbE6zG@codewreck.org> (asmadeus@codewreck.org's
	message of "Mon, 20 Jan 2025 22:13:18 +0900")
References: <20250118192122.327-2-joshuamurphy@posteo.net>
	<Z44Hk0FEm5bTx7SZ@codewreck.org> <Z45L7uHk5PCbE6zG@codewreck.org>
Date: Mon, 20 Jan 2025 20:12:24 +0000
Message-ID: <871pwx2qjb.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> There's no value in having you send a v4 just for this so I went ahead
> and just removed a couple of spaces in my tree;
> you can find the commit here if you want to check:
> https://github.com/martinetd/linux/commits/9p-next

Thanks! I=E2=80=99ll know to use checkpatch from now on.

> Thank you again, this has been on my todo list for almost as long as I've
> been cattering to this 9p client!

No problem, it was a great learning experience.

I=E2=80=99ll also look into changing the port into a proper char * rather
than it being converted, soon.

--=20
Joshua Murphy
joshuamurphy@posteo.net
