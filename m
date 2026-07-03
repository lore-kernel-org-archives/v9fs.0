Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC73C3BEE
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074183; cv=none; b=qFgZdPLtSSm99I7YOmCXye7Pet7N8pAsEyKb37Pp3kJckf4jIB+5P7CBEgB1Pr3jsJWVFhaXOrowUqkOtdGceonHx1hCPd4X1QHP1Mlwdaanu388iEZdMPskiD/GiVUncJ9y8lEOH/FqHmR4FLDTtaJlp0oF22YXIrrtjJdb7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074183; c=relaxed/simple;
	bh=qNLJ1DzGl8129HBO0EhHn4JkWSr5Kr9g5Ar9omOOWrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=jS1syGGWw4gUCdEUkUAtBQE96y9owaOhRfilwiNUDXKhlbuAmU83NXy3yg4JwU1xiRf8lRhUcNidw5u7UVeAxRr3u/lWyjAW0eRtb6ReH8u5FgCsnt5O3LD+mjnafGQiGoog0ftoNDFXCiaxcfoad/rugstPt0JEPTs2BsTHtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMOok37R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMOok37R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783074179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SqSTAKAygGy6fDoH7HM38FHPVW7tCSNwGAcZ298VToc=;
	b=BMOok37RgWmXvPnjnI/CnxNGwLzUA6vhWt6qGqOlFkhh3LPmOgj+L+ovbbZU0mMGEntLwi
	votw5y/HCrbAlbtLMmdBMf/tzFzZSjQWwOuEY/i/cCr1nuc1hxGVmVD+xJJ0Zo6HUpGUzG
	b6pXiAm4zVYftIkeEFZ0WkTm+iJpYaU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-oksc0kwUN7CNquEZAL2pLQ-1; Fri, 03 Jul 2026 06:22:57 -0400
X-MC-Unique: oksc0kwUN7CNquEZAL2pLQ-1
X-Mimecast-MFC-AGG-ID: oksc0kwUN7CNquEZAL2pLQ_1783074176
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-475b0b4e8d5so366295f8f.1
        for <v9fs@lists.linux.dev>; Fri, 03 Jul 2026 03:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074176; x=1783678976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqSTAKAygGy6fDoH7HM38FHPVW7tCSNwGAcZ298VToc=;
        b=UG7kSnGFjXtjkihWWEfV9Ygn+qwvBLndwjmvnPJRkHO3VQFbziZncwectmE1PPO6gR
         Nz8L5+prZuzsGU2ZoOM04oTnw9oQ/ycT8oJrUv6LrSEWAQgmdWWTStLc/j/R6ZVqnuT9
         X+6+ITLayKXEuqCSOsWN8wMnQilarvAEqpbLukXsApMZOTuvbHxZc3ImYVz2GIQDy/n7
         PpHBiXdmt4HDisC55yIF2AP0SUM9c8KD4HIdqtbWub2fHFvsxTHb3BvQJrfoiypAhFlA
         PyfrlePstrNIwDXkLKkjVVh8yEWuHQeMsi61Tp4Jnn2GjVl2xnfZ557r3XGUGSqDdfHU
         uubw==
X-Gm-Message-State: AOJu0YyaCM96ObfAQoUrEzO3iiFeTHNG6Ub0+b+TVbuzxG6Q3ANYiM5z
	q5CnrgsAvJwMC/Ag8N++cyM4Dxi7BFZ2y87vuZi7xS3lCL8Tkzt8P6cBhlWR6ygJe2kL3vav0/m
	LNHt7hckS5V3IcVQKAfmPrvCedoiLnK//9ZITJGJ7omeAPoD4QnBOxvmogKdQxUOCXwX4AqrCaS
	w+aGfYuCh2qbT4Yzduk/NVqkniSeJRiNTSOvMXHPQ=
X-Gm-Gg: AfdE7cn9wyVeXxRJR+MXN39xwggG+ps2Ek1ZWF5dkAjZlwWfyXtwA32DOweSBUOKKCF
	cE2gaGs2FnSN9mCmbYbrhotD996ZDCQRMutU3PsAQYZ6rmvkf3JoiYwIVXRJ9XZTW2AK0Al8oRH
	SBxUUgdcFs4wy3xJu4MsF3f8YRX1Uo60Az3LyGfYYYP1/9L+5GMyLASNqhlL2nO1JJxEDgIklwY
	/XOxmVSAb9ToEBwk3ACedzMESxNOFYxBsCipm919nYaORnFD1IIdspFr4lxSEt9jBgNMkjIRbzi
	qWj5XCTs856Xou2Zf81aGhUbYci0U31GVew9zMqKL4Ujy6jOepo71LfQ0MCsdwTVdx7dzGUV+9Q
	XuiPOJDwoBhgEODvcX9kW0/cIhmJ1YO9ifu7aPTnKq7Ca20hLSk77Mwc2r8du+Qk=
X-Received: by 2002:a05:6000:604:b0:46f:558:a43f with SMTP id ffacd0b85a97d-477b34b039fmr12378735f8f.4.1783074176556;
        Fri, 03 Jul 2026 03:22:56 -0700 (PDT)
X-Received: by 2002:a05:6000:604:b0:46f:558:a43f with SMTP id ffacd0b85a97d-477b34b039fmr12378677f8f.4.1783074175996;
        Fri, 03 Jul 2026 03:22:55 -0700 (PDT)
Received: from stex1.redhat.corp (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dc77bsm17460704f8f.33.2026.07.03.03.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:22:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: v9fs@lists.linux.dev
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Eric Sandeen <sandeen@redhat.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] 9p: fix privport option setting wrong RDMA field
Date: Fri,  3 Jul 2026 12:22:54 +0200
Message-ID: <20260703102254.114446-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fgwcppu7Tx6OqX3GZr4Y4pCzyHKSr5qdvzU_JhI9gs4_1783074176
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

While reviewing a patch adding vsock transport to 9p, I noticed that
since commit 1f3e4142c0eb ("9p: convert to the new mount API"), the
Opt_privport case incorrectly sets rdma_opts->port instead of
rdma_opts->privport, so mounting with the privport option overwrites
the RDMA port number instead of enabling privileged port usage.

Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
Cc: stable@vger.kernel.org
Cc: sandeen@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 fs/9p/v9fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 274c5157135d..f426cee37414 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -406,7 +406,7 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_privport:
 		fd_opts->privport = true;
-		rdma_opts->port = true;
+		rdma_opts->privport = true;
 		break;
 	}
 
-- 
2.55.0

