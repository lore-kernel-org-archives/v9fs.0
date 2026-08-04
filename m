Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52444E655
	for <v9fs@lists.linux.dev>; Tue,  4 Aug 2026 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879360; cv=none; b=bglABYd9xuVFhvVDcUhNDAnVZz3s+pF2q6hvVOTDFmTUEqkiifeW1NaE3FgRhm5qPQKn1bunuXymHZ8Wgf4mDXO9pbNsTuTNG5C/+9Udh+C1MbZcnFDyc3PcjKoOkkMspQf40GvZC6poNz1vvUT8ovmmzEo3TpidEby3GoxNlWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879360; c=relaxed/simple;
	bh=tEcMDoHS6/C19lkFbIVxAgB2kcG2kHidnTH70KxDhC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLTOMhOeWeQbAjRsAw1i8zbii4HkmOOFFSWNjvx8INL+Vmzib7nfSN2d5mrfW8r6XujuDdcZc/sOxjsZGK87irDjY0roszFeGxerF+SEhg1TSzkG5rShmFEQsFAsn17h/ZS33mnkTu3fMagtMi+nas9YZYX0cm/FgpiQkOZ8MGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k65gsUHa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k65gsUHa"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38511175ad3so233060a91.2
        for <v9fs@lists.linux.dev>; Tue, 04 Aug 2026 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879358; x=1786484158; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QH2K5FogbEg2Pu5YlCvSeafRigFtD0Kz01lkbZ2ZcwI=;
        b=k65gsUHa67tMdTerYMWT7GnYSf7MH3SlVX6+FC2rc94MICs0Kl7OPghrf7yi7vq2zs
         Qh771Wti6i1Ea/aU9mUFDvNiXvupWQBdYnjPfOeJeflGEv2wyGNDuDLwgYSarHdsxn7H
         kgZVLBO4sYdd41E4roK4v5w1PT09NOglPM4btFS2gHaKOgfhf7ev/Y8gKvfjCCryt16G
         jLe+BvqxLFLROj8b1eAhI1ToybHPEtCgcmte+npsMHOgj2XTaRCCO1fzsDmoO0Mlze9q
         fyLuUSucvVIG+pYUe10877konupISSWNfqWZKlX3HalNzL4gxGwD13M/gZlAv/EocIoP
         nlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879358; x=1786484158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QH2K5FogbEg2Pu5YlCvSeafRigFtD0Kz01lkbZ2ZcwI=;
        b=URTvkdAuEtlQeMmPOIvVN0HNxRKCqL0PWtQUmgvPtNe7pB7/dlNgBS9LjN02J/gNed
         FAK/Q5BYPDtQyza8z1x3CB2KFR7ClCABuJ9Br1zKzZNnpBy/FDmpvKr0MNAai/Yfk5iL
         ZnnY8mEDlfBgJsQBEE2bGRp3vLv/RO+obEJjtvigcUBD1qTIXeXasAsfXDah6hxMRodQ
         yFvI7y9tZVkQkseLXy7fnHvw8LGr7jHk6rsaGxFWF7Z41Pm8CI/TMzjrbYX1YKDQ3l3G
         5ddS6o+W52raJv+9iiN9kwsLFZteTI8AC/Vd9jPjbhn9+McG0FLS2JB9NugHliwzGROL
         M6GA==
X-Forwarded-Encrypted: i=1; AHgh+RrWoI6DHwfuStygrVriXiNkEyeBDK9vs1ADYzLL0YNtkzO929kQjO3In2Yviiy+FIzBmyX9@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+oGbhW2EJZATELC6kOyzUbvRdyjG/+U8PaEuUEKQr2LLBQcCh
	dnFKWPhn0JPkheo4E1H+qEd0aSUY7NPorpDhG1zF/WLvmrehNElWl8bM
X-Gm-Gg: AR+sD12yW82JWOBCJ/1TiHmqEC29ghT6F+rAa10JM/MZ+wExklvyUWS7i4iTD3dijm4
	oZP92yhPbW3UMMCw5zDdZp6V4srWc/igR2M8ERV8tSMmQfhEfbusBWKk0DaUdbTLGFSjQ45tqsS
	xKy4QC/VlbPHOja5X42tghQafQn6aDeWPhe3WX6F+EJrdcS1NEqZKoKmj19VWiyrgfY4cSxReTP
	bb8Kyb67b47h4bf/2DKk4ByGoJmITqlxWYiOSrlNo5zDbsO9DgKXhFu4rP4Nm3XRedy539Wwmoh
	avRsDNXwPIXdPb5906EcNMZ5U7mp8AKbkAaPFx5cqObXs4IWjXU/80KSbiEOjvqDP4ji+nvrQmM
	/u/S/hLpqj6sZzf9IdxJytXsT6S8ueDvKfUZ6Pg0dadZT+KsHa1wnLsGXwQh9V7psGA2fS43mx5
	ud9ZdgYfm96hStvO2qHL84lPum0jQmIv8Es9lnqvAQRyqHwsyMW6nH1f3fcltuoXM532Ik3NQPi
	+2p2sSKktLR9FJvoPOazAC2xPNK0ve8HNPf603hcBw=
X-Received: by 2002:a05:6a21:50b:b0:3c3:8aa8:6caf with SMTP id adf61e73a8af0-3cb85efb72bmr1956240637.27.1785879358555;
        Tue, 04 Aug 2026 14:35:58 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586447d52sm7628775eec.12.2026.08.04.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:35:58 -0700 (PDT)
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
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] 9p/xen: fix refcount leak in p9_xen_response() on wrong tag
Date: Tue,  4 Aug 2026 21:35:49 +0000
Message-ID: <20260804213550.3409638-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Drop the reference before continuing, mirroring the equivalent path in
trans_fd.c.

Fixes: f66c72bea129 ("xen/9pfs: receive responses")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
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

