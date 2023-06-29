Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848611190
	for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 13:26:38 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-313f3a6db22so714507f8f.3
        for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688045196; x=1690637196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IZn9mY6yIQAljeDv8xVMmhU05jiih/MltV2zfLp35Q=;
        b=At+4jbzAiWBllkRTylH5unvxfSqPBgKwR9gzhJVABG8A7Hh8GEsnYiaMGOE6TsKB+O
         rsw9dMOyC3x9oYaTLbYITpQT1ilzcwS2mvbd498QrrasOHdSVsqbBw7c2XSWvg622aXs
         fztr8ZMAH2AkTNP2RKcibtsJtc09LVp/JTm4WWKYPT/AlEMQIFFNVB/c+Lr8/Zw1FztA
         rEfYz3OVaktefCfPdlvlRP3TTJbWk+fSrcN1R6GnCPTge5gg6LvAYoU5fI61wizTOf+q
         RKNN9+J/+G6inXh07iXk+5Ss3V3pMcnN/05VlckjLk0C8do1ftLc/tx+vNcg7/tpSW95
         0eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688045196; x=1690637196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IZn9mY6yIQAljeDv8xVMmhU05jiih/MltV2zfLp35Q=;
        b=FYXdm3I+jo/x0lzXe+gboX/V969KpGfXobJpF7WWs0sKs4CtcN0v/EL4Tcy0s/hOUN
         4FB3ybobj84hE6ZffhdMQTQAKca8bqn2Wqk1tTIftlkH9/4XAe4Iu3lgOsck/i22aVMi
         SVWXUTJNS/4wvfq+BMY56vxMPGvD1CiEAfPfONXyurBj4RYt4aZq5Jvh0HK5FS9r8lBU
         zNWlGVIVASsjoWXME7pBPKhsjivW8t9oLEPenvqJZPITG6u6j6Yngyami740/h99omr/
         PqrbcL5As5lFzUq1TCeuZNwJUYh8jvrqEaYfG+HyK5ZV8yUumsADAlAht6htuukcnyg9
         KI0w==
X-Gm-Message-State: AC+VfDzH5FUURUMqm7NgbjtdYaNLa7Fdbk6YdLwF5soFNV5B4Nl9G/gf
	nf53fHC1VPmpZM2sekxhGuLf4URd4qEeKmXTPciQOg==
X-Google-Smtp-Source: ACHHUZ4zcELUB8K9dwKEgBfoupgiOPnJenny8MUS4F/+8+FYyszNhZOpedZcEDPjzPLwtX5eY+Hbqg==
X-Received: by 2002:a05:6000:1d0:b0:313:f399:6cea with SMTP id t16-20020a05600001d000b00313f3996ceamr9657527wrx.4.1688045196535;
        Thu, 29 Jun 2023 06:26:36 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b84:4392:4d8d:653c? ([2a02:578:8593:1200:1b84:4392:4d8d:653c])
        by smtp.gmail.com with ESMTPSA id u18-20020adfeb52000000b003113943bb66sm15822122wrn.110.2023.06.29.06.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 06:26:36 -0700 (PDT)
Message-ID: <df1fcb9b-27d0-8e64-34fa-e8d480c31721@tessares.net>
Date: Thu, 29 Jun 2023 15:26:35 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
Content-Language: en-GB
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTms30OO-p1-RyhAXKUXmavWQuJku+J-J-d-eqOz=Emkmg@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAFkjPTms30OO-p1-RyhAXKUXmavWQuJku+J-J-d-eqOz=Emkmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 29/06/2023 10:46, Eric Van Hensbergen wrote:
> (repost so it actually goes to the list and making sure gmail doesn't send html)
> 
> So, I've not completely reproduced your environment as I've been
> traveling and its been a bit more difficult.  I have done some
> relative performance regressions (in a virtualized environment just
> running qemu inside a docker container on my M1 so perf isn't going to
> be fantastic) -- but even in that case when I'm running unloaded I see
> very little difference between v6.3 and v6.4.

Thank you for looking at that!

> So, there is some slight perturbation in average latency, but nothing
> that I would think would be significant (particularly in a simulated
> platform which carries with it a certain amount of noise).  I'm
> working on automated the regressions so I can try them on multiple
> platforms and add some rigor to the results but I don't see anything
> here that jumps out at me as being an obvious concern.  Of course
> there may be differences in your kernel config that could be
> perturbing the behavior, I'll continue to try and run with the virtme
> configs but my internet is currently on the end of a cocktail straw so
> pulling and/or building docker images is challenging.  I may go ahead
> and just temporarily rent an aws instance to try and speed that part
> of the process up.

Thank you for that! If it helps, I can easily run additional tests using
our test environment having the performance issue. I can run these tests
with and without your modifications in 9p from v6.4 and compare the
results: maybe the issue we have is not "cover" by your tests. But I
don't know how portable your benchmark tests are :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
