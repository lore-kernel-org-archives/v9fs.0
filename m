Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795F3911C1
	for <v9fs@lists.linux.dev>; Sun, 24 May 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779633841; cv=pass; b=BlUBQZYrAuS3XvhlBdlAXdQluOEjeYRE/IhWR5gG4UgI1iI+a5UmQT88zdMCYQ/oy9TxQcBOHdYWZHt3LQZhsqw9Wqp67MUhyHnINj9Qx5/4uaMK1ptg8byCkb2MngktDm4Dl0JAMNj9ah42xs+iWyHAVo4PStzI46dIkALICGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779633841; c=relaxed/simple;
	bh=NlK4F5fZ3efqvVAgnJmeSuK2Moe4gmbeau722kK1tgk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FB5Nu+AFzet5shXPd5qNt1pgW5Ci1vViyX32E3zRWhDOVkjXQA2/T/agdKhAirIAQ91hOPjbJNbCRkn/7NiK3SEppygzc3rLlE7ADT3yAQqCBgfrNoNTw7TQ/Go0PW0wJvqsRLPpIbalgRNsx++mwHlkVs9Z/02hujBRZDYac0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD7ob4mJ; arc=pass smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD7ob4mJ"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-65dd9b25829so6903797d50.3
        for <v9fs@lists.linux.dev>; Sun, 24 May 2026 07:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779633839; cv=none;
        d=google.com; s=arc-20240605;
        b=HDzWP2ECyuMGSGQRamQkvaL9sx1wsUSheJSVwhvEe8pYtXCuQCSoq/W834/pZjIQ9a
         Ano52aHjnpxSM2tuetSy9zGWh9mz16vQIIfZfMbaV0sVPIOu7aTcx5WscR5vZjuH/id1
         CBMoEdNAodH2f+gYpblgVohGug+TjRRuQJympyQGPbw4qtOTHJ9ccmYFuj2BpmnIJ4nb
         3D4UdfxkSlc1slKd/V28tY8qdWqZpEoj1/6xfJJXoNGg6XC2syDwBCs//nwpM5eYoLXv
         ufEp3RTNHF5q0P4l5jBTS77a1THnWNndBGO/NBPGbwPaqHwZd4LV5hF3QvBcjUef/WH7
         UHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/Zvti4NWUDpVQhUUVmUXlsn1DslKKtq+cqj6zJoUA70=;
        fh=EXOcyuRuHS+XCSZAPrcNZMFaX3cXJTlLrup87Drmf3U=;
        b=dGzVWAgupg3XD36Zml53EedmxGT8UA+//TyaZ1yIMur3H3m0zdkvQDzcFr1KDCvW2r
         pmOlE4tuBLTn12ln5GKMaTi/iVTX0IJgFlRNkHb1V/LPsN1biAfnl/HvmFNN7ezFLz4y
         dll0nhJgv2J2HJ5wRFpHWOy+Dr4Tdbw9eCvZ7Ygw9cwie8+PjbbFb2+QMRfCdwWWeTUz
         enPYE0vLK3QxkAZ6ZQgc90exq9eCWHHM4AyHy7hPpVZOMpfuin9FXLAQ22RDmE6TBVWl
         j0J6PJh4l0kLMWQtTldRroGO3xfvD43M/cFVmD/MpNIbuXxO9QQSh8lfF7S7XBHxX9TN
         uRvg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779633839; x=1780238639; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Zvti4NWUDpVQhUUVmUXlsn1DslKKtq+cqj6zJoUA70=;
        b=jD7ob4mJ/7t++mWIehZbxe3+MIaGkIGarIF6N1SKwXjAZcYRSrwvpKYv2lx60hWnJq
         vykkDvLAVVWNg8N36b4rQSOQSQyA7sJJK6bgfnptiMH6ULhZZl7y4WoaQasZWbjZh2wZ
         wOiqAumCo2rfzu/Oy+G+l6KHjVyDqADy9Z6W3Ep9Y/GV/YBS7Wfurlti7uVLFCo0If6X
         7yWXltBOfclk8WDogaoPbIWd/SlmOcBEDPNOvMf5kfRuAM8aVFUh68yvj3hX64YV5eA5
         TNTvO1lwhwwyt6w2xUufC5DqHXYgsPNjHolFiYNGMhwMZGt74AHXxW8t/ONUg4MmDwyF
         b+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779633839; x=1780238639;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Zvti4NWUDpVQhUUVmUXlsn1DslKKtq+cqj6zJoUA70=;
        b=jWFe2kM8SOrfoeNF5prgtwc+SCWCmJCh9AvIObSquUzzUsY2C8nQzz1QW7BhhBTPFl
         jWyM/4AutTBhf+I+ZyxNphsCaWfDCIoKtB0roa4VEV3x44yMKAQFvdDTIlmGmsUJ4+GM
         maznpo3bxIAU1czRNnRQtZYeMo2kSiDLmf9N6g66aKkctb/5rRmvo3HYo4xnqt/Uxuql
         KQfrT41+kgrtZw2/mDne5XxlklGhekJG6ELBMhfUj8bn7YExdEhhl+wVHdfIV4HL+DAs
         XVmpycbrqshgiF8WdT9yVEvi3G4lh4kB9SgzamVqKb2+XF9TdXycJZn1IMUltbTsaybJ
         6iVg==
X-Gm-Message-State: AOJu0YzkblNR5eGxcS7VPz6pGjYq/xCMEre61EPxb7nhVHyWXHCqEJL/
	LOwPLVxWyjaFd9X1+IyHLebHDQ/3t55HTPNDsgEdDV3AdLV590//mbfWE0idqdR4wMYSMk0WHnQ
	rN7Le8ohczURlYz+njblHTsus3wc4FSyHmazDt1c=
