Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394901CAA6C
	for <v9fs@lists.linux.dev>; Wed, 20 May 2026 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241409; cv=none; b=gjsg42r/7F2Jq9EmrlDLP1YXcE1DcIL8xEjTMyxFDUUpoMij2ncY4qCEI6ZccfbQ2L2kgnzOEECyuBukVBo4GZkNpGWwlRRa4j6H7kDLzCKD6K8AxqP1MIWS5/EXcJtyShK8Y0h9kdlD108VWQGfwYZ+8r7/Aubdk6Gnk9f4i0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241409; c=relaxed/simple;
	bh=y4ymFFk/MOyr0eZKFha4UOJPPaUP2MhOPzFuKOqTFZg=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=IXJ3Rw8pcX/JR+7Hl6oX3QdQUN1Ka67Oc9Z54wEj3IlqW2m7DlzK4/P+Ot1c6JKJY30ZV5gyPKc/CytsgDK7f1wquwYB0yS7mr/OA7VCjAweBDw9i6m+p0ifsWkqZneROhjezspNsEzvn4/1us1Fffq/rFiOONkuKsI81ZJczbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nwDNkISC; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nwDNkISC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=Y025+LnTwh/7ShQnSI1+4ZX/UDIlzb8hBuO/2oM7ckE=;
	b=nwDNkISCaDKDso+riVQHducAkpY/zzGWHIxGO4pHm6irgTEwZ0OnxRLEhpZ3Si
	hwDLlk22TmG2o6FdlkdjGAtXxHqPwPnMC4/3WTD8EgLD+mA4Z7G7RsVyKXm9dIxz
	yU9Z9gvyA5Lb8mnl5DAUCQBa3/4JT83q+tkVMUyv8y0kQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnLyKWEQ1qY0XFBw--.27471S2;
	Wed, 20 May 2026 09:42:47 +0800 (CST)
Message-ID: <6A0D119D.3070900@126.com>
Date: Wed, 20 May 2026 09:42:53 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: Dominique Martinet <asmadeus@codewreck.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] 9p: Fix mkdir to return NULL on success
References: <20260511061830.38373-1-zenghongling@kylinos.cn> <agxVvu6on5BXqb2J@codewreck.org>
In-Reply-To: <agxVvu6on5BXqb2J@codewreck.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnLyKWEQ1qY0XFBw--.27471S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryDAw1kWw1UGr1DXry7Jrb_yoW8Gw1rpF
	WUtwn8tas8J3s7Cws7GF43Xw1YqaySk397Jw1Sk34DZ3ZIk3W8Xr10g3sY93W8Wr4rtw45
	Za1xCwn5Gan8Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-sqJUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrxdHGGoNEZeSrAAA34

  Hi Dominique,

   Thanks for picking this up!

   I received David feedback suggesting to simplify v9fs_vfs_mkdir()
   by removing the 'err' variable and using ERR_CAST(). Since v1 is
   already merged, would you still like a v2, or shall I submit it 
separately?

   Best regards,
   Hongling
在 2026年05月19日 20:21, Dominique Martinet 写道:
> Hongling Zeng wrote on Mon, May 11, 2026 at 02:18:30PM +0800:
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
> Thanks, I've picked this up with s/Fix/make/ in the commit subject, as I
> (subjectively) don't consider this a fix given it's only a style change
>

