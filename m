Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC3331235
	for <v9fs@lists.linux.dev>; Thu, 18 Dec 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045663; cv=none; b=lsbJE5WQQzkiJfhZ3TGGGURjhcun5txGT4wkyd8zo3mQnAVgqyX/Fkd5yqNLO4RR/oJU1tz5w7YPVjstbqA5pcT99a5iF+B2fa7nVIv/86Xh4X/9HB+Ybo2K3TS5xrelYFyfgXxNf+YYPHFku7ZK4gCmRUYINd9+0UZs2F5ztrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045663; c=relaxed/simple;
	bh=HzL8Pw8FRKEyfnw9DMyj6jkTR46N8YmfQmd8TVDfefA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEgs2JuGTNZhJS/1nR0cb6A+m7vdS/Mxk2fKpL+KvHyhU1nEIP0QUMesee0SdDZTXfc8FYRX7k9GiRJJelGz1tqRprxzZ61H5flowb7VuaM/0wifQtWdfgJDLObg4iU24qTlJn1AFSxaAQ3M/aaqtpsl0MCDatAl+XvstlpsaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tc/K+d3d; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tc/K+d3d"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b4f730a02so408226a12.0
        for <v9fs@lists.linux.dev>; Thu, 18 Dec 2025 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766045656; x=1766650456; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HzL8Pw8FRKEyfnw9DMyj6jkTR46N8YmfQmd8TVDfefA=;
        b=Tc/K+d3dmciP4Ac1ot8pmuTNBk8NX8VSOeSCLleYGAvM0C/lWT1PG+ynSaYdQCBVMD
         jRKR8u6QzQF4UsGDYSnRcTtgvNg2ve0cUEJtkQSpdnE/uxAZsTsoIC6CcFc6W3bGmdnT
         6L9RLRNfKn8UUgc4GeylEHKL/DfcRLWh7YACunajR0TX+u+yaJcfOo9O1YlZsUPVAW+n
         ZBl8gm5fkAYf5s7OMGRZzCrBtVFW5MSRzU6dt2qNuHjyzunkOOzf6eoRAjXsb+V8AvO2
         DW2TzWLY/9gJC2QQcaJt0AjfmvhkC0xfjyEjTlfXNtZCR+raMg24tS5YM58QuZvQW3Hi
         KfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766045656; x=1766650456;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HzL8Pw8FRKEyfnw9DMyj6jkTR46N8YmfQmd8TVDfefA=;
        b=QHlrRH9q8IQM0pV26wn8sNZD3N4xRB1vqAzkUnRAYReKVnIxIWiFp9/XvKXO12wKaD
         0mDIoQBYay2uAlgXhMsoxJFIGcZ9aJaq0mo5jn5foFuEKlFaIr51/fOEOITjTd2lb/gu
         KfFg1hsTO/r9QtaDFrWl6kfSw6YhPNqdySWUvc4//ILGcC/YihjZzC0HwNh4KqJmm1WI
         UR2bB6bKHlY4t95PFGXbGENoKvQJaS2Utg49uTZCxYUvqIajfcqge0tNUkzmxnbEY7Re
         49OOMqlthtuvoMs4VoCXu7O8OrYS2KflAUw88T4kxD1QzcHsWSqcX4Ycl1RHO+Z1X52b
         Ze2g==
X-Forwarded-Encrypted: i=1; AJvYcCX1mGFd3xLsYwUV6iB/HVr6fUCVFyGkFjWd/D5vdKwB0FdrdF9idBiq6FyNTyl9m69wbm5s@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1bnUyGBhoaOH9vgCmvJksb1zq2wWhdgRP6oumtcHPJToRio3t
	quDjP+2UE21b9SkcNYyMhhnJcwqIWHRKDi2pE32mtei1eoqsDqJJI7YuE27X+ii/q6EiiXE3UKP
	QUL/L
X-Gm-Gg: AY/fxX7QWqU6oVbjc5scvUctJWFPTQj+qO/mFuNLJOQfvNBL09eXzWUeidOP2V0MCB8
	BHNal+yS2SwO4pIrDllQW/7zn78rwezPksIGB8pptzZ09V6YZMay+EHyNNgXmv0HKSd9hU7iYnz
	y+kKvwukuL/EoWfhaXK/NN+VNLU83rdRe8L+H3kUGuA2aeGbGTaxck0Ot9Qy+QcCBlh3fTuBwEy
	75h39J6Ho3fdWbmTNb2lBWy/7qZUYzTsg+Efhb2yjQ+BHlQBHAlrgwM2FMMPZnTg2xY0FkKi3xC
	B0nCc9KgMiyzlT2k1cXYe2iTd8q9eONKvl5UwwajeUghzvhLIjyLLT4vgg+vTCCM28QsAkSe0EA
	eI5ezveTaWhL/W4Ecegx7xCfSlpPmi+07RMHweE/J1ISPoxLpmypGzYorbY8zaJ9Epwcak8r50s
	ln1E7+7C4ezwSBHVxQ18l1K80224LZLPieQZW8hOxGMmiUwswYiMOdAHWBD9DeLKUd81YBWXHBV
	b1QWOTDzY1byjmLwM7NUevHGR2O7JN6XMnisAx+vGhXsXzrkw==
