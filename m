Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B4F6F38E
	for <v9fs@lists.linux.dev>; Tue, 10 Oct 2023 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id C0BAE60313E9A;
	Tue, 10 Oct 2023 09:20:13 +0800 (CST)
Message-ID: <e54d667c-58a5-4456-dda8-3a01d25c2489@nfschina.com>
Date: Tue, 10 Oct 2023 09:20:13 +0800
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Content-Language: en-US
To: Christian Schoenebeck <linux_oss@crudebyte.com>, ericvh@kernel.org,
 lucho@ionkov.net, asmadeus@codewreck.org, v9fs@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <13910281.Zj71IQSfG8@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/10/10 02:34, Christian Schoenebeck wrote:
> On Sunday, October 8, 2023 8:01:39 AM CEST Su Hui wrote:
>> with gcc and W=1 option, there's a warning like this:
>>
>> In file included from fs/9p/xattr.c:12:
>> In function ‘v9fs_xattr_get’,
>>      inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
>> include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
>> [-Werror=format-overflow=]
>>     55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
>>        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> use "" replace NULL to silence this warning.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   fs/9p/xattr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
>> index e00cf8109b3f..d995ee080835 100644
>> --- a/fs/9p/xattr.c
>> +++ b/fs/9p/xattr.c
>> @@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
>>   
>>   ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>>   {
>> -	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
>> +	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
>>   }
>>   
>>   static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
>>
> Mmm, that's not the same is it? Have you tested this change?
Oh, sorry.  That's not the same and I just tested compilation.
>
> Currently this function causes a 'Txattrwalk' 9p message to be sent to 9p
> server with its name[s] field being NULL, and the latter being the magical
> hint to 9p server to not send an attribute, but rather the list of attributes.
>
> With your change I would assume that it would rather ask server for one
> attribute called "". I have not tested myself, just worrying that it might
> break behaviour.
Got it, I made a mistake there. Thanks for your explanation.
Sorry for the noise again.

Su Hui


