Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9431863
	for <v9fs@lists.linux.dev>; Tue, 24 Oct 2023 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kk3qjUu6"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so60599671fa.2
        for <v9fs@lists.linux.dev>; Mon, 23 Oct 2023 22:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698124575; x=1698729375; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aE2lxw/rNDGPdJ05hPD2uVnr0m8qN8L+coi09dprodY=;
        b=Kk3qjUu6h+mNy/jBoxYivrLFoW5RkDEw3CkOZKbQKh6aDFB74Da4vqNBwacE04vkrR
         m28fXJJWONr9eHO88fyLAafkNkiiCcEZ+sYWKWjaby6y7eHXd4OZjzynpIJ1iXDOPRwQ
         i7JnMjfjZ7PLWL1PSShOvByyGsCBy5yUYXsRm6QvMn4NDBsNwTPdKvFqenlnlcAdVmXD
         vCu8c2daK9LUJCjm1BWVA80mP0ckQcDf1xH9HaQQ8ur1M05wodQzWgWum6p9wey/MnwA
         4A7F0vPXDa0f/zdVPXuLbpFLD4ABWr2GaXQ/RNrO6ZouXffGEtw8nGVgkkl5bh85DKqx
         cBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698124575; x=1698729375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aE2lxw/rNDGPdJ05hPD2uVnr0m8qN8L+coi09dprodY=;
        b=FbSTive/5efQ5Ch2Q50YeH1Dbl5yi40EN7SFm8/abdZAxMsBW8AgF3zfStAYi5xnVB
         zLwrXLe9e9BVv0Yf/f1kv7tlQo/SkzpHOnAJVVeM/cFRCD/cSeRhlGwssD+U90xOVal7
         fmUZJTOASNi8eYm62NdTgrQxcIpVzQVLob6EcC4oeHTU/GQme8LE64w9Jzu1/w+ClwrR
         VxbJeChbRxElTZ9IES19O5plQlr43abbx+GotVJTC3Unlzv9+nCv4hFdneaNuIMaBM6J
         mYSPRo6THjzzwf3HZZdy7i65901sEvqtk0bIWvifU3HLZKtRO+bjTc7DjwSHEm19MBxj
         cz6Q==
X-Gm-Message-State: AOJu0YxUOw8mLGp9hN2dbAp94unw1vIhR29wo9IT7yrp2ivCNbc1SL5D
	6MxILHyrKu6qTO973HQMZA2shg==
X-Google-Smtp-Source: AGHT+IHjW90meTVeICIf9vFGqWrh2jrlNk4jyKzQOzYpwwr591HktRYBLgZz3B9ZPTt8EKOFSYqyOA==
X-Received: by 2002:a05:651c:70f:b0:2c5:2cd7:62e8 with SMTP id z15-20020a05651c070f00b002c52cd762e8mr6721518ljb.12.1698124574533;
        Mon, 23 Oct 2023 22:16:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003fe61c33df5sm15988490wms.3.2023.10.23.22.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 22:16:14 -0700 (PDT)
Date: Tue, 24 Oct 2023 08:16:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, ericvh@kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net, linux-kernel@vger.kernel.org,
	Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH 2/3] 9p: v9fs_listxattr: fix %s null argument warning
Message-ID: <03a1c530-ac79-4286-9156-b258f79d1fca@kadam.mountain>
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
 <20231023233704.1185154-3-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023233704.1185154-3-asmadeus@codewreck.org>

On Tue, Oct 24, 2023 at 08:37:03AM +0900, Dominique Martinet wrote:
> W=1 warns about null argument to kprintf:
> In file included from fs/9p/xattr.c:12:
> In function ‘v9fs_xattr_get’,
>     inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
> include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
> [-Werror=format-overflow=]
>    55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Use an empty string instead of :
>  - this is ok 9p-wise because p9pdu_vwritef serializes a null string
> and an empty string the same way (one '0' word for length)
>  - since this degrades the print statements, add new single quotes for
> xattr's name delimter (Old: "file = (null)", new: "file = ''")
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> Link: https://lore.kernel.org/r/20231008060138.517057-1-suhui@nfschina.com
> Suggested-by: Su Hui <suhui@nfschina.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I've checked this works as expected (getfattr listing all user.* xattrs
> after setting some), so let's fix this warning.

Awesome.  Thanks!

regards,
dan carpenter