X-Google-Smtp-Source: AGHT+IFMf1oNsW+AzB+TyZ6oAcfADs9kfShUc0VXAws0YQx6M+d5h8ZtcOuzZEINE3WIsMUo/fuqgg==
X-Received: by 2002:a17:907:7285:b0:b74:9833:306c with SMTP id a640c23a62f3a-b7d23a5ee67mr1924057166b.47.1766045656557;
        Thu, 18 Dec 2025 00:14:16 -0800 (PST)
Received: from ?IPV6:2003:e5:8704:4800:66fd:131f:60bd:bc29? (p200300e58704480066fd131f60bdbc29.dip0.t-ipconnect.de. [2003:e5:8704:4800:66fd:131f:60bd:bc29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80234a2c0dsm151625566b.51.2025.12.18.00.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 00:14:16 -0800 (PST)
Message-ID: <548207b3-c941-4956-bf2c-11eee467777b@suse.com>
Date: Thu, 18 Dec 2025 09:14:15 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: mark 9p transport device as closing when removing
 it
To: Demi Marie Obenour <demiobenour@gmail.com>,
 Ariadne Conill <ariadne@ariadne.space>, v9fs@lists.linux.dev
Cc: xen-devel@lists.xenproject.org, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, lucho@ionkov.net, ericvh@kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, Alex Zenla <alex@edera.dev>
References: <20251208195155.27473-1-ariadne@ariadne.space>
 <409cccec-15dd-4e80-ba56-f0bba12772cb@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <409cccec-15dd-4e80-ba56-f0bba12772cb@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------28Ghrc4OCSathJiwNAbK3Ixs"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------28Ghrc4OCSathJiwNAbK3Ixs
Content-Type: multipart/mixed; boundary="------------EUnWjdmBHMkVjcONGSsRRrh7";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Demi Marie Obenour <demiobenour@gmail.com>,
 Ariadne Conill <ariadne@ariadne.space>, v9fs@lists.linux.dev
Cc: xen-devel@lists.xenproject.org, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, lucho@ionkov.net, ericvh@kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, Alex Zenla <alex@edera.dev>
Message-ID: <548207b3-c941-4956-bf2c-11eee467777b@suse.com>
Subject: Re: [PATCH] 9p/xen: mark 9p transport device as closing when removing
 it
References: <20251208195155.27473-1-ariadne@ariadne.space>
 <409cccec-15dd-4e80-ba56-f0bba12772cb@gmail.com>
In-Reply-To: <409cccec-15dd-4e80-ba56-f0bba12772cb@gmail.com>
Autocrypt-Gossip: addr=demiobenour@gmail.com; keydata=
 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
 BPAiznAMOySMAGngUw==

--------------EUnWjdmBHMkVjcONGSsRRrh7
Content-Type: multipart/mixed; boundary="------------n5jEUTnsteudRSKfi9h8GnMS"

--------------n5jEUTnsteudRSKfi9h8GnMS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMTIuMjUgMTE6NDEsIERlbWkgTWFyaWUgT2Jlbm91ciB3cm90ZToNCj4gT24gMTIv
OC8yNSAxNDo1MSwgQXJpYWRuZSBDb25pbGwgd3JvdGU6DQo+PiBXZSBuZWVkIHRvIGRvIHRo
aXMgc28gdGhhdCB3ZSBjYW4gc2lnbmFsIHRvIHRoZSBvdGhlciBlbmQgdGhhdCB0aGUNCj4+
IGRldmljZSBpcyBiZWluZyByZW1vdmVkLCBzbyB0aGF0IGl0IHdpbGwgcmVsZWFzZSBpdHMg
Y2xhaW0gb24gdGhlDQo+PiB1bmRlcmx5aW5nIG1lbW9yeSBhbGxvY2F0aW9uLiAgT3RoZXJ3
aXNlIHJlbGVhc2luZyB0aGUgZ3JhbnQtdGFibGUNCj4+IGVudHJpZXMgaXMgZGVmZXJyZWQg
cmVzdWx0aW5nIGluIGEga2VybmVsIG9vcHMgc2luY2UgdGhlIHBhZ2VzIGhhdmUNCj4+IGFs
cmVhZHkgYmVlbiBmcmVlZC4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBzdWZmaWNp
ZW50LiAgVGhlIGJhY2tlbmQgY2FuIHNpbXBseSByZWZ1c2UNCj4gdG8gcmVsZWFzZSB0aGUg
Z3JhbnRzLiAgVGhlIGZyb250ZW5kIG5lZWRzIHRvIGVuc3VyZSB0aGF0IHRoZSBwYWdlcw0K
PiBhcmUgbm90IGZyZWVkIHVudGlsIHRoZSBncmFudCB0YWJsZSBlbnRyaWVzIGFyZSBmcmVl
ZC4gIFJpZ2h0IG5vdywNCj4gdGhlIGJhY2tlbmQgY2FuIGNhdXNlIGEgdXNlLWFmdGVyLWZy
ZWUgaW4gdGhlIGZyb250ZW5kLCBhbmQgbXkNCj4gdW5kZXJzdGFuZGluZyBvZiB0aGUgWGVu
IFByb2plY3QncyBzZWN1cml0eSBwb2xpY3kgaXMgdGhhdCB0aGlzIGlzDQo+IGEgc2VjdXJp
dHkgdnVsbmVyYWJpbGl0eSBpbiB0aGUgZnJvbnRlbmQgY29kZS4NCj4gDQo+IE15IGluc3Rp
bmN0IGlzIHRoYXQgdGhlIGNvcmUgWGVuIGNvZGUgc2hvdWxkIHRha2UgYSByZWZlcmVuY2Ug
b24NCj4gZWFjaCBwYWdlIGJlZm9yZSBncmFudGluZyBpdCB0byBhbm90aGVyIGRvbWFpbiwg
YW5kIG5vdCByZWxlYXNlIHRoYXQNCj4gcmVmZXJlbmNlIHVudGlsIHRoZSBwYWdlcyBhcmUg
bm8gbG9uZ2VyIGdyYW50ZWQuICBUaGlzIHNob3VsZCBwcmV2ZW50DQo+IGFueSB1c2UtYWZ0
ZXItZnJlZSBwcm9ibGVtcyBpZiBJIHVuZGVyc3RhbmQgTGludXggY29yZSBNTSBjb3JyZWN0
bHkuDQoNCkkgbG9va2VkIGF0IHRoaXMgaW4gZGV0YWlsIG5vdy4NCg0KSSBkb24ndCB0aGlu
ayB3ZSBoYXZlIGEgc2VjdXJpdHkgYnVnIHJpZ2h0IG5vdywgYnV0IHRoZSBpbnRlcmZhY2Vz
IHJlZ2FyZGluZw0KZ3JhbnRpbmcgcGFnZXMgdG8gb3RoZXIgZG9tYWlucyBzaG91bGQgcHJv
YmFibHkgYmUgcmV3b3JrZWQgbGlrZSB5b3Ugc3VnZ2VzdC4NCg0KQ3VycmVudGx5IGl0IGlz
IHRoZSBjYWxsZXIgd2hvIG5lZWRzIHRvIGhhbmRsZSBwYWdlIHJlZmVyZW5jZXMgY29ycmVj
dGx5LA0Kd2hpbGUgdGhpcyBzaG91bGQgYmUgZG9uZSBieSB0aGUgZ3JhbnQgaGFuZGxpbmcg
KGhhdmluZyB0byBlaXRoZXIgaXNzdWUNCmdldF9wYWdlKCkgb3IgdG8gcGFzcyBOVUxMIGZv
ciB0aGUgcGFnZSBwb2ludGVyLCBpbiBjYXNlIHlvdSBkb24ndCB3YW50IHRoZQ0KdW5kZXJs
eWluZyBwYWdlIHRvIGJlIGZyZWVkIGJ5IGdudHRhYl9lbmRfZm9yZWlnbl9hY2Nlc3MoKSwg
aXMgZmFyIGZyb20NCmludHVpdGl2ZSkuDQoNCg0KSnVlcmdlbg0K
--------------n5jEUTnsteudRSKfi9h8GnMS
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------n5jEUTnsteudRSKfi9h8GnMS--

--------------EUnWjdmBHMkVjcONGSsRRrh7--

--------------28Ghrc4OCSathJiwNAbK3Ixs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmlDt9cFAwAAAAAACgkQsN6d1ii/Ey9Y
twf+JmNTs9FPPnEeuIqacdYtb9bZSMWfUIvodrF8wc2c2QJWFqdIBaORZJZJSKlSt05a4LaqHRUZ
NuIWlaw6TQ8b7zZCWu8H2ZJJm3j96rVMAf19N9Et1fDiKTwG/h6M7JnPjuLKKoEUb5IDw7QQ3dDG
txb7YQi4S/N52hb2+g4S8XhLa3kEPW85GjzBjLdHAmH+CIMkpiE9Q4JgIizC1MiONSBNGcq51U+7
QaALrKTRVhnV1hS5zk/kI1rUP9xAOdjbe3fiHq7gdaQgA1+m/90N704y6/z3zP6CAox5RKfH5p2+
byJXpICZ/s26njxcHqRzVC8WonTAYIMI1dSpOEY8Zg==
=TLDF
-----END PGP SIGNATURE-----

--------------28Ghrc4OCSathJiwNAbK3Ixs--
