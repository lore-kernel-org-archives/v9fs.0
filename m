Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B118FDD5
	for <v9fs@lists.linux.dev>; Wed,  6 Nov 2024 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929540; cv=none; b=hGL8tu0vFqxEovVJxXo8X2dLuBXB7s6PkmZnieExHT+M1xx1s4kHA9ufUL4oGOg+rH0uOeymdobcYUF6EG1EOuYpY8ic48vavLL7ru+YrQognSc6RC8qVaSSV69xTVih7UdPy2YyCdZi3pV6k/54//DiDRpWblBEzBFQDcmNWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929540; c=relaxed/simple;
	bh=3XjTb8z/OatcAGlD70H52F9d4EjSpcmkKKzfQEYX9JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOcfuIcBuijEQl3lKOF5jtxQ+D2ak18pVtDNY8CnKpns+uDMXpjlGar4iGO45aqBwBcu0QkmvVArcod/7cq0b6vUopS04Ls6BU0925m4I50C0yo+jM0zdMGzkDVkss97zc53Svfv7B12ZlOxOx8YcKowQmMW6ljayAE2U2oaqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLcXr06h; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLcXr06h"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d533b5412so154578f8f.2
        for <v9fs@lists.linux.dev>; Wed, 06 Nov 2024 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730929536; x=1731534336; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZG/igyMP++w3vhsSNt9GffWfG68As9xDtf6/9FjLaY=;
        b=pLcXr06hmMtfN7uTKR/Sl20tTeoXJ597B24i5u9e21gyW6F4OfxGo+JD90kXeGtqEe
         Au43aTKq7Z9czZ9r10bMfD+B0rKqbBjUD3VhvxwGHeu3NpjN8Qe4Zwge5Ptd3xnU94Kr
         HATsomIpfBzxe4GoQSyvLRMZRu61bcyAPQs58HFA/TfXqfqLOOzZQnpPKg3zF6Z4fHBN
         tKYyLFLwVULdUeu6cfw1w7AbAC4SVIR4T2w5JMr+e7xpIV1OITvf1VPM1DlUbBYHWKjl
         I6ib/8QxcfTYftW/+FMQKuVUjkafwa4AL4gsSPumNOGDvusPjruN2+LSgz2cOlbl/lEF
         0QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929536; x=1731534336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZG/igyMP++w3vhsSNt9GffWfG68As9xDtf6/9FjLaY=;
        b=NzWiKQ1NPsdkcYUJBHpXhkWFLrfWf6ZkPlfg1rAJLrQD8+w1UYshcPIMhZzYhbfO0V
         cPqEN5Vs4l6Qsu1otPHp3XPAGLSqkk/V6U4O3NtDxqyTdFRo2JOfT3m27PWlAXbT2gKr
         c6yKk8WeuQJLFl4urZD+VIx5MdUq3ZSGZZ1M5d8CVLDkQSA6aJsMTzo3LSlpdD66yyVV
         uEm+DWFN3mrPPNuY3uJ//4s6NZQ4UczNlYJEl6bSRqPvVYjzPmPM31fmBynQNrGafegO
         RM7NVAWQ7OQe/U5XTUwV8F2mNFsKpfLar8lKHu5mvrsb8lBxgB6P3KK4U5my7c3zpi1L
         TqAg==
X-Forwarded-Encrypted: i=1; AJvYcCUuJHmtIWDOz5A0zKCwTJlRT/Cymr+C5oWRuFc21BK21Hhh64PQ5Y0kv/nwkqh5343GwlzW@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8QjOG/kIwOCCVKHee+8Tsr27VOKwhi2dFIHmPrLOGxB8c2SaI
	OPcu0LhEim2/nUnkDEhjip5gqcg/arlxYuM6V2NaNefzG94PO47sDwZC7I8tjUHL6OdfXK0hJSf
	pMBA=
X-Google-Smtp-Source: AGHT+IGQ0v+koMdAwFpvu3s3vBOtc/f9ove0xeGvJGuO0IWV0GiECd61P64DFb85ruuM8ktF6Hv5hQ==
X-Received: by 2002:a05:6000:12c5:b0:37c:c5be:1121 with SMTP id ffacd0b85a97d-380610f7bb8mr28648760f8f.9.1730929535965;
        Wed, 06 Nov 2024 13:45:35 -0800 (PST)
Received: from localhost ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7449sm20333098f8f.49.2024.11.06.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 13:45:35 -0800 (PST)
Date: Thu, 7 Nov 2024 00:45:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs/9p: remove redundant variable ret
Message-ID: <23a44a2f-2a99-47a7-a446-d96b5adf62ec@suswa.mountain>
References: <20241106152209.1626630-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106152209.1626630-1-colin.i.king@gmail.com>

On Wed, Nov 06, 2024 at 03:22:09PM +0000, Colin Ian King wrote:
> The assignments and return checks on ret are redundant. Clean up
> the code by just returning the return value from the call to
> v9fs_init_inode_cache.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/9p/v9fs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 281a1ed03a04..ee0a374e0d9d 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -661,12 +661,7 @@ static void v9fs_destroy_inode_cache(void)
>  
>  static int v9fs_cache_register(void)
>  {
> -	int ret;
> -
> -	ret = v9fs_init_inode_cache();
> -	if (ret < 0)
> -		return ret;
> -	return ret;
> +	return v9fs_init_inode_cache();
>  }

Better to delete the whole function and call v9fs_init_inode_cache()
directly.

regards,
dan carpenter

