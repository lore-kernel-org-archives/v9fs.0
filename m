Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8F390983
	for <v9fs@lists.linux.dev>; Tue, 24 Mar 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366239; cv=none; b=RVAYwekAxs+l9DdPiSXlpzd0Mr/804E2wGMtOfDHwIOncxf9H0vl/e7ykVwVazgy4ryhgex9wqQ8nfFT3ugprHyQaXMqrkotgbf/SDY4ObtoD+JlPi+894zJaZiF/QXeibcyHZZ75fHUfAVtymhAXwh6i1W9e4MpQnqi8aI3gLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366239; c=relaxed/simple;
	bh=dLAX/MaLMsA55bQXtSczaYIpJZHd96/3ujOVO8C7BxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJlcohEhflrROTz7MWOoWmcKZVdipjoPBdh62YyC0emP37UUP284oUnyXDrh4wNr8I2clzl1aml3r11r2EZ+B3JySgYR8Dz6zApi1w29d29ZjgchEnu0zTCWkpdPLui0J8gb1MeFsNYeTi03K8WpgMLGELgcg6sGBJjpYl/GrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2Bqa/Z1; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2Bqa/Z1"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2c0c955a481so5754226eec.1
        for <v9fs@lists.linux.dev>; Tue, 24 Mar 2026 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366236; x=1774971036; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+MnIitRRQp1/N0eopQVQ2cUe8bKDReL4QPDo76ZT4M=;
        b=d2Bqa/Z1U1x48Z5TcBNKOH1GpJp2qFl/GC374IwrOZN3MKoePkDD8D1/OgZxYoSXxp
         CcOGCTV4fTWFa63xLmeUsHZNQ8SvkR4tctrSCE+cTNBZ47FMjsm/APL75Gp+Qzg1gXId
         noo2uvdfxH6ZkWzDyIipapgDCpUbQ68DMl8g3N4fOs41GV2HifsxbpuMAVB00BrZkF5C
         p/4m2JfMlx4w33dFeGWks9QBRzkmdFR/SGY91xoFvRmQi0dujPYo7RUkFROWhAxL2ttN
         r2M6ZXRw3XePzerELNJhxQ0C4vYpOOzxMOOg8MEfPCMywhKU6CpiuC4xfh69cC+ExqjA
         lbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366236; x=1774971036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+MnIitRRQp1/N0eopQVQ2cUe8bKDReL4QPDo76ZT4M=;
        b=L/bwBFzrXhEfFk1pCm+hIx9DjLq//IjmtH3ZURiplc5ebD4wqB2UKmegzQQbiKiWcX
         BWmewQ1kM1C0V7z75RKeeaImghkq9X1igFgirU5Kyc0BvTAkAxn5w+8WpUarpcGEgoRW
         DEheY8e8FVADef7kW3hSk+uKddoN9zRhdGAhc9xzi35qx5NNzVw1JnOuf2/YIHgcfiQ1
         b7lcFfuK1/SQWL6nOgAdDvdclTPQYMr9YROSTRJmBa9JAe4ZJARw8P5AxKYtR+LuD8Fa
         zl3BBDHf1VQ2wc9TpVKA5zzV5q2+kmBktTqLRQISIQNmlGv/ntXcAHlyMm5A3Fi12am9
         vBZw==
X-Forwarded-Encrypted: i=1; AJvYcCUma1HGWFV4scDFcJPh0ANeV3wO1LrbnTbWIUtgR3h6xEinq4exPaCzJaRk/MhsEtfsvsab@lists.linux.dev
X-Gm-Message-State: AOJu0YwEEqzVwQ5u30n4LOol4AHuAY74DkI/XcfX+xQomQRhcWepMdwW
	/F/XDJuVWMdWd7vWDv7we2hW9FvbBNfX6qFQOytj3EG15ABYb8cRVvFr
