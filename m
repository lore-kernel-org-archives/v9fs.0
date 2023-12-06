Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB347F7A
	for <v9fs@lists.linux.dev>; Wed,  6 Dec 2023 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Dkc0FpIo"
Received: from localhost.ispras.ru (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id EE2E540F1DDC;
	Wed,  6 Dec 2023 20:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EE2E540F1DDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1701893372;
	bh=c3U7NlHX7ms/NKOXt6QI/vyo4/wqXOpsspJ9q0DqZV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dkc0FpIoSUrJWebyTaDD+QfyhNW3e5ZMH7xdQN2r6+1XxXqKyspx1owYEVT3YJ09z
	 Anm7Vc4LVNIOwJdgvc6cBRnvWkSqn7Sv0reu8keyrCkaaPhfyYoSgi2QNNl2gv1W3w
	 vzMp8vC4cdJw7vAnsedMnPNV3lUu6kbpKS0ITja8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
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
Subject: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date: Wed,  6 Dec 2023 23:09:13 +0300
Message-ID: <20231206200913.16135-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <10981267.HhOBSzzNiN@silver>
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

Initialize *wnames to NULL in beginning of case 'T'. Initialize the first
*wnames array element to NULL and nullify the failing *wnames element so
that the error path freeing loop stops on the first NULL element and
doesn't proceed further.

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
v4: Per Christian's suggestion, apply another strategy: mark failing
array element as NULL and move in the freeing loop until it is found.
Update the commit message accordingly. If v4 is more appropriate than the
version at
https://github.com/martinetd/linux/commit/69cc23eb3a0b79538e9b5face200c4cd5cd32ae0
then please use it, otherwise, I don't think we can provide more
convenient solution here than the one already queued at github.

 net/9p/protocol.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 4e3a2a1ffcb3..0e6603b1ec90 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -394,6 +394,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
 
+				*wnames = NULL;
+
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
 				if (!errcode) {
@@ -403,6 +405,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 							  GFP_NOFS);
 					if (!*wnames)
 						errcode = -ENOMEM;
+					else
+						(*wnames)[0] = NULL;
 				}
 
 				if (!errcode) {
@@ -414,8 +418,10 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
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
 
@@ -423,11 +429,14 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 					if (*wnames) {
 						int i;
 
-						for (i = 0; i < *nwname; i++)
+						for (i = 0; i < *nwname; i++) {
+							if (!(*wnames)[i])
+								break;
 							kfree((*wnames)[i]);
+						}
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

