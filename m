Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E20288520
	for <v9fs@lists.linux.dev>; Sat, 26 Jul 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753551004; cv=none; b=Vk+PKgoiJFb3UKy4pyQbCwiPGp2I8785TbQ3nPpiRI6kuQ6wXvAkL5Dy14xuRFdoQ/fSKEAwsKSko+t8rP8tqUBMGfO+sjb1h9zqf9lUFHNMbXpNPfyeyKIasHRYKP0jcdLCM8iBwXUB++E7Kp4YjU6v45Glk6IcwgSUT4TofFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753551004; c=relaxed/simple;
	bh=5Q5aOMMIyU8OyDBv0SNjxRb1bPT39Nthf9MNrfRQ0hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrMSEn0TjAhSyuVORdsbL+18ND9qU5tR9iK0pyemBGGtK3aGd3Z9fRE6WjfSs45lqnRUzeyQoJVaTfX71UxA/UqKWd9JzAndVcooLWiH9wizfl0G1jNE+9SNf35xyGAXvJHJHarjkM1bjqhWm0h0ufCFQmDgr9Kc41ML1qm+gqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2iT63l5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2iT63l5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753551001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWNMZDxjlEXFpTT1wN0M4N9OWTREASozqQIlCLt/kBY=;
	b=B2iT63l5Ba48Ukpm2i4pfhowvWpPqb8tJpRW+Asbwa9+/HkVW0MmBHc9dsc7tscyjwi9Rz
	n+iyqSVl09R65KjU3H4TT9QmtFBZ8eKzyf8b4Q+1rrrL5DBWsBI5TjFgQ4gHqbnLXDmJES
	LhMgynMwSsqeDLcfhLgnyT6DoK3CVic=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-JS8iQiQMPe-_ttzwC7lybQ-1; Sat, 26 Jul 2025 13:29:29 -0400
X-MC-Unique: JS8iQiQMPe-_ttzwC7lybQ-1
X-Mimecast-MFC-AGG-ID: JS8iQiQMPe-_ttzwC7lybQ_1753550968
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2354ba59eb6so49932495ad.1
        for <v9fs@lists.linux.dev>; Sat, 26 Jul 2025 10:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753550968; x=1754155768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWNMZDxjlEXFpTT1wN0M4N9OWTREASozqQIlCLt/kBY=;
        b=FakjqgtAMigX39AyMJxTPQYKqE2zlgPp9DrCmNmJmiXJfO4UBaBFWalw+8P4QsXoXQ
         hd97Bt+PCASQAebWd7A9uSvPb4jlxakXWME7Qjcx9zz8zwzxsSPOOCeX65omjDvj8CYk
         lUAKBX/0uWEDzNtCjHJ6VYEbsssz1CIJX9GmyPYaVhkeZndXUj4xLftAeFuMB14etwID
         1Sr6v77jx9J9pffTuHEPgxnTBNq7Q0DOAv+rC2PpXslDM+ekF0wlD6SzsUGbVPtSa7fT
         0t3kuB4Aa2ldYvwwi6SNUlXCGxxKmefjVblYfZVsmmSVLMQBlIezIJSUAtuD4VMS5U5L
         dx1g==
X-Gm-Message-State: AOJu0YzahwgSjN+FsgPlvuY3M48XXOOE4fV6G4mTvbC8QIURXybKNIQQ
	c5pxbT5ST5PBQknaZJbTXQDW4DXLRMIpW1Kn1NFEZvKgyUKwy1muR/0hfkY7A8Lori6mbUnJZwu
	Uf8vk+Z3c5Sl87WbGwLkHT+vEOEN8MHqtwJ66wGAjqsg1LzsbXg4ya2s=
X-Gm-Gg: ASbGncumyC1gHElCbZ/jZslBebk8C6Eg8tE/P4DIaIVDLx13u/u3HHFC9LGihc2WW3b
	dO6UY2QIUnCc6WKVvFR4Kp6HQWKKKLKMMXSC9E5WWqgv8Szeyqcs7ngbtTbUHYJ6W/M1iJD8Dyi
	L27Q/VDa/iU2mai6FvSfvKQhrme2RmlJLKA1QGabXY9gDFhOvlSurshwSsRyRYnnN99QpTR8nXa
	O2NvUoLkj+xxJpNkvWJU+a816M3QSS7xIKYTsJSgR24ASk7GyOAJhM1+yrMtzQh3nQTvdFPN1Wh
	35+H5IN/ttwGxsgR7sStSQ0G5mOLjIL510NhMtNk+UReSqMO/pY=
