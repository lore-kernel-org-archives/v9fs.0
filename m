Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951543DFC6B
	for <v9fs@lists.linux.dev>; Wed,  5 Aug 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914016; cv=none; b=mlaP8DQiL3l1zk9QdLjvVGT/mDGrfntobXL3Jlj86yEyJRtelIq7fs7Xt/J/KR85/EJrua7Vk9qsZuERi/AvQ9bgJ5TWCSeaqz0vx7poDpoJgObEewR9dqCN4LxRFxYqYIaYXEy68uXe1sCL+VmDa02qbTJXNuuaRs0moTPIqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914016; c=relaxed/simple;
	bh=drHrC+qdqsi+PR/0lRsf/Ub+SUFkFlPx++QVFcFYlko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mj2RtX2W2p/TnrW9jXSeOxmRtTXcC9Bk38eKxsn/xrDhBpcyuFnSyPz0eIi/xHm3FcaxMyLK45+exP4Hlbg6lPV+RBagu2jYVQeH4K8PRPuRBaclLkZUjeiLzTAbUeXxd3AJIICkjyyJbwXVEDio2rA8fC5CHLZgxBOKlnajbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SPhBNbHH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SPhBNbHH"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a8d251so830543a12.1
        for <v9fs@lists.linux.dev>; Wed, 05 Aug 2026 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785914013; x=1786518813; darn=lists.linux.dev;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=drHrC+qdqsi+PR/0lRsf/Ub+SUFkFlPx++QVFcFYlko=;
        b=SPhBNbHHDBXTkXSU7TRXZSd9CGmNQsF9Nwhjqb82Cf3CxNSFgI8qqMaLgg448zFl86
         I7nMMifL7hUwfYHO+zDlLNrldTrhl+wPc0yGisve47dzIADRgQspqitCmz6tM+LHFF5x
         m0wbEyngqNa0I9fAEqDO3Kmi+ap00DfMdkXfka7ftB8BxI2z/bJzujKpwE63aBFud9JS
         mJFl49f+Yly6PKxLTdEUAOn0i25/7Iu6OiDYyMLrXkRfz2/bendXj7Nh4ucBOOPixiva
         r3rtaqmmdAvThuAeuLFoTV5WJVEjsWQmp+1o5Be0x+SBxl1JbrH4+km/iLPA9eHg2ICi
         rXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914013; x=1786518813;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drHrC+qdqsi+PR/0lRsf/Ub+SUFkFlPx++QVFcFYlko=;
        b=U1XAFycgtWhga27fAqzkitV0sWBJcJ6XEWpmGFQ6LdXfsEmQKOzxPGk4wki+iw0swF
         focL3s3mkiBgWOzak4+ELCtXFWtCbWdY4LFxKctIZjkIrOiYHZat+7LS4CgzcL7EzZgw
         j2V87jw0a0imnoD2O6n6+puv6y4smnS6PbHEh4Wv+c23eUKJvjnZ4rPnFpNmugscEx+j
         B/gRVMr4GF1wh75pYNgg7jihTNfvPNoxwHqw1HTIs8VgyuWW/uFcRMunYruYhbX8Ycby
         cFwCUmQX92K56u0gXgFI9DwpxTPrz/xef1HduhQUZHmCpcockvXqY7zRgT+NKetw3ECt
         N/FA==
X-Forwarded-Encrypted: i=1; AHgh+RoWlG5ciPfA9sgrySHwarG97RNIxDu0joKZn0gx0ZmKWPOuGQYp1VG+9LYuTxavsxa8jIq9@lists.linux.dev
X-Gm-Message-State: AOJu0Yw76Ii0qqFs5hXLSaGDPB63/0D+R1e29zbByEty5167XLt352Sm
	wy9jkYnta2Cbh6yP/kobB+drrxDfmLyAtcvJiJ1+0dmGt8aTjIWNH2fVE/QH5Ayk3os=
