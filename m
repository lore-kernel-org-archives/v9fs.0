Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DEB24E4B4
	for <v9fs@lists.linux.dev>; Mon, 15 Jun 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531120; cv=none; b=GhKZd5utUa9KIXaIPvJGriNQ25/3yONwg+EMicm6sZfnrieyxhXy1gxGcoagqBE1IGpG6K+eoXFi/3J8VllIRwK3AcUidVQm74i94aVTjMZXb9aQESulo2ujSFnfpJm1tpnPPXCTSBG5kgCOmTK2pWpPv8mVBYscbx/Jvvl5zeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531120; c=relaxed/simple;
	bh=vrYOAAg4u0P4XHB8NOhF0JGzheIdmPHfS45M+tKWvRc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YUT7UJGLCSnFHgckTkNUYLGbPosn8mKsxoKJCv3pfNlly8JL12ge4SgA01Q5KIxsPEAgM6ME0C/VsN3IV1xVXzN9FgTtmjalTGhV47cGdMZRxnMuT0iSmnY6uJ8fTOR0srE7ibdEZ2quorI4wAG0OoLapzdIKIqmRu6N/0vxrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=NBeqcNV3; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="NBeqcNV3"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D5FD414C2D6
	for <v9fs@lists.linux.dev>; Mon, 15 Jun 2026 15:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1781531117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=k0nFDGIqVDSHajASSrnx/lB8xFBnegP7KqiFH9KKHUo=;
	b=NBeqcNV37UrhnQXwDBO1Kex+3QVhlAqhcVgZRGrLJhy0DN79946qwckCHBIDGpIgeOii/4
	B3G4IL2WBu4GJA8EgcciJX99ImEJ379gMj78ItsjGxigAX9Mxf0yo6Mgaz2SfSIECxNU8u
	t8lQ3WVfDUm0CaSCv7em+mfB6Kea8NluDY2V+HSICJHvmL+4mltqkG174gWdOm78kpkeNI
	yD+8HQJxJKsiKtef+WAcJQSVkkqDR9GwCFMsffIeOK3eaYaA78S/00Jh2Wy/C33VO2wUu+
	ko4o4GGsNRfLbXR+VsR4mw2qzMhfWfwNjDD5YiG8cTjcUjCFMh8DAyzsfR6OAg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a81f99e8
	for <v9fs@lists.linux.dev>;
	Mon, 15 Jun 2026 13:45:15 +0000 (UTC)
Date: Mon, 15 Jun 2026 22:45:00 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: v9fs@lists.linux.dev
Subject: 9p patches for 7.2 (recap/heads up)
Message-ID: <ajAB3PMI_8O28a4m@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Like last time I'm still under water, so tracking a bit what I've picked
up and not...

No time to review usbg or xen things that aren't trivial (some usbg in
here can likely be considered trivial but I'm not comfortable without
someone who can test it, I've seen someone use dummy_udc to test in a
recent review "poc" and I'd like to make time to try with that
eventually but I didn't have time yet)

xen - both look sane enough to me at first glance but someone
testing/another pair of eyes would be appreciated
- 20260609155202.1706-1-zhaoyz24@mails.tsinghua.edu.cn 9p/xen: drain
response work after unbinding IRQ
- 20260529103416.81378-1-zhaoyz24@mails.tsinghua.edu.cn 9p/xen: fix
use-after-free in p9_xen_request


usbg
- 20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn net/9p/usbg: Fix
use-after-free on usb9pfs_clear_tx
didn't take time to wrap my head around this one...
- 20260529081817.77898-1-zhaoyz24@mails.tsinghua.edu.cn net/9p/usbg: Fix
use-after-free in usb9pfs_free_func
can't hurt?
- 20260607121907.12588-1-zhaoyz24@mails.tsinghua.edu.cn net/9p/usbg: fix
prefix matching in device lookup
likely ok? couldn't find "the configfs tag lookup path" the commit
message talks about in 5 mins and gave up...
- 20260607130118.16579-1-zhaoyz24@mails.tsinghua.edu.cn net/9p/usbg: Fix
use-after-free in disable_usb9pfs()
had fallout and


others: 
- vsock transport 20260527073447.86538-1-skvarlamatus@gmail.com had
comments to address and no v2

- 20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn 9p/trans_virtio:
bound RERROR copy by mapped pages
might be correct, but I need more brain cells to consider it right now

- 20260610114206.3749904-1-michael.bommarito@gmail.com 9p/trans_virtio:
bound mount_tag show copy to one page
I agree with Christian, better to reject any such mount so we don't have
to worry about it in tag_show()


The rest I *think* I picked up and hopefully didn't miss much, here's my
short log before testing:
* 5bf46ec0f86b (HEAD) 9p: Add missing read barrier in virtio zero-copy path
* a472a0f7cceb net/9p: Replace strlen() strcpy() pair with strscpy()
* f2ae8be77c17 9p: skip nlink update in cacheless mode to fix WARN_ON
* 3cb6b464435f net/9p: fix race condition on rdma->state in trans_rdma.c
* b2b130e101dd 9p: v9fs_file_do_lock: replace WARN_ONCE with p9_debug
* 3ec9e935015b (martinetd/HEAD, martinetd/9p-next) 9p: Enable symlink caching in page cache
* 64a0eb2b2224 9p: Set default negative dentry retention time for cache=loose
* 7025a34eda23 9p: Add mount option for negative dentry cache retention
* e7b0c932b719 9p: Cache negative dentries for lookup performance
* 6077a40933a9 9p: avoid returning ERR_PTR(0) from mkdir operations
* aeb815e3abe8 9p: avoid putting oldfid in p9_client_walk() error path
* 6335c463f916 iov_iter: iov_folioq_get_pages: don't leave empty slot behind
* 6b4f48728faa net/9p: fix infinite loop in p9_client_rpc on fatal signal
* 38ba49580e87 docs/filesystems/9p: fix broken external links
* e661e17ddbed 9p: invalidate readdir buffer on seek
* b4d71bea1445 9p: use kvzalloc for readdir buffer
* 9061075b4f0a net/9p/usbg: Constify struct configfs_item_operations

the top commits didn't get any test yet, I'll try to find time to test a
bit tomorrow before pushing to next, and will send to Linus next Monday


If I missed something you care about please reply on patch I missed or
here


That's more patches than we've had in a while and I'm not quite keeping
up...
-- 
Dominique Martinet | Asmadeus
