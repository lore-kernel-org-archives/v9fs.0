Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8983DD53C
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089604; cv=none; b=RIRxzkiEyPH6DOHrM4ou3U2RxtZN9A2d9DXcYqoSe3GcXJnw/YklHsH/SkzpYcc8jQugQItDXBxVlXLydyHB1/LKil4vrvU8FaSmuaOwDi7zyvAyjohQ3Bo7lqD/L30fw/coJdzU/Mg8ddnyBUDEiyhi3bG1MCWVsBPApqQaORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089604; c=relaxed/simple;
	bh=uy/0cxLKCDIXe+tlXp3ij1YcAufIsxHrENGp+jFPhGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbUhNOEB2nfj01w6xrXbfoKzo68pgEVqOPuL1MrAao+pFQdEwrKN/Myw/3ljR6j3w4Kq7eXUdNe9jVGADkoOfmKG7EbUWjPub2T1pvHb+EBZMRgpiYMDyN9MJbcQoigXXcJ0Q38kvGVxKfsorbkCfS8UKOmRqhlosGXE+xFENgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV5u60AZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV5u60AZ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b7612475so6194195e9.3
        for <v9fs@lists.linux.dev>; Fri, 03 Jul 2026 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783089601; x=1783694401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy/0cxLKCDIXe+tlXp3ij1YcAufIsxHrENGp+jFPhGc=;
        b=WV5u60AZHJ8+XldtXzPc8oQZ+CdS1EqBrlACUdbZRORnFkE5vfzS+xChd3Zv5+psSa
         FCk68MezNACIJZwJMWOkTuWAgIMjYUXiNHRvYScgDwT83q6/Iuj1wlmBoOjsAH6cOFUC
         1Uzu7eIQJcc36o5OhJu0KQYkta4tjQPUDOFumF0oBiKjzSRe//D30pisMRiM40BeRxVl
         qt29b8hxNE3MH6xz+2kekag1z0FM6Z5QpE2Pgv3YXhF6DKzEiZg1PTd1E8mHTWTxSPPa
         ZjbAPvqtB0M83sXyFj0lJAMfXA7gpmLQGyxYboqmZZ/aO2SBzqgA2kMUeM+dC3SXCzFG
         EfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783089601; x=1783694401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uy/0cxLKCDIXe+tlXp3ij1YcAufIsxHrENGp+jFPhGc=;
        b=gUXrq9uX/8YvH+Bm/LdSq7n1Tu3o6TR/V4wjJE3Dpy4F3NyBv0k/cDRabaAq7GpLDX
         qsfr462V49Ukc3yKOBeQOSkbUmP3Kq93LWZ9CSmNzKSXXALZ2ynQLlHqgWnC8gw5Dpel
         FaF+XBIdjC45s+q2LO/AfZFZwxDGhtLaECRtyaNRe9ulcE/PF1n5CljCLDt1A0oWR+Yf
         CIwKGV5d1GB0N3TxeCi/sYZ9/aHU7Bvj3iwXqv/to3tKtumMnduc2J+J8RdZQQ35tktu
         F7gpyz68Wklo2A0HYfa2UStYXiw0j6FKPSHXHkrJEi7IlyoAoI9L6yRGDoY6go99B67D
         o/Qg==
X-Forwarded-Encrypted: i=1; AFNElJ9e7Zy7q69+Yw05eLh20ZMkuOjoBW3qUgLx0+bOSS0hcY1i4ZyOBUNV58Yh0A8962encBrv@lists.linux.dev
X-Gm-Message-State: AOJu0YxDBorP8ZfMsPirBsFIoRSBAIrXprDVZRh9T7iKnVEoP/5IV3rE
	pwLr2n+e+b7E5PPgPixSLzm+6opSt8WfHltvAh+i1Q/YZ6BhJbRBs2dt
X-Gm-Gg: AfdE7cmAmogqgBKO319Qu50i/fmTqh+SFXx/SNj+DowPIPhcLgqewiq4kMhRY2X3vZF
	PEzjcqczOfp6FgP8bfWSZJ/rKrTne/1Phf2zq9RSZSyxOR0YmhixnNHc/3/EJH3ZQQfEngbx7Bx
	0F3Esr1i/QI+sN1PoQy9t97Zncw6qsSRnImaAnF/UnPrAzwVTRXNwfWm2tTAxdTor87lzsw/I6n
	4hGbUlaQSlzeQOnklBryIe+67JUzicXFyqoDwhH6dsod7G48IsXr90MqBuMPRrRRL9U+Tz4effl
	f1/0qzfIlBfMmcl2xd2DLGoE48rmtKkxcUm7cwyGRAoIzSFRKb4cRAqrFP9hiF16DKhAvOeFlJf
	WqUhXEinpzFar7omw1lSwhFDsumxXKFTiFd+CiHhrPMH6RJK6LiUNaDrspMUbIZfoM7AUxGhVc8
	KlzFCoyJrUFJZTkHt7fDNYX+0TyXn6WCTPJWBJqpRj4vb5mkmS5FsxWVX9Gabwe3eWlA==
X-Received: by 2002:a7b:c016:0:b0:493:adcb:d368 with SMTP id 5b1f17b1804b1-493d0f0fa69mr1355385e9.9.1783089600739;
        Fri, 03 Jul 2026 07:40:00 -0700 (PDT)
Received: from localhost.localdomain ([85.193.42.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dde19fd3sm19524399f8f.25.2026.07.03.07.39.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jul 2026 07:40:00 -0700 (PDT)
From: Matus Skvarla <skvarlamatus@gmail.com>
X-Google-Original-From: Matus Skvarla <mskvarla@redhat.com>
To: stefanha@redhat.com
Cc: asmadeus@codewreck.org,
	ericvh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	sgarzare@redhat.com,
	skvarlamatus@gmail.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v2] net/9p: add vsock transport
Date: Fri,  3 Jul 2026 16:39:58 +0200
Message-ID: <20260703143958.45652-1-mskvarla@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260703054133.GB448934@fedora>
References: <20260703054133.GB448934@fedora>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 03, 2026 at 05:41 +0000, stefanha@redhat.com wrote:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks for the review!

--
Matus
