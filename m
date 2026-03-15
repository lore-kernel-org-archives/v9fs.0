Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1B5373C18
	for <v9fs@lists.linux.dev>; Sun, 15 Mar 2026 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773594436; cv=none; b=KhcCbXRSar2IM3/KhAcWxZuk6zqivr/0M2HQFMZ6hyfMOQlFyMkMPGQcGVB/h1ishFHaBnHRy6NPlKBFrFi5Ebu6ZbNRdBBpiUbFrLRFO2LxYXxBAtuFFzgrJr3mSJ3JHV9ifoTlFdnx+C8fQki64QtjEeMTz2dvsxTFoMZabWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773594436; c=relaxed/simple;
	bh=d/R4+TuBHELKkpXTQmZVyBd4sGccYCnSg+xWcrV6+VA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyALk6Ao9UPwRp4XTCzWK46YPaP/pF1di7wNH+e4PVzXwTZ9H6VrOnQ3IGRFJwjVnZMV8/GwB3wa09wV9uvhScb3QmjG8lqXpdErZ1vzNtVkaymU45qL80e/W2DOhlEzeg9lQVedmnlggw3C7wg0OeYcvzpmSsQ+DRRMdBEusxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc7odlh8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc7odlh8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-485409ab264so26141175e9.1
        for <v9fs@lists.linux.dev>; Sun, 15 Mar 2026 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773594433; x=1774199233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9CtlmBlx+I8Ll0yQI7Nk9bmvuVR4UyWp0VZA4+45g4=;
        b=mc7odlh8WjlK9WoVmo/9aZCn+sZqCuH5RoBH+vpd1K7eaxK9jxbvkYShMPSHDN9pLB
         NV3hSgoJ5tRJa2HAKnwkBhnGCl6pi8XPIshz9hTfmNrDOnDyGvww9GZmW3PLHWxV1gMq
         nsYCrWoC+X0XBgUyS04mxapSV7CUf06R3zF1R4yzfqK8fkN9z4cwPsRguzn+GTRLBAJj
         n/eOWfJQaWs53v41BxNyVtyRna/8iYsgvMiQgYrD0M5/rSFuQM7EWRCPvF6s5//nKTYv
         YIq6ZeHnWtq5eZvHcsf+RhpUs1KgpeB3KS0YPnxe2Ygac4cEzSqoB6szyoPOMdtyGwbe
         /8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773594433; x=1774199233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9CtlmBlx+I8Ll0yQI7Nk9bmvuVR4UyWp0VZA4+45g4=;
        b=IVXhXNxfnPBdAyuhTHmOEkxU89qJOMWABW1QIeApcwVERLkx3WUuE6UvgMy3S9gMkO
         S06ycc/8LddU20ohVmjwcL8DIQpmDiG0WaHIxQrnBNWd73XCaTJWj0tSYjnHsxo+oe/D
         A1cIR8D1OvazEKRUE1/i+pEvPdwlSK+znNAXVFpx1U6HLDFlgyEsE5+Ult7yTQ4dx+Dh
         DpWkNLa/6EP+QexFjcp8AGPsIKnlHogYdG62mgOJvCEHThbvjP+1fFKvGo2Tcn/dKOum
         ivB4LbtkLEOM+J5/NYNCqQ6wVIqsS0SVFJi/3A7iyaCAXyfEa3VV8ShGmd0PhGnvl8Nu
         VvDg==
X-Forwarded-Encrypted: i=1; AJvYcCVKhiKfPYbevY+P85BlTjs/x1d3P47YQztZ/kB9xnG6JLEdVVxRW+wspY46NdjUre7HRYXT@lists.linux.dev
X-Gm-Message-State: AOJu0YzzbX/fXVdftrPKF69FNY/vo4xRi4+6ToWMfv4VzmM5xzwd1b+7
	lm1gKPSgZ+rQTJEEhAIHLY4HST5QjiYAq4bG05jS8fV9GO18wVfXIdzs
X-Gm-Gg: ATEYQzy5FPfKoeW+Gbv4P63bM0PoOc+iDYtVZZGNNMZtE9sqyUbwgIht1igZ5PBe42c
	aEjMOVY/Wr3HydAJ4O9FEfEeGdMvID0NO/gcYQC6mwz5s/CQQtkNGBlmz8Zd57uMnONfiAG2ZCd
	iT/Q9NbF/CL8mihusZ8SvZaDoSnFvUvk1U6ncL1/ilHiQ20BXo7oXTQSnC9iJUebZTB/ZFgdNw6
	Jl94EH4039pjzo4s+hI5tguoCr8Ldnzp6YhymjK/lLmi1UUUE1YMGDFm294Hqk+lANtGxV/NTUe
	ndtIBb+lEqzeov/iPYeUFZTib3bPc16DDg3sYylLy5z9PQ7Fb4c7ONZ3vpxqX9Nh8HONRB3ldS4
	MiIUDZVToiUg44TX1eiLxwj7+aK/9xLiTVp6zXckyFookbfYvHZSTaEdiZknFjmXSVDw5uiJ4/s
	T9qS1nPm4xOnYoQEUq6wlonZ7QkhDPrCm5CvLQqIJu3XNtHmeJJQW2eofJ2INBzj/SnbJ7ARUpv
	/yNKhMf2Phjgv8UpXPhfjoEHeK7Bw==
