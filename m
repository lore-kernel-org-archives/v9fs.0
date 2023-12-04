Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE630CFB
	for <v9fs@lists.linux.dev>; Mon,  4 Dec 2023 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ual9iV9Y"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d069b1d127so14139845ad.0
        for <v9fs@lists.linux.dev>; Mon, 04 Dec 2023 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701721413; x=1702326213; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVjS70OS71a4UFnI0/y09WP8jWT0Ha288mxabbPI+EM=;
        b=Ual9iV9Y5C17KoIFKPqa/x9162nXqXn0mrIGbvw8eKL1qISNn8UQaCvvdbjNdnxD2N
         TpZGIBRGMFkzypIZCUyUcyioii3QoAbUFTN4XTI4z2I8p8NtfIkYxFURrZBdv6sNkWe5
         UsRFwrq6CIrYDa/dSSuoWjcISFR0G5PjAL3u3xbw7BZpz2pzfI2gz+4QWNESlOXRlp1L
         rI9pCLhG6GpAzxUIWrdsG197QzdWe0WJ9OJ882H478xqUI/gpb0sX4sfSV/cG6zuxl4d
         uIVtp6o/E50t2LwWcykP07OYiHKvLXnl7llrBaKehbeA9H0YrGca4eKbAY2rvVGc0Lgk
         6MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721413; x=1702326213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVjS70OS71a4UFnI0/y09WP8jWT0Ha288mxabbPI+EM=;
        b=B7dcgpDtPGzudI8SS5o9DSigWOHJp43aIOsdxhRGtqUm6ZpaKsJPztBdCD+GrpY2ME
         eyTWtCzd6A0zp/u9k3F5y9McQzpbI31vt+hkE+JN0ewJV1/pkKs61SvcXSqe90mVArBC
         i0Bz3SE4LJmFDeHDc3Q6ePeqLK4lCesEph/RQCXMFOxesqzydkVVZOzLqId+OD82fjE7
         mSALCgi/xJTPSUcFESiuRCIFmXOwCBomFs3qhA6ZknvdzE+NgSDzUY5yt1t4L/YIY5HC
         t5gYB4KFt6q5eQZ7noM4z8bs9fRw6a1R7M5G1dJH9Zel+y999lb3vyiXvqBpSIDjL2P6
         uTTw==
X-Gm-Message-State: AOJu0YxKJFVmhirzhLElqu5DfmtcxMRXLra2DWYV8urFnh0VYMVS7jkM
	ZSw1tfOB0UaAmqHLLOW9bZM=
X-Google-Smtp-Source: AGHT+IEZnHypQNo+wnImWpW1CT4pRSkna+76zEAA20WYV5o93R7E6DkHV3NFild2kYTqVRC4Ks15zw==
X-Received: by 2002:a17:902:7616:b0:1d0:ad56:d879 with SMTP id k22-20020a170902761600b001d0ad56d879mr1335824pll.14.1701721413254;
        Mon, 04 Dec 2023 12:23:33 -0800 (PST)
Received: from localhost.lan ([2601:648:8900:1ba9:692:26ff:fed8:afdd])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902820e00b001cc52ca2dfbsm11740pln.120.2023.12.04.12.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:23:32 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: v9fs@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] 9p: prevent read overrun in protocol dump tracepoint
Date: Mon,  4 Dec 2023 12:23:20 -0800
Message-ID: <20231204202321.22730-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An out of bounds read can occur within the tracepoint 9p_protocol_dump. In
the fast assign, there is a memcpy that uses a constant size of 32 (macro
named P9_PROTO_DUMP_SZ). When the copy is invoked, the source buffer is not
guaranteed match this size.  It was found that in some cases the source
buffer size is less than 32, resulting in a read that overruns.

The size of the source buffer seems to be known at the time of the
tracepoint being invoked. The allocations happen within p9_fcall_init(),
where the capacity field is set to the allocated size of the payload
buffer. This patch tries to fix the overrun by changing the fixed array to
a dynamically sized array and using the minimum of the capacity value or
P9_PROTO_DUMP_SZ as its length. The trace log statement is adjusted to
account for this. Note that the trace log no longer splits the payload on
the first 16 bytes. The full payload is now logged to a single line.

To repro the orignal problem, operations to a plan 9 managed resource can
be used. The simplest approach might just be mounting a shared filesystem
(between host and guest vm) using the plan 9 protocol while the tracepoint
is enabled.

mount -t 9p -o trans=virtio <mount_tag> <mount_path>

The bpftrace program below can be used to show the out of bounds read.
Note that a recent version of bpftrace is needed for the raw tracepoint
support. The script was tested using v0.19.0.

/* from include/net/9p/9p.h */
struct p9_fcall {
    u32 size;
    u8 id;
    u16 tag;
    size_t offset;
    size_t capacity;
    struct kmem_cache *cache;
    u8 *sdata;
    bool zc;
};

tracepoint:9p:9p_protocol_dump
{
    /* out of bounds read can happen when this tracepoint is enabled */
}

rawtracepoint:9p_protocol_dump
{
    $pdu = (struct p9_fcall *)arg1;
    $dump_sz = (uint64)32;

    if ($dump_sz > $pdu->capacity) {
        printf("reading %zu bytes from src buffer of %zu bytes\n",
            $dump_sz, $pdu->capacity);
    }
}

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/trace/events/9p.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/9p.h b/include/trace/events/9p.h
index 4dfa6d7f83ba..cd104a1343e2 100644
--- a/include/trace/events/9p.h
+++ b/include/trace/events/9p.h
@@ -178,18 +178,21 @@ TRACE_EVENT(9p_protocol_dump,
 		    __field(	void *,		clnt				)
 		    __field(	__u8,		type				)
 		    __field(	__u16,		tag				)
-		    __array(	unsigned char,	line,	P9_PROTO_DUMP_SZ	)
+		    __dynamic_array(unsigned char, line,
+				min_t(size_t, pdu->capacity, P9_PROTO_DUMP_SZ))
 		    ),
 
 	    TP_fast_assign(
 		    __entry->clnt   =  clnt;
 		    __entry->type   =  pdu->id;
 		    __entry->tag    =  pdu->tag;
-		    memcpy(__entry->line, pdu->sdata, P9_PROTO_DUMP_SZ);
+		    memcpy(__get_dynamic_array(line), pdu->sdata,
+				__get_dynamic_array_len(line));
 		    ),
-	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
+	    TP_printk("clnt %lu %s(tag = %d)\n%*ph\n",
 		      (unsigned long)__entry->clnt, show_9p_op(__entry->type),
-		      __entry->tag, 0, __entry->line, 16, __entry->line + 16)
+		      __entry->tag, __get_dynamic_array_len(line),
+		      __get_dynamic_array(line))
  );
 
 
-- 
2.43.0

