Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038D41A8F
	for <v9fs@lists.linux.dev>; Sat, 26 Jul 2025 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753554750; cv=none; b=gGlbMwms+UTOEyIb8Rg0jI7qpkftmGjZpMJ3XcLxnFKqK/DCRfFt4l+QbaOB0eSNW+grjdnJlK+uyo42gSOQmEg+w5p+Ro5cwINZDB6Lt8f2KZ2OZFAU3UDVTZYaz+FHevWkGQ8sQD2HO++Ke9b0AVzfvM2fgKhCdVrfPTpv+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753554750; c=relaxed/simple;
	bh=VZZ5nJ6uZcWAZNmka8Wdhrr5kFIGG/4ZvATvKl/YWak=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bGUDAzfaco0KhYvPBuq3eQW/avOcPmi08iBoTUdMawwaSx/Iaixkj3/60wkhZTbgfN2j0LwicWoy4kCZGdzh0888KVOCl/Lf/2kXApV2F4/ZWrFxw83Z+uSceK74aahxgGB1OFG+xF6S6U3M+R2R7ltWqYrLUvN6ZSwkkF97KHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/YQaa+4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/YQaa+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753554747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycNAGwVQ8zsz6cuQbxt3DHpMOyt+trcmT7C1JZvetQA=;
	b=h/YQaa+4VLRkpCjQKoJHJsUqIdajGdECZ1rhw4MUGE8EinsSA3yrKLyuVpwo7FQY9vudqw
	5w699tc0h09fh82UUoQpBmx5rj/Ddxo3uDwVmGb1VVQVJPIDhW0utdlb9sf9h0TPRh4a2n
	YRlwaTml6rpORh6Z1O83PH4WLMiU/+4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-6z3k-RoyMRuO5prDI2oo-w-1; Sat, 26 Jul 2025 14:32:24 -0400
X-MC-Unique: 6z3k-RoyMRuO5prDI2oo-w-1
X-Mimecast-MFC-AGG-ID: 6z3k-RoyMRuO5prDI2oo-w_1753554743
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23ff063d087so1627435ad.1
        for <v9fs@lists.linux.dev>; Sat, 26 Jul 2025 11:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753554743; x=1754159543;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycNAGwVQ8zsz6cuQbxt3DHpMOyt+trcmT7C1JZvetQA=;
        b=ItxjMwJ8A+lrnhtU6/1mwD4SKPUSe3Lph3xovUzDJkmRN9H+52aUAr+cSMUITYBe83
         NWrGWhYowSHPgA2PaKg7uuxSPvXhpBQ7S3z/qlSJ8g7Z6cIsfJ61d4PLd/zd2XEsHVo7
         pBNgYw+VXiVRoHYo3ljQxaQ2ilC5JKoa0W1NUZcgLInZ5rMtbrl1kmGISz1iJ2/YfLiZ
         W1O3qWRYQcDS4VjYFfoSCsLsgecLoKueWQ7LseuQhdUruSqPlfuBoQEFBFjVSJe+qvNs
         wXWDASaPizdC//S4P2EfQPKXlVmthcGIoU6rZXimVYIVS6Hz0wd3pDY3vf5zlCCgX7m2
         fPow==
X-Gm-Message-State: AOJu0YwfJ+KlTcIT33jRvKMRXY9j3Eyji+tVno9en8vQmAhO0E8jTYJX
	3a2e67UWtq9UHuPBtX/hrdJ3ee3Beih8MqqqBBp3ibFmJq3qSkBTKuxkh65AaHLZ7kjlgc16l2D
	IE0HrvZh93UUUU1gITj6XyIKg1vngU+oxwpKTvUE2rWl9syPdzHgRSQRPEkv38Sl/xoZh4iv7w0
	mu/WWYxPeeTF61C7CLtXDGI91oIwyU6e1U5wLppd5I
