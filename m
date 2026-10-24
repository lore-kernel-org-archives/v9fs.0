Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833734;
	b=bdFz7EQgWwKosd3EX5z90ZBvS+yS8xvQsE3CaCBMOnIAxm+glkCYZElN/XYr5FlUth94
	 2yyoG6SPFD7Y+BmFfpC0DDlBRTftK60GzaBj3lcLJlFROqHhqyDYV3daa1xP71dU/TyYx
	 K6Sm6JG1GhF2X3JusdUdUCafiPGw1Zcd+COzklOlIawG7KznEw4xBPwegS5kF6U6sF7ZX
	 H0x4ev0QVIkHKRhejVAVarbsJdtx9jPcizsRqBPGOxcRfXawbFDetTemxppbLztjiS8nS
	 dc7CBpIK75enYuBW3v6h71II3EAaebXEJhBn5wHY/GrTO5ZYzKiry5XKfRucl+41foA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8UxGyEsK1TTsAs2PHw++qV37HG8gWyYxh3d4UgtmYeI=;
	b=gndn03AYGSnE4n7SOF5zXilNDd3gvQRdoHTw2apdktuJFy4aQFhzwY44GA2e6Q5fkGza
	 TJCKVRTdUoJCwsuRJpAfn/+tmii+27YS2R2UXK8pn0BrVj5urTSNMekh7wc+lHwsFRCv6
	 Rj0+AvEOTw0z2ylPT8oycAnZvlswBKMluqgsSJnhtvcvKUgHSUvA7++xitNeDDZm6kTqP
	 PHR9R0ZZdDp+kQLxtdxb5TQFeRLyhB+FmqBVtDo1fWn7T414iD7M2ou4vVDMOpVHCzv1Q
	 xYxuFDJ0bKZXef5Gw7YdSITDZQ0EVagGzxkBZZBWu7vel76yIqwAWyk5LbKpXu1aFmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kWIrhg3J;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F8606A31A
	for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 09:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C1F8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kWIrhg3J
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2838557eec.1
        for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792833733; x=1793438533; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8UxGyEsK1TTsAs2PHw++qV37HG8gWyYxh3d4UgtmYeI=;
        b=kWIrhg3Jm/Vr0wUoCQf6ZnxpeeztYrXUVI5pU4lH+ITtE+pnV/Jpw43s0OCXGknmyu
         OumMIzpCbm6evJH9VvanIZ5dsZaeFTpdGmQhBxUhv48IRl70EUgGFPrY9O3wVNfB1Yz3
         iGZyHeJvM60gV+fkXYJbSBwzGV2m3+vTZccVv1eD/0pnOyhklsF/nKr/1OgX5BJUFvcA
         4zOMZbYud+PW605VW6txw7zhbOVeQvmR0oyCIeOBX4AK/yPpOmy5p73J0e/bkbWAMD26
         L6fD7YjZvq1/HbtsKj3wH1aL+uEvspcjWt6NlTZzpbwzv4+WmfyubWJoO/az9AmqSEaC
         T8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792833733; x=1793438533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8UxGyEsK1TTsAs2PHw++qV37HG8gWyYxh3d4UgtmYeI=;
        b=v2uHuxLcXTznOqktMy+ugbcRSlRF8TN8MC0nOqElyb7V/LmMnI7q0JaDMhLDvfadE7
         Y2uTb6ofcrXOYmZjYLeH2oURXjPtdjyTN8y1BOCRnktVb1t3T3WJVU3tYNLYOUEzfx/+
         +MfDA7/G6N9J1bCMHFm41nnBVjucuh0PBVjg/c+l7etJar38/KPJTH7TuykfMvHknFiZ
         AT15OqGLXiU2RWQwW9mrkVwrpDfZ7tHCC4qQR2tRI3Yn27mAOmFFp565K3uaEhz/Z5fd
         22ec8LczSp7f7pa24Qk86SmSgxgPWw4y/HJrpwQ9Ccd2BqTGIY6vIJcG/LEytMEV9vC1
         ncgg==
