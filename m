Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87933B6D3
	for <v9fs@lists.linux.dev>; Tue, 19 May 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212138; cv=none; b=MnXb0aNCFgm6aCXZrTl7t4zvKY1PfXmD21weRoWyhrN+myYYdxPrcb8+/jbmmy320PIAKwUYgLn1Od0Gi+lkk2ctLlIZsDCYGtGmwLqVHlBPYZ1HLKDDDCUUTpiMbeO7ReYIPw7VgGB6gaDSeB2afiviqbnYnYL34d13qhUWIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212138; c=relaxed/simple;
	bh=G1zrEaH0Nw9IGEVr8BN8GKQEXjdHN+0JM+ydMJOLmLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqBBbRA7Whg5CnE6B3fNISb4YHitv8SjkXNrP3NxSMgRyeAyYV++hyZUTaU1apcUNyuFvvYUP5jdxuVCaPNo4kMHZkXLMBj8xx3dO43nnT135Av8fH6mREPYUJiPAjcbUMQHGcnoVaMHU0pclSFZq9jJLtmUTiv/oE2jgqKg7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee0pTPbw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee0pTPbw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso19922415e9.0
        for <v9fs@lists.linux.dev>; Tue, 19 May 2026 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779212135; x=1779816935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TeEyf8zqAP+Bjk4W8JuLyXdZAQ/knaMY6sSh//YJGI=;
        b=Ee0pTPbwj9c1G7wJzaQuFckksrUlyOKPJ/tpofWHEa7SkQPU5Tic9XN1qC55PKIqs2
         OssoxAT32DQ/WhXsZn9s/mFOi8KReNu++cDz4KODATZYVxsyBLh9AKIOTWPKMIsqYaB7
         2sr9UkJ7KMDFLnn73oReJVrWjOrDQVUQvBkemQ5y1F0HnJHKF/ncif1iFdvZu3YSbUGR
         BACj0GI2qLEDX84bPrYn+etV2jTOWKEXuFLNkqf5c8perYO2RMwarZpDNItiOxNp1cOK
         KaCf0Dn7203YQ0IKdpKYGtuj4eCh+Xjvzn1Wn5U0RpsflKXu1jWKMBWRg+apYgfDKrBv
         d4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779212135; x=1779816935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1TeEyf8zqAP+Bjk4W8JuLyXdZAQ/knaMY6sSh//YJGI=;
        b=fDpObDqwga+YSw9jpNcXS4KoW4kB5TauYHXFCrJdwgY7WkukhzQe/0pL2UfT0dE33w
         8lcD0asSxeymceQVTgjEYb+8wsVYq+FIe3JmUQzh+RBXJrLX/57svcVOq3aesFIn13ul
         XRqXHoO2Zt4INhITZ0nqRBvt2YVyH0usGUmgLcYdLtFmHmY+i4BwcxuetPFTmTbW5qwq
         +reI79A2E6XJdbiwTUMGOn1hOZZkDfS8KxvT6XtBTQQaCtAUHDKNWmUUjBtMTwDKgjQJ
         ieBZTCqZgh2Rsq7qLrZy5iFb/UJm4l7PVROw9z6FiBUyoJwdSu2CPSCYAK2T7oQ4EgcD
         TiNA==
X-Forwarded-Encrypted: i=1; AFNElJ8Yhc1JVZNqcdMDaGpXQ1JtzuVcAtHKE5bXlwOKEW3DqEhLTKaI/Wz+Y20KCNolhdFs89zI@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ6/t3DE1A5NP/rgI0wgwmsVhtbBNrZs384Kpuidd+x9Z3i7lg
	5bqanB9FYc4Gn6DbolT+GfPI1vdWKB9wPdalm8xHG3ggQloxfuy3llx2ZZKvuV2o
X-Gm-Gg: Acq92OFBL59qTrhra/Y9JniccOqS8NXBkvQc5fNIREaUjWjEkPIxbEvY4kf9S+jzw9y
	CyPJT2GPLdh42Zfw0TjgjtkoEtoWxIzsc9X22fR/n1Lvt2wGupYVJrkrYtIQx0U7vDByesvzNr+
	z0u/u62S7cz00sgUhrEwmTXsia6AU/fIgJQ8ZrGffJvxvtYQ01CZL5IAyGjYutROdfCg9uhZT94
	YoV9wzAZsi7Xp6TFqUfdMnPwDAnAjKpBqNO+FhK4P2Nky1b0gfibF83+GQkToc4iINDCuDF9NfF
	6pE7XTqItbCLzInX3s2Imkf4HYJP0aQf2p+XKJ+hMZQEMeTzf7pyFpeN4eEuZZLHkow+gfWKqKa
	je2cPbrY+vFsB8VnXdsdnCC4LCRaoyXSA9s42QO9anaJ/vYn6pHZILT6dO2AjorgdRyDBhyZIRz
	7cfFqOFlG8y008EhLYGPz6BZZyVWz8k2YbbgLbztjoE+PYeH8y0hCmZPKZhKF7VtsCe2PfqaGOz
	hs=
