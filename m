Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D23FB067
	for <v9fs@lists.linux.dev>; Wed, 17 Jun 2026 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700943; cv=pass; b=fd0je2NHqwrS0G13bCj/Lh616nH87WUqbUqvyws37xGMA4LLzfMBPsuMZ7KX4/pBZIkZNdGuJQPnS4DGQz0+CaHvZW8Y+A6ZGhVopfvVf86ojGDJl5nzSC46IW18gn9WG1lvX6bOvliTgNKCyP9yF7MtJ3qz6hkzdUrSOUN6uqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700943; c=relaxed/simple;
	bh=cWa4NW/PhtHnvNqrgN9YSlooiI4wAnqIY2PvS0bcMdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfKDcznYRbFMNqq5yQp3as7+jAUFKC85VsQ0K56FcFczVz5MUo2og9dWgukpUgjtWi6IgDn1Ibjtwpnh+BHsol5JadqpylUXn9wlAbDPw6waRgMpC70HWMZuASn2i90FR/Pq1JzwuKFQ/0jiHeBRSyshfCfckBkOZiN/dJeeEes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhS+NDwb; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhS+NDwb"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-485ecc0f2dfso3721714b6e.3
        for <v9fs@lists.linux.dev>; Wed, 17 Jun 2026 05:55:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781700940; cv=none;
        d=google.com; s=arc-20240605;
        b=JMVIgFFiDF5xKD71gzl2FOWbOr0EWg2RmKT9B9ZBg2aKCe5PsBKG8MYAHDsN3ZLAXr
         YYIaUbSa1UUlIfoEmJk6YA0MmCAzwh53qlagsMWjZh707MKCwTKsoADqGNHCNgjU4MTS
         ureWofD67B41/B35PhL/dWNMlSy40PtntAYXWSIGrWEB8l4pA+25b+U3SkgSE8SYxvmB
         V2dB/GmD7invstRJIuErpYGc5q7DOdQ9MZPS40lv4UxbwcqJ3CxpC7vhpLd3WTVvTnsb
         REE+0SwECn08BbKgcrFOsoxiMsoCDtPsFzSIhWzYcN6yE+PVsPnofRTc7sKDrDS1FRzw
         StoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWa4NW/PhtHnvNqrgN9YSlooiI4wAnqIY2PvS0bcMdI=;
        fh=zXvAPHtmq4w5f3HreLUOLn16wT62ZQwifej/AoZ/YB4=;
        b=YurlIbE/AEOEJnrLMcWTX6+Zp9ya3zI+kmhLCp9O/f2Yo+41ey7MWv7cWB1z+s/xpv
         ktDMGdAZoCLiqweMw4VTorzxjdNWbCok5ZX+3mKJcJRNWKzLFfwXUbCO4U7/T8GzwFb7
         0QOmocjXvZUQil+ei7yKyp85kI5D9aWhFsf0KCFcQvf/s2PNNOst2IRxrXkyGqm1iKbT
         ftPuOf1pzYf0NFdWGDOGYBGJVipWPM501faL2XlZZBT9DNLM7gWQ6Oq3q8/2EaQEg56Y
         2aKMzrLb14t7NV69jZDoFsagu8k5ZIrmahDvCK7mrnok0JEAylCr+fajCcBV5iE1zCRQ
         sEFg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781700940; x=1782305740; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWa4NW/PhtHnvNqrgN9YSlooiI4wAnqIY2PvS0bcMdI=;
        b=QhS+NDwboq2O2wDqNfqrgEfLGKWHJHcnw4owkdzXcEPrH4jCOWvB+4qPVaXGfSccnk
         EvsUDO/NjQVEBxB+fuuX6ELktbl91nxu7/bOCewud6/nWOl8MVtVjrt6mFAEm1dGpq+C
         IJCVafr5S3Y4i49cx9DtOtaFx/yOoiik9mjhpKUBw1/jXKGUuKq2iKrcuwPlQw9FdH8j
         vM50lVVvWQiTAJFRN7sOfXfT4qDIoHos8tI81B+/UsVfUrAzJhO9uXFaiwrV2WY2Y/zv
         lMKsBpddZ0bYII5oiEJzkcQ/Nry/S2Pusg8y3IYkxvGj57LEH+ZaZSdOIRIIFaVb+t+G
         L8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781700940; x=1782305740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWa4NW/PhtHnvNqrgN9YSlooiI4wAnqIY2PvS0bcMdI=;
        b=JF9xn6jbVbYgX9cyQCkGLUL0jTkYGifl8wq/arxnQOn8YAgC/FqH3oGviYT3cNYKXZ
         ss/EwQlGs0aWVQ5Xvnq8/fiTBg8qZeBx/YGzecGefiqsRMFjmPJhGz6y4YjVBAMp48Tz
         lzTdVUVQw6IiiRra1RFVqS0/HWKf+ivgzOcbeB2/ruoRaIaei4IYAVtgqoYK7sukvNUI
         WTfF8uLO9d2VqqCVLBluZ5ZWbx6aVccajIJauwqkDOa3ecpObqcZC9XN2lOGsc4Sh2Bh
         n+mmynlWnzrxn07+YoWpnN4h+0q8Bl4uZ5Fd7lebMuBxa7Lc+gCx7gZfqbf5SmagxqyV
         SXdA==
