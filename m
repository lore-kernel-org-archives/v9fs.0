Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E7276046
	for <v9fs@lists.linux.dev>; Tue,  2 Dec 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764713562; cv=none; b=CCGbQznevxgLpldsemkGxxNFTFzrbZDSf2CslVCJ5neNizk4DZ9eqQ+JsVBIv7njBvCa1BtYQf3M6vli0Vrvts8g9SHlAunFIK12tZlMNfhXqoruMekVNEgm7Vq/J/1FOyPCWDd7rhDjj/ZkHhxr+G1aIW3ZdHlRPLR/yA56SEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764713562; c=relaxed/simple;
	bh=DFk6jkyVaJz5NFepFvphO0aBbU2Yqr0IduPDe5gjTNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/n+G6fxcu1jGeEp2AZrGjl0lTnt/Bfr9B8f/QCPOWM8Fj4k3Jtdh1OMddFVs/0r3m0CQJtXKyTSEWejaUJewj9fwoUoKrnAR+B04yv4N7v9VQK67IyaSsNQKEgRL/wuRINkkWgEw4Ky7RXwJVoWJBY9X6iAAl4HSxJxsBklRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csB/672L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csB/672L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764713560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HR6Gpebm8idLOLOm3Ct3v+B3+RBobPQirAADkyH+HU=;
	b=csB/672L0wEbzEe+iOSZa8n4d9WKyl3s0vt/5QmYtOgLRxfpxPvyVYySv5i+0+KeriEFif
	H/P0vb/wlN48nboHxJ0zmyr5MUKZ/sCe4H2k+RJ17bCaKxhv0UbHGHNIWL7h/Y2RgZ0I7h
	SC00r6sLZilb0TZD+XoI5mT8lFcHkxE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-7tEsMnpROiaHzs9fvb93ZA-1; Tue, 02 Dec 2025 17:12:39 -0500
X-MC-Unique: 7tEsMnpROiaHzs9fvb93ZA-1
X-Mimecast-MFC-AGG-ID: 7tEsMnpROiaHzs9fvb93ZA_1764713558
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4501b05fcf1so2181978b6e.3
        for <v9fs@lists.linux.dev>; Tue, 02 Dec 2025 14:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764713558; x=1765318358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HR6Gpebm8idLOLOm3Ct3v+B3+RBobPQirAADkyH+HU=;
        b=eHmr72p2i+Muh3Y64RtkXsZdAYsXihcpHEGpaoEP8M6I+k/y5g9F3Gm/EzSIsq90Dt
         cOdivXahIXpQpw4uCzkELSfOpGQh5iMhZW+E0uEeYcUbtfN6E9QOlUEb9j7Yf9z8XqU6
         stbGwJxVqz26WSsfKI2sz4tAHKKf/2irL/QIboPNHbLMUxJ5cIfMNAqwsT+/xgzIBZnZ
         xMQsTrMYF/0hDYPPzYxQkd7+W+yqDMBfrGWZFcq7OuiiO0Glqw7KcQyvTDrEdprDwECo
         PhuZ4TZYMjThxOXCViLkj0wjXM7GmoTHvb9E2OpOnP/PKzX7xWOtb/x9cr5kAh6kyvqW
         wN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvyG0GGBmCHGN8iCCtp2TkcG0HsL5+kwT0wNYESXXFyrieMfV2mQFuhqsF55R/nOK3pctj@lists.linux.dev
X-Gm-Message-State: AOJu0Yy666bjq7MdCTJLjBP0Ilq8hwvk/fozHpVVwQ/rcUy6SSmkDTf4
	/2T2nun+A9KStezJUeqafp9fmtG1ZxNjV7qX0WNJv05aATlLE4rowL3qyjginz0Oh9QikbfvqFU
	1LLw1MkGHhCn2/zkKg1MMWhsdvz6YXEQi/UEjhnwpyJamdV2HetWU8YI=
