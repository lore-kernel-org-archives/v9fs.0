Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466582;
	b=WQSE1xulS377DbYe65Yub/1LUSj035+ULqzF+SuPsj8bbt4Ve7LVc5/YndedsugftAkC
	 JqCCNvI5hkbDz23LbRp0v2EAT9i0OrR+/INdy11myrFs9JwgAPDmOCduLtzY1D+yyp3dg
	 ABXPV6M9MLQ7E0IoPsKBy2jnWzaWVZd+yjEe9xkFWYFU4x1H8GfNJcm+gi3KDtEyH8oOu
	 7GmymX2hutz1zEG2wdeDub7BxPN1pah6zHOencPvOvVOLbUVwTQXRiMteP1WNxUbj18CZ
	 S2DBWyE6Xxd2PZ7Fghy9IaBdTJazrVd+yantIcyruO7s2UVNlVhoZYqhdWzChimJlTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JKkJYPrCUqRXqqsiNkj7J/GhQQ+Z7+5b8+YcNnPW1YA=;
	b=ILOe49Oj6on1vSJLRX04HXUGJBXXuqeFQbdYBvASnuPyqPO1Qbuqpm+NF5+lusmr/mBB
	 GM3qOhyYlHbUKlSJYgLjz3q9KAfVnZARV3QV7v42cxxdIEeazx1TnBesJAF/p1fHdDSPY
	 PuP57C54i0LhyNhcAQRlTjQnRIW4KC/o5z2GERdPs2ipDQW8yYzyHRHVxZS2c+zrUj5kk
	 kjaceZnlo3Lc5gN5hwoEOpnTsYdee5GqqElBpC/4lEoa1dVdPN8RGNTEX5vkkE4kFiV6g
	 plFpcGs2QuxdFgTg+plbmUoD5na7eItDHDxrNcX+CghuJOljdK+MTdprO7KL/oXXg5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=0BejGK4z;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001BC606A331
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 20:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 001BC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=0BejGK4z
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14394530ec6so5456676c88.1
        for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 12:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466581; x=1796071381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JKkJYPrCUqRXqqsiNkj7J/GhQQ+Z7+5b8+YcNnPW1YA=;
        b=0BejGK4zivwfOjwVRe1GFj/ADCK1SmvNoFS72N8FdR4ft6DYEwzMHftGUtsaveS89e
         lWb7/iCDrTrFaYzZ0CNFhCSaYfqXGpsXkGpop0m5rWonDxTQHaNqVPrdafkH+PXgdA2f
         nXjnkCIrWhNDf1Gq+70CrL3/LtjpaA0BppwljV7FanlCEQwy8Wq5lUM6yfSyV5sCdifM
         Ggp59bwdJangB9+ELNVzOtPiOj2/tuuGz4HHphM8mtUC/1ORdm3j0GdDR6OHKAFXvMUW
         tsJG7SSEUp6XJFHbmsQj4K9tw9R8DMHcXx61P07WWTe4EBa7WXqA+x8l39wJnwyCQY9M
         ebPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466581; x=1796071381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JKkJYPrCUqRXqqsiNkj7J/GhQQ+Z7+5b8+YcNnPW1YA=;
        b=z+IJBQltYKz4YIO713YDCxgTybr38ZyRLbeyZ4I2P9XOQXYxuQHUqIG8/y6CPt6Bnq
         NKLkM6/Gmzr17cCZpajWUj5o9XSBkDILe8lh4ZMT/AEd1VkF12kCVDMxYMUNQ6fzJswe
         xV7enSMtFIuqgJqugWx31iUoq0+o+Ck/mq1MM0vv7+M966uBnQwRZ//Z9xmh/jAosDlf
         ZcGbE+tEDWYVBIQelCF2hwSTt0qDRb/3NsatQHBP8fifm1OY/FKIkG0ZW55FYwOV1pW7
         xwXHIz3goTlTXvVHFVOqxZc1B4rJuZWXjiiN6Q0qCzujNkwmK3ZwAuncWb050BOtwYcd
         P12Q==
X-Forwarded-Encrypted: i=1; AL+hErHneba5pvCaPp8Bb8ys2EOGBojwdg4Ft1JRESFBsTiVZ4Xvmce6lrIoDkatYmnMIGGLrmdU@lists.linux.dev
X-Gm-Message-State: APuU4Z+AA+yWwZ+rq5jpbmdEohgFSG9amiwvkS0QQHPlnNirz36rZwb1
	rz81plvJn2eGdpzjy5IYVg4j9hqi6yfFcMN6TAuGjnC2BQ7xJZHhYjy00rrO61gYcQ==
