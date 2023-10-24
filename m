Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08514A8F
	for <v9fs@lists.linux.dev>; Tue, 24 Oct 2023 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UEC5N4Zh";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="mhie8GGa"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 173DCC01D; Tue, 24 Oct 2023 09:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698133490; bh=k4l5me87UyJdn/SX3+43Lrzcu2MLLMcAwllwxSbsoL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEC5N4Zh4ATofje+sxzbEpTJgeZixGn50DNgKpy1ub3fLdu1npot/NBJSbDgwwREH
	 iweZGJVdveOSkdXke0nLIMcqi0Dr+TivOGcyYqj1m1fjYOht4yjG3orqC7u35S0Qoc
	 frl7s2oZ+y73W6QzSVoH+BZBazJKkh7b/7ebKqbB+OxdS8OIIUJMsoh4roKN8Wqznp
	 m1owsZsVIOOyi9gPFhTGzQpLmQVrn3Uh9vZhzTV8iP/MnN8OCQXbimKNLKsviT9SRU
	 ynueKC+XYQ58rc+xZs/hsqIA4Ho1MaBOi+717NYFe5Npcuu/TvPLdZGniilJDfADmU
	 AHaAGyqwUUJrA==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 4627DC009;
	Tue, 24 Oct 2023 09:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698133489; bh=k4l5me87UyJdn/SX3+43Lrzcu2MLLMcAwllwxSbsoL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhie8GGazbK3MRGH2L88sLZ6+aAAOdoS3Rf+xMuEdA8oWKJhSY+3TWN5rIb+haARI
	 Z2sG67rpjvZdKg3p4qsCIYX5Gn3IQx1Uu4rLnxhN2EiekdveDjKrk1R76BDyefPAjG
	 DdN7AREO8nPtb5J88i+BMEjZUgI981s12mMixYVReh1GEaPyGQvezaNg1UE4Mqo32+
	 Ef0RaAOj13naAxrogh7oUpVzkJtM83opsU9rG6jxnXfwmJWtC82aQPWFUR0XJ0P12w
	 f+MO1DO/W/MmLcrvvc+dScpIHSrN0O8G5sHGI/YFf9DQlkuLqOsgqYGzL6SYO0HdqP
	 NQL/v4zICGoSA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 8d12950e;
	Tue, 24 Oct 2023 07:44:44 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:44:28 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Marco Elver <elver@google.com>
Cc: v9fs@lists.linux.dev, ericvh@kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net, linux-kernel@vger.kernel.org,
	syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/3] 9p: Annotate data-racy writes to file::f_flags on fd
 mount
Message-ID: <ZTd13Eh1ryuyQqyr@codewreck.org>
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
 <20231023233704.1185154-2-asmadeus@codewreck.org>
 <CANpmjNOUSci41NssMKgrNjC5P0doPWPekiizMOfjrr11CV-ogQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNOUSci41NssMKgrNjC5P0doPWPekiizMOfjrr11CV-ogQ@mail.gmail.com>

Marco Elver wrote on Tue, Oct 24, 2023 at 09:12:56AM +0200:
> > diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> > index f226953577b2..d89c88986950 100644
> > --- a/net/9p/trans_fd.c
> > +++ b/net/9p/trans_fd.c
> > @@ -836,14 +836,16 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
> >                 goto out_free_ts;
> >         if (!(ts->rd->f_mode & FMODE_READ))
> >                 goto out_put_rd;
> > -       /* prevent workers from hanging on IO when fd is a pipe */
> > -       ts->rd->f_flags |= O_NONBLOCK;
> > +       /* Prevent workers from hanging on IO when fd is a pipe
> 
> Add '.' at end of sentence(s)?

I don't think we have any rule about this in the 9p part of the tree,
looking around there seem to be more comments without '.' than with, but
it's never too late to start... I'll add some in a v2 after we've agreed
with the rest.

> 
> > +        * We don't support userspace messing with the fd after passing it
> > +        * to mount, so flag possible data race for KCSAN */
> 
> The comment should explain why the data race is safe, independent of
> KCSAN. I still don't quite get why it's safe.

I guess it depends on what we call 'safe' here: if we agree the worst
thing that can happen is weird flags being set when we didn't request
them and socket operations behaving oddly (of the level of block when
they shouldn't), we don't care because there's no way to make concurrent
usage of the fd work anyway.
If it's possible to get an invalid value there such that a socket
operation ends up executing user-controlled code somewhere, then we've
got a bigger problem and we should take some lock (presumably the same
lock fcntl(F_SETFD) is taking, as that's got more potential for breakage
than another mount in my opinon)

> The case that syzbot found was 2 concurrent mount. Is that also disallowed?

Yes, there's no way you'll get a working filesystem out of two mounts
using the same fd as the protocol has no muxing

> Maybe something like: "We don't support userspace messing with the fd
> after passing it to the first mount. While it's not officially
> supported, concurrent modification of flags is unlikely to break this
> code. So that tooling (like KCSAN) knows about it, mark them as
> intentional data races."

I'd word this as much likely to break, how about something like this?

	/* Prevent workers from hanging on IO when fd is a pipe.
	 * It's technically possible for userspace or concurrent mounts to
	 * modify this flag concurrently, which will likely result in a
	 * broken filesystem. However, just having bad flags here should
	 * not crash the kernel or cause any other sort of bug, so mark this
	 * particular data race as intentional so that tooling (like KCSAN)
	 * can allow it and detect further problems.
	 */

Thanks,
-- 
Dominique Martinet | Asmadeus
