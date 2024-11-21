Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE81C9DD8
	for <v9fs@lists.linux.dev>; Thu, 21 Nov 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229493; cv=none; b=c2y8n1VfQyCyeT/2gdKButn4DDrVkLaWOFAZki/MP53LoQeyP8eXUE6VQ/Sx6q2bR4ml8QY/xmQ875MkCpFS0xymzAQAmRoieY59hjrpSyNMfjgkiygD/9K0ocmNs2IY/yXu3LoMlh9sCfRRQmlnb24tYRx8qJ3xIXH3EsvgSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229493; c=relaxed/simple;
	bh=ssFA86Ebsud+qwvD2MYa+V+ZiLCeYzL2g4M04SUXcw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N74Fj16d9ZP2A+hDt/F3YLfypUb6ZYc2+or7Vhd9alD43XASDcBmXkpNhikCFTL+DKP4FlswQudL0MJlm/KJxow14Ehjq2KlfkUJ/5tmqMlg+TKmfP4EU09ytCexi6WzsnV/4Gt0pXVYtKF1XTnBfemKz1NDeU9Cmun1pJyXmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=edera.dev; spf=pass smtp.mailfrom=edera.dev; dkim=pass (2048-bit key) header.d=edera.dev header.i=@edera.dev header.b=Ih3+AOI9; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=edera.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edera.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edera.dev header.i=@edera.dev header.b="Ih3+AOI9"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ee55fa4b31so800610eaf.0
        for <v9fs@lists.linux.dev>; Thu, 21 Nov 2024 14:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edera.dev; s=google; t=1732229490; x=1732834290; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M5KMmAvOf7yexbO07PqanGNRWx1lbfxWV65SvdMYhlY=;
        b=Ih3+AOI9EPxF7vwVtzN7FP9UTybDENg3bW3DyGD8qyB+SzNbeGXo4TduVOUEsS4MVA
         JnDjdscI081BYJb8Wi3AuRN8KfzXiCt7jNDJlzOBrMD9OQjN/2pfspwUYITbESCQSWJ6
         BJcxLgnudjvhWDzvE2a1FR+fZWCxN//grRG3VMayZlWWlXAyIczmABOA6xpzV8ZbVdy/
         LuTCKF4H1WfpqrcGEsxwro0+uodUFJDO8ewasTPSoGQqGi0mzr/Ap6X/nFYM+YDx/LzE
         cnAE43k/S8odAehuqdL1PE73vwBY6mqF7Y8YHwdKaNSU0k8Po/ozM7PO8QT34ap05QII
         fgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732229490; x=1732834290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5KMmAvOf7yexbO07PqanGNRWx1lbfxWV65SvdMYhlY=;
        b=XMEdRo5ypgHphQ18LcCm6l5v4dyy4G9ZOvhKMPtj+tWHV4D28lMnTYcfOsbjIlfaGd
         KH3Q8zLGJJanxjcHE/nN7lmQg7+7poTVv3hOx+03jG9cGgK5036+/Ylf+Gh2XGpQO9oL
         hcl9no5tF4U8Bp7qxDCyX2b/0p5Ek3t69WgMdgx/p1vMLvSVEKPHgt6c541ZG2D6yOtf
         FB68TEiLsqvy5MjJyMMpqqIX5YzamCWQKHEtM0ngl0z8hbvR9j8nBqPEcuB796j18If7
         y+TChuheTwZGYimMrxUKXgia9Ibjq6OIZQ18Yb6ePIyZ/q8sehxqLqHTPUQm0FZzf11c
         FQVA==
X-Gm-Message-State: AOJu0YwXNOSqRWp+jcukx7CQeKlm59QU9th98Ri9t0YSRZIkI9RTtnM5
	Mh6/TV0uYCfvYM49FyTmrX+k/2EpURG8kopsxcmV1J2KaJVjtrtzyxiE3AxVrikbLf8AmcShq2d
	u2zQ=
X-Gm-Gg: ASbGncuSc25Le9GkPxEHztBkbM6kUIz9Jh4yZ831Q2e5/TfLvMT6aaUveGj6BROx3Dr
	VeXgTeRW0CQC5YvRvl5E8E0SgDpaQK79/MbtS++AqvEdA2/oMsSzSnLE+4IEBkl8vXPAotVrCv3
	Mde10vTPyjcioU6MJjmmjuB/EJKbP1tHlPccvVx2GfGkJIA0ws3nT15fOxypciBW6fw8hx41PSB
	ot7IsYtvnGo5aCEw3O446K4FirafJToym9Z7w3Ic4phRMDxmWFWjE2hmztSs3D3w3AKNi51YiE/
	FdBjGjVaOJPbkRqUH3k/xbC9HgBOQ3uJar429FliDYn76DGZIQZXT7+fvv7W7afUdq6OwVw=
X-Google-Smtp-Source: AGHT+IHRfgZ/zJdkaYat35UYAnjiCdb2X4OLEmzJdr9rSEx2OpMGZ9tm7YvUi1s+NAeKvDBAkLpcQw==
X-Received: by 2002:a05:6358:c02a:b0:1bc:7c1c:9fc2 with SMTP id e5c5f4694b2df-1ca7970dff8mr121232955d.6.1732229490351;
        Thu, 21 Nov 2024 14:51:30 -0800 (PST)
Received: from ip-172-31-19-182.us-east-2.compute.internal (ec2-18-220-54-129.us-east-2.compute.amazonaws.com. [18.220.54.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c3ee43esm4203971cf.22.2024.11.21.14.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:51:28 -0800 (PST)
From: Alexander Merritt <alexander@edera.dev>
To: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Alex Zenla <alex@edera.dev>,
	Alexander Merritt <alexander@edera.dev>,
	Ariadne Conill <ariadne@ariadne.space>
Subject: [PATCH] 9p/xen: fix release of IRQ
Date: Thu, 21 Nov 2024 22:51:00 +0000
Message-ID: <20241121225100.5736-1-alexander@edera.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Zenla <alex@edera.dev>

Kernel logs indicate an IRQ was double-freed.

Pass correct device ID during IRQ release.

Fixes: 71ebd71921e45 ("xen/9pfs: connect to the backend")
Signed-off-by: Alex Zenla <alex@edera.dev>
Signed-off-by: Alexander Merritt <alexander@edera.dev>
Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
---
 net/9p/trans_xen.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index dfdbe1ca5338..198d46d79d84 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -286,7 +286,8 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 		if (!priv->rings[i].intf)
 			break;
 		if (priv->rings[i].irq > 0)
-			unbind_from_irqhandler(priv->rings[i].irq, priv->dev);
+			unbind_from_irqhandler(priv->rings[i].irq, ring);
+		priv->rings[i].evtchn = priv->rings[i].irq = 0;
 		if (priv->rings[i].data.in) {
 			for (j = 0;
 			     j < (1 << priv->rings[i].intf->ring_order);
-- 
2.43.0

