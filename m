Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB86A323
	for <v9fs@lists.linux.dev>; Tue,  5 Dec 2023 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="qjGGvX+q"
Received: from localhost.localdomain (unknown [46.242.8.170])
	by mail.ispras.ru (Postfix) with ESMTPSA id 60EAF40F1DE8;
	Tue,  5 Dec 2023 18:05:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 60EAF40F1DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1701799532;
	bh=iSQFzh6kLnBCcudLetoO0SevfeUo1ajFojtQyoqXpBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjGGvX+q5/okA2ccONfrW/JIILDtVsCtbi/3lK6KMl7/MKeXrk9Y7g1krpec6W8Q4
	 MeNVeYPnw637K1E2S+L0ZBw1Sj4vTg4eGXzUDMIoe2stuRvJ82adZVg/+lcNdXhrtu
	 LxQuq8jpwgyfD99rtJTxly4iAOqyk1RvNMLheh3I=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v3] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date: Tue,  5 Dec 2023 21:05:22 +0300
Message-ID: <20231205180523.11318-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9f21f00b-0806-4811-8d0a-9b6175eaedeb-pchelkin@ispras.ru>
References: 
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If some of p9pdu_readf() calls inside case 'T' in p9pdu_vreadf() fails,
the error path is not handled properly. *wnames or members of *wnames
array may be left uninitialized and invalidly freed.

In order not to complicate the code with array index processing, fix the
problem with initializing *wnames to NULL in beginning of case 'T' and
using kcalloc() to allocate and initialize the array. For assurance,
nullify the failing *wnames element (the callee handles that already -
e.g. see 's' case).

Found by Linux Verification Center (linuxtesting.org).

Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v2: I've missed that *wnames can also be left uninitialized. Please
ignore the patch v1. As an answer to Dominique's comment: my
organization marks this statement in all commits.
v3: Simplify the patch by using kcalloc() instead of array indices
manipulation per Christian Schoenebeck's remark. Update the commit
message accordingly.

 net/9p/protocol.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 4e3a2a1ffcb3..7067fb49d713 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -394,13 +394,14 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
 
+				*wnames = NULL;
+
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
 				if (!errcode) {
 					*wnames =
-					    kmalloc_array(*nwname,
-							  sizeof(char *),
-							  GFP_NOFS);
+					    kcalloc(*nwname, sizeof(char *),
+						    GFP_NOFS);
 					if (!*wnames)
 						errcode = -ENOMEM;
 				}
@@ -414,8 +415,10 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 								proto_version,
 								"s",
 								&(*wnames)[i]);
-						if (errcode)
+						if (errcode) {
+							(*wnames)[i] = NULL;
 							break;
+						}
 					}
 				}
 
@@ -425,9 +428,9 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 
 						for (i = 0; i < *nwname; i++)
 							kfree((*wnames)[i]);
+						kfree(*wnames);
+						*wnames = NULL;
 					}
-					kfree(*wnames);
-					*wnames = NULL;
 				}
 			}
 			break;
-- 
2.43.0

