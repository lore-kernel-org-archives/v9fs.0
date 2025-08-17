Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFE199949
	for <v9fs@lists.linux.dev>; Sun, 17 Aug 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755448930; cv=none; b=UCgItI+9s8yug0Lw4loZsik1an7iZ4f8yjfADrdXjIWRB3SCm6n+OjgUCIeMfySF+hS9iIr8gjgWDXhaFqZJsg0qodb8O3PMWHm2KfTaf7iMIU/cTBkEK/fW7GX8Om0hn+bFO3MksWyLHP+5IsYgU9oBwa6UIyW4heQXb8stJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755448930; c=relaxed/simple;
	bh=+QBR3qdBitT3XtY+qZlKbkh355Xw2vzLzsBzq+IArns=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q9iCBmHt1jsvz3zDpsPmspwrDlpWxpqpC1j2OnNxkgf4DQnCx/HO659Lj0X+r29Z3f20lfzkT5tFrVjDLwSwcE7Tr8QTdPC1J4nLTQIw9kJXj+KoudtNMm/gmiQ3eNCTdyCr8Qd6p7eEimtfTCrp9VER/tynJBlI4n636KTGcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d1WQYdCI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d1WQYdCI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=INlWQUuAbHwdBT51OHQ/0w7vh6GhtzwyAto6IvUx6Qs=; b=d1WQYdCIH9TOIoydQljSeXsHoW
	rUB7ZNdxeKKvM1wTxUL0Pc3uajKR5eyHa9dF470If7mOSsV0SXCDtcR5wzdKAUDhJndZav+Mhv74v
	4Xxqp1OJ9ZQuTT4fdyzvgffLk2ej1smzlY2PV9rXZkB4fWq81BXaBXRYVMlMALXtMlM9pmw3yhmhB
	jFPamTgeerow1CJuMfNtFNEfHKHTI3xMVrfmgl0xcrGVU3iFs03hkxCW18i6f+5WXvhUyHl//f1SR
	hgYG1Nf1Jj8TuwTtr/h9FvmJEiLKquXpWml8ql8zOTNTmd2RCCl0Ew0x5d6r/CsCOZSWStABTdD+E
	lOQCyGug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ungSM-0000000Ak1C-1eG9
	for v9fs@lists.linux.dev;
	Sun, 17 Aug 2025 16:42:06 +0000
Date: Sun, 17 Aug 2025 17:42:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: v9fs@lists.linux.dev
Subject: [PATCH] spin_lock_irqsave() in p9_client{,_zc}_rpc() is bogus
Message-ID: <20250817164206.GW222315@ZenIV>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Both of those are blocking; they can't be (and are not) called
with irqs disabled.  So these spin_lock_irqsave() should be spin_lock_irq().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/net/9p/client.c b/net/9p/client.c
index 5c1ca57ccd28..b708c6ba6b98 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -675,7 +675,6 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 {
 	va_list ap;
 	int sigpending, err;
-	unsigned long flags;
 	struct p9_req_t *req;
 	/* Passing zero for tsize/rsize to p9_client_prepare_req() tells it to
 	 * auto determine an appropriate (small) request/response size
@@ -746,9 +745,9 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 recalc_sigpending:
 	if (sigpending) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
+		spin_lock_irq(&current->sighand->siglock);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 	if (err < 0)
 		goto reterr;
@@ -783,7 +782,6 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 {
 	va_list ap;
 	int sigpending, err;
-	unsigned long flags;
 	struct p9_req_t *req;
 
 	va_start(ap, fmt);
@@ -831,9 +829,9 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	}
 recalc_sigpending:
 	if (sigpending) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
+		spin_lock_irq(&current->sighand->siglock);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 	if (err < 0)
 		goto reterr;
