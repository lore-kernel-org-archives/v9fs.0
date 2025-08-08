Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFC145329;
	Fri,  8 Aug 2025 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651542; cv=none; b=ahVl66FaGvLq6u4E+L/eNpGiKB/DlJDbPIZgdFbVR5S2XG8dm5tlg6x24EE/zh3MFhc671wDwdDn1+zgvFeIv/RQp2aY+cWFdW15NqzJbvok68FKRLZvKu6STJ3k7yEn1K8obQz5wmslTBLXeS1HAFHF+uAZlnn/kkyU7QpvDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651542; c=relaxed/simple;
	bh=mY/wL9UIkAIFI1mNLPqGbgPa914Wg+wkGjj7JcSW9Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p96x+K4BmwqDOPFnXz5gANoWAfuORiVk6ljkS6WPXw4qJ0z3xtJIbpHRGaBL5aMHnuqoe5IZXVxJ/ILYbSagvy2qtC7mteXDuG6Z0PYwqkfTuq7MdeLHqtLXi16x52dwPVTGvjNsw0IwMUYLpxKDQU2LlPkwvCow6/SvL9IUEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=H9G9Kl4O; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="H9G9Kl4O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=KZyAoLIDCCNjDR5EyXkaxLElgk1EdKIqDrVQYIfIUE0=; b=H9G9Kl4Oj29A/TIE5qngLE3AlE
	uVtI9UTr5njjm89yLLoFIfgxRRgCtYy0xZogq45kqHzMwGDq0aTwoyrSOuNsciZtbxu2FfBv2yyn+
	MbT81EJyruz9GBaaQ8CsUZvFEhWef1zZqsbyV7TF7kgRPgM3MfN+CInuM/f/PL4bYxJbizMpg44aA
	ylzDHdhNxEGYQeDvOHsJQ5+zElPTaM1IQPowvjci6EehEU5IEHw39V/MDBKBzFLACyUlKI7zXl5//
	Q/5bc6Jq9BVNJCD3tREhxYYRRRpDysf1UUPaCbaygKlmgF+kLijOp8tlKSGWhZzKbpsdmR2vFmWUr
	enY9GTEJMWV77k1Cxc8rPoSTJzxmQfseak7SWL22WV5KhiXCboa0EbzCyYbtEbNUzMlmi4qUkVEBg
	RdF6wdZ4u+hbG2FYD3vSElbG9D4B/OO0Co2PnfvkOWZsW92NwLnQ+fMjbz/CXv6zhIf792UJ7Li29
	NvAs0H2I6/mX7XI5MaDnqUAwASKBQqMPyGWThjHclt0iKJr0MAEg6JdX6vzIt0/qLYIQN6xdAr4sp
	utf2Tpi7kmNH267jBlNWQWsbA0Ehfg3alioMxf/8kl6LtZL+oRrmojrR+BTjkjDojrqO/Mf8qu+vy
	Ds+8ntyvLwOY+TnSgsqLFbVSZ6GnbN5fXQnH1Azm8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Pierre Barre <pierre@barre.sh>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, v9fs@lists.linux.dev,
 ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Use kvmalloc for message buffers
Date: Fri, 08 Aug 2025 13:12:08 +0200
Message-ID: <8602724.2ttRNpPraX@silver>
In-Reply-To: <aJPMwqqchOaZFSqn@codewreck.org>
References:
 <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <f08d5585-0a26-4c98-be1a-c0fd89ccd916@app.fastmail.com>
 <aJPMwqqchOaZFSqn@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, August 6, 2025 11:44:34 PM CEST Dominique Martinet wrote:
> 
> Pierre Barre wrote on Wed, Aug 06, 2025 at 05:50:42PM +0200:
> > If I submit a patch based on what has been discussed above, is it
> > likely to be accepted? Unfortunately, in my current setup, I am
> > encountering this issue quite frequently, and users of my servers are
> > having a hard time making sense of the error.
> 
> Yes, sorry it wasn't clear.
> 
> I still have no idea what's the "best" allocation method that we'll be
> able to use as either a vmalloc buffer or split into a scatterlist, but
> there's little point in worrying too much about it, so please go ahead.
> 
> If it's restricted to trans_fd and there's a chance we can make use of
> it with (at least) virtio later I think everyone will be happy :)

Yes, sounds like a viable plan.

Pierre, one more thing to note: kmem_cache_alloc() might still fail though. So
maybe it would make sense to add a separate patch that would check the result
of kmem_cache_alloc() and if it fails, falling back to your kvmalloc() call
(if enabled by the discussed transport mechanism of course).

/Christian


