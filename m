Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACE2038D8;
	Fri, 18 Oct 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276613; cv=none; b=QYPTU0lPNkepNM+KFAWNZhxMW5npn+/8kUza4wr1itQvbY6vPVY9sUZsnO+RN9IN+Wsi2p97WlMSspecWlA/9x1dUwYyVo5P7dm8blZcx16IOUdDtlaolOWyZ7ANTI9LrirppoYtiVOvb8hz73u7FJ9xpFDKSbvpT/WtWfbsmHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276613; c=relaxed/simple;
	bh=D3G0l9jbMvlCkvgoc+kjUJNNTFmI2ix7sVeYwkEJuOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgmNyo++vMxMLliMmBI7p9m4z59L8lcC8rfpdyqP799rrB7IDOZE/pCrBQ/6HuE6oh6PJW3fsnI0M1N/q1u5NDahypOT59HTtHmjOirsNN9qFJYU/aJZxLbDZnP9y354xc2dm5Tcvb4FncN++bG7J6+WsTxzvAT/+s856HmENG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO3ne0hk; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO3ne0hk"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d5d6f9fdaso705987e0c.2;
        Fri, 18 Oct 2024 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729276610; x=1729881410; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx5yoM9lQg2y1MsfWqtMxM0GetDzvGAcfS6YYX5arXQ=;
        b=WO3ne0hkCvnAg9mWywgvGo84XqauUjc2sdiSaL7Z319YkZuLzVOmP7XpMQ4OWh4fIF
         UM/3XhGQrE0ilSvtsq16WPkUPcCbL3kWfavS/vI+K5LGv1E0s7a/7GhUnKOKGdGP7R5C
         M9NxW+s7Mc/34V61FjhEkJQjWMsqGqou6m0bKJxuDOH0GgrYfR3VkGHW4R3ab04E13LM
         F6JFuXrPMQYYdr5ubwYrMGNezvDNTyuR4oR1GVPTZoDDkhKAAFB6nzLyFR6R7bl2J5hf
         nlkf0jtG/2NjcpYQIVbepjSp9bZQqmwGO4RfHCf7BSlixMJLFQgCekRAUR8a8e/eomYd
         Ad8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729276610; x=1729881410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx5yoM9lQg2y1MsfWqtMxM0GetDzvGAcfS6YYX5arXQ=;
        b=LLg8E6eIG/NIbIoaSPXnbtV0OoDqhMY7sef0ogc4M+PDTO1FtiDWz2+2N9J7NWisS+
         Cru0FpzWywqaiUbcQBsJ3541Agqkxx2jD2bN/3MbMUR1WVxbIBt5nwuUChxDQyYmLN5/
         ben4qV8H0Mq+HsKEES2SkWmK5NWO7QKDRXWF21Vylv4Q5pTgX1XgyLUkKCTLhMnOymTR
         TYeyX2vbC8ivSVEtEdyhmksFX/Ye+ZAP0QmGDmNOtTz06vhKXhHCKXuj8lFdO94EZRUA
         JMysPF7uM1Wdf9m2iWWeNqk/3vB2NxhpkJKIO27hDITvvyEHnhEXOxmE0W3CbARiOuqm
         khPg==
X-Forwarded-Encrypted: i=1; AJvYcCWxOMhBBe3xr4hqjX6BEzGx59bY26dZ2DbDFHwNlWnIVP3mJh8Rir6gKH98IKvggdhOZ7E+ec4zMS5vIQ==@lists.linux.dev, AJvYcCXrnAnXZJTGjzqX+lCOV3hg94mceeVhju0nNVLOtRG3KRASf5/EYNh0S4U84ih1AlFnsyhofg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNUHifWzjm35eAro+A0mZ/KHA5rG9sv8DAO9Ftt8wIJj4O6XxX
	ohyl+yFsxPRj3EDMh8mudh6o+Fo5K7WhiCwyPjaNopT5BYXVGrobK6VyN05kO73Yp2jH/9HI3dM
	oaTJmdPWgOA0AqYJhRVHlbVJdtizfQbHV
X-Google-Smtp-Source: AGHT+IEow0bGucLUZ1EAJuePRFrAKTAb24joUPnIV4vUTrT/pXMPFvfyGUsiAjxf8rRzvpLQqHL1GFyZxA3goPQDvUs=
X-Received: by 2002:a05:6122:512:b0:50d:5654:951 with SMTP id
 71dfb90a1353d-50dda170c77mr3295182e0c.5.1729276610195; Fri, 18 Oct 2024
 11:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240807094725.2193423-1-pedro.falcato@gmail.com> <20241018172804.GA2151929@nvidia.com>
In-Reply-To: <20241018172804.GA2151929@nvidia.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 18 Oct 2024 19:36:38 +0100
Message-ID: <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same name
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 6:28=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Aug 07, 2024 at 10:47:25AM +0100, Pedro Falcato wrote:
> > In the spirit of [1], avoid creating multiple slab caches with the same
> > name. Instead, add the dev_name into the mix.
> >
> > [1]: https://lore.kernel.org/all/20240807090746.2146479-1-pedro.falcato=
@gmail.com/
> >
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > ---
> >  net/9p/client.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
>
> Can this get picked up to rc4 please?

FWIW, seems to have been picked up into 9pfs-next
(https://github.com/martinetd/linux/commit/79efebae4afc2221fa814c3cae001bed=
e66ab259).
Seems like we're just missing a PR to Linus?

--=20
Pedro
