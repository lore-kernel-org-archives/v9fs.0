Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386B7221275
	for <v9fs@lists.linux.dev>; Sun, 31 Aug 2025 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668160; cv=none; b=ppxLnCuutw/j1Lsg4U+S0wqbKG3LYGyU1CSfewjVDCEsBAffkWFeNvTXvh1TLaGBX7oO1v7r1cMYE1aljaaCTmtYckKGdH1bpGtHjs3sc5IVqmFJ2rCSD4VM+iVFMqdT0hhhBdVkbZ+CEy8zm28vdpao6+2vRXFvLC78j17rhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668160; c=relaxed/simple;
	bh=7D3KwNWJoC6p1VF2zcIsFrvHRGbh4rZ3AUloKNQr7YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsRkCkkUyFbhlkMT2JnbHoSzPKbU5sDndgSzkjcHXXrOUhJaETRvIhf2NajpLk0WAU+YvuId9DBfRoGrlDgQc7hfpo2FdM2hWRgYn9FY5R5kqOPgbihyux4Zrtg+9ATYEwT3WdpY1Z0/FXGBXrBvvBUbJIEopIdlH5MUtWMRWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=38bzr3S/ reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ZK2aycwB; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="38bzr3S/";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ZK2aycwB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756669059; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=XTOQ9/bbRBmTKIaXSYEBEdp9Uyv1R7EscXEwjs/sOsY=; b=38bzr3S/wD3HjERLDEvayH7QFY
	Zcclm7rHpIlCkKJDctDBvHFbTdn7fh1zx3bEoUsQzcjXaUhGzSLWeCwcUDx4VS3kcCSLyMQaIbggC
	GDpWkWGMsGIbTTYY24pH7VmfB8Hb3qYC53qDDb/4J4NszrepF0UV4LHE8J5g7i3Ew/qFfw3kDfMEo
	AzC7BhV6jWzSIx16o1klPQuliYcY6Z3jh+7qbpqwtoS5A+JyImHoNFE0ke4J/dpDQx3ucp9gWHlDQ
	chL1yiJ33WWNsT381NcxUzfFZdmyTNaC4dN6nfjBFpC72Oxu3/R/GSunrrk9t4yPpbEh5PWB36U3I
	pxHlkXEA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756668159; h=from : subject
 : to : message-id : date;
 bh=XTOQ9/bbRBmTKIaXSYEBEdp9Uyv1R7EscXEwjs/sOsY=;
 b=ZK2aycwBzBtk3bplsnBvNcv7vnwQFZEJiJp4sFrrxxrMRHpzwyOPxcGegQX9f0P4ivdHc
 KCUd7uyGJUSMPCg1aCrca0TV67UNyVXJ+bbvUQ0qg+68pyuc+tVTo4BuIlhNsWL63yAOQbh
 cMEjoqxaXeEQQSq6cZEeUQfxg20CEGUk+RubtyNG9fL2dCoomXhc4sdoH76p5wi0uCXIEpa
 Ghagn0sUnFGZJ/Ifue8QSMtOjgVmT+PiGUz72CzVZkkXEJmqPIrpsFuNUP/cwehZkKXhsNB
 jYq/Y34aIldPZVVmkUVirhm+yVVdjRgjx7FXj7jIdDPwlcc5SA91RAfxCwlQ==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-TRk4XF-Tb; Sun, 31 Aug 2025 19:17:59 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-4o5NDgrhYfw-mjHk; Sun, 31 Aug 2025 19:17:59 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 5/5] 9p: Track 9P RPC waiting time as IO
Date: Sun, 31 Aug 2025 21:03:43 +0200
Message-ID: <cd1a0278bc06117a870fa7068228e77327a25127.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: GvaUTC6_SZEh.bVwJo6bIbXgd.Yh__SQ1Q9K6
Feedback-ID: 510616m:510616apGKSTK:510616svxP-T_CuV
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Use io_wait_event_killable() to ensure that time spent waiting for 9P
RPC transactions is accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/9p/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 5c1ca57ccd28..3f0f4d6efc00 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -713,8 +713,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 again:
 	/* Wait for the response */
-	err = wait_event_killable(req->wq,
-				  READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+	err = io_wait_event_killable(req->wq,
+				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 
 	/* Make sure our req is coherent with regard to updates in other
 	 * threads - echoes to wmb() in the callback
-- 
2.50.1

