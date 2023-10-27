Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2119C
	for <v9fs@lists.linux.dev>; Fri, 27 Oct 2023 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECBeVtof"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-6bd20c30831so349133b3a.1
        for <v9fs@lists.linux.dev>; Thu, 26 Oct 2023 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698374477; x=1698979277; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Y45Kg1FVvOUrUmxNTyFscKK00f1fFAimD2L0qeIY8U=;
        b=ECBeVtofXYY519p/chn5ppn7IHt2Kqi/n3zTMwqL/tZlWiVB18ThS0dr+8z733XStf
         E9TEtTkzZqGlJCLKgsIEJ2hhC0zliTmk9eg1Z2lNUTnXBwVgMiPKAGJw+8aFPK8KiZbZ
         1XI/RWDh7ffKIvZ+3j0wqhp5IbsFf+YdhXgXnhvANfjx3nxZnp/MmutZz8aW3B6S6B3K
         nr+oNgkZKWxU8Ha+s+i79b3DQkLA2DVq1zbpbJnahITcJ02dJ9Rr4mVrBERPCb+IpkKs
         KUsxWy7DqKDTa9Rjg+6J4euVsCrBasLkz5RwmpOgD3UiOn/hoBeCb+uF99G2qHSFKB78
         BPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698374477; x=1698979277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y45Kg1FVvOUrUmxNTyFscKK00f1fFAimD2L0qeIY8U=;
        b=WGehpM9LXk24S3c9SGik+Cwt+oCx9YbmJm9EMSCon40eDlHMrupq3bKsFT+Ibhc8jO
         Smgp8x5F0PLt2g/0+JdEPIBX2KgCPN1NG+5Pm+d/wRPJpUNLuAfsxMPawzD8iv0OKOJb
         cgNIpJbnurRzMhVxNI9PC/6l4uOPm1w40GgNbd/PgojkWFL1z0zsm/Wj5nBDMtn9SgjQ
         j34XpkPNndNdeOo5/ZoapZ8QtfX7gu0Z4VMUEG2DjyYcpqBlk32S856Ddty+0kC8qxWI
         s+ELc36TRyzNXjZloqWjPEP6ORuSP6g7zNGJovKGiplr68pvXi9TFecxS/4xMj54bMTz
         rU5Q==
X-Gm-Message-State: AOJu0YzPkICOJzmDAXO/EoN5KXDesS6G409IqYbYz3I4E+RD9GtznJFa
	E4CK+txP48MwjV8/pTX07wk=
X-Google-Smtp-Source: AGHT+IEdvyLE2DgnauF9a83HstUljP8iblHqKFnHxJKPWxoaD4Km4Z6EVpXrPAgNqUAmRCnnM75Sag==
X-Received: by 2002:a05:6a21:7899:b0:14e:2c56:7b02 with SMTP id bf25-20020a056a21789900b0014e2c567b02mr1928136pzc.0.1698374477451;
        Thu, 26 Oct 2023 19:41:17 -0700 (PDT)
Received: from [127.0.0.1] (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902d38900b001ca82a4a9c8sm366382pld.269.2023.10.26.19.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 19:41:16 -0700 (PDT)
Message-ID: <0f6ebc50-06d6-4e3d-b296-1045b0255c8a@gmail.com>
Date: Fri, 27 Oct 2023 10:41:08 +0800
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: 9p: fix possible memory leak in p9_check_errors()
Content-Language: en-US
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jvrao@linux.vnet.ibm.com, v9fs@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231026092351.30572-1-hbh25y@gmail.com>
 <ZTpTU8-1zn_P22QX@codewreck.org>
From: Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <ZTpTU8-1zn_P22QX@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/10/2023 19:53, asmadeus@codewreck.org wrote:
> 
> Hangyu Hua wrote on Thu, Oct 26, 2023 at 05:23:51PM +0800:
>> When p9pdu_readf is called with "s?d" attribute, it allocates a pointer
>> that will store a string. But when p9pdu_readf() fails while handling "d"
>> then this pointer will not be freed in p9_check_errors.
> 
> Right, that sounds correct to me.
> 
> Out of curiosity how did you notice this? The leak shouldn't happen with
> any valid server.

I just found that any attributes that require memory allocation are 
prone to errors when mixed with ordinary attributes.

> 
> This cannot break anything so I'll push this to -next tomorrow and
> submit to Linus next week

Agreed.

> 
>> Fixes: ca41bb3e21d7 ("[net/9p] Handle Zero Copy TREAD/RERROR case in !dotl case.")
> 
> This commit moves this code a bit, but the p9pdu_readf call predates
> it -- in this case the Fixes tag is probably not useful; this affects
> all maintained kernels.
> 
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   net/9p/client.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 86bbc7147fc1..6c7cd765b714 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -540,12 +540,15 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>>   		return 0;
>>   
>>   	if (!p9_is_proto_dotl(c)) {
>> -		char *ename;
>> +		char *ename = NULL;
>>   
>>   		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
>>   				  &ename, &ecode);
>> -		if (err)
>> +		if (err) {
>> +			if (ename != NULL)
>> +				kfree(ename);
> 
> Don't check for NULL before kfree - kfree does it.
> If that's the only remark you get I can fix it when applying the commit
> on my side.

I get it. I will revise it based on your and Christian's comments and 
send a v2.

Thanks,
Hangyu

> 
> 
>>   			goto out_err;
>> +		}
>>   
>>   		if (p9_is_proto_dotu(c) && ecode < 512)
>>   			err = -ecode;
> 
