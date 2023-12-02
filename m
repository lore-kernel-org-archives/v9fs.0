Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385B23B3
	for <v9fs@lists.linux.dev>; Sat,  2 Dec 2023 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRG/7LXp"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ce015fd299so1279551b3a.2
        for <v9fs@lists.linux.dev>; Fri, 01 Dec 2023 19:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701486260; x=1702091060; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REw1mAw66ScsuvDmlw17GMi/wuxgxUo9tJzn9xaikuM=;
        b=IRG/7LXpDRttT603K+ziifo7MaSjLaOJf/TUGrew8NmhUUU01q6D2sEkk5waJiL5i+
         DWlKC6GeVEvc9sRfw5ZdTkW3IZtCeQsHP2iU0xA7V3msnEzOPUKw+5zeoRVZqgKIVx+Q
         wkL0Ae+biDaI0dtcjibI+xmMKDIFd5K6/j8O2Puc4h3CbxqJBs704XrTZ/gPOrQltgti
         izdYyVIjFVQnrpzFgWi5M9XAICMQfAQV4cxBHwYifxMPqs7NZSkU3LcbrNEy7SE+mQxc
         lRu+dGDBEqsJo3AFzMI5vcVngb8XtdZMtB1E/bkXe4pSfL6QZ6G9aGVclFvMiBeewBMr
         cFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701486260; x=1702091060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REw1mAw66ScsuvDmlw17GMi/wuxgxUo9tJzn9xaikuM=;
        b=U8fGpjMtVFiAfRCZLB94JSZdJfc8KQ/MKVI9GW9VTHxZ93bVPMTMMnjUtgVQNqtSEL
         asT75Np7ia4LYbD+eZ24OEvqKWkBEG6bGkqU79V1dRiND08hNxih4BoQmMYBVQEeEFj3
         0E44Sz2LehNIUM6X070vBDb3RQmGsMx9LHb5Ct3ia2LEOv2OcRTsuNp/eapQMqRjrC8P
         wzGk4sFM4+EI4Khiq6awwJHRLmhuKbVVP9M3QZjIb1NnntwMdY9oHH6gZQuOrhUN8H6U
         HaixgjbPvTm5cc+hUz1iKrGBWMfSLWr6rOyAYE0o9rCzH/GU/4jWYqNM5ERyLwzNhL9R
         pMhA==
X-Gm-Message-State: AOJu0YyR2l1YTcuwkxEx4325n+m0hO2xHUD43olyBay8L90aeF55tAec
	9Lmfy1meSBulmaYbfbwEDwE=
X-Google-Smtp-Source: AGHT+IE3KFV19ADFs1mUPExAmlKdN0d9YGpc5JdEEyaRf6nN7+dLQCkmGfnxUJovZiUeI3jwAvt5QQ==
X-Received: by 2002:a05:6a00:438d:b0:6ce:2732:590 with SMTP id bt13-20020a056a00438d00b006ce27320590mr699706pfb.65.1701486259941;
        Fri, 01 Dec 2023 19:04:19 -0800 (PST)
Received: from localhost.lan ([2601:648:8900:1ba9:692:26ff:fed8:afdd])
        by smtp.gmail.com with ESMTPSA id j18-20020a056a00235200b006c345e192cfsm3644645pfj.119.2023.12.01.19.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 19:04:19 -0800 (PST)
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
Subject: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Date: Fri,  1 Dec 2023 19:04:10 -0800
Message-ID: <20231202030410.61047-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An out of bounds read can occur within the tracepoint 9p_protocol_dump().
In the fast assign, there is a memcpy that uses a constant size of 32
(macro definition as P9_PROTO_DUMP_SZ). When the copy is invoked, the
source buffer is not guaranteed match this size. It was found that in some
cases the source buffer size is less than 32, resulting in a read that
overruns.

The size of the source buffer seems to be known at the time of the
tracepoint being invoked. The allocations happen within p9_fcall_init(),
where the capacity field is set to the allocated size of the payload
buffer. This patch tries to fix the overrun by using the minimum of that
field (size of source buffer) and the size of destination buffer when
performing the copy.

A repro can be performed by different ways. The simplest might just be
mounting a shared filesystem (between host and guest vm) using the plan
9 protocol while the tracepoint is enabled.

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
 include/trace/events/9p.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/9p.h b/include/trace/events/9p.h
index 4dfa6d7f83ba..8690a7086252 100644
--- a/include/trace/events/9p.h
+++ b/include/trace/events/9p.h
@@ -185,7 +185,8 @@ TRACE_EVENT(9p_protocol_dump,
 		    __entry->clnt   =  clnt;
 		    __entry->type   =  pdu->id;
 		    __entry->tag    =  pdu->tag;
-		    memcpy(__entry->line, pdu->sdata, P9_PROTO_DUMP_SZ);
+		    memcpy(__entry->line, pdu->sdata,
+				min(pdu->capacity, P9_PROTO_DUMP_SZ));
 		    ),
 	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
 		      (unsigned long)__entry->clnt, show_9p_op(__entry->type),
-- 
2.43.0

