Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8983763F1
	for <v9fs@lists.linux.dev>; Tue, 21 May 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306758; cv=none; b=tllwP4IBcLIcmW03KhFM+U5gzZjOBSrynYHwmsuWG/PFOP0R0L81Cp/Cxu2kzXXOh31cLir8fMAJMHwkhRDMUm1TjF7BD4oc878BM43oVhn70PAGem7V2wMTnluHoimhSBYdQzR1BRlwUFYynIOEKiVTxEC1lJEuqNHJ1URZXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306758; c=relaxed/simple;
	bh=ydWfB8Ixx2WGgADol03f1VZf4M7vv9stY1thXdwwiug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcajG2JUwII3wK1xSEWAyQVWtEj1FNLHiR0EWOMR3PEcKu/Xdq1Mh+7rrPCCe6FCNPyQJSnTXLHS4cqijwJo4kITeUCO0ALBeGpH9DOyaGuTOGl0eRcV2eUWsziQ5y/T3AqZZ72uKK9T5NCEab1gJLG/sJC6bHAs+VzgpC7TPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k4ZIiSUL; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k4ZIiSUL"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36c84c95c23so1467315ab.2
        for <v9fs@lists.linux.dev>; Tue, 21 May 2024 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716306755; x=1716911555; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lu6Cz3W/7JBafbJfSPoliRhPwzKJFkEKd4ea8AjEFNM=;
        b=k4ZIiSULDMD6dhDd6lQcudyCTUX7oMvR2I04EucM/WBogsc3Q0I/31+QI4OebAc0Dl
         xswcq5zfaFEYqndLGlbpV/2lFESGiRbKndNl70ZQcFQ7vmBWGwZ091Z1Ci7q+Zo3KlS8
         HUM+5OnaVyvrvGvLMC3xdr63eCd0Yrio+pXYEAexLiuOryWQHRKi1k1tKM0mGd2Aa6IF
         OQ+B9io8eiUVFHoghTJeC0gTxgu6f9jk20jfdTNvVf2XlbVLxvs1PF9/KYrDIw0S4O4A
         BNO30UUKKNA3lAA2n63AHv6zY9pXV6K6Ryu9vWoqOM3J4Ll5yg9F4EtYE4umznEPV3Rt
         juJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306755; x=1716911555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lu6Cz3W/7JBafbJfSPoliRhPwzKJFkEKd4ea8AjEFNM=;
        b=XPWWXiqI3Crp+5jijv2BLCBfF6uA9X1NwS29x+LVGQvEpCEZhednhXzYp9K4Z8Ydk0
         wB9SQ0cE9dk+tJHJN+nOr7/zM/DaH8JQ6PtMGU+e4gX6/GtFokeA5NPT0id3G+9VUWJh
         r4cpZRb5rztgXAqZfUd5wSKq2atHcjhxKR9dQisrCRFg6d0+6h27c0cPBnlRtrcqo8v/
         AUPJOzigWjUYJKyAgA657PJaXnXtvGOBLbgl9XqbCkeRpHLgQgcB19uhl5/rnboGyUFe
         q/P8+aMDklVzcrb888mXRFLX2qmL6EBI88TTD/7Gz02TpNIwapXY9AB17dRSTO1YvhnL
         bChg==
X-Forwarded-Encrypted: i=1; AJvYcCW+AWtgJDYJQouvNwh9NYBXNbEHG11r8O0/P59Fewe0BlGZKOAO3nW+6z/oUc0ue9i780XFDGJD/qotAOFSdwGW7wVaiQ==
X-Gm-Message-State: AOJu0YzX1WKx4GATvlGHFtRMFOf9yNuvdlGV7z6/qJ9MTGH9MRu6U0dy
	oqQRAKvS4XdQhXOXhSdhJWO0BDe03JLB4yzU8qTn31DHq4T7XYHFuTJuNd7gO50=
X-Google-Smtp-Source: AGHT+IHa1zyl6cmZPdjySIykg2SQdYZupp88XF9rpgThrnqOxMjg4dDFQSMzR/ggbhek66vW9xxDQg==
X-Received: by 2002:a92:c988:0:b0:36c:c86b:9181 with SMTP id e9e14a558f8ab-36cc86b9470mr305103065ab.0.1716306754979;
        Tue, 21 May 2024 08:52:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9e1363esm63659975ab.71.2024.05.21.08.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:52:34 -0700 (PDT)
Message-ID: <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk>
Date: Tue, 21 May 2024 09:52:32 -0600
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Cc: Jeff Layton <jlayton@kernel.org>, Enzo Matsumiya <ematsumiya@suse.de>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, netfs@lists.linux.dev, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <316306.1716306586@warthog.procyon.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <316306.1716306586@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 9:49 AM, David Howells wrote:
> Fix netfs_perform_write() to set BDP_ASYNC if IOCB_NOWAIT is set rather
> than if IOCB_SYNC is not set.  It reflects asynchronicity in the sense of
> not waiting rather than synchronicity in the sense of not returning until
> the op is complete.
> 
> Without this, generic/590 fails on cifs in strict caching mode with a
> complaint that one of the writes fails with EAGAIN.  The test can be
> distilled down to:
> 
>         mount -t cifs /my/share /mnt -ostuff
>         xfs_io -i -c 'falloc 0 8191M -c fsync -f /mnt/file
>         xfs_io -i -c 'pwrite -b 1M -W 0 8191M' /mnt/file

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

However, I'll note that BDP_ASYNC is horribly named, it should be
BDP_NOWAIT instead. But that's a separate thing, fix looks correct
as-is.

-- 
Jens Axboe

