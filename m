Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF279DE
	for <v9fs@lists.linux.dev>; Sat,  1 Apr 2023 19:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE49C433EF;
	Sat,  1 Apr 2023 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680376002;
	bh=XndH/S9Pym3JldjOAUSU5oSQBK2eeCU0AUtP7DnlHzc=;
	h=From:Date:Subject:To:Cc:From;
	b=keomznfEeSQr3r/Pu7LNejIAgE4nEE3B1/0c00QzMlPh6ZrLtbKYOVcP0ge8ewQRQ
	 bSgFc91MPLWJ5UZ4tqPcOh8/yF2fsEhpQSSR9Up3fkWxsmVnxbbA2YSYCrzsjTvIBc
	 xU82lD7VWmZMgwmc4iIKLARH0uTaGqbyMcjFVnbEHxyEOozb3QtIgeo56Tb43qj/8f
	 X8MJH5nCFW+lXqKFSOHHJoeNYmDGEe+I3usKjqLkc4xzEiBUZlFZeudIaRzML/QXmn
	 Pr4/HyNKirZRMSzChLz7mbIRliNejl2WhKVxvvXF53287aBaa/39NToFJr+sdZfHs9
	 oZWdWR/MfAdBQ==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 01 Apr 2023 19:06:25 +0000
Subject: [PATCH] Update email address and mailing list for v9fs
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230401-ericvh-fix-maintainers-v1-1-e3c535b2b5cf@kernel.org>
X-B4-Tracking: v=1; b=H4sIALCAKGQC/x2LwQ6CQAxEf4X0bOOyLMT4K8ZDWarbg9VsCSEh/
 LuFwxxm5r0NjKuwwb3ZoPIiJl/10l4ayIX0zSiTd4ghdiGFFh3PS8GXrPgh0dnD1fA29KmPPOT
 UEbg8kjGOlTSXQ3ec7aq8zsf5q3wO/jye+/4HjbwjSYUAAAA=
To: v9fs-developer@lists.sourceforge.net
Cc: v9fs@lists.linux.dev, ericvh@gmail.com, lucho@ionkov.net, 
 asmadeus@codewreck.org, linux_oss@crudebyte.com, rminnich@gmail.com, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=XndH/S9Pym3JldjOAUSU5oSQBK2eeCU0AUtP7DnlHzc=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkKIDBiokMrbNDCsIwcCQrElOLAozIyearG27Tl
 zm0HWDRFs6JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZCiAwQAKCRCI/9X7Sl//
 mCZVEADCtQznRfgLyQ4PG3NZU+Pt3lPCtcFHnjMcKYfCt7eKR3ZvDYzqLzREmMrTMpGB89QsBIC
 e02qgjwDHqBY8FDK6MzDgGeGpCCHcrRmkZbLNYLOCusqIpYl/u/OdGN++L3KQVRp5UYzlZmVScs
 0hFirlFP3AS4a6MTiPoVCZlE06VcAWUwXnFZswz8btRR+8xCnze5zQf/K0pht8bPQ2XAO9vuzuD
 qfPomqT9NokjVSEv0eBJrc9qN/4PCGytNIp5IB6AceXFHBe2eCNKcT/TXDmzr0sOVqJk1cE9Mb5
 GVBTiRddxBF55+IBUE1LVtfmmI65ID/lQID8E+SU3oaNcPUEIy8UGNgeJt9D/DbciEpp7cAcp8P
 eTHZJq/4rW8LrAg3nv48b4G1xvOSvNRCFKwhAulj3baLt2ANHqxYHQpfTLBx2KIKpIi+0eJBvmc
 4BTT0+ajAEeXXKwSzJV0/ZJx802D9x671a8gYHacHlkbU9WWUzpA4vaJ//UMiZsbj+Ir8//cmv8
 WBresUWC+GSP9eGVTu38BPpXZUkQXanRq44pqw3PP3bPOgbyO+g6QibgcUV11npaAhNOQfVIQ+r
 hWYXp3X/39+4vc8Ndvu/JvW5Ko9GGwU9r7rqzvX//JumNvu8j8EXzbOsTVw/CVoL+QWWmqRbkun
 VATV0ZrBZ9uUyvg==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

We've recently moved the mailing list to lists.linux.dev to move away
from the sourceforge infrastructure.  This also updates the website
from the (no longer v9fs relevant?) swik.net address to the github
group which contains pointers to test cases, the protocol, servers,
etc.  This also changes my email from my gmail to my kernel.org
address.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..6567bae7137b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -224,13 +224,13 @@ S:	Orphan / Obsolete
 F:	drivers/net/ethernet/8390/
 
 9P FILE SYSTEM
-M:	Eric Van Hensbergen <ericvh@gmail.com>
+M:	Eric Van Hensbergen <ericvh@kernel.org>
 M:	Latchesar Ionkov <lucho@ionkov.net>
 M:	Dominique Martinet <asmadeus@codewreck.org>
 R:	Christian Schoenebeck <linux_oss@crudebyte.com>
-L:	v9fs-developer@lists.sourceforge.net
+L:	v9fs@lists.linux.dev <v9fs@lists.linux.dev>
 S:	Maintained
-W:	http://swik.net/v9fs
+W:	http://github.com/v9fs
 Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
 T:	git git://github.com/martinetd/linux.git

---
base-commit: 707823e7f22f3864ddc7d85e8e9b614afe4f1b16
change-id: 20230401-ericvh-fix-maintainers-865452e6c43a

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

