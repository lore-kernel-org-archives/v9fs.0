Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C723803C5
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379997; cv=none; b=fgcbwXjrvn5q1RkxQxYYhR17WjS7VTs+AkjyEXIQcHEGYrS0aGV/3k07bDi50dx+e1sBeTjcIDI5ANAUjX4FjQnnbsZQEmW/+st5q5R6c6XiwFCp2ajQVtm+i2+SGqIDTIuqTsv/dS7JzJ8duEsPgOT3f2/y2q647Pzvqtr2QcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379997; c=relaxed/simple;
	bh=7F5uEZdyjz/uhVzwQYFym6Br8RgaJkVNP4y9m1xkTcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8Gs2+8oS7lOwcL1po7ZQf/XH2TS1sX2pHkvDk8FkTK1RNCUYga5pr3ITFfAPxGsG0GBaUTDet0X8kACOrDRTqkWVg5K29MksTyp1Oz4FnCpDxbWRJViUO/cqQuvOL82eP4qHfJFmca9TTNtGi8JE6yyni3VSZpslgWjKCcmud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=HbKedHv8; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="HbKedHv8"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0CF1814C2D6;
	Fri, 17 Apr 2026 00:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776379991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMyzhFVhqlw5BIjRticIUobVMjZqkatcay7qPAlCi6Q=;
	b=HbKedHv8d20j0+oxI9um/y0j575UUzemiVaixwoxfz0I/55uDiXEC8go4CX4D7ZWxssjZC
	kkFETtOw9STe9JZBF/9l3EVQVGqxUx42NnJ1fwsd/VF1nBmqLqvL57mAwPhRdPbZuCm5Xu
	XZGxNZHoYWyHKfsr6zDyFGIUGNTj6v7Kvr7/vBG5Dk071PMnuaogIbqDxJh254uABswJAr
	ZFw4WOcyZFMq3XBLC+yLzRgcSfbbs9+dxkSLhUM4pbBv3LcRoynRK9WT6OGdfF7QPidwY5
	qA+OTeiMHvkeT09rLmW8qx5cJd+thzCa8HY7obfvxxaQgr2TwYbBVj4LKwVP4w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 6c1dbacf;
	Thu, 16 Apr 2026 22:53:07 +0000 (UTC)
Date: Fri, 17 Apr 2026 07:52:52 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal
 signal
Message-ID: <aeFoRIOUNQZWmTG5@codewreck.org>
References: <20260415155237.182891-1-kovalev@altlinux.org>
 <aeA-WpUyfWrYrvaE@codewreck.org>
 <e3e9146a-d820-d35d-cebd-e7e7e4a2fa24@basealt.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3e9146a-d820-d35d-cebd-e7e7e4a2fa24@basealt.ru>

