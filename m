Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC218DB0D
	for <v9fs@lists.linux.dev>; Mon,  8 Dec 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214486; cv=none; b=rkTUKwJgT4EhH2S67j8FDUX2g9n6yXyDhA379QjhK87UVCW7oEF4bTQlnJTZoyUIr+jczS1rwX82j1oFnLfCh0tdoug4oKtfcEAIfCSzfrTUF6O43mp76hi6I1tJ/j8x20xys9yGFbA5qAiflsUCcXmMrpjnNyWpT1VqWHx/xPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214486; c=relaxed/simple;
	bh=58IBorTfmU4uDxhBSWnSUuJZWpGW4TpbGkMXG7s3Rek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7PEGqqKTVL0SSNyHZ9lNMjLetXK/34JYW/5H1atnkIFlakguoKlRMq9dOlgEwUiDU+1rZ5tLAcjeWSbmX1p8F8A8qjmAIXntQQQ0lwZx1GhHBi7elP6k0xGjrtFrpHlT692JHZh5WsSRZHgvOtZJVfyuBuVbj42vyMh9Ko2HGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Hewqdjvu; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hewqdjvu"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3f551ad50d1so557922fac.0
        for <v9fs@lists.linux.dev>; Mon, 08 Dec 2025 09:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1765214484; x=1765819284; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhPMrWpz1eQdpSXVpfBQ716e8Gxsn6bVq0Q9mSHX8u0=;
        b=HewqdjvuEJpGNj6w7EBBVYIv+0UJttV9QLiYEgg80dnXiE2upLbi6CF6emRQA1jLkn
         QNvcKYouu+8FiRBfpxF57Icqp7dkiIOSMO0g1ALWRKMPrbL6lKt93KTEiFnzHm1dnFoj
         2utGbLJ+oXUpCYAzJ0mtg4daj7jqzoQfhmtqSck2b7TBMHRjPCci8V9ygCThgxCYbSVA
         l3QmCCGl8RHadSsjoLY/tn7bWPe+Wl/5k6cJ+B/lC6R7ndYMFDMBes5JmwJQco3WD+RP
         dzhh8AXacefyz7vtZ9wuvut8zqTWip1l7UneT1PWFsSEco5qYvPXSMul3EyFg5ls1iFL
         16cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765214484; x=1765819284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhPMrWpz1eQdpSXVpfBQ716e8Gxsn6bVq0Q9mSHX8u0=;
        b=EgA62rC/LfybAnpfWJHyLlWUPmXDYovWkmMpVwKp+uI80zByHXf6zdHzZI5R0K9d5r
         Vv6ryvlE2KtsNbZOKOhIpGUSdxwF0Basd2klNcDOInDlYYCcE0WSP3sGEkV6Pkt3wpur
         X2OqAKmWrGgUlZEshnuSfRuUw1166SlX4gBRngMN/7sX5EWhkvMWVGCVeY95LTCAP0VP
         YPUBADHmaHpL6ULd3EE2AtVDUn+E/8alaP4CogNSPg31uv4I5fqhCDG7hYQnP56S9cc1
         SoTfpKRLVZ7QmcF4aVMeAL4IqS1IqaJbH+AzhEfrE3INu9mOmh/W3n1q2lFU1MM5+x7V
         khUw==
X-Forwarded-Encrypted: i=1; AJvYcCXYE6btCCahjIsHc6JAIwZaq/vOvy42eIHkzmWFSgcOoKRK3nNCNxN46SMlKqJ41IIs4F4W@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh3AYEoz4m1i5rtH3AEtfx09eJTi+f0Oif9L8CYwYop7lvtT7/
	yghhRPaxYn09Y8w6tbVgZcNAW8OixU9TKBMPl1hSRiV5L4aJzFvRI8wLWz5fjq59Q7I=