X-Forwarded-Encrypted: i=1; AKwUvByf+lPwRFzAqowc9SBIim/RKrqVMh0X14oXkQL/Prsx2HwTmMKHhjLorXd2amAlAqH1iv4A@lists.linux.dev
X-Gm-Message-State: AFq9FYKIsiggMcxoCr3IH4VXGIuukZ3GgpbTWxT1EfLf7R2DjIbeHZL1
	oyVTdYMTauxlXIjQiynXv13pwbmsaFGTrbhk2EXAKxH20wU3dkWduBZz
X-Gm-Gg: AYBFou1vr/obbScr5+NBtJPOWmepkpcxl9/vr9eUOC5l6hN/AYmsvY0eWOJTeOrA6D+
	V4eufcsdJdQrkVWIHzvdCq9dAHO+BcYWBjOZ9RY7i3tBzo21Lxmj4zclzk2FExY/prMvvO9uLbq
	mTbQajkiGcsoXRI+6opGC7oS2vgubPirCEtGlQPDl0HecAJWV3vq156CCp8saCOHFfgEuJ2Lnd2
	lXfs3LpP36E8lUkcprjh1tSx9Eyt9sUZH992GBXX017z0ccSXxlI4IT5JMyNUsdKxk6IeiUAqKI
	pH63NE4Q8wjFIDLsWRDmK2FP/I1dl4bZdvfG58rwwoOt23Ax0qdtiZFekhkhJRyJaNHpZKWATfj
	L8hrBikBqvV6hcUJaFKftRRzk68aKuSBHJCIO3j62DghTwJ3HPszPEGj5mc9ArZaiJuuG5fDgwf
	DoFEH2Nyn8o4aImk2gfMot4NQBT5lKOKWpJXIyCBCZLBmyjRrlcVuxoGej4a95FAyFOPVJ2e76e
	d2KB7p/7MSbUWUN9xDTRrwqaj5pqtnVtS7iNKrbkgmyLWPFmU0CeuxWSiR4tlrWf839a3xGz2p+
	4LhyZRrJBlYG1Ed3KM5vOnTfm4JbrEkrvhpqoEhhk+2gN9QpnCm2GZVjxgfAsbxREB1e7+Y10jf
	lNf/J2g72p4PzKMB1Lkbg9gj08w==
X-Received: by 2002:a05:7300:da05:b0:33c:e74:4624 with SMTP id 5a478bee46e88-369e84e93b5mr2335562eec.27.1792833733242;
        Sat, 24 Oct 2026 02:22:13 -0700 (PDT)
Received: from LAPTOP-VN8JNK11 ([111.223.26.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db450bsm5108584eec.17.2026.10.24.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:22:12 -0700 (PDT)
From: Ankit Thakur <codeankit.thakur@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ankit Thakur <codeankit.thakur@gmail.com>
Subject: [PATCH 1/4] 9p: fix header guard comment in acl.h
Date: Sat, 24 Oct 2026 14:51:51 +0530
Message-ID: <20261024092154.1844-1-codeankit.thakur@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The closing comment of the include guard says FS_9P_XATTR_H, but the
guard macro is FS_9P_ACL_H. Fix the comment to match.

Signed-off-by: Ankit Thakur <codeankit.thakur@gmail.com>
---
 fs/9p/acl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/acl.h b/fs/9p/acl.h
index 2d1b24abc..d123ab613 100644
--- a/fs/9p/acl.h
+++ b/fs/9p/acl.h
@@ -51,4 +51,4 @@ static inline int v9fs_acl_mode(struct inode *dir, umode_t *modep,
 }
 
 #endif
-#endif /* FS_9P_XATTR_H */
+#endif /* FS_9P_ACL_H */
-- 
2.55.0.windows.3

