Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FD395240
	for <v9fs@lists.linux.dev>; Thu, 16 Jul 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187107; cv=none; b=hs1rIXrWGedRYXRZr0rpi6mBonnMSIyODo/bhaNYFTHaHgzvp/rMnwWlsrch5WfC76xmC4Qnb7L14lPM2X4o82v+BffuQ/qJuLbDuVvkI/hJ2ZxwO6pNBLlrCYUB/4hKEFBa98UM2yOPYt6bfOwTtNJrBkK2zXUgNJxrBtvqrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187107; c=relaxed/simple;
	bh=aadNiLpy1z1Y9kpdwfFvHkwaucQwNaIeAh2PAI7VBvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KI+7LakZXizFib5Rwjc4IxrekIWodNsfCoyfJkTvX3HkkSxxsja+EgS+fvQTRtn5uCfCEa/MdKOS3w5J10R9+NLlR6QP8ewLNIHZxSbbm6MZHjf5h6Soeew/qRl+31Ep2nUQIJoy1Hgp8/SBHKVLAzjDP055UCPS7gfT31PK3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6163466680e811f1aa26b74ffac11d73-20260716
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:dd56e613-edbe-437f-9292-88da8d1a9973,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:dd56e613-edbe-437f-9292-88da8d1a9973,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:748a8c9ffd50345ffd0687e89d40c5fd,BulkI
	D:2607161531395E5N71GT,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6163466680e811f1aa26b74ffac11d73-20260716
X-User: tanze@kylinos.cn
Received: from desktop-od00ebi.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1967845856; Thu, 16 Jul 2026 15:31:37 +0800
From: Ze Tan <tanze@kylinos.cn>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tanze@kylinos.cn
Subject: [PATCH v2 0/3] net/9p: safely abort fd RPCs on fatal signals
Date: Thu, 16 Jul 2026 15:30:48 +0800
Message-ID: <cover.1784186316.git.tanze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a hung task reported by Syzkaller when a thread blocked
in a 9p fd RPC receives a fatal signal while another thread in the same
group is waiting in coredump_wait(). The interrupted RPC currently enters
the TFLUSH path and can wait indefinitely if the 9p server is no longer
responding, preventing the thread from exiting and the coredump from
completing.

Ze Tan (3):
  net/9p: handle replies racing with interrupted RPCs
  net/9p: prepare fd transports for asynchronous aborts
  net/9p: abort interrupted fd RPCs on fatal signals

 include/net/9p/client.h    |  3 +++
 include/net/9p/transport.h |  4 ++++
 net/9p/client.c            | 35 +++++++++++++++++++++++++++++++++++
 net/9p/trans_fd.c          | 10 +++++++++-
 4 files changed, 51 insertions(+), 1 deletion(-)


base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.43.0

