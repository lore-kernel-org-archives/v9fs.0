Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015DC23AB
	for <v9fs@lists.linux.dev>; Fri, 22 Nov 2024 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283653; cv=none; b=BpgUaNs7UblFTWo0pKS1w2ka7rHkQlU5hRbT0I93sCfd4iVv42K8epHKJMJWP1h7Mjbjexc/2Dmt8UgNQ6cdtmrPY1/pK6UUsS4lhYAHLOA4tI+/YutpRRuEAacq8Fzd/KR+DtBwcp7weTUyQVt0+zpTVQz0Lku8fOOV2IkzeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283653; c=relaxed/simple;
	bh=XhDueBRm6/e/F4NHneCkoQbJKjaJRbqVYbhdC3iIX08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXiSkBEjlErHpq/WDx10av+xUtQ5Wvs27+vjLSkQUNt4wJ+muZPtx7BHRiJoczO2KSgUfLTp4iW9L0pWEWe4BYXXG9ZAeJAZQcQ4JUpdZvIKhKskGYOTgzfkp/p8HSHp622JNW0xgUh0xBn0KqG+gS0GxmFy2R78qUsmtVzKwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cuf7YFTt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cuf7YFTt"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3824a089b2cso1298963f8f.1
        for <v9fs@lists.linux.dev>; Fri, 22 Nov 2024 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732283648; x=1732888448; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XhDueBRm6/e/F4NHneCkoQbJKjaJRbqVYbhdC3iIX08=;
        b=Cuf7YFTtNRH7XS/O5AfzEAGPBjcIIuNnM36wkEX6hk22rlKlIFsjNsB1/DhqcoTkoH
         tWjdQat/FEYPS82CaWpSwlji+aV+VVYOvUUMpyx3ps9qStaFB7ff+2bPVYjJOJgc834q
         h+j48lDI0ujA0ngB9Z6FvsxDkpfPPFNxZt00+ZiBrQPZK+o2VvoKno2PlZo1QuzLa1D7
         IT916EujMnxnw2la4W2vsiE33WC2Ubf15g/9nQVVkN4oCmzSFO3tZuPfysFyzhB1Fw1j
         huVIXKU0qEkBt522DXSdWpDfc5VY4VWtZAjuWR5gY4i/fpmmTzyWDa4AhNqHf5da2eGl
         rdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732283648; x=1732888448;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhDueBRm6/e/F4NHneCkoQbJKjaJRbqVYbhdC3iIX08=;
        b=UMFMncZNJonADhfGuAXBmBAfYds1Y6ho6/FThl+vL40Lx0A2J8BlseO0UqsSX7vreq
         k833zzIsBi6QrayOFz3aHzdFkCOnTsrOSa/T0gQhkz6xeoVRtuQEdupAx4aMZmV11NTi
         GsgiVSGbATvapZEGgbe7wHzu4Pax0oDri6iBQn6wolBZbK44v3aKgVn7FIib8GW1IaMY
         MZfEODO5/jZmR2Dj7hhJk3g/b7VWRCF3jkfBx8YK5rYTyl8RpHNHBNtZj4CBmVBONI77
         6bq8oVxsitGxv2SLDwACqkTpgolMvZuHIA0fHJAYSWxW89M8PhOnRjTZXbRqosXC/SbR
         /45g==
X-Gm-Message-State: AOJu0Yzsfx2uvfoHPFUc+aFLmbf/vH9a2os7Zf9Oe8YsmC1VKH7bdvBU
	yj5KvewxU0EQxkRYQD3x/Dv7pfECfG81mkbW1BEOFtbFYvytmmcWdAuCq+3Gpfs1GiIBKKtFBfO
	3o+E=
X-Gm-Gg: ASbGncvsfdI9fK+KrkPMs2tSpN0u+8BgIDWwlXNNbP3fdkIb+De9LKzdIGOtE16Ixrp
	bbgeU/9fSd2VywLnscNxR6X1R9TaFdQuwsATeqY5Y4GmRnLOtSeUz88kmfqZc67+UtNySFb4sRF
	Iqre9bCmoXA7MbIlyT4qNKg2pOSMRUpq4/FXIlfvWWj8zrujkF85OWFyE6/0eppnrBOgmmFqSnE
	Lh3VxdL604tEGN6I18ygmOmnRW06Sie7JxU1h3cH0+86Q1pza8ue0cMPicFlEE0XSzwpKTluJaE
	xhguFOJ/iUJbBOXJVvwxzAeThaIXfOQUt5EvZck9xLmAQSWVrziWdbfVuIJkgmjJdRL0Xj8qNXs
	=
X-Google-Smtp-Source: AGHT+IEgnAdMMxgnTxCDj06rnj+QxKz4Nm1h/mTObW0SrAHslDOcyRZvOd0timHcitZ4fp4F4v1GJg==
X-Received: by 2002:a5d:584f:0:b0:382:4b69:9c75 with SMTP id ffacd0b85a97d-38260bcbb36mr2364283f8f.43.1732283648227;
        Fri, 22 Nov 2024 05:54:08 -0800 (PST)
