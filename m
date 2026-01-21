Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1B346E59
	for <v9fs@lists.linux.dev>; Wed, 21 Jan 2026 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024438; cv=none; b=MUCSo2qAIZyxgKVk4F3t6ACBj6Dk/hm7wyuHM8z6JNjTa5bsVRyLVQnxuK3ODMW/nbDwNgN+uwQl7NcuiTadI4u8RYq78Dd5ydDa0mZ88IvcXetUe/7NptPuBcDtV9tQ/2gNTRfEpEX9mXnwzlI/KIMhRdKC2S93mj1exFTsx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024438; c=relaxed/simple;
	bh=S3hxWCQPMT8XIQzsU477HCdlF2KOvOQcuSSHK1nzbBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMD5BBJ9w7st0dcFW25hLPyYS6BchbXDQJVpuSMD1wR1NysQCHo/O6i8h5MiJIbzrnbMWiHWzW8YaZmoJmEbsyrLL1+M1XzdgHEySsszTuCFFujtNrrtkz8l2znHsQ9lMGK094uOU6fkac2SuM+zZzfVtjnJB519Q25vBHWGoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=fho0111T reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=dLJq+w3S; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="fho0111T";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="dLJq+w3S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769025335; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=/OSCX664UbG6WyfoVOW1dP6q4L9KvL6tcvUejq4tXGY=; b=fho0111T5bnRtCG9YmjD23drF7
	de+tsC/ckfkCXYL0M1CrkHXkaiX8o8YLQrryeB8lXh89F84jPXibFGZN83XjilMsoA8HK9Es2iY7h
	Iue5DlZodxUqGW56HExGP5GtwkkASDttl25A2BGKQCe9c+DGqrQxEOGNRTpZLI2i5pLwbFxCl3Vtk
	7GcCelcf10TSCHPYoqTEHIx36TsSJxAi6vKbgU+3kDcmBLWzcT8HUf7LqNcXnLxovF6F2jDb/XYRo
	Dro3UMaYGi/z+36TlPCYVVmC+FR+o6gqvmE7jdUkGqV70MQ+N3UZ/WPX1XpObNa4gFk1P2fVi5LzQ
	U++pqQaA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769024435; h=from : subject
 : to : message-id : date;
 bh=/OSCX664UbG6WyfoVOW1dP6q4L9KvL6tcvUejq4tXGY=;
 b=dLJq+w3SjMhPdsd3Xild/QFlop6I7VfIbEPcbPYpIOg95hSLWIn++Vx5e+j5ZSSE7vuiG
 kyRXvo32SuEsIeYli14tWFRgzDOU9QYekbbJrTEd1eEy6fi7CHZQtzQKU/5u69w0m0AQGDJ
 FKOgih7+vCm4XVAC5PflrhwNzzIYBvZjYvHNBHF7rf+KWKA+jim0XHu5hbeD/TtrQfeAyA2
 R1C7jlhuOi75+Df4FtjGQZcJkVMhaAxODHx/vPejMQDKgB4CJhOJ/bavY6Jd6Ouu1J0v7N7
 C9Nb7QuxiQN1Oc1ykzpK+/pHfTK7oQ0VIwO6ITHuey+qdG08rEISF30VpazA==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3n-TRjx7e-LU; Wed, 21 Jan 2026 19:40:11 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3n-4o5NDgrkeP7-lgVq; Wed, 21 Jan 2026 19:40:11 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 2/2] 9p: Track 9P RPC waiting time as IO
Date: Wed, 21 Jan 2026 20:21:59 +0100
Message-ID: <47f0b44f159084f4032a9424e0e2e586b8640a12.1769009696.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769009696.git.repk@triplefau.lt>
References: <cover.1769009696.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: C9deZWzgpoQ3.Mz6NMpQoeAQw.OvVRrg8sq6S
Feedback-ID: 510616m:510616apGKSTK:510616s9QkJ0c_51
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Use io_wait_event_killable() to ensure that time spent waiting for 9P
RPC transactions is accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/9p/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index f60d1d041adb..1b475525ac5b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -590,8 +590,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
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

