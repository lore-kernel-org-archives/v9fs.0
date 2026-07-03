Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428763D9042
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089091; cv=none; b=ExNgO6gg2B8YQaHcpgRXgc7wS/219kw/5DAzy9CCjCyw9H/pLD4miFyq1K24dwr2Has23X3ctE8YjOB7EqIc3rNxHNhKdeIFJ//6hPyGGyyha8Jq5LUqCZle5VaLX9mG+m4Qa4D8UtmvAY1sJk5Lj9c9qilb0RtCcU4RIMg2O70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089091; c=relaxed/simple;
	bh=DxKl22WYMhwSk+H0tEAS+Ng9aN14mc5J8WkinkLUPmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkGmHtLjk6fliprrqLg2kD/LYIuyz40iywEM2pK3ERTTOlYbuO7I+b3zehBFAjgu+DwH7ylkSFz3rgjxjaDb9ZEs7zZm6+yWjc7Rwfb1ZeK2o+z7d8UcXQskTaK0zUYypEAO3/gpMlBWFbE1m0vMOXN2pmECivBRFDS8T+PrTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDFfarsE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDFfarsE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so4726465e9.1
        for <v9fs@lists.linux.dev>; Fri, 03 Jul 2026 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783089088; x=1783693888; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VsT/jI0COZ96KSJ5oT4I95zT2XH8sWJVztlvb5FlAM=;
        b=gDFfarsEdWG/A/xJHSJCi4x07bTGOFjv/m0iNBc57URsFyFQl5hu8axG0iVjii7zt4
         qNNFQnUOETcg8OE4XtVxAAXq+KdoWxECq87ja879l/V8jC6pGwoh0vwU6OaF0p4eDdDM
         /f22Mh7chA6cglefkw8k/SJ80MI0wS0/lOJqKV7YHhERo1/6JIIoCGpbK3/Q7uJYIMQq
         ZAA1bZtTPnFVEvMtCLUe4kQtORXJooi7GuIY4aG7h8u0jKLiYjO2I7F01b6AnHwcwrM9
         A9XmUm4n/kb8q/hGElqI9/wmeX9Kp4azG1f1V+Kk5JWQAEd4aWwOS5W0e+oLuuhdb1Du
         3Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783089088; x=1783693888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9VsT/jI0COZ96KSJ5oT4I95zT2XH8sWJVztlvb5FlAM=;
        b=pfmlFgKjI+VktivQZYvxhT13WwwlwLWYy0z/YDJM95fW3YnFfDTvHi/OpNTIMypRO3
         HB/4fgqiedX2MrAXMBFS4sazYocVNzMcXUHAA55mr6g6arxx2l3a7QQC1E78xPVQpHgJ
         8x84oOPQPlJ+2TA4hLlTNTuogdtAEWmAqHbBIN72p8fKlR9qeE8AILqNQEOSOYKHd6UJ
         OgaqYgIECF/WysD+H8HQkRi/KUifbNa+nrrlktI6pd10qDyURBIRsp2NU7GS1mfuoMfy
         BNl3aLde0Yv2nc51kO3NZMvxVh1TtdwASfPzfJprBFFYjLu1Y960o9xbbj+dCc+7C7Rk
         U3PA==
X-Forwarded-Encrypted: i=1; AFNElJ9AP4fAhKduVxI1kQ04bx3ofEkyhIRA8Ib+O1KDhRhGm8THwlZozCpvecMeo9ayhPzV6ZBx@lists.linux.dev
X-Gm-Message-State: AOJu0YzCYlx5RDkZLgpWVgdy59vDXMxq7zINHLj0LvcjSBclRE1LNe2S
	jQYUz3pZ8s8n3aJO/63/bKiEtM52R5wfbsJ17XfA7GU0gz0qr3fNpT55
X-Gm-Gg: AfdE7ck1kprT5zumUJmSmBEMs7fU8uB3jApVK4o/xURUz46ILwyR9mUqfut78ithXtB
	sVzvl6ILH7OnAakg2jTpdCGyy16exHTZjjQmWwDwhuvBPnJplo/YcA5umNP+7FY7n37WkEJOZj0
	6IbGPJv9+20/qiSCPJEfqkPuRZDdNL+/Fr9hKHzzUNx1iiqma54+T4Be/XNuVM0giVX6FwctgFY
	uuRAveVIxcXWDKG2WJuFbGo7YqucPooPHTMukLJGmIjWBTxaZezF5ILMrEB2OuI8AJWJHlCbeyV
	cgsNESa4r5VcPe2xNNxgp9edI2xJEd9sa0gHU52i3/5cKzQwWOm3nkx2au/EfpgAVimH/19rY2j
	ri1oda5Nky6k+kP0G3vfUVROBdCTK2QJyQyNC+rhvthI7nBntT1ajCw1dkV75MFKxsx5n3eyZau
	/kMmjMQUbyDHp31gaNoZ9nknlB3qPPBi0AWZkIblnBWi5uQxLexG6yuqkOt3txVTOQvmpVMg==
X-Received: by 2002:a05:600c:698d:b0:492:66fb:5dc5 with SMTP id 5b1f17b1804b1-493d0f34376mr1059005e9.24.1783089087448;
        Fri, 03 Jul 2026 07:31:27 -0700 (PDT)
Received: from localhost.localdomain ([85.193.42.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dbc75sm19462711f8f.5.2026.07.03.07.31.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jul 2026 07:31:27 -0700 (PDT)
From: skvarlamatus@gmail.com
To: sgarzare@redhat.com
Cc: asmadeus@codewreck.org,
	ericvh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	skvarlamatus@gmail.com,
	stefanha@redhat.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v2] net/9p: add vsock transport
Date: Fri,  3 Jul 2026 16:31:25 +0200
Message-ID: <20260703143125.45423-1-skvarlamatus@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <akd7QliTAWpkmE0Q@sgarzare-redhat>
References: <akd7QliTAWpkmE0Q@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 03, 2026 at 09:12 +0000, sgarzare@redhat.com wrote:
> >The privport mount option is not currently supported for vsock and
> >returns -EOPNOTSUPP if specified.
>
> Why not?

The existing p9_bind_privport() implementation is TCP-specific
(uses inet_pton and struct sockaddr_in), so it cannot be reused
for vsock directly. Per Stefan Hajnoczi's suggestion, I opted to
reject the option cleanly for now rather than leave it silently
ignored. Support can be added in a follow-up if needed.

> >-			fd   	  used passed file descriptors for connection
> >+			fd   	  uses passed file descriptors for connection
>
> nit: unrelated change?

I noticed it as I was adding the vsock line below, but you're right,
it's not related, so I'll drop it in v3.

> The rest LGTM, so for vsock point of view:
>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thank you!

--
Matus
