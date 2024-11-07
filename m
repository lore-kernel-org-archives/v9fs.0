Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BE1D88DD
	for <v9fs@lists.linux.dev>; Thu,  7 Nov 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970848; cv=none; b=EAVmhXF61J0ZmzFgcEUEodK6Q4ae4gX6W9eIqp5aD/wPL8ZYYSlOHRth6VhO+3wC4pKjWoNK3ua0RlyUX29lCurD5uQcRcCEx5bK03DpxdI11duU8AMFYBSHQWsaeyVv+6YonP1zbPL+soyEe6P/6T7wM6tOxYEVUD8W/rQt1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970848; c=relaxed/simple;
	bh=6tAAux1lly/TI0vCOujAeTNBXuv3W0q6Y48vNZZo7PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Df6MAD7HFExZjGkzK3Cl/cNQ1TOEMqIyNiJFlvfTQWKAtVNEJKkrJjJ03C/0OCWjjwkRJJXypev3t64qBEPerBlheQcAdtZZedQSEPKVPToI08MnYlrWgIBaJf+HR7TyiCLSlViY52gt+iH10+FSFkhnDxLDgoVvPWwIQFcBAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6e5t1Ma; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6e5t1Ma"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so5832315e9.2
        for <v9fs@lists.linux.dev>; Thu, 07 Nov 2024 01:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730970845; x=1731575645; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZJoYWgKwwmsJWfb2QT5nT8hw1PQ+BpTzyZIvvtju0M=;
        b=j6e5t1Ma/88wZ2+59eOu4DhOxSoe9FvN2Y2v9mC1/CP6rUw3M3AdBXBrnboHxLDuHC
         5QKj64W4xLCTJKZE+VtAQXGsu5TKt9cUSJXIv5QHcAcXgmSDS0++3VxVBmAfu6KzboH9
         VX1d+ojqOQhj1d/NI5jwXbtiskRlNoE1BFG3uyqUmV4cKY3b/KSL2NhZD5SDkAw3bzTy
         MN+sTBUXzbJLfL2Q8SwqW7BYkbXVvTzwi1uiqMFZCqqIW/B1v5woZbg5odgFidDnbUY3
         Fza/8w+YPbU2g7X/294NJfvt/kLogA3M1BdN4q+Rut2t9XVuk8UCwhrn0Hm9AODU1wcd
         5Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730970845; x=1731575645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZJoYWgKwwmsJWfb2QT5nT8hw1PQ+BpTzyZIvvtju0M=;
        b=VNotx81u0BiWW6LgBkTDeHYXSJL0teef6k0IqxwMLbQQBefhRdabluDw+0MTDVJGeA
         1WzSavGsBM23fW5NzJ8MT+xQuuvQbJb2EzIOWdbcsK5yzhYkgs1fRmIV4142HHvWaV1X
         SOHnx5cJtv8HGSzC0xfsrG/QrgpiM1eG6+TqzzR82Pyj5nVSkRAbVZAzosLWnluNQYnl
         Rl5RaiuR0ea9uPIFVxGIwGpjOBXGE8ngiiok0F/qSSXmz+BMaFIpC9rYSKkXwl3u8ctw
         6KXw/KwmdJ0kcG8KC6vxZVha4p20jDqTh/C5IuuJUY/cSYmK4w9ZtsZH44rIbNLZ3YhW
         CctA==
X-Forwarded-Encrypted: i=1; AJvYcCU4CF9NYwYIDCpZOjWlft5sjUI7YoEryaNYJCJMDAFcByj4KVVSCKb80xngploTeUN/QDBa@lists.linux.dev
X-Gm-Message-State: AOJu0YxjMgY0pgG5kqvR9EOmCy6JEU2F5sH43Q2OtofjwBQPfJuHSzlt
	LM3b9KaZCWBsQ9OzMQ2HLHMss+YlYT7jiuCRE5s1G/asjpri+rIS
X-Google-Smtp-Source: AGHT+IFIm9AGuKcLross5xfua6rDaxLhOzo2CvrTnh1BEbODgP6JuCFF8fGOgbf6qFgkkCVJPvePpg==
X-Received: by 2002:a05:600c:35c7:b0:431:5459:33c2 with SMTP id 5b1f17b1804b1-432b301e8e3mr5531435e9.17.1730970845467;
        Thu, 07 Nov 2024 01:14:05 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.65])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed97f544sm1171452f8f.40.2024.11.07.01.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 01:14:05 -0800 (PST)
Message-ID: <f8fa71b8-05c9-4f1a-92fd-e72a8a2d34eb@gmail.com>
Date: Thu, 7 Nov 2024 09:14:02 +0000
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] fs/9p: remove redundant variable ret
To: Dominique Martinet <asmadeus@codewreck.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241106152209.1626630-1-colin.i.king@gmail.com>
 <23a44a2f-2a99-47a7-a446-d96b5adf62ec@suswa.mountain>
 <ZyvzuHBSyfI63CT0@codewreck.org>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <ZyvzuHBSyfI63CT0@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2024 22:54, Dominique Martinet wrote:
> Dan Carpenter wrote on Thu, Nov 07, 2024 at 12:45:33AM +0300:
>> On Wed, Nov 06, 2024 at 03:22:09PM +0000, Colin Ian King wrote:
>>> The assignments and return checks on ret are redundant. Clean up
>>> the code by just returning the return value from the call to
>>> v9fs_init_inode_cache.
>> [...]
>>
>> Better to delete the whole function and call v9fs_init_inode_cache()
>> directly.
> 
> Makes sense, and if we go there delete v9fs_cache_unregister as well so
> the init/destroy pair properly; that also is a single function call.
> 
> Thanks!
OK, will do.

Colin
