Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316671B7C3
	for <v9fs@lists.linux.dev>; Tue,  8 Aug 2023 16:44:43 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-56cc461f34fso3586438eaf.0
        for <v9fs@lists.linux.dev>; Tue, 08 Aug 2023 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691513083; x=1692117883;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBnFEr6hL7Vf1RaT+Kz/ZGkUB6X3BF40XbTk/IEziOA=;
        b=Y6W1YKV2lpCReNKInMmBqDB9Einxdn+vs4X3zNb6cxrTCsr3J8zLBOR40vvtyUhprq
         sMgMEu2qg4dTxpIfOpMFZbM7wVxl3li5zjtr/xcUVNl8NvAH8fpEg48/UnHcyfw+kDpr
         Ml2TFLJymQSkTsH6/mq/811+QPJuut+euWg+TNsDjEB3YjaxZfTkFjqJV1LUP0JsxLBS
         UTmcMgtdu2FhqX8x8EA6XZHtQMS6JD56zkRd/9BQimBqaSXnmPHmV76t8p9Xq6WUYnPl
         Q+C7wFUeFw+4mByB3M0p2twpqQmyZ/twF41QMIio1MjZJJXewHQLcjvzefdZJWWC9HVC
         1LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513083; x=1692117883;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBnFEr6hL7Vf1RaT+Kz/ZGkUB6X3BF40XbTk/IEziOA=;
        b=icOFcXomR4oG7QPwy48YQtSGp/DSbm37s/vBG7WCGPw4QVlTu8UD6goXpXnJveSDAs
         UV7QhXuoSJJYAKWJe+2WKsqxWqeQmMSDzzOGnTiODxMA2l/8RMvdYqv2gIxCw5peTaCf
         zTw6Da7wW5PQKAjTmukF9hP9TUdrXWd5RFCd4sMfHD4u/HI2NBR78R15Zsvk/zn44iy4
         NG58Tv5biD5bePpWg3p93LBjOmlG+Zkmj8Niycf4wcCI4qs/WE2fFy36SlySvyM5opJ8
         W7HSW+S0HAXaEcCmUFGoXNIGmBixBTWt7FlAoiGY5sgkiudjQmk2khoEiVMwLhu1Gn69
         qH0g==
X-Gm-Message-State: AOJu0YyBJA2pKN9z5ApWbHY5irHMQJzCJ6N5eGyOjmuw3h8xKkNLt7X4
	r4Ry4FND3UBCmI5Id9RPxiVKb7Ki8ReBgUV/
X-Google-Smtp-Source: AGHT+IH3S5h4d0rHL4zXlmIwflGxSWvOSBLz6fXsTI1uU4OPORKHbO+d0e7TYMMgVri2+0OFUP1D3A==
X-Received: by 2002:a05:6870:2189:b0:1bb:973a:6752 with SMTP id l9-20020a056870218900b001bb973a6752mr147598oae.25.1691513082987;
        Tue, 08 Aug 2023 09:44:42 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.43])
        by smtp.gmail.com with ESMTPSA id d24-20020a02a498000000b0042916ad15bcsm3126288jam.31.2023.08.08.09.44.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2023 09:44:42 -0700 (PDT)
From: Sishuai Gong <sishuai.system@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: [PATCH] 9p/trans_fd: avoid sending req to a cancelled conn
Message-Id: <AA2DB53B-DFC7-4B88-9515-E4C9AFA6435D@gmail.com>
Date: Tue, 8 Aug 2023 12:44:31 -0400
Cc: v9fs@lists.linux.dev
To: ericvh@kernel.org,
 lucho@ionkov.net,
 asmadeus@codewreck.org,
 linux_oss@crudebyte.com
X-Mailer: Apple Mail (2.3731.700.6)

When a connection is cancelled by p9_conn_cancel(), all requests on it
should be cancelled---mark req->status as REQ_STATUS_ERROR. However,
because a race over m->err between p9_conn_cancel() and p9_fd_request(),
p9_fd_request might see the old value of m->err, think that the =
connection
is NOT cancelled, and then add new requests to this cancelled =
connection.

Fixing this issue by lock-protecting the check on m->err.

Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
---
 net/9p/trans_fd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 00b684616e8d..e43a850f5190 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -671,10 +671,14 @@ static int p9_fd_request(struct p9_client *client, =
struct p9_req_t *req)

 	p9_debug(P9_DEBUG_TRANS, "mux %p task %p tcall %p id %d\n",
 		 m, current, &req->tc, req->tc.id);
-	if (m->err < 0)
-		return m->err;

 	spin_lock(&m->req_lock);
+
+	if (m->err < 0) {
+		spin_unlock(&m->req_lock);
+		return m->err;
+	}
+
 	WRITE_ONCE(req->status, REQ_STATUS_UNSENT);
 	list_add_tail(&req->req_list, &m->unsent_req_list);
 	spin_unlock(&m->req_lock);
=E2=80=94


