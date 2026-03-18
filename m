Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8D3DA7CC
	for <v9fs@lists.linux.dev>; Wed, 18 Mar 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845370; cv=pass; b=CYlYju0hLrkUdQWkNclt1fftlAtbTJgn2L/uS5GxGjMIaA6GWgbmxY6/z2SpNFNhY42ObibefKbvG7vaZCZU2PB1I/K5PUD2pZtB3u4iZprZFAvJFRs9xs9yMuMVNEXEuBAMgL9unOw0Rc2w+4IuTZS2SOiAitJFeeNyzQbFNc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845370; c=relaxed/simple;
	bh=dzt3L8FljthUJAGYI2jmUC2ThE71Y92qdrRQ4fCeeEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axEtFQkO0ERSUfJBnZCdyTaE1SkZxmkPmUeylMW72PZOm4UnfhFSCih5ADhYdqfwcYGSy1shyfkcPCGxuL5oZkMVtPGYu4vXZ3I7jYQjxHq6B/QC43wZXrb1YYojQ40NOf7SoHNYpihqsoNsd+Mkkba7otqjjPSRN8w7i7kipns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYGKOsm0; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYGKOsm0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so21004a91.0
        for <v9fs@lists.linux.dev>; Wed, 18 Mar 2026 07:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845364; cv=none;
        d=google.com; s=arc-20240605;
        b=iVHsjXX7OUIs6Q311pf+0fufFFtT8HWcAGZQ4hiwdWCeg4IXJh/KFKCbWEAAO1qEJO
         DMTP6kz3pdI4U/y7Ys+LQWUiaJi+tBSb8d+iQds+Gcq1YWVM/m2IiZ40oSvGqDbV+NkC
         QGp6217FKwKA5sTTWcVdPqHz9QUFvoJeoOkgHjpU1QikZBJiNNSitB1P/Mrd0cRMznzr
         LjEKEmWCuS4s4oELf/syiG5sksZUNJ+fgwFyG0digmWpBCXvJCzQLnr3vbTYSYfOPAbm
         0iHLuGMPa979yRTzCFv4HotCa1Xq+qFyXlVKMQxnWHMhvS1IG9g141jrTnbiq2Cja7QN
         IPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dzt3L8FljthUJAGYI2jmUC2ThE71Y92qdrRQ4fCeeEE=;
        fh=L0K1uLHUz9IdhC9tPAKMUN3DhoYrf6SEOgaNsv1VpRE=;
        b=ViD45Q3HcqGyoNGf5MJK0BdutuY5cOhAYz+0LX1Vw0fWVlkez7+taFfPykKt58Qzw3
         fnPSKWdK52krSWYlu7e8eisthRfrv6v8rSIEeOuYtIYx1NcL78YM83ZbW4Wl94eJaoiJ
         hbociXfpwUjPvElzcpyhRpYFqjCh1LIYIo/pZUKfucoEH6E5pP2WmKpiwOcvoOsANMib
         3kt+/QUzYLXQL1wstTyNL6SK+7heOoYInGqXAXlusRbkxMNWxOs+Hxla5cg8aqba6UNt
         SauQKD3cfgQTigY3eNkpSy+QRgpmo2X9rJul9JEqUupsruMoKSSgHYy7tgOUuMJIHqB/
         KjTg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773845364; x=1774450164; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzt3L8FljthUJAGYI2jmUC2ThE71Y92qdrRQ4fCeeEE=;
        b=NYGKOsm0c1TKEL+X1F4qIj1xvQtL8NC6hbFDy/xaH4ga45TH1ATYfpMuHVcF+K2FqF
         i1lwZfWcfdRJLLuLI6JRQ+6DlcytGl6WDeWSIppo7+wWekXQp/KvLrJ4UEwb0qeLNEC2
         3P9+LH2jvxiJ0wtZ0BWnr+T6fWR+xFlHZyBeriPXwDbMVOPa++Nx4klKCmkUKFgFNYe2
         ibBLk0OJayDZZZYMz5kJQ7jlC2qhkIEkJdNN88EsB6k64J46MDe7rg3rmcUQdrRatLMx
         m8B9Er6PxdnJm/3WPK/Vl0dAXZeQRkxF9l0wZYGz0e4H07LIhM1lfTbIKXcSRdB37C6d
         UhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845364; x=1774450164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzt3L8FljthUJAGYI2jmUC2ThE71Y92qdrRQ4fCeeEE=;
        b=S4cCF1vKpJSx6q503+G+tRSwvEvwS7TfURu4yq2M1qGS6KtMEHKN+p3Pwcz9B1Qb0B
         6UxfEIBTvlgzFO3FtpCOZBLPXfSMxbKdu+TAqPKuYWnRGKJRrU645rNsw1qJ8uUlmYgc
         niI6rHWOsVcaNzE9vm6Tc2Xsjs9gSq7CB1e/kok7CFpspbHpxrTTl+XUxq/JW29vA08U
         VRnu8xx20CHWVcYFRxif1cjrhqxSZABrE+ihCjIocbjQ3FTavmoTFr+hi+cfB55Ie9oj
         fyrVLko/ASuwgyWbWZOM92Gu5KGaGnwBtsjZavozLv40SfYlezkjMDPczBgkaD/KmQ2W
         ZvyA==
