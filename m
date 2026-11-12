Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451562;
	b=fDiT+epmDJpKQS0AFaQO/q7QrS2HD+fEaIjvD3aasdLFnbq071idsUQgmjT/kvLoxCMi
	 JYD5xnG7ewfLsujkx7Zwa01UFcIX/+WQYJINDme+fxN8lJzmUJUwdrbJg508ONuNAfT8W
	 /nHhZxkme49fwQAyBTnb+LlL4hvTBhgmMSvxS1ciUmiuv8/xdOPpYLSnwJnR26+PdGV7k
	 x/RF4NvdDTCMW0S11zFwYsPt7jMKnJPZuNMTPEdzNKE58Dqk9SGcUeKrswSnGy8GBg3bK
	 NNr5rZPPrsLU3oUnb2yYXvcrVD6yiTr4e8d/RxBOPU9ypLkTu8hraofznQwK7cLt5dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O0Wzh/H6cUYHlQzokf7YPQu3CTXbAI/owZLe5svmt0Q=;
	b=tn6u5zwjTuuvR+db65DC8H1rCFT22eV0sccr/co6RfAxibIwK92vXlZaU2AjvU5qx04R
	 BruqHGp0Qt9lXvzojwn/uACOkdkFmbivov80HBxGto/Yd5SI3VsdFEdmWoCPhn4YL1lfl
	 JlSvdhUl469X2u/r2/yxdvRNnnkSX/qqhnHZ0iFDhE9qWjdArU7KkcbQvViPepOCitHx7
	 PVxdQEKSHkO4054qKa9nK4YbsObuLqbbIz1IAyvIIYJUTU7Z4ClCq3RvAthlh601oPDEP
	 p6ScOhwzjXlq7ZWXaeh24nKkEGR586Y+hpqpaYFQmyjq2XFbFgqorPAnpY2S3O405kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V0vqv9wK;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DE606A323
	for <v9fs@lists.linux.dev>; Thu, 12 Nov 2026 02:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 204DE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V0vqv9wK
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5495d549924so38688911cf.1
        for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 18:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794451561; x=1795056361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O0Wzh/H6cUYHlQzokf7YPQu3CTXbAI/owZLe5svmt0Q=;
        b=V0vqv9wKe4qnXHJQRYFehdlOs4hUEN3Wj7mRnJNErqpciumcbZB99U3TpQAwgMMCwM
         MjtjhQhoUB62Fs7JewW2RyXZnhd30+ICvFwEjPCldox+ajYc70tIyjiVm1xA88B+8HxR
         pZ8C894jM5jsTI2ESYGT4wRFtlFTW8ngmCSLmreCTMxvmNhtGng8znaKDhhGaA07Yr3a
         Je6WR31pySqGBlqpI/kEWWuYIKOwUrJi6zENmAPhM6uj17HQsIKm+vQJhZbX7dxgxIqo
         fvAY+fHAFdnS6B8k659qrkcERxw5UT8lLa1F60C5Mohjg0gNx7OtEnU8g/yhkG93AQKs
         iLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794451561; x=1795056361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0Wzh/H6cUYHlQzokf7YPQu3CTXbAI/owZLe5svmt0Q=;
        b=JV3nEifxStuHR0BIounIgd6WRwbRexBTD+Mh7jV9LYNZCiEYy2JMlgsfmdIRkDANFf
         VZOoYjbpPp58X7NT5lQETduTE/oGUkTiJ0+uhuAbkjscAhRPafIHeAG8OItszp6FNFOo
         Pil5ftdPnxZ9kCfQ17EQQ03CYJxoii6N/equ3EfjNIdxP4AfL+M5oLDfKF/tRCx4He6z
         7KAkViOhjiVou/zZTLOYHoTqy3Rm3JQ7PZvlhgHMIWyHFWN0kcvJddtRM9TJrF4hEBm3
         ++rMk5fG4v29laLVlrCMWRClIIJCAZ3qnrRDjw3rjmStcoKJaK1ofKCkw0bX+TubwPa5
         Botw==
