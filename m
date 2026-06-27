Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E2282F3C
	for <v9fs@lists.linux.dev>; Sat, 27 Jun 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594633; cv=none; b=HSOM4swg29J9oawjjQWtGhrc/TwQ+1qdbGOaSvZY9DgewY7zvLMGuQTngq+OINiTHq9CDh/Sv9iMucOXQtqVwCf8GWQ3AEUo9qstEkhq/sLXzTHcKIpx5gDzF3lx4vlg7XqT5ysVHs+gXptnJaqE4/Ah0+rk6ocH3TOHpQTKx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594633; c=relaxed/simple;
	bh=md8u99Rsv71oNA58KA/ltOKBoRbEgGc1clDD+mcrcns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZCZR0K9R7o4xAUabanlUfGNNkjT3xtm5i6PH1JX+HA+UQVNJ8hIjZPxv8Ihjz0sZ2O0a1PVUUxMI5JXImvD1AtC6Un5eIzy1B6QwCW4c3c2NYV+w5TkAqglvuJ+N/Cs5wHn8nB1tdOQ8oUtcWY6Zt/YNvH1VPwMC2qNfD63X/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4vWEtbP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4vWEtbP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92213351918so284715285a.0
        for <v9fs@lists.linux.dev>; Sat, 27 Jun 2026 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782594631; x=1783199431; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXVVHr1pzRpCgstdGFWJchynEB/rshfqTO7LghYGjjA=;
        b=L4vWEtbPBHgUZ+OjE0t0v32oHl5764Lty6vzymJKOfM6Fdm0DUiFbbXrUy7AY0aJYB
         r+Xzrc0DUqXim/HBKHWkl0PhY22jG7VRgWSMIXj6gNW0mMu/t539n27axcRy3jI6fcQm
         IscVaSKX5RpW6iuPS5V+mfiseKvYT6yUP/va/ZnJPmSxxC0JY+TB6K2I6bw1uLUHfUN6
         NeaI6/GpjVLoS0cUOYiDqamzURWHO1/8VLy6sI6b9fSNCca1DoIaQ/6kcKso2TBstzV2
         m70BISj1oVgxiWgBv9LOkm3mvwJ7z7aJgNIdYTRU/UYj1e/OJMIrE5NFSofhyb4iCqDV
         NElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782594631; x=1783199431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXVVHr1pzRpCgstdGFWJchynEB/rshfqTO7LghYGjjA=;
        b=mHBT8AicfyMmlYLz5tuNY94OCWgEJMNAwVMO4bsypfoHRKwTxc5TeffZ9qdP7A++M+
         5hBHT6zN2QDN7LA+7i6PMyIXukwVRTock1mSPznM0beCc5aaMu6C/uMt+DSR9OsKG8EQ
         Kg3RtD5J04unDURAYgHOLql4ULyMrDP6FAR1lB/FDVOa/f4R0eBp/Y5N1aJkH2/v7iVy
         PZtZVRLDwEPqVBjuURDQEHoybbezqGIN+fkInRzMT3vVeYA5WOfQm1d7kZGG2eHw6D+J
         DiIbYfXBKJW9E4kLkLDR4gafVwcLp6hDjgObTlAMDaZHBfVKXv5+T0x6hpqJlySA7myG
         noNw==
X-Gm-Message-State: AOJu0YyFW5wdnqjWK1kOZO6X5iLbjfPu4duK9Pqeqiu+I9nSG6lbW/n4
	8e2FfxTKWa3//ANm/xfbyZrTQShAcFiEv9hd6vx+e7MHxUiwyV1ytAt7srU35hAn
