Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115A17D4
	for <v9fs@lists.linux.dev>; Tue, 18 Jul 2023 02:50:27 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id C76A3C01E; Tue, 18 Jul 2023 04:50:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1689648625; bh=wJz99+njLvG/FzGn7fEs+yqA3KyAmCqTev3CP76dB6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0k1QVCyqWppSXRu9b0CgGfUuScnAXyJ0K7Oxt93Xz7fQUi0U0P/9rQGJmmJcjByOA
	 tWoDLJC9Xo+c2LL+CrP2ZbnDAFA6XYSegv4TNwieA8k6snaiyNQ7OsnWkJjBgCrv20
	 RGxH1Sm8yI/4+dgDfRT8aTQCWFLJUeOi8DN68y8DJlUekxPV214+4xjSGgwKGkfqVd
	 MJlR9KmYnQRoZOC3QdJdeYKHsLS6junNuHRhlwrxgmu1G04XF/951OEwfAIdPwOPW2
	 iDwFesWkIgqgTLv/duKZEkg19ktJU3fDWRYwicZasUq+uIOfY8cXvXu5QfhtYVW9B3
	 Qt9OJb0C358ng==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 31F16C01A;
	Tue, 18 Jul 2023 04:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1689648625; bh=wJz99+njLvG/FzGn7fEs+yqA3KyAmCqTev3CP76dB6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0k1QVCyqWppSXRu9b0CgGfUuScnAXyJ0K7Oxt93Xz7fQUi0U0P/9rQGJmmJcjByOA
	 tWoDLJC9Xo+c2LL+CrP2ZbnDAFA6XYSegv4TNwieA8k6snaiyNQ7OsnWkJjBgCrv20
	 RGxH1Sm8yI/4+dgDfRT8aTQCWFLJUeOi8DN68y8DJlUekxPV214+4xjSGgwKGkfqVd
	 MJlR9KmYnQRoZOC3QdJdeYKHsLS6junNuHRhlwrxgmu1G04XF/951OEwfAIdPwOPW2
	 iDwFesWkIgqgTLv/duKZEkg19ktJU3fDWRYwicZasUq+uIOfY8cXvXu5QfhtYVW9B3
	 Qt9OJb0C358ng==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id cd499b91;
	Tue, 18 Jul 2023 02:50:20 +0000 (UTC)
Date: Tue, 18 Jul 2023 11:50:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 3/3] fs/9p: fix type mismatch in file cache mode helper
Message-ID: <ZLX93Z81efpEWjaa@codewreck.org>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v1-3-0683b283b932@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v1-3-0683b283b932@kernel.org>

Eric Van Hensbergen wrote on Mon, Jul 17, 2023 at 04:29:02PM +0000:
> There were two flags which had incorrect type in the
> paramaters of the file cache mode helper function.

Checked the parameters passed (v9ses->cache, file->f_flags and a flags
parent function parameters) were all correctly unsigned:

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/fid.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index 297c2c377e3dd..29281b7c38870 100644
> --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -46,8 +46,8 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
>   * NOTE: these are set after open so only reflect 9p client not
>   * underlying file system on server.
>   */
> -static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
> -	int s_cache, unsigned int f_flags)
> +static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
> +	unsigned int s_cache, unsigned int f_flags)
>  {
>  	if (fid->qid.type != P9_QTFILE)
>  		return;
> 

-- 
Dominique Martinet | Asmadeus
