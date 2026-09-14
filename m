Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B848CD6A
	for <v9fs@lists.linux.dev>; Mon, 14 Sep 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408327; cv=none; b=nCXoL/gnsTglDIV/XHP3R0kp0M7U0fIcj9lKslp1Ae7AA+zlM7s+uuCRQPxuRMNNHR+/JYB/nAO8XCy8Xx60lgWoQxQ2G7PAlWZknIK/V1nqK5CNpC8EIlAC/Blf27hYMaanNp6OAnyPorf4OHPIEXKKCFzy2+ETMoU1sZtvJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408327; c=relaxed/simple;
	bh=hTM5uHoZGmLuqNP2Jl687M3jiQRxJw0VPJAxKjDVRvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2HhfLlvoYnVBq3yww/z67YVisXhMh5E4WxdKm6kCDK/BqMzsYMEIG5Aq2JWGEO11h29WZNEIaDDGKfH2ye/IzkaFjOoCmqpROyVcDx8ZNp+IJc5pctgNj4R+C/lUDUfvDvqtjNwTNJhCa6XttwrUvslYf0JQd31fHWcSDuOuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMKzSzr4; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMKzSzr4"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843172bff4so1132960f8f.0
        for <v9fs@lists.linux.dev>; Mon, 14 Sep 2026 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789408321; x=1790013121; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hTM5uHoZGmLuqNP2Jl687M3jiQRxJw0VPJAxKjDVRvQ=;
        b=HMKzSzr4oaVUVpw0xuMEvMtvpnQBTFftV+tINZBKwFF3w4w8AAaCFap2mIybv5j5Vs
         3DYKKJw0Pqn9q8i1IE5feMYD5q1NoJIAAT7er68KxfOqEoSUaAYn3unS5OrBcIy09bt4
         xN7JofUjVhOc53DmpcW+OgDaAsUaxaKkN+UgkuIQWdFDGWEWFWyJR6nxHyJsYDjfphiz
         UCxlevsCapwc0x5Fq002dTa3NPxJUTZ1vmACE6IykL4m7Z4Ir+1r2Qs2vTA/FJl3mph8
         xnvB8XvWUBKulN0w4YNzLUPTS5sL65tgTzp4M+FWbctOgYpiVSPcZIr+zanmj4GRvjR0
         wexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789408321; x=1790013121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hTM5uHoZGmLuqNP2Jl687M3jiQRxJw0VPJAxKjDVRvQ=;
        b=BxGRnRVFjphZOQ9gRs/1uZvES2FTvljq9tP6BToPi+/PFC03z8qLTg4F6/qIzCYMgQ
         ouun+kNHSpuw2t0CYx6yWSpGhCDvQGcsYuFO+uscnZIweMgkR0sQ3f8gGJunqa09w8p/
         oetIO3XW+2bQoyplvSEyiS2KiNxgX3nJCKW/D8C4i20WHd29wb+0EJjfQTveh2+66zK1
         +u1s7Wl2WRfY+MzsRTHSJIGDe+LispJImO+OM+IUmfJMz0rDM0825BccslDacgHqH5j3
         DOO8mMO1OeG9WLoXtPoeQWoeFeZeqsqAm30pPD5DorQM7Dv2imbi1R4JFPW4C4h1zYCU
         TKZw==
X-Forwarded-Encrypted: i=1; AKwUvBzUmfF8S/7cOG4wrvob+6tk/55g/JA8HF7bl7wGBSh122T1wNTgMvNw8z7bcOb+pEuLN4R0@lists.linux.dev
X-Gm-Message-State: AFuF++l2KdAe8nrPQYxxJqt4QxNiUdlpTJ80aeslLpynA4nji9ccrC22
	vjQXi3POmsd3TY1OjhnkNC/zWIFGEyFfL5mqTQD25AEd9rP+9YGd/1oR
