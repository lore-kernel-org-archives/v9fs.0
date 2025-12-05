Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3B2FBE09;
	Fri,  5 Dec 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764941816; cv=none; b=WJArJN6ik9pA845Es4UQcOnmUkJ4YpUPvLQJoynFEIZGOWbpyG08x6Kku2OI90PD0/i0jYkkwNMNheSfkp8aL9Azl247McyVcWVdl2W4FXn68xkrXE4AaUkNDZJEG8CdFaz+ZC6I68WjifglirEFZp3GXxwnQQmbpv2VeLhyYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764941816; c=relaxed/simple;
	bh=kKwByTI4sXyhIE+hKlAUpIFU8P+VyxQYtplWn/0a1ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lET/EQB0fF9t+l2SWrUN+HZ9u10ZPjJCnDsJNMLSsu1J6VE+4NZ62lI8FiO31LzbTw6TYly2g/Sw6npxfIBT1ohsuXS7PJFi0+OCrXkUg8xEmDg/3eMDfc2HSysnkxk3qFcLOwb7ThIn5ZgKKicTf0kuliZCGzFyuqbhryXQWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=NXFC5tCe; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="NXFC5tCe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=I7eeqVBfxAvYathWoM67aeY+g/ciHa9CX2OQmPXAyV0=; b=NXFC5tCe98cXqXcXAE9olXOPQq
	KyHPPSTH02fzsIPiFeUAskT5EamUoWiWKxzTEZI1wOaxjeroFEVhgtP+oItI7Vxm1A3B6PJOvyqw4
	u0ektaTdNSQqSbKGUP2RFv0fyvpQQy5gaiUcqQpJo2mH1tfnRNMOGJMSww7yajP5/vcFlTqj9aNB9
	HVWwj/F2XlmOKIoLgVqFqz8wKWW0HDGaeE3+RPBnLJ/PXxt/1vrgFOD8JpKfdlnlZgOYTRG3rYqDW
	BN+LYzRjO2yaVcVo2pKNJXBhL3l77l3e3JI2E+3YlrP8eQ3PT/UbDeyGYYBwGAxpRq3owBVxl0tf1
	9P3mOPAIyHJfKzHlisl4lXYnxhoDgM8IFPP2w6gyvi2TDR5u7Umqo5ba59PnTkbOtuNMD8nV4BRh3
	IJeV62mSSj3WbN284cR+u57MhZyAsJbAImpGYHeOXc0oNiO1fR1W4RTbP9nYyv86PFCq0acqHVmHu
	Ulq9rYMdU7nBRQ2dfMwt4+GAtkjGkBGKnthHEHi+hpWsNRbQJBLuOqiMeDqCjlR7g1Df7aKH+F8eE
	6JnZdjQhbH2OHVSgZI3Z0VtRTPc2pwlb4dZ4z2sgRSWHmjYA66t6LQOP0Z7OzJWVgPNouMXMIXtUG
	X7slH/bvMMnpjyxz0SH7/Tv5z5Zh0907MR5NJ7OBI=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Arges <carges@cloudflare.com>,
 David Howells <dhowells@redhat.com>, ericvh@kernel.org, lucho@ionkov.net,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Subject:
 Re: kernel BUG when mounting large block xfs backed by 9p (folio ref count
 bug)
Date: Fri, 05 Dec 2025 14:36:41 +0100
Message-ID: <2245723.irdbgypaU6@weasel>
In-Reply-To: <aTLYEF4ZaTwF3tdL@codewreck.org>
References:
 <aSR-C4ahmNRoUV58@861G6M3> <5945634.DvuYhMxLoT@weasel>
 <aTLYEF4ZaTwF3tdL@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 5 December 2025 14:03:12 CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Fri, Dec 05, 2025 at 11:47:10AM +0100:
> > > Oh, hang on.  You're passing a kmalloc'ed page to
> > > iov_iter_get_pages_alloc().  That's not allowed ...
> > > 
> > > see
> > > https://lore.kernel.org/all/20250310142750.1209192-1-willy@infradead.org
> > > /
> > 
> > I'm confused. Looking at p9_get_mapped_pages(),
> > iov_iter_get_pages_alloc2() is only called for user space iovec data,
> > isn't it?
> 
> I think that doesn't hold true when mounting a filesystem with -o
> loop -- afaiu the kernel issues IOs to 9p from the XFS subsystem, so
> these can come from kmalloc or whatever it is they get memory with.
> 
> As to what to do with this, given Willy's last reply (thanks!), I'm
> honestly still not sure... If we can detect the pages are coming from
> somewhere we don't like I guess we can return EIO instead as a stop-gap
> measure (better than a crash)?
> If we check early enough (in client.c generic code) perhaps we could
> route these to the non-zc path that doesn't require this, so let's start
> by trying to figure out how to check what kind of page we got...?

Haven't checked yet, but shouldn't it be like this?

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 0b8086f58ad5..5ff4bfe25a3e 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -318,7 +318,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
        if (!iov_iter_count(data))
                return 0;
 
-       if (!iov_iter_is_kvec(data)) {
+       if (iov_iter_is_iovec(data)) {
                int n;
                /*
                 * We allow only p9_max_pages pinned. We wait for the



