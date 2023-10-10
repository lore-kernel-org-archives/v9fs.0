Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68014A8B
	for <v9fs@lists.linux.dev>; Tue, 10 Oct 2023 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4Zn4rml"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50444e756deso7173472e87.0
        for <v9fs@lists.linux.dev>; Tue, 10 Oct 2023 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696924296; x=1697529096; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kJcWNo/8KJ51ax88QJfvPgCGs+4edXiaLsPmHPPvA7A=;
        b=A4Zn4rmlp/swk9u77N/UeMlQssrmv0/CaqtqfewM+xz05itBN3DWMYMG9Qs+TTKjOv
         yaNZ9RGWp+9ivKXTvRcKqeq/HhXLqAE50PoXvG2hYqW2RzAUZc80ns4haW1Ws68zW0q5
         SUNYMqRldEsy6Jus5g5Wanw5mDqEwYcRyQ8GH18VBSIoYxkl5z9KBboXKEyWLFq9Km6w
         p9w9ro5zp1SuL4W6uFLSXGvaP38B0j3qeDj5c1R9f0bDY8zKdckbJjWJaTODmcY2bOR3
         L3stk3vjJfIm459wcZ/bR3rjqV1AYjLoEKxR0W4GenSlivuNffkNqlItLTnylRlk0TdN
         T34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696924296; x=1697529096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJcWNo/8KJ51ax88QJfvPgCGs+4edXiaLsPmHPPvA7A=;
        b=uYfLgiJV23/U3+l9TEHs8G0spDirZCNRaw79jI30BbNWiLUEIDLwI4rcZTCX6Wm1cW
         IK1chx5xTBu4M/OLjKGNdt+6u8X2M6FnEjf3R0VEf5UFkNQV8tAMrOa/GzuDO3Rfdj5x
         reXOXcfvgg8Arr5qnmqcmG5EPJhykM2wH6GfEJgMoQTZ2tWj5rDl36M6b9En5nJmWdOC
         3Wg5wJ8xcWwrdJeHTc0X3GdjX41rqzBrRvlTW5sQu08xHVgbKNtdMZVhXHy4O+0xKQpy
         v9l3qzvzmZJvRNItnpjKi2Znz5Vd9hLvzQnSh90O5axJ1bgz+745IoLAJDKTuMJsG0nt
         jkWw==
X-Gm-Message-State: AOJu0Yx4ELe2aj3dqPJBuFT1H558O9F6TvYnaat5IBvafpJvqS1qWKnX
	BZ/69OtJbhO/2AFHf+F6TJZIcw==
X-Google-Smtp-Source: AGHT+IHtqLHYfIcwgaVbaqexLs+zoWCH5Qmn/1pLpFUPQWX4ZuHxth1Fvpbhs5GXKf1ycBqkA3XEvg==
X-Received: by 2002:a05:6512:60f:b0:4fe:94a1:da84 with SMTP id b15-20020a056512060f00b004fe94a1da84mr13917473lfe.5.1696924296104;
        Tue, 10 Oct 2023 00:51:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b0040684abb623sm15716967wms.24.2023.10.10.00.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:51:35 -0700 (PDT)
Date: Tue, 10 Oct 2023 10:51:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
	linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Message-ID: <56aa4f09-8f61-48f3-9836-687bf852b03a@kadam.mountain>
References: <20231008060138.517057-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231008060138.517057-1-suhui@nfschina.com>

On Sun, Oct 08, 2023 at 02:01:39PM +0800, Su Hui wrote:
> with gcc and W=1 option, there's a warning like this:
> 
> In file included from fs/9p/xattr.c:12:
> In function ‘v9fs_xattr_get’,
>     inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
> include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
> [-Werror=format-overflow=]
>    55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> use "" replace NULL to silence this warning.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/9p/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index e00cf8109b3f..d995ee080835 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
>  
>  ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>  {
> -	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
> +	return v9fs_xattr_get(dentry, "", buffer, buffer_size);

I'm pretty uncomfortable with this patch...  This code is 13 years old
so it can't be too huge of a problem.  We're doing this for the printks,
but now they're going to look weird first of all.

Old: "file = (null)"
New: "file = "

But also this must have some other effects on runtime right?

regards,
dan carpenter

