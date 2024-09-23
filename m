Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DC39AE3;
	Mon, 23 Sep 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085915; cv=none; b=kUlhpSj/j3yBRfLaRP66dkFdyW9GvtI3+ZQNiaqa+j676V8vpuXtQrek0+V2we21IrBIvCcoNA4Zl7Smazkk/mD4u8kFwzEuveFIk0Z/yEMRz19XMztXAqNTB9SY9UQ0Xc7w1ADzvg7QyuHlAtqvw9Yi4GLFw1XE3BshJQK/s00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085915; c=relaxed/simple;
	bh=sfHsfjwf54qbv4SUznUDWk3U25+whbeyuat/1WGP9IU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Aq96d3JJu9odCtUXJrYbp05SAnw3fejhqHsb+agzNLfS8hxFbC3G0aHdxk+grCCkM9EaV0vS92Ac90FYQfmZgCs763GtXNKQO/0FagBmY54qK0ejGCy6GWj9R1dh57MjzYkcqoRV7sGNsNd8x7Ny1QJ5/6c7WYuOzbOsgG0T0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvCNtseT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvCNtseT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD210C4CEC4;
	Mon, 23 Sep 2024 10:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727085915;
	bh=sfHsfjwf54qbv4SUznUDWk3U25+whbeyuat/1WGP9IU=;
	h=Date:From:To:Cc:Subject:From;
	b=EvCNtseTLWpe6Lh9BZPq7Myk+8ChfjfkiiZ5sqjAb/Loa/mSP0abAOm0Q6hVtBlb+
	 7GTn0yUGld8fUp+42dMSWN42y3wAyuw65E5pBxdrpuBempm5hpLToB/v2nGoPzLR1G
	 ovrmX5QKvBTADnBGGIe2fHk+ZsCoz4Fm4DKi8zYM9t4qgjS5XwqVIoZ9RQetVxOVqq
	 he2WbV8oXTpE0xEduaWHGvwkhg1j7MmXeDuNyfGV3aj0CzIvKtgywIhxmOV2tZqkQ0
	 HnrmVO6WFZUNdmR3YoMorkAzkfln/ha0B6tyrbfpaL0mIlwPqPsmZ1se5UyyL/jtam
	 doEiPVbZPlOZQ==
Date: Mon, 23 Sep 2024 11:05:10 +0100
From: Will Deacon <will@kernel.org>
To: ericvh@kernel.org
Cc: lucho@ionkov.net, asmadeus@codewreck.org, oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com,
	keirf@google.com
Subject: VFS regression with 9pfs ("Lookup would have caused loop")
Message-ID: <20240923100508.GA32066@willie-the-truck>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Eric,

I'm trying to use kvmtool to run a simple guest under an Android host
but, for v6.9+ guest kernels, 'init' reliably fails to run from a 9pfs
mount because VFS emits this error:

  | VFS: Lookup of 'com.android.runtime' in 9p 9p would have caused loop

The host directory being shared is a little odd, as it has symlinks out
to other mount points. In the guest, /apex is a symlink to /host/apex.
On the host, /apex/com.android.runtime is a mounted loopback device:

/dev/block/loop13 on /apex/com.android.runtime type ext4 (ro,dirsync,seclabel,nodev,noatime)

This used to work prior to 724a08450f74 ("fs/9p: simplify iget to remove
unnecessary paths") and it looks like Oleg ran into something similar
before:

  https://lore.kernel.org/all/20240408141436.GA17022@redhat.com/

although he worked around it by driving QEMU with different options.

I can confirm that reverting the following commits gets mainline guests
working again for me:

	724a08450f74 "fs/9p: simplify iget to remove unnecessary paths"
	11763a8598f8 "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
	10211b4a23cf "fs/9p: remove redundant pointer v9ses"
	d05dcfdf5e16 " fs/9p: mitigate inode collisions"

Do you have any better ideas? I'm happy to test anything you might have,
since this is 100% reproducible on my setup.

Cheers,

Will
