Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3641F5F9
	for <v9fs@lists.linux.dev>; Mon, 27 Jul 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173900; cv=none; b=qZGjUgQesTStt+JX15jwrTE05JQD/2eLXsLGsqkuDRBPErKkOxRNOYHC7ycxJ4iTsFHrAez2eX2YZJQhxi1RtkiWApjsl0g/D0HbP1y3Bg1R07h6AUjIv4D9blk07XhSPYXkpstj3Q/+Osfs7XYoO+iZO+6vwz3wgCyxg58j1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173900; c=relaxed/simple;
	bh=VQZ5fYCTvFa/9SbOtkKSyxVz2+Ca7PXXAQlKjpRfnbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFP9hK7BWwjolhRGbp3NpCI8nkuX83r+WL+CgrbOdlnNTPb1Bmla0el0Lhrwnue5kNB0D4Jh46IvWJPHxi7Us+t+ChIw8+3QhUTCDk+Mc/T+yAwKxv4UYqk3ZLFixbeI145EnMAui5tmnJnZtKLRxKEYeR+qy10AHygjG3cRRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZwczVwyL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZwczVwyL"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c01c79467so29511cf.0
        for <v9fs@lists.linux.dev>; Mon, 27 Jul 2026 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785173898; x=1785778698; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xc8RNpA5Jhta+/kmas/o+hbP+ADTzC+07ggHCpEs+UA=;
        b=ZwczVwyLpuUfqi6f+au3+eo4gYdP2IQgKHtVhUD5MRcM8xihm6oprPR03aqMSzyVe7
         qYxNPJOrm7+znyKZGSF2RUPqJ/XH6PhzIOhXN22GQUbVWqXULR7ww2I8MnMcE6n0QuJS
         VQtPZaCboVZbycFMrjlasnC5Ntm5sZn0ZDPc16BbXpAomC6dl+SoyUJRw1l43ZECaOdY
         mQEfU/PA87apSGR9vtyOxZ/kzIAevv2G6IPYrVjHi7ug0O+yDuLhlcdNRhusfKsEwNar
         9LA+r3UHt6RphxrVezHyEckTe9E7imj6LCVPnOTR5l8YioVfflk/H7w1x4eLjRPCssjy
         ppcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173898; x=1785778698;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xc8RNpA5Jhta+/kmas/o+hbP+ADTzC+07ggHCpEs+UA=;
        b=UcfAQieNGzGJRmSvj1dC18d66IucvUbUY24sQVvHfOgtGi/rCXDftLnC+Y4/UMTz/0
         oKkRhfw2r+XMj79zPvRbqtb+iWeEwppG2KC+voXgu368c5RJjy8IwO+ShG5CQOJiWviC
         Vx9kDGg17f5IxXJ+hO2FPVZVbEEYyY7sG8A6krvMOCBO4SC02pX30PK2PgYc19VnzShI
         /sOpnHXANDVj7ssBflaDYERFYWkuaPPFQfW+As1BMd/+WjJGWiw4EmMovppVV7jLPnms
         9Pz/bKKPvRg/JRtWhzhby+4GCIAws1xh1BlfgZSzUJVzYXv0MGQ3W0tqRXM2N15pUoDr
         fS1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrFlmccNDel6jwKRJn++/uLB8PtDnJV4n7phhxBmY05FEG8jXBdcdHaVOeoTYJiqqpVBDGm@lists.linux.dev
X-Gm-Message-State: AOJu0YxC0gJZIcsLp7sFoHVFa6Ahhz5cqtRIelbTSdKncKNpecpAb+Wm
	O43vApJBVTW/yAuNLsSdDlfX2o4rNiugeOL9Gao+FI8BqiXcAcYgsr/DAnP677JJKA==
X-Gm-Gg: AR+sD13gY5f19QgY9uVGnCmhyXMpMZ9NpWJ2PaS2LG1hShUcosR2Bqu7KEtZW3mTPe7
	h9O3HfFDhHB+a9Ss78Ll2C8gzCW5BG2JHg8bXdpdhXGEba4q9nXOsEwbRHKs3Ligtqv33z8KGXz
	a4FXcMvkTaojC+aCNKIzm21RUANSf0A02/osY2eLImXc/LuZdnzB1J2B2sGtf1H+owpFM06Ubt6
	hFh+ihh7RzU3t/Tv6B831vQCXEHo6VrCXaxFWhlyeVlPI23QrgY3alozKGZSiPdHaBD98zvlmub
	RVdv0XDkTe20mvBHYQFmG0ugIkQARmB2VXgthSThsAYMzsjuDbD1MeKK/g8YnocOC1rJYRcClMP
	FiG28ceXoWX2lgrOnJ7sq90bEB088NwQFs74uI+dPCcxJx7fC0UoV8FSSvYikRd+vClfx92S6
X-Received: by 2002:a05:622a:1308:b0:528:38d6:71b4 with SMTP id d75a77b69052e-529a7705cb6mr40292631cf.11.1785173897654;
        Mon, 27 Jul 2026 10:38:17 -0700 (PDT)
Received: from [192.168.1.31] ([70.8.224.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e854f462sm70659126d6.18.2026.07.27.10.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 10:38:17 -0700 (PDT)
Message-ID: <f7005841-80a9-4c21-a114-6cfd6ee63a58@google.com>
Date: Mon, 27 Jul 2026 13:38:16 -0400
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: treat read return values of 0 as EOF
To: David Howells <dhowells@redhat.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
References: <akfHGcqke9qixd3Q@codewreck.org>
 <20260702090941.1298188-1-brho@google.com>
 <2237820.1783934942@warthog.procyon.org.uk>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <2237820.1783934942@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/13/26 5:29 AM, David Howells wrote:
> This is kind of a weird situation.  We're caching locally the content of files
> aren't really regular files and probably shouldn't be cached.  I'm not sure
> what the best way to deal with that is.  I wonder if there's some way to
> detect that and mark then non-cacheable.  (Assuming the server can be told not
> to even serve them).
> 
> Can we detect that the EOF length doesn't match i_size and set a flag to say
> "don't cache" in netfs_inode::flags?
Possibly, but could you have false positives from this?  e.g. if a 
file's size is changed concurrently with a read returning EOF?

As far as detecting EOF in the first place, my patch had the 9p client 
doing it.  Not sure, but Dominique's question might have been whether 
netfs should have done the detecting instead?

 From what I can see, the netfs clients were responsible for setting EOF 
(except in netfs_clear_unread()).  Some in response to an ENODATA error, 
others due to the "did we read past the end of the file size."  Not sure 
whose responsibility it is to detect these cases: netfs or the FSes 
themselves.

Thanks,
Barret


