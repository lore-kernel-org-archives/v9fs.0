Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5564A
	for <v9fs@lists.linux.dev>; Fri, 27 Oct 2023 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+ITlUsj"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1cac20789e8so3053355ad.1
        for <v9fs@lists.linux.dev>; Thu, 26 Oct 2023 20:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698375799; x=1698980599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EOx1Hx1IAPQ1YOKRVGNCkYTk+hHI63wiG6ySEOWqsw=;
        b=P+ITlUsj4YpisnzH299TiRH5/Ofc1XpadEyVhKSDAECk9MHLQ2ewAyTTvdkX7mLCCQ
         fwvISjAZJteHRW2Zda0rwOvJofnfv7Tq/e3PTzLYDA3NXYrcd36JV5fHY62oKZmRx8Iq
         TP3VuRp7fU+o+BWZKlbWvXYJ388s+yy4qEOBXFuqm2tfw0SpBvhzm2WiOedaAsG0ez2D
         6izHAL4OwFRFVOLbksctWPigOBB5+Z9NNDI0NrQEFcskGvrSP+vnGZSUUrgj5fR7e12G
         1a1x2Oqgx2JoQWEjNZMV7DhYwlpYpc5kKxhB5IOILEtJx0RUrJD+ODSXwMJriJFoUxlM
         BV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698375799; x=1698980599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EOx1Hx1IAPQ1YOKRVGNCkYTk+hHI63wiG6ySEOWqsw=;
        b=GzwjjN570zvjbv79zAb/8XAPCK5lcyqnaJrkv/3mtPkRkeQidaMfql80n05ySHO8vB
         gxJt/OHxwHM58YBAy+1rOxJQ+47JIWC+DU9xFVXm1KGKhlh1MBc6pFRUpHHK9VZMcMeu
         pNS5eHUAXclMFMS47QUsHg0SYbsqCJo2lvcfcEtkZxzmn1p1t8e+GY9M9/2CmojCyOl0
         oZTTSn7tP8lMSIyPNXVG5964XKveXu5sSwG7iup4cnNE6VeoG9A29wCSh7lJrhJWpEjk
         3WCxcv8d8ergHp5zbrQXXrictc55M3f4LZ3oIsI5P4uG6bArEOSn0Ceni7QMFVcZQJN2
         bQYA==
X-Gm-Message-State: AOJu0YyLvY7+JRLmnHrHS5M7H9DZdeb8HzZ+/lcNTw0KxRvBC/mWck8H
	9Jk9rKiHnKUDrnQZrJaN7OY=
X-Google-Smtp-Source: AGHT+IG9yKdbB5f6crmqx99aYXu0CfVPTX0c780HCd5N35eViHlFac5rHuZEhQhsRoxb4hn+gVW6SA==
X-Received: by 2002:a17:902:f213:b0:1c4:1cd3:8062 with SMTP id m19-20020a170902f21300b001c41cd38062mr1465649plc.2.1698375798663;
        Thu, 26 Oct 2023 20:03:18 -0700 (PDT)
Received: from hbh25y.mshome.net (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001bde65894c8sm407508plb.268.2023.10.26.20.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 20:03:18 -0700 (PDT)
From: Hangyu Hua <hbh25y@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] net: 9p: fix possible memory leak in p9_check_errors()
Date: Fri, 27 Oct 2023 11:03:02 +0800
Message-Id: <20231027030302.11927-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When p9pdu_readf() is called with "s?d" attribute, it allocates a pointer
that will store a string. But when p9pdu_readf() fails while handling "d"
then this pointer will not be freed in p9_check_errors().

Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support functions")
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
	
	v2: change the Fixes tag and remove "ename != NULL"

 net/9p/client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 86bbc7147fc1..b0e7cb7e1a54 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -540,12 +540,14 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		return 0;
 
 	if (!p9_is_proto_dotl(c)) {
-		char *ename;
+		char *ename = NULL;
 
 		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
-		if (err)
+		if (err) {
+			kfree(ename);
 			goto out_err;
+		}
 
 		if (p9_is_proto_dotu(c) && ecode < 512)
 			err = -ecode;
-- 
2.34.1