X-Gm-Gg: ASbGncsVl1NeiK+OZIFAsrUQP7InmJsMMnj7OlF7+epdkEVjnDtlsZDgQstE/DFU151
	HZkuOEm9fn4us5kZemhQSbLGmtmCUWpJ0PftooDi64nF6n6jlIXNj75hdXCn2ijNyhjy7LnQdmr
	DlG48Iw/2ZZjmDdSk43MpqD+IIDZ6QI0PgZYzlXHVruVe38/gKC+mBi1engLFrqLyzlJfvsd1vW
	/FxUoS0ttm70oR/FSoJR6XGl5XjPzWJXZySJ6dzgiUfy+JqlRZBP9Z07jXJqFHVddEcZm7nhR9C
	MaBTKo8YMw2lKD9zEP6r5BP42xrWQ4U9TuwScGmOAkP+PkHjwQopz78pQ2o2hSRnIpTLTnBqo74
	hAJirEasKYI1R60Na+QGC30hkqK6KiyroDwo2klehVb5CAUEiTng=
X-Received: by 2002:a05:6808:1a19:b0:44d:af21:bf34 with SMTP id 5614622812f47-4511294e751mr22168651b6e.2.1764713558421;
        Tue, 02 Dec 2025 14:12:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz/KymsEP/xs/W+jYnCoHFuQlJpYUDhkDP/FaJqgHwkUGYC7jbKunrQ9FAPvoBzltjcKzjZg==
X-Received: by 2002:a05:6808:1a19:b0:44d:af21:bf34 with SMTP id 5614622812f47-4511294e751mr22168636b6e.2.1764713558085;
        Tue, 02 Dec 2025 14:12:38 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-453169fa988sm6331014b6e.9.2025.12.02.14.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:12:37 -0800 (PST)
Message-ID: <13d4a021-908e-4dff-874d-d4cbdcdd71d4@redhat.com>
Date: Tue, 2 Dec 2025 16:12:36 -0600
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Remi Pommarel <repk@triplefau.lt>, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, eadavis@qq.com
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org> <aSdgDkbVe5xAT291@pilgrim>
 <aSeCdir21ZkvXJxr@codewreck.org>
 <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>
 <aS47OBYiF1PBeVSv@codewreck.org>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aS47OBYiF1PBeVSv@codewreck.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h8H4RoE9Augm7LYmC3zuKgZQJ3kcY5xQSOTu4ZmNXZY_1764713558
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 7:04 PM, Dominique Martinet wrote:
> Eric Sandeen wrote on Mon, Dec 01, 2025 at 04:36:58PM -0600:
>> I suppose it would be a terrible hack to just extend the enum to include
>> hexadecimal "strings" like this, right.... ;)
> 
> Yeah, that might work for all intent and purposes but we'll get someone
> who mounted with cache=0x3 next... :)
> 
>> I think the right approach would be to just reinstate get_cache_mode() to
>> do open-coded parsing as before, and get rid of the enum for the cache
>> option.
> 
> This sounds good to me!
> 
>> Would you like me to send a patch 5/4, or an updated 4/4 to implement this,
>> or would you rather do it yourself if you think you have a better chance
>> of getting it right than I do?
> 
> No strong feeling either way but I think a 5/4 would be better to
> clarify why we do this -- I could probably do it as well but I'd
> definietly appreciate if you could do it (and I'll just have to make
> time to test at the end!)

Working on this, but something that confuses me about the current
(not for-next) code:

If I mount with "cache=loose" I see this in /proc/mounts:

127.0.0.1 /mnt 9p rw,relatime,uname=fsgqa,aname=/tmp/9,cache=f,access=user,trans=tcp 0 0

note the "cache=f" thanks to show_options printing "cache=%x"

"mount -o cache=f" is rejected, though, because "f" is not a parseable
number.

Shouldn't it be printing "cache=0xf" instead of "cache=f?"

(for some reason, though, in my test "remount -o,ro" does still work even with
"cache=f" in /proc/mounts but that seems to be a side effect of mount.9p trying
to use the new mount API when it shouldn't, or ...???)

I'll send my fix-up patch with a (maybe?) extra bugfix of printing
"cache=0x%x" in show_options, and you can see what you think... it could
be moved into a pure bugfix patch first if you agree.

thanks,
-Eric

