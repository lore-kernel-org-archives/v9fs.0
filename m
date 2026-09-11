Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C8459AE6
	for <v9fs@lists.linux.dev>; Fri, 11 Sep 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131231; cv=none; b=gxFJVEN2EBVFg9fScN+2DF1rlO91u4j8jDbZLfGPdYtsLkuHeTrJQ40uQIobNgJL2RRxxJpOBX1VfZE6mcyRJqYDMJodLUZXnF3NcaKYrRf+/7EOy/tNEKsQj/1l/tJSKCGLGGUBTFqnNrorI6JvajZcEqsaUB9rx4bnEnGs8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131231; c=relaxed/simple;
	bh=m/ys+Oy7wZhz/DzfYhAyQcwzJEpe5j+mlbCa2sSO8is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmQkDaFAPktFtIbOQ859SLHexkUteNVExsP1HaNOhVWEzm5dXQ3mcY3/zkZLvuac/ExISiWDKGIuolvEROT7zrS4HXSH3nsyjjepwEs1Ozg3lCWzuD+TlhvCRAmZPSpCVRjJ6VS27szKvJgUhq01R6k2KGzpKHLuediCDJ32BaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=method-b.uk; spf=pass smtp.mailfrom=method-b.uk; dkim=pass (1024-bit key) header.d=method-b.uk header.i=@method-b.uk header.b=XWmC7zC9; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=method-b.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=method-b.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=method-b.uk header.i=@method-b.uk header.b="XWmC7zC9"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so3002665e9.0
        for <v9fs@lists.linux.dev>; Fri, 11 Sep 2026 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=method-b.uk; s=google; t=1789131228; x=1789736028; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dG8HOZHtiAY98dOkyP/NeJQU/ZUjP3gwdxCbOsPTbSo=;
        b=XWmC7zC9W+wtlo7aHsgP33Cv1/YqbsF/Oa3c2cuXRp5+d+ofOZPN9n5eIkLsUIWWUF
         rZ4MS4wbyjnHcgG0wPuT6gsB5nP68kLug0k/ddrWuCuYH+SnB+d9vaBalWLB3kgL4QOA
         sViCBsxhro44sT/gO4sXFaRQvfzR1aoXK6PJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789131228; x=1789736028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dG8HOZHtiAY98dOkyP/NeJQU/ZUjP3gwdxCbOsPTbSo=;
        b=BNy98lpagp5LrsdwmTgKHRxVGSLGZoA+4PdBdRbo9FcbQtdukX2Jmd1qxXdsewdBqf
         xLgzsyqcJwcgAOmutNZhZznhlHlX/OfijAxl3+Qxfyf00mVK1x6Eap0oxqXJLLyc2a9N
         X84+Wjc8k6vT5f3oNGyl1POvwOslvpLLnF+TDCFpT0t6zWO76Jl0fMR9bZM0OcNfHGTe
         AvxR//JTn8waG358sqwfu/U5xmg+pbylt3heQX5CloY0dtzbu3Jzv+Iwu1lEYo9TgpMs
         7VTGSgkrCnL+VauTR1JQOMReMOFVjjvJNXHqF5nI+fHJRJVSop5c0/jRo919ug7vI3aL
         e6tg==
X-Forwarded-Encrypted: i=1; AKwUvBzjc/faYZyyflNzdaOQa4wwVL/yEAtnRbVjSHXxaKvt+9swJzfIjOfWL7Pff9kX+OyMZk19@lists.linux.dev
X-Gm-Message-State: AFuF++lVtZY36EGO/AuJZixANmPq02rriiHDfRexjTJ5jxAwuJrvuZdP
	wLg4ZaImGCRJgd+WgOvYF77UvPV6dvLpP8BsTBaA5bE3n9Zx0D5F76VMNHlRZC1JU6A=
