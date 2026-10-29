Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253510;
	b=4JjmQAvuMuPVKAeylMmoZBweyoG8aW3qbrYmleoFCn7GYUEuu+pOqeRVO93hnz16AlD9
	 OI9BX2Pvf4KeTW9kUtzv9uq1QRX4esgvOVzlk2VOv7qtORKzz/oaQfERkCBrBlIyshnlf
	 2DZC10wYjvDXiVW0hFtpVVJPB07vxUE9ZeTlIvBVdR0Zv0iQNMKBMtKE705WD+D5QQshq
	 bIE2VL+0x29v1Qs8RTYBBntyla0r7uyyv/0BfeAjWRjj2LO9nc9p6AaPYMn8H/4RHfMDe
	 5PpE3nxJqbK3tGO8Wb7yx4YhWylL0lhmNpxaL8t2fyuTtRpcRXxMSv4u6uglZSuw7eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253510;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uccmeCHaHJdMWir67NKZcEGmBbvnIupxOj2VL9Ao9Ls=;
	b=4PyjIOAfysVBZqd4RbiOMzUi5BRwv6dGvAuCdp9uF48KeW4gJg0TJpBjbnZbwEqGBVOh
	 oQk4Fx/WvBd8CmkpNIcTI71AqoOWylE8S6gaTlFXg9V5273BJVNLXLE7FMcSXicbzyHPo
	 f9XLvbxJmf2vN4cu3oGh4fZ/kVAlaFXu6ni+w1KIxhOANtplEJDch2FCHOqIQKXQQA9Bs
	 WVvJu29GJzynD8ULgkhkfdR5KRzHY0MoWWA26rjDSkvpnkJ6q3RR5uLmLpoTJKHfLoVtE
	 cSqkJOBaeO7J4j2KFJGcSR6TkzNCHeY2aLbDmM/ALAkQrEpXa0mhcTOlYtA2KfbMjyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b="gxFdJpr/";
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2A606A31A
	for <v9fs@lists.linux.dev>; Thu, 29 Oct 2026 05:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E2A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=gxFdJpr/
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A3F0714C2D6;
	Thu, 29 Oct 2026 06:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793253506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uccmeCHaHJdMWir67NKZcEGmBbvnIupxOj2VL9Ao9Ls=;
	b=gxFdJpr/0LBsrQYke7wZ6t4B2VNnOwI0omJ147Z0+pdSwNm44kqk/YxP5STLT/xM6g7eUj
	QhCDnx/OXQbZbhrpEpKq6hlADsraoxbTw+kAsi17u7qWjlg0o0sp1ej/L62ImdjRhdQK3T
	0fwmP1D5v9IuqFSfgGKFJOKOPE8pUXp+omMmIDqx1BIeHeigXxvHuApuAUGTXpaFuezW/G
	/UcvGhLwF4hQf0lT8Rjm6/8bzuoME+8+uQ3/hFVm4SRuSUAW1FqYgeHcOO1z5sdMS33FzV
	vOwn75RlmYCTlFDGRop3qDaLoBwGP5q58SnInH+gx7nmVrC1fGbsPJccffg2oA==
Received: from gaia.codewreck.org (localhost.lan [127.0.0.1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 51c5776a;
	Thu, 29 Oct 2026 05:58:22 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Hui Peng <benquike@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: reject RERROR/RLERROR with zero errcode
Date: Thu, 29 Oct 2026 05:58:00 +0000
Message-ID: <20261029055801.3-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.54.0
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

From: Hui Peng <benquike@gmail.com>

In p9_check_errors() (net/9p/client.c), a malicious or buggy 9p server
returning P9_RERROR or P9_RLERROR with ecode == 0 causes
p9_check_errors() to return 0 (success) while leaving the unparsed
response payload as if the expected reply message type succeeded.

Map ecode == 0 on RERROR / RLERROR to -EPROTO.

Link: https://lore.kernel.org/all/20260919221734.3708000-1-benquike@gmail.com/
Signed-off-by: Hui Peng <benquike@gmail.com>
---
This is a resend of the other half of that commit, since the original
author never bothered to do it.
It's valid enough to be worth the 5 minutes to resend it...

I kept their commit message & code verbatim so kept them author

 net/9p/client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/9p/client.c b/net/9p/client.c
index ef64546c6d52..e63e8c2a853d 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -448,6 +448,9 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		p9_debug(P9_DEBUG_9P, "<<< RLERROR (%d)\n", -ecode);
 	}
 
+	if (!err)
+		err = -EPROTO;
+
 	return err;
 
 out_err:
-- 
2.56.0

