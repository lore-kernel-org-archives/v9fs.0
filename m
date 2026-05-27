Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47703EB80E
	for <v9fs@lists.linux.dev>; Wed, 27 May 2026 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876432; cv=none; b=hPJ+V55FcCd6bC2VOXWJC9eVEHB/0Y1lkhnBduDFWkma9kwwC+q/ooWgh8zL4WocSmPJUtQr99LBpQ/8qzgem473ynPIO0JqKJZpHMd3S1/jk/BkSxfWKWqKYyXG6TO/xM8q3LPSsSkP9vfhlwN5QdVC/hvWh+dewj/eXcegX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876432; c=relaxed/simple;
	bh=6PiQZPhKVMypXtLiEi3TcidUmMvLiZvC2Mm62/FxlbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JK9G5HOIVsHcEdpuI8hZsrNjmAkhiYPjTKcP9FUmnSB9++MiBQBr2xqwaWAtlEF3xMTq7ikaaaMt+xVTh7q9U195HCli8DvjGTB0fehEjbnUL5H4VNsF5f/bKVKQoS8fXHPhPsIjkRGPUOIrPaBtGa7grDcYq8f7SPFDY9kuPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KRciJRvA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KRciJRvA"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67e9e343b22so15845045a12.0
        for <v9fs@lists.linux.dev>; Wed, 27 May 2026 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779876429; x=1780481229; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6PiQZPhKVMypXtLiEi3TcidUmMvLiZvC2Mm62/FxlbE=;
        b=KRciJRvAK2WIohVGjVi5FK0Tr/u/i/C7Fww7VxzIN9rGnYwEWNfVkDWR4hOJ65kdhH
         9RG6ZbqBDdjB2oe8c1rJdbpk6pePx0efrpTl0mwQvw9vxbs2dcTDDuTq7AT20hho09Au
         4wHzVrEqnrL2NnWJFqIBBzJ2HY94X2uKYlRGC2h0RrVARh2q6TCQWtR4miTrLXAJZRQV
         ONAXL7AmF2YCNtGLOS4s/wilIal1Knf6JReCzvn1jmqiFLCrzLmjhfFwW7s4ZIVYc18/
         ixtYKkBsq4OALkS8kHckZxz8mtEanYlE797zT2lL3PQ4pczbRJqASHHMnuYHNulHsa2I
         6ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779876429; x=1780481229;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PiQZPhKVMypXtLiEi3TcidUmMvLiZvC2Mm62/FxlbE=;
        b=DS3eCvjBdzCakssLq0EJEixQL0btUdJt4vxaFasWwf0ZDvSR4bmtb6/8wocpOfYtqr
         CbqMgmGNvI+d3HNcAfi0z30jeoJwdz0uSgyG3C5LTjLjx7CA+bqwQeLmrOoLp5FMtwge
         862Mujacg7RuFziOAqRl9SHnz9AQUqUkMVOtx+0tLmA8ubP0m6YwpN6i8SfzM1hhJWW0
         6UIBhibZNg2hLzmrQGbx3E74ZgIKkTtYS5DsiS7HNifVnO2oNjnHhb62XtYbLo2CzZ0W
         xpeGYjBCoPD2X7pHnftCiat5dgmWXVIOpM//qMrf3X88XhxxQpEqQofhUa6mcerb/HVf
         z/+A==
X-Gm-Message-State: AOJu0Yz8crDMetv5XZEBtdUds6NWxGz0+tjj8a0Wxh/29l8rqDO/Vgur
	t0rAzFAGo0Aj0huqT/C3veb9MiN6YaJTjBjLa+3a2aVEaDV+SmRXFt8HzQkQVncP4jc=