X-Gm-Gg: ATEYQzzry2RJqHpFmABvvetcxNyLEQbVavAPPWbbvx2JqstQMGdNQ7y080Yxn6+59Ha
	bx92jTWDXIgDsIyazzSzt0iKJUa3utHxMbP+H4WonEEuIqyrWFEeQCrRBI43txzIy5/9sImn4cL
	csrOXrrGUNw9FLFiu0giIWPBXxpiHGHJxvkjXz6BENe/RjMsYTIyNYaK3ibkdAdDCJj9vmiMDti
	ucUwsAoBVzZ7GlsdA2NSB5fcKAWiy5fIRKV14zgJ4wOkvU8DQoXeQBVxYjrpqka2GjsF7EWbfD6
	uTFX4yJK7GXSX8s3eZDUOkwsS+SeimTs1urzSvEwGCxxgOIiky5o3t4GdOU3SHcgDk9wHtUa752
	Z+sJNoOqulwXSqTPZx78djE0EcwsuolQh/UEBGOS1wIqfTDBkEiugcZ4Rh1lW5TECzgmxwy76a5
	JRjop/Jg59tDT31Mq4EgxO0yru7U8nbh04TJVGMwz9p3hVzvMREATF+ASj4BIPtX3iGJUeRA==
X-Received: by 2002:a05:7300:e2cc:b0:2bd:d04c:a430 with SMTP id 5a478bee46e88-2c1095fd85dmr9074373eec.12.1774366235748;
        Tue, 24 Mar 2026 08:30:35 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10aefd778sm20842577eec.0.2026.03.24.08.30.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:35 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: asmadeus@codewreck.org,
	ericvh@kernel.org,
	lucho@ionkov.net
Cc: stefano.stabellini@amd.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 2/2] 9p/trans_xen: replace simple_strto* with kstrtouint
Date: Tue, 24 Mar 2026 23:30:23 +0800
Message-ID: <20260324153023.86853-3-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324153023.86853-1-ericterminal@gmail.com>
References: <20260324153023.86853-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=ericterminal@gmail.com; h=from:subject; bh=J10JPVWKsVQanKp923Zl9fUFEZ4SGvBX5W7Guc7pfaU=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqslevn97QnFyuvcPn1zXGlx4gPn3kMy/Or7fxctP Z0Vvjz1YsdEFgYxLgZLMUWWu//3zc31ujXnOvfhXJg5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ z9BIx0DHmIGLUwCmuleMkWG6nuTemQtvls2KNlu8teHmHK1NpntUJ7YzV61g3WjG/esHI8OBU0+ Cpiiy/2YI0tP9fEI3+rawbHSSw0HL42brpnN8ecUGAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

In xen_9pfs_front_init(), parse the backend version list as comma-separated
tokens with kstrtouint(), keep strict token validation, and explicitly
require protocol version 1 to be present.

This replaces the deprecated simple_strtoul(), improves error reporting
consistency, and avoids partially parsed values in control paths.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
v3:
- Split from mixed series into a dedicated 9p/trans_xen series.
- Refined commit message to focus on 9p changes.
- No functional changes since v2.

 net/9p/trans_xen.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 85b9ebfaa..f9fb2db7a 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -413,23 +413,29 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	int ret, i;
 	struct xenbus_transaction xbt;
 	struct xen_9pfs_front_priv *priv;
-	char *versions, *v;
-	unsigned int max_rings, max_ring_order, len = 0;
+	char *versions, *v, *token;
+	bool version_1 = false;
+	unsigned int max_rings, max_ring_order, len = 0, version;
 
 	versions = xenbus_read(XBT_NIL, dev->otherend, "versions", &len);
 	if (IS_ERR(versions))
 		return PTR_ERR(versions);
-	for (v = versions; *v; v++) {
-		if (simple_strtoul(v, &v, 10) == 1) {
-			v = NULL;
-			break;
+	for (v = versions; (token = strsep(&v, ",")); ) {
+		if (!*token)
+			continue;
+
+		ret = kstrtouint(token, 10, &version);
+		if (ret) {
+			kfree(versions);
+			return ret;
 		}
-	}
-	if (v) {
-		kfree(versions);
-		return -EINVAL;
+		if (version == 1)
+			version_1 = true;
 	}
 	kfree(versions);
+	if (!version_1)
+		return -EINVAL;
+
 	max_rings = xenbus_read_unsigned(dev->otherend, "max-rings", 0);
 	if (max_rings < XEN_9PFS_NUM_RINGS)
