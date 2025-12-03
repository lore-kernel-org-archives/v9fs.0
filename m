Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B116212FAD
	for <v9fs@lists.linux.dev>; Wed,  3 Dec 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724190; cv=none; b=FMxjBbXJiTSBq3NtVt//lGqKxEDPfp4MPE0pIzEwoTiCAbgAyjz+kyoZGW7lfjHAdeHezNaqPnnyRl3JveDK/2IWrVFVWdUIUN/Xjt59lDsldHdZ/KGJthfnj/xLK40VlzhP0gKblFL051wAcogV2YPO8/gr34zpNswIarT4cfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724190; c=relaxed/simple;
	bh=6d9MLhbuGhImXKQsbqVvBDxpx5TNDGot34v3meko/w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+PBRi0QVW327lxHK+Ezvt1xhOURHqK8MQJ7eVFyu1rxhVPbn76ja4szPaE4wzER2HSSqnXiL+X0NFy23CZoM6zWzU5WZkO04fTGBEGRCZQREriVo6KOzi6qYkGjj0YIDj/v1hjlUj4OYAMAc6chjYCU4CmEUZ6T30eTVZ0oyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMK+KR64; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMK+KR64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764724187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFZSJbUMoFREDOMf4hNQovtb4fH0ilmA926PCOmpAo0=;
	b=JMK+KR64Vb2aqyy6RgoOULOI4qyUB+M9SiznQhtIfH0uihdezvN9XhGHuWlvR2xdjy2uPi
	weaIz0cJZiR6ZVvGoEzrjzrMwaZxClTzTqyVYnlrvrZ/K+0A905kOhtI+qlQtpOxknoJ2Q
	OQSOV7W5NjcWJdHRIGYzScLChYGQJKg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-yt-C9b4sPUWU4NCpSPmqhg-1; Tue, 02 Dec 2025 20:09:45 -0500
X-MC-Unique: yt-C9b4sPUWU4NCpSPmqhg-1
X-Mimecast-MFC-AGG-ID: yt-C9b4sPUWU4NCpSPmqhg_1764724185
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6574f3b6ec1so8491169eaf.3
        for <v9fs@lists.linux.dev>; Tue, 02 Dec 2025 17:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724185; x=1765328985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFZSJbUMoFREDOMf4hNQovtb4fH0ilmA926PCOmpAo0=;
        b=JzfjlxPjxdRdbLbJaInn/z7UcDeNh0vpmDz5tiD0OasAIhHBSdm5F8fDPBe/YJpN3N
         ck7tbzlYxhFkFIkD18FbvzfGOHwc2PplRfjdHXNHZyD6NFAGEarSNBsWj9DLseXnd0Mh
         WqAckh3HTFpLYGoVpU60Dink1M+p/aOJyctXQmu3VcwBqd0cFCx4yclO6L8Fz8JNPlya
         TWbDdLbwS/rsu8KkFL5oh0Ukg6d04mbhvGwjRasOMS+UWsfufb+6DI9Ydrt3tnvNYnb7
         aJRUb39HuYiuaT7xG5K6U5SirqmzraAtRcQ1PUk+DSfjZvJ9Kh7IBmvw92kGE4KWbOZx
         FIUg==
X-Gm-Message-State: AOJu0Yw4YNfVaR8dKKrZxipuEbXWonjp4MCo8sg7mezI6JAZjBpkzC/k
	QX1sPrqEwDBtiFvd56/u52G7qsbVQdSrEZtr/DWBNEEimh4JBSTE3/2OCmnLhII9KajKNFDQ9Un
	Shf3a2zd9iuPKk4ihzE67YSLeWUa7CGuPquJtah3uNAdIXV07+ynxIeg=
X-Gm-Gg: ASbGncsxEZ6KzoVFTKJHgifjs5iw/wPGqbKz/UDt6qdomM8mMnQxAOnliQvHz9RDIJm
	63abNoPi1La3d6JxAxVPUGfDPvnJe96E4AN9QBANRjIW7HlW6n2yYa+CrTs1iSLBt/5+G89VJtu
	1ZTV7J1ahb0Q2vVks26W1LXHIbXiPdusgiLE2eC2rDTDolBu+1WT1uMRLMNcDOLFUdrx0EG1s9G
	ESo7kxcnHNVJ5JVj7s800t8BvDHDKy66DDoU5Q4OlT9kvVVqTlr2UU8bxL+6DOkEkNhJe0jdGj1
	8ORM86Q+rDJWY/mYoW7tGyV5/GKTNQh72O8s2Dgi5B5Q2QOpW85T7SxtCTP7AEgiz2dsDb3zV6H
	vq3C5WR1P98n1xO41QqYDxWMevIny83unCGl9Mu4iNdsyDq7Xe8M=
X-Received: by 2002:a05:6808:30a4:b0:451:4da2:47d1 with SMTP id 5614622812f47-4536e599060mr212330b6e.45.1764724184826;
        Tue, 02 Dec 2025 17:09:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX66IY0w4jVRYgGZS3OqlgpFq++sZ6b4dlPs/qOP4GCvzDfdGtaSRW5nlyyfoamYMaSZ+eFw==
X-Received: by 2002:a05:6808:30a4:b0:451:4da2:47d1 with SMTP id 5614622812f47-4536e599060mr212317b6e.45.1764724184426;
        Tue, 02 Dec 2025 17:09:44 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-453169f6f67sm6648597b6e.6.2025.12.02.17.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 17:09:44 -0800 (PST)
Message-ID: <c1d0a33e-768a-45ee-b870-e84c25b04896@redhat.com>
Date: Tue, 2 Dec 2025 19:09:42 -0600
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/4] 9p: fix cache option printing in v9fs_show_options
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 asmadeus@codewreck.org, linux_oss@crudebyte.com, eadavis@qq.com,
 Remi Pommarel <repk@triplefau.lt>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <54b93378-dcf1-4b04-922d-c8b4393da299@redhat.com>
 <20251202231352.GF1712166@ZenIV>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20251202231352.GF1712166@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DmQmuf7aFZU72iZffCLVjawAWmItFiUaZDeSRzjLcNk_1764724185
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 5:13 PM, Al Viro wrote:
> On Tue, Dec 02, 2025 at 04:30:53PM -0600, Eric Sandeen wrote:
>> commit 4eb3117888a92 changed the cache= option to accept either string
>> shortcuts or bitfield values. It also changed /proc/mounts to emit the
>> option as the hexadecimal numeric value rather than the shortcut string.
>>
>> However, by printing "cache=%x" without the leading 0x, shortcuts such
>> as "cache=loose" will emit "cache=f" and 'f' is not a string that is
>> parseable by kstrtoint(), so remounting may fail if a remount with
>> "cache=f" is attempted.
>>
>> Fix this by adding the 0x prefix to the hexadecimal value shown in
>> /proc/mounts.
>>
>> Fixes: 4eb3117888a92 ("fs/9p: Rework cache modes and add new options to Documentation")
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
>> index 05fc2ba3c5d4..d684cb406ed6 100644
>> --- a/fs/9p/v9fs.c
>> +++ b/fs/9p/v9fs.c
>> @@ -148,7 +148,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
>>  	if (v9ses->nodev)
>>  		seq_puts(m, ",nodevmap");
>>  	if (v9ses->cache)
>> -		seq_printf(m, ",cache=%x", v9ses->cache);
>> +		seq_printf(m, ",cache=0x%x", v9ses->cache);
> 
> What's wrong with "cache=%#x"?
> 

Nothing, presumably - I did not know this existed TBH.

(looks like that usage is about 1/10 of 0x%x currently)

-Eric

