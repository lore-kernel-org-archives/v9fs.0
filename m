Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200B305678
	for <v9fs@lists.linux.dev>; Sun,  5 Jul 2026 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783286585; cv=none; b=bPZPfB6rYJBx5jVtiy3gcay+uS8L4UkdNMCCmLolt347QkdSAcvNroFpYGQNIBc2K6yCw2lJqDlLt/4VSSNLPmLlAZZh+5m6sTgsRRnFa+Um3LJUc3BZBrVZfW8+8hSvSGyeJWD7tZJjeNOamnH8rMKOedzUqINtWMYScLZMXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783286585; c=relaxed/simple;
	bh=vH+eOgrF8FVWrBN++mA+QX7ihOZ6DLzDCoGhIdIdN0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBicw16mIZxRFVE9/EJTZ8XCoLGhuSNTb77zpFf2AW+F70fMftyKXbm9Y8k23gjPRlvFtZqoraVz41z2YVATQeyWbH8qH9RlAl45fpv4a7Cs722oqvcB6fliWXZQYvq0NRStVsGCbGVe9pnD+S6oxD1Ij1yt8okuxzYUD+LDsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kYgK09SB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kYgK09SB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c81db32393so410095ad.0
        for <v9fs@lists.linux.dev>; Sun, 05 Jul 2026 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783286583; x=1783891383; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a5qWio7s6GPHBlGPQg3ZP+USmFc8rp3BGSQUCn40Klk=;
        b=kYgK09SBtulXfnCjIVDamnt0vlgl6Mg4yWxu98bNnu2lvaIIWqTfHXTtKYqQPh7kmp
         KusuQ/lG8ySgNPFNWXbXY8dQ/9JE79O0YwcNjyXRM/5OebeEE3VdC/TQVAKfkl/qZzUt
         eTWApqSiM1ufS1Rq5xp6ALKQ6+5IQHPoc4G/phCxUy1oVC8QopHhHpm68UumSFz9J//H
         tzfF41aNHG+I18n8OY4gR6A61o/olnwgJ6NCpaWu2TKBjUTv+Rpa/tYio9nxqwhr0gtj
         QItH17gFd4MHa+AQfDY5BCzVsp1RIVLog9+iHNDYT9QBjBvI/nLbI7/ClKkxdbb9sNyA
         hlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783286583; x=1783891383;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5qWio7s6GPHBlGPQg3ZP+USmFc8rp3BGSQUCn40Klk=;
        b=r58wl9bRpurkkRbYI6IU5TO7qkBJhnWu0w6Sw4gzf5cE+slLM/6UPwndA+GaH8Qig5
         dqWHOhghWOYnc+iUJ+D/2W2n4MQLhU27izkOYbubDWyXYfkCIzNCkn7yZHte4FNezqsi
         sK/UnzHNUwMMjm9dv/k2jZgzNCNt8EpaC1fFzLAb0s7IKi64eBr1g1vneieWjnoAxn0L
         xUWsWddLLp8lbDD+knQJsavtifOkW09KHE5RrkHeFfhDDnYCsNulw9NofKZ5p2oTM9FK
         IFJTesQDDogB7Mia06pRmoNz+XHyFDagkHxDLEx5MF3XMKDxawzXIU+TG4/U5TL+9Tgo
         XwBg==
X-Forwarded-Encrypted: i=1; AHgh+RraIQkQb8l0S/GB54/MclCm/gqfeoaoO8tJg+Cm5mjbN1t5au+dEIqS2nc8CbTJfeRhIpuE@lists.linux.dev
X-Gm-Message-State: AOJu0YyWAmL5LkCTH+3PksjRx67A5tv3BTPaZ3VdgyGdJfF7/pJ90+KQ
	RvNlpY71yt3uO30Ns6f+cSur2fkY1mHpY3Xl+Crf3gQoPzIy3/q40QiJ9+jSnGGp4w==
X-Gm-Gg: AfdE7ckuvrUMmT7a+iCbllbrEUeICiUmMkNdPuI3w4i/pzR0RVrlGKm16ph3mUVFutC
	d8ctIz9aOe9r68b/FmU4fSMpvBsi5dwOOt1HMJqG1LE5Hoa+fWz0DpZGSjO3cdxnf8XIN3NOvEa
	hcJF92aKKiWuojHm5rwqUgmm4DdbqVkCwAZ/32F519el7pNSI1oViOIcClpVACCqfFUvL/Lv0og
	7d3sAUEES3x9ScmGRpvDnwXxW9ydivx0zk7Mft4yXNrqa/1NvLEEhU2h06l/NLKddD4FXlgWpcC
	PEiXiHlsr9V4Ho26A8nn+nRJCQLPq6uu32cB76uWxEZb4aLAtlmFVe1vp6gOI4SkTR3i3VCmoFT
	TQ8R8BbAVInkwUVDB98y1zaXpWY6tP83hGW54l/+a6+I8jwEtwo+lKJc6VKdcS2dH1UB2g4ej1f
	ts2SwzfH3NW7jjtjeievXqGWvMqh5UfDL72hYaF8ra9kkhim6WvVkMAr0=
X-Received: by 2002:a17:903:244b:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2cb14c67133mr2481995ad.0.1783286582754;
        Sun, 05 Jul 2026 14:23:02 -0700 (PDT)
Received: from ?IPV6:2405:6583:a4a0:700:8702:66a3:f0a0:ec6a? ([2405:6583:a4a0:700:8702:66a3:f0a0:ec6a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f4cd4b1sm4905767a12.12.2026.07.05.14.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 14:23:01 -0700 (PDT)
Message-ID: <b19a121d-4559-4310-833c-7947b8bf027d@google.com>
Date: Mon, 6 Jul 2026 06:22:54 +0900
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: treat read return values of 0 as EOF
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260702090941.1298188-1-brho@google.com>
 <akfHGcqke9qixd3Q@codewreck.org>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <akfHGcqke9qixd3Q@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/26 10:28 AM, Dominique Martinet wrote:
...
> Barret,
> thanks for the patch, please give us a bit of time to check; I'm
> sometimes slow to reply (like for your sending the patch first without
> the [PATCH] tag in subject) but I did see it, just hard to find time to
> review...

no problem - i thought it might have gotten missed due to the lack of 
[PATCH].  my bad on that.

let me know if i can test anything too.

thanks,
barret
