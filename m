Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78315D5CA;
	Fri, 25 Oct 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869952; cv=none; b=OOa7FrjLUeJQ8h1r+Rt7Rhv3aGaFxMqvtBhIz+9pbuCcOhB5K6YISVLlXPiN826Z/wmSKsojzuPnfRDuSSFJSy7LYCPXIAg0+1s+eQ7SkWATJv4FQXYBIbg9OIJQ0CjGkihHvSaFj3ojx/c6FcQb09fbvk9iAwEXDrQ9RsO2nO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869952; c=relaxed/simple;
	bh=MiwcC2uykYAEEHt7MzLsCsQ78r/dJlY3KdNH0P1orNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVPBQolvZq/+nuzBbsJP9/FVO1v6bXidYfz0r+sjx0uXDwVAKUssTdtae5CAQlAXtU8S6vuBbHaxmogbSCYf/C4cMLDQS5pp0BSsr4o6SnjpqIKwaps349m2POlD/XiLjsg4bbkaXUQm9qmCoEv6FiAYeEbll+xe6vRqf68hXw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftZ2d9jD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftZ2d9jD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B41C4CEC3;
	Fri, 25 Oct 2024 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729869952;
	bh=MiwcC2uykYAEEHt7MzLsCsQ78r/dJlY3KdNH0P1orNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftZ2d9jDn8xkP7JxhAdi21rljLTyp35KM5NYjLMq4WWCCDiHfXpLYgaK7D7bZ4BEK
	 rv2KVe1cQq3ZjK10ceQd8F2x28IHEfyDESIsnstzJCrZt9YgeQXgK5UQvIa2EdWWPt
	 ABHI9CBHKUeDPdfOabA1SP5c5i68maQoEsBfpVUMoywjtVXvM3UXgAVm6r78cRqYTB
	 cmiwG0kEZojWY8sqyGbJXU9BDCtzgaaOd9Q0vsPLQtbvSbTr6BhTTEsH8UDE7eWwJG
	 t/K2yc34Y/HdBhT3Dsol6but6K0rsX9JAtwoCBswKz/A/81tbdxQ3ijGKePD4ufxPR
	 LdhAuTuf81NZw==
Date: Fri, 25 Oct 2024 17:25:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Will Deacon <will@kernel.org>, ericvh@kernel.org, lucho@ionkov.net, 
	asmadeus@codewreck.org, Alexander Viro <viro@zeniv.linux.org.uk>, oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com, keirf@google.com, 
	regressions@lists.linux.dev
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
Message-ID: <20241025-ungewiss-zersplittern-c124bc48be5c@brauner>
References: <20240923100508.GA32066@willie-the-truck>
 <20241009153448.GA12532@willie-the-truck>
 <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>

On Tue, Oct 15, 2024 at 08:07:10PM +0200, Thorsten Leemhuis wrote:
> Hi Will! Top-posting for once, to make this easily accessible to everyone.
> 
> Thx for bringing this to my attention. I had hoped that Eric might reply
> and waited a bit, but that did not happen. I kind of expected that, as
> he seems to be  somewhat afk, as the last mail from him on lore is from
> mid-September; and in the weeks before that he did not post much either.
> Hmmm. :-/
> 
> CCed Christian and Al, maybe they might be able to help directly or
> indirectly somehow. If not, we likely need to get Linus involved to
> decide if we want to at least temporarily revert the changes you mentioned.

Sorry, I'm just getting to this thread now as I'm still out with a
fscking case of the flu.
/me reads...

> 
> Ciao, Thorsten
> 
> On 09.10.24 17:34, Will Deacon wrote:
> > On Mon, Sep 23, 2024 at 11:05:08AM +0100, Will Deacon wrote:
> >>
> >> I'm trying to use kvmtool to run a simple guest under an Android host
> >> but, for v6.9+ guest kernels, 'init' reliably fails to run from a 9pfs
> >> mount because VFS emits this error:
> >>
> >>   | VFS: Lookup of 'com.android.runtime' in 9p 9p would have caused loop
> >>
> >> The host directory being shared is a little odd, as it has symlinks out
> >> to other mount points. In the guest, /apex is a symlink to /host/apex.
> >> On the host, /apex/com.android.runtime is a mounted loopback device:
> >>
> >> /dev/block/loop13 on /apex/com.android.runtime type ext4 (ro,dirsync,seclabel,nodev,noatime)
> >>
> >> This used to work prior to 724a08450f74 ("fs/9p: simplify iget to remove
> >> unnecessary paths") and it looks like Oleg ran into something similar
> >> before:
> >>
> >>   https://lore.kernel.org/all/20240408141436.GA17022@redhat.com/
> >>
> >> although he worked around it by driving QEMU with different options.
> >>
> >> I can confirm that reverting the following commits gets mainline guests
> >> working again for me:
> >>
> >> 	724a08450f74 "fs/9p: simplify iget to remove unnecessary paths"
> >> 	11763a8598f8 "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
> >> 	10211b4a23cf "fs/9p: remove redundant pointer v9ses"
> >> 	d05dcfdf5e16 " fs/9p: mitigate inode collisions"
> >>
> >> Do you have any better ideas? I'm happy to test anything you might have,
> >> since this is 100% reproducible on my setup.
> > 
> > Adding the regression tracker as I've not heard anything back on this :(
> > #regzbot introduced: 724a08450f74
