Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF061BC46
	for <v9fs@lists.linux.dev>; Tue, 21 May 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307504; cv=none; b=LA55lnhKktrfiPTH6oR0+2jC1AdvGkYkVt+hhAzDshhlGU+Tt4rA/8LeZ26V41LyWBIQRAzn2AtJiESJarNC7dBrxwRKymMFrAziKq53k78fLmndy88zPL2h7HxeJtFYdQBJi36XPHhnDwU5FJLXxpUFWMtaiQcThV86ULTUtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307504; c=relaxed/simple;
	bh=bKdqkY8H9wTw5y+8oj6M+om12H9BkqcMweVk8ln1A/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGLD4pkRk9dcTfn/7YiMixsXwPJISUZSJUFKnF0u1Ft7rq+tXkrZOfN4rk67Z1k5A467XaRRCLsEGrgZeUyf5UFeK2x1jbbRa4JEca9/ONZepk08Vi9ukR47pvnpkS4GQEPBmNp44snm5uwQCtJPAbVFMsuZ4amO4FdDha+5ugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gIWanfi5; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gIWanfi5"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36da87c973cso1677945ab.0
        for <v9fs@lists.linux.dev>; Tue, 21 May 2024 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716307502; x=1716912302; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nt4NT2eZ7AdGPqZ8UIZ+5/ykmoqBj7Ymiyz5OlxoaQ=;
        b=gIWanfi5bJNShisE2Wv1/koh91f0hfQ38/4A2EZi1nFl0KpIdDJ2Rowl5a44A5S5pp
         GtrADqMPFXT85RAdbIgys7seEId02CKAI7A4D/4r0/T/wP87AwiHQWZc9/vQ6KoKnaEQ
         IGz9dfkHct72vzkmHikH8JGw9BP1gHbI1FimesO3FU7yRcDLo30nOLhlOGcxtfZV3c8h
         dDZAX/3tC8NDTBq9eoUTEGp0eclWnmQS3NN22D6zGPkT8q9aH7FONnFH1fUNdNHadOxf
         DMX6npneK8b6RlMhket6uOMt0bNVZfDkheXTAZzcppkIJ2nzQBzlQwj0KwbOpmeaLLtk
         c+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716307502; x=1716912302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nt4NT2eZ7AdGPqZ8UIZ+5/ykmoqBj7Ymiyz5OlxoaQ=;
        b=uPco51zmEy/Ryy/oyUqLZssUlgFzD450MxrMJd89QX7S2gcvSjsobgHSSFzzOkdze2
         ubUO/75YzvCRgy7KlOV3JwZ2w3mMuUpD+LsQMR9Hb8qiub2PMde5kAAQdaHXtf4Sv8Kg
         lEMEhqPzMjGq63tFdWADPnyO9rkMH8rUbkjW7Ur0ZK8OxQtP6fTnjeIGC5PgINhiLtd5
         WI0jwVuUC9VuscUoLNZhbHOdkHAuWiv3xAjK7Kr0UNc5xlonP0EoufyAtQjuNBl5NWL6
         P/fErDmat6IDSTH/V9uaumvn0amhcL58sn4TiNlH9BT9d8iTvZIql+rC97I/NP1gWP1c
         MiSA==
X-Forwarded-Encrypted: i=1; AJvYcCU0RayQAJVO0YPY+HeM+c+SICkpH5r6vpwecEQntVH3oGfX7PE9cWCUv3GRpTJ8HcQYhXk5/1VvEKmViS/tuogYoL8AIw==
X-Gm-Message-State: AOJu0Yxb0xwpIXUfcB5fOpce/0vtoTQVZKveOI9RthLFM9aQXyFGwBWj
	bj97tN4bAc9SUXHlmY5Gt22VxG0/mDxYbLHdupyubWAr+sq1Kmf1iC4sSZ+Mgyk=
X-Google-Smtp-Source: AGHT+IENbxbCIveBfU+56Mh8grD6M5RzWxhN7Hek5IRjzUTl0X8SyhHShX4YeSl1RmBxMd1Vsijtiw==
X-Received: by 2002:a92:d3d1:0:b0:36c:5440:7454 with SMTP id e9e14a558f8ab-36cc1444bedmr308848125ab.1.1716307501743;
        Tue, 21 May 2024 09:05:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d9c943sm64565475ab.49.2024.05.21.09.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 09:05:01 -0700 (PDT)
Message-ID: <110d2995-f473-4781-9412-30f7f96858dd@kernel.dk>
Date: Tue, 21 May 2024 10:04:59 -0600
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>, Jeff Layton <jlayton@kernel.org>,
 Enzo Matsumiya <ematsumiya@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk>
 <316306.1716306586@warthog.procyon.org.uk>
 <316428.1716306899@warthog.procyon.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <316428.1716306899@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 9:54 AM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> However, I'll note that BDP_ASYNC is horribly named, it should be
>> BDP_NOWAIT instead. But that's a separate thing, fix looks correct
>> as-is.
> 
> I thought IOCB_NOWAIT was related to RWF_NOWAIT, but apparently not from the
> code.

It is, something submitted with RWF_NOWAIT should have IOCB_NOWAIT set.
But RWF_NOWAIT isn't the sole user of IOCB_NOWAIT, and no assumptions
should be made about whether something is sync or async based on whether
or not RWF_NOWAIT is set. Those aren't related other than _some_ proper
async IO will have IOCB_NOWAIT set, and others will not.

-- 
Jens Axboe

