Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F041E885A;
	Mon, 10 Nov 2025 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785161; cv=none; b=eCtZZ+wYKUM55kt+qESDmOKyMYGxAznZItutwPaA/cMug/5PrFuO+4MjA0fP/GLy/n3tzWdT/BonSGOlBGvkgA7luYMh7jxvsSo3w5EhY1FEWJavhz6M79Ahuwr4vp5FMLWT7+7E4YGNLwKdE2v9Wy0zLvftSZWBjESM3000wq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785161; c=relaxed/simple;
	bh=xWYWQZkqX3vZXhVv/npQp2hwjkNijYbT6+VFmFzuNSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyJ4oY25XXV1iV6Yh8U8+6V1otlc6GN1WAGXwd6kBT65bUMbrr5C2To45VSm9JcWQPjMNK+DBhXW+qjrUoBkh3d0+vFmDxriyGFQOFXJQL3ppbvC0u438giJUb/DEPCGCuBLqHNUWH69RCAmbVlJ/0JFdnsIZfit9Mypr/ngQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=jJz54ThO; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="jJz54ThO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=rPLSFIy9b6yqaAJ8GRX9t5GUuly6QBcZcQLWafIe5RM=; b=jJz54ThO0+6/2qdNHBFs234YyP
	DyCQbq2vhJWivO8StidkOd4J1OENCDTQdYqGGluO0PKM8T1ikkM4uRTcX0QeDsbenrGXn16IZ+ehb
	33VwCE37T4sznNWV7sKi/1A/oulSsiePvc6gZZzq3oXmW/ADQyetQBX/HL/coMVFTZqJsjAIA9BUE
	mw01yxzDv3f5kKdvibTLkSx6jijL27alnUL2hdfsPBfdIgoB43XQpaPL6ePd4QJEAYjRlm1KrtJ5L
	HQdv23VUM4jtdizjWgskb1QA90+iyUo7vvDY0wfl0Jall1JWorsOyKN9ScvkAToXb49NkonZ7o9cF
	S2Kpmi6P4t1aJJaM88vS6fk/+LVj/1+Al4h8EoFzIULr+CdQAG+P0PX5LpUuO27sk+oyBdH8NhETG
	Smp7zv1BXZzkd4JrtkUOBuOPli05W8IIaCFs/F+ktpMAe6WVVIqmZUhDiWyN9H4BfvOdEZj9dIFxt
	YHJGHfzHcLvY0HjTka5n2g2SHmllaKqi4PSdhNo6YKSYunTSEjKsyBCMrQqwpFW/RUEnqEbOl76cw
	35AlhppiBxOjilyb3k5gjle4mSV3C/niWLySjM6DAaEqQe6MQVdyEm8yvGt/CFUubzZfb9BAMqmkI
	lihUHXHiUeSMwz6JGH6ym4GJHZoFBz+WWPfaDHTh0=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, asmadeus@codewreck.org
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] net/9p: cleanup: change p9_trans_module->def to bool
Date: Mon, 10 Nov 2025 15:32:29 +0100
Message-ID: <62958427.AAQ67ucbvc@silver>
In-Reply-To: <20251103-v9fs_trans_def_bool-v1-1-f33dc7ed9e81@codewreck.org>
References: <20251103-v9fs_trans_def_bool-v1-1-f33dc7ed9e81@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 3, 2025 8:42:36 AM CET Dominique Martinet via B4 Relay wrote:
> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> '->def' is only ever used as a true/false flag
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

/Christian


