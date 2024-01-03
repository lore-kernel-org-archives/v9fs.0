Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DC18650
	for <v9fs@lists.linux.dev>; Wed,  3 Jan 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cwt2h71F"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d4c27cd502so8298025ad.0
        for <v9fs@lists.linux.dev>; Wed, 03 Jan 2024 02:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704276918; x=1704881718; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9kSoFv/7+pD3aWATl3d1Zz/zNpbqJdAmBC+qKH73H4=;
        b=cwt2h71Fw43LhdLbFB+uP3NwqbuYRE7gGCJWoJ+Ly7Cq2Utqz+iMdvkZumtnNkGX9b
         mVogL/2o7NoZWGyTTqeqfOTmkIAXHJTE9HmEw1PqwG/ZyNamrcrueSoJYSeh1R7O4zS1
         xpdNIfk8OiY4wl7WBAfKR9QlIs083DIugBcUupz39vT+P6cogYIgEUEjH5fuyixZ1Dmv
         j20ETMEOGpFyXv8zEIM+tBP7+oLNhbhkm3nl9fumkCmsqnPCYqIdcEEMlwwmx2pF5CLs
         8j30tBzE+Hk/qeyCRM3HyotNkT91sQ/mNR8wMno5M5gYdvAqC0NhnU1a4fmgZF3Gw5T1
         i4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704276918; x=1704881718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r9kSoFv/7+pD3aWATl3d1Zz/zNpbqJdAmBC+qKH73H4=;
        b=gY7/ETjtzpXVjVJYylWtKMWU0YxxdU7P0lZqAvNcdwZXOs3AZrAjdk/DsoVl776pSF
         fPuHn40e5lIES98uz+PdViSD/gxOHEW53Vr6QXDZK6zfRrqaHXTzsGsySchCojx03ZYo
         dDTDFHmK/rYuY7Bhm9/KW+Ipa6v9muEM9c/vOk0UrbjljKosSVQWbjApV0oD44HtPQfX
         LOr2KqlAkdC4+VxeUl628I5fm8wCWJjM8brxXPx4f2Qasri5zHTB1AxwBCwfZlE2tXtO
         fQo6zTQ+smCaR/dhiwIbyH8fNDOuhuNC3mIRplG4NWAMtEQPU6/Io3+YBS4SSjeA3MJ+
         lbCg==
X-Gm-Message-State: AOJu0YwDO4tC5u8iP+kY8bE+R+Irodr4nxYIFjI+jEM224WItcJyOzsv
	DlxUSeYqx5oIUTwC7OCBjpOA0KAzzQZpwg==
X-Google-Smtp-Source: AGHT+IFb5s1kRhg4lbBcAXzAad/ZQWUpaLKwi6GbYgUI52nqs1wg58jl3FEdVQCfwyB+lzN5OaJ2qw==
X-Received: by 2002:a17:903:11c3:b0:1d4:75c6:9560 with SMTP id q3-20020a17090311c300b001d475c69560mr6941145plh.59.1704276917712;
        Wed, 03 Jan 2024 02:15:17 -0800 (PST)
Received: from [10.3.158.72] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id bh10-20020a170902a98a00b001d4160c4f97sm21615997plb.188.2024.01.03.02.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 02:15:17 -0800 (PST)
Message-ID: <42dd77c4-8842-4f96-958a-0d9407362b9d@bytedance.com>
Date: Wed, 3 Jan 2024 18:15:09 +0800
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v5 33/40] netfs, cachefiles: Pass upper bound length
 to allow expansion
To: David Howells <dhowells@redhat.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Steve French <smfrench@gmail.com>
References: <750e8251-ba30-4f53-a17b-73c79e3739ce@linux.alibaba.com>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-34-dhowells@redhat.com>
 <198744.1704215477@warthog.procyon.org.uk>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <198744.1704215477@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/3 01:11, David Howells 写道:
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>>>    	down = start - round_down(start, PAGE_SIZE);
>>>    	*_start = start - down;
>>>    	*_len = round_up(down + len, PAGE_SIZE);
>>> +	if (down < start || *_len > upper_len)
>>> +		return -ENOBUFS;
>>
>> Sorry for bothering. We just found some strange when testing
>> today-next EROFS over fscache.
>>
>> I'm not sure the meaning of
>>      if (down < start
>>
>> For example, if start is page-aligned, down == 0.
>>
>> so as long as start > 0 and page-aligned, it will return
>> -ENOBUFS.  Does it an intended behavior?
> 
> Yeah, I think that's wrong.
> 
> Does the attached help?
> 
> David
> ---

Tested-by: Jia Zhu <zhujia.zj@bytedance.com>

> 
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index bffffedce4a9..7529b40bc95a 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -522,16 +522,22 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   			       bool no_space_allocated_yet)
>   {
>   	struct cachefiles_cache *cache = object->volume->cache;
> -	loff_t start = *_start, pos;
> -	size_t len = *_len, down;
> +	unsigned long long start = *_start, pos;
> +	size_t len = *_len;
>   	int ret;
>   
>   	/* Round to DIO size */
> -	down = start - round_down(start, PAGE_SIZE);
> -	*_start = start - down;
> -	*_len = round_up(down + len, PAGE_SIZE);
> -	if (down < start || *_len > upper_len)
> +	start = round_down(*_start, PAGE_SIZE);
> +	if (start != *_start) {
> +		kleave(" = -ENOBUFS [down]");
> +		return -ENOBUFS;
> +	}
> +	if (*_len > upper_len) {
> +		kleave(" = -ENOBUFS [up]");
>   		return -ENOBUFS;
> +	}
> +
> +	*_len = round_up(len, PAGE_SIZE);
>   
>   	/* We need to work out whether there's sufficient disk space to perform
>   	 * the write - but we can skip that check if we have space already
> @@ -542,7 +548,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   
>   	pos = cachefiles_inject_read_error();
>   	if (pos == 0)
> -		pos = vfs_llseek(file, *_start, SEEK_DATA);
> +		pos = vfs_llseek(file, start, SEEK_DATA);
>   	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
>   		if (pos == -ENXIO)
>   			goto check_space; /* Unallocated tail */
> @@ -550,7 +556,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   					  cachefiles_trace_seek_error);
>   		return pos;
>   	}
> -	if ((u64)pos >= (u64)*_start + *_len)
> +	if (pos >= start + *_len)
>   		goto check_space; /* Unallocated region */
>   
>   	/* We have a block that's at least partially filled - if we're low on
> @@ -563,13 +569,13 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   
>   	pos = cachefiles_inject_read_error();
>   	if (pos == 0)
> -		pos = vfs_llseek(file, *_start, SEEK_HOLE);
> +		pos = vfs_llseek(file, start, SEEK_HOLE);
>   	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
>   		trace_cachefiles_io_error(object, file_inode(file), pos,
>   					  cachefiles_trace_seek_error);
>   		return pos;
>   	}
> -	if ((u64)pos >= (u64)*_start + *_len)
> +	if (pos >= start + *_len)
>   		return 0; /* Fully allocated */
>   
>   	/* Partially allocated, but insufficient space: cull. */
> @@ -577,7 +583,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   	ret = cachefiles_inject_remove_error();
>   	if (ret == 0)
>   		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -				    *_start, *_len);
> +				    start, *_len);
>   	if (ret < 0) {
>   		trace_cachefiles_io_error(object, file_inode(file), ret,
>   					  cachefiles_trace_fallocate_error);
> 