Received: from ?IPV6:2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c? (p200300e5872eb100d3c7e0c05e3baa1c.dip0.t-ipconnect.de. [2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe147sm2443852f8f.30.2024.11.22.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 05:54:07 -0800 (PST)
Message-ID: <a6570b47-217c-4e92-a64c-16fc34494e3e@suse.com>
Date: Fri, 22 Nov 2024 14:54:06 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: fix release of IRQ
To: Dominique Martinet <asmadeus@codewreck.org>,
 Alexander Merritt <alexander@edera.dev>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Alex Zenla <alex@edera.dev>,
 Ariadne Conill <ariadne@ariadne.space>
References: <20241121225100.5736-1-alexander@edera.dev>
 <Zz_F9wMda68xhvKa@codewreck.org>
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
In-Reply-To: <Zz_F9wMda68xhvKa@codewreck.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Nk0vB0TxZPrkl6QvVkr8wsTT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Nk0vB0TxZPrkl6QvVkr8wsTT
Content-Type: multipart/mixed; boundary="------------OWLn70UB2fIu0Y9aFiUC05De";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
 Alexander Merritt <alexander@edera.dev>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Alex Zenla <alex@edera.dev>,
 Ariadne Conill <ariadne@ariadne.space>
Message-ID: <a6570b47-217c-4e92-a64c-16fc34494e3e@suse.com>
Subject: Re: [PATCH] 9p/xen: fix release of IRQ
References: <20241121225100.5736-1-alexander@edera.dev>
 <Zz_F9wMda68xhvKa@codewreck.org>
In-Reply-To: <Zz_F9wMda68xhvKa@codewreck.org>

--------------OWLn70UB2fIu0Y9aFiUC05De
Content-Type: multipart/mixed; boundary="------------C01w8BPyR5Yj4NMZLXVKi1ad"

--------------C01w8BPyR5Yj4NMZLXVKi1ad
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMTEuMjQgMDA6NDQsIERvbWluaXF1ZSBNYXJ0aW5ldCB3cm90ZToNCj4gQWxleGFu
ZGVyIE1lcnJpdHQgd3JvdGUgb24gVGh1LCBOb3YgMjEsIDIwMjQgYXQgMTA6NTE6MDBQTSAr
MDAwMDoNCj4+IEZyb206IEFsZXggWmVubGEgPGFsZXhAZWRlcmEuZGV2Pg0KPj4NCj4+IEtl
cm5lbCBsb2dzIGluZGljYXRlIGFuIElSUSB3YXMgZG91YmxlLWZyZWVkLg0KPiANCj4gTml0
OiBpZiB5b3Ugc3RpbGwgaGF2ZSB0aGUgbG9nIGl0J2QgYmUgZ3JlYXQgdG8gaW5jbHVkZSBp
dCBpbiB0aGUgY29tbWl0DQo+IG1lc3NhZ2UsIHJhdGhlciB0aGFuIHBhcmFncmFwaGluZyBp
dC4NCj4gDQo+IFRoZSByYXRpb25hbGUgaXMgdGhhdCBzb21lb25lIHdpdGggdGhlIHNhbWUg
cHJvYmxlbSB3aWxsIGxpa2VseSBqdXN0DQo+IHNlYXJjaCBmb3IgdGhlIGVycm9yIGFzIGlz
IGZpcnN0LCBhbmQgaGF2aW5nIGl0IGluIHRoZSBjb21taXQgbG9nIHdpbGwNCj4gYmUgYW4g
ZWFzeSBoaXQuDQo+IA0KPiAoVGhpcyBhbG9uZSB3b3VsZG4ndCBuZWVkIGEgcmVzZW5kLCBJ
IGNhbiBhZGQgaXQgaWYgeW91IGp1c3QgcmVwbHkgdG8NCj4gdGhlIG1haWwgd2l0aCBpdDsg
aXQncyBhbHNvIGZpbmUgaWYgeW91IG5vIGxvbmdlciBoYXZlIHRoZSBsb2csIHRoYXQnbGwN
Cj4gYmUgYSByZW1hcmsgZm9yIHRoZSBuZXh0IHBhdGNoKQ0KPiANCj4gDQo+Pg0KPj4gUGFz
cyBjb3JyZWN0IGRldmljZSBJRCBkdXJpbmcgSVJRIHJlbGVhc2UuDQo+Pg0KPj4gRml4ZXM6
IDcxZWJkNzE5MjFlNDUgKCJ4ZW4vOXBmczogY29ubmVjdCB0byB0aGUgYmFja2VuZCIpDQo+
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFplbmxhIDxhbGV4QGVkZXJhLmRldj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEFsZXhhbmRlciBNZXJyaXR0IDxhbGV4YW5kZXJAZWRlcmEuZGV2Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQXJpYWRuZSBDb25pbGwgPGFyaWFkbmVAYXJpYWRuZS5zcGFjZT4N
Cj4gDQo+IA0KPiANCj4+IC0tLQ0KPj4gICBuZXQvOXAvdHJhbnNfeGVuLmMgfCAzICsrLQ0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL25ldC85cC90cmFuc194ZW4uYyBiL25ldC85cC90cmFuc194
ZW4uYw0KPj4gaW5kZXggZGZkYmUxY2E1MzM4Li4xOThkNDZkNzlkODQgMTAwNjQ0DQo+PiAt
LS0gYS9uZXQvOXAvdHJhbnNfeGVuLmMNCj4+ICsrKyBiL25ldC85cC90cmFuc194ZW4uYw0K
Pj4gQEAgLTI4Niw3ICsyODYsOCBAQCBzdGF0aWMgdm9pZCB4ZW5fOXBmc19mcm9udF9mcmVl
KHN0cnVjdCB4ZW5fOXBmc19mcm9udF9wcml2ICpwcml2KQ0KPj4gICAJCWlmICghcHJpdi0+
cmluZ3NbaV0uaW50ZikNCj4+ICAgCQkJYnJlYWs7DQo+PiAgIAkJaWYgKHByaXYtPnJpbmdz
W2ldLmlycSA+IDApDQo+PiAtCQkJdW5iaW5kX2Zyb21faXJxaGFuZGxlcihwcml2LT5yaW5n
c1tpXS5pcnEsIHByaXYtPmRldik7DQo+PiArCQkJdW5iaW5kX2Zyb21faXJxaGFuZGxlcihw
cml2LT5yaW5nc1tpXS5pcnEsIHJpbmcpOw0KPj4gKwkJcHJpdi0+cmluZ3NbaV0uZXZ0Y2hu
ID0gcHJpdi0+cmluZ3NbaV0uaXJxID0gMDsNCj4gDQo+IChzdHlsZSkgSSBkb24ndCByZWNh
bGwgc2VlaW5nIG11Y2ggYGEgPSBiID0gMGAgaW4gdGhlIGtlcm5lbCwgYW5kDQo+IGxvb2tp
bmcgYXQgaXQgY2hlY2twYXRjaCBzZWVtcyB0byBjb21wbGFpbjoNCj4gQ0hFQ0s6IG11bHRp
cGxlIGFzc2lnbm1lbnRzIHNob3VsZCBiZSBhdm9pZGVkDQo+ICMxMTQ6IEZJTEU6IG5ldC85
cC90cmFuc194ZW4uYzoyOTA6DQo+ICsJCXByaXYtPnJpbmdzW2ldLmV2dGNobiA9IHByaXYt
PnJpbmdzW2ldLmlycSA9IDA7DQo+IA0KPiBQbGVhc2UgcnVuIGNoZWNrcGF0Y2ggb24gdGhl
IHBhdGNoZXMgeW91IHNlbmQgKGI0IGNhbiBkbyBpdCBmb3IgeW91IGlmDQo+IHlvdSB3YW50
IHRvIHN0YXJ0IHVzaW5nIGl0KQ0KPiANCj4gDQo+IGNvZGUtd2lzZSwNCj4gSSBhbHNvIGRv
bid0IHNlZSB3aGVyZSB1bmJpbmZfZnJvbV9pcnFoYW5kbGVyIHdvdWxkIGZyZWUgdGhlIGV2
dGNobiwgc28NCj4gaXMgaXQgbGVha2luZyBoZXJlLCBvciBpcyBpdCBpbXBsaWNpdCBmcm9t
IHNvbWV0aGluZyBlbHNlPw0KPiBXZSBvbmx5IGZyZWUgaXQgZXhwbGljaXRseSBvbiBlcnJv
ciBiaW5kaW5nIHRoZSBpcnEuDQoNCnVuYmluZF9mcm9tX2lycWhhbmRsZXIoKQ0KICAgdW5i
aW5kX2Zyb21faXJxKCkNCiAgICAgX191bmJpbmRfZnJvbV9pcnEoKQ0KICAgICAgIGNsb3Nl
X2V2dGNobigpDQoNCg0KSnVlcmdlbg0K
--------------C01w8BPyR5Yj4NMZLXVKi1ad
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------C01w8BPyR5Yj4NMZLXVKi1ad--

--------------OWLn70UB2fIu0Y9aFiUC05De--

--------------Nk0vB0TxZPrkl6QvVkr8wsTT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmdAjP4FAwAAAAAACgkQsN6d1ii/Ey/X
AQgAnEPHcjShbIOAFbogh8d7tg+wk/TFewFy1WodIc8EpJ9msRua8BRLXcZTK6G3OX8g9B71AsLB
zKBpHnhfI/HXUFZQvWccbzEZCESx/XMYaP1aAY0s26LBqjWcmU80LgNUWcm7uCtGzJ75BmoHaRCC
1FQXLwZZYRhqSAdapdFgDO3aifgkTcWmQBYjxrgPNbGLSffIQ3LWrF7txcmmKTPAdSPopmLhgHtH
Vm2cNXX2G96+B42wolHCqJbEZde7y1NSggCJQUSq6PLJYCOPRsTp3Z8G++M8+U9vPL14pWANliXn
8gWyDVv21vC224l/XuL6RS2LTwmF6KMqSRff9bdt5A==
=CpVu
-----END PGP SIGNATURE-----

--------------Nk0vB0TxZPrkl6QvVkr8wsTT--
