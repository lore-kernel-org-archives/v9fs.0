Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82CD24B26;
	Wed, 30 Jul 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896493; cv=none; b=frTkSXBoDI9Ser0RxBoGpFITc5y24q2PLNy6htI6ieTHsBtEpuSspyC77Q74j3nh5WwKwgkyQdd2kLAtt5EK/RXwy4YyZ+YYYK+rXasQIiU1lC4bbNSmX7uZ0Y//ArD25jclkviP6SwNVaKKx+SYPoXLYBLhBA3udI199s8yQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896493; c=relaxed/simple;
	bh=JjmuY8DFzgMy2TKr+WyJ2EWjjp4TmyV4tQJJJKS9yi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/7+EToG2Hxg5W4ZdMT4NTiDP/sB9xMj1fRpkt5OpSIFH7f33CPcUw3iD9tOpPK2SWMc6ePRCo0nszY3kw+SqsmTZ4xcE9lNXFDZ7S/mx4nNJsNmb7gNd836M/0FWglpFICXMnMQosnqIJmmjPTza/VriTZwfllNF1/sDJVnnd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=YqK+RXyD; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="YqK+RXyD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=3Gbk3Sqo2hYVjm3I0SkL68Ub+vIB1qTw/GwnXeIdsUg=; b=YqK+RXyD9Wxm68e7UTwkeSS6Oo
	eA4JvlofNDzHrNp5XHUrKnfNbAU7ngCMjEnKnY0wTcP5pJUbTr6Um94uSOL/mG+AaZX7salN0E6I/
	yD/3ydQB1ICJbluAkbJk0wUMx8kl+bGbOTIrWL9Ed9yZxsZF3p3SYS/0uAyCwzbPQTKtutc5LlLOB
	sZvrn07wxKLowKzKgqecWLEcfWgB1B+d1T2dAVKQwO/VxkHgmL2ETniJ9tBj73bubLpQYSHTOmknm
	JD/C7WTpnhSi54vjzoFHim4Z4XLgzw30wK8ZzkJP+yuk37VpG7pUMLjPDn6ZkZbY3i13iJTpjV9Ra
	1uPQbSQ3rDB7MyNiiP4FB+9KHPHN7+GQhLI4oOQVAhXN5Q3qPOeKJmtUo1lX3Ia7DU2bHwzNiChrc
	OMGmZAYnMBzD1x9A3Jxc64nPcP4SHid6kGVrOMc31zKXvNXL4o791g4uookMj3O4VS94zZjycexB4
	sZlhlGAg7VI0Vur8FbxVssN/AbjNFxjrTgw2yuzqHGcU9kzRoSOezYxlXOvAcKs8KHE87Lm+MFppl
	4zcFQ27Ll+mH17q+apEcDWzcMmJUQf5F9SUZAkJM7FuEXWZwvkMb+PULWzm0zQtyswDSk6kApcVw0
	dT/43jSc0cH1bEDjtLgBrVrEcTwXLaKbUeIqjdlWM=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Pierre Barre <pierre@barre.sh>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Use kvmalloc for message buffers
Date: Wed, 30 Jul 2025 19:28:02 +0200
Message-ID: <2026737.7mX0AZtNi0@silver>
In-Reply-To: <1fcc97fd-bf32-4ea1-82c1-74a8efb6359b@app.fastmail.com>
References:
 <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <2989343.ydHz1Oe0dO@silver>
 <1fcc97fd-bf32-4ea1-82c1-74a8efb6359b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, July 30, 2025 6:19:37 PM CEST Pierre Barre wrote:
> Thank you for your email.
> 
> > What was msize?
> 
> I was mounting the filesystem using:
> 
> trans=tcp,port=5564,version=9p2000.L,msize=1048576,cache=mmap,access=user

Yeah, that explains both why you were triggering this issue, as 1M msize will
likely cause kmalloc() failures under heavy load, and why your patch was
working for you due to chosen tcp transport.

> > That would work with certain transports like fd I guess, but not via
> > virtio-pci transport for instance, since PCI-DMA requires physical pages. Same
> > applies to Xen transport I guess.
> 
> Would it be acceptable to add a mount option (like nocontig or loosealloc?) that enables kvmalloc?

Dominique's call obviously, I'm just giving my few cents here. To me it would
make sense to fix the root cause instead of shorting a symptom:

Right now 9p filesystem code (under fs/9p) requires a linear buffer, whereas
some 9p transports (under net/9p) require physical pages, and the latter is
not going to change.

One solution therefore might be changing fs/9p code to work on a scatter/
gather list instead of a simple linear buffer. But I guess that would be too
much work.

So a more reasonable solution instead might be using kvmalloc(), as suggested
by you, and adjusting the individual transports such that they translate a
virtual memory address to a list of physical addresses via e.g.
vmalloc_to_page() if needed.

/Christian


