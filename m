Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243427;
	b=hXlrUXzokz1CJb6j9dGN5tuU3hJjLw5ZWBoEexQskIblEA6HNtXrHc3u3oDJXmPaxuY8
	 pJdrtnGDb4xyqA6PgFnaOyn/1CMf/GLifPsSotDCm7t09KdZEjIzjfi8uvKhWj4PMEdwm
	 Am/06yxeBYdxOkEO9UJN6DNl8kGsqAqbEnb0H4ilJ66XLfBsdOh2syrBpLyzrlfTIm3wI
	 eU/T9K3YZAKzv63qew8xi145jUudZAxQ2/ok7NZ0KpoBCITbbs5SzlDdG2JjK3wxBN1f+
	 lds8DMntsdIb9Ix3FSFruRviFYOscunlpnw9sDSbiT5CqW+CCW9qaHN7YozTkrhvaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243427;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Hnn+XSsK00XAAHUyElKxTpv43aVdKWCxhzx8Lt6Vo0c=;
	b=nKuZKL79jmbS31FztL5zUoFMThoqaMicxTKtlER0R8qZCs8oqpEd5SNWbz/Zf1j9kTQd
	 VVtwn1J2+cy9DnULEikENZeXHDlPDXbWbf3QcSXk+AZr3UcgoQ++XUlcRS7+2SXlv2eSI
	 UIhMq7dOlk9k1r6gLqOSQ1bhYnnbmcsDvPGKBEmvboI+7lY+CgG7enUJwY965+HzPCOhb
	 Jplk9HQAxgL4UzqzL9DAWDvoqZWJNVviu6JA/zy5PtpxAt2n4HdZ9dHv48VBRbkZMbUbP
	 vXnhCKSN9gJaxrgceQHNDgL5RGDKT8iqEtQHontH5FqUChcnx4A/eZMLZS9Ese5ya1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=cMR+2lEK;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0973606A321
	for <v9fs@lists.linux.dev>; Thu, 29 Oct 2026 03:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0973606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=cMR+2lEK
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D655514C2DE;
	Thu, 29 Oct 2026 04:10:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793243422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hnn+XSsK00XAAHUyElKxTpv43aVdKWCxhzx8Lt6Vo0c=;
	b=cMR+2lEKtXOsLFLqlERdy5zBSngHlk26guVQyW6eXEz3xVHbs1oU7uthPE06wRq5UY8B7W
	4yw0quqKKkFY6pmUequs0pzSQ5C5AbCmdlNSmjAdLra6YAmf5GdSvJUrUCb3GSi3QmFORn
	huY48+/ImEK7OJTeFVWeqnkqOQS2caTCT46dPpbjLg6SbT04NTuBFf1UPViv7nmd0zXJmy
	62WQMlTBvZ5uUDQcqUGSyaNM0xdSoOFQ/YfKAHxc+jkEKe4DjX393StflqnCX1T8+CJcq7
	6t9S5u6DCvGw4J6KfDV2jWjDOai9hKRRzm5n5haWuLxHwIXpVRDRIxZfVLqOOw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e9ce229a;
	Thu, 29 Oct 2026 03:10:19 +0000 (UTC)
Date: Thu, 29 Oct 2026 12:10:04 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: do not store the create fid on special files
Message-ID: <auK5DISBP3Nmls1I@codewreck.org>
References: <92377346-29E9-46D3-96F5-AABA8A64CD57@stu.pku.edu.cn>
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
In-Reply-To: <92377346-29E9-46D3-96F5-AABA8A64CD57@stu.pku.edu.cn>

Yuanfu Xie wrote on Tue, Sep 22, 2026 at 09:16:22PM +0800:
> v9fs_vfs_atomic_open_dotl() always stores the create fid in
> file->private_data after finish_open().  FIFO and device inodes
> already have type-specific file_operations that own that field.
> Overwriting it with the fid makes later read/write/close treat the
> p9_fid as a pipe_inode_info, which corrupts the fid and can use it
> after it has been clunked.  The non-dotl atomic_open path does not
> assign the fid this way.
> 
> Only attach the fid for regular files and directories.  Special
> files do not need the create fid; leave it for the existing
> p9_fid_put() on the out path so it is clunked before return.
> 
> KASAN report, linux-stable 4982d3552a3b:
> 
> BUG: KASAN: slab-use-after-free in anon_pipe_prefill_and_lock+0x376/0x3f0
> Read of size 4 at addr ffff88800ab30538 by task repro/1
> 
> Call Trace:
>  <TASK>
>  anon_pipe_prefill_and_lock+0x376/0x3f0
>  anon_pipe_write+0x127/0x1600
>  fifo_pipe_write+0x24/0x300
>  vfs_write+0x659/0xd00
>  ksys_write+0x10f/0x200
>  do_syscall_64+0xdd/0x4a0
>  </TASK>
> 
> Fixes: 30d904947459 ("kill struct opendata")
> Signed-off-by: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>

Thanks, also picked up

-- 
Dominique Martinet | Asmadeus
