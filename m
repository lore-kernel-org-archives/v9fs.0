Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2734DB6D
	for <v9fs@lists.linux.dev>; Sun, 15 Mar 2026 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773601607; cv=none; b=GXUA856EtMjAE/iInZxVEjjLTRFuix9g2+cb3zj5hWWnE7OXz7wUe27bcvSi1JclzR9iqQwKqT0nGsn7VHtmR6C37uAbGyTWMZEMnZbzEBZZQ0RJvS29ntOUijKtYXCInn17SfmBHtRg5oRk3uPpWNz84SFCZ7NZsBWErEqR/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773601607; c=relaxed/simple;
	bh=DI+700CtYNosaPkYL2rt6SybCGhWALRSycFS4GbWLB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awQTIkRAGGd06IjIUiX8P4VBWsqX4ziJayO5PzVOPnDoJbR29QYHps/ydz7iQSCBzebzEoFg44S9eOnaQcZt+b2hMHYLeWPVrh4ldA1XayCobGkwrYKw8AZE6Hp6Afdtw1lkZbUDN3W6vVVCMhGOFctqe6ExCA24PgSj/6r6Pc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYIJ3ODH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYIJ3ODH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-485409ab264so26546125e9.1
        for <v9fs@lists.linux.dev>; Sun, 15 Mar 2026 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773601604; x=1774206404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsWcMYH2O8uTc+mZLEWVEGacKr10jMp8JDXFXbefbs0=;
        b=fYIJ3ODHIWrN5zxxazRQn/ki6q/JKmTJQu1EkxoQcPrxrXlr5PG2dw1PtmVAoBxtoa
         NwvypZ8qoUliRJNqYw1IduM6u7jksZv95OHWaKkB5rHYVrC2VyOLdwIKYhqn22RCAQCX
         +Ly8aIdXxLE6hNzg7aPpE+d/Z4O9Y9II3oWF/qGQCJ4JUiF0h9UeuI68wiJrRkE1109U
         ziUBKa8vbWE0iqYlUWiE5ReR7oh7MkEkWSXUxm/h1EuxDrhh9rdrG8yZQiwUzozPkL7J
         DsvNZP0pFpbWEhPMtPIm/Q5T7+olM7TWi4liagV1N3q2/EsbmqtbGj9iAh/fpi5p1Zdc
         iiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773601604; x=1774206404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FsWcMYH2O8uTc+mZLEWVEGacKr10jMp8JDXFXbefbs0=;
        b=pcNjk1nVrJa5o3xB7p1SIQhXK67b1KJPPJn5uU7+dEdq7FNqjSCpf04GW03tMPPfCZ
         0FTJN5kF6xO3PA5AORigCVyK5HnP4jky5lp6ErOhGqHcnRz2rrgNMZfVTEqHQ4chU9iM
         1fVtyPGGLVWrw5mSGDRo3LRy3foMB23CMzDVQUV+/AGo4Bept+Zpdb9A0nYAr5nxRl1d
         ciVqCIpvIdMD6YtDZkCBeBZg4B7Sunuk31+bjl/5bmb2sjxET3ZRPf5owgZGhqKRUGWn
         Ve2+N7de4/oAknJiYbuENgv8rUBI1HQGQCaRrb7gb2PEYfIP8BtgzxT4zza+Xzy30XqF
         +teg==
X-Gm-Message-State: AOJu0Yzn3G+grR/PXU6lUxdIgLKoNMvQunZJ9PqHWuyEp1OIoNnNGLhv
	8Msz0axUXO+29J6UYVdtyw0z1VM5ik5boqhTL7ZeLMsqHXdpFp46U6M+
X-Gm-Gg: ATEYQzyjY908lD15AOvem6J2wTmUf3zJz6NmdLrjzNNCGIMkY+2ItlDx+DLYyt0EDyt
	a0/HbCPOms1MBW06yPFatjlZXaAL1k4sT+PfzU7g2HI+p77g07f4y62Nzc9UNP8BhKJ1i2tProu
	h9cZqFU3OMW16hsFMRX/4g+hWZmtvvi8Q64E3244yZpgoZAyDzPJyqx+rMaIFsz1MkdrT36Zkab
	IwvNEJjJDqQ84JNKfnUZycX3I01gwrUIR7SGyyELi8UkHs0UzuiY0BfOOSah24VVb+/PV+ndnjv
	7vB7FRi7TCpQhFhW8sQg4CclxPtUbKGsXx7hQhQvg+CH+16rtjHK5vlP77TO1WCj7fLp/cCTqhc
	f8KB9P8EFFqfxxDMgjmhNTPDH04jFmejYEClGM8DCnHjMC0mEf5CeOl//txUaqtlI3O9Ma1GwCS
	vvtrzyXggIejC4dY7EaVzOUik9CRt2WrjD+ALvPqBO26UvoBAm50AiikwjDw6XU671PtdHP94Iz
	rYlysomBy2mxUITEGG2kiZcgD35yw==
