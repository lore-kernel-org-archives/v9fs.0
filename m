Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA84136349
	for <v9fs@lists.linux.dev>; Fri, 22 Aug 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873991; cv=none; b=O/1LMhBEZhAQz8kppEcJJZbhHU3+CNtXeOO7iIJ03EknxeBXfhKcQcE9bMRD8qPQy5HFMjA7R4MlH7EuYddQcZr2fTF+iRQBt5PEqxC1w8zDDt5lIdfZeLA94DfzwRol85pvcWNH5vdp4CvEXHM4uQF1dzcehN/QfgchW+5VjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873991; c=relaxed/simple;
	bh=wrqna0sZ6RMPU8gTT3h+3xAxYsH60khbZNhU4KLyBMo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aM2EDOXVDm/1ahamWkh47aNqEO8x8BGEREMM//UI+s/A/2RDccn0K0cK0G8frf6JjrWS8CWNxqL7ByWA6KFU6ebJyQbYO94wlBJzhmAko51UXJ6YkUXH48KbymxECAPQcAkDmkV5dRPNfnyU1KE/rrFrf8jX4p11KII5esFtvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h9VcjKIh; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h9VcjKIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755873674; bh=AXtNgOCqWlXjJdTGIg/SbLr8Fg0oT7SoDt9nlF0FA/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h9VcjKIhDFof0UpTm7x75ZEdJIeR7mshNt0X8MXdqtvddplu0c+DYhPhTte3B29Ju
	 S0Lhoc3MsYmjwBa1llqLJUptPmQMfM5299IdlueXLqH6G0mW/8UaJ9Kw9Y8jjwQuem
	 8QKcPk2RSLYZ0bsd06Qg57e9qwvAXDJtjDq1WPeM=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A4812659; Fri, 22 Aug 2025 22:41:08 +0800
X-QQ-mid: xmsmtpt1755873668tq8zjx9lz
Message-ID: <tencent_074BFE748F778366103D0B36E0971837E809@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXpvt3VlSnxhCwwyEuILRU9s99sYUUY10cqaSBidHw7OgAT7VZ6/C
	 oIKGWH7S4O7gdFiqDoV90uTYbfsmJAEckQdyAhLNgb2itk3KsG+OaBgActIDxPMI3Bl36tMpoSbQ
	 enuNwb9nQf1+TrpT35vXKrkny3jytaWoXyFou32BIptza9kPKpuoqcsEQC9Xf4a2DSDphqnvshES
	 I85vJPLQvz6j3dVgeuf+UPk3dTaxB+y7tKRemfbfUhFm6kyEwWOLPL0hFl2bhdIVHibCBnoBmN8Y
	 /VvlSp1bfUP1J274u5+3E+lOj0V0ev4RQgrvWS10OSqgDAAFi76XzDy1pz3bqv0xI21w1JstMtv3
	 JqAXVSY1juTyuGS5eEXtEA2RN/yZsoBTxt0Tjv8BXAFgSJVdj0OMTOoChWa+9e5DHOOmUztPqOPt
	 Q52xerPK6lnQjbL4TtOvrtSP9SaLrOpGluV7lELEJttDxncc/pHaMn9F2N44C9yuapqCASDnsfHB
	 E6jw3nKRn/qh+X9wZdDVxwdW6K+liVeG5LilK7L49QUYlsVWkAIU9IT+q00MbgxOTAUMLviMyCdd
	 FIzsgZQT9y58XyUil2cFtUdcdnTw4Zi7UvD8N6N0B+TdNCl7TAxzBynJRG17gWjf8KHC6zItC7eJ
	 PUK5dj70UzEsv82nhsB2rlPqrFR1DdzcaayIpNEgSdiLPoEhpNOnd7bIA1ILNPbf62D6unjOwg/g
	 rG1eGzrK/gyu7TXBXn/1M2+JHEyjhRQAm8MQ2b4uhFKnnTl+QiI4UVM4lH75/K8LIaQnl4nONoDY
	 budczJgbtrmhsozpYh5towqS3UGhFQLkB8KjLkRMbs6eMLtvSk5nxmtFZQQO+Aa+tzrVF9StEgyj
	 JalrNoV4IUDHEqpw9iSx5Miknmbf6/5L1gty/7d2K17OADZM2ILHr+08XHD49CvrmDHIed1hukWH
	 1PZHEZx8gOiMzi/EnDQRX0amQcAcCMK7I25tT6hyhZLXnJxlaZZk9vzdwPVfqj
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
Cc: asmadeus@codewreck.org,
	ericvh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com,
	v9fs@lists.linux.dev
Subject: [PATCH next] 9p: Correct the session info
Date: Fri, 22 Aug 2025 22:41:06 +0800
X-OQ-MSGID: <20250822144105.2424847-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
References: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syz report a shift-out-of-bounds in v9fs_get_tree.

This is because the maxdata value is 0, causing fls to return 32, meaning
the s_blocksize_bits value is 32, which causes an out of bounds error.
The root cause of this is incorrect session information obtained during
fill super. Since v9ses is stored in sb, it is used directly.

Fixes: 4d18c32a395d ("9p: convert to the new mount API")
Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/9p/vfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index f6065b5e0e5d..cc2056dd0bef 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -50,7 +50,7 @@ static int v9fs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int ret;
 	struct v9fs_context	*ctx = fc->fs_private;
-	struct v9fs_session_info *v9ses = &ctx->v9ses;
+	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
-- 
2.43.0

