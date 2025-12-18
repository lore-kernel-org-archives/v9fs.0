Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85564352FB9
	for <v9fs@lists.linux.dev>; Thu, 18 Dec 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072901; cv=none; b=G3epAyYbT65CvOywfXg4HwymzXYYyrLrAQrTiMfseV5Ss6O3u6qHp+Am+Uyrgqc6f8cBrsNy3HRvLAooB/SwLSF8VQYeCzgAuyBDGgnSZ8q/JoVJ39Ju33O4pBScQjTTecpIWOX4eRMowJvFuAkE9Mq6FBn0omjbaubh+Jprsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072901; c=relaxed/simple;
	bh=JrvIb7/vexgjtgjPDoQtI2p9c83SMglMjbUpS5UutyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPyngcMB2B87qfYk37WBC7jIWzs7ANZRAuMaCDChfDfDgtP0fUGU1VCTgXmllbVGcZInIN9ufaMxF4XnyE8LXq7Pl4+j0HQF7LpXBraIJn4uHv809lcdcm7K8lJUATF5CaIDxX29q4mrGYx46ckQhN67WAKDylH6HhIg94792xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BQ4ScyBz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BQ4ScyBz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BQ4ScyBz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BQ4ScyBz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A65035BCEA;
	Thu, 18 Dec 2025 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766072897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUkILHHtydyJKd6345vOYj6van+XsE7l7VPm/raSiio=;
	b=BQ4ScyBzO8loY/QesA4Kb1ftoTpUHmm/BvOVSUAiPMJyApXtg2o66vCvy6vqdW9E/43hlq
	BoVY8iZgHeDeQpcnFVAdDgtWk11D/WFVKl/4wewUkyXiN3EvL1YCsiGQX9Q+TcwkRHbuSc
	ZijGXmxpVtGbj6mLCZzk8lUBVqlZFWI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BQ4ScyBz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766072897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUkILHHtydyJKd6345vOYj6van+XsE7l7VPm/raSiio=;
	b=BQ4ScyBzO8loY/QesA4Kb1ftoTpUHmm/BvOVSUAiPMJyApXtg2o66vCvy6vqdW9E/43hlq
	BoVY8iZgHeDeQpcnFVAdDgtWk11D/WFVKl/4wewUkyXiN3EvL1YCsiGQX9Q+TcwkRHbuSc
	ZijGXmxpVtGbj6mLCZzk8lUBVqlZFWI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 552873EA63;
	Thu, 18 Dec 2025 15:48:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +KJLE0EiRGmuIwAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 18 Dec 2025 15:48:17 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev
Cc: ariadne@ariadne.space,
	Juergen Gross <jgross@suse.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH] xen/9pfs: Fix data ring granting
Date: Thu, 18 Dec 2025 16:48:14 +0100
Message-ID: <20251218154814.28938-1-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: A65035BCEA
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

xen_9pfs_front_alloc_dataring() is granting the backend access to the
data ring by using gnttab_grant_foreign_access() for each memory page
of the ring.

Unfortunately the pages passed to gnttab_grant_foreign_access() are
not referenced by the consecutive PFNs, but by GFNs, which might be
not consecutive if the system is running as a PV guest.

Fix that by not using "virt_to_gfn(bytes) + i" as parameter, but
"pfn_to_gfn(virt_to_pfn(bytes) + i)" instead.

Fixes: 71ebd71921e4 ("xen/9pfs: connect to the backend")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 net/9p/trans_xen.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 12f752a92332..a2ab633e78be 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -347,7 +347,8 @@ static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
 	}
 	for (; i < (1 << order); i++) {
 		ret = gnttab_grant_foreign_access(
-				dev->otherend_id, virt_to_gfn(bytes) + i, 0);
+				dev->otherend_id,
+				pfn_to_gfn(virt_to_pfn(bytes) + i), 0);
 		if (ret < 0)
 			goto out;
 		ring->intf->ref[i] = ret;
-- 
2.51.0

