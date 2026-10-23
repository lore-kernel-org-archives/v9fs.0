Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757976;
	b=MfjZdB9XuA7I78PAk9FkzcbpqPwl0iZ72YyQV7r1ItHSS6qQ/zU86C6nn+2LSz/QIcY+
	 Krt7rz9QbKVdTjCUl1dfX09Vs1xj1c6Dgrp6xgJY7iDZYdzmO4lJy86nxd3ssAhKEnY6X
	 qiHlGp2+xxLqJFqIbdWCk/tZV2DD+wM9456HiftdILievco99teoxnw+N9DsYpZjUtBcr
	 +X0Xqni/AenvfAeJlmoQNbHJ/pHgnZGbr+82w34nqWeL9Z8bpX8AYnCIl7DUuMh1xItwd
	 IlkseOODUdW7zy+IZ0qvarS7KSpCLJb2uNOdTEgGKCkZp8l2wzj2Pz96Dgqze0HvoHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=tnGVfmtDG/ydhJPk7ys/dw5eqE6jQ7yst5vq99GgEUc=;
	b=YIv437fmjO33v2IUusVCtpjRPe58zrDmFP2IuwINokPTytAFlf2o7aR3aTqdbVVkYIPr
	 o0wrz93LYnztgYmnf6kP/IkgP2vQEu6cGUlb4cQApsuXgy/xbvFaLvxSS4PlEvDisLXGM
	 3OBIumHGuD80X0Yos/VaJkPB28/Cedt5BsDkX8KjhsACiGVTEl6Opn+pmWHTi+I9+GqsB
	 ZlzIW5bkcVuOg4QdBoZ2b0YveeugO2hoEi4GYfHIYZD4fc1kxO4Lj5L4QRr7ZgzLOK7T6
	 mRogtaZ1Y3VU3sgqwA3+wdtiRcgnFxpeZItyCfJm7NBrrQ04uNTr0oeEaT0q26mq6/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=maatWBKw;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D5606A320
	for <v9fs@lists.linux.dev>; Fri, 23 Oct 2026 12:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 411D5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=maatWBKw
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5337fa12431so232971cf.1
        for <v9fs@lists.linux.dev>; Fri, 23 Oct 2026 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792757975; x=1793362775; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tnGVfmtDG/ydhJPk7ys/dw5eqE6jQ7yst5vq99GgEUc=;
        b=maatWBKwjM914d5Kqt7NdrDjPB4m3U8BQ9iDwPQw0UylnXZXjn/MJu2EdnNKfhDrQn
         KKcXq+AKB98sniu/dNQ2F4IMsZzfyM59OaFDPxG2FoUb78beAkZj+2BC3eBe1F6wESBR
         UyBNtuZmQfqU6t+TDC2bHso/Aa81hT0pyd9M1/JdiPvqVi7ZuAHCVFvfhn2hwZIdqyMn
         ajjWgk4g2gV+XQaxrmLKwCS+NCEgqDouoB6OGTVqzttQMJ4WaebCmw/iti26s5KvZ65m
         oC3I8N80CzsOdlMaZ1aEs2pEVtSFRuG+X47PUzolDhT/jtDSgQ954u5hZs1WbSed71fl
         reGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757975; x=1793362775;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnGVfmtDG/ydhJPk7ys/dw5eqE6jQ7yst5vq99GgEUc=;
        b=phK5bZBH6C2gGSOqo/U8NcByMIrUbkdzxAXfNkZYMWypynt0AXOFIOo+UepHvNCM4F
         yuoNwmm2FVlA3yV2fWFyDJxJJqwmmhXg0XbJWwlYl+DxX0P+hTG0p6S1UB3CoS++KB8T
         kJwX+oMZirrg3buwsVAsotCwBRum2YjNae427UbI5QQ5MDl1d/9jz98oPpkgwRJKCMwp
         oKqGdosLrtW9nSVKJn9LCs5x3EIGJQFavhu63jTtl+2C59vRR8NxZeG+d0rC7L5IbgSQ
         RaMe5zSXmnBpbxYdSbKxZXVBy8q56HoIs0m+EJHSKbtDnsloIWTSa1iIcTHY58FsQ2Qb
         U8yA==
X-Forwarded-Encrypted: i=1; AKwUvBxUzfp5r1aE0wai9UvLKblXqxX+H5jPjQVwPZWFSidHxnxyBt/Blw9Ev5tnnbsEyvcaknac@lists.linux.dev
X-Gm-Message-State: AFq9FYJcE21K1yKCLK8PEzNGVZWTaluDT75U4K+dk5IbU8gZAgV26XC6
	8M9+2l475lXZ9kOk8BuWSmoSTfa6zfSQZhPlYfTKci00GZsoTwYY1CRM5B8YTiDnSA==
