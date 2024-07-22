Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2151B969;
	Mon, 22 Jul 2024 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637523; cv=none; b=Osp73oOZcQY0MjOCtX/hyNwWihUeO6uIi/39XVIJy3+rx1GIt56mwoPyXlUV++ESWZlxYLTWVOyuesxkYOdiTEuuK9nXNZm3ee/jjRhkHfBO99GNem16gzo2xrbvZdlUM2kgoPL8zamZqAt5tgkZmTEGCXCCA6yMAN4CCCiGZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637523; c=relaxed/simple;
	bh=uwJwktSn671leInxY7NeuFEZVaSQrbXVX6gObNF6aSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfYv6A9wqfmvDLuTYcFQJlZPdMpGCiO6h8N94dwCJycLrwxmS5PRBUyxvzWkWlUTIu8sWuasN8C1Es5LmU73ZVCH5Z3f1K7hkCHX/wdJN3Oab8gaOGKuxE+5pNhNVB0C7kEXuJsWtYii8H1KXlmbfwf1CDmPF5nIjaWIbhEvL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: David Vernet <void@manifault.com>, asmadeus@codewreck.org
Cc: linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 v9fs@lists.linux.dev, kernel-team@meta.com
Subject:
 Re: [PATCH] net/9p: Fix uaf / refcnt underflow for req object in virtio
Date: Mon, 22 Jul 2024 10:03:11 +0200
Message-ID: <2328041.KKODgcftPW@silver>
In-Reply-To: <Zp4DSeHdOU0U1PZC@codewreck.org>
References:
 <20240709162904.226952-1-void@manifault.com> <Zp4DSeHdOU0U1PZC@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, July 22, 2024 8:59:21 AM CEST asmadeus@codewreck.org wrote:
[...]
> If the request really was cancelled we'll get the flush reply before the
> response and that'll drop the second ref in the cancelled callback,
> which would also blow up, but afaik qemu doesn't implement this so this
> code path so this was never tested.

It is implemented in QEMU 9p server according to the 9p protocol specs:
http://ericvh.github.io/9p-rfc/rfc9p2000.html#anchor28

So a Tflush request by client is immediately answered by a Rflush response and 
in this case no answer is sent to the original request being flushed.

There are also QEMU test cases guarding the expected Tflush behaviour:
https://github.com/qemu/qemu/blob/a7ddb48b/tests/qtest/virtio-9p-test.c#L403
and
https://github.com/qemu/qemu/blob/a7ddb48b/tests/qtest/virtio-9p-test.c#L444

The 2nd test case handles the behaviour when the Tflush request arrived too 
late, after the original request already completed successfully that is. So in 
this case client first receives a success response to the original request, 
then followed by Rflush response.

/Christian