X-Received: by 2002:a17:902:e801:b0:234:bef7:e227 with SMTP id d9443c01a7336-23fb302672cmr82320245ad.18.1753550968409;
        Sat, 26 Jul 2025 10:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq1iiQpojPxRmvAn/lUVpaHKwTEtMOXmUdh4KoL7jrx8+8u4AZb+rQVTfPu5I15fd+L5+c1A==
X-Received: by 2002:a17:902:e801:b0:234:bef7:e227 with SMTP id d9443c01a7336-23fb302672cmr82320095ad.18.1753550967958;
        Sat, 26 Jul 2025 10:29:27 -0700 (PDT)
Received: from [10.0.0.185] ([172.56.107.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff3ea7547sm3554835ad.149.2025.07.26.10.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 10:29:27 -0700 (PDT)
Message-ID: <35a300e3-d9ea-4368-a947-4d509eb414ff@redhat.com>
Date: Sat, 26 Jul 2025 10:29:26 -0700
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] 9p: convert to the new mount API
To: David Howells <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, ericvh@kernel.org, lucho@ionkov.net,
 asmadeus@codewreck.org, linux_oss@crudebyte.com
References: <20250724023325.16178-5-sandeen@redhat.com>
 <20250724023325.16178-1-sandeen@redhat.com>
 <511061.1753538965@warthog.procyon.org.uk>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <511061.1753538965@warthog.procyon.org.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xe_Sfy0Cq2iC7c1VWmbmTroh-6NDt0BQYa_i558oMWw_1753550968
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/25 9:09 AM, David Howells wrote:
> Eric Sandeen <sandeen@redhat.com> wrote:
> 
>> +	case Opt_uname:
>> +		kfree(v9ses_opts->uname);
>> +		v9ses_opts->uname = param->string;
>> +		param->string = NULL;
> 
> I wonder if it's worth using swap() for that:

ok. Sadly I've used the above pattern a lot in other patches ;)

> 		v9ses_opts->uname = swap(param->string, NULL);
> 
>> +		if (strcmp(s, "user") == 0)
>> +			v9ses_opts->flags |= V9FS_ACCESS_USER;
>> +		else if (strcmp(s, "any") == 0)
>> +			v9ses_opts->flags |= V9FS_ACCESS_ANY;
>> +		else if (strcmp(s, "client") == 0) {
>> +			v9ses_opts->flags |= V9FS_ACCESS_CLIENT;
>> +		} else {
> 
> Maybe put braces on all the clauses in that?

Ah, sure.

>> +static void v9fs_free_fc(struct fs_context *fc)
>> +{
>> +	struct v9fs_context *ctx = fc->fs_private;
> 
> I would check that ctx isn't NULL.

ok.

>> +static int v9fs_init_fs_context(struct fs_context *fc)
>> +{
>> +	struct v9fs_context	*ctx;
>> +
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	/* initialize core options */
>> +	ctx->v9ses.afid = ~0;
>> +	ctx->v9ses.debug = 0;
>> +	ctx->v9ses.cache = CACHE_NONE;
>> +#ifdef CONFIG_9P_FSCACHE
>> +	ctx->v9ses.cachetag = NULL;
>> +#endif
> 
> You used kzalloc... ;-).

Oh, fair enough.
 
>> +err_names:
>> +	kfree(ctx->v9ses.uname);
>> +	kfree(ctx->v9ses.aname);
>> +	kfree(ctx);
>> +	return -ENOMEM;
>> +}
> 
> Instead of doing the freeing, you could just set ->need_free and if
> ->init_fs_context() returns an error, the context will be put and that will
> invoke ->free().

Ah ok, I don't think I knew that was an option. Will look.

The kernel test robot had a lot of complaints about this series, will dig
into those as well.

-Eric

> David
> 

