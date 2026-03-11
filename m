Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B163B8947
	for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217806; cv=none; b=DkFObuSiRTdxsIhmgWiyQnlEV7llrMgh/Meyc+fdv06RImHsV5sYiH7Drwdnq0TW6hDRzCyZ+QjMhSPdxH/QPbdCiSUwgbOgdLMdGvynHCvaY1kqXaeSKNadUBcF6IeB+ki9kTZ8YvHH3Rb3VMr5USQQn/ud9+jC35NvJk2kdqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217806; c=relaxed/simple;
	bh=N5EmeK5HGI2hj0GDeiObMgh1KxVViUjBhYZuIojYdHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg3ygeHk+dHliBvu8EyPAvFWGTJDP57KzzVFI0dj87O8nNpBk1h+vSJ1U3C9PYpF5UI4ZZ0N0sy69kUuz8ANZEjj/uM9I8aDOp4bmPm9+AdPRiwEFvingGEG2acZuVM2ynWAYu7U5llRVAHKjHV7xgoXv4R2QTQP8LSXTwPBcD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=iF02s73j; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="iF02s73j"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2AC2C14C2D6;
	Wed, 11 Mar 2026 09:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1773217795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BipbvJcvwX/pjXsy3HWRU3NhgZBFRdigEE7P7xncOg0=;
	b=iF02s73jB1lsEH+Jc6HMJEpKKuVkJd6FWVNCE+iORo0Z76iYqUIn4pdPN9mJGadCBlcd++
	Z/RpVBJ/zOQDQkohjntybZTKM8VPw1bP6St9U7AtKpwyIrA/s6D8Oox+zQcPZ2JlkWX6o1
	RZB3FUsoReb/ijKqZE9uZs60ERf8Vr0rRe0DOZDsUGiClvdBmg7gyyXxGPODEQ1xOL/X/M
	dvgKJbqHX0Y8qv9R1/m/CyBmYn/zj9zshtBNFX2E6xWk2eAh8v72m/I92crkAto4l3Sp39
	ih2J4D9ZcW8dSCOpplX8mqV1sq6CLYCap2MzSrB35vKZ6wO6JRTprrqztrms+w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0e77f259;
	Wed, 11 Mar 2026 08:29:51 +0000 (UTC)
Date: Wed, 11 Mar 2026 17:29:36 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: cocci@inria.fr, linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 06/61] 9p: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abEn8GjSxsVD3D7j@codewreck.org>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>

-most lists...
Hopefully anyone who might care about 9p is on fsdevel.

I second whoever it was who said this should be split and not send all
the patches to everyone...

Philipp Hahn wrote on Tue, Mar 10, 2026 at 12:48:32PM +0100:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Eric Van Hensbergen <ericvh@kernel.org>
> To: Latchesar Ionkov <lucho@ionkov.net>
> To: Dominique Martinet <asmadeus@codewreck.org>
> To: Christian Schoenebeck <linux_oss@crudebyte.com>
> Cc: v9fs@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  fs/9p/fid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index 0d6138bee2a3d1ab565ab2d210c0a3f3bf97e4e3..3bb7ef4380e972a2d9ab67eb4aab6cc5bfe2eea7 100644
> --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -27,7 +27,7 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
>  	struct p9_fid *fid, *nfid;
>  
>  	fid = v9fs_fid_lookup(dentry);
> -	if (!fid || IS_ERR(fid))
> +	if (IS_ERR_OR_NULL(fid))

FWIW v9fs_fid_lookup cannot return NULL -- and all its other callers
only check for IS_ERR() so if there is a corner case that does return
NULL then we have another problem -- so please drop the !fid check
instead.

(not that it matters much... But might as well do it right)

-- 
Dominique Martinet | Asmadeus