X-Gm-Gg: AR+sD11F3D7VZbYOMo3VFQtraNtEmBY884HNEHHN4z6jr3pZs385m9gj8tZTQhpiyN5
	wTE0DAm0B0HnExvqG9nOxZL7aNjRO4NShKc7HTx+Csf7YyntQ7mJx6STc1N339o35JsngK9xS+f
	oOEDOjgM6P6pgjKppU3rnLSVodfXaSOu5jsbgW66y5qFdqZfe93tKLfij21KPSneprXuDcOM0dt
	nONn5WfMUw6jYA4YFUJTgIl+E/KRofiUEfQNgMEzmYwd2ayjMu1/rLboj15YGCpWrrN1PDAuZa6
	cO/kdL8XIqU50+dZtchWDySN0jbXbvIbslTK6NwmBg8uqfX33r2ViM80u7Cn5txv3yN7JKCeAFB
	Qy5an9Ka7iIWJpeqr8kabuU4r44x/3LGdp0IjpgFBMpJ8Tz078lEJ3ZW3/iFc9cdyqU0LngUpff
	8gxYIxcpZFFronKY5Q2VFFngvR2Ca04s2qmASRt5Xb9HXMG41MM0IU5k/hMZKSTu2bDlUus41ga
	udUJ7muMwX8ieDUstIg+xUQKQ2oCWC6dXbzioale6SM3UetDPWT62rfA04/HmEyGutATU70g5Xc
	ue7hN5eiDcPbImQXTVhhnczGBg==
X-Received: by 2002:a05:6402:1586:b0:6a0:a4be:6ed0 with SMTP id 4fb4d7f45d1cf-6a14f14c601mr2107256a12.17.1785914012808;
        Wed, 05 Aug 2026 00:13:32 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a145c49044sm1419460a12.9.2026.08.05.00.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 00:13:32 -0700 (PDT)
Message-ID: <931b763d-2ee6-4fbf-9222-c5b75f35ec47@suse.com>
Date: Wed, 5 Aug 2026 09:13:31 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: fix refcount leak in p9_xen_response() on wrong
 tag
To: Stefano Stabellini <sstabellini@kernel.org>,
 Yifei Gao <gyf161023@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260804213550.3409638-1-gyf161023@gmail.com>
 <ebcebd30-68e2-1650-f0e6-b69e4239619c@kernel.org>
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
In-Reply-To: <ebcebd30-68e2-1650-f0e6-b69e4239619c@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8si6pc96wSFhwkSY5O2H0kme"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8si6pc96wSFhwkSY5O2H0kme
Content-Type: multipart/mixed; boundary="------------VvTq5HqiTdsegQZQBXC4lBJZ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Yifei Gao <gyf161023@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <931b763d-2ee6-4fbf-9222-c5b75f35ec47@suse.com>
Subject: Re: [PATCH] 9p/xen: fix refcount leak in p9_xen_response() on wrong
 tag
References: <20260804213550.3409638-1-gyf161023@gmail.com>
 <ebcebd30-68e2-1650-f0e6-b69e4239619c@kernel.org>
In-Reply-To: <ebcebd30-68e2-1650-f0e6-b69e4239619c@kernel.org>

--------------VvTq5HqiTdsegQZQBXC4lBJZ
Content-Type: multipart/mixed; boundary="------------292XJsm8x0UioVDewQdpX8cO"

