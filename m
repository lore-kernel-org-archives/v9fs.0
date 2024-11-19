Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307C156F4C
	for <v9fs@lists.linux.dev>; Tue, 19 Nov 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732051011; cv=none; b=ToC1LO4Gqmwt6KqSU7F2uQlDHpjVKnRDPukVfwMsdO89mpTLj2vppeaYhF7p67hYEI4EWrybHnr936bUXvdomPrdzWRowTITqz5ZYEzPoC+3CQSRBlVBoYC9cEIdNqdeksfmqzZpmIMG6FVmDp50nxTzMYuPQkFAbMo9qg2u/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732051011; c=relaxed/simple;
	bh=11+Sy7m6oTI0vrvYq2MPsw+viVG+AnDGVAxeGecmcew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAPIxLNlXHuF4+WremANE4c7BTcOZNjBDRnSrkIhGQ2oiUlINpUQh7kTcLXEhydaHeBH9FnvzuAMpQzubPMJdyrRFpcI4FIMWDBPQr3ja4RoT2JF7g8aZOqnWOLAsdnNVENCjKOhaVZ53axvEYDWnYkSCLLxdhIUCseKAlSbc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=edera.dev; spf=pass smtp.mailfrom=edera.dev; dkim=pass (2048-bit key) header.d=edera.dev header.i=@edera.dev header.b=K3E0P2Sy; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=edera.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edera.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edera.dev header.i=@edera.dev header.b="K3E0P2Sy"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d382677c92so26448766d6.3
        for <v9fs@lists.linux.dev>; Tue, 19 Nov 2024 13:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edera.dev; s=google; t=1732051008; x=1732655808; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg7OcnGXpKtgXWaHwtGS+ToZC8TTTiMcCPq5ZYxyLCo=;
        b=K3E0P2Syb/DcGp+kKDQFBstHOTy1Ad8ZXGdBgTb9k1CpwQ+k0mgajRjoYv/K+TInOv
         YUGBCc7ueMe7PSs5JDf5ahyc/gUw55OFYxerEKUSSv6KIF0hH4OhIQGKSSIzW0cQ8ly6
         XHntkONYrvT9c/2CU38iaCPP065MCcLSluFQ8VcsfF/V5YstDJoPS3QcxxUJtb+nW+aG
         05E4B5Ok4lD8QgqrfQ9DeHo6LIVBDu86Df8MNZ/bB1N0QBZppYaR6aD+yZ7a/N6JGlgS
         8eYSrdfNvy/9qE+5bTiI43PykYds3nAA3pZPawIix8dGJhpoSugirXMmaYYNK7n63X22
         U/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732051008; x=1732655808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg7OcnGXpKtgXWaHwtGS+ToZC8TTTiMcCPq5ZYxyLCo=;
        b=HLDeI95vMbWDUm/HHjOYmOmKgtN6Xt1odHSnwK6wvM0F8XCz3r7tkSFlMQ1MPl2oUn
         LZE6a2mr8TSJpOYonGBk2v5zcEfk5SypqwKkw1oXoWKj/QzzP89xEkwPlu+F3KrNLPWq
         +wNRwxVm32hOoNZiTpprSbVRmY4Lea0Aj1JVU9vThdu4bEFr0vaX+9TPCWxdsky/gbRy
         iNiM8l0vNGngWLulcFOImwIXvypyUuIyeKERcoAb+KongcGxD1iGozkhedvzwWC0itpU
         EmOx7zthbqnjprq3P3TzKhThqXFjHDsSXW/3kvxVSvOmPziQEU/1OV1XwvwjjQg3r6Dt
         9O3w==
X-Gm-Message-State: AOJu0YyE1qPtBuoF6+1BI7/ozlcaXGSQZcdh+2GUE3I3iAHByEh/bM6f
	CGiY2YlHlGPzdKlKdkDQiEz7itD+HAOzgfslcY4PLqjuORVZ6YfZqB4XUb+yG9wa1iQGPS2aATJ
	i0jc=
X-Google-Smtp-Source: AGHT+IHB3u2/l2rZG0k9ZOUXZliIL+D2FSwQjxK7a12SP+D4OKLAIj7VApFTPwlDLTNgD+mrpxyQ9A==
X-Received: by 2002:a05:6214:5004:b0:6d4:2778:ecb6 with SMTP id 6a1803df08f44-6d4377a118bmr7865406d6.18.1732051008401;
        Tue, 19 Nov 2024 13:16:48 -0800 (PST)
Received: from ip-172-31-19-182.us-east-2.compute.internal (ec2-18-219-201-45.us-east-2.compute.amazonaws.com. [18.219.201.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380db2edsm865966d6.36.2024.11.19.13.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 13:16:47 -0800 (PST)
From: Alexander Merritt <alexander@edera.dev>
To: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Alex Zenla <alex@edera.dev>,
	Alexander Merritt <alexander@edera.dev>,
	Ariadne Conill <ariadne@ariadne.space>
Subject: [PATCH] 9p/xen: fix init sequence
Date: Tue, 19 Nov 2024 21:16:33 +0000
Message-ID: <20241119211633.38321-1-alexander@edera.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Zenla <alex@edera.dev>

Large amount of mount hangs observed during hotplugging of 9pfs devices. The
9pfs Xen driver attempts to initialize itself more than once, causing the
frontend and backend to disagree: the backend listens on a channel that the
frontend does not send on, resulting in stalled processing.

Only allow initialization of 9p frontend once.

Fixes: c15fe55d14b3b ("9p/xen: fix connection sequence")
Signed-off-by: Alex Zenla <alex@edera.dev>
Signed-off-by: Alexander Merritt <alexander@edera.dev>
Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
---
 net/9p/trans_xen.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index dfdbe1ca5338..0304e8a1616d 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -465,6 +465,7 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 		goto error;
 	}
 
+	xenbus_switch_state(dev, XenbusStateInitialised);
 	return 0;
 
  error_xenbus:
@@ -512,8 +513,10 @@ static void xen_9pfs_front_changed(struct xenbus_device *dev,
 		break;
 
 	case XenbusStateInitWait:
-		if (!xen_9pfs_front_init(dev))
-			xenbus_switch_state(dev, XenbusStateInitialised);
+		if (dev->state != XenbusStateInitialising)
+			break;
+
+		xen_9pfs_front_init(dev);
 		break;
 
 	case XenbusStateConnected:
-- 
2.43.0