X-Gm-Gg: Acq92OFZ1AUK62y+9Lp8pOiCCE4qoYjsW/Y+jArJcwJu6afF0fSEH/ZR/TP6Yf+uZsI
	Fq65pEW5wYJUGlQLQ/yXoDFMSH4/W3P+PABOedRk4f0i25l7/0iRFJ1SeiK0CNkrC4dS2T8BK2U
	6bAehvqyhTJrEUpMVXqUscHtrTgqF70NXRSboSoDJHiQFOgjqc88n7T8CkcZO5c+gu8TArdwDJf
	/dPjWG8t3KXLZHnBxFNT5X8a1RMS5XV+5s93lGaAGEbtzr0mlRv/GC+3JR4YMsMSUHqmC9QT5OC
	pegRwJ8MPMSaXStzNLBNkTibtFqigqwgjqleUPFkcak+O32qpuJoeOIxQyZmWJpDHZMU3c7yW1Y
	pzFozhN6l+6NiPtU92V4uwhdJaikeCeHHkZYXZ0LizUNB8wFAn/XHY8UTDSlfXElwmdyzvmJfZ8
	uSQ2vhZAkYWJK1RD/VV57jJPKOWSP3qubl7W6f2dOk3TRBcd6dNyhEeBYrwhvne1xtMgFs1jduC
	Yct6tKBwIuMpbtXXUNpu4UEUGSY2I8QmBqmLX03wH1TKu7PAoMkwukn34dCsDZd
X-Received: by 2002:a05:6402:35c4:b0:67b:7a8f:3e2c with SMTP id 4fb4d7f45d1cf-6889cc5c2c7mr12052741a12.25.1779876429077;
        Wed, 27 May 2026 03:07:09 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68a6fa2a017sm606312a12.0.2026.05.27.03.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 03:07:08 -0700 (PDT)
Message-ID: <16cfa5c6-a09c-4d45-93e6-074260f530c6@suse.com>
Date: Wed, 27 May 2026 12:07:08 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: Use flexible array for data rings
To: Rosen Penev <rosenp@gmail.com>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260519015739.634423-1-rosenp@gmail.com>
 <147ee577-8a72-407c-b332-45dda9f153b3@suse.com>
 <CAKxU2N-t6mjfGPmeRq3ychV0XKULhwOvq7EVQHtjG2eQ=KDGpQ@mail.gmail.com>
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
In-Reply-To: <CAKxU2N-t6mjfGPmeRq3ychV0XKULhwOvq7EVQHtjG2eQ=KDGpQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CJq5K5O50rB1YA4frI74iY0V"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CJq5K5O50rB1YA4frI74iY0V
Content-Type: multipart/mixed; boundary="------------D31so8GWHoGYUQcaSxP0Oypq";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <16cfa5c6-a09c-4d45-93e6-074260f530c6@suse.com>
Subject: Re: [PATCH] 9p/xen: Use flexible array for data rings
References: <20260519015739.634423-1-rosenp@gmail.com>
 <147ee577-8a72-407c-b332-45dda9f153b3@suse.com>
 <CAKxU2N-t6mjfGPmeRq3ychV0XKULhwOvq7EVQHtjG2eQ=KDGpQ@mail.gmail.com>
In-Reply-To: <CAKxU2N-t6mjfGPmeRq3ychV0XKULhwOvq7EVQHtjG2eQ=KDGpQ@mail.gmail.com>

--------------D31so8GWHoGYUQcaSxP0Oypq
Content-Type: multipart/mixed; boundary="------------lRJ3zdlWOApMta4UNLBYHhyR"

