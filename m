Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D02F25E4
	for <v9fs@lists.linux.dev>; Fri, 23 Jan 2026 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180781; cv=none; b=ZZU6fNP4VasPpMUU003mPTcAS9iym7+2ps06MK/K1N4ARMfdfK4CidGVLQYOfv74K3kaOlAkVf/Fp9xx7CEe0tjqHXQLK88KxSFOmpal/BzH8XPgKy3PXIv5E6//X0t+biP7sMMfhRE+8VO+8mLGQN2AXdWzKCMfNrvz2rFmxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180781; c=relaxed/simple;
	bh=XtiAGoBQ1blzOcjTq8pgxagTyavwnvETQwdQ0jnB2rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNRvVOEmD9JXAJSqbtKakzGUkxx+LjEo7BMsW0ri9HUmULSr9YpBycwbe+WJr8jsUZv2XpKBbWQH537/ZGOnkQWCnRhjVC1vg1AUiTovbUbb4O72zZnrSJvFrCBYhvmtsnkwcOkUjCmh0BJRZmPjD0ghwWMTR3JcpOuYDgyXjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=2AS9Mhjz reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=koDZOJc5; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="2AS9Mhjz";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="koDZOJc5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769181677; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=5hlZx6sa9MG8kpnxvIumfa5wATQurfzuGf1yx1tG58U=; b=2AS9Mhjz78ePn3WMtyJhB39VGx
	XA0lJRClr2OaJHAOANA4H/BG1DfWYlbmw1rd2zeSqjLw/TCz/ud/+ix+vgxLOhZoYmMZTllnMG6kJ
	h1kMB5Uukb1b7KoMudmGxIzbY4PDRMcWEO31i2lG9dTkqnplyzfnpr2CSPCNyksYLliaQg88NLxM5
	AExQ5P4fSk2yIewmZXC1X55crjjV6hEg7w5SqgFUE+t5WUm5qAQrvyTP3nm7Xx2XOEWd0vxaS8SyL
	1ERNj+vUjZ1u6SLdUyrHfhiPGHjnYv9cE9A1khNATunw5ExwSy+dqbmu1NRP8BViHy6wbEhMB2GrM
	sCafJb8w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769180777; h=from : subject
 : to : message-id : date;
 bh=5hlZx6sa9MG8kpnxvIumfa5wATQurfzuGf1yx1tG58U=;
 b=koDZOJc5JnECxH5p7vAWTpJb0gp+JWbgf7boSADxDC5cKimVTReabhp/ssU0V5Cf31ytR
 ZccJ0UxpSZxlP12fGraiB0gx9VODiqyL7a8R7LuOXMJ1pYbotCiHOTsTyg/sYOiHUxU1o/4
 oebt1ggWmmFVsbwglHDS/FfyAuzdZYl4zJwssrZpoVU6zZAS+QX5NDEhyGKAk9xrU+UsCy/
 aEN8LELwwVzDNEYPmunDWQ452zpL1Pp+/WyHGVVZaqRcjXKzuc2aapFhQNF+IPEGT0DK7+P
 tSy1X9kmV7ubxV/70E1AqPHO6GVZgloOWZsvrE0J2uT7zWi1oUoMzbd2b6fA==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjN-TRk3Nn-Sa; Fri, 23 Jan 2026 15:05:49 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjN-AIkwcC8p21S-ImA4; Fri, 23 Jan 2026 15:05:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 1/2] wait: Introduce io_wait_event_killable()
Date: Fri, 23 Jan 2026 15:48:07 +0100
Message-ID: <1b2870001ecd34fe6c05be2ddfefb3c798b11701.1769179462.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769179462.git.repk@triplefau.lt>
References: <cover.1769179462.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: BXsWhv2wVMY4.A_n7tFLvx5Lw.qKElFwi_Ehz
Feedback-ID: 510616m:510616apGKSTK:510616siuLes3UuY
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Add io_wait_event_killable(), a variant of wait_event_killable() that
uses io_schedule() instead of schedule(). This is to be used in
situation where waiting time is to be accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/wait.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index f648044466d5..dce055e6add3 100644
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