X-Gm-Gg: Acq92OFrOFSCax5Eh/TjIRzU7W5U1q0bF3Xbiu94A/AVbmmb10ePeVyF8hkzbz9dUkR
	cLmHFWibUH+XlWmV4t+cusdeDuqkZJoXvsD41JQDilQI9iNUf8Fuft/FvhIT9kRlkN9/U36LVtg
	hOcQ8JD2/elyVdTjSDynlukntUpIldTOnyZg0Y78lMNbKml00wI6QTiO3Wxxuj+zbOoWteHA3uP
	44EryE2UC3KiKBDpa/CHM6TjYLYmRn3m2cmICyzTw6G6xk7JQ/W8RuNESDwfj6ufks7M5x6KEA9
	DqsP/0E=
X-Received: by 2002:a05:690e:1247:b0:650:36e6:2ace with SMTP id
 956f58d0204a3-65ec98a990amr10942651d50.31.1779633839099; Sun, 24 May 2026
 07:43:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 24 May 2026 10:43:57 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 24 May 2026 10:32:58 -0400
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yifei Chu <yifeichu24@gmail.com>
Date: Sun, 24 May 2026 10:43:57 -0400
X-Gm-Features: AVHnY4JaVQjQs77NmH4_trHulshGdAYQ-1Tvs6oFR0duvStVTCRTDSdwQuUAGY0
Message-ID: <CAPJnbgJ7ZK7DCjCfG56hd_iKGePmAzudb4hOWd4=9r32nM+KcA@mail.gmail.com>
Subject: [BUG] 9p: unknown RLOCK status triggers WARN_ONCE panic with panic_on_warn
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cf90380652914a81"

--000000000000cf90380652914a81
Content-Type: multipart/alternative; boundary="000000000000cf90370652914a7f"

--000000000000cf90370652914a7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Short version: I found that a 9P2000.L server can return an unknown RLOCK
status byte and make the Linux 9P client hit a WARN_ONCE() in
v9fs_file_do_lock(). With panic_on_warn=3D1, that turns into a reproducible
kernel panic.

The reproducer is small: it starts a minimal fd-transport 9P2000.L server,
mounts it, opens a file, and calls fcntl(F_SETLK). The server replies to
TLOCK with:

RLOCK status =3D 0xff

That server-controlled value reaches this path in the client:

WARN_ONCE(1, =E2=80=9Cunknown lock status code: %d\n=E2=80=9D, status);

Tested environment:

Linux version 7.0.9, x86_64 QEMU
gcc 12.3.0, GNU ld 2.38
Boot args included: panic_on_warn=3D1 nokaslr console=3DttyS0

The panic I see is:

unknown lock status code: 255
WARNING: fs/9p/vfs_file.c:201 at v9fs_file_do_lock+0x614/0x730
Kernel panic - not syncing: kernel: panic_on_warn set =E2=80=A6

I also checked current mainline source and still see the WARN_ONCE path in
fs/9p/vfs_file.c. I have reproduced the panic on the 7.0.9 QEMU build
above; I have not yet runtime-tested current mainline.

My read is that an unknown status from a protocol peer should probably be
handled as a protocol/locking error instead of reaching WARN_ONCE().
Returning something like -EPROTO or -ENOLCK, with a non-WARN diagnostic if
useful, seems safer.

The attached tarball has the README, C reproducer, and full QEMU log.

Thanks,
Chuyifei

--000000000000cf90370652914a7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hello,</p>
<p>Short version: I found that a 9P2000.L server can return an unknown RLOC=
K status byte and make the Linux 9P client hit a WARN_ONCE() in v9fs_file_d=
o_lock(). With panic_on_warn=3D1, that turns into a reproducible kernel pan=
ic.</p>
<p>The reproducer is small: it starts a minimal fd-transport 9P2000.L serve=
r, mounts it, opens a file, and calls fcntl(F_SETLK). The server replies to=
 TLOCK with:</p>
<p>RLOCK status =3D 0xff</p>
<p>That server-controlled value reaches this path in the client:</p>
<p>WARN_ONCE(1, =E2=80=9Cunknown lock status code: %d\n=E2=80=9D, status);<=
/p>
<p>Tested environment:</p>
<p>Linux version 7.0.9, x86_64 QEMU<br>
  gcc 12.3.0, GNU ld 2.38<br>
  Boot args included: panic_on_warn=3D1 nokaslr console=3DttyS0</p>
<p>The panic I see is:</p>
<p>unknown lock status code: 255<br>
  WARNING: fs/9p/vfs_file.c:201 at v9fs_file_do_lock+0x614/0x730<br>
  Kernel panic - not syncing: kernel: panic_on_warn set =E2=80=A6</p>
<p>I also checked current mainline source and still see the WARN_ONCE path =
in fs/9p/vfs_file.c. I have reproduced the panic on the 7.0.9 QEMU build ab=
ove; I have not yet runtime-tested current mainline.</p>
<p>My read is that an unknown status from a protocol peer should probably b=
e handled as a protocol/locking error instead of reaching WARN_ONCE(). Retu=
rning something like -EPROTO or -ENOLCK, with a non-WARN diagnostic if usef=
ul, seems safer.</p>
<p>The attached tarball has the README, C reproducer, and full QEMU log.</p=
>
<p>Thanks,<br>
Chuyifei</p>

--000000000000cf90370652914a7f--
--000000000000cf90380652914a81
Content-Type: application/x-tar; 
	name="9p_lock_unknown_status_warn_panic.tar.gz"
Content-Disposition: attachment; 
	filename="9p_lock_unknown_status_warn_panic.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: dda7f6b19c7dd4f6_0.1

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
--000000000000cf90380652914a81--