X-Gm-Gg: ASbGnct8pMsDC3hL5pzbJf/VhjFc+3KMmRyj39VyB7X1+czJZItijOq5gC3cZ40jzeA
	FkHktjFjsogOr7W1LmdqxK7uWDztWTt1mw7shfDQdAj+Qf21uVHlCCoBct39HmcDJyMgIdgUaf9
	vyfm6xOOIyX6T34a8ZiKVm5rjBJTlN2yDIyRVxYgvTm1LInbcGpPAzd9nffcwPpdskcvoAG9cbl
	8ZG5ZrSRK9moeCBmSq8awXc0c6MZ+sClgm0n3V6DySx5FQGD8kEYHCH2wtHhL7xwN8YFOrecqMi
	0iJ0Eqlzhf6SKoy1fEDLpoQBiWsUWPaoqUaPZsfI0R5GYwhIOfaW1mkDrzWh/gpwBQbn53hI4Za
	XEUr/2nTX42upGFJ3hW4Z/UwfCSZkKKgvlNFCqcDhF3+ZbrineTai/66Vp+N/lBlzpug0+1Q=
X-Google-Smtp-Source: AGHT+IECgGHbNEhUfjt57ooHzsGKSD3RZhEl51RBJQ/aq3BU3oY5jPZpKWy80c6MtcCdkgMJ57fipw==
X-Received: by 2002:a05:6870:c191:b0:3ec:3d84:3c51 with SMTP id 586e51a60fabf-3f544194db0mr2994393fac.49.1765214483639;
        Mon, 08 Dec 2025 09:21:23 -0800 (PST)
Received: from 861G6M3 ([2a09:bac1:76a0:540::22d:109])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50b5ed5a7sm8916428fac.22.2025.12.08.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 09:21:22 -0800 (PST)
Date: Mon, 8 Dec 2025 11:21:17 -0600
From: Chris Arges <carges@cloudflare.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Howells <dhowells@redhat.com>, ericvh@kernel.org,
	lucho@ionkov.net, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: kernel BUG when mounting large block xfs backed by 9p (folio ref
 count bug)
Message-ID: <aTcJDS67sks7KoY0@861G6M3>
References: <aSR-C4ahmNRoUV58@861G6M3>
 <5945634.DvuYhMxLoT@weasel>
 <aTLYEF4ZaTwF3tdL@codewreck.org>
 <2245723.irdbgypaU6@weasel>
 <aTLix4bcHo_XDXpf@codewreck.org>
 <aTUqKudyHxilbBpL@casper.infradead.org>
 <aTWF6xnCe1sSA8gQ@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTWF6xnCe1sSA8gQ@codewreck.org>

On 2025-12-07 22:49:31, Dominique Martinet wrote:
> Chris,
> 
> I'm not sure why but I can't reproduce with your .config either :/
> If you can still reproduce this reliably, could you try with the
> following diff applied (which is basically the same as what Christian
> suggested a couple of days ago with also ubuf, whatever that is)
> ------------
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 10c2dd486438..f7ee1f864b03 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -318,7 +318,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>  	if (!iov_iter_count(data))
>  		return 0;
>  
> -	if (!iov_iter_is_kvec(data)) {
> +	if (user_backed_iter(data)) {
>  		int n;
>  		/*
>  		* We allow only p9_max_pages pinned. We wait for the
> -----------
> 

Dominique,
I can still reproduce this easily. If I apply this patch, I no longer get
the crash. If this patch ends up being applied feel free to add:
Tested-By: Chris Arges <carges@cloudflare.com>

Happy to test other iterations as well.
--chris

> 
> 
> Willy,
> 
> Matthew Wilcox wrote on Sun, Dec 07, 2025 at 07:18:02AM +0000:
> > In readahead, we allocate a folio, lock it and add it to the page cache.
> > We then submit it to the filesystem for read.  It cannot be truncated
> > from the page cache until the filesystem unlocks it (generally by calling
> > folio_end_read() but some filesystems explicitly call folio_unlock()
> > instead).  So you don't need to take an extra reference to it.
> 
> Thanks.
> 
> My main problem with this all is that trans_virtio adds the buffers to
> the virtio virtqueue but does nothing to take it off if
> wait_event_killable() in virtio_request() gets killed, but looking at it
> even in the code path that gets a ref the code will happily drop the ref
> even before the flush is over so I guess there's no reason to actively
> try to pin kernel pages...
> 
> I'd sleep better if there was a way to remove (detach?) the buffer from
> the virtqueue but I can't see how to do that without breaking something
> else, so I guess we'll have to live with that behavior unless someone
> knows better.
> 
> -- 
> Dominique Martinet | Asmadeus
