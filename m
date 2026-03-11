Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD50345CAB
	for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194859; cv=pass; b=DOxKCw2NuL+CzT3ONAUgXIMYcrX3VMuAFIH7uhihGzC5k7OW4aNyIUIs8YuA22DI3N9BAKGHkXWiQQU7VlbqKnryLaIPoCjEshflf/z3a1bjgAjK2fje4As8LIQRm2mF5t2J1EQ9xjWEXH0Kjb2f49C+PvceY5CqG5eqO3YmGU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194859; c=relaxed/simple;
	bh=8UJnLa/DDQ+b65RDSHa97nR/Rm6zetnRjswOkVb13wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2g2yzZ4Dybh6kuhvcBULVguDYhdrEOCm8tFVHG5HxZiMK4r1ieV3XC7DvFbBP/+LmMwsbfu65u9ArSpCtaVdbPZteok84/rVMReHCYXmpmbYEy9zrdrliUY8eD89Ecnaq3KiIRSp5NcaBqhT+HUD7Ww+h1VR8ou9i4C8J9QSO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G46rxFFc; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G46rxFFc"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a13d1c6f25so4703792e87.3
        for <v9fs@lists.linux.dev>; Tue, 10 Mar 2026 19:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773194852; cv=none;
        d=google.com; s=arc-20240605;
        b=DYWA7BR4QFBZmfkJu1T8f2+4GohzaUSufmiW7oJbalSUuPviVpMpgl4lQ+4YqRg25F
         HWYTOze7cgClQ2OuF/wwO6gGrtJBeLniAWqsV+cXqoHXyvLeyB9lv2XZ0DmRHxScxQV3
         OdM64H96XX58fhKp9slPw15SypjkIDmtA50rMddvWOxnBEHDMNMICnoEqZ9+CvG+Q1F5
         hEc/eoaoTYnTYpF26tCQ5QKluOgsUBkRyVZJhRnTUJcTagQt95CxwMMnikfCOfmGMpaI
         YPbLGiW29Nq1zaVr98lX67LlDlX2yRYdgs08RMQl3lEbCugeW5TtPqUyqWUEZHif595w
         3ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        fh=L6oOYF7G895HWpQKhAqxZWColNkzpCBdXGO1/zg/wGI=;
        b=f2EDO7wBzQBWJDTpwlDfOO6RHE7Rifp86XpE0zj3z3Hc8jNGKFr91jCRkOTsvUNdsl
         9zmk2dHIgoE5fVWB69U+r/UXyNO0OijqDzjPkvp9ISWxf+zptFaeiFbri6I0/iN6RX5/
         HaXAJrUZ8ox6xpjt1vvviJp4CtGHxbGWoUxhu6r4d7TRm29BjrNZP5DEVq7+w/kv1+D2
         bjlb7KCTlhhvq9RcDGbKnFK4kKMqFm+ZjxoAnGJL5LDeEfV2M3CSF4fZjyqKRitO1knR
         xyATvc0xM1MBZF6rHXxZk4xJvDyKqm3Gl86I3mqiPffm7KUJ3oRiyX4W5GY99309R3A5
         1whg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773194852; x=1773799652; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=G46rxFFcX1hnQKxUUrTijJdlDpB5OBfdKVt7tJqloBNXcNg5JAjWvjlGBTrQCSFpEL
         kw5r/kEngKAkJ0pkN558AqUScugTYRjvdhsBLXq38oLpcnNpxGDuEjo6TpPJTbZMKzhC
         YhKhvGGnSCYDK9QQnvadjQAxBlN7qho59qSI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194852; x=1773799652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=YcXrjnhPxBBpeT8v0M/lLNIaUOzuvk/oUYqyREBe61x3wBYFl7Rd3sdXApazWwS1tP
         DKrmaYoCCE0xVSK77CNOafVnuy5t3aRirR7rB6ZV97gYriwsr8dA7O/GQzlchEMvxeKY
         Z92PHTPw931cfeplqi6OUVg1X6VROoaS16/MmgVC6iLj0+xbJeuN/aZffU9W1gFw/2M6
         oNBr16V+tZIRbusBt0NP+tnhL3ZGFU5kC9gtMNZ9pY9R7rGl23iUci8A1oDfbYZXeqbo
         keQUmQ+XWpkI/X89iLb7k6TwqoS0Rvl2lqXe+u3OWUIRiHxZH6IhUaamGXK1hDH6HHB+
         gBsw==
