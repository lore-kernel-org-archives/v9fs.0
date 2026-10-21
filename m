Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560657;
	b=ckj6zUwW0sNQlfzxHFwuzvi937v+FdB21mL3wH7Q2Pab6oW2W1nnGTCcf3LQDFyLxi2v
	 eMBLBqLT7MhH9aiv34m/5j2PVdr+pA7CdpDNp56MW5a/cc3K8evO/KG208Wgf9YFLwVo6
	 EAeOPLPoYSld/up5mnuyVPI5kWEyt3bf2CAgL+eenMYbLrcjpNxZW5CPPIY4aZdvYkExL
	 xX1QYshPx0VSXmTokpLUH753M1cc1wiQGNGXTZ9QHDKTHh1iN91tfpTEGY1oXEzsQYWcE
	 KAk15sC84g1uaX3nepYFlOiUfZpfJLPLHzoPbfoSDw4RscI9h8GOT3NtbohbqsBV/ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type;
	bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
	b=MHnpYxBSbQM8RMNLD7WhtuXcbR1vxBCru5U6nY1Uy+YMSQ9kNaPEi15wOJabdq8vvVAI
	 EomixK68LgK31KC7B+4+kuT+q7JsdKdzg/iBrvTgGpY1pRD19wlnNfoobTgfD+r9UgxGR
	 2I8SZ97qfmPHejJKYa1HSkDN5r2FV10jAV0J6MYdAw2NZq+z1Ux/0RK4e2mc191hiVGIm
	 w7jNvuMZUfZ9FZ4b17KB7oSPSbwUBhBi2W73Y7IBw+H2IzCJbpbSHFKDIfPRv521lIohs
	 Q8aof5Kqajy/7+t0SRkzsj691+QSh6ageApptcDG630i1z6Ch2TWKroaasdRr3f6JtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innovatrics.com;
	spf=pass smtp.mailfrom=innovatrics.com;
	dkim=pass header.d=innovatrics.com header.i=@innovatrics.com header.a=rsa-sha256 header.s=google header.b=xZwCKltf;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E54606A324
	for <v9fs@lists.linux.dev>; Wed, 21 Oct 2026 05:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4E54606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=innovatrics.com header.i=@innovatrics.com header.a=rsa-sha256 header.s=google header.b=xZwCKltf
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so3148155e9.0
        for <v9fs@lists.linux.dev>; Tue, 20 Oct 2026 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innovatrics.com; s=google; t=1792560650; x=1793165450; darn=lists.linux.dev;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
        b=xZwCKltf3zghJTlx8T3lgccnf0K5U1fWzAwkzwC/xr2APRA4aQZpemSR3pJl3p4WQv
         hhpI7CdRBBOM3GG5sMNKX2eWe7Sr6JbS1td00XoELCM6W+r02W7EwwksDUlY6zpIHVxW
         N+Vg3TCfaFtqeMNKGctOGqWWCNYqd7Bisd9r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792560650; x=1793165450;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
        b=iuAzdodrGEvsw+N0xhepUQankhQ5eSbbn3khqleHDsp0/juMOacU3RsX5TEA+rFvgF
         MIk34ke0xnWULFOk0fcqPj6mI8uccLMjKSZiGB1pEVym8igma1wsE83V4ILO6SFKjrsu
         BlM6XXTJlEk+IoFY/w8/LrFuk5dkf3mf1VbBDo4GmC+HysLgURa7M6D6k+F2qZRIhdh0
         HEPla2UZOlRVpb8ZvPzGUPcykZEz01Cy/ibGkNnGcmD1521+HfPnJbPfhSSrY3dZEznd
         hVTCr0MZDBIRmkEl/1HQFbgn/WYv14yRy2eyr72/vlISrVHZ110mfEC0hw5KiOdrKzWY
         CuHQ==
