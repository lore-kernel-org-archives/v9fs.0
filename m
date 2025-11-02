Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FF146588
	for <v9fs@lists.linux.dev>; Sun,  2 Nov 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762127891; cv=none; b=E2phTF2MiL2BLhIG1+JI156Jnr1u/kfzLRneKSqTwuSbaoVu7n9vVKar6bL3SpXXd8RDkM7safd/lsBJ0FacPdHTgBnZ8RJWYWOwn05ykpf1ezh3jFmdpcGfOJX3/5QQGEWw4WNBBKlswWWdv9cAv9h5/0atvD9XuDhW9fR/Iz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762127891; c=relaxed/simple;
	bh=rFC+auKMwh9plis+gbrTuFD5NjDjOm3h8ZjqSh41e30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzNc0A6vrd3BG7VKBVLb/sLYPoRXq19Vqs1UUC2X3Z/FtjodDhrf6ytYDsqrvnGrbygEjTv0OQkK7/hYbHNmfsJyDi8VmxAY6tKht9TNuEOkVdMubiL3T5XKwZeZy5QUzJ+OK4jhlKGt/nBmnfC36NdMFLU4jIZoOYWMXrKDvpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=k7U7RsX6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmefQeP6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="k7U7RsX6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmefQeP6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5685140006C;
	Sun,  2 Nov 2025 18:58:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 02 Nov 2025 18:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762127885;
	 x=1762214285; bh=UsZalTCsXXs7lJzw/MPWFnNK5em/vLTSJ5uTcEsP2pI=; b=
	k7U7RsX6jbi6vESI76kPVm5BgM4QEbnNOeKf0RIhwcu+CPzdwlU2NLU3wSdoPkUV
	VvI/ERs/8sFVXp108lAIHoU1ePhbkdgGFCRkJPSf9UVuQzgsJ0oDNVZiHKmcEYPq
	fuTq4joFRW8Pn0k1PXeO8L+JPJBe2jDBH3rEanC0SVd8yp7NCtLUZCVts4GYXV8s
	skGO9S9v/cwcPt+blAvE0uJ7ulYrsnoIhr5tc7rfsEW4wBIVhkSO7G76xDWxcGPO
	eWFQ5ds1K9KFsObCJR7UdYSdCRxF/yOJklWYkokXAEJGiQbVp2bX63L5A1odBd80
	SCxetyg9XkiquKcVf2n1DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762127885; x=
	1762214285; bh=UsZalTCsXXs7lJzw/MPWFnNK5em/vLTSJ5uTcEsP2pI=; b=A
	mefQeP6U6zOLIz9mIpcXyifB4H/qfER0SMVRAruQAxDid+sVBMSNBVMxHGMRI4ax
	kK4glGQss1UmL5CWYSlOaPgVPMOPkvxWmY3YHImBXZeIeGH2ArDNLoat/f+5iuOD
	esO5sSQFK9Lbs7pECjF8a+dDJfQwTSsXu0i9pRTq6MiV+iFQT4Hf1AcWqCamoEPR
	vMl1BI5E+bNEIZqDJZozTy3kpPQOxyrtqpk25WtG/Dv3oiIJgSmdxi5+WP6U9b6h
	xS/ArRNjf85g9wtfojHhMzZVp/TWI2p3OdFRVTSqmbBw2zZUcJr1UL1K72/h6y4K
	d8gHTRT00no8VqyiOku4w==
X-ME-Sender: <xms:DfAHab5Lk7RaoYo1VnknBS-XM9KLuqzmf76fiLAm2Ukm-EwNkT0Qig>
    <xme:DfAHaXzaGOvoyj_SdPOqMfbmfLwBVHSdypM3r-lblvbFKLVBp9Z5dLnrelmJeE7kC
    en7aafnZLm7Hk7cCvvSyDMisZViBwtOiMKCBXmBBlr6PYDn_zJV8RU>