X-Received: by 2002:a05:600d:8496:20b0:48f:f7cc:f6f5 with SMTP id 5b1f17b1804b1-48ff7ccf76bmr154129675e9.31.1779212135411;
        Tue, 19 May 2026 10:35:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm46855162f8f.14.2026.05.19.10.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:35:34 -0700 (PDT)
Date: Tue, 19 May 2026 18:35:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhongling0719@126.com
Subject: Re: [PATCH v1] 9p: Fix mkdir to return NULL on success
Message-ID: <20260519183532.04e8e8f2@pumpkin>
In-Reply-To: <20260511061830.38373-1-zenghongling@kylinos.cn>
References: <20260511061830.38373-1-zenghongling@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 14:18:30 +0800
Hongling Zeng <zenghongling@kylinos.cn> wrote:

> When mkdir succeeds, v9fs_vfs_mkdir_dotl() and v9fs_vfs_mkdir() return
> ERR_PTR(0) which is incorrect. They should return NULL instead for
> success and ERR_PTR() only with negative error codes for failure.
> 
> Return NULL instead of passing to ERR_PTR while err is zero
> Fixes smatch warnings:
>   fs/9p/vfs_inode_dotl.c:420 v9fs_vfs_mkdir_dotl() warn: passing zero to 'ERR_PTR'
>   fs/9p/vfs_inode.c:695 v9fs_vfs_mkdir() warn: passing zero to 'ERR_PTR'
> 
> This change does not alter the runtime behavior since ERR_PTR(0) and NULL
> are equivalent. However, it improves code readability and silences static
> analyzer warnings.
> 
> Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
> Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> 
> ---
> change inv1:
> - Add clarification in commit message that this is not a functional
>   change, as suggested by Christian Schoenebeck.
> - Add acked-by.
> ---
> ---
>  fs/9p/vfs_inode.c      | 5 ++---
>  fs/9p/vfs_inode_dotl.c | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index d1508b1fe109..d2d18c796b58 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -672,13 +672,12 @@ v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  				     struct dentry *dentry, umode_t mode)
>  {
> -	int err;
> +	int err = 0;
>  	u32 perm;
>  	struct p9_fid *fid;
>  	struct v9fs_session_info *v9ses;
>  
>  	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
> -	err = 0;
>  	v9ses = v9fs_inode2v9ses(dir);
>  	perm = unixmode2p9mode(v9ses, mode | S_IFDIR);
>  	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, P9_OREAD);
> @@ -692,7 +691,7 @@ static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  
>  	if (fid)
>  		p9_fid_put(fid);
> -	return ERR_PTR(err);
> +	return err ? ERR_PTR(err) : NULL;
>  }

That function is odd, it ends:
	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, P9_OREAD);
	if (IS_ERR(fid)) {
		err = PTR_ERR(fid);
		fid = NULL;

A 'return' here would solve the mess later on.

	} else {
		inc_nlink(dir);
		v9fs_invalidate_inode_attr(dir);
	}

Can v9fs_create() even return NULL?
In any case p9_fid_put() already contains an (inline) check for both
NULL and IS_ERR() so the 'if (fid)' and 'fid == NULL' (above) are pointless.

	if (fid)
		p9_fid_put(fid);
	return ERR_PTR(err);

-- David

>  
>  /**
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 71796a89bcf4..83a52a85ce08 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -349,7 +349,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
>  					  struct inode *dir, struct dentry *dentry,
>  					  umode_t omode)
>  {
> -	int err;
> +	int err = 0;
>  	struct v9fs_session_info *v9ses;
>  	struct p9_fid *fid = NULL, *dfid = NULL;
>  	kgid_t gid;
> @@ -412,7 +412,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
>  	p9_fid_put(fid);
>  	v9fs_put_acl(dacl, pacl);
>  	p9_fid_put(dfid);
> -	return ERR_PTR(err);
> +	return err ? ERR_PTR(err) : NULL;
>  }
>  
>  static int

