Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C76BB40
	for <v9fs@lists.linux.dev>; Thu, 21 Dec 2023 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id B20161868DE9;
	Thu, 21 Dec 2023 14:02:05 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uNA77BV8vq19; Thu, 21 Dec 2023 14:02:05 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 49B811868DC5;
	Thu, 21 Dec 2023 14:02:05 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1z0oOcMoKVIi; Thu, 21 Dec 2023 14:02:05 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.102])
	by mail.astralinux.ru (Postfix) with ESMTPS id 997A11868E4C;
	Thu, 21 Dec 2023 14:02:04 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.232.135])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4SwnZ34sJVzfYks;
	Thu, 21 Dec 2023 14:02:03 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Hangyu Hua <hbh25y@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 1/1] 9p/net: fix possible memory leak in p9_check_errors()
Date: Thu, 21 Dec 2023 14:01:22 +0300
Message-Id: <20231221110122.9838-2-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221110122.9838-1-apanov@astralinux.ru>
References: <20231221110122.9838-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Hangyu Hua <hbh25y@gmail.com>

[ Upstream commit ce07087964208eee2ca2f9ee4a98f8b5d9027fe6 ]

When p9pdu_readf() is called with "s?d" attribute, it allocates a pointer
that will store a string. But when p9pdu_readf() fails while handling "d"
then this pointer will not be freed in p9_check_errors().

Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support =
functions")
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Message-ID: <20231027030302.11927-1-hbh25y@gmail.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218235
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
 net/9p/client.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index e8862cd4f91b..cd85a4b6448b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -520,11 +520,14 @@ static int p9_check_errors(struct p9_client *c, str=
uct p9_req_t *req)
 		return 0;
=20
 	if (!p9_is_proto_dotl(c)) {
-		char *ename;
+		char *ename =3D NULL;
+
 		err =3D p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
-		if (err)
+		if (err) {
+			kfree(ename);
 			goto out_err;
+		}
=20
 		if (p9_is_proto_dotu(c) && ecode < 512)
 			err =3D -ecode;
--=20
2.30.2