X-Forwarded-Encrypted: i=1; AFNElJ9G85H7iEegspPUK9Ri0AYqIGOcXmrZ6Y7PAxS+Xs46ZIFCX+JamBzXbe5hHmDoGzxbnsxf@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc8VmWveLGHHAUUtoEWenA3AXVPiBD+0uwYnuZQZAJLQ5xRylS
	PzZXNjvP9bjcULYTQaPO+7pOrRj8FUyYBncbKK0XP9GOmvTQsqBSkXr+zrGghM207wvAM5HbxPx
	Pus09ozpOKGzOMsOLgwojiciFVzijBq6KvKGi
X-Gm-Gg: Acq92OFC0hl6xcEFHBIUnHNELYQKbedymPCfLzB8Dpr9tR+Oa8rBOtZ2UxNijncsFyk
	w/qI6FXg3MRTwacV1CttXXIk/WwpuLCO8Lfz2TFeHCrT3OfOzttUY0NknbosWrXSWe7Lmv+75Gv
	jJ0iOr0DzyvfZtBd9bz9FA0v4emgvvL9xtNDprphzc33xbeUMqZ5tnECZsB/LVpGnCfuA89vEZ5
	qfSSeCLjwh0CcAWWCJWZ90Hg7fTWeZKiqpBxtAydFPF5uPrGhYnTAgFg4rFkk8IhdOTx4b46gGV
	ETGUMx5jUWBm7B0t3Qr3T9Ek+Z9x7rtY9PyQKrkuRVCXgXMXyLytfzUE/fe+WiPZHy7F6L5MlVv
	bhyJYsNBP6STlAKegOkZVANS7BgleHIFyEIA=
X-Received: by 2002:a05:6808:170e:b0:486:50c7:7f9b with SMTP id
 5614622812f47-489428d4a3cmr3098102b6e.19.1781700940222; Wed, 17 Jun 2026
 05:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260529075441.233369-1-hanguidong02@gmail.com> <ai_6e8Rhfq1coHw_@codewreck.org>
In-Reply-To: <ai_6e8Rhfq1coHw_@codewreck.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 17 Jun 2026 20:55:29 +0800
X-Gm-Features: AVVi8CdELcVuYnaTn5Vp76bwRJoO3UxIOogF1FUXII2lUEsUHPQulmMzjqWfWi4
Message-ID: <CALbr=LbuWzRo+fndQFEnhVJTfSPsEfKqwUri9ovyUe+dkXXx9g@mail.gmail.com>
Subject: Re: [PATCH] 9p: Add missing read barrier in virtio zero-copy path
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:13=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Gui-Dong Han wrote on Fri, May 29, 2026 at 03:54:41PM +0800:
> > Commit 2b6e72ed747f ("9P: Add memory barriers to protect request
> > fields over cb/rpc threads handoff") added a read barrier after
> > p9_client_rpc() waits for req->status, pairing with the write barrier i=
n
> > p9_client_cb(). The virtio zero-copy wait path was missed.
> >
> > Add the same read barrier after the zero-copy wait before reading the
> > completed request.
> >
> > Fixes: abfa034e4b8e ("fs/9p: Update zero-copy implementation in 9p")
>
> This doesn't make sense, the wmb was added a few years later, so I guess
> this should be
> Fixes: 2b6e72ed747f ("9P: Add memory barriers to protect request fields o=
ver cb/rpc threads handoff")
>
> With that said, a rmb here makes sense, so picking up (with fix tag
> fixed up)

Hi Dominique,

Thanks for taking it.

I was also unsure about the Fixes tag. abfa034e4b8e introduced the
lockless zero-copy path, while 2b6e72ed747f introduced the wmb/rmb
handoff rule completed here. Your choice makes sense to me.

I understand you will fix it up when applying the patch. I can also send
a v2 if you prefer.

Thanks,
Gui-Dong Han
