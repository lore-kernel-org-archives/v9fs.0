Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AE306D26
	for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234971; cv=none; b=LUEthIxBORdUoM+dy79Quzgj22bZxlxZPe1hvegPW8aWvNVH6RzIR6Oq1Ziqv6X72iz0LgHb3oDPGbcc96K5Ts5INF8i8rt2dfUxtGX+TBjfuln0K2gRG33OExWwmVemHIxkqIAYHLpbitgE+Fxixxht8xxAiK4Bg2aAHxOcY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234971; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjrC5WgzOX4Q1FQASlGYMYhwefWiV/1AzMpyO2xd8Z+QU9unll77tV2lXIt4l3hYmoJbeuAvwJ9kO4jU/mKPpfBYT1Q+dDgC2DyYyHD5H3zycdNgiurXd8yPauD/Cf4ab2HYjURDC6VXBM6OJH9AnbQIgSUvd5Gk7AcR2tnzdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ffc879c1aeso4441256137.2
        for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 06:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234969; x=1773839769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=Q9Lma/mawOCKtcFD2VgALl+58mvEhkUZvrdU33LB+ZWs/OGrZIzVSjDvszXCnbQbQv
         HVsWiq+tilKYDLO2mtTonQpnAcIw5/8CN2WnkRULDJeFjXoKY8wkW8rYHomJhzQatHO1
         Y26OkGv8rFLHyj2zmOwUiqAKc5UbIMUz07uhNEM8ohLYdZY/c2Hmk71DQKoFSgv8Aarv
         aqvH6X5XJm5uSfiq/OGm7ILWwbJa61jp5xDK86V/w2VG2SGjetibf6py2K/h/mTm6Aec
         vS2777cy7MZ6Oxe+wienzHso7O2yAb8piEmJd4etI1zhArTkj93VHmZPlaEoV1OxcDrN
         Eblg==
X-Forwarded-Encrypted: i=1; AJvYcCUnyur0XSuA8muI1zzNmmOA4o2jTLMhjSVY20hpxeIqNqnbxlNqC6FpkDm/f47DoV+TpD5s@lists.linux.dev
X-Gm-Message-State: AOJu0Yxvb6V7SacHE9ozAM8tRcEAVUAsd0wtx+Au9f7I11bRsIWF5CT0
	v01gAPqnURa2w2peiayVNNxcacfE/hZmf9WmITo9B9qMOWY9utORrqnK+g9K0Yyi2ps=
X-Gm-Gg: ATEYQzw2oqMbCn2XF5GonFrag1b/I8F8mpwLpph1HjusHoTDLcWWyDcplht2HTszNdW
	4nhwg+F5CW8HyXINMrNQOTpVod7T40soa84hHuYiifBTGpjCquRjRV1iLzS08Kx6S1DfCKC7csC
	JQWOPSwjazUoDSzYR6dFqFJOHh2V/EU2heJFcX7x7VV84B14C1iKUWgCR9ScRIEuij7GZYtniNR
	SgHHqqyb7x+Tw2EAadcCM+qlf3TFg9l0kEfkRhCgsMpVzu0a41ZqKlz5NzAFrdycko2c7iiSZMH
	czhykTL7nmuH5tdAZ1oWVvsqwfq3eWlE1uXcrzLcq0+C5KVT7m2wrc0JgukklUSAkGUq4co1UJE
	VGz6tc4y3useEv3DZYXfiucphdH4WRXA3iX5X7HIY+LfJj1wJXXqs7osRORmloNuUQLrRtc/qsj
	S++8uMSdyosGZMtUcR0dX6pLfNdXfCUf/5XMeuSDWVgDZkLG5NPNRfudnEnu6l8PQl
X-Received: by 2002:a05:6102:dcd:b0:5df:aff3:c42d with SMTP id ada2fe7eead31-601df00aaefmr1110448137.32.1773234969284;
        Wed, 11 Mar 2026 06:16:09 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601d505285bsm735890137.0.2026.03.11.06.16.07
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2419025e0c.1
        for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGmDyHkg/74WBVvpEbU93P1eHT1b+SADTn1RsDqS7oH3K+CXSruyzpDANjrOXOswgMlNqV@lists.linux.dev
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
