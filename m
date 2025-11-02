Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195812F5E
	for <v9fs@lists.linux.dev>; Sun,  2 Nov 2025 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762124879; cv=none; b=aG3ovUgtehRuPwJTrAG2r7VAFRlC9wYlujRw4A1hI1CjkVuPO1GaCndNu1DvW0dz7cZmH7o0ambJuLfK3QpYsoj1BKWIQ2H2BN6F3w6ocVPPb9pCsEFF/M7Cm5v7j/kp2ed/tiTAQG0DQHGHvH8zv2a+3XuRhC+ED4rGmJbvilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762124879; c=relaxed/simple;
	bh=BEKn9z8G+P8Hon0lVC9IRXlc7seX4MG6OpW9aqY4mag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwXc84UFXxOMuLwtw4mhjyYpzFDyjUYezMfOlYrC/6UGTza3ePJlaWRtftx53n8sF7xEPuaKIajJQ8/ObHs+C4iKk7ubBTeJS1b42x68nUfT/2laELKrN13WVCAsIOHvuq20MaN2lRFU4aPQ0q9GuD3Vv2L36K6VRkUqT/WOLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ylJaTqdH; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ylJaTqdH"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 08C7E14C2D3;
	Mon,  3 Nov 2025 00:07:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1762124867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSodQaJgIQb77k3eL4FQI16TAYIQ7v57UHPO4Z8UcGY=;
	b=ylJaTqdHumVMi3cQkIzURbn2iJt0lPfgxI37XfzMsXT5WddaZrGytUq/9Ds5QDPi30LiUN
	mEuyDr6b8FgziR1hLTQswtRDuKLwRpnmN/UQD9U3V63FGr55p/mbsgQDIgiiJbYCqJd1m7
	STotX2ochxX2y1a5yrHurP1pt3gM5baB2OpMY3Qaj4s/fJuMIkC+7jZ0k/E2lBFY4iD9Os
	28hTP3lSAFsxwNVjhw+ROxW4CY/ejJqZrYDL2NHB/EA9cDe3ZZ9XK6jh4mCDMTffQwB5ZG
	g/KScU63wQQrvMoogzHE56N+pVTO4J4WfrR/GnEhN8Da75CKgELK5x9iLxAkKw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id fd3a5c00;
	Sun, 2 Nov 2025 23:07:44 +0000 (UTC)
Date: Mon, 3 Nov 2025 08:07:29 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Subject: Re: [PATCH 1/1] fs/9p: Do not open remote file with APPEND mode when
 writeback cache is used
Message-ID: <aQfkMUncxteb9aPW@codewreck.org>
References: <cover.1762115015.git.m@maowtm.org>
 <ed2d3f0045f538e8ddbd2d0a151e31767dda87e8.1762115015.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed2d3f0045f538e8ddbd2d0a151e31767dda87e8.1762115015.git.m@maowtm.org>

Tingmao Wang wrote on Sun, Nov 02, 2025 at 08:24:39PM +0000:
> When page cache is used, writebacks are done on a page granularity, and it
> is expected that the underlying filesystem (such as v9fs) should respect
> the write position.  However, currently v9fs will passthrough O_APPEND to
> the server even on cached mode.  This causes data corruption if a sync or
> fstat gets between two writes to the same file.

Ugh.. I'd never expect O_APPEND to have any effect on the server tbh,
9p writes are "pwrite"-like, the offset is always specified -- there is
no plain write(fid, data) call -- so O_APPEND should have nothing to do
with the remote :/

(well, man pwrite(2) does say this... So that explains the behavior if
qemu respects the flag:
BUGS
   POSIX requires that opening a file with the O_APPEND flag should have
   no effect on the location at which pwrite() writes data. However, on
   Linux, if a file is opened with O_APPEND, pwrite() appends data to the
   end of the file, regardless of the value of offset. 
)

I guess I can see this being useful if multiple clients are involved in
cacheless mode, but I agree any kind of data cache should strip this
flag.
(I think this didn't cause problem in other cache modes because writes
through the page cache happen on a writeback fid that's opened with
fixed (no O_APPEND) flags?...)


> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 612a230bc012..ff95dfb30583 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -43,14 +43,18 @@ int v9fs_file_open(struct inode *inode, struct file *file)
>  	struct v9fs_session_info *v9ses;
>  	struct p9_fid *fid;
>  	int omode;
> +	int o_append;
>  
>  	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
>  	v9ses = v9fs_inode2v9ses(inode);
> -	if (v9fs_proto_dotl(v9ses))
> +	if (v9fs_proto_dotl(v9ses)) {
>  		omode = v9fs_open_to_dotl_flags(file->f_flags);
> -	else
> +		o_append = P9_DOTL_APPEND;
> +	} else {
>  		omode = v9fs_uflags2omode(file->f_flags,
>  					v9fs_proto_dotu(v9ses));
> +		o_append = P9_OAPPEND;
> +	}
>  	fid = file->private_data;
>  	if (!fid) {
>  		fid = v9fs_fid_clone(file_dentry(file));
> @@ -61,6 +65,11 @@ int v9fs_file_open(struct inode *inode, struct file *file)
>  			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
>  
>  			p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try opening O_RDWR\n");
> +			if (omode & o_append) {
> +				writeback_omode &= ~o_append;
> +				p9_debug(P9_DEBUG_CACHE, "removing append from open mode in writeback cache mode\n");
> +			}

I wouldn't bother with the debug message, just clear it like P9_OWRITE:
   int writebeack_omode = (omode & ~(P9_OWRITE|o_append)) | P9_ORDWR;

(same for other hunks)
-- 
Dominique Martinet | Asmadeus
