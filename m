Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88523C8C7
	for <v9fs@lists.linux.dev>; Wed, 24 Dec 2025 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766615668; cv=none; b=TgEtabExifDeEuFhA/nZuc4HZN2kjAiqZv1gpstLvKUFSN192LCGQwkvkHvCPcMpWYXcrNb0cTUsGcxibWeVm8xP9pV9+YYtn4M6vygL22TJYmeyZBj3mguMHK6iGEJuHMpn4Hc9qiRVw9VsZvmbXlsGAEeUmjVMrkSGqblkOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766615668; c=relaxed/simple;
	bh=mcJ6T/oyXVa6dGO5sOKjxR8gzSrX+J7J1iIHWCFmA7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/A1EN7eIrbspwvRrSAXOMocoPyjbbZb2FEksGvx5Vq6JjvOLY+5awFsO+GYyd5IyvPCkWh3/dHYVcLuds6j3ukwuVTD2Lr0GeiRauslivzk5BiAZ7QxSNQCMg+fBKtV1v3ozZ6ORLal88WxG878be71rtTfHyYGoGTGdX0brX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=vLPYIMyq; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="vLPYIMyq"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0B89B14C2D6;
	Wed, 24 Dec 2025 23:34:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1766615657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCEyi7tf/Z1TJthxjHkQwN0GtqGJp71AYTBN8YD8M7M=;
	b=vLPYIMyqMPEOX7tR/ECtqHAnbiBU9dek9seWkrHfX+xTcSwGC4dnLVyx48PNKm5uORc+zD
	3ay4Ar2bWT5eT3hkz4M9H8Au87DflzMUlBO0hwidxpCJ6NubZaSwaoGHobLtEhrKwUWOLy
	0BO5F0B/rnydvoh8m5V/uKNQ+fg5pmcmPm5rFJZKDBy+nXnDo6ncVApe4le905V60AFKw4
	gadSHXbBwP4NE0e9gTO2xze6QF2n19ApKnSEoSZ12Gcx1ebBS9YpkXc/+mbR2Ph7/gmg/v
	9oWW1PzbgLQlHvEDnfLrq3b2ArWJJrlbMXnlUJA9qf/Rpa/WpzPjLFMh+gmDSw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5f376c84;
	Wed, 24 Dec 2025 22:34:13 +0000 (UTC)
Date: Thu, 25 Dec 2025 07:33:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Pierre Barre <pierre@barre.sh>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [BUG] 9p: data corruption with cache=mmap under concurrent
 stat/write
Message-ID: <aUxqVn0DO7ee9K2_@codewreck.org>
References: <aea6cd1d-ff2b-4288-8196-edfdfd1539f6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aea6cd1d-ff2b-4288-8196-edfdfd1539f6@app.fastmail.com>

Hi Pierre,

Pierre Barre wrote on Wed, Dec 24, 2025 at 03:29:01PM +0100:
> I'm hitting data corruption using 9p with cache=mmap when stat() is called concurrently with writes.

Thanks for the report

> Environment:
> - Kernel: v6.18.1-061801
> - Mount options: cache=mmap
> - Transport: unix
> 
> Reproducer:
> 1. Mount 9p filesystem with cache=mmap
> 2. Run PostgreSQL with data directory on 9p mount
> 3. Run pgbench workload
> 4. Simultaneously run `watch -n 0.1 tree -ah` on the data directory
> 
> PostgreSQL reports:
>   ERROR: unexpected data beyond EOF in block N of relation "..."

unexpected data beyond EOF looks a lot like
https://lkml.kernel.org/r/938162.1766233900@warthog.procyon.org.uk

could you try with this patch?

if it doesn't work we need a better look

>   HINT: This has been seen to occur with buggy kernels
> 
> Analysis:
> 
> The issue appears to be race conditions in getattr/setattr when using
> writeback caching:
> 
> 1. v9fs_vfs_getattr_dotl() condition checks `v9ses->cache` instead of
>    `v9ses->cache & CACHE_WRITEBACK`, triggering writeback flush for
>    any cache mode
> 2. Both getattr and setattr call filemap_fdatawrite() which initiates
>    writeback but doesn't wait for completion. The subsequent server
>    stat/wstat sees stale file size.
> 
> Would using filemap_write_and_wait() instead be the correct fix?

-- 
Dominique Martinet | Asmadeus
