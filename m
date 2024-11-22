Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DC156C40
	for <v9fs@lists.linux.dev>; Fri, 22 Nov 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261299; cv=none; b=osGmkrWCfyIR8dCtlIvOYKO8blV6o8SiO+Z1rPefSovOTnTPJCLdiRBBO7IHlVAtD08xivm5z2xvqSg/uzgXBChjLAy0M9TUBDIhFKR3uAcdkZJjdNHuFr2mfG7fnU5Yxujp6zBk99s6dXjVqgm7TKAyHGbHg07ec5lnEwjA+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261299; c=relaxed/simple;
	bh=cCF4a7xZu3k4CvCsXul+R4V71IZtblzB8rKccNz1NPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZNXmZfrj2SAXssCSAEkg1geMkTRfp/hNWV6vUzcrQisGD7Y+/v5wCHsgSwW23UyJJ2JIgxl1jlFXTDIqLFt2O/JV8dOpyf/WIGF/xt286rAFR/OArtTsruCEu1jWbuKRGM1KBhaMWM9xd0RmtTzoqK5sl5AYVcbz11M3Q7mCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M8AMfalD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M8AMfalD"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e71401844so239471466b.3
        for <v9fs@lists.linux.dev>; Thu, 21 Nov 2024 23:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732261295; x=1732866095; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBHoeELbwDLkucIgeo0FolILCzjYH65AZPyoPhvFLo0=;
        b=M8AMfalD1Uchn/hYcH1mPkBHaDE3gFzSfoqm+gwQJzT7FPD8pgnhSV+Y/Q846iNziV
         pGhXA2hh9vjQpTqeVbGdIFibKOtQb3OnTtRBYcspFwQgPrF4aO+7cdtHHOggV6xvdvvP
         0tteoFCmDoTCpAyP8EymU8Mz4EYh65WPbr3UggS5r7EikDorRyFcCL+kYvJ2GXvYM4OI
         AB72AwiTedWxyQpv4u2pSZkKh3xnVsnACFqfwJ1Kw7LFgNJJB/sz1d7MitsMGBSGSspN
         SO/ivixxKe6UfI2kaRzAIE1qSLT6R0jOXuM7RyQcQCvgHCZyuGUpiwDY/wpHXK57VzVP
         f4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732261295; x=1732866095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBHoeELbwDLkucIgeo0FolILCzjYH65AZPyoPhvFLo0=;
        b=RE6J1bY8OhPVjNMuQUkk9QqOMU+u7nFkU3/2Xdn8W2Kc+cdh2kXGhG7Y/nUglcklgj
         66gC+QH1Sb+PybiPNyPS8GDx/naZlYiHbP+xcSBn/lHnPhgsja6Y9d5Beh5Oy2yA6Dth
         e8kEZwVRw8IH7J1lPU4PXKxcu37zDSJJTvUMD10SvDuscO6tXnkpGdVXrVOi891xRR6I
         Km+vlYvOLlgu4pvOzWZnNYYJyCYdKq5Im79Br0vCLp5EzNcafGqLbOvvuNRgxtrP6cUF
         eAWUdBmlisTAnJ/zBV0u6/ZE9SrnAQCAXH2w3MVTbkEwTfabfwZIoPkUYsida+cDJZSN
         adxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJl0eOhPc7gaI3YkOkYolhx36TZEPTpcjn9wnpqS1Fi7FW8+tIGRJrRal6eCH76ry9g3rP@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3YDEnTwGVLlwQQPpq75ApX79hj/HBbJ7NJ9zhGbM+6h9lF9m2
	KS84dx6G+DWE0exgo4JpRnEBG7enWV7iOCj1GlfcR7Qx7P8UKqGViYw/V+CTie4=
X-Gm-Gg: ASbGncuyhy3tQZx7KUcgCk1AGDBqBz2VsBaLogkt/8neTDJkem+2rUrzsCqifA/Tid6
	wjyQ11XRp4GPdtv7LjwA6KEIMOr+AEJ560NGVy+4YNYKvmtcUE1YLjnMKLxggeynEIkY0VPaAej
	RG68NlwrURpdKyPmrNlmheWNb9OHVoI+0zt6oX00mHz1IA9eIDUe6CqBXRng0yxom+RW9+iVkuB
	6l5LoGt26KCTTm5KI8k13o0pgk91iu6KxWjPz0HvY/v4ZprrYtFRr7KyJqTvAYoT2zT6+0COvto
	5Nl/cRvTpCeWUP5ufDw82e+q1L/tBRptGFMQdUTdY1FlqADixDXr2ROOqJ6g6e1nxMbW6Lk6sUg
	=
X-Google-Smtp-Source: AGHT+IF52r/fIQbL1oofxnzTPJf9FWebVRq//EG7R9cwJOhSaBapeMtbsLC2alc3Bk+yr83btzoIrg==
X-Received: by 2002:a17:906:9d2:b0:aa4:fc7c:ea78 with SMTP id a640c23a62f3a-aa50997efb1mr140885766b.23.1732261295072;
        Thu, 21 Nov 2024 23:41:35 -0800 (PST)
Received: from ?IPV6:2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c? (p200300e5872eb100d3c7e0c05e3baa1c.dip0.t-ipconnect.de. [2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28fe1bsm66384366b.28.2024.11.21.23.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 23:41:34 -0800 (PST)
Message-ID: <f65fe715-2ef7-4171-8bae-b78438656dcf@suse.com>
Date: Fri, 22 Nov 2024 08:41:34 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: fix release of IRQ
To: Alexander Merritt <alexander@edera.dev>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Alex Zenla <alex@edera.dev>,
 Ariadne Conill <ariadne@ariadne.space>
References: <20241121225100.5736-1-alexander@edera.dev>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20241121225100.5736-1-alexander@edera.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.11.24 23:51, Alexander Merritt wrote:
> From: Alex Zenla <alex@edera.dev>
> 
> Kernel logs indicate an IRQ was double-freed.
> 
> Pass correct device ID during IRQ release.
> 
> Fixes: 71ebd71921e45 ("xen/9pfs: connect to the backend")
> Signed-off-by: Alex Zenla <alex@edera.dev>
> Signed-off-by: Alexander Merritt <alexander@edera.dev>
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
