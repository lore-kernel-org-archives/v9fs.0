Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2D30FC29
	for <v9fs@lists.linux.dev>; Wed,  4 Mar 2026 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592169; cv=none; b=HtkjhPnla1J+TtuBPJJQEVcPDyXKLEjJcVbhTo8LmrvkTYPkCB6rSVho02eaC5SBLkCJrPT7Q63cSl6CkxIF+QEA7a1gqAv8UJnja8+LT3Kk0aCTEJgEELwTeWJHXLZkVKd5zrSjTcLEATEgyogbYL/L+FGYX0HBDk2I0PSMUlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592169; c=relaxed/simple;
	bh=/XWSBClgiVO9Y8DcC9EFb3ReAwqS4B91iVSCE58gCGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFgWXejhRUPVtTic+UaI2RIeutxNZg68uFbxiK7HtqnSlmVj5qDJ+6nTJFPMFgK+D0Qa1qio4mcKbSFs3+Cs98B/EJkjqclj/NUmUOBjprMUhUSAgzoGc+jneov3annsABFCGDfKAB5YHIxQyqYG6WAv+B26LpGw61oRz9kdzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nbav31ex; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nbav31ex"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d18d0e6d71so4951771a34.1
        for <v9fs@lists.linux.dev>; Tue, 03 Mar 2026 18:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772592167; x=1773196967; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7dycZCW1i0wVXbu5i6p68JSQ3h2ubeTDMrk86ISU5M=;
        b=Nbav31exD7HLV6PCQmiFnHsu5gRGCz2+J4y84DgkIt2MG/E12ss68Y2SJ5tdwAe9z/
         Xc56LkZJyOhw9ybuaODe8g+P6fcWLuww66LgNMNXz33Ad7Vz58311tTNMhugabhXwXT4
         8aQoD8PfnozrmMb9neJwXJqyUJ0CO4PzQG0oJJcb6GtEWSkv2F6eFUfHWxEbgX9EcF6W
         tC4I6FZ1drXPSVWTDl3jEDojIjG5iGj6RuznvOcvueMQu52iiuO/28c/wMSDpcCTh/cR
         CKUXrJ/XULI7cugDSaY/8PXNtKkXJTa7YE+hUiOImR9Qy9uAWn3qEqrSjyNuYfjPPHBM
         vnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772592167; x=1773196967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7dycZCW1i0wVXbu5i6p68JSQ3h2ubeTDMrk86ISU5M=;
        b=R32uo9aUWUyubcWhkYibvcndYN7LbQlTJDUKp+ewb/IYNcvrmb5738ivUCnF8Mp1YC
         O8/0nl/oZ0/Bwwoz4W5DbSqstuXTm8h0AWAdd5OJ97nRl9gMLrP6wecQBLkwzkLrBWwG
         OXwpW3rdQ1DZV2diZc3FJqLjc0M6TT1H6VDmb3XoewqL9Kyc22KV51pyjSFhrNHTnJks
         be0wbqHl6djyNrypsrbFcP00HGAuGjly/7n8EJsJj8wLP7zg+yA0rN0m4S5p+GHZOzsV
         dcN1jxmQ1yeXwtTAF0t7Srg0Rf1283RZGnDiqZ8D5lxOdp/rEFf5Y13xINd5vlbht9og
         cEIw==
X-Forwarded-Encrypted: i=1; AJvYcCX+NdhewXnvUHdP4ns8PgCWOgsC98GffhSXhgTXsKooffVtDTlz79a22BcdgEwNPBNYFfpe@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8OFFCH2a/aOOYQ0OkYEbzDJz/wIKHVaH2ZnoqktAZy7zqn+ze
	6XNuEI7KCZb8cfbeNl2lY1jAea+fauwm0sMOKT1UJ7NTJEEeKHaizDdG4K89YUKDw9Y=
X-Gm-Gg: ATEYQzwxzysulCkPykQSrkuXccx7sa3qIql10NsITnTd97Vzi3NnWP6lag3u/GuvKWy
	cj6bT5rZsq6u/tsN0V0Er24BzYG6r5j3GGwFxGO7gFbhgb/wV7+8oLX/+tgycfqv5KCzgBd9QM8
	4yc040c/i7M6Qq4oiW8TSAk9gX3SzMSspfTkkNdEh27xV0PVj7Xo5wudbrAu5gnkVl4J+9s/DYC
	2ACFfyTyQZ/vj1PvrwJlkBvdUYlG2V+iv0be9M/dMxtIRW/ACLhcUpiqKGLR+kyCAIk5AW/wCtM
	SmmyMmjQXrRXwNJRZFew2ZTFr+sdEk0dqTPQWHFp16+HXMjoRlrKsPp5JNCjazoX68bTrX8X0Qt
	QwLLsGJh2KZzvUjw+qACugDdAaGWvJSLMH4UaZ0Z8P2hqHuMB4mZDmOeSuPKc2p9gUQPoeYLekk
	od5zy2KQrI4AjA5ELZjh74t4nM8IhyTD2jKoJ9IroKgKs16MxgKvPHbyzalu8V2lNoY05ZBVs1V
	Ji++UVwTw==
X-Received: by 2002:a05:6820:4a8e:b0:66a:1886:e4bf with SMTP id 006d021491bc7-67b17703546mr346906eaf.22.1772592166871;
        Tue, 03 Mar 2026 18:42:46 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm12574800eaf.7.2026.03.03.18.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 18:42:45 -0800 (PST)
Message-ID: <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
Date: Tue, 3 Mar 2026 19:42:40 -0700
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
To: Jakub Kicinski <kuba@kernel.org>, Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck <alexanderduyck@fb.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Carlos Maiolino <cem@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Yu <chao@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Latchesar Ionkov <lucho@ionkov.net>, Linus Walleij <linusw@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>,
 Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Sean Christopherson <seanjc@google.com>, Simona Vetter <simona@ffwll.ch>,
 Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zheng Gu <cengku@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 dm-devel@lists.linux.dev, netdev@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev,
 virtualization@lists.linux.dev, linux-sound@vger.kernel.org
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260303182845.250bb2de@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260303182845.250bb2de@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 7:28 PM, Jakub Kicinski wrote:
> On Tue,  3 Mar 2026 20:27:08 -0500 Yury Norov wrote:
>> The net/9p networking driver has a handy macro to calculate the
>> amount of bytes from a given pointer to the end of page. Move it
>> to core/mm, and apply tree-wide. No functional changes intended.
>>
>> This series was originally introduced as a single patch #07/12 in:
>>
>> https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
>>
>> Split it for better granularity and submit separately.
> 
> I don't get what the motivation is here. Another helper developers
> and readers of the code will need to know about just to replace 
> obvious and easy to comprehend math.

I fully agree, I had the same thought reading this.

-- 
Jens Axboe