X-Forwarded-Encrypted: i=1; AJvYcCWVApDQ9EmY0IW52ov5obDZxu+G9WRscxuunBrv15ktffzh0nhCiDHQhgD6/+nsj5kQpGoQ@lists.linux.dev
X-Gm-Message-State: AOJu0Yx55wFEhkE7z3MORMaqp7zrpMlFqJkJsry8K/NN5T05IE0aF9Bj
	1uDIl6PjC9oFYEBko9wVs/LNRwtyLOh+S9VJNwDpqzzYDXtcmFVgSKFLY4aTWR2sqkMTAndEGOU
	SnF//xnKLqYqmlCyBk68CfyA71kxRk7dLbGUxxGff
X-Gm-Gg: ATEYQzx5wBkZ35f0hk4zL01SfVZdvlnp54p1iuwiMitXIVRS9qz9a8aAy+SdDhLu6vQ
	/Bw6dZNHuLGlM8jzxQb53JMls6k84WItWSBvfe2S3+qnEIsbsMI4gauR1bH7NHuIk2PmMLVM4Q9
	SGQqusyPOrDU6gXHimMwpYM1k2I3qBenzvUDp0A4A4zPydkXURU/s7f+iigihZ/u8HXP1KC62ip
	d7fQhVhUnP/gSHoNsoJoXudYeKoVPT4OSHAMHRE5R3FCMjqS8OEUKOao7kE93w9Ku4rqjZauuuu
	ci7kBObcIw==
X-Received: by 2002:ac2:4427:0:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a156cbd1bbmr169453e87.28.1773194852284; Tue, 10 Mar 2026
 19:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Mar 2026 11:07:21 +0900
X-Gm-Features: AaiRm5028PWt8n-JnveiRgn8oYMksdR_-_nk4JOkvxMfplWs-GDr7RRk-OxICyw
Message-ID: <CAGXv+5FQAVaJjqhv+Xq-ysOc4SHQn2mCNTgCAp8XocmWBWGGoA@mail.gmail.com>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
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
	v9fs@lists.linux.dev, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:57=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
>
> Change found with coccinelle.
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/clk/clk.c               | 4 ++--
>  drivers/clocksource/timer-pxa.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b72=
23d4488a9216ed1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
>         unsigned long flags;
>         const struct clk_ops *ops;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
>                 return;
>
>         clk_debug_unregister(clk->core);
> @@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
>  {
>         struct module *owner;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))

clk_get_optional() returns NULL if the clk isn't present.

Drivers would just pass this to clk_put(). Your change here would cause
this pattern to emit a very big warning.

I don't think this change should be landed.


ChenYu

>                 return;
>
>         clk_prepare_lock();
> diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-=
pxa.c
> index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a=
4c0fb08ba11c8f9 100644
> --- a/drivers/clocksource/timer-pxa.c
> +++ b/drivers/clocksource/timer-pxa.c
> @@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem=
 *base)
>
>         timer_base =3D base;
>         clk =3D clk_get(NULL, "OSTIMER0");
> -       if (clk && !IS_ERR(clk)) {
> +       if (!IS_ERR_OR_NULL(clk)) {
>                 clk_prepare_enable(clk);
>                 pxa_timer_common_init(irq, clk_get_rate(clk));
>         } else {
>
> --
> 2.43.0
>
>
