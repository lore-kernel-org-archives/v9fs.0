Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46EE547
	for <v9fs@lists.linux.dev>; Tue, 18 Jul 2023 09:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=AOCh2pECVFkA2m0PgCMpjH4E1B+tTEN/qI4vKGlwX54=; b=X+CpZ7PHoRJv/rJiDqA1H20lZO
	ieil5mjS9FIPe9GSCjWWPi2MQwATquhizUhraXCHkU9ZDJmZzW6xbjWZZcDVWZxks4qKp/2fMs8IT
	jmKjBbqUAOaLoUJmG175sYZz5rVLsVWszjtEkLV7aybXD1JgX5y5hdcJ85HR2tiVHD2YfcKZ5hccd
	WlbeKDPhf8/BsSnI5My9YTk8Mb5Vq4QhV0P/+RvX5anZ8j9T8tVcVKEr9hS4RQa2z/NU4+K1LUsk/
	GinU1pCh4teENnqiHNAOU4MaIJIjftxXm5lwW9AtTLC7tb3zUKsTaSsGCc+68me314MywADbQOsmN
	UOISuRcZ+tI2wZKcxCR5iTfxAcMd3x29YbuCGebWWKv95kmeKIivDGyjSpRQEiedLHqidHrYpCNFs
	22qFwxscC+77L7loZnBt7Txg57+/HhVhwtzzdE1uVUxxKj8uWePlEQXkjzeej2YhCxvLp6jXYAwAL
	RclbrqFs2gXDdIik/soqenNMmda6IVixNxLdTsyroGjiIZDPC81a1eFR8aBjohqa6qZk/h/wiQhrR
	kMtyZoescLFy6p+z8kjTMLCQVOuPvTLqatVUy7z11OZZwlSEOFrtfQukjk60ITp5ha5Ie1eKSOGng
	FSRs5x5ITF56HCWU4OxhpjeD66BVfEqhPZYBDr+SM=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 2/3] fs/9p: fix typo in comparison logic for cache mode
Date: Tue, 18 Jul 2023 11:34:53 +0200
Message-ID: <2377968.dzquyXH1nE@silver>
In-Reply-To: <ZLX9lUnIwLYT-Oc4@codewreck.org>
References:
 <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v1-2-0683b283b932@kernel.org>
 <ZLX9lUnIwLYT-Oc4@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, July 18, 2023 4:48:53 AM CEST Dominique Martinet wrote:
> Eric Van Hensbergen wrote on Mon, Jul 17, 2023 at 04:29:01PM +0000:
> > There appears to be a typo in the comparison statement for the logic
> > which sets a file's cache mode based on mount flags.
> 
> Shouldn't break anything, but good fix nevertheless, thanks!
> 
> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

Right, at least AFAICS I would not expect any visible behaviour change by this
patch at all. So this patch is probably just a formal fix.

BTW there are a bunch of unnecessary braces in this function:

  (!s_cache) -> !s_cache

  (fid->qid.version == 0) -> fid->qid.version == 0

  (!(s_cache & CACHE_WRITEBACK)) -> !(s_cache & CACHE_WRITEBACK)

These could be wiped in a separate patch as well. Anyway ...

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> > 
> > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> > ---
> >  fs/9p/fid.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> > index 0c51889a60b33..297c2c377e3dd 100644
> > --- a/fs/9p/fid.h
> > +++ b/fs/9p/fid.h
> > @@ -57,7 +57,7 @@ static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
> >  	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
> >  		fid->mode |= P9L_DIRECT; /* no read or write cache */
> >  	} else if ((!(s_cache & CACHE_WRITEBACK)) ||
> > -				(f_flags & O_DSYNC) | (s_flags & V9FS_SYNC)) {
> > +				(f_flags & O_DSYNC) || (s_flags & V9FS_SYNC)) {
> >  		fid->mode |= P9L_NOWRITECACHE;
> >  	}
> >  }
> > 
> 
> 