X-ME-Received: <xmr:DfAHaawBQwN3SrZ0rC8G50Tj6Vu_60NcLkVTcs2288iJkMJ1w6Qw1oCi2iWTEuM1a59aTBjPQJKZVOX6Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeiieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepfe
    dvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdtfeeilefhudetgfdunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlih
    hnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepvghrihgtvhhh
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvth
    dprhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:DfAHaXxoOc8UAHwKRkP_h-hcHa5iCE8Gtv_THZy0BagbBTcT4h3VbQ>
    <xmx:DfAHacahtt7BAUeHW-MRPi_fWPlI7kPcpRO-rCkz51fdg-TVEW83eQ>
    <xmx:DfAHaQUfn8NqAfpujDdC9RQHzmpid99E5VZXsdfiR0Ra4BLPSx74-A>
    <xmx:DfAHaSj7c4VNFIm94DH7AFZVzv8-EibdSlGUPiu0yAsxLqG8gG6xXw>
    <xmx:DfAHaVm-Uma9BA2LL8V7n_pzo3DDLpnyv4KqDA4Ky5KNbRmdMhmVqO2->
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 18:58:04 -0500 (EST)
Message-ID: <fe56b7f7-fec8-4930-80e6-f55bcc3a834e@maowtm.org>
Date: Sun, 2 Nov 2025 23:58:02 +0000
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/9p: Do not open remote file with APPEND mode when
 writeback cache is used
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, v9fs@lists.linux.dev
References: <cover.1762115015.git.m@maowtm.org>
 <ed2d3f0045f538e8ddbd2d0a151e31767dda87e8.1762115015.git.m@maowtm.org>
 <aQfkMUncxteb9aPW@codewreck.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <aQfkMUncxteb9aPW@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/25 23:07, Dominique Martinet wrote:
> Tingmao Wang wrote on Sun, Nov 02, 2025 at 08:24:39PM +0000:
>> When page cache is used, writebacks are done on a page granularity, and it
>> is expected that the underlying filesystem (such as v9fs) should respect
>> the write position.  However, currently v9fs will passthrough O_APPEND to
>> the server even on cached mode.  This causes data corruption if a sync or
>> fstat gets between two writes to the same file.
> 
> Ugh.. I'd never expect O_APPEND to have any effect on the server tbh,
> 9p writes are "pwrite"-like, the offset is always specified -- there is
> no plain write(fid, data) call -- so O_APPEND should have nothing to do
> with the remote :/
> 
> (well, man pwrite(2) does say this... So that explains the behavior if
> qemu respects the flag:
> BUGS
>    POSIX requires that opening a file with the O_APPEND flag should have
>    no effect on the location at which pwrite() writes data. However, on
>    Linux, if a file is opened with O_APPEND, pwrite() appends data to the
>    end of the file, regardless of the value of offset. 
> )
> 
> I guess I can see this being useful if multiple clients are involved in
> cacheless mode, but I agree any kind of data cache should strip this
> flag.
> (I think this didn't cause problem in other cache modes because writes
> through the page cache happen on a writeback fid that's opened with
> fixed (no O_APPEND) flags?...)

I don't really know enough about 9p and netfs and which fid a writeback
would end up using, but I've seen that it happens in mmap and loose cache
mode.  For cache=loose it's harder to notice since the client has the file
data still cached and thus read() would behave correctly (and in loose
mode we don't refresh the i_size either so we don't even see the extra NUL
bytes that happens when in cache=mmap mode), however the file is still
being written wrong by the server, and would be visible after e.g. a VM
restart.

> 
> 
>> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
>> index 612a230bc012..ff95dfb30583 100644
>> --- a/fs/9p/vfs_file.c
>> +++ b/fs/9p/vfs_file.c
>> @@ -43,14 +43,18 @@ int v9fs_file_open(struct inode *inode, struct file *file)
>>  	struct v9fs_session_info *v9ses;
>>  	struct p9_fid *fid;
>>  	int omode;
>> +	int o_append;
>>  
>>  	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
>>  	v9ses = v9fs_inode2v9ses(inode);
>> -	if (v9fs_proto_dotl(v9ses))
>> +	if (v9fs_proto_dotl(v9ses)) {
>>  		omode = v9fs_open_to_dotl_flags(file->f_flags);
>> -	else
>> +		o_append = P9_DOTL_APPEND;
>> +	} else {
>>  		omode = v9fs_uflags2omode(file->f_flags,
>>  					v9fs_proto_dotu(v9ses));
>> +		o_append = P9_OAPPEND;
>> +	}
>>  	fid = file->private_data;
>>  	if (!fid) {
>>  		fid = v9fs_fid_clone(file_dentry(file));
>> @@ -61,6 +65,11 @@ int v9fs_file_open(struct inode *inode, struct file *file)
>>  			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
>>  
>>  			p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try opening O_RDWR\n");
>> +			if (omode & o_append) {
>> +				writeback_omode &= ~o_append;
>> +				p9_debug(P9_DEBUG_CACHE, "removing append from open mode in writeback cache mode\n");
>> +			}
> 
> I wouldn't bother with the debug message, just clear it like P9_OWRITE:
>    int writebeack_omode = (omode & ~(P9_OWRITE|o_append)) | P9_ORDWR;
> 
> (same for other hunks)

Patch resent as a reply.  Feel free to add any additional tweaks /
comments you prefer :)

