Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5119047A
	for <v9fs@lists.linux.dev>; Fri,  4 Apr 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743805789; cv=none; b=iNmG8dc0oOQZxaFWo0IcIfiumKljGZ1bYtrpVb/ighUA0lOWpIhdx9dsTIenpRAw9sehMuZnEuM4FFPTROgIMfkdDvKZ939/rKQdcx8JhEcLDNJgxAvCX66OXWvzCjAite7kpoa/OqD+C8v6wgQwrmnfn2bDsMclzWoKxT7x79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743805789; c=relaxed/simple;
	bh=NmHFPxslfg0WBqi0kIWYsQah2KUantxPzippnzuHLhA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ndr8PYbX+KvU7fFh6hpojnPSFLmqT2fkPC4eyQKRYTiD9J3XnF42Hu92ESPHOQ0X+5Q04WTgBQxzCq06IBHlaDy0Bx7FXYxm0BoEpcumDJdoB8lH/A1ubS3nToqn+uH8J8LX9KITXpeJZ2RzUXo2bWVgughVnMZqFP+P9X3SC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zi7ubabj; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zi7ubabj"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce87d31480so13607015ab.2
        for <v9fs@lists.linux.dev>; Fri, 04 Apr 2025 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743805786; x=1744410586; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X2+rBhFrK00h+ijJXPzvBEmgahY//panNVZB95538Xg=;
        b=Zi7ubabjYm2FAwUDa3GoD9hgO8fJNyjFviBL+vsGesrmApmdLEfCejQfdTjg0dQ8El
         xRb7OTVsqmMo/fdJSF4FDZaOKGWE31ugtOmIvROsiPzqRHgntA4t/7tKUfgBz3q2Y4yF
         DPV+YSyTVCGkBi1RzMIyVMLsJdVEkmzuvbPCnGs/OREM34hdqyvtr8znVQmbSvqvYOKg
         MuShpiEB1F8IC/uY7XG+RhZJ6wbIfA8JO9vq2M5ihyVN9OVsCYVW2qDH8HFHkeYUYa2h
         zK4j5SkumoXrtXxpGlC/2OwY6+76yxmY7U+I+KsZkTgla/gO9TkdCjzqC2HJiu5PZfWe
         iYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743805786; x=1744410586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2+rBhFrK00h+ijJXPzvBEmgahY//panNVZB95538Xg=;
        b=f2jUOOK8Lb9jfq6abmtkXKme3++MUhzB0cY3e2Oa6NVFIImiibP4rfIcLHhYhBXIZe
         /bYufU0Amv9dqtQbgSH8utml+FiLhwSnoNmWAusLTUOBTXLTV9GQAnTYvbBKQExs/dZT
         40jp2A1oMNdmL00080TU1i6f8whWvf2I9XCWlkeEMPmgZ5Nnwe6qyPVtqMq/VS5fgbVx
         Do8aT94J9c90RzDwzo8Duq/X3UD6o84ykWEbS3+0NQmn60S9pqr1OfxFXDttbHisBpnZ
         NQoYe0Kx8KiKwnGzkp1oGLO1zym6JJgWd2foszZUId8H8Mz6KEu0zTXLBWu9PHW3Z6Qy
         vuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUm8aWUTkak44YnAl5dR+jPnznNXDXRytRwFeQXJtSA9XlrfM/ovmSRmVF6NMGSlvi4ya4@lists.linux.dev
X-Gm-Message-State: AOJu0YyofVTnb34p+FvLmxR7iKsBbUfzcBtjNjVVckjjOS7SQdgS2EnU
	G5cUXVVhO/R1LlC99wVUbCI5NtyQZEMffzf5iR5eJCO2iYNJFywPKY2CaJaJA2TD0GAEeONChOk
	d
X-Gm-Gg: ASbGncvg83jpEG+SjZHmDdMVMfHbCrnQALKyUT82nniRJN7k4RNRaOjplVSwaqjBruV
	SUA6ZP5JNjI1bK4tZwMD3CDbmY0+tOmJ9asUxv7XYclMhy76QkgbvhTHW/zH6mTK1Dv/Guszwij
	pV/2skB0c85bEx7/yfN/jnWkifEoeTH+A+7sUgQrCmpltCVHt+AR563VNGwPNZgtOBPuJ0SgjLb
	+0VLU4jGGCw2lvlf8Pbur/1g6Ya7FBK41UUVLxEc+zCOsCPr10CjQj9f/xVuPHQYzYJ+Tt6mWjd
	EhzKL49kMSPJHes5LDMgnMrwga+U1WMagwVMZhtaMQ==
X-Google-Smtp-Source: AGHT+IFEdAwRfc0UX+JXaYJNbcrDKSXDiE0ZmU7jYIj1mI0qDtgXapwG2cndU6ey8QrKP9T048JSFA==
X-Received: by 2002:a05:6602:4c82:b0:85b:476e:ede2 with SMTP id ca18e2360f4ac-8611b5788f3mr531756939f.13.1743805786473;
        Fri, 04 Apr 2025 15:29:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5c497besm1038305173.38.2025.04.04.15.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 15:29:45 -0700 (PDT)
Message-ID: <078b3edf-aa34-452d-aa2b-244119f76ace@kernel.dk>
Date: Fri, 4 Apr 2025 16:29:45 -0600
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [v9fs?] BUG: stack guard page was hit in io_wq_worker
To: syzbot <syzbot+6f691675b0810bf591ec@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, asmadeus@codewreck.org, ericvh@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
References: <6782e97a.050a0220.d0267.004b.GAE@google.com>
Content-Language: en-US
In-Reply-To: <6782e97a.050a0220.d0267.004b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz set subsystems: netfs

I believe this one is long fixed, though.

-- 
Jens Axboe