X-Gm-Gg: AYBFou3Rpxr98WBbcb4/N2tFFiddHFpIAoRUS3X7Ct//A9IQvIBGd0sb2yp/giwu2Nr
	JTMFm5l1bjg9SI3z6z5rn+5vsub9/e9QRzFeJBCtZg+BMbE0K1j5HAiZmyLmKuUxB2mwI8aVIAL
	LKlwfBmKJ84x034v83tUepmcdmidf8i7PMxzlyob5FraRyb1VGQuHeoa8KPkXANRydOLZw85tzm
	PbHIbcjDCtuWKKYWct5SLoMjcOL6tXu0dMt4Rk6DznfmbifZ6ZwUs1aB8zz5nOKdXTZKK/czq5Q
	3MLrWewikXTSQ3YfH6+BGjtEmAVkYy6z7fmLahD31CDXTpKaX5dgEr6DEZNqKsON7pOdChyQlFU
	dOvQEb4XWuqvmIG2ZZQNSK+xSwKySoCS5YIna/mOpwLYX5DDlKvkaGNvoFvRku7UnczGoNuNC3V
	5u+W378cmNcz8L83BjvoTOqXU3J1wQzc8iBoKHtoaKfHdqRTeUgbLhbOKo7znd4ErsfSU7ZsNA8
	L/73cIUGZHTFr71qfCCcnxOiaT2GRxkXc9hFrFTUuM95t5l6BKdKOdbcVGY68nzm4YtiwKMyMpz
	8BL7pGpUsU+Ouap/vDuu3Isj
X-Received: by 2002:a05:600c:4ece:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49e610829b5mr49417265e9.9.1789131227930;
        Fri, 11 Sep 2026 05:53:47 -0700 (PDT)
Received: from [192.168.1.182] ([193.9.15.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5765152asm105767435e9.11.2026.09.11.05.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 05:53:47 -0700 (PDT)
Message-ID: <3faab0c3-29be-44af-9569-1e12e8ed6a74@method-b.uk>
Date: Fri, 11 Sep 2026 13:53:46 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL
 corruption of file data on cache modes with CACHE_WRITEBACK
To: David Howells <dhowells@redhat.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 pc@manguebit.org, linux_oss@crudebyte.com, v9fs@lists.linux.dev,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 regressions@lists.linux.dev
References: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
 <2226525.1789118704@warthog.procyon.org.uk>
Content-Language: en-US
From: Michael Mulqueen <mike@method-b.uk>
In-Reply-To: <2226525.1789118704@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks all for your replies.


On 11/09/2026 08:16, David Howells wrote:

> Are you actually using this with a cache?  Or just enabling the "use a
> cache" options?

This is my mistake, I hadn't set up cachefiles in my test VM. So yes, 
I'm seeing what you've seen with the reproducer. Apologies for that
misdirection! 

For posterity all the previously tested versions that were CORRUPT, except
v7.3-rc2 which I come to below, do this:

  none             read   0/20  write   0/20  [cache=0x0]
  readahead        read   0/20  write   0/20  [cache=0x1]
  mmap             read  20/20  write  20/20  [cache=0x5]
  loose            read  20/20  write  20/20  [cache=0xf]
  fscache/unbound  read  20/20  write  20/20  [cache=0x8f]
  fscache/bound    read   0/20  write  20/20  [cache=0x8f]

Where fscache/unbound is not having cachefiles properly configured and
fscache/bound is where it's actually active. It's the same reproducer 
as before, just run twice for the fscache case - the difference is 
cachefiles configuration outside the script.

On the 7.3 release candidates, I get a different result:

  none             read   0/20  write   0/20  [cache=0x0]
  readahead        read   0/20  write   0/20  [cache=0x1]
  mmap             read  20/20  write  20/20  [cache=0x5]
  loose            read  20/20  write  20/20  [cache=0xf]
  fscache/unbound  read  20/20  write  20/20  [cache=0x8f]
  fscache/bound    read  20/20  write  20/20  [cache=0x8f]

It appears that cachefiles isn't actually storing anything on 7.3. I've
used the same configuration for every version, cachefiles is active, but
seems to encounter an error when actually storing in 7.3. I haven't had 
time to investigate that. I only mention this for completeness, it's 
not material to fixing this bug, just affects how it presents.

On 11/09/2026 10:25, David Howells wrote:
> Does the attached work for you?

Yes, thanks, I get this on patched 7.2 and on patched 7.3-rc2:

  none             read   0/20  write   0/20  [cache=0x0]
  readahead        read   0/20  write   0/20  [cache=0x1]
  mmap             read   0/20  write   0/20  [cache=0x5]
  loose            read   0/20  write   0/20  [cache=0xf]
  fscache/unbound  read   0/20  write   0/20  [cache=0x8f]
  fscache/bound    read   0/20  write   0/20  [cache=0x8f]

So it looks like it's fixed. I haven't had a chance to try the patch 
on a real workflow, only the reproducer, but I will next week and report 
back.

Cheers,
Mike
