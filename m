Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594BD6EB54
	for <v9fs@lists.linux.dev>; Thu, 25 Jan 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196162; cv=none; b=C0UCdUj6s3IyUTQvbk1+ngDjo1IT51B67koCOskoKse7QBQ7sUlCfWPFmKng8isSnZlDW46icRleWyhsdupnsR29vzak2PCGy/2K43tefodk2SPiF/eUX+43KQVsLft9t5tmffg8BFiwWeZAYEmJ+TQsLDjDpzH8zMDmdlLee40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196162; c=relaxed/simple;
	bh=QyKrKPi2OmBilyWipKm6g9LwaREY3/z/OwABiSANKQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpErewnfJKX0W7R3MQ7Poz/2WKeq8SDeBSFmqLnewWTbrf+dZ5EWPZbfy06l8793kxlkMrxtsr7hTDeji8vUHIzYZqmK169Jh/XUTadZiSUs4Fmx0UzIgnmoG2iNo4JYHbOanwrDt2U5ER14RCfm5RU8oLOkNY3phEwOTmbKpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nXf2mZwE; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nXf2mZwE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706196155; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=p3tSUpOimDMRg8zqfNouUpnGd0mSimHS2NTV/3U3wfY=;
	b=nXf2mZwEZP2E0uO9n23rFNbiZl4/eDOy/bI6+4RRzdGZRu2Z73u77uiqTqvAyYjn0gEcefvoCkIjG9kdUQ9MfIF2XhqbswEIAGZseE59e0SMP6cqlV4e7CKiPcJCKD3DJCHskgxbp/XBXpDTGKCcoAnQQUUcPhhSQ+BbUsM1Oow=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.Kkdiy_1706196152;
Received: from 192.168.71.114(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.Kkdiy_1706196152)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 23:22:33 +0800
Message-ID: <8ac3a2fd-1c41-493a-b6a0-a5f53afb49e1@linux.alibaba.com>
Date: Thu, 25 Jan 2024 23:22:31 +0800
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Eric Sandeen <esandeen@redhat.com>,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <520668.1706191347@warthog.procyon.org.uk>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <520668.1706191347@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 2024/1/25 22:02, David Howells wrote:
> Here's a roadmap for the future development of netfslib and local caching
> (e.g. cachefiles).

Thanks for writing this detailed email.  And congrats to you work.
I only comment the parts directly related to myself.

> 

...

> 
> 
> Local Caching
> =============
> 
> There are a number of things I want to look at with local caching:
> 
> [>] Although cachefiles has switched from using bmap to using SEEK_HOLE and
> SEEK_DATA, this isn't sufficient as we cannot rely on the backing filesystem
> optimising things and introducing both false positives and false negatives.
> Cachefiles needs to track the presence/absence of data for itself.

Yes, that is indeed an issue that needs to resolve and already discussed
before.

> 
> I had a partially-implemented solution that stores a block bitmap in an xattr,
> but that only worked up to files of 1G in size (with bits representing 256K
> blocks in a 512-byte bitmap).

Jingbo once had an approach to use external bitmap files and
extended-attribute pointers inside the cache files:
https://listman.redhat.com/archives/linux-cachefs/2022-August/007050.html

I'm not quite sure the performance was but if it's worth trying or comparing,
that might be useful though.

> 
> [>] An alternative cache format might prove more fruitful.  Various AFS
> implementations use a 'tagged cache' format with an index file and a bunch of
> small files each of which contains a single block (typically 256K in OpenAFS).
> 
> This would offer some advantages over the current approach:
> 
>   - it can handle entry reuse within the index
>   - doesn't require an external culling process
>   - doesn't need to truncate/reallocate when invalidating
> 
> There are some downsides, including:
> 
>   - each block is in a separate file

Not quite sure, yet accessing too many small files might be another issue
which is currently happening with AI training workloads.. but as you said,
it's worth trying.

>   - metadata coherency is more tricky - a powercut may require a cache wipe
>   - the index key is highly variable in size if used for multiple filesystems
> 
> But OpenAFS has been using this for something like 30 years, so it's probably
> worth a try.

Yes, also configurable chunk sizes per blob are much helpful.

Thanks,
Gao Xiang

> 
> [>] Need to work out some way to store xattrs, directory entries and inode
> metadata efficiently.
> 
> [>] Using NVRAM as the cache rather than spinning rust.
> 
> [>] Support for disconnected operation to pin desirable data and keep
> track of changes.
> 
> [>] A user API by which the cache for specific files or volumes can be
> flushed.
> 
> 
> Disconnected Operation
> ======================
> 
> I'm working towards providing support for disconnected operation, so that,
> provided you've got your working set pinned in the cache, you can continue to
> work on your network-provided files when the network goes away and resync the
> changes later.
> 
> This is going to require a number of things:
> 
>   (1) A user API by which files can be preloaded into the cache and pinned.
> 
>   (2) The ability to track changes in the cache.
> 
>   (3) A way to synchronise changes on reconnection.
> 
>   (4) A way to communicate to the user when there's a conflict with a third
>       party change on reconnect.  This might involve communicating via systemd
>       to the desktop environment to ask the user to indicate how they'd like
>       conflicts recolved.
> 
>   (5) A way to prompt the user to re-enter their authentication/crypto keys.
> 
>   (6) A way to ask the user how to handle a process that wants to access data
>       we don't have (error/wait) - and how to handle the DE getting stuck in
>       this fashion.
> 
> David
