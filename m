Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155702;
	b=hKvlRcbgcRTZtrUUvB9l+55pyFbFVCpf1NFV+Bodp5j9WURYTRqnA7NsNT8WbV11EMSb
	 uj9UsjwOqw1H0kk1Dz0lCbVs+G8/9oXZ0Ip6Wk/zBRuILwcp7sRWAesvGWnrXodlH/FG4
	 CgTQeiQjzkUGzNX78okGsAseK5SkAZcrBiQsoWnJ63AkzCTANhRfyIirObRm7r9sNIgNY
	 A4ka775CmULcimwxsQBwB5btfeX3714HPJRKABrlX4Rr6zzIlsaVouMRS+nU7yfidVbSy
	 IOEYqQFJUsVuERHBaXOFv3kB7dDKnTu5LLMQWYClpZvZqC2UNzCGMciiDp61yK6Itgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o0YluxS4Okhmx9UrB8rgmv3I9P5u8AeGkwpP1wynEOs=;
	b=KC7pq5E5V2juN1oqRKTmM5c9XygQr1J6tjex3LMwqHRkYaGkplRryguDEqadPEiPwV8Q
	 zkgptfbVKxtka+EGkXEdbslk0iXCvVRh+guetKSw6GH9vS8jTvO7O1/ljamZfeCk1exOn
	 npuCfkJkx/bX0ftwUOAh0gx9aHj1TUfXNA4vUY/w5fo3MD/edCUu2N5UrulNIrS8qZH3q
	 QGX08TN6ZIxLkamU0g3NH2aMmL9klNel8IN+Bohuv1+5plrn2K5eawemkor9iXH1WrcUn
	 W11OoGIPRkoqCQe79mhEvwlFR84EkO640mIANkK9hJ0RH7TP9090I7KjojV2nldNQ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCmTwPJZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF1606A33E;
	Fri, 20 Nov 2026 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCmTwPJZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701551F000C6;
	Fri, 20 Nov 2026 06:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795155702;
	bh=o0YluxS4Okhmx9UrB8rgmv3I9P5u8AeGkwpP1wynEOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fCmTwPJZWJZyml1zSal8iY+pLCTP2AUvCztZXzLLgHy35oj0IgVEtbT6g9hmV++J7
	 6kU+Y/3s5ci/wGBsUesL5agxmcoQsdPT4GpV4ItQOoXBdSXtQ+hvWI3F3cKry3COq1
	 XIs3jdbIaO9IDSHyecaKzJgndqgGUvb9WXV9jfWdOc28Pq4HnP/pfkIHtAL0Mh7nPA
	 auhOUE9eagyYJJMVbesYsZ2VX7j1C48qik1ED6m4lIf6iWq7M0cW43RL93W6rjioSi
	 ktZAxJwXN44LbRtY0BjUDcS19qF9E/SBfPGQ8FkMwyN+7iKGprfsXlyRuQY9fa0w7u
	 T+vQ0tZdj2hzQ==
Message-ID: <sashiko-outbox-224554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools: usb: p9_fwd: Send complete requests to the TCP
 server
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-usb@vger.kernel.org, v9fs@lists.linux.dev
In-Reply-To: <20261120061937.98224-1-zhujun2@cmss.chinamobile.com>
References: <20261120061937.98224-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:21:42 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> socket.send() can return after sending only a prefix of a request.
> The forwarder ignores that result and waits for a response to an
> incomplete message. Use sendall() so request forwarding completes
> only once all bytes have been sent or a write error is reported.
>=20
> Fixes: 673f0c3ffc75 ("tools: usb: p9_fwd: add usb gadget packet forwarder=
 script")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120061937.9822=
4-1-zhujun2@cmss.chinamobile.com?part=3D1

