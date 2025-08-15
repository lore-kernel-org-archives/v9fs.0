Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3321D3CA
	for <v9fs@lists.linux.dev>; Fri, 15 Aug 2025 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225911; cv=none; b=DkpKQ7BIk7UZYnuWsQx8YC7PsjPZG4D4PyC0ehiV3ZEKk0ViqbVSJyGyUPUwTPPL4gfDlftZL3irQsLeRsRA2LDNjg5y1evqBGRia+NA46VKb8aMsLDsMEurFUGXKbbdWzlENVCPgZSDhFM7szCK2gqK3fguZyCwtFGqaDa0nFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225911; c=relaxed/simple;
	bh=I4FD3v+VUZikNRwYd+gBHMrLUQ4CPjiLRoYKNpa0koM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBKeyFyGCxXXhlhDsuDuVhjmHHwhaKm6sYCmr4U42nGoiPxQVVYjo2MG1/oL6N7Jzpzk1ydeTlur7vsDzVwLXkW2cri+9QTXU/LAn0IVtKhOq0LrEnQxpjmablN0vxmutSBN8FeHwAcwT81+NqHtqzcqKpTikqxG0MAThAs7aX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h31zGfQD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h31zGfQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755225908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0MkfgQ8bxQYxWpTPhXMKMd18J4d8CIS4VwAx8IBZF0=;
	b=h31zGfQDi0E6SCMq/o479EVIvnYw6dEJqnz3VwC4YdsnLngwbcbQtxWt1PnvE7m1koT2+h
	bshFG+LhAd5+dPni1z5yprBlDG0FZym5uW46YTwiAoik/eOvMOPb475LVqAHfz0F+iAQvs
	amIhazX1gUKNCP96+XcVG0QqFTtVvb0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-gwPSBe2KNxGjSlLXm-qFPg-1; Thu, 14 Aug 2025 22:45:05 -0400
X-MC-Unique: gwPSBe2KNxGjSlLXm-qFPg-1
X-Mimecast-MFC-AGG-ID: gwPSBe2KNxGjSlLXm-qFPg_1755225905
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88428cc6d2fso280210839f.1
        for <v9fs@lists.linux.dev>; Thu, 14 Aug 2025 19:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755225904; x=1755830704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0MkfgQ8bxQYxWpTPhXMKMd18J4d8CIS4VwAx8IBZF0=;
        b=Tuh/Yjoezgx0JoUfbaLRSo1pKPcfm8S3rwRU4pc9jUDDrJ0n0t7+3zisnd8quB8SrB
         FCdPegUob0pb4Q83GWrk/HG3Yw1uDvFsQdcmUXbo9ZtLq6WGdtYVjZ69o0CMDdaa7MjR
         ZkbvKgCjkRyGPrFhSDBdLPaArMcsEYnlltTfMXpT7hh4sjlpBXsuqwqEhTbE3AiD06K4
         O5wBM4MpHh7qUjtpkvsKcwp6lSfvc/61BvDIvO/6OkPttcAXjmV2eyUpAszSxc7Wo2nY
         N68G3ol1ZwfG4pKl5aCqPRqinLc3G0a+RrvExB0PSDo+LigBzwQOCJVi1pN5eGH+IPSL
         HXGg==
X-Gm-Message-State: AOJu0YyP3LfV2MsRJlsj7zTuEOrfN4eJbW68BDMx+nNBCoeZeHaWAA23
	YdVgm2WYo6p6+eI3YmLEiATSjp9AxzBaVxjGcJsGf3FFMg4E+6cbKKILkeg8+TIAKYJWBmZSNSA
	rcnwAzO/w7yXnHInon5I9oA9SvKchi2iuTk6H2+Y/zcBkdkU1mewVtuikC/1wGrN+Sw==
X-Gm-Gg: ASbGncvCY84R12xQUjHHUhn7tTkQBGcFHs2KlJvBs87AytX7jc+/5RngTvuObAzSXD+
	24wVpZwwTZu0MZUleK3RP0wwcYDQZM+tlWtYSuB6AHw3kRAfhMX68KQIvPVNfpkAaZM3u6iDppe
	CA7hpBJejBwmM9VSL760D5q25SMobhRCy9qiRnlc1s3pspSIL757frZ3hj7Uig5gdJuUKigmQTU
	+v3ZWHsnPlnKO52SbfYfXIZcpVPixms36UAXgOT6x+QN5iprqF9/jPsZpJFU1dOJZN8d8rRjGT0
	jtArJEcCZ28mDSjwaMSg5AKRuRLlSmTPEnvMVUt/3ENDqOyElqjE/eIt/HAi1DInIL+lewdPkb9
	f