--------------lRJ3zdlWOApMta4UNLBYHhyR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDUuMjYgMDg6MzgsIFJvc2VuIFBlbmV2IHdyb3RlOg0KPiBPbiBUdWUsIE1heSAy
NiwgMjAyNiBhdCAxMDozOeKAr1BNIErDvHJnZW4gR3Jvw58gPGpncm9zc0BzdXNlLmNvbT4g
d3JvdGU6DQo+Pg0KPj4gT24gMTkuMDUuMjYgMDM6NTcsIFJvc2VuIFBlbmV2IHdyb3RlOg0K
Pj4+IFN0b3JlIHRoZSBmaXhlZCBzZXQgb2YgWGVuIDlwIGRhdGEgcmluZ3MgaW4gdGhlIGZy
b250ZW5kIHByaXZhdGUNCj4+PiBhbGxvY2F0aW9uIGluc3RlYWQgb2YgYWxsb2NhdGluZyBh
IHNlcGFyYXRlIHJpbmdzIGFycmF5Lg0KPj4+DQo+Pj4gVGhpcyBrZWVwcyB0aGUgZGF0YSBy
aW5nIHN0b3JhZ2UgdGllZCB0byB0aGUgZnJvbnRlbmQgbGlmZXRpbWUgYW5kDQo+Pj4gc2lt
cGxpZmllcyB0aGUgYWxsb2NhdGlvbiBhbmQgY2xlYW51cCBwYXRocy4NCj4+Pg0KPj4+IEFz
c2lzdGVkLWJ5OiBDb2RleDpHUFQtNS41DQo+Pj4gU2lnbmVkLW9mZi1ieTogUm9zZW4gUGVu
ZXYgPHJvc2VucEBnbWFpbC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgbmV0LzlwL3RyYW5zX3hl
bi5jIHwgNjggKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlv
bnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9uZXQvOXAvdHJhbnNfeGVuLmMgYi9uZXQv
OXAvdHJhbnNfeGVuLmMNCj4+PiBpbmRleCBmOWZiMmRiN2EwNjYuLjVhMTEwZDcxZDE4YyAx
MDA2NDQNCj4+PiAtLS0gYS9uZXQvOXAvdHJhbnNfeGVuLmMNCj4+PiArKysgYi9uZXQvOXAv
dHJhbnNfeGVuLmMNCj4+PiBAQCAtNTUsNyArNTUsNyBAQCBzdHJ1Y3QgeGVuXzlwZnNfZnJv
bnRfcHJpdiB7DQo+Pj4gICAgICAgIGNoYXIgKnRhZzsNCj4+PiAgICAgICAgc3RydWN0IHA5
X2NsaWVudCAqY2xpZW50Ow0KPj4+DQo+Pj4gLSAgICAgc3RydWN0IHhlbl85cGZzX2RhdGFy
aW5nICpyaW5nczsNCj4+PiArICAgICBzdHJ1Y3QgeGVuXzlwZnNfZGF0YXJpbmcgcmluZ3Nb
XTsNCj4+DQo+PiBBbnkgcmVhc29uIG5vdCB0byB1c2UgcmluZ3NbWEVOXzlQRlNfTlVNX1JJ
TkdTXSBpbnN0ZWFkIG9mIGEgZmxleCBhcnJheT8NCj4+DQo+PiBUaGUgbnVtYmVyIG9mIHJp
bmdzIGlzIGEgY29tcGlsZSB0aW1lIGNvbnN0YW50LCBhZnRlciBhbGwhDQo+IGZsZXhpYmls
aXR5IHJlYWxseS4gSSBkb24ndCBrbm93IGlmIHRoaXMgd2lsbCBldmVyIGNoYW5nZS4NCg0K
SWYgaXQgZXZlciBjaGFuZ2VzIHdlIGNhbiBzdGlsbCBzd2l0Y2ggdG8gYSBmbGV4IGFycmF5
Lg0KDQoNCkp1ZXJnZW4NCg==
--------------lRJ3zdlWOApMta4UNLBYHhyR
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------lRJ3zdlWOApMta4UNLBYHhyR--

--------------D31so8GWHoGYUQcaSxP0Oypq--

--------------CJq5K5O50rB1YA4frI74iY0V
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoWwkwFAwAAAAAACgkQsN6d1ii/Ey9s
Zgf+Ia52H9w/0n2fbdVa7tTo7x6ZmoLfBwi6/O4Zbxzneehsxk9f+ChNcnTCdIZpE+7R3HOr7KZr
KgUe2Cg3wS105viJNRBd18pOIxqcHQWcWyvBvhKtcJ1O/VMEbWNhJ++XMOjem6OOvSY8ulUyYRnW
692+vP+m4Xep8MFYcI9qXfsI7qFzZL57YScoqJW4Nb4RDeXlV/B+ipJfY0jyanBGC9FQ7vu/R1L5
FEQXr2VrNhKIy9J3Mf7Sx8VCH3YL6KY20SA92dyt3+wIMpZwvNAPOKcrUQdVOT1+Ye1yX7jd0pr/
YtIfFxSFVZ6tRgReJKeGS0s0SLx96u7oxAOQKFlMjw==
=n812
-----END PGP SIGNATURE-----

--------------CJq5K5O50rB1YA4frI74iY0V--
