Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A13559C3
	for <v9fs@lists.linux.dev>; Wed, 21 Jan 2026 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026434; cv=none; b=enSAMDr+QlZ49aW34mDvCQ3szK7Vi4BOlj453Mc99dWjCUtMw/U9VVpf7u5+HcOXTETqWksF+WUHw+H4sVMIVGlHqhoi39R4SRvzT9JFsOTLxM9XVFQGu2tF/m7c8plG3UKCxFhC7A1hSwdcMU0nsvyJ3yNoe9d2+QP3wXk4af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026434; c=relaxed/simple;
	bh=MI2BmTqtZrNSQrlrrLbu/L5u8kVcj0qImD2nnPGSwwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6kqYKo/cG8qYAktI79AcPkYjD6o7OeP3Jwo0AAw3JQhSLT85JtjPOWQPY1BJgcGmllrGOY6pPofoeIi2Du/M/aQxjCHl0pZtejZEuDYPPpD/hQs+OwgWp0VNEqk4EI2vx9xYVi1mLQ8i14wb2+DarnvpT4eTvwyk9X7SEeoi7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=xY/ZZI6b reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=UQ4k6Jsu; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="xY/ZZI6b";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="UQ4k6Jsu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769027331; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=T3TZwnO8y1oxOvrH2YQS/n2Bl9vhGxNTqyNbInimA3Q=; b=xY/ZZI6b+h4eb5Ge1nBTBIsnDW
	gR3wyoSCoJxKTZlUfft4qQz5VRJ628escCsETcvnoYf+bBA/WYOP3bWtImQu44Apz0dKIzyFZhXw8
	jwzQqP+UFQDrV2YbB9s3rl12B3cmeFkR0h1mlcPO9HKgVzx5bXALV/ZnqcbEnrTJqHVdQAp3lo5CL
	X7zoE7vmuY7dZjZfBBwD0AL9Hle1AJm8H9tPrFlYJXaBfFUcQ/NO5KcvVkhtCZhuXfowRehYKBcx7
	FugJ0YP5DXSgEvm9hnQuyGEb2MUZKUqaZjtGVicZhbSwGtEPOO7gGlwyQ/A2ocIitDDnPjRMphr3r
	xJzpIDDg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769026431; h=from : subject
 : to : message-id : date;
 bh=T3TZwnO8y1oxOvrH2YQS/n2Bl9vhGxNTqyNbInimA3Q=;
 b=UQ4k6JsuAI8dg2CiVntgitnSxVt7Iqs3foX/vq0qdQipFdvcyC6VYr52FIt3QJwI3akxF
 FBuqS4bAu/GaIvCkLDSqy9agNmphuqoSurVRDkGZLDaix4ZrdtZkTizZ9OYZrKMjBVdGWUK
 6rpPMf2QY+JfuK4m/ngQ2jpQ+B9stwFX4u6PLSpyzW/k7C7FOt7GtS5Op31VpD9sCvfMSUf
 SHOLvz937mRETrj79I9p6KE4YvSusQ53D28FNnH1uEuzOc5jdyvIra1dRTR0j05t0ZqDLqa
 Vt2b1VHBxKioN1hyXGDYiEsbskLjJb8MQECbUqRbx7mGzlLG0OAafdOaVsoA==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaL-TRk28y-OL; Wed, 21 Jan 2026 20:13:49 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaL-4o5NDgrlA5K-l5yO; Wed, 21 Jan 2026 20:13:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 2/3] 9p: Introduce option for negative dentry cache
 retention time
Date: Wed, 21 Jan 2026 20:56:09 +0100
Message-ID: <7e38e7bd31674208ab2b0de909c0744feda2c03f.1769013622.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769013622.git.repk@triplefau.lt>
References: <cover.1769013622.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: pwE9aQNgp4sv.fy_-LQqC19bL.YACK2QnyLga
Feedback-ID: 510616m:510616apGKSTK:510616szNUyQSrVu
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Add support for a new mount option in v9fs that allows users to specify
the duration for which negative dentries are retained in the cache. The
retention time can be set in milliseconds using the ndentrytmo option.

For the same consistency reasons, this option should only be used in
exclusive or read-only mount scenarios, aligning with the cache=loose
usage.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 1da7ab186478..f58a2718e412 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -39,7 +39,7 @@ enum {
 	 * source if we rejected it as EINVAL */
 	Opt_source,
 	/* Options that take integer arguments */
-	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
+	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrytmo,
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
@@ -93,6 +93,7 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
 	fsparam_string	("access",	Opt_access),
 	fsparam_flag	("posixacl",	Opt_posixacl),
 	fsparam_u32	("locktimeout",	Opt_locktimeout),
+	fsparam_s32	("ndentrytmo",	Opt_ndentrytmo),
 
 	/* client options */
 	fsparam_u32	("msize",	Opt_msize),
@@ -159,6 +160,8 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, v9ses->dfltgid));
 	if (v9ses->afid != ~0)
 		seq_printf(m, ",afid=%u", v9ses->afid);
+	if (v9ses->ndentry_timeout != 0)
+		seq_printf(m, ",ndentrytmo=%d", v9ses->ndentry_timeout);
 	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
 		seq_printf(m, ",uname=%s", v9ses->uname);
 	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
@@ -337,6 +340,10 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		session_opts->session_lock_timeout = (long)result.uint_32 * HZ;
 		break;
 
+	case Opt_ndentrytmo:
+		session_opts->ndentry_timeout = result.int_32;
+		break;
+
 	/* Options for client */
 	case Opt_msize:
 		if (result.uint_32 < 4096) {
-- 
2.50.1

