Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E411CF5E1
	for <v9fs@lists.linux.dev>; Mon, 21 Oct 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541169; cv=none; b=NKFGdt/5QsmhBXMk4yC195F1YO2c2vxXaXf4+9I+8USJga5uBHmpcDmc9HnTd/7yba/zeUamY+ywLdgx8DKY5vTrBE74n+l3RS3XxbLcuFXeSxcp186hskpwoa5cljWbKqxzofnCSe6NIIX+ucOJ8wOYBiw2gV9gC85JLqVL2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541169; c=relaxed/simple;
	bh=YSKw6jb8QPWFx83Peoso5ccFLz73UcVx429F0xZ3Ez0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCxVs3pSWTtmtkBVEQ4Ryyr7vhGhr7FZkKvdhwCqGw4TB51YwzKksov/ZPXDEUwfvtePGFWet8l74YGodra/Wz7Fjlh7uhmJib95nPtmm7Y1VDXfNouTWgNZPXaNoDaWy5w4pC1TAUXePW5ZnhEvW33MWfvMSt0uQMpYQe7B+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=NCK4NPC3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="NCK4NPC3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca17bf0d9so3570145ad.0
        for <v9fs@lists.linux.dev>; Mon, 21 Oct 2024 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1729541166; x=1730145966; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrqqRk6hzjGWjq29e3qz8ttMOlAUA5wKTrVPk+XCY4w=;
        b=NCK4NPC3cuUl2LVfR0ichufGaLb4JCfZQYcK6Oa0yrlfv/eHhku51Z+1RUjOQHobPw
         V7/hR9Xk0mxw5rHigtXipyG8Zm2DCIJXC3h5KCcn9O3/FzGsuvZ0uCdTXptQT0+v039/
         Ox7opOA1DGfllt9kxUW+7baF6Ye/2M7m50KuL0Ta21aB/AJrgZemIRTJW6nE67hvcbOc
         lFq0yN4GeZYgF36mVN3fbjmtWBTnrP6Bb01/XLHCb+92n7eEXMkh1w0DFKewm3OlifiL
         BO1aaHvE0pTunTVZfMOt2jjEP2u0wW7OAouzrYtOSjQ5C0kr/5z+IsHx9nT0JNvSqvVi
         cEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541166; x=1730145966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrqqRk6hzjGWjq29e3qz8ttMOlAUA5wKTrVPk+XCY4w=;
        b=g5kfmyg7g+8d4KgxRHkE4V3zc1CAS1o5pjhMj/WSHEr9FMrGVaHm08g2Qaiydev0Tb
         Dvzsz3G5KOIHJO1eZeQqpXz/sDYRT7wpI+tYeECOxJhHXjiuxMnzVhNmw+BjdAUl7LiU
         G1pdF/G9B7+WfZl4IPWK8SKF44Vp3fEC9OiUVEbpOBhGIe6Gh8cFqPHJENUvkWyzZmWQ
         EyNRHPO1tCciimO9k5Gcskh0LlyQUu+ZFpGSPzm3H6Z18XiNQsRaKDFGcLvPm1AEB/IO
         ITAtdtyreK6jjM5kMguYbWsLaEDP/RNW1j7ExO2l9EHDBTV+KY5O95BrM+d8eTyLHd/q
         agpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQDKv7gYvpisN2+sBb+i+l3DxDagYG0Uy00cAI+lKPlssnVUGcd/vq8Od66oPgB5WyxflE@lists.linux.dev
X-Gm-Message-State: AOJu0YxuFf1f598Bl/YoQAa3kLJ3FQSkfCPSEfj1s6bikuLoKYn7G3Up
	3L/UIz5CGiWh6mHf2+daTPkIYsTWGNnan1K8rMmDstuugYoTyaq7DvBJ9tHcarg=
X-Google-Smtp-Source: AGHT+IGw0pHFBO2qR1RMPMHDvfyXxvAHkrtR735iXBeKZTTZs8ZlsbDet6VFNPejquCo5hRUYsh0lg==
X-Received: by 2002:a17:903:2309:b0:20c:6bff:4a26 with SMTP id d9443c01a7336-20e5a9601e1mr67498045ad.15.1729541166558;
        Mon, 21 Oct 2024 13:06:06 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::7:4942])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee3c7dsm29769045ad.35.2024.10.21.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:06:06 -0700 (PDT)
Date: Mon, 21 Oct 2024 13:06:03 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same
 name
Message-ID: <Zxa0K-4mhSI91S-w@telecaster.dhcp.thefacebook.com>
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com>
 <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
 <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info>
 <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
 <ZxL3FsmjGrTT_EV9@codewreck.org>
 <d937fd92-249e-4660-a59a-ee85b6ec4691@suse.cz>
 <ZxafcO8KWMlXaeWE@telecaster.dhcp.thefacebook.com>
 <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 11:57:38AM -0700, Linus Torvalds wrote:
> On Mon, 21 Oct 2024 at 11:37, Omar Sandoval <osandov@osandov.com> wrote:
> >
> > FYI, drgn's CI started getting EIO errors from
> > getdents("/sys/kernel/slab") that I bisected to this patch. The problem
> > is that dev_name can be an arbitrary string. In my case, it is
> > "/dev/root". This trips verify_dirent_name(), which fails if a filename
> > contains a slash.
> 
> Bah. Does something silly like this fix it:
> 
>   --- a/net/9p/client.c
>   +++ b/net/9p/client.c
>   @@ -977,6 +977,7 @@ static int p9_client_version(struct p9_client *c)
>    struct p9_client *p9_client_create(const char *dev_name, char *options)
>    {
>         int err;
>   +     static atomic_t seqno = ATOMIC_INIT(0);
>         struct p9_client *clnt;
>         char *client_id;
>         char *cache_name;
>   @@ -1036,7 +1037,8 @@ struct p9_client *p9_client_create(const char
> *dev_name, char *options)
>         if (err)
>                 goto close_trans;
> 
>   -     cache_name = kasprintf(GFP_KERNEL, "9p-fcall-cache-%s", dev_name);
>   +     cache_name = kasprintf(GFP_KERNEL,
>   +             "9p-fcall-cache-%d", atomic_inc_return(&seqno));
>         if (!cache_name) {
>                 err = -ENOMEM;
>                 goto close_trans;
> 
> (whitespace-damaged, but you get the idea)

Yup, that works here.

Tested-by: Omar Sandoval <osandov@fb.com>
