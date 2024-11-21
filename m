Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF21D31AE
	for <v9fs@lists.linux.dev>; Thu, 21 Nov 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190448; cv=none; b=BGBf+QjCflx7IJpe1GafKAKiXAfM1BXz2wWnPmo8m46z4gW4fUaSbyKe4XJA3Gmrj4e9h48GVFotJxUipnrDQPTjzQ60+WGg9BY2XcapP9jBeGD9XDZoIRJ7cTJquOkzKnIoOjAz9dksPOHmpBut6f4sP10ET/6/v6+EPvNmSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190448; c=relaxed/simple;
	bh=MyO5QqG1xiB5nlAGLGeCcTjvMH2F3Lc1pDdC3EIoRxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfB4zBcQ5OMSXoYVWJRFHAhyBLvjFAnV9NN1Tm2gvnVJ7h37W+j6RoZgEXu22ur4v/UCjeJQwiWF6oxM8OrtpgsZSgCncihTJjGGZeCerRPKunHv2znISntPN45/Q2nr1cDBOH0RT1FYiMTKHCDvDDM2U8eKmgMijvpoMy6JJ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y9uAetj7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y9uAetj7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431ac30d379so7078075e9.1
        for <v9fs@lists.linux.dev>; Thu, 21 Nov 2024 04:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732190444; x=1732795244; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EO9H7L51gE6cPNefBYVK5KHtIK+HLO0v1Tul0wks2V0=;
        b=Y9uAetj7fOFJXQrlori3T7WWCYhbtIH6Oasc8GsVkl+mSbAu+fE+OSf5HamSKzPluD
         P/8qbegyP8xaT5unE8UIQ+xaN2Ivz+UgqGVz2dHt1hDcAeYQXWgqdZe4PC0EuM5JYJC4
         4rW7jAGTDMkGK66yDJq76ACz/dxKZl8fnWM2mhbkvcIAyKljssAnSTaXtfYxbu+tevHG
         cxfcG9t/nupOinwOSZAt2cdENfzbwjj6e1xei7pjRJityb/E0sG3pctkRSVnJ9TvDl9d
         apTzAMUzseWCi3LaAfr0vGZWkRl6IpAjBJXi/VSARpW5JIpZTre+8h/4BQk/T/BO7nVz
         A+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732190444; x=1732795244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EO9H7L51gE6cPNefBYVK5KHtIK+HLO0v1Tul0wks2V0=;
        b=a9mubJYb9Kkie9/I8zUHroyzyK6VeNf6IVpYx5KpUgZz3lvxK5PdwBgZVNjnpSylF5
         WinDPyi+KFEyfev3piNg2DwJUm6NzPyYxplcqjQ/3gBadAW5PN15O1isvVQGEyPQetyB
         Omk12JWywB5P5nckmMM2MM+ZJlEkS35IoTl6+1ipRdeWKhyOaA2DEvcvzcCsZNVZb6NT
         VnzRsZhZhOuRdOgCzF+rSyZBFUpl7b0VVkLo8Wb+RYi8yToPSc2PFN8HQ1qg+Y2sgEVp
         Ir/Bh8kckLofUsXVO5/WVhNWrQRbTyG7cQ9FkaE5L0rtymXX4X30NSeyi5PiQpqV4D3c
         CzTw==
X-Forwarded-Encrypted: i=1; AJvYcCXVFJvzcswRLH48ddHG3oufT/vfXYz3BzUwwiHj74Bq+BbK2wlR/XPIFGKWxPJUBFl7x1j3@lists.linux.dev
X-Gm-Message-State: AOJu0YzcwbRZIRoV5PkV4hEQ8L0kDjZty+1KT4UBQ4hKmh1i0EF23dSP
	exx+RBx7Z7klX0IL0k2S2P3SXWrG8suxEcKOJMfybqF8iOnzmM9IC8tWUNtTI04=
X-Gm-Gg: ASbGnctNK9CTjVCsuxNP1qUt/QjzAIh8QbBy7KJFA103RK15RUvBIQzfpp5+SPDOg7G
	0HibCYDj6C25TjBW3/gd+jWwxr41MWz88ibf4Hj4Z2x+lkr448lZIV6Le9v9aopJVwaFioe85bO
	7n2P/rKTbVZmwL+tl5RzJn+G1xIQ8azmOKMRuSRRgmfNdv0TVfz6ECMACX/MdmuEERdoXXdKXVX
	VmIO0JcWk1M+2qBOb68soh/ukIEKVdQZeCYATD0eie5GcUCoqZ7AQWamk+V2blBGMs35WV8neTJ
	9ALudyhyHgvTz4ErSiRy4qywHG87vLgO8xdZTyPRcAoI+SBS8y6J8jeHQCBVC9wGGfgfyfshyqA
	=
X-Google-Smtp-Source: AGHT+IH/3NH9JKgLe2HMj+sVAVSzV5oHzHhIknlp/HwTvLcOeg4S3MgtK3eWa+wQPxuOZjcu3rfShQ==
X-Received: by 2002:a05:600c:444f:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-4334f017137mr48829815e9.23.1732190439548;
        Thu, 21 Nov 2024 04:00:39 -0800 (PST)
Received: from ?IPV6:2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c? (p200300e5872eb100d3c7e0c05e3baa1c.dip0.t-ipconnect.de. [2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490bfd6sm4799041f8f.25.2024.11.21.04.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 04:00:39 -0800 (PST)
Message-ID: <82dbba56-e803-4332-81f7-225e35048e1e@suse.com>
Date: Thu, 21 Nov 2024 13:00:38 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: fix init sequence
To: Alexander Merritt <alexander@edera.dev>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Simon Horman <horms@kernel.org>, Alex Zenla <alex@edera.dev>,
 Ariadne Conill <ariadne@ariadne.space>
References: <20241119211633.38321-1-alexander@edera.dev>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20241119211633.38321-1-alexander@edera.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.24 22:16, Alexander Merritt wrote:
> From: Alex Zenla <alex@edera.dev>
> 
> Large amount of mount hangs observed during hotplugging of 9pfs devices. The
> 9pfs Xen driver attempts to initialize itself more than once, causing the
> frontend and backend to disagree: the backend listens on a channel that the
> frontend does not send on, resulting in stalled processing.
> 
> Only allow initialization of 9p frontend once.
> 
> Fixes: c15fe55d14b3b ("9p/xen: fix connection sequence")
> Signed-off-by: Alex Zenla <alex@edera.dev>
> Signed-off-by: Alexander Merritt <alexander@edera.dev>
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
