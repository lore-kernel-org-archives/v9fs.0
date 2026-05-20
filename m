Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCD258EC1
	for <v9fs@lists.linux.dev>; Wed, 20 May 2026 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240321; cv=none; b=fqWwjjQ01NcpCFAiYNtA2CWybFyA4rIgAydLIZAhEfha3dttKBaco0DB/KfJqfBu86UyyTqvAUO71GRlIYkQvFIuJET9hrf23qdvyKC3p/elUyvFHuR4kMAN2qnNmdmZdkUhbETJhZsohWgoVexXUAUfk6O73vlLZPQNGwMVxiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240321; c=relaxed/simple;
	bh=Ayg9QZdfhHbEDzBPSbJd/qQ+4muJCh55LSQVLcIAu1o=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=DhHBWLc45o+ImRkQGsJRwHyEfhgQh9m+pjWrIIMqLXT/OMXV+NDu0JTtHxaZoV3I2hhGC5pOEb/4fXuc7XF2h850BY6blmAM5rZ8Xu88sTjpO1pBg6KCXr6fxXL60ExpbLEqvdFsMX9odMb1kwB6nZprvdzqhW9yhBYbXjrq+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=aiszmvCe; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="aiszmvCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=c6oI5kdk7nCao8oggoBmpnu2ZOCQfYXqNXrFl4cQe0M=;
	b=aiszmvCeJFeUtZeYumTfWgEWO3nfRpW6Bzx7iS4F3Ciug+nywYWYYfEJORXmKv
	H8hECbPWFTKImAKNNIaphmDdejSJiLJ+0u6TZIWuY14L2Te/a8PrQedeYesG70sE
	CP7AXDhadDghlYjsWKb592qcTUv5Czro7zX5vQQGU/SGY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgDnz7JUDQ1qtFOGFw--.58608S2;
	Wed, 20 May 2026 09:24:36 +0800 (CST)
Message-ID: <6A0D0D5E.5070900@126.com>
Date: Wed, 20 May 2026 09:24:46 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: David Laight <david.laight.linux@gmail.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org, 
 linux_oss@crudebyte.com, v9fs@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] 9p: Fix mkdir to return NULL on success
References: <20260511061830.38373-1-zenghongling@kylinos.cn> <20260519183532.04e8e8f2@pumpkin>
In-Reply-To: <20260519183532.04e8e8f2@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgDnz7JUDQ1qtFOGFw--.58608S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry8ZFWrCr4DCr4kJFyDGFg_yoWrGF17pF
	W8GF1vyFs8X34xWF4SkF4UX3WSqF43Kr48Wr1xKasYy3ZIqr1UtF48G34Yk3Z5Cr48Gw1Y
	qF4j93Z5uF4fCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-WrJUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrhU2B2oNDVU-IAAA3q

   Thank you for the review. You're right about the unnecessary err variable
   and NULL check - v9fs_create() never returns NULL and p9_fid_put() 
handles
   both NULL and IS_ERR cases internally.

   I'll prepare a v2 patch with the simplified implementation as suggested.

   Regards,
   Hongling Zeng

在 2026年05月20日 01:35, David Laight 写道:
> On Mon, 11 May 2026 14:18:30 +0800
> Hongling Zeng <zenghongling@kylinos.cn> wrote:
>
>> When mkdir succeeds, v9fs_vfs_mkdir_dotl() and v9fs_vfs_mkdir() return
>> ERR_PTR(0) which is incorrect. They should return NULL instead for
>> success and ERR_PTR() only with negative error codes for failure.
>>
>> Return NULL instead of passing to ERR_PTR while err is zero
>> Fixes smatch warnings:
>>    fs/9p/vfs_inode_dotl.c:420 v9fs_vfs_mkdir_dotl() warn: passing zero to 'ERR_PTR'
>>    fs/9p/vfs_inode.c:695 v9fs_vfs_mkdir() warn: passing zero to 'ERR_PTR'
>>
>> This change does not alter the runtime behavior since ERR_PTR(0) and NULL
>> are equivalent. However, it improves code readability and silences static
>> analyzer warnings.
>>
>> Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
>> Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>>
>> ---
>> change inv1:
>> - Add clarification in commit message that this is not a functional
>>    change, as suggested by Christian Schoenebeck.
>> - Add acked-by.
>> ---
>> ---
>>   fs/9p/vfs_inode.c      | 5 ++---
>>   fs/9p/vfs_inode_dotl.c | 4 ++--
>>   2 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
>> index d1508b1fe109..d2d18c796b58 100644
>> --- a/fs/9p/vfs_inode.c
>> +++ b/fs/9p/vfs_inode.c
>> @@ -672,13 +672,12 @@ v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
>>   static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>>   				     struct dentry *dentry, umode_t mode)
>>   {
>> -	int err;
>> +	int err = 0;
>>   	u32 perm;
>>   	struct p9_fid *fid;
>>   	struct v9fs_session_info *v9ses;
>>   
>>   	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
>> -	err = 0;
>>   	v9ses = v9fs_inode2v9ses(dir);
>>   	perm = unixmode2p9mode(v9ses, mode | S_IFDIR);
>>   	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, P9_OREAD);
>> @@ -692,7 +691,7 @@ static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>>   
>>   	if (fid)
>>   		p9_fid_put(fid);
>> -	return ERR_PTR(err);
>> +	return err ? ERR_PTR(err) : NULL;
>>   }
> That function is odd, it ends:
> 	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, P9_OREAD);
> 	if (IS_ERR(fid)) {
> 		err = PTR_ERR(fid);
> 		fid = NULL;
>
> A 'return' here would solve the mess later on.
>
> 	} else {
> 		inc_nlink(dir);
> 		v9fs_invalidate_inode_attr(dir);
> 	}
>
> Can v9fs_create() even return NULL?
> In any case p9_fid_put() already contains an (inline) check for both
> NULL and IS_ERR() so the 'if (fid)' and 'fid == NULL' (above) are pointless.
>
> 	if (fid)
> 		p9_fid_put(fid);
> 	return ERR_PTR(err);
>
> -- David
>
>>   
>>   /**
>> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
>> index 71796a89bcf4..83a52a85ce08 100644
>> --- a/fs/9p/vfs_inode_dotl.c
>> +++ b/fs/9p/vfs_inode_dotl.c
>> @@ -349,7 +349,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
>>   					  struct inode *dir, struct dentry *dentry,
>>   					  umode_t omode)
>>   {
>> -	int err;
>> +	int err = 0;
>>   	struct v9fs_session_info *v9ses;
>>   	struct p9_fid *fid = NULL, *dfid = NULL;
>>   	kgid_t gid;
>> @@ -412,7 +412,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
>>   	p9_fid_put(fid);
>>   	v9fs_put_acl(dacl, pacl);
>>   	p9_fid_put(dfid);
>> -	return ERR_PTR(err);
>> +	return err ? ERR_PTR(err) : NULL;
>>   }
>>   
>>   static int

