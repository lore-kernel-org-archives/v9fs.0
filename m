Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEF3CBE91
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089592; cv=none; b=EaY4OAOcNvesJnV7BEeS8WtJpB2/NMrz46n4EWtuRQ/v6JZOjvp3D4ZZa9e/7CddMN0iqzuoFQ5T1tIvjpWUOjV5UVjIVIpCdTCYwfpFUlgHG0xOPU5YFC/ys4KW6XQw9/OUc+J/34ArKu1LSgs926M1Alv+L7Xv3SkD3fGCtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089592; c=relaxed/simple;
	bh=JoU/3Dkj/9YEnuUZuII+fhfJ6507H845sf1Hi1WSLBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KJU6S8Bqvcau+Ac44azbQq1aeKVxWhraOXqtXFCaC5vO8B4Jm0I6osmSV+/sO7aVPH/0ZSgkI81URK+sn96AKg2I/DMJqhX1pyI1FtGUYXbGigtPmXM0/0qsjr7grzl7AzCi9o+AfsX23GOknqZllQjK1fiay37DvmteMYn464g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9UA+iQU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9UA+iQU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783089589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8pJUCifTPKIbVhgb7JXPqQOckc/dWstQL8e0QRVlhQM=;
	b=a9UA+iQUfoag2waI5QGAQ5+iuqj9VkeKOt5gygwsdgtFLv27LSEPicqKvTIzgUOfGVHWrE
	wvOR/R78jEByef2DjZPH3bG4xzcAQt6hnFYudRjVU/hruF6TdY6MItrmD8H3yswpJ9ypBc
	koiXoEV9/dL6+pW3PBmFzliQozPqDhk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-A6q9I9rcNq-MzmFJIO0J2Q-1; Fri, 03 Jul 2026 10:39:48 -0400
X-MC-Unique: A6q9I9rcNq-MzmFJIO0J2Q-1
X-Mimecast-MFC-AGG-ID: A6q9I9rcNq-MzmFJIO0J2Q_1783089587
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4729d2a64efso1314280f8f.0
        for <v9fs@lists.linux.dev>; Fri, 03 Jul 2026 07:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783089587; x=1783694387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pJUCifTPKIbVhgb7JXPqQOckc/dWstQL8e0QRVlhQM=;
        b=WkvM4aJOJh6FZt9sJSknwCYWmJ62e1jmXNKhwrnpEtKGPsPUgZEL4LxStoF1jkDgsC
         6LE/QYGmS/940SMxL6pE+qskChyZ2Z+NF/hskzb0gDOt6nAjV3fxkAbRsCV2fjGwKAVD
         lBYufe9tEMn6k8pG9XnBrDgQSJoHo1ujhh/VVTXBf1qzDVDOmnLiuPrsRHS/kRBzBzit
         xo78lqKXYU71s3cP+dNilov/iN9GPhZv2N0hLMawnl7/yYB9RjlHWquFfA0S3p8WyI7J
         rN1so2x7ODU/UCUO6u9qye0lOGTrl7KZcJZ1twmvb5xBj63/Cd82QnE83xox5fJp8N+S
         yLfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rptau4KRHtRWzHEu6qgZEa0upGI0KFn7as3ZwLspbAo8AELrB3R6l7j1gXgSWEO3V1LZ321@lists.linux.dev
X-Gm-Message-State: AOJu0YxYHgZ7CWNnXXzArtoi2X8N7SXYVhlaEXdGWuor8quD7W8ep6Ia
	fotnHWTGpJrudvwnDAadaIXlFbqJeYckJvDC3GnrLdgfL4tlkLX93N3i/b/mC1mySjwiipBrCFa
	mzjCVvmAF1NAlX7gGW7R5WMGunRnTV71gUYmWK6HKtCTFcWfSnyQJlnVtjjeVztk=
X-Gm-Gg: AfdE7cmySMKH+ufMB1u3Y/A54eaIR5Am0eBlUY7LC0sQV+/HI6sw6w3bzGdrUHYC3kU
	xTAsrND/+mZ2oCvqTvResxH+DRejNk3cp677k0JNFrd2Y0uWRYkHs5/APY4dZZTxCx5baE2vQF8
	A8CUfYKtIGwGMdFSq1H2HoMDPwY7JNjTxjnIpryZUNSPkG4xd2fmJXClr2rnRR57PdWDmOBwb/P
	bxW9uvcEzhDHhS56imJ+pwzCFY0rY0VNyoK4wPr3bffTK0GHfOAi0e85hdFoUutTWl1hqsCY8e7
	x5pM5GP+oxihCT1aV2HaNT19YuFFNBK7G24gZMe7KN6SePZEtplTGWjRyFy+3wwwTc7ML1Cnc+6
	b2XdnIHO/xVjdnH8tAZ81qyLkW006b98ZPld/+yyY7IS0aUZOjlwMajToJCxs
X-Received: by 2002:a05:6000:5c4:b0:471:dfb3:772 with SMTP id ffacd0b85a97d-4793686030fmr5819010f8f.15.1783089587072;
        Fri, 03 Jul 2026 07:39:47 -0700 (PDT)
X-Received: by 2002:a05:6000:5c4:b0:471:dfb3:772 with SMTP id ffacd0b85a97d-4793686030fmr5818974f8f.15.1783089586562;
        Fri, 03 Jul 2026 07:39:46 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4b73sm18260260f8f.15.2026.07.03.07.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:39:45 -0700 (PDT)
Date: Fri, 3 Jul 2026 16:39:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: skvarlamatus@gmail.com
Cc: asmadeus@codewreck.org, ericvh@kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, stefanha@redhat.com, 
	v9fs@lists.linux.dev
Subject: Re: [PATCH v2] net/9p: add vsock transport
Message-ID: <akfJDhVJKMXiX4KH@sgarzare-redhat>
References: <akd7QliTAWpkmE0Q@sgarzare-redhat>
 <20260703143125.45423-1-skvarlamatus@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260703143125.45423-1-skvarlamatus@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DUcMLZFcmI2v21Dv2eLvrOp-MHsMYyRAPXQ24Nwnj3k_1783089587
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jul 03, 2026 at 04:31:25PM +0200, skvarlamatus@gmail.com wrote:
>On Fri, Jul 03, 2026 at 09:12 +0000, sgarzare@redhat.com wrote:
>> >The privport mount option is not currently supported for vsock and
>> >returns -EOPNOTSUPP if specified.
>>
>> Why not?
>
>The existing p9_bind_privport() implementation is TCP-specific
>(uses inet_pton and struct sockaddr_in), so it cannot be reused
>for vsock directly. Per Stefan Hajnoczi's suggestion, I opted to
>reject the option cleanly for now rather than leave it silently

Ah, I see now. Sorry, I didn't look at the v1.

>ignored. Support can be added in a follow-up if needed.

I'd add a comment in the code to explain that, maybe with a TODO label.  
Because initially I thought it was not applicable to AF_VSOCK sockets 
for some reason related to he socket family.

Thanks,
Stefano

