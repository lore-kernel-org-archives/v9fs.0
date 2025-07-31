Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1462D023
	for <v9fs@lists.linux.dev>; Thu, 31 Jul 2025 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753925904; cv=none; b=Y70KhTFJgEgBaV7LSO7w/EmgDzxXz3dh6IsHDJX72S3Luk0QIgQgMmIyZMtRrY4T047eLiCy137sP4uFmWCvISxgwpTYug7aY40dqXuJYOhH/eZsyyJe7dx42kjABpeQRFmxkwSIQB9Yk5dG8VEBSEDP2P7V0eaJL111vPsx8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753925904; c=relaxed/simple;
	bh=8ya7e6/CKYInYotmvzdXqePRXf+We+Yf0/tthtPk6a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4b37ywHdRUFbOOtYpLP9CCjnKWrWtpYxZchqARS+N0uMXVMcZKoVlSB5C0O6soh4+zUS19XHiH5zkWkGEhwgLqDDYz6WoVwxcOBrj/ZIh9QEeHmcnE+lkqkP9iUH2ndj5Vx3ERdBbx9NCWOdugFI22sbtoOa0BdtxWjTQI3ERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoResCrK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoResCrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753925901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8OY69MZlq/xsrBb9axeH4pIVOb+xTllFUAYP1I6n5U=;
	b=eoResCrKY/eImi9tnrUH9YrCQ9NpWy70vSPKPBU5J+B+IpXvBr25dzxlaUn+563IlvxpZC
	MiYpzPaLPySj6Za9Y+LTV1sopC67SAbJa7ZNeq+mbQfMtt31XC3PEpE20HczlTFZ/JTRcS
	gzao7s2b8921ONQYZcpq1tY7fVy6fbs=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-mTpMHVDLMHqGTy5WLFLJuA-1; Wed, 30 Jul 2025 21:38:20 -0400
X-MC-Unique: mTpMHVDLMHqGTy5WLFLJuA-1
X-Mimecast-MFC-AGG-ID: mTpMHVDLMHqGTy5WLFLJuA_1753925899
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c2b11be82so31983039f.3
        for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 18:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753925899; x=1754530699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8OY69MZlq/xsrBb9axeH4pIVOb+xTllFUAYP1I6n5U=;
        b=IR+mGnGBOGAUYuTzx/R9gL7wHHkiM/1acyPkgCpnvUbJUOoTtZYvIGmJvJCuGTxjUk
         NHuNSEUsri4KNy8/N8PuHI66fFNU1MIgM+LgHomQmQsFddkP0kbZfRdmhIbu9pKg218h
         uM5sw+OCCXD3F+lt9unB6/eEdFFw0WF6AyhzCKq9n8c+qEtVNGfnjgc9LDEUGs5R+sV8
         OBUnvNJK8vX9lbIVbNQ542QJzlPAugj6Mluez6SmfyjMTgqJEK5LcM+XKHg+f7pFSxcj
         gHXUumPrzl1OEDt3Z8jFzjK10ENvPksTj/vA9M/R+4/108N+ljUQ+86BugGtXqQuOCK2
         1xwA==
X-Gm-Message-State: AOJu0YzD+SS/DkwEdfAJOzVoY+LWWnBjfld/kJLCONpOKrIWuzqZdw9I
	tehkrbORZGMvOkoWNVWP0MJiZqsb3tXYrXAj5e5X9n2IMxLL0D4ovLE61RXl7+KCAnS7IOwWS6j
	hWWEg0+1DHKt/i60zHp7Q4YO01EbO396Sh4rYazFpLx4QVJUyi3BuNYY=
X-Gm-Gg: ASbGncuLXjzhzm5UaabLtfslwc70C8q+q0M+D3+C3JV9vcOD/ULiJtkxtMu3t5t74xc
	PXFZqIdYEGxfQuuHw2rlUlj7n47CjRX+4opDmW4gMBEbZ/2HAK7JlpSyptE5FxKB9xVelJww6N/
	qYVbbOecWdmUrE7/RoNwLjyA1U4n2Tw/i/hwDtykmfZru0LM9rMlTmyXk5esDPMu7hm9egfadRX
	y68v7TpwiSnWThk9gg7BQimjWfPsJ+9KkRtjkmCdECvDnD9WQwml9lzEtrd1R7Iwzq380yN8z7S
	lmlLXnWZUHXNvZRoBEF6AllNUYf4UIgNzqJvJ3rncyUd/bVvuc+GcXoKieqElzeEcW06zD2Oixy
	3
X-Received: by 2002:a05:6602:1592:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-88138b04598mr1029069939f.14.1753925899506;
        Wed, 30 Jul 2025 18:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDYpvJqVTQun48scooKx53IQp8MzyEscpkj6Zf7fOtkrrh/YzKc++iz/oiD39bF32aJz1UpQ==
X-Received: by 2002:a05:6602:1592:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-88138b04598mr1029067239f.14.1753925899081;
        Wed, 30 Jul 2025 18:38:19 -0700 (PDT)
Received: from [10.0.0.82] (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8814dfa2282sm12147439f.27.2025.07.30.18.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 18:38:18 -0700 (PDT)
Message-ID: <fb7e2cc2-a13a-4ff7-b4ab-8f39492d3f76@redhat.com>
Date: Wed, 30 Jul 2025 20:38:17 -0500
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
To: asmadeus@codewreck.org
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 linux_oss@crudebyte.com, dhowells@redhat.com
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aIqa3cdv3whfNhfP@codewreck.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lvVBTbGpg8Y04_urUensQ03w4c2sBWD2HdOhBd0pB9s_1753925899
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 5:21 PM, asmadeus@codewreck.org wrote:
> Hi Eric,
> 
> Eric Sandeen wrote on Wed, Jul 30, 2025 at 02:18:51PM -0500:
>> This is an updated attempt to convert 9p to the new mount API. 9p is
>> one of the last conversions needed, possibly because it is one of the
>> trickier ones!
> 
> Thanks for this work!
> 
> I think the main contention point here is that we're moving some opaque
> logic that was in each transport into the common code, so e.g. an out of
> tree transport can no longer have its own options (not that I'm aware of
> such a transport existing anyway, so we probably don't have to worry
> about this)

I had not thought about out of tree transports. And I was a little unsure
about moving everything into fs/9p/* but I'm not sure I saw any other way
to do it in the new framework. @dhowells?

> OTOH this is also a blessing because 9p used to silently ignore unknown
> options, and will now properly refuse them (although it'd still silently
> ignore e.g. rdma options being set for a virtio mount -- I guess there's
> little harm in that as long as typos are caught?)

Well, that might be considered a regression. Such conversions have burned
us before, so if you want, it might be possible to keep the old more
permissive behavior ... I'd have to look, not sure.

> So I think I'm fine with the approach.
> 
>> I was able to test this to some degree, but I am not sure how to test
>> all transports; there may well be bugs here. It would be great to get
>> some feedback on whether this approach seems reasonable, and of course
>> any further review or testing would be most welcome.
> 
> I still want to de-dust my test setup with rdma over siw for lack of
> supported hardware, so I'll try to give it a try, but don't necessarily
> wait for me as I don't know when that'll be..

Cool, thanks.

-Eric