X-Gm-Gg: AfdE7ckKv+K3NCsb1th5iVTheMb4tv7RyXzUTyIRXsadff/hfi6n+ZRMFoc+rP967Xk
	Qq2AJ2GWEMtcwrWGDvv5eEykFTSUctazFWdaLp8lwQtDXK1n8n7jJILTWAWIDaEofwCXDbvp7W5
	B1fpsuNTYX5DByW68OxrAno90vlEuNQXHFLUdVFKF4iLZlXzgvdAp/fAEEdJOQwOepy9bhPgsLG
	oB4fqQ5KvrdYzBN+BiLPc9sB3JEGztexOV/gFOlOxdemwBZ8CFmG5u6MiyPOD+ormZZpjhXEHOT
	sBEsZKllRE1u/U0QX2yKGZ31TQcTvs0NhVk12shI9ZFHA8uE0/rGc6LNy6mk+xOvZ9AaP1ytOm5
	+48aeRJx1cTWOyjaEqeHwGxD+K64bx/984T5uETwBCi6GhZX4EFLVQZHN1lJApYDeSCFKgv0cOd
	FinZLz6FYmrnvgDJiReTSG34htJMN9HydjvN6m85nLSW3A0SACjHP6LLgXFj04mvDWWD/QdkqaA
	rt7IabqtWoNQkrhOnnH0xm6WU1JAgwg
X-Received: by 2002:a05:620a:4399:b0:92e:452e:bcf with SMTP id af79cd13be357-92e452e14aemr233326385a.12.1782594631512;
        Sat, 27 Jun 2026 14:10:31 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fda62183sm1587373985a.13.2026.06.27.14.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 14:10:30 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] 9p/trans_virtio: reject mount tags longer than NAME_MAX at probe
Date: Sat, 27 Jun 2026 17:10:12 -0400
Message-ID: <20260627211012.4042372-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626111906.801890-1-michael.bommarito@gmail.com>
References: <20260626111906.801890-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

p9_virtio_probe() reads a 16-bit mount tag length (tag_len) from the
device config and kzalloc()s tag_len + 1 bytes for chan->tag with no
upper bound. A malicious or compromised host can present a tag of up to
65535 bytes; that tag is later copied into the single-page sysfs buffer
by p9_mount_tag_show() (memcpy(buf, chan->tag, tag_len + 1)), a
host-controlled out-of-bounds write of up to ~64 KiB past the PAGE_SIZE
attribute buffer.

Reject an overlong tag at probe time. A 9p mount tag is a name-like
identifier, so bound it by NAME_MAX (255): that limit is independent of
the sysfs/seq_file page size and is far above any legitimate mount tag,
which keeps p9_mount_tag_show() safe at the root without hard-coding a
seq_file implementation detail.

Fixes: 179a5bc4b8cb ("net/9p: use memcpy() instead of snprintf() in p9_mount_tag_show()")
Cc: stable@vger.kernel.org
Suggested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v4: bound tag_len by NAME_MAX (255) instead of PAGE_SIZE, per Christian
    Schoenebeck's review of v3 -- a 9p mount tag is a name-like identifier, and
    NAME_MAX avoids hard-coding the seq_file page-size implementation detail
    (which could change and silently break the bound) and resolves the
    off-by-one he noted.
v3: reject at probe time (PAGE_SIZE) instead of truncating in show().
v2: sysfs_emit() in show() -- dropped; probe-time rejection preferred.
v1: bound the show() copy.

Build-tested ARCH=um (net/9p/trans_virtio.o, W=1, clean; NAME_MAX resolves with
no new include). The original ~64 KiB OOB write was reproduced pre-fix; with the
probe bound a tag_len > 255 device is refused, so the show handler never sees an
out-of-page tag.

 net/9p/trans_virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index b0d0094ec8e2c..9fa63e3ebf673 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -633,6 +633,11 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 		err = -EINVAL;
 		goto out_free_vq;
 	}
+	if (tag_len > NAME_MAX) {
+		dev_err(&vdev->dev, "mount tag too long (%u bytes)\n", tag_len);
+		err = -EINVAL;
+		goto out_free_vq;
+	}
 	tag = kzalloc(tag_len + 1, GFP_KERNEL);
 	if (!tag) {
 		err = -ENOMEM;

base-commit: 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4
-- 
2.53.0

