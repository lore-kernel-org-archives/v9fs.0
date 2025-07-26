Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B77645
	for <v9fs@lists.linux.dev>; Sat, 26 Jul 2025 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753550269; cv=none; b=s7Fy2tW+LTp24OF75OEDgSGWQ/r5krIRAlKOS12wd619bU9PZ48JbAPUDgTqiDXUjXyCpffTA7SswceMvVT4C0LdewHve7quHv0MlgDjfLRXttrUHjrk9guGh20fRTb94KYiVqry26LOoBiuEC0t9ffU5W6Xvr9reaFeQiXvaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753550269; c=relaxed/simple;
	bh=tzgrnu8d3mp9TRH6qvtFbS/bE7fgfk9EpuHBP7fD82o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RscM2s2pQ2HxDbZZGv3u+NDanTm3/BG4NWN7FIeLF8ev9m1UsBnw0KZl+HwQMdtc6iXWAbbDmtX6M6Uk3jTkSoY2fmLcdGkmxG4ZDQ/y+rWSq5uFyyYBb9Zy6ZjX1IaXhnsrTlP/Z61L/Bwl5j4nT9cxMjDNzoSm8dlqz4CBojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPAPn8N1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPAPn8N1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753550266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIX30e5IuJLwIvO6qYMWSDW9J1JdyCtYW7xshMyArCU=;
	b=QPAPn8N1N4DPPdreG5VByeEHjM509Rjiz92D7FG7jA2DtkKK9x5iPs26u5OOjpIp469CtQ
	NwVThmo85C8f8HVpMKpBQSXmS4NZE9f2S1lhWMZV6HetytJaIYV44l+XknZNNIXijTv+GM
	LkSYFhZG637r3Ba/IKzy6a9JdCqvjzw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-gfdJCgaAMXymQICAcMtmhw-1; Sat, 26 Jul 2025 13:17:45 -0400
X-MC-Unique: gfdJCgaAMXymQICAcMtmhw-1
X-Mimecast-MFC-AGG-ID: gfdJCgaAMXymQICAcMtmhw_1753550264
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3928ad6176so2829807a12.3
        for <v9fs@lists.linux.dev>; Sat, 26 Jul 2025 10:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753550264; x=1754155064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIX30e5IuJLwIvO6qYMWSDW9J1JdyCtYW7xshMyArCU=;
        b=dvVxJ5HtyHGM4YFMNlnzv88nJ4lwj8arwyuU8IIgBhNI5bfEZXgJFCg4KIs/1tz7zc
         Wg91y+OGagBbXajpEluAinmXqWfFwN3j3bo+3PDRgdymAyEiZy7WdDe+Y4XvlHY4pwSz
         /Gh4is+y9MEfB41iQnhJN85tNFnJMlRWeScBgaCCc7FzkIvXrBsXjALvtteOZQ0EsF9i
         F5yf5iIYNF2rMHzRClBoTDul8Ir4X4ZNLGl/7fNjSWf66yv3bGzcomt167ayjyDELR+e
         zNJ+tz7VpuMZO1hPIiYyr+FVaBzDXnZ74UuRMD05sH0ulkOSnnoxJ0pR6G+NtLF5bfXA
         e8iA==
X-Gm-Message-State: AOJu0YwsFBQl7SnAZ1kqtRurVzsd7oJS8ccaEaBVHmtqWt6F8mmXfpk1
	MbDHBFdm3uF59A0I1oRM/zfW75tTLeEdIAhdSt5ZNUlK16uHfys6BvFiq9DV5HsKogRqP7h04WI
	LQPT4EzOdpMPeto1zBsdDTXXZptHHCk02f/h8VWtSnXXcrrO4mQZAa4m4/mCjQyQjjhJH3Fg3Su
	qrCW3YQIO+atrB6B/z10LjW/VVndsp9vEm7XFuKZ8U
X-Gm-Gg: ASbGncux3b858w6W1iDLfmsAh6J6wuIrtgEOsXWeQutK+75uoOyacJzW2kjdtUt2KgF
	YytbQsGGo9HrPH8i8h9cESZlo9Zzi9jqdqfLCVMJv3nmRti80a2HaycWljED3d3l5L+cbUK97+c
	3QycGHxF51RESG9XDAunngIlixLwTkpaFt4QZWHyEwPvN04/TFzr6x1cojUvlExGqbQP6DDPCGl
	3W6Y9kw85Jh/mnuCVpKvHCMqT3NWNUJje3SeoYEMS4054X54uVm700FsfQRkEMLAsQMGfQdR9l/
	4Tk8je96w4det2PtwQRebWzVplJp1i9s9vUdw2q+cAUgn5xInFY=
X-Received: by 2002:a17:90b:224d:b0:313:bdbf:36c0 with SMTP id 98e67ed59e1d1-31e7770b68fmr11050275a91.0.1753550263821;
        Sat, 26 Jul 2025 10:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEKhd5Akev2+FENT4yODkVUbHtUNVQwZNXTvrz7lCZz5AEx4SLrGwcpCCrk4XW7/9X8ZSmDw==
X-Received: by 2002:a17:90b:224d:b0:313:bdbf:36c0 with SMTP id 98e67ed59e1d1-31e7770b68fmr11050236a91.0.1753550263325;
        Sat, 26 Jul 2025 10:17:43 -0700 (PDT)
Received: from [10.0.0.185] ([172.56.107.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e833690e3sm2146547a91.18.2025.07.26.10.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 10:17:42 -0700 (PDT)
Message-ID: <c19be9ba-d164-4d43-bc03-c467584df3c4@redhat.com>
Date: Sat, 26 Jul 2025 10:17:41 -0700
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] 9p: create a v9fs_context structure to hold
 parsed options
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, David Howells <dhowells@redhat.com>
References: <20250724023325.16178-1-sandeen@redhat.com>
 <20250724023325.16178-4-sandeen@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250724023325.16178-4-sandeen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3J98X-0bjXTvS6-Q4bz6S6O0erufedaAQT9qADCcyIo_1753550264
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 9:23 PM, Eric Sandeen wrote:
> This patch creates a new v9fs_context structure which includes
> v9fs_session_info as well as p9_client, p9_fd_opts, and p9_rdma_opts
> to hold all parsed options. The new structure will be used in the next
> commit to pass all parsed options to the appropriate transports.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>  fs/9p/v9fs.h               | 49 ---------------------
>  include/net/9p/client.h    | 88 ++++++++++++++++++++++++++++++++++++++
>  include/net/9p/transport.h | 32 --------------
>  3 files changed, 88 insertions(+), 81 deletions(-)

This was a last-minute refactoring that I did not properly build-test,
it seems, I'll get it fixed up in the next version. Sorry about that.

-Eric

