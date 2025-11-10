Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492121257A
	for <v9fs@lists.linux.dev>; Mon, 10 Nov 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783145; cv=none; b=WhkkpJh+WSWy4rhXMbRsSOaC+lW3s6KaWvQyZaaCrLSHwvWom4SWJSseMy3+zI/E7Ktb3/Z6cNNtdNr5oWDYoH5yPsMVbVfjMiIf2RFl3dSxGawUjEK1a/U8Zf36TkKTqRLAEsTWKGxnqRGawoTr6e9jIC5VNXTa4fDI6XJpBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783145; c=relaxed/simple;
	bh=ybEbia6mZqGAc8v+mEtqDDo339lG1/cbWwjU09v7lOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWOMBEst/6FPd2BVNLoZKeu3HfeyZUqGUTmkXT0AnUblgBt+8bYC9b8J5ADWYsfeT6epL4ysfnaSZY3+nf33RtexlGfwScxKpsqIVTuEjeIWJ9B7zjenwxfAebWj+Ia/vAkHe+rIHLwEGRVn0DHhelxMaItyebovC9FqKykQKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=QOnQL5TP; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="QOnQL5TP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=IJruCgD+xaNvDIwXAqIuU1hd0qBJ4K9dKZWu5bA/U2A=; b=QOnQL5TPtTySDdWBstH3QhW29d
	OMr8OSCouQRm3ASbWzTqSJ3c/1LRJLgDoKXTB5t/9aFN+Y2w1paZmRXZ40lMZDwDGwt9BpDB5rcri
	pMUNEBCj7vwrjRliq8GNnKkzCruJl0oSSbqXVtaJALm7Yk7qjptVA74Q0PTt5ISI7/OfobVJE8wsc
	P2j7WZwwf/y34Vy+0PlfxOmEwrUIIJM43Xl3DNQZEFk1vv+lHCf/Ogx/SF/E+AcshYme7YK6Idw6w
	v0gZ9gKMZJ0hK2e81qc2nsPfPQ5EnqfDTafda6jRXRyqkSySi8tiQvJBtFqumT9xfQdt06MlsBF4J
	jNaYAu2xdtapoEUxas8ETnhhMPjQQgBUKTXyqvtNUr4HkbWT3WJmzKIvVZs8/1oT6mdJlNQs+YXWH
	Wag7MV8IO8ElAulN8pmFxSvIbz2mNaHY8CAxsJoXPPBSaswWqjM5gwhbMg653AKl3ZP+5j/s/IwJR
	6yw7ClXiS9cjoD/eMV7yUmJPL6a3tDvbo0eSvi6wN6Pi0ue/hkOw44BDyiAKEzPvK5bZDQ2U6L6uE
	WICyY14VFBeRTykGC0efUrkL7It+iW+N3wkWHjLJZ09ifxRFZbzpc9VLYorK4/UGxoDaiC+Ji9Gop
	Kq2EYKbTeH9Jo4ySGDVcaNHWGLuep2Uy582xeyIoM=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Tingmao Wang <m@maowtm.org>, Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Subject:
 Re: [PATCH v2] fs/9p: Don't open remote file with APPEND mode when writeback
 cache is used
Date: Mon, 10 Nov 2025 14:25:20 +0100
Message-ID: <3315313.d5zAtLYnLX@silver>
In-Reply-To: <aQha--QBgwu8DoDE@codewreck.org>
References:
 <cover.1762115015.git.m@maowtm.org> <20251102235631.8724-1-m@maowtm.org>
 <aQha--QBgwu8DoDE@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 3, 2025 8:34:19 AM CET Dominique Martinet wrote:
> Thanks for the v2
> 
> Tingmao Wang wrote on Sun, Nov 02, 2025 at 11:56:30PM +0000:
> > I haven't done a bisect to figure out if this regression was introduced by
> > a change or was this behaviour always present - 6.14 has the same problem
> > and 6.13 did not compile for me due to some problem with bool / true /
> > false being a keyword in c23, and it could not compile with c17 either.
> 
> Ok so you got me at the "it happens in cache=loose too", so I went ahead
> with bisect... I had the same problem with newer gcc being c23 and older
> kernels being silly, you'd think `KCFLAGS=-std=gnu11` is enough but some
> arch makefiles ignore that so I went in heavy patching
> arch/x86/boot/Makefile and arch/x86/boot/compressed/Makefile . . .
> ... Anyway, it certainly didn't break recently, but it's not ages ago
> either: the repro you made (thank you!!) starts failing in 6.4 cache
> rework: the first bad commit is actually 21e26d5e54ab ("fs/9p: Fix bit
> operation logic error"), but that's just a fixup of the previous commit
> so 4eb3117888a9 ("fs/9p: Rework cache modes and add new options to
> Documentation") is the cluprit... and... I'm not quite sure I get why
> without digging deeper...
> (But at least that made me realize the commit just before, 1543b4c5071c
> ("fs/9p: remove writeback fid and fix per-file modes"), removed the
> writeback fid I was talking about... But that commit was working (with a
> sane ~P9_OWRITE mask), so it's not directly that removal that broke
> things, but something else in the rework)

Haven't tested, but to me it looks like 1543b4c5071c ("fs/9p: remove writeback 
fid and fix per-file modes") was the causing change. Up to that commit the 
open flags were hard coded to exactly O_RDWR for all writeback fids:

struct p9_fid *v9fs_writeback_fid(struct dentry *dentry)
{
    ...
    /*
     * writeback fid will only be used to write back the
     * dirty pages. We always request for the open fid in read-write
     * mode so that a partial page write which result in page
     * read can work.
     */
    err = p9_client_open(fid, O_RDWR);
    ...
}

/Christian

> Anyway, I think this commit is a strict improvement over the current
> situation, I'll just slap a Fixes tag and push to -next for now, and if
> time allows I'll try to have a closer look...
> 
> Thanks,


