Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56F7182D2
	for <v9fs@lists.linux.dev>; Fri, 22 Nov 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286885; cv=none; b=bPmMTVtGJ5LG3zZS2M843cEEem2R8+dQ22AF3f9ZzFg6C2m29mnFga1pRDAOlSiwcoxQVbdCOCONPbbg6VzZZpCWVVttP8z3dUo646dTf9ZPevDg4/ixwEHP1O9rJNHp4+Zh5ijVFdHJ5K5dpn7eM+NbvXRidnVm6r/KXdui+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286885; c=relaxed/simple;
	bh=k0DLlJF5pzxf+dcq5+CjwFaUm4bEs1VCSTahRbdTxzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0hVyPHs9UohRIkyXBXscyutma2Ut36UtFnSipMtn8nVzjaHOl/3+jgOrxgAHi1OJmvHL23ltdPqgTherywKjdISbfOiVl6SoYHQ9LRbknaUGEqz8mfrxbeQ3V5W7zcdLuM6/xZJsVAX903lXyI+vW5+RMf/8ODynpL2VebD0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=uzsdk1BC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="uzsdk1BC"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 81AC914C1E1;
	Fri, 22 Nov 2024 15:48:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1732286882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mChST4oG1qTA4hRQNt9WCwIj728ndP8rnvxu0Kdgk0c=;
	b=uzsdk1BCqr8wi4Znob9ds8rgWKsF35V8cYc2KSwskhfEQVCSDP5GHszd/jnUzlDbvHv35A
	t9u1VfavpoObfmRMzbA5x1Rg978gWAkni68kGVaAzteuLZmY16NElhXwqOrjYvPtlcj8Ni
	naHZh4Tu+mIZMfioCjj9QCa/f3AM7SzjVVeW0yPJWtfT9vHVCbr/v3zSPUATZrJWxmmCDk
	714y9mp3wIJrm+yi7dkeWMXQOKOs97xRPx6mZUa9r1FEAo6wNLuF0/EeAhQcSGxVmDKPUV
	2x790r0J8VkZx7vwMCzlCCER8CTJPKE7XOWcblOR7bmXwdxESi0BpnSZZY+Nyw==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 837d027c;
	Fri, 22 Nov 2024 14:47:58 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/9p/usbg: allow building as standalone module
Date: Fri, 22 Nov 2024 23:47:51 +0900
Message-ID: <20241122144754.1231919-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason only the usbg transport would not be its own module,
so make it tristate.

In particular, this fixes a couple of issues the current bool had:
- trans_usbg was apparently not compiled at all when NET_9P=m
- the workaround added in commit 2193ede180dd ("net/9p/usbg: fix
CONFIG_USB_GADGET dependency") became redundant because a tristate item
cannot be built-in when its dependency is a module, so we can depend on
USB_GADGET "normally" again.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Link: https://lkml.kernel.org/r/ZzhWRPDNwu225NWz@codewreck.org
---
 net/9p/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index ee967fd25312..22f8c167845d 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -41,8 +41,8 @@ config NET_9P_XEN
 	  two Xen domains.
 
 config NET_9P_USBG
-	bool "9P USB Gadget Transport"
-	depends on USB_GADGET=y || USB_GADGET=NET_9P
+	tristate "9P USB Gadget Transport"
+	depends on USB_GADGET
 	select CONFIGFS_FS
 	select USB_LIBCOMPOSITE
 	help
-- 
2.46.1

