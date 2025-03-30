Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190642AF10
	for <v9fs@lists.linux.dev>; Sun, 30 Mar 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743370501; cv=none; b=rMKbzjNt79yHaD3KcPFBfvbFRY1305zApsit6wOIM/R2sRo6quddIxfU3Bj2Zpslion5XnKVJKPOoGH/eIbIbPurP+cA3UizlxHfw+IN8Bsn4+WBeP8t7dfmkV/7NqGk2+ZJ6Y23PFuc69iGIKNzQNZ9ZlL/9xUS93i4EStu7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743370501; c=relaxed/simple;
	bh=yPL7poNUYAG0X3gKW/82JphDf6G3L4GrYOWJennSucI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tiXGAupAeLEVcKJKMsovDhDQ3GjJkpOlCmq7kGKbIHbbuWyPOVUOPTN0vwWFKOZGYNZBRRxh5viW7i407FLCw78HiiWrY54aoTuZ1StJS3bsb0gRjx9XCl+Pq4czvP54QOZauOTp47i8jZxFcEPASaD5KDQYwk6uqDEuruuFndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=eCRI6g0s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ppq6G35Z; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="eCRI6g0s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ppq6G35Z"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 0D388201EB4;
	Sun, 30 Mar 2025 17:34:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 30 Mar 2025 17:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1743370497; x=1743374097; bh=fAVegt/7o/L9UfjxefOtl
	a5pDrpTsej8kI0jHCIePXc=; b=eCRI6g0srBU296V/9Rn6fqj3v+jS7lCy2dG2B
	M/cug5rNNLcrHtKB3zx1EdH7BcsxXwJ6QOfwLj4zlr+FqDdGD3iK5PCCY3iYHGUv
	EhhiByGiLjqcpYLVz7hgsyvolJHiUgNtKIwhjC8IlT/9T3tUk8qTF7XXNOahAQNM
	ppEPmws11qpyvqVxWfGtznpSbXv+CCBGaxyo5kLHxoyGQoCzHQd6IkZWNrER52Iu
	CFa3l/3+8di+wE3MHaagO9GrNvGPMwmFGvev6kkd//Exxfz8LNfiYTgDR3rU5ILD
	3mvu7zz1vSytAD8N/asp6BpZSc86o5WBnVhD5La6HMIvLYZfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743370497; x=1743374097; bh=fAVegt/7o/L9UfjxefOtla5pDrpTsej8kI0
	jHCIePXc=; b=Ppq6G35Zy3wc9QjcIYiECYSBJ1Fw0dno2mc2C6L2zy6f/pzxWZF
	XVqs0fhiINbkn69fRFkzgYczlWO5tvX8AcuJaqkF60NRrCKPTz1uFafdf1IXi6gP
	qPVR3qkE6oEQ20edrRXsRhzbkvaw7lqqMHIAAIrgNJ3pfR0sZd39QUt/OYKdG/8Z
	l/6qjcFOZg0JClGDi0HVBMeW4SY5SX87qACAFlob5yqqk74ClCzB7GUm73q47DgX
	nSLAUCBSBpC0nIVzN4oOzZrn3husr7/PoJAE6y8a5sm+Wv9f9wQDqju+z/cUUWXd
	K9FWgUq0Chm0FRcDNaqI+Qe2fDDuKLjVJrw==
X-ME-Sender: <xms:ALnpZx_QqBHYa_tKZ2iQdPnfi1NMb-LmCBHwN3FmnpfXRtWU0vc5ow>
    <xme:ALnpZ1uTZjYGxXKUWtdmvfYkgBq-boi_4dpeMpLpnxUIrYQdDaOmFlpOTAALAdN2d
    GBjMmMYN7X2TO9gISs>
X-ME-Received: <xmr:ALnpZ_DXVAvAVINMwCx5iVaWtZgby4hmH6mMY9_s3UrX88OqBCQ7ycAvrT_r4y7dayTA1CQMUuMx2rVoCf38l4GhXFS9vqU1X_KYiGwdpsal9Y4AZohiLZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejvedtkefhveetjeekleegleeiheeuueetleeftedvieffieev
    gfekieeiffevgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopegrshhmrgguvghu
    shestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrh
    huuggvsgihthgvrdgtohhmpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghp
    thhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinh
    hugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ALnpZ1f9RIML0YVBG11z6-40cr-Za6JGbAARrEAVJOpI4eIhbksEmA>
    <xmx:ALnpZ2PMcxrqadlC2t8G7ibFpvZIX3SRU_wsD8qCVMPw1-tzp5kkaA>
    <xmx:ALnpZ3mUGRPgPf5sEFySqVUZ9AjQkT5kbQBAuf2EXumj9lxGJ9GW0g>
    <xmx:ALnpZwt_cl3LH4-AlwwS5Ke98pu2hocfoMZxhsR5LkyFScpRQksCMg>
    <xmx:ALnpZzrEMq9nFIjDtse747UtC620G53kwnzgk1RBZ0550MYnep5F7zgh>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Mar 2025 17:34:54 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: fs/9p: Add missing "not" in cache documentation
Date: Sun, 30 Mar 2025 22:34:42 +0100
Message-ID: <20250330213443.98434-1-m@maowtm.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A quick fix for what I assume is a typo.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 Documentation/filesystems/9p.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 2bbf68b56b0d..c9f0274c808e 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -165,8 +165,8 @@ Options
 		do not necessarily validate cached values on the server.  In other
 		words changes on the server are not guaranteed to be reflected
 		on the client system.  Only use this mode of operation if you
-		have an exclusive mount and the server will modify the filesystem
-		underneath you.
+		have an exclusive mount and the server will not modify the
+		filesystem underneath you.
 
   debug=n	specifies debug level.  The debug level is a bitmask.
 

base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
-- 
2.39.5

