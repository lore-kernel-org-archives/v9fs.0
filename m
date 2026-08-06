Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AD3CF678
	for <v9fs@lists.linux.dev>; Thu,  6 Aug 2026 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027396; cv=none; b=ZC37LG6eZGAyQz5Pcb/U1Iutu6q4b2qouOCdKdaHS8O83ZYTfag++Vj99uHV3h0ssDk9L9DOzSwpxeog3IhNeo9ah23T0IGosBMV1xwdRCh99yuHVqebPnE6y45LrgviDkvSO9p3ymVX9kJGmK2DvEKFWJMJQRLjbTJ6/EybL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027396; c=relaxed/simple;
	bh=QXyumIIVVZEJjd14fJDOG6kk/TauhmZNZgQBcQSuUAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGkiC720o9eH6VwYkKggQzKMrglkdvEWGSH75yDN+b9HVvpQeeAd0Mrp39DkfI/rhJOt43zoiqzTv0ELTzqK+NkOcziqT8AUB/FXMpjJEb4yzaJp5WRVxQj1Icu0LDomeo/nTk7tpv5pH4nNX/W8qiV6DFo/jrMFF489EfGd7kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8I+wos1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8I+wos1"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e533aacf2so126641085a.2
        for <v9fs@lists.linux.dev>; Thu, 06 Aug 2026 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786027394; x=1786632194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQCss4lFgE6Dwf1NizCh8ZHT2e94D2G9yvtYGo+Xll0=;
        b=d8I+wos1zAXGD5h13P9ArDE2ucerrObYlzHoAr7Aj8GSJi8ZSeEszdgF90MJ+UQmbo
         FcPIxvo9gdBedTCl8BfZqhMbmKA2rc4ZYP2qrj2ubZ5jY0v+QzXXxbDk/kHYLv+7Sc4e
         wbRMKyO9JlyqXE7p5Q8tgkU4eJROAAt67iVNG0l9p6Ru3tq2/U53IJYF4zbz2bDzXD7S
         x1iyl2n4YIjoxSiGfEA2+fqmTiNZIW3C4cAY2Qx6Eas9bll7VQXGKxgkIrXDU8KBKPIC
         VDk9wu0qZLndEdtxcdtY56aNqfxF3EISFuqmd/+XGVzbD2lLVdD3au8o6Wtq4cL5yjFH
         7NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027394; x=1786632194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mQCss4lFgE6Dwf1NizCh8ZHT2e94D2G9yvtYGo+Xll0=;
        b=qjSCgR3d9bkYX12LCe/OMIqXXeeJaKr23fY7H3H/7tMqIv/Nw443bE6/rRL8+1xq8G
         fZB3MC0xrbRotCZw7SPOWnvBXjvtJJ1+t+koveBPCH/kLUGJpubmqFPFs45dkzR6FeSr
         ZKButvAJBMoiLHXn+gWFByLcJib2DKHg4fkYjssS3dVeydvRqY9lXIH/Vr8l7pzwro2C
         wKHoZ+haksSbG/pyUmNVcxchSGd3N5abGWGJNR0oLRfFJh0NIhUj8BfPVndZgcg/WRpZ
         jVmC1k3h+ESQlPTbyDJDYIeh5NEkedFEiWlWUnnfmY9B38qMYurFRvVvWLyPJNda5Rk1
         leoA==
X-Forwarded-Encrypted: i=1; AHgh+RpCtI3WyoCEpHypcdVumJHGlP60zko78wiIUrbzExJcr0Fu8sZsS+xyPQslgANZPeTY8ZXq@lists.linux.dev
X-Gm-Message-State: AOJu0YyKwggIpiRxN90UGT90sGXds3pRP0YOl5MH8xRYFINpMjQLUD0s
	xwskr22rIA/UR//lOQVCCEDgdyW2m3dR1GY2QLh/sI3uwnw/3VLc8BuT
X-Gm-Gg: AR+sD13ukyqlkOP8vxpUCb7HtEWxTJKnwxlfVZw35N4P9gdz2IGYOBTb4frNXZ6JRJQ
	/ZPrkNbbxUlfQkZHD5QKeYb9FF5HVeCHue/zrgb0Xs2PAe9XrxUVMUU1FG8StdcsMKVa5Ozwl/1
	6VGp/G55+NpkrNUwtsi2jRP9PtbJLx/MWw2CRbnXevUPQiTN27y4wcVTjeaos7v61q7Q3/ivyZ4
	JAo0s5haSfVFwf6iC2AqZUXM04wgngVHXm5OseUmM/Srl/SCoDZBWzdppVo/vdJ0BZhdyj9JGJ+
	QizfLijwn1gTIXxaLddlq6+T5bwNQ/QsIH+q4gaKThHD7o4DQetT1DbKBSJuCK9Bbez19YHqidx
	aXw2h568Nt+kfjrha+ky7ypCfUDyCkHNBePoVM38t6rs2rxTXaRHfmmT1QGWD/x743aCM65wW9L
	nqprVlXf/mGaRuXFevvBGEL+y7d+UK8Mq5VCuKkI1FzzZ8OhPm6jEPar5V023Bvf52LFN7lS59E
	IWhLqDlGWu3DiAHYAwcW864XvoJeQGjc5Us7/GeLAA=
X-Received: by 2002:ac8:5e08:0:b0:527:f0a:ccbc with SMTP id d75a77b69052e-52ce5fa28acmr159831981cf.18.1786027393869;
        Thu, 06 Aug 2026 07:43:13 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9088a219ea8sm35070376d6.37.2026.08.06.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:43:13 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	v9fs@lists.linux.dev
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>
Subject: [PATCH v2] 9p/xen: fix refcount leak in p9_xen_response() on wrong tag
Date: Thu,  6 Aug 2026 14:42:54 +0000
Message-ID: <20260806144255.4167019-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804213550.3409638-1-gyf161023@gmail.com>
References: <20260804213550.3409638-1-gyf161023@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p9_xen_response() looks up the request for an incoming reply with
p9_tag_lookup(), which takes a reference on the returned p9_req_t. When
the tag does not resolve to a request in REQ_STATUS_SENT, the function
warns and continues the loop without dropping that reference, permanently
leaking the p9_req_t and its msize buffers. The reply header, including
the tag, is supplied by the backend, so a malicious or buggy 9P backend
can leak kernel memory on every crafted response.

Drop the reference before continuing.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
v2:
  - Fix Fixes: tag to reference the correct commit (728356dedeff).
  - Drop the inaccurate trans_fd.c comparison from the changelog.
  - Add Reviewed-by from Stefano.


 net/9p/trans_xen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index f9fb2db7a066..8eea0da8797f 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -203,6 +203,8 @@ static void p9_xen_response(struct work_struct *work)
 		req = p9_tag_lookup(priv->client, h.tag);
 		if (!req || req->status != REQ_STATUS_SENT) {
 			dev_warn(&priv->dev->dev, "Wrong req tag=%x\n", h.tag);
+			if (req)
+				p9_req_put(priv->client, req);
 			cons += h.size;
 			virt_mb();
 			ring->intf->in_cons = cons;
-- 
2.43.0