--------------292XJsm8x0UioVDewQdpX8cO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDguMjYgMDI6MDYsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gVHVl
LCA0IEF1ZyAyMDI2LCBZaWZlaSBHYW8gd3JvdGU6DQo+PiBwOV94ZW5fcmVzcG9uc2UoKSBs
b29rcyB1cCB0aGUgcmVxdWVzdCBmb3IgYW4gaW5jb21pbmcgcmVwbHkgd2l0aA0KPj4gcDlf
dGFnX2xvb2t1cCgpLCB3aGljaCB0YWtlcyBhIHJlZmVyZW5jZSBvbiB0aGUgcmV0dXJuZWQg
cDlfcmVxX3QuIFdoZW4NCj4+IHRoZSB0YWcgZG9lcyBub3QgcmVzb2x2ZSB0byBhIHJlcXVl
c3QgaW4gUkVRX1NUQVRVU19TRU5ULCB0aGUgZnVuY3Rpb24NCj4+IHdhcm5zIGFuZCBjb250
aW51ZXMgdGhlIGxvb3Agd2l0aG91dCBkcm9wcGluZyB0aGF0IHJlZmVyZW5jZSwgcGVybWFu
ZW50bHkNCj4+IGxlYWtpbmcgdGhlIHA5X3JlcV90IGFuZCBpdHMgbXNpemUgYnVmZmVycy4g
VGhlIHJlcGx5IGhlYWRlciwgaW5jbHVkaW5nDQo+PiB0aGUgdGFnLCBpcyBzdXBwbGllZCBi
eSB0aGUgYmFja2VuZCwgc28gYSBtYWxpY2lvdXMgb3IgYnVnZ3kgOVAgYmFja2VuZA0KPj4g
Y2FuIGxlYWsga2VybmVsIG1lbW9yeSBvbiBldmVyeSBjcmFmdGVkIHJlc3BvbnNlLg0KPiAN
Cj4gTW9zdCBiYWNrZW5kIGFyZSB0cnVzdGVkLCBpbmNsdWRpbmcgdGhpcy4gU28gSSB3b3Vs
ZCBhdm9pZCAibWFsaWNpb3VzIi4NCg0KTm8sIEkgdGhpbmsgdGhpcyBpcyBmaW5lLg0KDQpF
c3BlY2lhbGx5IHdpdGggZHJpdmVyIGRvbWFpbnMgbWFsaWNpb3VzIGJhY2tlbmRzIGFyZSBh
IHRoaW5nLiBUaGV5IHNob3VsZA0Kb25seSBiZSBjYXBhYmxlIHRvIGRlbGl2ZXIgd3Jvbmcg
b3Igbm8gZGF0YSB0byB0aGUgZnJvbnRlbmQsIGJ1dCBpZGVhbGx5DQp0aGUgZnJvbnRlbmQg
c2hvdWxkIG5vdCB0cnVzdCB0aGUgYmFja2VuZC4NCg0KQW55IHdvcmsgdG93YXJkcyB0aGF0
IGdvYWwgaXMgdG8gYmUgc3VwcG9ydGVkIElNSE8sIGFuZCB0aGVyZSBhcmUgYWxyZWFkeQ0K
ZnJvbnRlbmRzIGxpc3RlZCBpbiBYZW4ncyBzdXBwb3J0IHN0YXRlbWVudCBmb2xsb3dpbmcg
dGhpcyBydWxlLCBzbyBhbnkNCnZpb2xhdGlvbiBvZiB0aGF0IHByaW5jaXBsZSBpbiB0aG9z
ZSBmcm9udGVuZHMgd2lsbCBiZSByZWdhcmRlZCB0byBiZSBhDQpzZWN1cml0eSBpc3N1ZSB3
b3J0aCBhbiBYU0EuDQoNCg0KSnVlcmdlbg0K
--------------292XJsm8x0UioVDewQdpX8cO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------292XJsm8x0UioVDewQdpX8cO--

--------------VvTq5HqiTdsegQZQBXC4lBJZ--

--------------8si6pc96wSFhwkSY5O2H0kme
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpy4pwFAwAAAAAACgkQsN6d1ii/Ey+H
KggAg6nytSOOYq8z0ItP8CPzGV2WeFi552GEXsho0t5VEJrJrI24Ujyyy954xFTbzaXtOHsU8fTJ
+URN3WaLFrA8LEz0IzTnDjNdR4sXwJT0QVuBlCzSo/XOKzQXR1xnZVk6rfS2rTy6v0caigYk2MlX
yYU3nUCUsR3IQJYAIY7E6PEM9MGAr9Xk6Vhv8iJHk2twCq5cXqfwSTQowOtgCI9T0HQufnz1wy7Q
cbxZfpclY4ahGtES2b/+saK8J54DPMFr2cwKJ5svBREmlL6o9YO7LWASnFdo9d7MEcP+mWXRq0hl
ZXBWLiXuEZW643jzUprYwwrrojFXqrubr9OIRM+3wA==
=DfBT
-----END PGP SIGNATURE-----

--------------8si6pc96wSFhwkSY5O2H0kme--
