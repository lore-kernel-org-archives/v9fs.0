Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0933EAF3
	for <v9fs@lists.linux.dev>; Wed, 21 Jan 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025140; cv=none; b=fnZVOND8Cq50ECwde1ppPNLvmDvAadr2Rykz7OvXI4nuKlYcmMK24Y7Z6TXVoMLgYLp6/EbUzun/Q+NfLspRzUaDE9lxtkfb5D77EfMsN9sSRCgINGvz6bhyxlN17JbZxXbeVrnbtf3VnWVMfQ57zxMT73+XoyMYZ8K1u6uRLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025140; c=relaxed/simple;
	bh=xWR8+2wGjm3ruZk2p6dj6phIUu2lpRDLViyNPoYkxoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QofmswY1wcMDnQs8Jf/OjB3RZZyBZg7zzCMPZW2KFQ6I6VAUMPX3+3K4xcvyyXh0iCmc+hrG85faky2rgcewAryvqP9eJtI1G6xT+18yIO73ll+w7Hiuz4yv5wyz4FtNfFwLaEu3xwVnYmbaWONYj/HZf7Li9kP3kBjRmrjUP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=yQpq2y30 reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=logFWy5M; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="yQpq2y30";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="logFWy5M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769026037; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=4cFXi5ffTlofjVqYriSS7S+dg6PFnmAY2IZAHb9HavE=; b=yQpq2y30+kxBRlu0ssclUgRMdE
	Fdzao4bHeMUGhXlr0B/BUDQhlE7NMJFLbXXyomckElt7RbFPIz6iw7E8poevbpjH0/WopsHOm+g8F
	iWnhXLKNvv9ue9vLcdp/HncrtGfJbSdpV63LtZ8aTdUBN9ISFQB/cVCJ7EBhpfzwXiSQi73C8zl1F
	KCjl3mSEHWULwCC89Tgs/BlOyi0f8gpr2yyd2Zg/UD0V0LawggdJBDLT6dswqdJLqtDJBRfrQmwYV
	kUwCxNwIniDPr+QSYLlHZB4MLJo6yTnja2B+yJAPv/fqJ5DMNcFaEkIX84iV0S19fl7h0hym7udYH
	uX3tasUg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769025137; h=from : subject
 : to : message-id : date;
 bh=4cFXi5ffTlofjVqYriSS7S+dg6PFnmAY2IZAHb9HavE=;
 b=logFWy5MN73tRPHGnI7q0Is3LnbdZSz8lYFvV/0IEx6RYUjZNujs+lKugIw2Ftigi4ZrH
 0p4REQfQTUWwV82CRA2Kj/ToE7R+vGSBFXLdr7WlCobl6MUbo3+1VHS7+6n/E5jjBz0+RUo
 K2IayeSIw6pz5hsJvDqrmmdpryzHLs/7athNFqH9i5cnUO6cDl8xELCxZwj0f2WKJlQvuOx
 CVKTLQF8nGCN0IKfhIa+n4DdvdrFUxIPfwWf83sYYaXbD3FZu2D8VvUe5nyA/EDXhuwVWOP
 1N7VJOciMxO5I74WXH2mB+OpXuSuvwu/GpS08isgfBFs8yTAeas1SI0nt5yw==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3f-TRk7G4-Ax; Wed, 21 Jan 2026 19:40:03 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3e-FnQW0hPpU1x-o72R; Wed, 21 Jan 2026 19:40:03 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 1/2] wait: Introduce io_wait_event_killable()
Date: Wed, 21 Jan 2026 20:21:58 +0100
Message-ID: <1b2870001ecd34fe6c05be2ddfefb3c798b11701.1769009696.git.repk@triplefau.lt>
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
X-Smtpcorp-Track: x3KkZeVspepo.cq7R2HKIi8Qe.OzF9YwZfehZ
Feedback-ID: 510616m:510616apGKSTK:510616s8cjAlH8hC
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

