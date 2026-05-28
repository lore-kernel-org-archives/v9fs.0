Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E081343D8A
	for <v9fs@lists.linux.dev>; Thu, 28 May 2026 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951351; cv=none; b=u4qGtpGb8Db6L/B23QmQPy5JkMrbTlVtUzRGP6ing0PR6kQqU/w0Bw7EFGo1wZ1wPNdRKyJuztvji1eBe/uqZ47Ru1BDClcDuxBcDw9khVKiKUBbgXtnoSAhOn2YzmdwrzwAFdxkLMkRF8dEieIO8Pscx0xQ6wypMBZbjDwNOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951351; c=relaxed/simple;
	bh=SVXTfhF2wAhS5kAQWIwVdr9J705bGFJMrvzUErxndb8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFjtGbfNW7XvA7Dj5Ie9i8YdVFxBe1zzs7FHsuzYm27PadaVT/qiIw2hdPfVePfRz3trM7wGd3EEjd3JvtLzfpBRfKyNVjAsueaWO3QQU0lVICPfwRRQG9403qE4Ez7xEqBbIpkoUYlfGx/OAsUnrzf2AiBp7RS2MI+hoW5aTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJv8k4v3; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJv8k4v3"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dccb5f4b1cso1696387b3.3
        for <v9fs@lists.linux.dev>; Wed, 27 May 2026 23:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779951350; x=1780556150; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVXTfhF2wAhS5kAQWIwVdr9J705bGFJMrvzUErxndb8=;
        b=qJv8k4v3tz9VpmcjXW7pj5Nf8yiTpcoSCoD4GJmqjY0B36QNonakvVWTGyZZ90OHAD
         TshIuGeyhtVfvDECLQV6jJ9t+UqngjS8Ni+VCY1uRQKHvziC/qL1xA/oNHSdRZz8I475
         Fn+ZZQy9I5MsGHUF6fBH3zvKECIASuWw28Vhg3DWYSpJVtlG8wLZDgRLHXDi5l3dSVjK
         CSIX8VjIxJps0XuMarG8Tj2MUq3TVsHDUF0VZLBuF9FcZ0DKVvzMZYHc4XOxDh4uxM8N
         A2RTpnXaR7cYliqTNsdBINKFlhB3kYpMldL0F1qawIXXg7NN2yYnHlfCMGPMBe3M+857
         MIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779951350; x=1780556150;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVXTfhF2wAhS5kAQWIwVdr9J705bGFJMrvzUErxndb8=;
        b=ZGwKPZH5fNONfD3LlNRnlmdN/qyAxM6RgSsSYoJEfQ7uGLiZTomUSfbegEKVgHgTEv
         dLnYF526oAHXk71WXTB4c2GhxDRrTmXTde/opd1r4yuiVnO2QgD+RXnywTz32Qndx8tu
         TeeAhhdaQkpUtFKp3t+idkSaRNas0+hFrPw6jF+/My7Ukud2jUDW/CQShDHKgOWiViol
         2l/CQytgHFKqK4yImp1jJyzwAYsHINZAZAlpFDo4Nxb7F6PcloYiTEVQYzT0M6E5M6Zj
         bKga8QiNtPXE926TC8UbdKvVwu7DQivvgxQ/ugamIEVM0g7208txWpRoDNm3ts/L4n2c
         bHiw==
X-Gm-Message-State: AOJu0YyqSnOc/t+Gg/VScUjS9ycqrG+3u6XXTNhfaaRCJbaNiHk7dHed
	D+xpRe5heetYaN73MqYxUdYcQg0oqNDbj/WcHtzqg/6lf2An0dkwx7vB8Eutavdq
X-Gm-Gg: Acq92OGe60AXaGzVgBLxlytJv6ObGVRA4AK6b5+MyETibiucP//GEjURfA0yQB1O75G
	ll/GthbGK/FBwdgPFkFdPQfaYT/dJW5oLFph9mNvU+8+G2VmJM0DRMH84MkhcL1oOWkp5jfZvDq
	NF1LM2dbIqoEXIuBGRoGcgXbXSzGcrxXW7Ol6yZX6Rg9ZPea48yc7PXz3hgoe5w49SMlrIOE97/
	yTWm8+ZNmih+dSWWS+Jx00KSka6Ay/dptciXlwQltscDXJHF9eTQD/Pdp7+S4Btb0n5ifd6S9+5
	FesUSlMURGWR6uFjG6e83CJhvS2TN3RQAVXtLCLHcAG9Q9VdjECwgooQJNBq3mzlaHRWYUQ+ds+
	oBkIXkBa1MI50OahsCzHPLQtSA+BFgzwFyZnzemfkMh4Dmy3pmJKQpb3nzQUlL4zH74MPWVBODa
	4HxC9x/MiWjZBkQdxRJ0z8K4kW0dCyibBPnPrqmip1tMU1U831xylHSjp1R0/3yE8nlFc86vvhj
	RFoZrELB5/W4veN9GX1jJPhme3dQX4A
