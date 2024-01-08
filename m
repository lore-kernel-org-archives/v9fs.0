Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462341226
	for <v9fs@lists.linux.dev>; Mon,  8 Jan 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFmceNIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E18C433C8;
	Mon,  8 Jan 2024 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704718603;
	bh=CI9WZbFsKpI4w2t6C08wTtvZLR9Dl548SViUhtWK5MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFmceNIZAKqOQQSQNfmshI/z5iv6jwWCE3Df3Ha+Ce/QmH+c7NhigQfK2/Dp3q2wH
	 ZCCcSmXzQ9+scQrjsZ0C+digPwg/S4L372E1IDX8CBhGACkEuBKunxvHByzdYTHqe+
	 kb/95sCa/zey89+o7JLESHT3/PQPrcqUmgBtr+tg7h9aqNLnKoyNHsfxIzYJqotqZt
	 9e09otxIoTURBNUE5TyGCvH0S1HAzM/qY/uYsVoWN0CDKDEqsFrInjZOor3ow/0C3O
	 H0OtVTbcX0xcEniRn9lJmV3vkDiW+M1ytQfs2umfz4fyIOAVLEsKYf0PDWHGhXa33D
	 3olS7iNhSWIyg==
Date: Mon, 8 Jan 2024 06:56:39 -0600
From: Eric Van Hensbergen <ericvh@kernel.org>
To: asmadeus@codewreck.org
Cc: v9fs@lists.linux.dev, linux_oss@crudebyte.com, rminnich@gmail.com,
	lucho@ionkov.net
Subject: Re: [PATCH 7/9] fs/9p: rework qid2ino logic
Message-ID: <ZZvxB3u-yMypFI6c@FV7GG9FTHL>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
 <20240106-ericvh-fix-cache-dups-v1-7-538c2074f363@kernel.org>
 <ZZvcT2__1syWHdbC@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZvcT2__1syWHdbC@codewreck.org>

On Mon, Jan 08, 2024 at 08:28:15PM +0900, asmadeus@codewreck.org wrote:
> Eric Van Hensbergen wrote on Sat, Jan 06, 2024 at 02:11:14AM +0000:
> > 
> > diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
> > index ad0310deb6c8..789e1188d5dc 100644
> > --- a/fs/9p/v9fs_vfs.h
> > +++ b/fs/9p/v9fs_vfs.h
> > @@ -43,7 +43,12 @@ void v9fs_free_inode(struct inode *inode);
> >  int v9fs_init_inode(struct v9fs_session_info *v9ses,
> >  		    struct inode *inode, umode_t mode, dev_t rdev);
> >  void v9fs_evict_inode(struct inode *inode);
> > -ino_t v9fs_qid2ino(struct p9_qid *qid);
> > +#if (ULONG_MAX == 0xffffffffUL)
> 
> The standard preprocessor condition in the kernel for this is checking
> BITS_PER_LONG, e.g.
> include/asm-generic/bitops/fls64.h
> 18:#if BITS_PER_LONG == 32
> 26:#elif BITS_PER_LONG == 64
> 33:#else
> 34:#error BITS_PER_LONG not 32 or 64
> 35:#endif
>

Thanks for that, will update to be consistent with rest of kernel.
 
> > -
> > +
> 
> stray white space?
> 

oops, will fix.

> > @@ -428,7 +426,6 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
> >  	 * FIXME!! we may need support for stale inodes
> >  	 * later.
> >  	 */
> > -	inode->i_ino = i_ino;
> 
> This is gone, but v9fs_qid_iget_dotl() still sets i_ino -- didn't check
> which is needed but we probably want to stay coherent between the two.
>

Good catch, deleted it from .L (and later here but in a different patch)
because its largely vestigial since this gets set in iget_locked anyways.
Will fix up to be more consistent.

      -eric
 