X-Gm-Gg: AYBFou3NE142lX7ho9hjzr2LEacpsebZCKY4A+UlIaiV95G4zBP84l61GW0kp5YXpnm
	4qRwqT5Y8WksN3cIphTGAW9ix3r/CKOqQcOFsdiBb4sk5ETDpxqpGgJ1uNihfMpHjdzrY+YnLQg
	pEiSfZxtWWG2fB1kY2WKhKqlPAMp5iFBcyy33HVPHMVo9o5PYMqqKoEVB2yKu94wIg3uC6xPIfO
	UcSvmTFZFBk/QHPKWvYo1fgCsvajstyYcdUiiQhQTGU9WLBK5ceio+3QYyi20lYWfSTO5yr0ods
	9vpyfDirYhdGBRBzUPcaNP+ctLhMjhw5scem36SSjJ+8hbg9swUq4ZArHllI9DPitwHxuAaflJs
	NeMA/WEgXHC5gpGp/ySqRs+1VsoblTFrfkQR6SYEzqVHPPiHFp5arUQjWZRjqylNa7SlzN3wTf6
	ZX3csle9z6mpWKoWYXsH7x2X8T42oWVPIqYJR8ORgVCHQ3Fxzan7IpTAneAjWnPeTY0q9lqEP5n
	eQkDc0LHkvPbWPu8O9nsNSylGrMh/6k5g+5QIQ7V8UiBMxxoiz7yYxhje55jLhKeXJTJofQgRGR
	JkU5Me0=
X-Received: by 2002:a05:6000:4603:b0:486:f199:187b with SMTP id ffacd0b85a97d-48704931bbdmr2343965f8f.34.1789408320841;
        Mon, 14 Sep 2026 10:52:00 -0700 (PDT)
Received: from mskvarla-mac.redhat.corp (adsl-dyn98.78-98-3.t-com.sk. [78.98.3.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f1f7sm28114280f8f.24.2026.09.14.10.51.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 10:52:00 -0700 (PDT)
From: skvarlamatus@gmail.com
To: asmadeus@codewreck.org,
	skvarlamatus@gmail.com
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stefanha@redhat.com,
	sgarzare@redhat.com
Subject: Re: [PATCH v3] net/9p: add vsock transport
Date: Mon, 14 Sep 2026 19:51:56 +0200
Message-ID: <20260914175156.75298-1-skvarlamatus@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aqautUJPkTMvmIGU@codewreck.org>
References: <aqautUJPkTMvmIGU@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 13, 2026 at 14:09 +0000, asmadeus@codewreck.org wrote:
> I've looked at v1/v2 threads and I don't actually see any rationale
> explained: what's the benefit of this over e.g. virito or xen
> transports?

> Do you have/use an hypervisor that cannot do virito 9p (or virtfs) but
> has vsock or something like that?

virtio-9p is only supported by Qemu/KVM. Vsock transport works on any hypervisor
with vsock support and allows using userspace 9P servers.
The motivation behind this patch is primarily driven by podman machine's
use-case, which is file sharing on Windows [1] [2].
The hypervisor there is Hyper-V/WSL, which supports vsock for host-guest
data transfers [3], but not virtio-9p or virtfs. Having vsock transport in the
driver would simplify the codebase and make the use-case more flexible.

> On a similar topic, do you have an actual server that works with vsock?

Podman implements its own 9P server in Go using the p9 library [4] with
vsock support via virtsock [5], but it runs as part of podman machine.
For standalone 9p servers, I only know of diod and example implementations
of various 9p server libraries (i.e. [6]), but none of them support vsock.

As far as I know, there is one 9p FUSE client with native vsock support
(my contribution) [7].

[1] https://github.com/podman-container-tools/podman/blob/main/cmd/podman/machine/server9p.go
[2] https://github.com/podman-container-tools/podman/blob/main/cmd/podman/machine/client9p.go
[3] https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/make-integration-service
[4] https://github.com/hugelgupf/p9
[5] https://github.com/linuxkit/virtsock
[6] https://github.com/hugelgupf/p9/blob/main/cmd/p9ufs/p9ufs.go
[7] https://github.com/ftrvxmtrx/9pfs

--
Matus