X-Forwarded-Encrypted: i=1; AJvYcCVF3N9Pw5fwuU41HcEqxAH/IKISdlBY65aIBl174LbWuzeL89u+D0LaPMBiBEpGKve3+1zX@lists.linux.dev
X-Gm-Message-State: AOJu0Yydyg3AfLBHDFL0rEbbf4sUW+1qgbr/HTDLb7Ri/ur+GU+tDkUn
	cS8v+W5JCy0mYABEnamIudMB8XZmmguqY9RPBmnJomf6txWryAD+CN7hvpAImmolQeIJAL1dY2E
	A2CTtP+OTXERQr+adn68pVsGr+rcc+10=
X-Gm-Gg: ATEYQzyaPprNvDCVOBQUOavJUB95bQRtg7ii1O02LV6JkYFcjGCDGZaPOklF5oHaRiu
	4kV2Zh+g1TCwv6GMTXIxwkoFo0etYcpUg3NCprRFS6cEaU7+cDxGYGXQD3KNeSzl1Iwwa3mHpxe
	OB9uSWQkoyjmv+2vEE6+TNJEQbeefy/AzLqv61IiXTLQy6udPpwT9N0Askja3klcHLmfUBSY8KU
	msotTOOon8NDY4/B0aV322gmctCN6p1GZyfw+rRjQWh+Hr81OaSQT3j2qbzqzV9U7BHfEgJz0eI
	A51gsQ==
X-Received: by 2002:a17:90b:4a06:b0:35a:1762:92ed with SMTP id
 98e67ed59e1d1-35bb9f5653dmr3408028a91.24.1773845364331; Wed, 18 Mar 2026
 07:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260313171659.1225180-1-jhj140711@gmail.com> <abq3yqrsQJGI71jz@pengutronix.de>
In-Reply-To: <abq3yqrsQJGI71jz@pengutronix.de>
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Wed, 18 Mar 2026 23:49:12 +0900
X-Gm-Features: AaiRm53b9VgQZBHhKpHk6qxeRQVGZED7vCl-Dy-q0bM0EzZVA_cnAyHZSDfEH2E
Message-ID: <CAP_j_b_QYUJeszN63nkCd1wL0vH3fa8UwCpBxJG4FV9_ARTnHQ@mail.gmail.com>
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org, 
	linux_oss@crudebyte.com, gregkh@linuxfoundation.org, v9fs@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thank you for the feedback

2026=EB=85=84 3=EC=9B=94 18=EC=9D=BC (=EC=88=98) PM 11:33, Michael Grzeschi=
k <mgr@pengutronix.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> I tested your patch and like the changes, however I have some extra
> patches on top. Would you mind if I take your changes and include my
> suggestions. I would still keep you as author though. These changes would
> then be included in my series I will send today.

That sounds good to me.
Feel free to take my changes and include your suggestions and thanks
for keeping me as the author.

Best regards,
Hyungjung Joo
