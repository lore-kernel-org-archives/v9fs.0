Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31001BD9C6
	for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953425; cv=none; b=m3rWhy9D3N2G5zMxW0krP8z+dVvEmfnwEMrmjRUzDBEBlZb/tYZMYSagUWyjM5WlAz0UMOwcpwBMaXVqjQ+XAQWmMUGhKmtX7GFjn/r79vpxDiFhVYtxv5s9/bPue/k0Q5pPpJMlwbrmyCzhPoJUMufOANtcsPHG7FOC7w1VFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953425; c=relaxed/simple;
	bh=B6dLX0PCMF6LNXVlJ1hYteBUz0wRZO8TkeZkHqtFabo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3BrCWwpkT2Ka/WPFMy2PYF0RRsWVoBDSTkTUMQg0WJjldWCZ5LYcRIN8WaGrDptsBb7hNUF9EZpK7DsVs3w3/6mNplbq6m35EWml5anrJ9YMUXlGsSYsH89gvZheoZaywQpmKwnG0227mb57anF/uUqJWQBCP4U+ZzeNMe9E4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDU/9XLB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDU/9XLB"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so1161109566b.1
        for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 13:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733953422; x=1734558222; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jANBAEDCtSv3pwk6q4Vw8RKGkd4R1NtNTLdDCiJ5iYA=;
        b=UDU/9XLB7dmqX5NAOYbchZaPOZIeD1RXYSVf+PaMyZB5vVCgRIHRKmLyEBXyWu1m/9
         +SIwkti+YJt2EVRcrRC3SW6WuCmQhfudWplIDTPUM2glzSdXj/nKNU61MBWQE7GUED5Z
         rqIRJAaMyBZhf1ShJz5cx1ZZKjeIfcDDgknh2JZeUQUACTMJINHwTNzTDBZXnpZKK2l4
         DwGxLSUsvh97UfzzuZd+7hfiwf60ivkXVmVUD25qoeM3zvGqIMsHPqsbvlC16U1BXGIj
         DOfC97xm9WdTswZlxJZDKWbA/UIwcUXxTFCdTPwQsZaVSzsyO604KceYsbluvrs0Js6a
         1I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733953422; x=1734558222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jANBAEDCtSv3pwk6q4Vw8RKGkd4R1NtNTLdDCiJ5iYA=;
        b=iS9XYHDY3coMii6weLWp6LTWrtyqzcw9Vm60OpD4zTZ1huchkPfKKxWAU8YGODEe7l
         8jmjkJjtxQi3xhcHKNZk+GC3C5ztuyuiX28BtNUqedTMdS0svw8nf6lQzgSVphQTYacl
         o4kdtfwN+6Oz7jHxhzf2P4SOmIcbL0dvyv6V9p/Dejkh6ZhuZKxRr9QVYPn6HlwxMe/c
         wWmhm30fFqM7eOD7n5n8w0kKUPIgTja4l8Er5A4Mj1ziawJ20mI4fVqXzjp3CAS+Oxak
         etaRcKPbKeg+acn2ZiSGn4+TaF+3PyFzX0YKcZmQIfBA5/kv4+FXYNqFI/tXK27O07DP
         Bp8A==
X-Forwarded-Encrypted: i=1; AJvYcCXNlpQgjKRAzO9UOdhRt5dd3pY6IazUU6N4qOhE4vJTyxtiicPlMlpuXitdCTXNkS7meUV/@lists.linux.dev
X-Gm-Message-State: AOJu0YwTUIKgi9zsmKJm3ecSaGHv+2zMqJiK/tovws+Z9NTXeJ/DRR1j
	Qk/GXVUFm7wZONXmGgMENgs+3+I6G4wOeZ5pICgjOajO00rKyYof
X-Gm-Gg: ASbGncsK9oB9o1Lg0UlLOnuKjmSqTWfxYailPZww/98P32Pdr/2UsGcRYAEz6Q3ETST
	qz3H0T05rE3IC9n0dUk2PRwvex37trTcxfbNReXRXzoJOaCtn1LKnEVmA6DWJwRjw3GwtQVAtD7
	Yh/yTUuSfyCP/HaOP/ikXsYl1A9G4bsHWfAUV/3wAnObCAooKjOLIEV7VTDWtD6/FMP0h2RqfY4
	7GJB28lwOqZu8p+mc9ZEsR5pjWYJlp+79J/9LC4eBCcgf04gMwTA2s7uDRE0+ZfK8rm4SGvalN0
	hd4nww==
X-Google-Smtp-Source: AGHT+IHBaSDKbo7EyeuaVv+rCE+2o82gIsnu/jmJ9j1vGzncTgHiyB1QwqkT1BK6tAWSzDDQjpG1mw==
X-Received: by 2002:a05:6402:4583:b0:5d0:8f1c:d9d7 with SMTP id 4fb4d7f45d1cf-5d4330358cbmr11222914a12.4.1733953422181;
        Wed, 11 Dec 2024 13:43:42 -0800 (PST)
Received: from [192.168.178.20] (dh207-42-21.xnet.hr. [88.207.42.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a394d380sm304768966b.77.2024.12.11.13.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:43:40 -0800 (PST)
Message-ID: <f09bbd18-98bf-4424-9a7e-c5477c52a771@gmail.com>
Date: Wed, 11 Dec 2024 22:42:39 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net/9p/usbg: fix handling of the failed kzalloc()
 memory allocation
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>
References: <20241109211840.721226-2-mtodorovac69@gmail.com>
 <ZzhXCi_0m3X2AHpJ@codewreck.org>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <ZzhXCi_0m3X2AHpJ@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/16/24 09:25, Dominique Martinet wrote:
> Mirsad Todorovac wrote on Sat, Nov 09, 2024 at 10:18:41PM +0100:
>> On the linux-next, next-20241108 vanilla kernel, the coccinelle tool gave the
>> following error report:
>>
>> ./net/9p/trans_usbg.c:912:5-11: ERROR: allocation function on line 911 returns
>> NULL not ERR_PTR on failure
>>
>> kzalloc() failure is fixed to handle the NULL return case on the memory exhaustion.
> 
> Thank you, I've taken this in 9p-next and will submit it to Linus next
> cycle

Hi, Dominique,

Sorry for the late reply, but yes, it is perfectly OK for the patch to go with the
next cycle.

I confirm I can see the commit in the torvalds tree, so this is a minor patch (+2/-2 lines),
but a proof of concept that it can be done.

Best regards,
Mirsad Todorovac

