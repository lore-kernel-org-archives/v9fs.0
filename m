Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739327EC3
	for <v9fs@lists.linux.dev>; Thu, 26 Oct 2023 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPc+D7ua"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-51f64817809so81599a12.1
        for <v9fs@lists.linux.dev>; Thu, 26 Oct 2023 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698312249; x=1698917049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydp47NijRNhsTd2ijrQYlgBAO7+uhRDGUkD8hJL4r/Q=;
        b=KPc+D7uaARFcoRm/VEGwBsxWCnwlHQ8L3JH2BPq1ydJGLqy8kFG5KUwKtUBiJ6Vqm6
         xUa6xGQa8w78Sje68oY5pBN1bWrsn7r3i3FPVsrLoGMwuac2QAhNmCV3GBs9R/M0CiGV
         ay6Pw9uP3auls9ssecBS/oKDBvhNi4zHQjq6VHHw+mHdutI5NFQuEYzXMH48i0l+jlcV
         onCizU26iUqrJLEdqpQaJwgHcg8odfYOoih8ZaIx/AT7KdM2ekgF7ShzqlvVLtkmpmK7
         nXWhd/WSWn3bq8abruO81c5mDRevCd/ahOA+EwqOhaRtNaBQVu+5DbdjzowZ7JlgAdzY
         SkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698312249; x=1698917049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ydp47NijRNhsTd2ijrQYlgBAO7+uhRDGUkD8hJL4r/Q=;
        b=ZfsgsnJqizAzM3VUKWMse/xhnU1BljrdXi/qz/F3wg5FCvleLHP77HtwCxxNGJUgYy
         AjVqRlNDfPdx+6YNRv0zawAjH4qcsRc1CBwKWlkOzKXbl8TPW8UfLR/kNEtwyJbKtBkV
         MBcyeFYDuKLIm72vGCreZLO3/lPULm0YTJwRHZsF7Oa7eebLRu+9wpt9cZH5quOaq9IA
         pSWp4/uvH4imiDWZCF0OrI5tQ19nOmcUtIQ2tJ2BTweSHYBQrrnhyVib1JBIdD8M/Gjb
         bVDTYibKMWv+7RjJgLB50MGAS50UZXjZd9tPMq0B1thvU+HTQUejqTPgJw7ZJXRFASoL
         G+eg==
X-Gm-Message-State: AOJu0YycIfjksPEXk+be7bcDZW1XRbsxYLtEJXm9sepUXGXvDmL9k0ux
	VxFNpHmAmOcWHY0ca7dThb0=
X-Google-Smtp-Source: AGHT+IGfiG4RI6qZ5xW5/G8usOancHujsybQ3U9PcSZMmC3jNU05tZxIxnVEK0f2M/KW6+GrqwY91w==
X-Received: by 2002:a05:6a20:8f05:b0:163:57ba:2ad4 with SMTP id b5-20020a056a208f0500b0016357ba2ad4mr21534848pzk.2.1698312249140;
        Thu, 26 Oct 2023 02:24:09 -0700 (PDT)
Received: from hbh25y.mshome.net (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001c5076ae6absm10565631plg.126.2023.10.26.02.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:24:08 -0700 (PDT)
From: Hangyu Hua <hbh25y@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jvrao@linux.vnet.ibm.com
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] net: 9p: fix possible memory leak in p9_check_errors()
Date: Thu, 26 Oct 2023 17:23:51 +0800
Message-Id: <20231026092351.30572-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When p9pdu_readf is called with "s?d" attribute, it allocates a pointer
that will store a string. But when p9pdu_readf() fails while handling "d"
then this pointer will not be freed in p9_check_errors.

Fixes: ca41bb3e21d7 ("[net/9p] Handle Zero Copy TREAD/RERROR case in !dotl case.")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 net/9p/client.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 86bbc7147fc1..6c7cd765b714 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -540,12 +540,15 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		return 0;
 
 	if (!p9_is_proto_dotl(c)) {
-		char *ename;
+		char *ename = NULL;
 
 		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
-		if (err)
+		if (err) {
+			if (ename != NULL)
+				kfree(ename);
 			goto out_err;
+		}
 
 		if (p9_is_proto_dotu(c) && ecode < 512)
 			err = -ecode;
-- 
2.34.1