X-Gm-Gg: AYBFou2hwrAT/UfEL/EpCuGCJiLAocUV4ECY4ZOLX9aaf41zyeyAJXi/u5ctXjyEnqY
	Ua3BZLP6k2e4Hkz9R2W5j/7KRYGzrUmHDQrLPK1sj4fmHftHLF+xJB6wwH+eVjVWApuuTadCxCN
	FtxW6NZkyoxvCR/oSnFKb4x0dr7JCuW22gtdno002jOAFLwJJ3o8T6494HdbuA2Jx/maTnrGivK
	Rj3xsEHkAfCY/8EyFOEnalvpkcZ5lbz0D6L2A6Qzhou/Z6Q2ns9iJ97Cs2OVW68SowePDAjc0K5
	57Add/tbKsOsIXG8NJUvfwvFQwoo3rSIhJkg5jB+uZPlbfhWfdOzTY3th9+tvJqnZSfZOKabaH9
	bPh4AG20IKexPH5Sgh2jtOq3zGwkNHUBZ3u02ZiRfpCatzFHA8LhxUpAjeDRuh37WX36HdA+FxD
	H+M9+dtKBBs1l2ZZWd850YgHEDRaCUGxZskePfD1trcRe1PYzbh0S0ppkZL2MzACYjulZonkemB
	UVig60B54WCY3vJVjukdhSskPNied0RLfJlitK+O0z+2QM7HLt9Kg==
X-Received: by 2002:a05:622a:4ccf:b0:532:8423:1e78 with SMTP id d75a77b69052e-536c48d0a54mr12945341cf.10.1792757974681;
        Fri, 23 Oct 2026 05:19:34 -0700 (PDT)
Received: from [192.168.1.27] ([130.44.176.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c45228b6asm128676d6.19.2026.10.23.05.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 05:19:34 -0700 (PDT)
Message-ID: <3d5f70fa-64e6-4df5-bda9-6d3cdd00682b@google.com>
Date: Fri, 23 Oct 2026 08:19:33 -0400
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: treat read return values of 0 as EOF
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <akfHGcqke9qixd3Q@codewreck.org>
 <20260702090941.1298188-1-brho@google.com>
 <2237820.1783934942@warthog.procyon.org.uk>
 <f7005841-80a9-4c21-a114-6cfd6ee63a58@google.com>
 <aqbGBMJ6bntYB1t2@codewreck.org>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <aqbGBMJ6bntYB1t2@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/26 11:49 AM, Dominique Martinet wrote:
> Sorry for dropping the ball here, I haven't had any time to do 9p stuff
> at all recently and the wave of LLM generated patches hasn't helped...

no problem.

as far as resolving the underlying netfs stuff goes, i don't know how 
much of the logic about "are we at EOF" should be in netfs or in the 
servers (9p).

would you be OK with merging my original patch so that at least 9p works?

thanks,
barret



> 
> Barret Rhoden wrote on Mon, Jul 27, 2026 at 01:38:16PM -0400:
>> On 7/13/26 5:29 AM, David Howells wrote:
>>> This is kind of a weird situation.  We're caching locally the content of files
>>> aren't really regular files and probably shouldn't be cached.  I'm not sure
>>> what the best way to deal with that is.  I wonder if there's some way to
>>> detect that and mark then non-cacheable.  (Assuming the server can be told not
>>> to even serve them).
>>>
>>> Can we detect that the EOF length doesn't match i_size and set a flag to say
>>> "don't cache" in netfs_inode::flags?
>> Possibly, but could you have false positives from this?  e.g. if a file's
>> size is changed concurrently with a read returning EOF?
>>
>> As far as detecting EOF in the first place, my patch had the 9p client doing
>> it.  Not sure, but Dominique's question might have been whether netfs should
>> have done the detecting instead?
>>
>>  From what I can see, the netfs clients were responsible for setting EOF
>> (except in netfs_clear_unread()).  Some in response to an ENODATA error,
>> others due to the "did we read past the end of the file size."  Not sure
>> whose responsibility it is to detect these cases: netfs or the FSes
>> themselves.
> 
> Right, that was my question; I honestly just don't understand the
> requirement/promises of the netfs layer.
> 
> In this particular case we have two patterns to address:
> - synthetic files with stat size > actual size,
> e.g. /sys/devices/system/cpu/online
> - synthetic files with stat size = 0 (rarer),
> e.g. /sys/devices/virtual/net/br0/brforward
> 
> For two at least two modes:
> - cache=none
> - cache=loose (writeback I guess)
> 
> Right now, none of these work, with various degrees of not working;
> I'm not sure we can do much about some of them (e.g. stat size=0 with
> cache enabled I'm fine getting empty data), but imo
> - cache=none should just try reading as userspace request anyway and
> stop as soon as the server returns 0, that's not a 9p specific behavior
> and I wouldn't have expected having to do any special handling for it.
> (but if you tell me it's to be done in 9p case, then sure, we'll do it
> here)
> - cache=writeback + stat size > read size should also stop when the
> server returns 0 and truncate its view of the size to that; the problem
> in 9p is that we'll reset the size again to the remote size shortly
> afterwards so that will need more thinking (and overlaps with the other
> cache size bugs we have in flight), so let's focus on cache=none for now
> 
> Thanks,