X-Forwarded-Encrypted: i=1; AKwUvByS1IdGRR76Y1kDf4uqNvj7H2k43LawbFenvYaHvtREMYvSc3nXGMhuNnFrcBf933Fi+BYY@lists.linux.dev
X-Gm-Message-State: AFq9FYK15+R2tyNoR4YFiLIxq5uJ9r/KOpMW+0CMO3KIOREsKDKgfJxT
	X9N//NbRXbcs7kIKciTQI8z81oLViIfE5NfubQxjjXPMXBpr2RPO9QAE6TDtZFfnJw==
X-Gm-Gg: AYBFou2vQX3VHut8tqFAHG8Tba+yjbqU//SVfVAIm9lLKj75QCna6u6Tw28WKcPk8uw
	Hmfw+I4e/XIovn1H5GjqJEwSsDKC6pATaSIBKjfJeIvRXseKHIvjbokHmScci+R2M7roSu0Zmol
	FWi43Fk0QfYLp6/92NnFiAjjKCXgjSbI60D8KZk3tpuVZ877pf8XrN2k2zYCqQ1kt/6+IDxdRCV
	5qvOh70i1gEHMk63Nv4BovQzdzL4bmeKO1oMwy+jVzhftyPnxbWx1tUGJ9sZ7aGP3PjV+APQ4jf
	axNWk4W+/qmmy6dgb3Wac3UGGMTh0gUHS1IlG+Jt8ltiUplUG12CDivb8H8/NykIRgRtWTWyqXX
	NGWb/RkV48e21XB1llGXKmYVqEINFYAASVCYjutA6BDfMio5CKXN0GusbDBUk+8Mt7QU7A35ykn
	bA4VnfwmS8oEPAnoyaZiv8FP33eo03ivL/YMA5znTrORqs0sHfYtixHLALXrGOYJM4uj/584HEO
	XUvRPeMXZhDkeSkUKUuNUOtcuVZ0ekiU4gt0+IohYv10mASxJqdl0nVGqDrqRtIo8OQzFpV5jQe
	JW9KrWh+zD5luYOHTasEKHWMR+QpMVsMjOk/v4h1qE7ZA+bmQ70Z4lyIPYAc3rdyt3tzL8WS2/3
	h2dWBdBYEboSg
X-Received: by 2002:a05:600c:4686:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a1fd72e1e6mr17106685e9.0.1792560650270;
        Tue, 20 Oct 2026 22:30:50 -0700 (PDT)
Received: from [10.11.72.5] (bip-static-148.213-81-147.telecom.sk. [213.81.147.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm85779985e9.5.2026.10.20.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:30:49 -0700 (PDT)
From: Petr Chmelar <petr.chmelar@innovatrics.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    netfs@lists.linux.dev,
    linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/5] cachefiles: Don't rely on backing fs storage map
 for most use cases
Message-ID: <20261021.cachefiles-mainline-confirmed.pchmelar@innovatrics.com>
In-Reply-To: <2648476.1792482342@warthog.procyon.org.uk>
References: <20260910220242.2165023-1-dhowells@redhat.com>
 <20260910220242.2165023-5-dhowells@redhat.com>
 <20261011.cachefiles-partial-zeros.pchmelar@innovatrics.com>
 <1655268.1791878098@warthog.procyon.org.uk>
 <20261013.cachefiles-partial-zeros-trace.pchmelar@innovatrics.com>
 <1995693.1791971125@warthog.procyon.org.uk>
 <2648476.1792482342@warthog.procyon.org.uk>
Date: Wed, 21 Oct 2026 05:30:48 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"

David Howells <dhowells@redhat.com> wrote:

> Note that these patches are now upstream with this change incorporated.

Thanks, David, and sorry for the slow reply to your question about
the fix - I was on vacation.

I've now tested mainline (72a16bcff2) with the same reproducers as in
my earlier mail, and it fixes the problem.  All 4096 blocks read back
correctly on both full reads, and the reads were served from the
cache:

 - 9p, cache=fscache: 0 wrong blocks (936 on 13e340e397).
 - NFSv4.2 loopback with fsc: 0 wrong blocks (817 on 9f8b64f66),
   also after a server-side rewrite of half the file and after
   truncating and regrowing it through the mount.

Thanks again for the quick fix.

Petr