Vasiliy Kovalev wrote on Thu, Apr 16, 2026 at 03:49:59PM +0300:
> > It's unfortunately not that simple, just leaving here will leak things.
> 
> Following up on your concern about leaking things (as mentioned in the
> thread with Shigeru Yoshida's patch) - I did some tracing with `printk`
> inside `p9_req_put` and `p9_tag_remove` to see exactly what happens to
> the request lifecycle with my proposed patch vs Shigeru's approach:
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 748b92d3f0c1..4e8f4e0195b4 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -274,10 +274,13 @@ static void p9_tag_remove(struct p9_client *c, struct
> p9_req_t *r)
>         spin_lock_irqsave(&c->lock, flags);
>         idr_remove(&c->reqs, tag);
>         spin_unlock_irqrestore(&c->lock, flags);
> +       printk("tag %d removed from IDR\n", tag);
>  }
> 
>  int p9_req_put(struct p9_client *c, struct p9_req_t *r)
>  {
> +       printk("p9_req_put req %p tag %d refcount before=%d\n",
> +         r, r->tc.tag, refcount_read(&r->refcount));
>         if (refcount_dec_and_test(&r->refcount)) {
>                 p9_tag_remove(c, r);
> 
> There is a significant difference.
> 
> If we use Shigeru's approach [1] (preventing the flush from being
> sent/processed using `!fatal_signal_pending(current)` in the condition),
> the original request (tag 0) is never freed from the IDR. It creates a
> definitive memory and tag leak:
> 
> [root@localhost]# ./repro
> executing program
> [   50.613200] p9_req_put req ff11000110157cb0 tag 65535 refcount before=3
> [   50.663513] p9_req_put req ff11000110157cb0 tag 65535 refcount before=2
> [   50.665156] p9_req_put req ff11000110157cb0 tag 65535 refcount before=1
> [   50.666593] tag 65535 removed from IDR
> executing program
> [   50.688232] p9_req_put req ff11000110157ba0 tag 65535 refcount before=3
> [   50.739634] p9_req_put req ff11000110157ba0 tag 65535 refcount before=2
> [   50.741170] p9_req_put req ff11000110157ba0 tag 65535 refcount before=1
> [   50.742587] tag 65535 removed from IDR
> executing program
> [   50.775708] p9_req_put req ff11000110157a90 tag 65535 refcount before=3
> [   50.825104] p9_req_put req ff11000110157a90 tag 65535 refcount before=2
> [   50.827719] p9_req_put req ff11000110157a90 tag 65535 refcount before=1
> [   50.830432] tag 65535 removed from IDR
> executing program
> ...
> 
> [1]
> https://lore.kernel.org/all/20260322111848.2837057-1-syoshida@redhat.com/
> 
> However, with my patch (jumping to `recalc_sigpending` *inside* the
> `P9_TFLUSH` wait loop), the logic works cleanly due to the `refcount`
> mechanism:
> 
> [root@localhost]# ./repro
> executing program
> [   48.875093] p9_req_put req ff110001056fdcb0 tag 65535 refcount before=3
> [   48.925981] p9_req_put req ff110001056fdba0 tag 0 refcount before=3
> [   53.873969] p9_req_put req ff110001056fdba0 tag 0 refcount before=2
> [   53.876638] p9_req_put req ff110001056fdcb0 tag 65535 refcount before=2
> [   53.879882] p9_req_put req ff110001056fdba0 tag 0 refcount before=1
> [   53.882505] tag 0 removed from IDR
> [   53.884184] p9_req_put req ff110001056fdcb0 tag 65535 refcount before=1
> [   53.886905] tag 65535 removed from IDR
> executing program
> [   53.914764] p9_req_put req ff1100010ca97a90 tag 65535 refcount before=3
> [   53.967191] p9_req_put req ff1100010ca97980 tag 0 refcount before=3
> [   58.909626] p9_req_put req ff1100010ca97980 tag 0 refcount before=2
> [   58.912420] p9_req_put req ff1100010ca97a90 tag 65535 refcount before=2
> [   58.915358] p9_req_put req ff1100010ca97980 tag 0 refcount before=1
> [   58.918478] tag 0 removed from IDR
> [   58.920730] p9_req_put req ff1100010ca97a90 tag 65535 refcount before=1
> [   58.923715] tag 65535 removed from IDR
> executing program
> [   58.946905] p9_req_put req ff1100010c5a3870 tag 65535 refcount before=3
> [   58.998260] p9_req_put req ff1100010c5a3760 tag 0 refcount before=3
> [   63.945960] p9_req_put req ff1100010c5a3760 tag 0 refcount before=2
> [   63.948549] p9_req_put req ff1100010c5a3870 tag 65535 refcount before=2
> [   63.951153] p9_req_put req ff1100010c5a3760 tag 0 refcount before=1
> [   63.953651] tag 0 removed from IDR
> [   63.957254] p9_req_put req ff1100010c5a3870 tag 65535 refcount before=1
> [   63.960655] tag 65535 removed from IDR
> executing program
> ...
> 
> 1. The dying thread breaks out of the loop and calls `p9_req_put()`.
> The refcount correctly drops from 2 to 1.
> 
> 2. The tag is NOT removed from the IDR yet, preventing any Use-After-Free.
> The request is safely "orphaned".
> 
> 3. Shortly after, when the parent process closes the pipe/socket (or the
> transport is torn down due to process exit), the transport layer cleans up
> the pending requests. It calls the final `p9_req_put()`, refcount hits 0,
> and the tag is properly removed from the IDR.

Thanks for taking the time to verify

So if I understand this right, with a sane server, the tag will be used
until umount or a reply (to either the flush or the original request)?

That sounds sane enough (and definitely better then Shigeru's patch)

> Since this safely resolves the permanent D-state hang during
> `coredump_wait()` without causing the UAF or leaks that plagued earlier
> kernels (pre-`728356dedeff` ("9p: Add refcount to p9_req_t")), do you
> think this pragmatic fix is acceptable for mainline and stable?

I'll need to find time (or someone) to perform some heavy tests with
this -- basically my problem is that these hangs are easy to test with
syzcaller but these are not ever supposed to happen with a real
(correct) server, so while I agree not having stuck threads would be
helpful to improve test efficiency I don't see it as a "real" problem
(as in, 9p mount is a privileged operation, so normal users aren't
supposed to mess around with a pipe/fd mount like syzcaller does)

Basically I'd want to "just" mess around with a real system on a 9p
mount and play with ^C/sigkills and see what happens, but I don't have
time for that short term, so this will likely be a few months

>  While the ideal long-term goal is the asynchronous implementation (as
> seen in your 9p-async-v2 branch [2]), this patch serves as a reliable
> intermediate solution for a critical regression.
> [2] https://github.com/martinetd/linux/commits/9p-async-v2

iirc one of the problem with the async branch is that the process would
quit immediately on, say, ^C, before the IO has completed, but it's
possible for the server to process the IO (and not the flush) afterwards
and you'd get something that's not supposed to happen e.g.

p1             p2

write(1)
^C/sigkill
flush sent but process exit without waiting for server ack
               1 not written yet
               write(2) in same spot
               write(2) done
write(1) completes
data isn't 2 as expected after p2 completed


So it's quite possible async isn't the way to go, but that there is no
good solution for this
(given this is true even without async on sigkill: if we have something
that works safely, there's no reason to wait only for non-fatal signals...)

> > (By the way, what's with the rekindled interest on this?...)
> > 
> 
> The issue was identified by Syzkaller, and I have a stable C reproducer
> that consistently triggers the hang. There is also a similar report on
> Syzbot with a nearly identical reproducer:
> https://syzkaller.appspot.com/text?tag=ReproC&x=156aa534580000

Yes, it's been a known problem since syzcaller started testing
9p... many years ago.
Back then requests didn't have a refcount, so it's quite likely nobody
looked hard enough after this became possible.

Thanks,
-- 
Dominique Martinet | Asmadeus
