Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B61FB3EA
	for <v9fs@lists.linux.dev>; Mon, 21 Oct 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537083; cv=none; b=M52b1GIZ1gXVtGmLoTl7BnvYBNLwXIEfmTL7q0fxH4b1s7DjDitN+6V5D951PFgJcq3VWT6d2ELa/hVL8YeMAHfTdix8reow1PuQA0FbLK82NnKWgtEJuuCkXBoHf6TBLkXmYJtGEIUL0pL2vjtbaJNQ1Xsiy4phssbEAsVpNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537083; c=relaxed/simple;
	bh=PysUGtBPrSuesGgmYr6bDEcVlC+Z3tHnHKdsXTKbTwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2RpDp3V1o0dnzlPSD2UklCqXmRQvoRI4hv8X6ocgjK1vPWEL/86l1WHgxcMRW1wCKd23vzq0cQTQfK9pYLbglJFjwWuNmamRBb2xhyP1oBRQMiQgr8a7K+PGz80hsmU+VxqJm/180K8yhTyQSbUZwwJE5VgVs53gD3KAYPpFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UM2YHZur; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UM2YHZur"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso75014621fa.3
        for <v9fs@lists.linux.dev>; Mon, 21 Oct 2024 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729537078; x=1730141878; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LTRV3bBQxzuWsx6RapAOc7MDWRhOKcayDBqasSrcjC0=;
        b=UM2YHZurmNpQkQi0vcMAqdkTKMKY/p5mkzYpKcbHn+IO6yhxduTh8IHTclcDyvCSs9
         yNvmz58LmFiFp6j8x2UUi1jO8Fk+yuON6IkTqi+XDU0KkF4QlccLEKhL3x+rVuKZaub7
         XjegCkVMLKggbjxVONgrUJ2mv8HOHgkq5ycCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537078; x=1730141878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTRV3bBQxzuWsx6RapAOc7MDWRhOKcayDBqasSrcjC0=;
        b=DIulk3iWsaFBcbRacA0rnYt8x7oJs+Xn1Qu3QeoIo7gxSGuZPod6LaU8cqgEvpDzPK
         tuEwC5YrSwtHu7P8qrEnS4jCfhbmxw+6INa/pUFW5heHeM35CGxDDmKLeb3LpcpDLAOr
         2obkIuOh2UX5wlbzX5T/Z+ETVkpBmLMi9MeMRZRDf9+W4Nc0iyoPC1AGVdC6JvT3Zxr8
         OZ/IDSL7ZZFFYh64JXpmxtjtaFL04RtUus7PNxmexao5JtDNNIZ58ulDuwaz0Ci3gg+H
         vhIQp6C2OMHJYq/J19mrsQklaKoxks2n92gbE6YCySeScK3itzBJksvmqhdgSmnwcvYn
         se6g==
X-Forwarded-Encrypted: i=1; AJvYcCVnrhgQ2a60xIT8Wj0nh+5GgbLplPN+NOB1x7mAKJvD1PFSidqTCEMcqGfzdAKgRn1D+GOP@lists.linux.dev
X-Gm-Message-State: AOJu0YyA5ujF43gUS7XwYU+KRB8p3+wmpwMZcAb9lImxn08k3sF/7RDQ
	3VQ01Fq59pX0+f5UJSgKgMZYKWxOa4TXBdu9895IuihGAEdN0cj5+xOFpfbp5IFUbyE0ilRt/m4
	Uao06vA==
X-Google-Smtp-Source: AGHT+IGJJ6dfMhgntg/Ea4SzA0SP8IMRsmvbHcGsnK7d1dliLA+ACGm+Lz62JBJAYR9CjtGR+Wladw==
X-Received: by 2002:a05:651c:502:b0:2fb:8c9a:fe3f with SMTP id 38308e7fff4ca-2fb8c9b23bemr62065261fa.22.1729537077754;
        Mon, 21 Oct 2024 11:57:57 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad8de8asm5477441fa.66.2024.10.21.11.57.55
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 11:57:56 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f2b95775so5660499e87.1
        for <v9fs@lists.linux.dev>; Mon, 21 Oct 2024 11:57:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGy1MnbwQHF6GIGrUDj0asJe50z9Y/dNBIsjglq6lrQcNP09Oatit2DXHREDCYQ9lqxXiE@lists.linux.dev
X-Received: by 2002:a05:6512:3b20:b0:539:901c:e2e with SMTP id
 2adb3069b0e04-53a154eb6famr10642034e87.58.1729537074916; Mon, 21 Oct 2024
 11:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com> <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
 <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info> <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
 <ZxL3FsmjGrTT_EV9@codewreck.org> <d937fd92-249e-4660-a59a-ee85b6ec4691@suse.cz>
 <ZxafcO8KWMlXaeWE@telecaster.dhcp.thefacebook.com>
In-Reply-To: <ZxafcO8KWMlXaeWE@telecaster.dhcp.thefacebook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Oct 2024 11:57:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>
Message-ID: <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same name
To: Omar Sandoval <osandov@osandov.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Pedro Falcato <pedro.falcato@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 11:37, Omar Sandoval <osandov@osandov.com> wrote:
>
> FYI, drgn's CI started getting EIO errors from
> getdents("/sys/kernel/slab") that I bisected to this patch. The problem
> is that dev_name can be an arbitrary string. In my case, it is
> "/dev/root". This trips verify_dirent_name(), which fails if a filename
> contains a slash.

Bah. Does something silly like this fix it:

  --- a/net/9p/client.c
  +++ b/net/9p/client.c
  @@ -977,6 +977,7 @@ static int p9_client_version(struct p9_client *c)
   struct p9_client *p9_client_create(const char *dev_name, char *options)
   {
        int err;
  +     static atomic_t seqno = ATOMIC_INIT(0);
        struct p9_client *clnt;
        char *client_id;
        char *cache_name;
  @@ -1036,7 +1037,8 @@ struct p9_client *p9_client_create(const char
*dev_name, char *options)
        if (err)
                goto close_trans;

  -     cache_name = kasprintf(GFP_KERNEL, "9p-fcall-cache-%s", dev_name);
  +     cache_name = kasprintf(GFP_KERNEL,
  +             "9p-fcall-cache-%d", atomic_inc_return(&seqno));
        if (!cache_name) {
                err = -ENOMEM;
                goto close_trans;

(whitespace-damaged, but you get the idea)

                  Linus
