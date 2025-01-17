Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B71B0F2C
	for <v9fs@lists.linux.dev>; Fri, 17 Jan 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154279; cv=none; b=lLApjnWcQCLbXPK94pYmRMcMd5qhqn1QPICxb71mCRvr8ni6jQWVT0SEfyepz26kTnfPDH5ikeuxn7HwHTQ0EWuzN9ceBPC86HqFkXCod2ETCumswOkiHZ9fMBYcfCSE2MWbDSr0Hvyhd+fAK2aljPMQuw9UWXOVHs4Jisr3GtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154279; c=relaxed/simple;
	bh=4ndr27vHrgV4i1+g3vktNBpEHe45gbqn3FheiMzvgYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLn2bTQAR4Lih31c9hsBLbfIA2l22LXXOI/7y0dzQ27ywpRF0Y8ivMd/hQ4BkMrIPDgbSMaD5jytpCQAXfJKDFmpCxbw4NK92x1vAbQsBR3rJ5Z/AfrtYEQ0rK521/6LyFR1Kbb3p2Hu9UvlFixeIaF6TBD8uoOU0MIF2WxJEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ftfLIUqk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftfLIUqk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef718cb473so540415a91.1
        for <v9fs@lists.linux.dev>; Fri, 17 Jan 2025 14:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737154276; x=1737759076; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p32dOXxKWKXzPhWP1vnoU/wqpnQJmdqQdH/zTSeblxA=;
        b=ftfLIUqkFfC3jONCfGALvFuk/yJeRCuB+fgaLfO75RHnKJO071QHTolVis4pY7VVuc
         gAVi1dQP+pDXGmahQU5EYDkyamfbLSp0LWiS7Pd9Ci38bqWlCldAGF5OHLMn3qjSx1Ea
         4dVHQ1/5wYJow4DPaLWokx/gXsVeESqQWDIH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737154276; x=1737759076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p32dOXxKWKXzPhWP1vnoU/wqpnQJmdqQdH/zTSeblxA=;
        b=JyDbN+WNF2ZET00vrZNoh9LRDPmRSPB5J+qRyJoBEsMQXA8VcKEm5T7iGXZREkY0EW
         rlSnSa6HYxFJOGqVKfbgBsxkKyfBTUFksKXfM8BiWkBNZSlrNilRsCRS88rZVEYOHPhW
         XxU0lCjilMwM9Sdz4eaFIIBmQBCxMgtSyfZVYuuq1mKR+KKFHQViaicdtG1h5KBoBX6o
         o4FRlz0sxIFEc6i6B508pbkQrWexVF8Fg6m0vrhmANQ5e/Yj/KhCbYQr1J/m74AwJsTi
         Se8eGve+pWtoLHxmFhRACKTZ8lG6IjTzoN/StV1/BS5kLD04bcokLxiglQYvLZxzMe6y
         iHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz1GXCwtoN0ov7TOeTq8VC6sul60Rarz+2fnaNxWbwGQVOt6gwjlbBff3FjDKKWeAYbs7x@lists.linux.dev
X-Gm-Message-State: AOJu0YyOmBnWbcqvgNe0cvm7mT7yV1GgI/0WN9RrMmYZy6EvOt0nYs8v
	LCGKxPhnNkWP2md2obXjDoHH+vxP5CS5V6PkPKhvb6qhVH61N8j/Nt18VSzDOO/3ukChnDsmvCk
	=
X-Gm-Gg: ASbGnctrzKMAvg+jVQpZxmGAdnfN3S2xw9eGp3u6WIAbbAu5crEfPiyxpCOI3hQbozP
	fIk9GQ3VTyDl3QXnqHi3yEUzc5oA49Qi8bzIHfbKyFpd/a+ofHz/YN1BLmJq/hnR26INiyIMhZP
	NXAaZCYC/+FU3In11RH31EBtETOmwJcT6UcLgj4XXw3VCZtFfu9APcJRjwJABiB2S8XV7g0WFv6
	ZLXE0lkTPaTYcHTLpmIClZB99TIiNEy4i73nloGlX6y+Q2ZH66MJUPR/VGCnL3pFGVmZbn44sXj
	q/sB1sVuLb7fXVOVbP93I7iXEWAE22rpmVsQNRfKYX3D
X-Google-Smtp-Source: AGHT+IFSPZPiozFWAgCjVpMyAGf3lzEQyzaz84DRpHRVY2Rng7FcQQ2Mj4vqGNPGu1dbr/hcbK10lw==
X-Received: by 2002:a05:6a00:2d11:b0:725:e499:5b9d with SMTP id d2e1a72fcca58-72dafa46dd9mr2722885b3a.3.1737154276499;
        Fri, 17 Jan 2025 14:51:16 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba50e8dsm2546105b3a.141.2025.01.17.14.51.14
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 14:51:14 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso3756946a91.1
        for <v9fs@lists.linux.dev>; Fri, 17 Jan 2025 14:51:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXgkbRpCRpDJN2eAIRxp5HpV18swyY7D8iFI7zqRjgQ4B2W1SBtJhkaNrmvYBfGP54IfQO@lists.linux.dev
X-Received: by 2002:a17:90b:2c84:b0:2ee:9a82:5a93 with SMTP id
 98e67ed59e1d1-2f782c94021mr7264517a91.14.1737154273894; Fri, 17 Jan 2025
 14:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250117214943.6368-2-joshuamurphy@posteo.net>
In-Reply-To: <20250117214943.6368-2-joshuamurphy@posteo.net>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Fri, 17 Jan 2025 14:50:47 -0800
X-Gmail-Original-Message-ID: <CABVzXAmxVAe-9wEy3QD6iZtA+pXj5_cVcDob06WNTC5conmmWw@mail.gmail.com>
X-Gm-Features: AbW1kvY6wMMlpNB5SOPKKBHeGoLpFpdN8vUiuAvlp6lceaRsnA1fAscmsI3I8RU
Message-ID: <CABVzXAmxVAe-9wEy3QD6iZtA+pXj5_cVcDob06WNTC5conmmWw@mail.gmail.com>
Subject: Re: [PATCH v2] net/9p/fd: support ipv6 for trans=tcp
To: Joshua Murphy <joshuamurphy@posteo.net>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org, 
	linux_oss@crudebyte.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 1:52=E2=80=AFPM Joshua Murphy <joshuamurphy@posteo.=
net> wrote:
>
> Allows specifying an IPv6 address when mounting a remote 9p file system.
>
> Signed-off-by: Joshua Murphy <joshuamurphy@posteo.net>
> ---
[...]
> -       cl.sin_family =3D AF_INET;
> -       cl.sin_addr.s_addr =3D htonl(INADDR_ANY);
> +       stor.ss_family =3D sock->ops->family;
> +       inet_addr_is_any((struct sockaddr *) &stor);

It looks like inet_addr_is_any() checks the current sin_addr/sin6_addr
of a sockaddr, but does not change it, so this doesn't seem quite
right (its only effect is to return a bool, which is discarded here).

[...]
> -       if (addr =3D=3D NULL || valid_ipaddr4(addr) < 0)
> -               return -EINVAL;
> +       sprintf(port_str, "%u", opts.port);
> +       err =3D inet_pton_with_scope(current->nsproxy->net_ns, AF_UNSPEC,=
 addr,
> +                                  port_str, &stor);
> +       if (addr =3D=3D NULL || err < 0) {

inet_pton_with_scope() appears to unconditionally dereference its
`src` parameter (`addr` in the call above), so the `addr =3D=3D NULL`
check is too late.
