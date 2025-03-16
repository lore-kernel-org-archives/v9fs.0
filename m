Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE8174EF0
	for <v9fs@lists.linux.dev>; Sun, 16 Mar 2025 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161876; cv=none; b=iE79tCvTxXzqwajQqCVg+9/ZFPCRphpB2+1C6jBZaZclSX+4nI5FgFE6Wt4jEOtouW/iJ3K0a7ii94qRY+5FsoQBA0EsjKhtI3UVDaZMxHkyZ99zuv0dpxYp2CIhJ6O4Sd5xa7u0t3Cw0+Vium0maLgVlwcI5ebl6gcq3ouce7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161876; c=relaxed/simple;
	bh=KwSTIINjek4C6NcWfA3eWqBn2q80cIra1CDyfVwYgYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Suav9c+6rbbGoX6tUg8kkYCUnqhXyVQnRgCXs0SPL/MCiqLtbKe3AdEoBh6/t+Jd/e7x4GTW0DjFgI0NbBr/4C3dXgpsEsO7EBCzf9sZUzfZqwtCzkHtwUeK7vEBwbwOtxIRmuwnQdxtTyzJAu8f1dH3FV/dRhj6bP9E056Z7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=M6dsYWQC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="M6dsYWQC"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2D1AA14C2D3;
	Sun, 16 Mar 2025 22:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742161873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YimY1Bf+igN/ThVHO6TRhNXFBUxdzqU4A52j7oKmUks=;
	b=M6dsYWQCzMnGfYox5OXAS77HbwB3tTOfKvRRP4JeSdL5KiYgKF5GV0HAiM4IPs1o8ZHNsT
	OBz0RrRqAWQMzs7+tRbjjsRMKni/yio87VRK9893e54bI848piKWvV99NkGrwH9xXK496o
	cYotI/Y/PoqJjs8cMZlRS1HUIU32oSxhHmoH1JCyhjepIAW5m6EAPJJrhu0+t6PJtvx1Oq
	1U+iVhkCfmi+wKhen7xsEA8KoY3k2G99ytGpdKeQI+bhCDIOs17h+G3iWwcQLS4WkgTXOE
	+WrjXRFP+1KwmrkCeQhZklPjAAK93N7p4P8/9JayC9MJq9mzhYenG7wBJsQfFw==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 7b78d06c;
	Sun, 16 Mar 2025 21:51:09 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Mon, 17 Mar 2025 06:51:06 +0900
Subject: [PATCH] 9p/net: return error on bogus (longer than requested)
 replies
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-p9_bogus_io_error-v1-1-9639f6d1561f@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAMlH12cC/y3MSwqFMBBE0a1Ijw0kikjcikjwU2pPjHb08UDcu
 0EdnoK6JwUII1CVnCT4cWC/RJg0oX5ulwmKh2jKdFbo3JRqta7z0xEcewcRL6qANa2xHXLdU/y
 tgpH/T7NuXgu2I6b3b7yuG/XizKB4AAAA
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=KwSTIINjek4C6NcWfA3eWqBn2q80cIra1CDyfVwYgYw=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBn10fNdo/Q7bqDGxDs238ulpF8UAZ/3Ku9Qxul6
 3YcWqzDSk2JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZ9dHzQAKCRCrTpvsapjm
 cO/ND/sFGDsmMG1kXFbFmQ5eUTUm6xQy46PFnGVhfl+5mPw01AtF0guhax0k92+5VefchoWtrF5
 kEykfrXSb+c7suxawLKbbPJGpIb7G2Lk0lBsLKJtBZ7fvqzdaMdoOFbJYKeoo61TUhxs58acTbg
 8JItcVEzDtAb3YcpD9kStznkG2mhYh2Z8qj48vUlbgZMKuAaLssZ3/Me8oEo61w5XhmEjELWIbg
 yqnmx5gK6HThfDyxS/gD+H1n5eElnW8y2yPTrjFA8IMwOzM9eRBUtpYgnAwq/sBipAV3ySi+FIf
 dkjBoWeXHjteL6zbD67Itlz3PAIc0es+8YRTDek/zUUmnS3kTy3tB5ZmqxYJrBHE2I8Vp9XkR/p
 bUzKl8n2bjRK6y9Jy2zsKuG220wmzFUEFHBLApcND1CChvSIp96jwd3h1SvyqYM5elfPaC8Q7Bb
 8s4qRCyKBnE/TEP00xWTV5KRGGm5bk6iQuhFok1F017XMOGQiwErXBNCeCRcPYcn9//vrVvEK8I
 cSiqVSxSJ8wCm8HEBCznrOrTHr76/swT5KsPSD1TNhmVS15Ex7kI1hC30WB6NeP378mWTeVR8LC
 JHYXcLDkZyDmGt1exIhXSZjXPwHKxt7fYgPMqJx0IQ1RhE6/XnuMnxk5dT1s0CsUnF6zvOnEQR5
 J6glgeTAuBcQIZA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

Up until now we've been considering longer than requested replies as
acceptable, printing a message and just truncating the data,
but it makes more sense to consider these an error.

Make these fail with EIO instead.

Suggested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
As suggested in https://lkml.kernel.org/r/4171850.H1WhmIdAfj@silver

Not tested as I haven't taken the time to make a bogus server...
I'm sure syzbot will come bit us on that :|
---
 net/9p/client.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 99e9a55199e8..a2e5ff161562 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1594,7 +1594,9 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 	}
 	if (rsize < received) {
 		pr_err("bogus RREAD count (%u > %u)\n", received, rsize);
-		received = rsize;
+		*err = -EIO;
+		p9_req_put(clnt, req);
+		return 0;
 	}
 
 	p9_debug(P9_DEBUG_9P, "<<< RREAD count %u\n", received);
@@ -1661,7 +1663,10 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 		}
 		if (rsize < written) {
 			pr_err("bogus RWRITE count (%u > %u)\n", written, rsize);
-			written = rsize;
+			*err = -EIO;
+			iov_iter_revert(from, count - iov_iter_count(from));
+			p9_req_put(clnt, req);
+			break;
 		}
 
 		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %u\n", written);
@@ -1713,7 +1718,7 @@ p9_client_write_subreq(struct netfs_io_subrequest *subreq)
 
 	if (written > len) {
 		pr_err("bogus RWRITE count (%d > %u)\n", written, len);
-		written = len;
+		written = -EIO;
 	}
 
 	p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", len);
@@ -2145,7 +2150,8 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 	}
 	if (rsize < count) {
 		pr_err("bogus RREADDIR count (%u > %u)\n", count, rsize);
-		count = rsize;
+		err = -EIO;
+		goto free_and_error;
 	}
 
 	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %u\n", count);

---
base-commit: a08cea93bd00497bdf3ff09527d378e2e928ed3a
change-id: 20250317-p9_bogus_io_error-5e91a19be30c

Best regards,
-- 
Dominique Martinet | Asmadeus

