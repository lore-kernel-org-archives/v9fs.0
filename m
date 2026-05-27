Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D230F52B
	for <v9fs@lists.linux.dev>; Wed, 27 May 2026 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860351; cv=none; b=kCv8/luTkUztgHf5kk85dDcdu6WKtVDpzcBcBOBacYrPLHsynvcGA0ZoqSDbVWrfvmLHGHVEhZbiE0aCTxPblOdXrMEQB2750A5G2s+9/fqIdNbT4ASgLCyjKx5VLVmmD7VUN5Og2KtDQysrGUzYdYg/KVWuOilpWbP8mvm0uCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860351; c=relaxed/simple;
	bh=7Fsldo4SHYYMF/NP1vaAtA4WX1cTjXR1U4+K/ufYgHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9nd5pLY0lBF9JG7NOZ7Lzohp18NqdtP3n0Grm8PMdnOrUFcP3O2pQKw8ir55PgCzuf7GnKbtaFNFAjVltkeSUQf/xm7FXTKAo/4LZDAecg7AN4BEZfTB8Hv3n9EvhVWu7Wo27Cr2eMOOp0PrbmUC7WXJv4z9JfBDnMo9Ms+Avk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GtyzAO+u; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GtyzAO+u"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6896c54a7easo1056904a12.3
        for <v9fs@lists.linux.dev>; Tue, 26 May 2026 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779860348; x=1780465148; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Fsldo4SHYYMF/NP1vaAtA4WX1cTjXR1U4+K/ufYgHo=;
        b=GtyzAO+uquYFLOugh3dCo8Kbf88FMvxv44oiPzIUgk+QwntAGBmYpRid5GgbJTwrOM
         39KHTZTqU1tGJAxAerQ+pxFi8gs3iwGDmLGABESo3yJnt+Ql4oZbtX9WeStf4lV2aYI3
         sRh9Kn5fcL6ftbXaMUra8+q86BXloMAESJlbW4eci5fqBBe0bGHScZB/rDiZH/YH8BbX
         iA5D3gB0fcUIpznkjY9LTK9y62E/Nno6yTJR5bpF5gdFrMN3JZsQCQxgGQLpfI3jn+JV
         f/TmNC590usPuiloQuoDbEWDkBtNXcd5C4XUSOM6mXkp6Gr3RsUvuQia1VVvCTssdqAt
         Ijlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779860348; x=1780465148;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fsldo4SHYYMF/NP1vaAtA4WX1cTjXR1U4+K/ufYgHo=;
        b=sFuiX8na51V1X08A65EGGPmVFVAMjVQhLIA0o9LSrkbn2mtJ3LJ8pl6XD2YLG9w+FY
         Mqf4/5VR/RZ5+WMXu1jOcJMxiWeQnqA6XZE0BNsf7ZC8qkTaBHpQ/ncgiluvUcPiNq34
         8QuQNGAJMWx1YHFslui4C6R4cZnnw8T5LRZt/GqXKrUxv/zWx2EBDfAQMLuSe2qolYhG
         AINgk9OIw/Xj6U+MMhNoDObPIkIeVF+KtKvQrFvYwgLcoti/rfIc5n1DsN02p70yJXn0
         HT6D/gQO4kbIwNaTy/7OQMSz/YQu5oPXqP6jJOC3w00SVA1b6j8vVmPCpQOR2C2BhKXT
         nx7A==
X-Forwarded-Encrypted: i=1; AFNElJ/b0dWQv0Yhphj+gZHKmZCtUqio6uxhdQc5KA/KdV/JjYGAZVMHnkkwoF1QWmKC0KrETmd5@lists.linux.dev
X-Gm-Message-State: AOJu0YyMFZxUUZugF/a3OyGXvpT1hy1bQJUYBi3VQKIKvdewN09paP2F
	eDB4KRoop42+REk5mVGAzN2Ba9akmwHRIvfs4wf1jF9vfyUGdrsy8i825jmJHYpr9zE=
X-Gm-Gg: Acq92OG33TMPMYiyr4exhanI9zeNsCi7Q21nZsJnVU0wYKDeRsXI/iQpT6AHehgVVqY
	+VppCsjLCuZTpLbV2M4FIHiz+nyzJQHI/P3jrTTpxvLi9VFodH6uAnWvADO/lzR4XMJ/3sETAu3
	Z7umZ+m9zdIKIfCJuCDxcTANFxQcWTU/I3XCsL1YbaBRm7TwDLk+yz0eUW0TVaez7cRxep7THeX
	EobKln9lKzqVmccSMEFphQHpCbJBQqDeYGDz5L+31aQnq37DT+0CHGLFjAXlDKrVoV70YkBpl+q
	18d90dyEfchV43SwR/lInp8JIczylYditOyPLZfcL9mOdpE4eOpSO1FHwFJzSepJh5p++EJBfuB
	lzyYJc/eUUP3a5Vy55tqnz2l3cpKEJcOxRuITB54vVLT4NuwMyqNmlUSyRXd8C/1n0jg4GAq6Mi
	BAfReqb8Ls5aXmB3+dpPHfHWg9mjyEoPInxETvHpCZ5/XUToCvShnhVIpamni/My5NXiMhmQHsL
	KqPElK6vzmtJynbVpJNZIRzlIB4/wsSq8XRiLn4Df65VliCXQqxxg==
X-Received: by 2002:a05:6402:11d3:b0:687:ece2:aac6 with SMTP id 4fb4d7f45d1cf-6889cc37582mr11903597a12.15.1779860348156;
        Tue, 26 May 2026 22:39:08 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68a6fac2de5sm371314a12.12.2026.05.26.22.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 22:39:07 -0700 (PDT)
