Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE722578A
	for <v9fs@lists.linux.dev>; Sat, 27 Dec 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858351; cv=none; b=j984deum6Bs8XweyNXDjeova1Dm8OsgSKNe4e94zXoXWnztZmNPqB8B4FGIUOSWWI5e01y1meKg1jrPlMfxNkeIU4aMfTSoVFXx7sg3P4QLczZFpy7wM+ju2/wvNe/bKy82KFht7dHlEPJ5j0dSgb5QXcDjO2PAjEipi2CspYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858351; c=relaxed/simple;
	bh=bOonYSligGooLAW6JQtZs3tYcOFQNsrObPRMtqiSRN4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N1sv+JXfOSfzgFtI6cFdIeOOcg7W6rO6pwjgcmF8sGAhqsYJ9Ia8rzx/CmE7AkawsPP6gLWQkwndw0q6fz2BzgGX2u4Rzw3d4t526awEvEFU59sXT8WakfEvRG2KRnILG4Ui+vqxT4w2YYuqipC6/oiG678l9BfT6CgJpuLc32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=CPHqXnr3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DOjrNXf5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="CPHqXnr3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DOjrNXf5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D2B91D0009F;
	Sat, 27 Dec 2025 12:59:07 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Sat, 27 Dec 2025 12:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766858347;
	 x=1766944747; bh=CXfPa+BB+JolUTb4tBuSJsDU+6mwvU1o3MtJPTx97q8=; b=
	CPHqXnr3sDMsXsLNpu7zrgdCa07Web6SBIrv3hlKRLypfquPjZszuXX93/CncOU9
	wssgGgbg+dX5d+OeC2KFRH+cUliHRJ0ueWrQF9m+jNs0j19jo/+iiqrDKpMw0XJY
	e5H+lyKcMpgCUsZv4WYF+5J9qsskf7H4yZiFXF5dKRmwHkS6Cw3HJ+ne9H+udmCf
	VH2HUeVTIew4RqkNz1exwgnN1SZ/rV31etP6eUEh1MDphopz70VqYyEVjC+oHgP7
	Gg1sngakb4+r0sx6WO2sC5Hk4wjQW9ojXAFrd7Dd2zu/TMCB/ExnaMvTTSgH7cOb
	6vLLinn8A4hXMLhM6cFPDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766858347; x=
	1766944747; bh=CXfPa+BB+JolUTb4tBuSJsDU+6mwvU1o3MtJPTx97q8=; b=D
	OjrNXf5mbBbnlBsEzanFrfu6fxk4bI+8LN1ljHRaDSbjE86UJ3fG9X/OgevCwvwU
	aGk8AKmB+Ahq5eWTTXFldb3nqNPhTvGwouJ9VqjW9l9XtFxIt10r8hdvpC+menqu
	51/uY5p5s9c9TWizmai8DZs9MCOc3NZfPw2+aPv0w0c2VsuoNhJ38NgPvLF5+H8q
	cCFWZ61jc+zsV1MwvPmofyBcAEiC7ySIg3UQ7nd8cHm6SfH/2/t+Pof0q4EdoI4x
	t7db7UeNoTZdeHBgYP6dIxhju5h7+lCucxCfiVI46DN20y9RF8nwmGxe7LLzBJAq
	oAP7cGWQX3oKR1/+0U6vg==
X-ME-Sender: <xms:ah5QaZKlRC413We0B7hJLbeeZiVK05Gm_qvERFVFCgKpJrV26JANyg>
    <xme:ah5Qaf9-InrUAaB4gGAmsfTfleDIfIycI8iGWKI2XMGX499zc0v7bz6w4wxictFy3
    z-UND81OkW5ZbgwXfiICcjtTaKczZvXMq9CadhMAUX0Ee2ibGxksw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfrfhivghrrhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggr
    rhhrvgdrshhhqeenucggtffrrghtthgvrhhnpeetgeeivdffhfeihedvkeefueekgeeivd
    ekheekjeeuieejiedtffdtjeetvdffjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgtph
    htthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushes
    tghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuug
    gvsgihthgvrdgtohhmpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhr
    tghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlehfsh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ah5QaYLflQQrSjCyTn1SbyTHyoS9kNnqgei_2i008ByVHVatDerRrw>
    <xmx:ah5QaTEVp_HpApH18odvFYR47WUsOqvuqIhJgf8CcW6xYzR4pmzfRA>
    <xmx:ah5QaXuCYhZBi49RPr4hxy_BT0jLA1uBu4VZJYzA2m9GXQ3Q_snsYg>
    <xmx:ah5QaasUXvtvaZXMBbD4fKg2WdNLS4D9qiMcOvCTXbkCKqRd0gYSXw>
    <xmx:ax5QablFfNTbBSPNM2ygsST5lnEdOsXwqkpH4Cy5btZP4Ss1i-n5562P>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A0E2DB6006F; Sat, 27 Dec 2025 12:59:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AoqcrCcQSTNZ
Date: Sat, 27 Dec 2025 18:58:46 +0100
From: "Pierre Barre" <pierre@barre.sh>
To: "Christian Schoenebeck" <linux_oss@crudebyte.com>, ericvh@kernel.org,
 lucho@ionkov.net, asmadeus <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <41b9603e-5e53-4332-aea4-7f63becb287b@app.fastmail.com>
In-Reply-To: <2393940.ElGaqSPkdT@weasel>
References: <20251227083751.715152-1-pierre@barre.sh>
 <2393940.ElGaqSPkdT@weasel>
Subject: Re: [PATCH] 9p: fix data corruption with writeback caching during concurrent
 stat
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Christian,

