Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB10E23D7D1
	for <v9fs@lists.linux.dev>; Mon, 13 Oct 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351218; cv=none; b=DX8eocCNmxa+h3VFtRLRD6c2VAkYJgU6o22p8YGWynfxAFx5HGoiusAHUMazfvDgYV2lzMAlg4jaomGAOFqLM7YOwlGU2L6VSo7W/4blyX6P7Bm7iN3gj9mSnAgiGUAkEV3oXjyh/g1ik9abXowNAdq6l5df6YMSP/8N6Of5iXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351218; c=relaxed/simple;
	bh=ABmn+fLVsctJIcVsQ8EXkfemm3Yt7M2ThU/pU1MhG9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwHRm6VCHegJf9Q3v3rl6Q1cMjf2SknhhYaRSr7Tt+hak7fwrD5nKqHT/QXAqcF1KgOZleP7tAJzcsr9ceSxOKWMLXWGxHeDRPYsvX5xwRIXe/KUDngA6pV+0Hclgf4Dj9V8d8lMXQyBIXiNyZjQG1i6/3FcSwf0I3wLKIu4QNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=xI/WgtXI; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="xI/WgtXI"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C50BA14C2D3;
	Mon, 13 Oct 2025 12:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1760351214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liVWWnazWktLk7qYgIAJtTqEdttWgrGsPA7uT5rJXvE=;
	b=xI/WgtXIs8rnlF78rRIuhG85Om82BhXX1ipNuWomu80ZemdzezlD3qOo1vHKI0MmwCyjQ4
	TVJ+EwQfiTrv6kzqAinIkJ91eRXixNKlrUE8LQhvszZRyeUB6m8G683VMv6jAm8Pl6iepX
	wAviR/0MKstVpFbNayZXsaPaJIEUIU2s9Jr1kVFJuzxhHSYgwmd9a6OPue1tNePOzTfl+4
	3INJRJvvVOynG+Z/KL+Uzuf5ulq0U6HCNQo5iXp1n2OJH9uODYAVazzZouzjDOaQJsWSG5
	Xe9K6a9ye88FRrt4/R8egH/VZXB1z5ilb7AaxJTCVj8Q7uuBTAw3+oszHhlYog==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e164d6cc;
	Mon, 13 Oct 2025 10:26:50 +0000 (UTC)
Date: Mon, 13 Oct 2025 19:26:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aOzT2-e8_p92WfP-@codewreck.org>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010214222.1347785-5-sandeen@redhat.com>

Hi Eric,

Thanks for this V3!

I find it much cleaner, hopefully will be easier to debug :)
... Which turned out to be needed right away, trying with qemu's 9p
export "mount -t 9p -o trans=virtio tmp /mnt" apparently calls
p9_virtio_create() with fc->source == NULL, instead of the expected
"tmp" string
(FWIW I tried '-o trans=tcp 127.0.0.1' and I got the same problem in
p9_fd_create_tcp(), might be easier to test with diod if that's what you
used)

Looking at other filesystems (e.g. fs/nfs/fs_context.c but others are
the same) it looks like they all define a fsparam_string "source" option
explicitly?...

Something like this looks like it works to do (+ probably make the error
more verbose? nothing in dmesg hints at why mount returns EINVAL...)
-----
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 6c07635f5776..999d54a0c7d9 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -34,6 +34,8 @@ struct kmem_cache *v9fs_inode_cache;
  */
 
 enum {
+	/* Mount-point source */
+	Opt_source,
 	/* Options that take integer arguments */
 	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
 	/* String options */
@@ -82,6 +84,7 @@ static const struct constant_table p9_cache_mode[] = {
  * the client, and all the transports.
  */
 const struct fs_parameter_spec v9fs_param_spec[] = {
+	fsparam_string  ("source",      Opt_source),
 	fsparam_u32hex	("debug",	Opt_debug),
 	fsparam_uid	("dfltuid",	Opt_dfltuid),
 	fsparam_gid	("dfltgid",	Opt_dfltgid),
@@ -210,6 +213,14 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	}
 
 	switch (opt) {
+	case Opt_source:
+                if (fc->source) {
+			pr_info("p9: multiple sources not supported\n");
+			return -EINVAL;
+		}
+		fc->source = param->string;
+		param->string = NULL;
+		break;
 	case Opt_debug:
 		session_opts->debug = result.uint_32;
 #ifdef CONFIG_NET_9P_DEBUG
-----

I'll try to find some time to test a mix of actual mount options later
this week

Cheers,
-- 
Dominique Martinet | Asmadeus