X-Received: by 2002:a05:600c:4fd5:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-48555b2c8fbmr175177175e9.11.1773601603594;
        Sun, 15 Mar 2026 12:06:43 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e2537c3sm384063425e9.15.2026.03.15.12.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 12:06:43 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: linux_oss@crudebyte.com,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kit Dallege <xaum.io@gmail.com>
Subject: [PATCH v3] 9p: document missing enum values in kernel-doc comments
Date: Sun, 15 Mar 2026 20:06:33 +0100
Message-ID: <20260315190633.73536-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315170702.65160-1-xaum.io@gmail.com>
References: <20260315170702.65160-1-xaum.io@gmail.com>
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
V2 -> V3: Address review from Christian Schoenebeck:
 - Fix descriptions to match 9P2000.L protocol spec
 - RLOPEN: returns qid and iounit, not generic "file access information"
 - TREADLINK/RREADLINK: read/return symbolic link target
 - TXATTRWALK: prepare to read/list, not "walk to"
 - TXATTRCREATE: prepare to set, not "create"
 - TFSYNC: flush *cached* file data
 - TLOCK: acquire or *release*, not "test"
 - TGETLOCK: test for existence of POSIX record lock
 - TRENAMEAT: safer variant of TRENAME, not "using directory fids"
 - TUNLINKAT: unlink a file or directory
 - TVERSION: negotiate protocol version and message size
 - Add missing (9P2000.L) tags to all 9P2000.L-specific entries
 - Add (9P2000.L) to pre-existing TMKDIR/RMKDIR entries

 include/net/9p/9p.h | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index 60cad0d200a4..fd7a034b8278 100644
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
@@ -68,13 +70,39 @@ void _p9_debug(enum p9_debug_flags level, const char *func,
  * @P9_RSYMLINK: make symlink response
  * @P9_TMKNOD: create a special file object request
  * @P9_RMKNOD: create a special file object response
+ * @P9_TLOPEN: open a file for I/O (9P2000.L)
+ * @P9_RLOPEN: response with qid and iounit (9P2000.L)
  * @P9_TLCREATE: prepare a handle for I/O on an new file for 9P2000.L
  * @P9_RLCREATE: response with file access information for 9P2000.L
  * @P9_TRENAME: rename request
  * @P9_RRENAME: rename response
- * @P9_TMKDIR: create a directory request
- * @P9_RMKDIR: create a directory response
- * @P9_TVERSION: version handshake request
+ * @P9_TREADLINK: read symbolic link target (9P2000.L)
+ * @P9_RREADLINK: response with symbolic link target (9P2000.L)
+ * @P9_TGETATTR: get file attributes request (9P2000.L)
+ * @P9_RGETATTR: get file attributes response (9P2000.L)
+ * @P9_TSETATTR: set file attributes request (9P2000.L)
+ * @P9_RSETATTR: set file attributes response (9P2000.L)
+ * @P9_TXATTRWALK: prepare to read/list extended attributes (9P2000.L)
+ * @P9_RXATTRWALK: response with extended attribute size (9P2000.L)
+ * @P9_TXATTRCREATE: prepare to set extended attribute (9P2000.L)
+ * @P9_RXATTRCREATE: set extended attribute response (9P2000.L)
+ * @P9_TREADDIR: read directory entries request (9P2000.L)
+ * @P9_RREADDIR: read directory entries response (9P2000.L)
+ * @P9_TFSYNC: flush cached file data to storage request (9P2000.L)
+ * @P9_RFSYNC: flush cached file data to storage response (9P2000.L)
+ * @P9_TLOCK: acquire or release a POSIX record lock (9P2000.L)
+ * @P9_RLOCK: POSIX record lock response (9P2000.L)
+ * @P9_TGETLOCK: test for existence of POSIX record lock (9P2000.L)
+ * @P9_RGETLOCK: POSIX record lock test response (9P2000.L)
+ * @P9_TLINK: create a hard link (9P2000.L)
+ * @P9_RLINK: hard link response (9P2000.L)
+ * @P9_TRENAMEAT: safely rename across directories (9P2000.L)
+ * @P9_RRENAMEAT: rename response (9P2000.L)
+ * @P9_TUNLINKAT: unlink a file or directory (9P2000.L)
+ * @P9_RUNLINKAT: unlink response (9P2000.L)
+ * @P9_TMKDIR: create a directory request (9P2000.L)
+ * @P9_RMKDIR: create a directory response (9P2000.L)
+ * @P9_TVERSION: negotiate protocol version and message size
  * @P9_RVERSION: version handshake response
  * @P9_TAUTH: request to establish authentication channel
  * @P9_RAUTH: response with authentication information
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

