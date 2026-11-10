Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307993;
	b=VYScX8qvL4J56Xnpm5H3MrMp6b5y6ztfdWGdLtQb2sD5aQZqo33UenfwY60FQ4h/W8kz
	 pAzkO+ff9A9sjNbhAnxKluE8U5j+F6ah8UCVFbglBRofPtzjW2RflnNQVYA/zdK/l5TYZ
	 3WT5ABzEBVaGD7MfUvZAgc7q3RKOqF9VpLtFAnGaJY9NWQ8RvE8mwtsIw20ktoWCp7DhD
	 p+vRYrlRKe459POsKlJiQbZ5C+D13rzaubx1sJ+a2QrJUDTzzw5DR4MGAhqYLiW5bOmad
	 ssKsQBQMu3m1eXTLrfoGK/SgHiNgZfNW9bEzD32CS5EsrDiKgv42jg5CfiD+YBdqmxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xYpnN2TICP47eC0iwvtC4YHKL0p/FAdebaukolc7BpE=;
	b=UJhpnD5vzhaRUORaLsWFLBel+g75WlQVoBKHMT4L20Ey+3ReanV1LerFNTwwR3gPzt6B
	 VjWoXPj6fw04JU+9bTZyfef8PQpx9ufcnojsgo5dAIFQmC1gUGuoWFCoYZ4kFioivNwf5
	 mCXph6vcyDgXrF5RvcT9Qlcnw8nUHvvgJU2ERYX62tAoZtIPBBtMyd+IaufRCGnw+bd6k
	 57SyH5elggPi3nD+eoyB/tWGQ6SYvhmBLDHhPT0W+3JK1Jar3aWnOuxMcCW7h40s+fAMG
	 t+Nxj/m8aBayi3Euddd8KDo2nRs1WMQm7se3t/ADOd6vTCpsK7v1Qbi5qmnZlhrN4YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kuufskye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540D606A32A
	for <v9fs@lists.linux.dev>; Tue, 10 Nov 2026 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kuufskye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF331F008A1;
	Tue, 10 Nov 2026 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307993;
	bh=xYpnN2TICP47eC0iwvtC4YHKL0p/FAdebaukolc7BpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kuufskye9wNQOV2mHFDqHH2i4RhNc1T8Ko7ZnuUjOAz22WAv5w0dGC00Z/M/UM2he
	 nFtYzCKh2jHok35ba4QmzFkpdXsLQaU5ZzuIVNdOoh62jBQ+FECwFl/C+uT+1TKJRQ
	 C8z9cctE3tqezTPqpWkDfzcjF+MtqnJnoxPU3tsgI7rZ3GE1THRJKtl41BjAiH5NBr
	 t9/3dBbQL2PtI2lEHoq6QZBoVulxPwrL7kdzF1eJPGikeVSMSrnImAL0M2WjzAcQSA
	 rK/0bFtVZLXK56bbOJgNA6hUZZMlByQi2eiy10nHi9ktyHYP61id8wFBN8XfO0Dr2k
	 CrTsSfu7UQTuQ==
Message-ID: <sashiko-outbox-206901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] 9p: ignore a zero-copy reply that arrives after a
 fatal signal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261109105251.2545764-3-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
 <20261109105251.2545764-3-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:53:12 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] net/9p: uninitialized stack memory read in p9_check_errors()
  [1]
--

commit ef137edd1ee785bfc27fe33c6494662e5a3cdca5
Author: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

9p: ignore a zero-copy reply that arrives after a fatal signal

This commit keeps err as -ERESTARTSYS in p9_client_zc_rpc() when a zero-copy
request is interrupted by a fatal signal, avoiding parsing an incomplete or
unbounded reply in p9_check_errors().

> diff --git a/net/9p/client.c b/net/9p/client.c
> index e63e8c2a853df..66980ad52bca8 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -706,10 +706,11 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_=
client *c, int8_t type,
> =20
>  		if (c->trans_mod->cancel(c, req))
>  			p9_client_flush(c, req);
> -
> -		/* if we received the response anyway, don't signal error */
> -		if (READ_ONCE(req->status) =3D=3D REQ_STATUS_RCVD)
> -			err =3D 0;
> +		/*
> +		 * err stays -ERESTARTSYS even if the reply has arrived, since
> +		 * the transport moves the error string of a zero-copy reply
> +		 * into rc only while it waits.
> +		 */
>  	}
>  recalc_sigpending:
>  	if (sigpending) {

[Severity: Medium]
This problem wasn't introduced by this patch, but can p9_check_errors() read
uninitialized stack memory from ecode [1] when logging a legacy 9P2000
RERROR response?

net/9p/client.c:p9_check_errors() {
	...
	int ecode;
	...
	if (!p9_is_proto_dotl(c)) {
		char *ename =3D NULL;

		err =3D p9pdu_readf(&req->rc, c->proto_version, "s?d",
				  &ename, &ecode);
		...
		if (!err) {
			err =3D p9_errstr2errno(ename, strlen(ename));

			p9_debug(P9_DEBUG_9P, "<<< RERROR (%d) %s\n",
				 -ecode, ename);
		}
	...
}

Under legacy 9P2000, p9pdu_readf() stops at the '?' modifier in "s?d" and
returns 0 without writing to ecode, so p9_debug() formats uninitialized sta=
ck
memory into the debug log when CONFIG_NET_9P_DEBUG is enabled.

[1] https://sashiko.dev/#/bug/linux-cfaf1e1d-d65e-44c0-a62c-a97caf427656

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109105251.2545=
764-1-lian@is.s.u-tokyo.ac.jp?part=3D2
