Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236563;
	b=nM9ox1Wr35mhVRcCbvnrsibbL/KM14cW7BcNLGMOl22sTLf9eYtsnM9F3f2FYIJnZr6Y
	 z54+KPNPLXRhivEmaUyD5JV9zKRUfVe5/9rul4du0v7VU706Gijx+p38iN1TDDWMPU6xI
	 BXCSble0b+ZN6t+WVoRhE7KgrAYq9htOjoVkkh0QoObTyRhn5NLD0HGghuJD5Dv5cdPuj
	 qgv1uFw/+mJJarSzQ1rh7hSX7rtaw7UekYO/IpxnY06b8pNBDqa5N89+PRxpjpPUcSSL6
	 xOW5usTaHYihaR2OJhjnfnw93T+C+zKoMrAWnRTmQv1FxUeR98a8AukVSKs2WF7vfiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236563;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EXPvvC5QiNbOqwxZ8W0rt5FetRvZVeTJ+6Boqil85iw=;
	b=CSl1A0HSXAPlBL4QX7ASknZ/UG6y5UaHmbL8Nwd1m63c5K45fMX4bm2zHvEFe+9UTRmk
	 YeAOJ46BJx7e4G7fahlopA2RoWzV5jb0Q/9X10iq710E3Baag4QEvypl2GZ8eCwlSAx7l
	 61m+9rITYHHhYAC8JU+AJeP4m94z5ooQB/Zuk6m+kqHDSZruy/aunxa+fOq+JAayt3EaD
	 MuIKWb3DjUIn+tWSRc5NvOrScU6cICgEa+gm5STz2KkHsfUayBCLi/CogXppSUlv9iRDZ
	 1kvE2OT2CPXT+VXnwDRClitkyRQUjVdLQk3FjzdFSraxqZv/m5nTAF4Xlfji03zYHAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=OWuswSp8;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1CB606A31E
	for <v9fs@lists.linux.dev>; Thu, 29 Oct 2026 01:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C1CB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=OWuswSp8
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 15D4914C2D6;
	Thu, 29 Oct 2026 02:15:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793236555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EXPvvC5QiNbOqwxZ8W0rt5FetRvZVeTJ+6Boqil85iw=;
	b=OWuswSp8PGk1/0K/bsBaN3BWvDR9MFhuAIkGQQbWqrSyhZrn+Ua7ljQREV5DlfaGzPoMwJ
	1xqVtaTpqwlLzJYAk86B04vqZ5wL355dk5Rq6Al2xD6jJlcGrUBc+FMWYFKGTYhY+2av5A
	Ois36fLNcSHwf+Le4OmZpdV8Sp9cDk8DEPjdJbSqGdrZmHtoYXlNPh90MkbgzWDQVfrdlW
	do+XnFGf3goJa8gdiz7FrCAGwa+DjiFF6/K92as6IZBtbSA1YIxkg8htc/5XXAQ2mPpHRH
	cDw1AUVDLJghKHLhAxjQb4MPd8LGJO/blHPbWeFKhhjVC7GdUniQhTUiHYfUCg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c4ec0c14;
	Thu, 29 Oct 2026 01:15:50 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:15:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: ericvh@gmail.com, aneesh.kumar@linux.vnet.ibm.com,
	jvrao@linux.vnet.ibm.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] 9p: fix kernel-doc warning for enum p9_session_flags
Message-ID: <auKeN8lGQMw5yYJt@codewreck.org>
References: <20261002035837.39703-1-emmaonana18@gmail.com>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002035837.39703-1-emmaonana18@gmail.com>

Omokefe Emmanuel Onanaroghene wrote on Fri, Oct 02, 2026 at 04:58:37AM +0100:
> kernel-doc cannot parse enum p9_session_flags, since its documentation
> comment is followed by #define lines instead of the enum declaration:
> 
>   fs/9p/v9fs.h:31 : error: Cannot parse enum!
> 
> Move the three #define lines below the enum whose values they are
> derived from, and give V9FS_ACCESS_ANY and V9FS_ACCESS_MASK their own
> kernel-doc comments with the descriptions they had in the enum comment.
> 
> Also document the four enum members that had no description, using the
> corresponding mount option wording from
> Documentation/filesystems/9p.rst.
> 
> Fixes: 76381a42e4a5 ("fs/9p: Add access = client option to opt in acl evaluation.")
> Assisted-by: LLM
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

Sure, why not; picked up.

> ---
>  fs/9p/v9fs.h | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> index a462bcbfc7da..2f18e75f0ed0 100644
> --- a/fs/9p/v9fs.h
> +++ b/fs/9p/v9fs.h
> @@ -21,20 +21,16 @@
>   * @V9FS_ACCESS_SINGLE: only the mounting user can access the hierarchy
>   * @V9FS_ACCESS_USER: a new attach will be issued for every user (default)
>   * @V9FS_ACCESS_CLIENT: Just like user, but access check is performed on client.
> - * @V9FS_ACCESS_ANY: use a single attach for all users
> - * @V9FS_ACCESS_MASK: bit mask of different ACCESS options
>   * @V9FS_POSIX_ACL: POSIX ACLs are enforced
> + * @V9FS_NO_XATTR: do not offer xattr functions on this mount
> + * @V9FS_IGNORE_QV: ignore qid.version==0 as a marker to ignore cache
> + * @V9FS_DIRECT_IO: bypass page cache on all read/write operations
> + * @V9FS_SYNC: flush writes synchronously to the server

I reworded these a bit as 'flush writes' sounded a bit off.

+ * @V9FS_IGNORE_QV: ignore qid.version==0 as a marker to disable data cache
+ * @V9FS_DIRECT_IO: disable data read/write cache
+ * @V9FS_SYNC: disable data write cache

-- 
Dominique Martinet | Asmadeus
