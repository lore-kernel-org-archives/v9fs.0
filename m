Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209F258CCC
	for <v9fs@lists.linux.dev>; Sun, 15 Mar 2026 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773589603; cv=none; b=s3tjPnEGrZZcD3G9/z1IGIz7az2YW0DGDWn4LG9zmdGXv5ZT0IhQv7PtGXnxweMnfYqH4NUqkvemLtcexJnO/o1YsfrMseftY2GcrcYf6d/upoYI6ObcgA+MiYo43/InLe7Qeu+kP/y7BPZ4hhsdgLIyt6EK+OjZ0RrOfRQZxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773589603; c=relaxed/simple;
	bh=iAydSp2SOigKwiJIXzuzx6l3d9f7Vn/peXmnFUF3hCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7YPYJPTYev3kLNY9J3Ob1oXuLd5hJ7dLYjdvYKDklx/QqTOGfQsQeNCjY3lSIX5AGZUikfO5/qrRt+i0ieffYudnddUxz1U14xuzxhqIYb8Z24HHId00X5T42PiB3Lyx5MhAHEoo/PMVz5yEkIgGoBd0G4mP0rjtXerWXxoW7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgvwQCvA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgvwQCvA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so44756345e9.2
        for <v9fs@lists.linux.dev>; Sun, 15 Mar 2026 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773589600; x=1774194400; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M6Ayv+qRbNpeH5TjyhcgtwmRoDj3PFSQoFhk2DqpBxA=;
        b=TgvwQCvAeNiojr9O/HGPKLzBGVvBBQPtcba7slyTHKMFx7FH+8jHNdQIN8TC86VftJ
         qOMuADHiSkr1UIeUPoTW/yid6UfUO8cu9p8ESpx2OmWnVYc+PuRdOMhLjWnPfCCQoEVY
         S04nWphRBZli2Qp43LkcX9zakYhb1JroJB+f9O+zOPIteaUMCdC5JZxRipW/NAHcnHme
         Eq8V2eHqZk67oxpx8mCzwzZmcTGnzhwgwN2rJmknCLzTztP9OV/fIgeXhYydtZzlZm/9
         GcFCbQtnQMU9kLoiOi+WlfdDUXCxJxN06mtCk9LcCUrW4hiZ83KKWwFNvO9Qpg4racfa
         ZEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773589600; x=1774194400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6Ayv+qRbNpeH5TjyhcgtwmRoDj3PFSQoFhk2DqpBxA=;
        b=Fc0/vMIeAZ2QKr2+P4+VgrWIoXcZFMiCDEZCP41h3OxGLqcWickrYQdUBPMG02nBK+
         YBcIcWyYlKzIdJK3+iNYWoFW3R8NxmpCh9SasrfWQ5eOQjb7h3Kv1cEdRdQpb7jvjjQY
         bGZnp3C6sjxxnErqwlPizbh20ReCw7QcBcQYiAtj+yFliWNhOgn8iYQshd03VUlNxeN7
         jsVgeeMv/rtUtDJveUnclydrJWNL89+IO7PixbN8LeZHXMHqKJqAiCuICOBOY7vhM7YX
         SxqStN/n+jjLEOljCAXUFFnlRoSu8I/Z4KivEQrMKnUT2pm2wNy+1W5IO8mZUNDLXoYF
         jnSg==
X-Forwarded-Encrypted: i=1; AJvYcCVV0GZmZ1NWs8BIpty8agUju+4MRWLLb3SEU4qiGnXNDESu8w5i71i+gjsLBc0VK+xq8pJh@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5APVzkRKBhmrt+Gm1NTAYJi5LcVS+aZ6+FT+B47PmW2Nk/hGQ
	dqumXNv+aG4tMwbQ3oGyEUDoq6XKchmdItsP5K4p/BrdbiMytLILhtrMn4wHtck2hE8=
X-Gm-Gg: ATEYQzyMo69PFfC6gukfAUrpz4Sp9u/dkHX2CaPw0paBlc7Kmh0/Y4F7ENCMkUJoVhM
	ILCiOQivLDJmstMxC5oae+8/l4ATvWGkVx7ALyoyNWGVIVu/4H1Iy7iwFHKuxglqAb28OZNMFYx
	64WSZKme8Qmo9O5aC1x7P077+lprGwM01Z+pajUO43jsae7GxL6fhbA3oZ77qGz6vL1hRVYor1Y
	J3cXjaBqEcKOxbpaMERuB+KUv+YodAQbQQ7lgChqKqA0eboFSEtvQu2IRaMw6O5UkQq9UUzu/p/
	EThbV5Cu07hQYcJ/fGD6CLnlcdpAUxaqRArlY2h8ZB/UfIG9UxQNTdEX3j0Fd4HwHfM2ySA6TIr
	W2GUhoApo7JDJ/xvhbF1tpub8IxkxETuzrs04xYnvgfalBOsqZ9d4OpQwuvf2L+pzGKIXrF+Mw3
	ImxSSGD52YmROpTV2L4o4wU3IHPXkljrZQStmn/MSyJ8rpjiBPFwFAYGtEN9ebSM3T3gng11cy6
	CVQfKZb7RD7u8D3BTcOuSBLAV14rA==
X-Received: by 2002:a05:600c:4753:b0:485:531d:28b9 with SMTP id 5b1f17b1804b1-485566d709dmr166345485e9.14.1773589600414;
        Sun, 15 Mar 2026 08:46:40 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3d87b1fbsm9474540f8f.7.2026.03.15.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:46:39 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kit Dallege <xaum.io@gmail.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 3/3] 9p: document missing enum values in kernel-doc comments
Date: Sun, 15 Mar 2026 16:46:29 +0100
Message-ID: <20260315154629.51013-1-xaum.io@gmail.com>
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

Assisted-by: Claude <noreply@anthropic.com>
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

