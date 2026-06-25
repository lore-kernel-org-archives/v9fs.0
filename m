Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD293E8333
	for <v9fs@lists.linux.dev>; Thu, 25 Jun 2026 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400602; cv=none; b=EJ6g+rbBCT1wqEh1dJtD4aXjwFkR4fkRBfR2sVWgF+7dXnX051S6ykKpWJwJp5TuNSV8eUr95+xIVkGiPacYvzy7EfxW5I+jTlWo952ZSQyEuRXlv8pEKeP2C9JJPRK6N8hkN6NGdKxRGCONZpBC3SHq1bkErjVYfOdZzCZg1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400602; c=relaxed/simple;
	bh=EIqqXcdIoOPiV+NIqbqMUH2LndGKssX7DiW9OtUpJvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs2IJtZxrNCDvPf1mMlgVNLwezF+lWee1Mclxzrrj7ZLbCQHEpI0rmwxr4Cv69nBHbzxBvqx+yO+Z9JdAy1YhiMCLI9CaXEIeBQKAVIJlnOufLHnXzJDLWl3dl3p3NB1KduYnBr7Ro1d9rKbRfMYFxVdxBcWK21O0TKmS6MdkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR84hRUU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR84hRUU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4923139e940so15240595e9.3
        for <v9fs@lists.linux.dev>; Thu, 25 Jun 2026 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782400600; x=1783005400; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIqqXcdIoOPiV+NIqbqMUH2LndGKssX7DiW9OtUpJvM=;
        b=fR84hRUU2USNl0GVPqJbTbd0gvQOSzNZ6qqZ0Kxs383DDUuwwJGdCaZcs/MSzMblDF
         qM+HbngQsHXz1PH+OgIgH+kMNHHUAUxvyWF425MnvSvejCbbnPAWpUsm9ePxYoZBdz6N
         75Ps4c3SpeIwF6YaVdZZ2dOrDPBHllrPGST0IN+i+2f5kH+krhZkVDvkGJb/mZJ3L11z
         HGWdx8LPNkQ0tDdbRraHRDQa7mvveqGLzl+2KVPmbuK/wnJtzkv6Sxu4dC61RT4gmZbN
         QbA3pvRfkUTYr6sYOegs0qPNtNAuEeDBJGejkj3QmQ40uGQs1eBqORsS7VYAo2o5sC2F
         euWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782400600; x=1783005400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIqqXcdIoOPiV+NIqbqMUH2LndGKssX7DiW9OtUpJvM=;
        b=PnqoEQ/bCXMMlNZp6tSUZvZDdrHbUj05mkoBZKo8BIPpDYsIN/M6Ay7IwkU4pyV3H8
         TfVEIqOxfj/irzSe35zsEI+OiqE0IlRGelA/PT+ehJ0nxcy0KqWG+rooRmKaOoDT0cXO
         JJAOrYVKU6n71AvMdl+alkD9A21AFD8UA1O+VewblgqN8BC9JsIXr2ooWYpiTLNKqpfE
         VUssTy0Mi2Kl9J0+0t2JHXvA6+yJIfRlYtFwT4RpR/w3qMtDzzsBKoXrDVywi3687/Gv
         uvh1UYYnAy1/89JSETiRYrILLZmYbbubx/HNcHwi0cwJu9ae3hRi0rDtPkpTQ07ny0aR
         WPOQ==
X-Forwarded-Encrypted: i=1; AFNElJ86CNC5+0Lw6e3yeZB+sZpGjuGY3Yv5oDq3ULNDHdv5DffsJSPnc1hkSntHwe247c+yKS2M@lists.linux.dev
X-Gm-Message-State: AOJu0YwoDU/zTgQamEHUQa8JuQ7ciUgoik3vjMikxeKcoLHgAVRJST0B
	tQDgKUP6qA4/PYuILOhBt2VOf9Wmdl4F+mju/2jUpqrEDMRb4G69ZXa0
X-Gm-Gg: AfdE7clRxmj7kT8vO2oNAs014TIZlb6DNmfdRTXBcW3JDfSEE3wRMIiv36KwcB63qL0
	wpAKxfYUPSGQlubgFUQkyJ8x1ztJsYN/oXxMPL5j3GSxJk7dVO+zvl+U6cOVWGO1xAtlZhu27Jh
	LA5udrfVB8m3pf/qIbNmhXEEz3+z9Iueu7ETFhd3qOKk+ReN7XF2e8vKI7FF4ApqNYZfhMT1I2c
	eQRNlLAT98phzNh59TzeQt6rZW7zQKmpRfw6mTmt9BNBeUXTLmqHHTDinm9Pyp7jhOn+gnGPkCb
	XZbrvWfQgFYchEmoeSH2DpYM1ceP7/4+XRrzJ/SAFnF8HogUPrxulrm6EhA+eXgaV3PH8YLunpy
	4PmIXEosGW9xctHHkvTMX9XI6J9CMeHkyeq89/g/cVTl09peETQe6sZOkAQQOcxAzuqHQ4FCbUs
	vn7inn9pEZMXZZZ2CqIL/zZg9WeqfKcEps85e6mWH1VbXa5k/J3CnPTfMH0vVGRxc+memrntlCr
	B0AoVzSfkj9Kmi6DyYRU6KDri0=
X-Received: by 2002:a05:600c:c4aa:b0:492:3445:ecf8 with SMTP id 5b1f17b1804b1-4926685fe2dmr40322555e9.3.1782400599376;
        Thu, 25 Jun 2026 08:16:39 -0700 (PDT)
Received: from mskvarla-mac.redhat.com (adsl-dyn180.78-98-2.t-com.sk. [78.98.2.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492691f60bcsm1420565e9.1.2026.06.25.08.16.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 08:16:38 -0700 (PDT)
From: skvarlamatus@gmail.com
To: skvarlamatus@gmail.com,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	stefanha@redhat.com
Cc: sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev
Subject: Re: [PATCH] net/9p: add vsock transport
Date: Thu, 25 Jun 2026 17:16:36 +0200
Message-ID: <20260625151636.26449-1-skvarlamatus@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260527073447.86538-1-skvarlamatus@gmail.com>
References: <20260527073447.86538-1-skvarlamatus@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you all for reviewing this patch and sorry for the
late reply. I am already working on a v2.

I wanted to ask you about your opinions on the issue with
port number truncation. The port number is parsed from mount
options as u16, which is sufficient for TCP, but vsock uses u32.

I see two ways to resolve this. One is adding a new command line
option for vsock only that would be stored in a u32. The other is
changing the type of the port variable to u32, and adding a range
check for TCP.

Personally, I would lean towards the second option.

--
Matus