X-Received: by 2002:a05:600c:1907:b0:485:50ac:b8cf with SMTP id 5b1f17b1804b1-48555a5689amr168059915e9.0.1773594432200;
        Sun, 15 Mar 2026 10:07:12 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm940069515e9.2.2026.03.15.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:07:11 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] 9p: document missing enum values in kernel-doc comments
Date: Sun, 15 Mar 2026 18:07:02 +0100
Message-ID: <20260315170702.65160-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-doc entries for all undocumented enum values:
- p9_debug_flags: P9_DEBUG_CACHE, P9_DEBUG_MMAP
- p9_msg_t: all 9P2000.L message types (TLOPEN/RLOPEN through
  TUNLINKAT/RUNLINKAT)
- p9_open_mode_t: P9L_MODE_MASK, P9L_DIRECT, P9L_NOWRITECACHE,
  P9L_LOOSE

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 include/net/9p/9p.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index 60cad0d200a4..6b645a0d3487 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -24,6 +24,8 @@
  * @P9_DEBUG_PKT: packet marshalling/unmarshalling
  * @P9_DEBUG_FSC: FS-cache tracing
  * @P9_DEBUG_VPKT: Verbose packet debugging (full packet dump)
+ * @P9_DEBUG_CACHE: cache operations tracing
+ * @P9_DEBUG_MMAP: memory-mapped I/O tracing
  *
  * These flags are passed at mount time to turn on various levels of
  * verbosity and tracing which will be output to the system logs.
@@ -68,10 +70,36 @@ void _p9_debug(enum p9_debug_flags level, const char *func,
  * @P9_RSYMLINK: make symlink response
  * @P9_TMKNOD: create a special file object request
  * @P9_RMKNOD: create a special file object response
+ * @P9_TLOPEN: open a file for I/O (9P2000.L)
+ * @P9_RLOPEN: response with file access information (9P2000.L)
  * @P9_TLCREATE: prepare a handle for I/O on an new file for 9P2000.L
  * @P9_RLCREATE: response with file access information for 9P2000.L
  * @P9_TRENAME: rename request
  * @P9_RRENAME: rename response
+ * @P9_TREADLINK: read symbolic link request
+ * @P9_RREADLINK: read symbolic link response
+ * @P9_TGETATTR: get file attributes request (9P2000.L)
+ * @P9_RGETATTR: get file attributes response (9P2000.L)
+ * @P9_TSETATTR: set file attributes request (9P2000.L)
+ * @P9_RSETATTR: set file attributes response (9P2000.L)
+ * @P9_TXATTRWALK: walk to an extended attribute
+ * @P9_RXATTRWALK: response with extended attribute handle
+ * @P9_TXATTRCREATE: create an extended attribute
+ * @P9_RXATTRCREATE: response for extended attribute creation
+ * @P9_TREADDIR: read directory entries request
+ * @P9_RREADDIR: read directory entries response
+ * @P9_TFSYNC: flush file data to storage request
+ * @P9_RFSYNC: flush file data to storage response
+ * @P9_TLOCK: acquire or test a POSIX lock
+ * @P9_RLOCK: lock acquisition response
+ * @P9_TGETLOCK: get lock information
+ * @P9_RGETLOCK: lock information response
+ * @P9_TLINK: create a hard link
+ * @P9_RLINK: hard link response
+ * @P9_TRENAMEAT: rename using directory fids
+ * @P9_RRENAMEAT: rename response
+ * @P9_TUNLINKAT: unlink using directory fid
+ * @P9_RUNLINKAT: unlink response
  * @P9_TMKDIR: create a directory request
  * @P9_RMKDIR: create a directory response
  * @P9_TVERSION: version handshake request
@@ -194,6 +222,10 @@ enum p9_msg_t {
  * @P9_ORCLOSE: remove the file when the file is closed
  * @P9_OAPPEND: open the file and seek to the end
  * @P9_OEXCL: only create a file, do not open it
+ * @P9L_MODE_MASK: mask for protocol mode bits (client-side only)
+ * @P9L_DIRECT: disable client-side caching for this file
+ * @P9L_NOWRITECACHE: disable write caching for this file
+ * @P9L_LOOSE: enable loose cache consistency
  *
  * 9P open modes differ slightly from Posix standard modes.
  * In particular, there are extra modes which specify different
-- 
2.53.0

