Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5E44682E
	for <v9fs@lists.linux.dev>; Fri,  4 Sep 2026 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520869; cv=none; b=rNTQ1G43VtJwEKP1vXsUFMvWiI1YAR8e5z1Z+4EXmeBM+MUtjLiSuON0kUJYZuvNxihmAu07m9BIAcXnrVcb8FA8BOqEnlb+TSPHC/vlmoxYOs0Hm8gG8XXWI5QHrqKSV+3I9MRnP6keJIPtVvpzt7USS9uOY0kntEu8fIwKVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520869; c=relaxed/simple;
	bh=YHUSWncJG4kn/isoSLhwcXwtOQwWDC1msBJis3Ldk2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knuwCXvjH3PXppHTcyY77UhfOjqEGnTrjfZ4inVoBhCQ/m4R8pbKxccOtZuvy+3w6wGUU40qYhJxnPQ+U3lSRrcyGCclIM5qyV2Fx0pjf5tAOzp44nu4LD7dzVplPnB9JfpgNxsl77ksXyJ4UGE3xTEfaQHD+PIrBKD5ckLpPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGtU5RTa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGtU5RTa"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d9db539a54so7780665ad.0
        for <v9fs@lists.linux.dev>; Fri, 04 Sep 2026 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520867; x=1789125667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lnTyvksY7pfKvaenvyNkrisVTNLge2aOUQRRsR1U+eg=;
        b=rGtU5RTaQFA144yKMZ6ISxJKWjx4Tpjrwo7GmXBGgJANYVadonZsDDEG59zM2rmnS/
         QW4edyJxWn3eLYKXH5xOKwe5CjHXJ/VzjCkQb15/jDLBttCWSLuOIW/wJfxzt5Z7ip0E
         M8YSzXgZqWI8WOoVx8VWnINhRg7MAsuhQqkn4hdrM7+R11sEHq199lq9VoxBPPi5V713
         gODry/co+I0yk4zegOV3TesOg0VG/hlmCg/Kl7tJkxJAUZFIrQltxzx5NnZPSZz/zIlH
         AlPZ9VA4Rp2JYiWK7X2XwuL0DlQZwMVc9Hz/YjP6xBZC2KgcHWwvXV+mn3pWYd6PMaEE
         qbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520867; x=1789125667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnTyvksY7pfKvaenvyNkrisVTNLge2aOUQRRsR1U+eg=;
        b=H2sVwlgIf5pKbSeR+Cin+mdR9kZtFU3YddzSMCvl1n4W9C1+/uMJvECYjUWgvJkbWQ
         /FOb1h8TVOsSMJaji7tkBvGybDa3CI8FmWfwWWQBvQt2hjaLJ2Iiin89SQ6rxa8QYCy5
         D3/fKQzO9Vhme5kv/n0cVR5yirthV+VwXtVzMaICjLyKdsrFneCxjnCEHAdE/QEY4y2p
         KkMc0uAQ1bDktobii7Fo58K2vZRxZRZ7tHjD/WISR3OvLnU+C5/947AYAR5zRwOOi40E
         tlr/7jImwnhRb4TldKKLo3a/nZj3S1vUoD8rvPZgOKU6pNPfEGemEC4ZpOprqtm6U8BD
         MA7g==
X-Forwarded-Encrypted: i=1; AKwUvBxYWYVsiuGKp1qZ1x8yRwqMUhv9PxFEBnQvITnMcd6p8TFqai0CMKQHStOA/gRFnBP+UL/e@lists.linux.dev
X-Gm-Message-State: AFuF++lFQUjavQpZFQeaTGFggFE6vE0tpCyAFslqcwbBtb9hqtPjhbda
	wdIwDC9RWj1gGHXaw2+uJ84EBExxt3SW0mjEZBxW9XWlLEYJIjWhRt6P
X-Gm-Gg: AYBFou02c9PkWy7f64gbJAxvs5n+eu6uqoU9ZlqBKl09OBkwGJqUbw7zdp9fTCiDAza
	FfermErplL5sKO3d7eI7XhNC3y9dinvI4BEDnxCq+MpLOj6I7ap80+bx1tU9imdzCCQb/EjpAAd
	6etMMCebsDIWVaYTrYwNZXO8iv+j+QKmwX2tPBjaxDodqhyBGJt2W1E8Wbah7njcMUWqun5qKOt
	0PIe0dwJzeAX1Zpz6WmRy15bcouCf0cjgUu0X+0zJjNkcIqfGAnK0C4U7Xy1aG2zWLPRVS0tnrb
	qN4gUVOWmHExohWhzlGRtiYc80AcTPhJWZmTLcF8LEVpACrEaDUX8XdaDLxjV46IEde0vTpLJPR
	Jid9mD3Rt3A80X+8FHn/RGLMMoFZkNma2bHzl4FbhSiBj3O/P2fBB7UPtMuPk4hoTyOhS9tazrD
	JgyxtRE4FscfBUqwNcozyRBQv4N0+F3IEDX0e0Skfs6I0feNEa4DU5XKfJyLsjRX/kI+saYKLQ9
	1bYHUdmbvpbMlY=
X-Received: by 2002:a17:90b:2e4b:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-39b26151b89mr8733669a91.6.1788520867353;
        Fri, 04 Sep 2026 04:21:07 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm5805929c88.0.2026.09.04.04.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:21:07 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] net: fix typos in comments
Date: Fri,  4 Sep 2026 16:50:59 +0530
Message-ID: <20260904112100.34541-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/net/9p/9p.h     | 2 +-
 include/net/9p/client.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index fd7a034b8278..22ab7486795d 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -120,7 +120,7 @@ void _p9_debug(enum p9_debug_flags level, const char *func,
  * @P9_RCREATE: response with file access information
  * @P9_TREAD: request to transfer data from a file or directory
  * @P9_RREAD: response with data requested
- * @P9_TWRITE: reuqest to transfer data to a file
+ * @P9_TWRITE: request to transfer data to a file
  * @P9_RWRITE: response with out much data was transferred to file
  * @P9_TCLUNK: forget about a handle to an entity within the file system
  * @P9_RCLUNK: response when server has forgotten about the handle
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 55c6cb54bd25..f3aead8939ef 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -97,7 +97,7 @@ struct p9_req_t {
  * @proto_version: 9P protocol version to use
  * @trans_mod: module API instantiated with this client
  * @status: connection state
- * @trans: tranport instance state and API
+ * @trans: transport instance state and API
  * @fids: All active FID handles
  * @reqs: All active requests.
  * @name: node name used as client id
-- 
2.48.1

