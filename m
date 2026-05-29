Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587E33A9C4
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041332; cv=none; b=iaZuFZLJmnmrTVPGAehnDDNLvCgNdB8d6H7s7xHce7o2E0+78FVsKPAcUdQV0dNVEZTpWIw5orBt3NDHV7NL6flBuftKZXwhn5059TfD8CpBOxQKkkeIiZN+qPwqAjCqcRF2MUCwk87OkoI/P8ifw25SnuFsZJ3ucsl+FJz6zzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041332; c=relaxed/simple;
	bh=wiOX5OOwxHyJmC+THIaXZ1d8e2aCROCqgR8RKeF2ACo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDPFFm22oSlYXaVE6IeQExX6EVKInza5WmE/iCFsSSabZbLSo5aFQ5w8ZFO6dPc5qEVXjbpENKPzLwJOy0QowwSfuAbl/IGlenihn+SW27eGqyXiTB86B9jZdG54jG4XuhOe4VRHrnk6sxabHFnNjT1gtMw/C7229mrDA9pDt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glwn/818; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glwn/818"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85625854d3so666326a12.2
        for <v9fs@lists.linux.dev>; Fri, 29 May 2026 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780041330; x=1780646130; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EOIlhV4TyHKTC2O9h1+JZXa0pc9hghpuCyvPU98in4A=;
        b=glwn/818kwkgQPvqcCLGz3N5sxCr/LYY0kGu5Tdm42A/DxR/FNBb0t+BIFGelH+k2O
         xyPvrHHKRtxp4EV2/ssJHUAi+E7/AhBYPy3D1v2QfMcI6GJPClFyjVVzPVkxBUSUWf4X
         P3diwFpdursRkZEtEpzjNLS/tHlxnogXH91kYWjJ2DH6VZjz/3CNTzaDSFWTduo8IBJE
         KqIvkdYP9fHrxXZfOBaBUdGWM9qjr2Uppurysu0RkleTS2MF1Tr/uoSN1DdQiKMoO0DH
         0ozf4cwNa76g3w8IWfn3XmFj1kFzv6nhBSRZMLzc7ykoLnhqJVvqRAdcmbeD90U6TJIR
         kDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780041330; x=1780646130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOIlhV4TyHKTC2O9h1+JZXa0pc9hghpuCyvPU98in4A=;
        b=DmY7Y6iAEwpxbv82JRFTHmDaa02pIxWbgBl/W662iz7E1HRPfJ8iyrRUkFYD7tcOEQ
         yGanJo4e/HaxXKUjUV/sLiERhKVLVm92ebUP5rpcgRTPAQOYiW2LaHwj49B5CC0d4vWp
         tV+hPm26XjAibPiKPkzBXCi65a9CSo/nlncsKohJo9XdsCLVwfjgtnVKasE7mv5PgAj3
         XjSFNwBdy6jSR2GS4KNhwWn4lNC/+rcohEQZi1CcvcEL1JIq/3BCgNiWXxldW1PkF/wx
         iqjKVQ3//AuXuxBi0RGLgPSE30cW1a1PsUk4tKTDkGq4+8Ci1cEWgOkAdJAJxn+UuVFV
         fvOA==
X-Forwarded-Encrypted: i=1; AFNElJ9YU/m74xX8JAqyMVUR1/tvgAvk2efPxQrDMXAI5Ub5My7vXVw168yKAkI7ACSHKbRwWAVA@lists.linux.dev
X-Gm-Message-State: AOJu0YyWSyLsfOl0sPSeNU1rYQLOvhoYvGaP+6mVJ1u3cBbM6N89/KJ2
	dBuZSDuiInEFbKHoaCHuXHimGXo3HdhY217kPdxJ3aKom0/Q8IY8Y970
X-Gm-Gg: Acq92OGGW8yeNZu31q8+78XmU6mJSEJOYjgAgiLwcGJ2sEnrIxjEkjbpZqRqC3vyBOl
	ddn+eOH3UhAALiiMTvSLHDUItMlSh9eV2fZq1i6zL+U+YiCCsgKfzf55oUsdZEriPesuYGdeS+w
	TuO4HPlG7yAZoyhB5KqAvSE9RgScLraJw6nQtwK0hbMVcwQb14ZoPLIDdvLO95ymTtGMYq6VQzT
	CaeXF8d6WTwW+VQoAurhAyReDlKDMdvmzn9r+RWxvGmaGoGFWMnxC89aIhBtj5Ic2IH8CAYl+uC
	A0hfZh0CeY8gAxUQZmqlyhDQP6riaET0O1ToeVrfuRjQMUIH1t9q9KNjnMj8uCA1OK9AljpCovo
	iPQzDyqjakxMXxYlpFS0+N5FXmdrutIP5uZwsjVCeCii5NW01yW+ZoyGnaG75sRrPRFUmqhqwXr
	XxaLzEND78IAS3EX3ON5dudwqKxxYc1xvxKXhdqZ8uXSqMIDe6mZki5wi+FCh5YkrqATPOdBkC2
	xKfOtIjBlFE1iFMwx4Lwc2v+IRqHEQkWjwjcd+vgZyy3ku8rPcJw/iYU5xQl7wHig==
X-Received: by 2002:a05:6a21:6e04:b0:3a2:d629:16a2 with SMTP id adf61e73a8af0-3b411c02000mr2163499637.10.1780041330263;
        Fri, 29 May 2026 00:55:30 -0700 (PDT)
Received: from bass-virtual-machine.. ([163.61.198.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772d9d35sm975539a12.29.2026.05.29.00.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:55:29 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] 9p: Add missing read barrier in virtio zero-copy path
Date: Fri, 29 May 2026 15:54:41 +0800
Message-Id: <20260529075441.233369-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2b6e72ed747f ("9P: Add memory barriers to protect request
fields over cb/rpc threads handoff") added a read barrier after
p9_client_rpc() waits for req->status, pairing with the write barrier in
p9_client_cb(). The virtio zero-copy wait path was missed.

Add the same read barrier after the zero-copy wait before reading the
completed request.

Fixes: abfa034e4b8e ("fs/9p: Update zero-copy implementation in 9p")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Found by auditing READ_ONCE() used for synchronization.
A similar fix can be found in 8df672bfe3ec.
---
 net/9p/trans_virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 4cdab7094b27..b0d0094ec8e2 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -532,6 +532,11 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
 	err = io_wait_event_killable(req->wq,
 				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+	/*
+	 * Make sure our req is coherent with regard to updates in other
+	 * threads - echoes to wmb() in the callback
+	 */
+	smp_rmb();
 	// RERROR needs reply (== error string) in static data
 	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
 	    unlikely(req->rc.sdata[4] == P9_RERROR))
-- 
2.34.1