On Sat, Dec 27, 2025, at 12:30, Christian Schoenebeck wrote:
> On Saturday, 27 December 2025 09:37:51 CET Pierre Barre wrote:
>> When using writeback caching (cache=mmap), v9fs_vfs_getattr/setattr have
>> two issues that can cause data corruption:
>> 
>> 1. filemap_fdatawrite() initiates writeback but doesn't wait for
>>    completion. The subsequent server stat sees stale file size.
>> 
>> 2. v9fs_stat2inode()/v9fs_stat2inode_dotl() unconditionally overwrite
>>    i_size from the server response, even when dirty pages exist locally.
>>    This causes processes using lseek(SEEK_END) to see incorrect file
>>    sizes.
>> 
>> Fix by using filemap_write_and_wait() instead of filemap_fdatawrite(),
>> and passing V9FS_STAT2INODE_KEEP_ISIZE when CACHE_WRITEBACK is enabled
>> to preserve the local i_size.
>> 
>> Also fix v9fs_vfs_getattr_dotl() to check for CACHE_WRITEBACK specifically
>> rather than any cache mode.
>> 
>> Signed-off-by: Pierre Barre <pierre@barre.sh>
>> ---
>>  fs/9p/vfs_inode.c      | 11 ++++++++---
>>  fs/9p/vfs_inode_dotl.c | 13 +++++++++----
>>  2 files changed, 17 insertions(+), 7 deletions(-)
>> 
>> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
>> index 97abe65bf7c1..f4c294ca759b 100644
>> --- a/fs/9p/vfs_inode.c
>> +++ b/fs/9p/vfs_inode.c
>> @@ -977,7 +977,7 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct
>> path *path, return 0;
>>  	} else if (v9ses->cache & CACHE_WRITEBACK) {
>>  		if (S_ISREG(inode->i_mode)) {
>> -			int retval = filemap_fdatawrite(inode->i_mapping);
>> +			int retval = filemap_write_and_wait(inode->i_mapping);
>
> Haven't reviewed thorougly, but this looks wrong to me. The point about write-
> back is not having to wait for completion.
>

You're right, apologies for not thinking that through properly.

>>  			if (retval)
>>  				p9_debug(P9_DEBUG_ERROR,
>> @@ -993,7 +993,12 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct
>> path *path, if (IS_ERR(st))
>>  		return PTR_ERR(st);
>> 
>> -	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb, 0);
>> +	/*
>> +	 * With writeback caching, the client is authoritative for i_size.
>> +	 * Don't let the server overwrite it with a potentially stale value.
>> +	 */
>> +	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb,
>> +		(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);
>
> And this measure alone (along with the same change in v9fs_vfs_getattr_dotl()
> that is) would not fix the misbehavior you encountered?

Indeed, I tested with only that change and the same workload, and this fixes it.

>>  	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
>> 
>>  	p9stat_free(st);
>> @@ -1058,7 +1063,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
>> 
>>  	/* Write all dirty data */
>>  	if (d_is_reg(dentry)) {
>> -		retval = filemap_fdatawrite(inode->i_mapping);
>> +		retval = filemap_write_and_wait(inode->i_mapping);
>>  		if (retval)
>>  			p9_debug(P9_DEBUG_ERROR,
>>  			    "flushing writeback during setattr returned %d\n", retval);
>> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
>> index 643e759eacb2..362a68a2bca3 100644
>> --- a/fs/9p/vfs_inode_dotl.c
>> +++ b/fs/9p/vfs_inode_dotl.c
>> @@ -431,9 +431,9 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
>>  	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
>>  		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>>  		return 0;
>> -	} else if (v9ses->cache) {
>> +	} else if (v9ses->cache & CACHE_WRITEBACK) {
>
> OK, so here is an inconsistency between v9fs_vfs_getattr_dotl() and
> v9fs_vfs_getattr(). But to me it should be the other way around, i.e.
> v9fs_vfs_getattr() should do it any cache mode, not only for write-back?

My understanding was that dirty pages only exist with CACHE_WRITEBACK, so filemap_fdatawrite() would be a no-op for other modes. Is there a case I'm missing? Anyhow, even if this understanding is correct, this should probably be a separate patch.

Thanks for the review,
Pierre

> /Christian
>
>>  		if (S_ISREG(inode->i_mode)) {
>> -			int retval = filemap_fdatawrite(inode->i_mapping);
>> +			int retval = filemap_write_and_wait(inode->i_mapping);
>> 
>>  			if (retval)
>>  				p9_debug(P9_DEBUG_ERROR,
>> @@ -453,7 +453,12 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
>>  	if (IS_ERR(st))
>>  		return PTR_ERR(st);
>> 
>> -	v9fs_stat2inode_dotl(st, d_inode(dentry), 0);
>> +	/*
>> +	 * With writeback caching, the client is authoritative for i_size.
>> +	 * Don't let the server overwrite it with a potentially stale value.
>> +	 */
>> +	v9fs_stat2inode_dotl(st, d_inode(dentry),
>> +		(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);
>>  	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
>>  	/* Change block size to what the server returned */
>>  	stat->blksize = st->st_blksize;
>> @@ -561,7 +566,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
>> 
>>  	/* Write all dirty data */
>>  	if (S_ISREG(inode->i_mode)) {
>> -		retval = filemap_fdatawrite(inode->i_mapping);
>> +		retval = filemap_write_and_wait(inode->i_mapping);
>>  		if (retval < 0)
>>  			p9_debug(P9_DEBUG_ERROR,
>>  			    "Flushing file prior to setattr failed: %d\n", retval);