X-Gm-Gg: ASbGncsiXXqcPilorijpeo+V8Q2tTFkCNbHTvLzOGKVvBZL9PhMJdzKWCY3Pl2BG1i2
	YTkd+J7moCRi5S3W0hbVHQQ8/3KfeDF9dWWXlG9Y+XE8HPPk3WmWB8LASByzPBMS0nkSrPh6gXX
	pxSJyWJu39RJ7KUu7fmNIoMyD5ng9H3/j+yjCKMw+iO2VjIUAV7NXSoEoAj4/o/vsDHsSxk4kg4
	SMA1cOK+IQJRJFH8TqjDfOoKRTu6ncl2dpEpEoNg+glA+86leQ7VV2CrGj5Mkei4ccHu+B3LZO1
	5zforJhrFR7ORCuuw6WIeg/F+xf/mh3d2PTF0DfFmk9mqm37Ig4=
X-Received: by 2002:a17:903:1c6:b0:234:ed31:fc98 with SMTP id d9443c01a7336-23fb3155ed8mr85429505ad.37.1753554742714;
        Sat, 26 Jul 2025 11:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUIDnVTg8Yx87CkCOT+Csk4T9BpHg5JR7D8Gzb3r7hqXly/VV3uLaUtqHcG9gy4GUlJO9KuA==
X-Received: by 2002:a17:903:1c6:b0:234:ed31:fc98 with SMTP id d9443c01a7336-23fb3155ed8mr85429275ad.37.1753554742259;
        Sat, 26 Jul 2025 11:32:22 -0700 (PDT)
Received: from [10.0.0.185] ([172.56.107.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8336831dsm2244420a91.17.2025.07.26.11.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 11:32:21 -0700 (PDT)
Message-ID: <c15e7b2f-d570-4465-9677-d114fecb9b13@redhat.com>
Date: Sat, 26 Jul 2025 11:32:20 -0700
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] 9p: create a v9fs_context structure to hold
 parsed options
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, David Howells <dhowells@redhat.com>
References: <20250724023325.16178-1-sandeen@redhat.com>
 <20250724023325.16178-4-sandeen@redhat.com>
 <c19be9ba-d164-4d43-bc03-c467584df3c4@redhat.com>
In-Reply-To: <c19be9ba-d164-4d43-bc03-c467584df3c4@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _av9I9q5WOQzFoPt5Fi0nrqbSGLwPM81lAF3HLCKD8s_1753554743
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/25 12:17 PM, Eric Sandeen wrote:
> On 7/23/25 9:23 PM, Eric Sandeen wrote:
>> This patch creates a new v9fs_context structure which includes
>> v9fs_session_info as well as p9_client, p9_fd_opts, and p9_rdma_opts
>> to hold all parsed options. The new structure will be used in the next
>> commit to pass all parsed options to the appropriate transports.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>  fs/9p/v9fs.h               | 49 ---------------------
>>  include/net/9p/client.h    | 88 ++++++++++++++++++++++++++++++++++++++
>>  include/net/9p/transport.h | 32 --------------
>>  3 files changed, 88 insertions(+), 81 deletions(-)
> 
> This was a last-minute refactoring that I did not properly build-test,
> it seems, I'll get it fixed up in the next version. Sorry about that.
> 
> -Eric
> 

I just failed to build/test with fscache. This should fix it if anyone
wants to do early testing. Will clean this up in V2.

diff -Nurp korg/fs/9p/cache.c linux/fs/9p/cache.c
--- korg/fs/9p/cache.c	2025-07-26 13:25:29.082858321 -0500
+++ linux/fs/9p/cache.c	2025-07-26 12:48:13.518471053 -0500
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <net/9p/9p.h>
+#include <net/9p/client.h>
 
 #include "v9fs.h"
 #include "cache.h"
diff -Nurp korg/fs/9p/v9fs.c linux/fs/9p/v9fs.c
--- korg/fs/9p/v9fs.c	2025-07-26 13:26:38.191669609 -0500
+++ linux/fs/9p/v9fs.c	2025-07-26 13:08:52.598712843 -0500
@@ -463,7 +462,7 @@ struct p9_fid *v9fs_session_init(struct
 #ifdef CONFIG_9P_FSCACHE
 	/* register the session for caching */
 	if (v9ses->cache & CACHE_FSCACHE) {
-		rc = v9fs_cache_session_get_cookie(v9ses, dev_name);
+		rc = v9fs_cache_session_get_cookie(v9ses, fc->source);
 		if (rc < 0)
 			goto err_clnt;
 	}