X-Received: by 2002:a05:690c:3388:b0:7bd:9ce7:164c with SMTP id 00721157ae682-7d338682c32mr285621267b3.43.1779951349489;
        Wed, 27 May 2026 23:55:49 -0700 (PDT)
Received: from SE1P216MB1244.KORP216.PROD.OUTLOOK.COM ([2603:1046:c07:800::5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389d173eesm86768307b3.15.2026.05.27.23.55.47
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 23:55:49 -0700 (PDT)
From: =?utf-8?B?S2jDoW5oIFRy4bqnbiBOZ+G7jWM=?= <khanhtranngoccva@gmail.com>
To: "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Subject: [BUG] 9p filesystem does not honor turning off O_APPEND if a file
 handle is opened with O_APPEND
Thread-Topic: [BUG] 9p filesystem does not honor turning off O_APPEND if a
 file handle is opened with O_APPEND
Thread-Index: AQHc7khWLsIDxr7DvUCTuneUjnkjzbYjAM5V
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 28 May 2026 06:55:45 +0000
Message-ID:
	<SE1P216MB1244C510206B0E41478E1843FB092@SE1P216MB1244.KORP216.PROD.OUTLOOK.COM>
References:
	<SE1P216MB12443CDB57EA1BD32A45FAEFFB092@SE1P216MB1244.KORP216.PROD.OUTLOOK.COM>
In-Reply-To:
	<SE1P216MB12443CDB57EA1BD32A45FAEFFB092@SE1P216MB1244.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

SGVsbG8sCgpJIHJlY2VudGx5IGZvdW5kIGEgYnVnIHdoaWxlIGludGVyYWN0aW5nIHdpdGggOXAg
ZmlsZXN5c3RlbXMgb24gV1NMLiBJZiBhIGhhbmRsZSBpcyBvcGVuZWQgd2l0aCBPX0FQUEVORCwg
dGhlbiB0aGlzIGZsYWcgY2FuIG5vIGxvbmdlciBiZSByZW1vdmVkIHVzaW5nIEZfU0VURkwgZGVz
cGl0ZSA5cGZzIG1pc3JlcG9ydGluZyB0aGF0IHRoZSBmbGFnIHdhcyByZW1vdmVkIHN1Y2Nlc3Nm
dWxseS4gVGhlIHVuZGVybHlpbmcgZmlsZXN5c3RlbSBjb250aW51ZXMgdG8gYXBwZW5kIHRvIHRo
ZSBlbmQgd2hpbGUgdGhlIE9fQVBQRU5EIGZsYWcgaXMgZ29uZSB3aGVuIEZfR0VURkwgaXMgY2Fs
bGVkLCBhbmQgdGhlIHNlZWsgY3Vyc29yIGNvbnRpbnVlcyB0byBwcm9ncmVzcyBhcyBpZiByZW1v
dmluZyBPX0FQUEVORCBhY3R1YWxseSB3b3JrZWQuCgpJZiByZW1vdmluZyBPX0FQUEVORCBpcyBu
b3QgbWVhbnQgdG8gYmUgc3VwcG9ydGVkLCBGX1NFVEZMIHNob3VsZCBoYXZlIHJldHVybmVkIGFu
IGVycm9yIChFUEVSTSBzZWVtcyB0byBiZSB0aGUgbW9zdCBzdWl0YWJsZSBhcyB0aGF0IGhhbmRs
ZSBtYXkgb25seSBhcHBlbmQgZGF0YSkuwqAKClRlc3RlZCBlbnZpcm9ubWVudDoKV1NMIHZlcnNp
b246IDIuNi4zLjAKS2VybmVsIHZlcnNpb246IDYuNi44Ny4yLTEKV1NMZyB2ZXJzaW9uOiAxLjAu
NzEKTVNSREMgdmVyc2lvbjogMS4yLjYzNTMKRGlyZWN0M0QgdmVyc2lvbjogMS42MTEuMS04MTUy
ODUxMQpEWENvcmUgdmVyc2lvbjogMTAuMC4yNjEwMC4xLTI0MDMzMS0xNDM1LmdlLXJlbGVhc2UK
V2luZG93cyB2ZXJzaW9uOiAxMC4wLjI2MjAwLjg0NTcKCk9yaWdpbmFsIGlzc3VlOiBodHRwczov
L2dpdGh1Yi5jb20vbWljcm9zb2Z0L1dTTC9pc3N1ZXMvNDA2NDkKClRoYW5rcywKCktoYW5o