Message-ID: <147ee577-8a72-407c-b332-45dda9f153b3@suse.com>
Date: Wed, 27 May 2026 07:39:07 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: Use flexible array for data rings
To: Rosen Penev <rosenp@gmail.com>, v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260519015739.634423-1-rosenp@gmail.com>
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
In-Reply-To: <20260519015739.634423-1-rosenp@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Gs4WzmyGXpGofpkP8HKji2Yx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Gs4WzmyGXpGofpkP8HKji2Yx
Content-Type: multipart/mixed; boundary="------------LNb2IAUXc4HWC22Uo0uSdR5e";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Rosen Penev <rosenp@gmail.com>, v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <147ee577-8a72-407c-b332-45dda9f153b3@suse.com>
Subject: Re: [PATCH] 9p/xen: Use flexible array for data rings
References: <20260519015739.634423-1-rosenp@gmail.com>
In-Reply-To: <20260519015739.634423-1-rosenp@gmail.com>

--------------LNb2IAUXc4HWC22Uo0uSdR5e
Content-Type: multipart/mixed; boundary="------------WI6Vs9JEFQl0ajmjJr7ts1hX"

--------------WI6Vs9JEFQl0ajmjJr7ts1hX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDUuMjYgMDM6NTcsIFJvc2VuIFBlbmV2IHdyb3RlOg0KPiBTdG9yZSB0aGUgZml4
ZWQgc2V0IG9mIFhlbiA5cCBkYXRhIHJpbmdzIGluIHRoZSBmcm9udGVuZCBwcml2YXRlDQo+
IGFsbG9jYXRpb24gaW5zdGVhZCBvZiBhbGxvY2F0aW5nIGEgc2VwYXJhdGUgcmluZ3MgYXJy
YXkuDQo+IA0KPiBUaGlzIGtlZXBzIHRoZSBkYXRhIHJpbmcgc3RvcmFnZSB0aWVkIHRvIHRo
ZSBmcm9udGVuZCBsaWZldGltZSBhbmQNCj4gc2ltcGxpZmllcyB0aGUgYWxsb2NhdGlvbiBh
bmQgY2xlYW51cCBwYXRocy4NCj4gDQo+IEFzc2lzdGVkLWJ5OiBDb2RleDpHUFQtNS41DQo+
IFNpZ25lZC1vZmYtYnk6IFJvc2VuIFBlbmV2IDxyb3NlbnBAZ21haWwuY29tPg0KPiAtLS0N
Cj4gICBuZXQvOXAvdHJhbnNfeGVuLmMgfCA2OCArKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlv
bnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC85cC90cmFu
c194ZW4uYyBiL25ldC85cC90cmFuc194ZW4uYw0KPiBpbmRleCBmOWZiMmRiN2EwNjYuLjVh
MTEwZDcxZDE4YyAxMDA2NDQNCj4gLS0tIGEvbmV0LzlwL3RyYW5zX3hlbi5jDQo+ICsrKyBi
L25ldC85cC90cmFuc194ZW4uYw0KPiBAQCAtNTUsNyArNTUsNyBAQCBzdHJ1Y3QgeGVuXzlw
ZnNfZnJvbnRfcHJpdiB7DQo+ICAgCWNoYXIgKnRhZzsNCj4gICAJc3RydWN0IHA5X2NsaWVu
dCAqY2xpZW50Ow0KPiAgIA0KPiAtCXN0cnVjdCB4ZW5fOXBmc19kYXRhcmluZyAqcmluZ3M7
DQo+ICsJc3RydWN0IHhlbl85cGZzX2RhdGFyaW5nIHJpbmdzW107DQoNCkFueSByZWFzb24g
bm90IHRvIHVzZSByaW5nc1tYRU5fOVBGU19OVU1fUklOR1NdIGluc3RlYWQgb2YgYSBmbGV4
IGFycmF5Pw0KDQpUaGUgbnVtYmVyIG9mIHJpbmdzIGlzIGEgY29tcGlsZSB0aW1lIGNvbnN0
YW50LCBhZnRlciBhbGwhDQoNCg0KSnVlcmdlbg0K
--------------WI6Vs9JEFQl0ajmjJr7ts1hX
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------WI6Vs9JEFQl0ajmjJr7ts1hX--

--------------LNb2IAUXc4HWC22Uo0uSdR5e--

--------------Gs4WzmyGXpGofpkP8HKji2Yx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoWg3sFAwAAAAAACgkQsN6d1ii/Ey+5
wgf+IATaJE6REnqhAlrOagTWgHMeSavymkFsmN1VVO/lMFdg2WvIgV0KSoIBe7Fb3uhRUjWj8YJI
4JTXeckqu0c6NMoOdAySpelogQ2fDaXYbij24A1mJEpXkt1Ihpl98PbGGIWvuo0dT7vLOwv0la9U
kL232KGtybB7/4QD7aBANZQmwz1HDUZrqWCRS98pg9PuPVR4jz/gOZBc7230mWC3o+taFm5Rs8vO
6X60CF0dmMaIRoaS2UGQx90E636vgqPpMq56VYewHRrHnq6CKbZHA7GDjPae7HJTAx1IsLaGH1Ni
DXN/j7Ga2elq/OjQIHw//Ub1pkiRMGm9OlXEH12btw==
=Vd3V
-----END PGP SIGNATURE-----

--------------Gs4WzmyGXpGofpkP8HKji2Yx--