X-Received: by 2002:a5d:87cb:0:b0:883:f98c:d346 with SMTP id ca18e2360f4ac-884344a12f8mr663498439f.8.1755225904398;
        Thu, 14 Aug 2025 19:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPO2/dpIhfW88S7AVny5BTqTTrhXRStv9g3Vy3tFeK3kWPbXDX/MhOKhT4XvAfrxexA31dhA==
X-Received: by 2002:a5d:87cb:0:b0:883:f98c:d346 with SMTP id ca18e2360f4ac-884344a12f8mr663494839f.8.1755225904012;
        Thu, 14 Aug 2025 19:45:04 -0700 (PDT)
Received: from [10.0.0.82] (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94999fe0sm79448173.57.2025.08.14.19.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 19:45:03 -0700 (PDT)
Message-ID: <0d8d55ab-f21c-4e4f-8951-87398f382112@redhat.com>
Date: Thu, 14 Aug 2025 21:45:02 -0500
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
To: Dominique Martinet <asmadeus@codewreck.org>,
 Eric Sandeen <sandeen@sandeen.net>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 linux_oss@crudebyte.com, dhowells@redhat.com,
 Christian Brauner <brauner@kernel.org>
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
 <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>
 <aJ6SPLaYUEtkTFWc@codewreck.org>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aJ6SPLaYUEtkTFWc@codewreck.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: duNiVZxYdKRZsEEW9lLEk64y6L2CB-3Z5DXWk1yZ4r8_1755225905
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 8:49 PM, Dominique Martinet wrote:
> Eric Sandeen wrote on Thu, Aug 14, 2025 at 11:55:20AM -0500:

...

>> Any news on testing? :)
> 
> Thanks for the prompting, that's the kind of things I never get around
> to if not reminded...
> 
> I got this to run with a fedora-based host (unlike debian siw is
> built-in):
> 
> - host side
> ```
> $ sudo modprobe siw
> $ sudo rdma link add siw0 type siw netdev br0
> (sanity check)
> $ ibv_devices
>     device          	  node GUID
>     ------          	----------------
>     siw0            	020000fffe000001
> ( https://github.com/chaos/diod build)
> $ ./configure --enable-rdma --disable-auth && make -j
> (diod run, it runs rdma by default; not squashing as root fails with
>   rdma because of the ib_safe_file_access check:
>   [611503.258375] uverbs_write: process 1490213 (diod) changed security contexts after opening file descriptor, this is not allowed.
> )
> $ sudo ./diod -f -e /tmp/linux-test/ --no-auth -U root -S 
> ```
> - guest side (with -net user)
> ```
> # modprobe siw
> # rdma link add siw0 type siw netdev eth0
> # mount -t 9p -o trans=rdma,aname=/tmp/linux-test <hostip> /mnt
> ```
> 
> I've tested both the new and old mount api (with util-linux mount and
> busybox mount) and it all seems in order to me;
> as discussed in the other part of the thread we're now failing on
> unknown options but I think that's a feature and we can change that if
> someone complains.

Super, thanks.

>> As for "waiting for you," I assume that's more for your maintainer peers
>> than for me? I'm not sure if this would go through Christian (cc'd) or
>> through you?
> 
> Sorry, I wasn't paying attention and confused you with another Eric
> (Van Hensbergen) who is a 9p maintainer, so I was thinking you'd take
> the patches, but that wasn't correct.
> And that's after seeing your name all the time in #xfs, I'm sorry..

No worries! I don't mind being confused with awesome people ;)

> Christian is "just" a reviewer (for now!), and none of the other
> maintainers pick much up lately, so I'll give this a second look and
> take the patches.
> Linus just closed up 6.17-rc1 so I guess this will get in 6.18 in the
> next cycle, unless there'd be a reason to hurry?

No reason to hurry. This has been a long process, and a little longer will
not hurt.

Thanks!
-Eric (Sandeen)

> Thanks,

