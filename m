Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC8221275
	for <v9fs@lists.linux.dev>; Sun, 31 Aug 2025 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668164; cv=none; b=l85+z7VAUyHPpNvWf+StV62l/nAYNxd8GLyUOdKhQH8q5bRVmLphq1bVj9yNOub3jiQHOdXVDZH32PMV03QvSZIBarFCS11ZQ9Szdw5vaqcnoR3Ev4/4PCLPzrno6PJ8PexUVw1jxWVtSUszEjcHQiXtTCMYZ7AIflOHZtsEq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668164; c=relaxed/simple;
	bh=ABm7sCuXnVGTUvJ3oYj/x/myV+euHTB1ShT8xKihbqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1AlMutOsmf1XdkSDiP9PBfvBsXsMFz2DOFV4nJXOrnIMIxVqnDJ85d+0GgBtifEPYHlP1ZH7OFMT9fWxbUXcsWCe8Kyx26rwb/CMHtgydfBC87wDB/he/1lQzBWgGq8LxanpidMxlNh7XbkipL2QKSDxyTTvOwFPcB3MAwnLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=H+4aI4VA reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=lgklAtfe; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="H+4aI4VA";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="lgklAtfe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756669062; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=ZQf10//JpnrdeYz7kQCzI/aqQ6NoOTIPSKaQVv4vqlM=; b=H+4aI4VAUiDFnasDc97Y3dO4Mg
	+HjowSgL8pPZ+nGSn+eSu/sUBCE/y/+W7n9uyD/gGCHLQe1A0lqUYZJmKHRNjzQlT2QMdk1goeylk
	yNhcJoiLclmnmc2fzalzcoI7qOhMwmKJafch7X+6dfcInic1zy0cPKICGe3rjcVD1FuZO5m3OdouA
	lt6KTAsv8dvudLYWz54475kMqHNEUI7r/zUmaaRtrQEgx+Xw/Bki36aH1rlusaYLyvHS8vzZ0GVOW
	dtw7BTIGN/zs+xSt6Jlgh0sidGhBHTK36aa2V3dErgbDyO1FmijoLJfv7rpZ6uh53F41V1LqdVZg7
	lHwFBRQQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756668162; h=from : subject
 : to : message-id : date;
 bh=ZQf10//JpnrdeYz7kQCzI/aqQ6NoOTIPSKaQVv4vqlM=;
 b=lgklAtfeGMPhTujcI6cQcI8Hfd3B0JhkhU4K9BSKQLili+kv1bkWyAD67e87G5lzesxH4
 dgazl6kx3AVhASagnLs9FgBFO3y5SFuwfJGyKLsbOX5L6NblIcyqeVVN3BJcCvp1mAucupa
 HruT2/HRyUuf2rzVVYjUGCSu9fedNU0EDMM1VhGd3dcUY9uFGcyBsdr5SWgozOLoeH5Y5rE
 8PrOKYa3o7fOMA1ODkTG1kaDW1XgdrwPNxgn0bSKeUomRK/SqrsK5cO42qfNK/QOwQrr+UX
 MlnXrfHoIAAyjXb30UK3BZ2PR/4DyS6sQsOBsqfMx9rvpi8ZLqvwgAmZnV5A==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-TRk4VS-H5; Sun, 31 Aug 2025 19:17:59 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-4o5NDgrprk4-pPNu; Sun, 31 Aug 2025 19:17:59 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 4/5] wait: Introduce io_wait_event_killable()
Date: Sun, 31 Aug 2025 21:03:42 +0200
Message-ID: <370180ef235d9e183c93bfb9677e8a35e4ca27f2.1756635044.git.repk@triplefau.lt>
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
X-Smtpcorp-Track: J-b2j_RlUnIH.ihNJeBlD6YMg.FnJHOg9Gas9
Feedback-ID: 510616m:510616apGKSTK:510616s1xwnvTvE6
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Add io_wait_event_killable(), a variant of wait_event_killable() that
uses io_schedule() instead of schedule(). This is to be used in
situation where waiting time is to be accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 include/linux/wait.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09855d819418..cfeb1adee973 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -937,6 +937,21 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 	__ret;									\
 })
 
+#define __io_wait_event_killable(wq, condition)					\
+	___wait_event(wq, condition, TASK_KILLABLE, 0, 0, io_schedule())
+
+/*
+ * wait_event_killable() - link wait_event_killable but with io_schedule()
+ */
+#define io_wait_event_killable(wq_head, condition)				\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __io_wait_event_killable(wq_head, condition);		\
+	__ret;									\
+})
+
 #define __wait_event_state(wq, condition, state)				\
 	___wait_event(wq, condition, state, 0, 0, schedule())
 
-- 
2.50.1

