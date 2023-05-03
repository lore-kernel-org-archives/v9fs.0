Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68C63AA
	for <v9fs@lists.linux.dev>; Wed,  3 May 2023 07:49:55 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id E721FC02C; Wed,  3 May 2023 09:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1683100193; bh=Bn/5ZlGn+EVgDbTblPSYKY/zFDm4FlTzSP0TCXKNJ60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cArzKPcQq+Fj/JPgYWfk1344oKzKtp++5epuCzUQuxMELmjXVUNm+xHEKMf9u1zCk
	 VfK9AfK18eHsy/fPiF8GnSoQhd0wMuUSi2dkgGkQU+2UhWfrEJXuDDpX2Cv4D4+RFG
	 g9fpnNFaepUzqUxRrMhZ0/tiVNIM/01nOzD3H1BRPitY2kM61r8A/0p3l/RP/5YJ+j
	 /o0eoujeO11nup6oU2WUZwaeK8zT1SYPr0zk8CEIRDVPGPpa5NMNqKQAxbsBV9cNHx
	 fLQURnxsECtVP8DT4jVsHRse9y4xiBym+XGQWpu55YwBW5IeOQFUWDYPgzMsfvKCkX
	 rsDXswwl0WOxA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 9000FC024;
	Wed,  3 May 2023 09:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1683100192; bh=Bn/5ZlGn+EVgDbTblPSYKY/zFDm4FlTzSP0TCXKNJ60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=syReZg6P6clHA+ydk9LatPM6TUX8yYj0qYvSB+4ma8ZmuXFnTo9jAiJEwKC/zT7tK
	 oDuo+/vM2j/eZJ5ZWyN6pAXwgZ8wnajxmr0dv8Ay1OZGf/FJlF/PMjkC20qqu8cCa5
	 ETDhGms1M91LNe0oMGFBTtU+1uigHydXV2+rNSfIXUBKArufxnjlPKNTh9RLQ5fF6r
	 /VQv13KTrc1zqh1JpFnD+foHLo24kjJ+bhzG6kxjioyHVnw8pzTZunO2nkNSSImwhK
	 0EZOcuLtdXlyBnLHHuUEIRq871XD2PW0E4n7OOpoRcRZ1NLYMwZQOTelxCqleOkhku
	 wYqLp7H44/hBg==
Received: from [127.0.0.2] (localhost [::1])
	by odin.codewreck.org (OpenSMTPD) with ESMTP id a2b34235;
	Wed, 3 May 2023 07:49:37 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Wed, 03 May 2023 16:49:26 +0900
Subject: [PATCH v2 2/5] 9p: virtio: fix unlikely null pointer deref in
 handle_rerror
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230427-scan-build-v2-2-bb96a6e6a33b@codewreck.org>
References: <20230427-scan-build-v2-0-bb96a6e6a33b@codewreck.org>
In-Reply-To: <20230427-scan-build-v2-0-bb96a6e6a33b@codewreck.org>
To: Eric Van Hensbergen <ericvh@gmail.com>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, v9fs@lists.linux.dev, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=Y6KjVHWIIzNv5G9OQA9559Le+4Qy3Sq4eORmp7S4tKc=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBkUhIRIiVTjDDML37A9Vdn14K6TOXpNjJcQR7vZ
 bUrPpMLcHaJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZFISEQAKCRCrTpvsapjm
 cIfzD/0fdtylPvf+ZXFI3idGfmM9rCi/Oyy9JGSjiU8U22WOOnkX5WLbZDdp/lkWZvSnIJikBoz
 JS5FG0IzWBW3coy7KMPy6e4E2Y7qUttUhK9X421UvQ2gvhXoY/55TwAaGClF5IDHE2f+jbVc9AK
 Ra/RvqBK3ilgCQlPc1RJPFC6kXevqsPYxhGHZmZxIlPiwkp6xHPxYgjvQiMU9EQJt+K4Cw0Gs1T
 hYL27EvJfu3zdj5iBCa1m6yYVwHk5P9gZXD9SWoCANbHzMNfAWPwdZ2ZuR9xEeCcPYXJwGvhXKg
 UodiX+qScCuetqsH/tApjtHNCYzMh+v/EKlCoSOhb5a54gwVoCIgzO2FsKEh0EN8EwV4UOssUFX
 xRNlEGdKAHkjUGjC7gMQt7+g8Wuk+jQCB1eHLjRyX/YiSplSr25CrGLHlz+UvzRlGLgmbgj0oQL
 xFIp5w+bEaSrs1OyZVjyasfIKLcWidcCVvnJOHH1nglLgjOo1p1wY35Fow9PT1WUQhfi4iCATIy
 XIM/ZuTG2Qe96mt2nGZ5lk6ZYTkoAdErZJkV207k/DJfKDUAEH3N2OGV2Yr2N/nRPQNrOKA8GtN
 /yMXnnMfC3UHc5D2W5hJvoM4tQS9Z6cfQ4yo0awQ031caNpe9K07X8oA+jOtANH5Azq0G1VUsdK
 TBL5ouRdIukX1uA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

handle_rerror can dereference the pages pointer, but it is not
necessarily set for small payloads.
In practice these should be filtered out by the size check, but
might as well double-check explicitly.

This fixes the following scan-build warnings:
net/9p/trans_virtio.c:401:24: warning: Dereference of null pointer [core.NullDereference]
                memcpy_from_page(to, *pages++, offs, n);
                                     ^~~~~~~~
net/9p/trans_virtio.c:406:23: warning: Dereference of null pointer (loaded from variable 'pages') [core.NullDereference]
        memcpy_from_page(to, *pages, offs, size);
                             ^~~~~~

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 3c27ffb781e3..2c9495ccda6b 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -384,7 +384,7 @@ static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
 	void *to = req->rc.sdata + in_hdr_len;
 
 	// Fits entirely into the static data?  Nothing to do.
-	if (req->rc.size < in_hdr_len)
+	if (req->rc.size < in_hdr_len || !pages)
 		return;
 
 	// Really long error message?  Tough, truncate the reply.  Might get

-- 
2.39.2