X-Gm-Gg: AZFdTZd3AN2AeHsKVrB7/BmKJpnP1WmuNlPhv+AhqV6zSsmFykqk1WJ4D00Nasu2DNO
	R7FrvAoV4N+DF5gKNLups+dCbtEviH8toDQgcI06zQUvB+Q3R0EwjBQS+ZYGtZ8C2uj8yfbsRI9
	N15RU8rYGEFDMv1ZYVRi6ZGzZFSrb82xb7uPGugyRhOaTZAxnUuguzIg7Zg+Px1c4XPBrHW859c
	TiZ4MleE9SMhmWBumDNGMhzhAfuaa5/MLaZNhQ8PyuI5gRTXwmeAn13WFBLf83zHqLEMYjoCzcz
	D3USgl+u3NRVWFsrszjQgytX2DQxgA/vpK0V3wtwXiwsRTzp6+ZIXRRw1Tar/js6c9tScJx12WH
	b2fbnUcgvyLG0TzxB+twe8UjiRULTTscHuaYR6Im1D/UGXlMrtkv0RXMNbudBYir2Vt0QCYGT/q
	gXoBMEqDngBq+NpV+0xxtCKy3rWMGahVA4ZR25YmENEbIkVdp5GbIXskgYmduTZF6xJWbzctpdF
	yexEInIoP3AtcNJjXEIqItz3r1TeHo6WYKiUYvLXYJ2HiVNfJRMomVyDkoWHYjJbR/l9WA5lLuV
	ZDX8+uRt80VX/CRIGwEEYRJ4VQXd3GaGcOLFOQ==
X-Received: by 2002:a05:701b:230b:b0:1b2:4da6:bccd with SMTP id a92af1059eb24-1b5568feaadmr10679683c88.34.1795466580856;
        Mon, 23 Nov 2026 12:43:00 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:00 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>
Subject: [PATCH v2 0/5] 9p: bound zero-copy error replies
Date: Tue, 24 Nov 2026 05:42:52 +0900
Message-ID: <20261123204257.3055515-1-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the error reply to a zero-copy request, a virtio-9p device can make
the client read past the posted buffers (patch 1), also with an RLERROR
under 9P2000 and 9P2000.u (patch 2) and with a reply after a fatal
signal (patch 3). Patch 4 fixes a double put of a zero-copy request
interrupted by a fatal signal while waiting for the ring. Patch 5 fixes
an uninitialized value printed in a debug message.

The patches were tested with QEMU modified to send the malformed or slow
replies.

Patches 3 to 5 of v1 are left out in v2, since patch 3 of v1 fixes the
use-after-free on a request returned after the RFLUSH, but puts a freed
request returned after an umount [1], because an umount frees the client
and the requests while the device still holds them. Fixing this entirely
appears to require deferring the destruction of the client to a
workqueue until the device has returned every request, which is costly
and beyond the current scope. Patches 4 and 5 of v1 depend on patch 3,
so these patches may be sent again in a later series.

v2:
- Rebase onto v7.4-rc4.
- Add patch 2 for the RLERROR case raised in the review [2].
- In patch 3, accept a late reply within the part of rc.sdata posted for
  the header, as raised in the review [3].
- Add patch 4 for the double put that patch 3 of v1 also fixed.
- Add patch 5 for the uninitialized ecode raised in the review [4].
- Drop patches 3 to 5 of v1.

[1] https://lore.kernel.org/all/179446999129.2199510.15094266003962078465@kernel.org/
[2] https://lore.kernel.org/all/179446998758.2199510.14994914047354508278@kernel.org/
[3] https://lore.kernel.org/all/179446998948.2199510.3182298225630042557@kernel.org/
[4] https://lore.kernel.org/all/sashiko-outbox-206901@kernel.org/
v1: https://lore.kernel.org/all/20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp/

Lianjie Wang (5):
  9p/virtio: clamp the reply size of a zero-copy request
  9p/virtio: move the error string of an RLERROR into rc.sdata
  9p: bound the zero-copy reply after a fatal signal
  9p/virtio: set REQ_STATUS_SENT after adding a zero-copy request
  9p: initialize ecode in p9_check_errors()

 net/9p/client.c       | 16 ++++++++++++----
 net/9p/trans_virtio.c | 15 ++++++++++-----
 2 files changed, 22 insertions(+), 9 deletions(-)


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1

