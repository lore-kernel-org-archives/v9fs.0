Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8315853D
	for <v9fs@lists.linux.dev>; Fri, 25 Oct 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873162; cv=none; b=oUJv5KXHg3YhNTIbOrW9JCyZJlLiyHOnbBj17Uuk1VrNgFY40qjxBxkQ8gOHPM6PXMG5gI4FS2xsI2bZ8Qo95wXFwOu0IcCYnELsRqlb+kOWEhrFu6REX5oMR+rJGmFZFcLJmU/qbfNnjJkdKOmNzpyXITH7tANRl/ngMLl1Z3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873162; c=relaxed/simple;
	bh=k0r3WOrb2CXmy30/tV6kcdOv8W3nxY/6aW3AFGdzRrA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=anWVDEnP+r01vutxyQBa6PUiur9cNxPaA6Lo6jPxwO23w5/yIErcHHHaAo4IILzsF9I6RhEWRqAJ/HASDRCm0/FSTbSrDD1ogv0WAmknvohNeSGdIjePU3xdl3hV5ZNBtQbSlLXXvLEXng+riE2e8A4UOZYYIe/GlqyqURqBgCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkePwM7T; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkePwM7T"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e3d97b8274so21465077b3.1
        for <v9fs@lists.linux.dev>; Fri, 25 Oct 2024 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729873158; x=1730477958; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vxUXE1ju1lVW9j8FPLrrWfH8+vzsmqWln+XfSxRyQ8M=;
        b=hkePwM7TgVtnHhftCotSHYblyqsZgxTNWDwQ7ILJTuT/LUY4WrjidOz8chgCi+IeAi
         K/7iHINyW99j+cmFFzGE6lOTwOcNRnture9dFM+rFEAJaodgytO9lspc8EnHkh4BnCi5
         jvtMZ064WPB3CVxz3kH4CDZ9fOrQ23YVwKVF/850DRDAgX9cQxIU2nA6hq/+bf5yo/ld
         XgW+hCvSr5N58zBhkuxer0/7saTGAYTAlG0ZCPP2XCwqk8IoHRIFrwheK2Llm19RlezO
         Do0wZpVLdkC4V5nv2Zq5Fa8V4NzK2CLCbpuj9eRL3cRsAba/z5HHcnR8PVe7HEww7RC0
         0KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873158; x=1730477958;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxUXE1ju1lVW9j8FPLrrWfH8+vzsmqWln+XfSxRyQ8M=;
        b=ZBYRfy5/tDsdnZQ+6Lc88HHAuNWM+svACeiNve2JeoabBSaPUuOU7i/lIjziZyhQxx
         QFD08q9IAKMer0nuZWXoV06OfShz3kI6xJ6GhkMWJphZEHQobS30PlEh5sMfoe7BUrsV
         vm5gz/3Gb4WSLwODriF1QyHqGJ0a/ji0Jtwil9kasnDZs00ti2DU0MOxKy1g7CKJd/WI
         LxsojMPBoUNrtXzuxQVqMCBYcWEKlMzK/kIxiNuOq/EybJ4VBQMewX7y2FqiybErQpzH
         so6k9eaUxhYnFyRmnRg4kPJNdo6dXM+2s66mRPuz/ZA50aohrydTuTCAfCiOBReMQmYl
         LpRg==
X-Gm-Message-State: AOJu0YxxYgSie+nXpzBMZo40rhr7+4lXiIdRveJNfftrtN6geiaz3W0S
	JfaU3IK9Y3NRELST2LDTyou9Oe1byman2FXbT7Zuf/Yk1Tikr1UelwZMbZL9Fq9OLfCJgrJEOP5
	haDVnq0xGUCTWjkhMQ98lt24alg/mtTJGvo4=
X-Google-Smtp-Source: AGHT+IHUpz9ZwAfXIOasMpVe4eRYejrDsMrmUdXt/yfsYIVGqbQ+JiZAnKZq+qLhFP6qSO+n+5bWerJXKYQntsaVHQQ=
X-Received: by 2002:a05:690c:660a:b0:6e5:e571:108b with SMTP id
 00721157ae682-6e9d88d0944mr1182027b3.8.1729873158313; Fri, 25 Oct 2024
 09:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Guan Xin <guanx.bac@gmail.com>
Date: Sat, 26 Oct 2024 00:18:42 +0800
Message-ID: <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>
Subject: Calculate VIRTQUEUE_NUM in "net/9p/trans_virtio.c" from stack size
To: v9fs@lists.linux.dev
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Eric Van Hensbergen <ericvh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

For HPC applications the hard-coded VIRTQUEUE_NUM of 128 seems to
limit the throughput of guest systems accessing cluster filesystems
mounted on the host.

Just increase VIRTQUEUE_NUM for kernels with a
larger stack.

Author: GUAN Xin <guanx.bac@gmail.com>
Signed-off-by: GUAN Xin <guanx.bac@gmail.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: v9fs@lists.linux.dev
cc: netdev@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org

--- net/9p/trans_virtio.c.orig  2024-10-25 10:25:09.390922517 +0800
+++ net/9p/trans_virtio.c       2024-10-25 16:48:40.451680192 +0800
@@ -31,11 +31,12 @@
#include <net/9p/transport.h>
#include <linux/scatterlist.h>
#include <linux/swap.h>
+#include <linux/thread_info.h>
#include <linux/virtio.h>
#include <linux/virtio_9p.h>
#include "trans_common.h"

-#define VIRTQUEUE_NUM  128
+#define VIRTQUEUE_NUM  (1 << (THREAD_SIZE_ORDER + PAGE_SHIFT - 6))

/* a single mutex to manage channel initialization and attachment */
static DEFINE_MUTEX(virtio_9p_lock);