X-Forwarded-Encrypted: i=1; AL+hErGRo5jCFzpXMcD+04FHpwYIRGhaeVrpnocM58ks0x9mA6HwfrUQUjeFs+46VB+/hyD/ST27@lists.linux.dev
X-Gm-Message-State: APuU4Z9kRu3CNP+C5q7OB0hFR8UYW/BoAhcrzJF3Df8ac/FMlN2CEi/v
	6/pAu6iiAPQcmyDFZzZiVRmT6dFoCjNVeM7xbAyhig/CLTyzGKlzT8JV
X-Gm-Gg: AYBFou2Hg3JzcY7ANjBz51oM1r40ENg6yu3TqVg8Ou4x6ff2QVmPJkyxJOZgCWPudNa
	W61O+sd8kkzJNyJ8ChaDOoVe9wj6F3vJ0ZdvQVmuZw1PhWlaR9Qp6pEtG77aU1i6ZQ+TcKJRppL
	Wqhel1bkXS7oG5r1hfENyfTHmVXWA484u6KMdHyR21QE71NORTxxtCEVBbObUm+U10zI8xcuKkV
	lSV8eVAfvdA5W5KAN5Iax6AX4hd6m5z0tTWqObUn1ezyWo8DnRaGcQd1LRtBW+JMpbbj8MmNfmY
	O5O2QZ75FJNDPrk/RmEqIpk8EY+2cMMfVhzX5Csr31kR316R7X+mrWO8k5RO1M5VdbOGJQAdLxb
	nxuy9p9zVNCOk5H7KaC4rQI+0mXFbkC3tREts5LLn+gbCTtCwpDIt0M7bA5re0whnplPJU1mpKr
	fywFg29Qb4srFINrpleWFElB+qPbZwi5fpaDDbUoLZblF+2pU/Vszp1ZYnGf72wN1yR+6UoKs4g
	/1q8k3004wBdUD8Ge9YcGTMmFypFjxjT+AhhPdCRDZx4PggAJIwYJ9S1s6a5i24fXqPDtpHCzY1
	vE0/O8bzGOXxuh5KTJBhYVU7pzPNRZ7KVXXXvS9eZcfLidDpO5n81UyVEQna5o/7C4RbujOCeQ=
	=
X-Received: by 2002:a05:622a:994:b0:537:a19c:6e52 with SMTP id d75a77b69052e-556c1f42ed3mr70735681cf.56.1794451560904;
        Wed, 11 Nov 2026 18:46:00 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af60493sm64922411cf.4.2026.11.11.18.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:45:59 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Yuho Choi <oss.patchbox@gmail.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [Question] 9p/virtio: zero-copy pages after interrupted request
Date: Wed, 11 Nov 2026 21:45:50 -0500
Message-ID: <20261112024555.1201300-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi,

I have a question about the zero-copy page lifetime in
p9_virtio_zc_request() (mainline 067c5c24cef2) and would appreciate your
view.

After virtqueue_add_sgs() and virtqueue_kick(), the function waits for the
response with io_wait_event_killable().  If a signal interrupts that wait,
it reaches err_out and calls p9_release_pages() before returning
-ERESTARTSYS.  Only after the transport returns does p9_client_zc_rpc()
send TFLUSH.

If I read this correctly, the sequence can be:

  publish the zero-copy scatterlist to the virtqueue
  interrupt the wait with a signal
  drop the user page references
  send TFLUSH
  finish or cancel the original backend request

The virtio backend still owns the original descriptor when the page
references are dropped, so it seems able to access pages that can meanwhile
be unmapped and reused.

I also checked QEMU's 9p backend (71f25c75417d).  v9fs_flush() marks
the original PDU cancelled and waits on cancel_pdu->complete.
pdu_complete() calls push_and_notify() for the original PDU before
waking that waiter, and the flush coroutine then completes RFLUSH.  A
successfully cancelled PDU is returned with a zero used length.  This
ordering suggests that the original request can remain active after
Linux has released the pages.

Is there a 9p or virtio guarantee I am missing that makes it safe to
release the pages as soon as the killable wait returns?  Or should the
pages and the transport's request reference remain alive until
req_done() consumes the original used buffer, including a zero-length
completion after TFLUSH?

Thanks,
Yuho
