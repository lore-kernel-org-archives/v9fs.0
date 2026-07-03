Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF5401491
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090743; cv=none; b=kdOmX4DDmSzEEAdcOoMo77LxLJhTPeProIUinmtTYprniTwSaFzOkCZWwMlPlgwGTCPdJFxBWhG6dkATw5fy05zVgZ7K3SAHBz5G8GpjcnpDyTUIyCwvecIrzRy5RJELKyKIC+jbHI+e/n8MV+YtgOgBxWWzRgOcy9KhDwKElZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090743; c=relaxed/simple;
	bh=RBZdI7jgrpFKUef7mrSDPHfqiq/fFIVInIXz5/aBcfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILNbOgLF9L05mjyOajmhJcS1IT5gvTyQEJLwujnQSS21LUQNEFiIPv6v0b/ujQ1g8aVGfC/GQhG+o9ekZj5DaXF+51VOgj7d77ieNCsjxDPIztgPnbziBIUukmw/IF7PI4cy5GrWl8RuS4H1oC46WCkeyObPUJ8mKlQVw9ldef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKn7x7bB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKn7x7bB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493ba701891so4784755e9.3
        for <v9fs@lists.linux.dev>; Fri, 03 Jul 2026 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783090738; x=1783695538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RBZdI7jgrpFKUef7mrSDPHfqiq/fFIVInIXz5/aBcfA=;
        b=TKn7x7bB+okO7Ibr25oIdNbQRZ4eJBz4qUz4fiNPSvl8afvWt8IQUlzopKYNJE/1wu
         7K7k17e71OXpJNH/w4L4fFfjGbNy9szLA8KJgvOs19nZqctCglsOaRuLdV9LQ1+C1or1
         XATPiTj7yYDrt6NDVb1WU9XnBkWysBWR1oNYMYOcrK4TitDJBhE4mKgiuRZ9M28uYrIP
         I8H93eHhVhi2Vv1TYP7Tsdc/qRd0ZuFueUAbVfvsdvd6YjMSOC2NvyU19khlTcNNkT11
         WEvx/i7yZ/h6V59TSV7393PSWbkhNsvKy6+qw7nBUyo5AdnAycyOHELSWaiQW42TWk6w
         BAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783090738; x=1783695538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RBZdI7jgrpFKUef7mrSDPHfqiq/fFIVInIXz5/aBcfA=;
        b=VHrpCKQ+rLrCdcMI0umX9/6g66I5kgX8EKXY9wGU55B3JIRWpnEGomUQx0bDOBXfK4
         crX1JoFZRL6sPVlR96WoD8dVKSriELftPqxczOiknqYIZhXGX7BQQyKPeNX2qgGEiy3b
         PkcrHfFovE/lK2KN4RqTPVTIeFABWsZaz8Z5L2QEGkWAtr8s6a+QKgntJk27ub05gIid
         nXYcwYLpobIVsJnJW+tQTQmBcPTUyxC5eW3vTzMamDYp/2MYsMuElGfdZ9qgKPFssY1I
         9PV3c56KwcN3Udb0Z5CVeEzNk8ZB0ee69EyRIDZW0GX1sP+zn2KgwZJKum0cGNPKh5aP
         du4Q==
X-Forwarded-Encrypted: i=1; AFNElJ86pZDXU6w5Ff5+F0G+aEp3jqEn7WrxEx5h17PnXA0dxBrfKChXHFfK6OEiq8+gJap4yEcx@lists.linux.dev
X-Gm-Message-State: AOJu0Yw51ixeNbVdjS4zJ5oBsl6PrRNi09O+mCTphWmrvai1T/R/mDpX
	lVhtAj9shpCtpjt6YizCGOhQ320ZgyYxZ58mTHQCVdtbjvS8dRoRv5kr
X-Gm-Gg: AfdE7ck+vh1uyj9e3+BHCmw/7OUfq9cbb/Ey1DQ0zt4m+YgiGPw+KZPyerx0Y2A7ryd
	kdNlSDebojGJ3R1f95l4JGnu0Yqfx1LucnEwD7OgQLV0X6GqJh0ucFXbss/E1Eh4E6SOK8ejmW3
	8P+jkX/oZQ7gyq3ayFK4pG0hgiiDlxfdyuB6IxbmFGVWD+mFLOGfRgvndZDoSTlKz960pTY5qKF
	EZUtIpQRjomImRNmhu1OVYu/PtgBKcfyn2g+wDCMCeRzr5q48nkEUu4pVgMDUJ74ZWkge0+il+K
	F4/nE5oVG5qTZYkeCd7+gEX0M6jU/5Reb9WlJuxBx4IDAu2RQQbcWwt9/aRsWY4jAOrL+Pokqs3
	UMKhPP7CpRIkWZQXuMbUfDWa4N+V8ikrpa8ooD6IYUl7BggJzlHdNrmHZ49wND4dyCTgOUS7nZf
	9MCI6UQoRJNnkjuwOGFqy0qRA132T1piUN0mDPaouGEdycp9mafutLxFFGkMcoIbaEabwD6fwTI
	exn7wIX
X-Received: by 2002:a05:600c:6098:b0:493:c773:c3f4 with SMTP id 5b1f17b1804b1-493d0f33611mr2132385e9.22.1783090737939;
        Fri, 03 Jul 2026 07:58:57 -0700 (PDT)
Received: from localhost.localdomain ([85.193.42.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63ba971sm213978415e9.13.2026.07.03.07.58.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jul 2026 07:58:57 -0700 (PDT)
From: skvarlamatus@gmail.com
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	sgarzare@redhat.com,
	skvarlamatus@gmail.com,
	stefanha@redhat.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v2] net/9p: add vsock transport
Date: Fri,  3 Jul 2026 16:58:56 +0200
Message-ID: <20260703145856.47071-1-skvarlamatus@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <akfEJIwxoVx1hKXd@codewreck.org>
References: <akfEJIwxoVx1hKXd@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 03, 2026 at 14:16 +0000, asmadeus@codewreck.org wrote:
> If that's the only change required I can do it when applying, don't
> bother with a v3 just yet

No problem Dominique, there are a couple more small changes, not only
this one. I'll submit the v3 next week (probably). But there shouldn't
be any more significant changes to the code.

--
Matus
