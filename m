Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C01A4F0C;
	Wed,  9 Oct 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488093; cv=none; b=eTqlEAj5FF4bgAHF7GfmYP9eN8lUWUeYog8uMXCGM8DR2Hm8TR1uP0OMnqasZgNiWTAvivpxi+PS6hWPVHdtoif7H7TIox9MCRy0csQ6tC8Rndf5EbE3YysCu3qYEPg/rQ7zmoKyieNQ79/8WNYWx8Q3VB/E8CDXkaxKiX2TBKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488093; c=relaxed/simple;
	bh=3RZzGcqZdE7ZKJybnV1LA3aUWw22/CmY0V4YrNl1LCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoa5xKxU90GChdtcXhlfvU35PDQOOr+bFVN0qj2M7xET3aSBxOGiQ9CVgwy9vfJVrV+A1t2tFfgapYihUopsLhdr+ACF9cTU3CQ7XmOUVR58aTcD5+4n4ZvXDbq10ql0cn+vulNYJSngdbyzFJvhyvpCLwmKVkNWW70X84FbWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZCgrjAb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZCgrjAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FDBC4CECD;
	Wed,  9 Oct 2024 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728488093;
	bh=3RZzGcqZdE7ZKJybnV1LA3aUWw22/CmY0V4YrNl1LCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZCgrjAbgo/Z7heWyrDGKIkrYQ8B4nCcutvZBc+1bev5ZbpzzagruM5BWOZZtN3xZ
	 WYKlu7UTQci4wJ5tysbIU83ubJDZdnKuAwkVDOWvAVeNfokgDDh989kUbjsVZzXSKC
	 BnTo8d9ANYPxAUzUQ5lnYeT8rFIm9AmhNcY47UT2tfbAolt1zZ56scfqCIX8Rq/B7D
	 PgSrgLXeHJ8ErSZjIkCqM9Y0Cw6c9XVhC/DjgK8dsbAyJS6n5fZ2vSnAghxkhYAASO
	 Q/u9M5oIZZIEO3KyM9OIkwOKyHL0dPjPtsGZmZR1qpWeXtLj/ZxtVLmad1vw8nOUIi
	 4tvk+c7BNIBTQ==
Date: Wed, 9 Oct 2024 16:34:48 +0100
From: Will Deacon <will@kernel.org>
To: ericvh@kernel.org
Cc: lucho@ionkov.net, asmadeus@codewreck.org, oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com,
	keirf@google.com, regressions@lists.linux.dev
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
Message-ID: <20241009153448.GA12532@willie-the-truck>
References: <20240923100508.GA32066@willie-the-truck>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923100508.GA32066@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Sep 23, 2024 at 11:05:08AM +0100, Will Deacon wrote:
> Hi Eric,
> 
> I'm trying to use kvmtool to run a simple guest under an Android host
> but, for v6.9+ guest kernels, 'init' reliably fails to run from a 9pfs
> mount because VFS emits this error:
> 
>   | VFS: Lookup of 'com.android.runtime' in 9p 9p would have caused loop
> 
> The host directory being shared is a little odd, as it has symlinks out
> to other mount points. In the guest, /apex is a symlink to /host/apex.
> On the host, /apex/com.android.runtime is a mounted loopback device:
> 
> /dev/block/loop13 on /apex/com.android.runtime type ext4 (ro,dirsync,seclabel,nodev,noatime)
> 
> This used to work prior to 724a08450f74 ("fs/9p: simplify iget to remove
> unnecessary paths") and it looks like Oleg ran into something similar
> before:
> 
>   https://lore.kernel.org/all/20240408141436.GA17022@redhat.com/
> 
> although he worked around it by driving QEMU with different options.
> 
> I can confirm that reverting the following commits gets mainline guests
> working again for me:
> 
> 	724a08450f74 "fs/9p: simplify iget to remove unnecessary paths"
> 	11763a8598f8 "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
> 	10211b4a23cf "fs/9p: remove redundant pointer v9ses"
> 	d05dcfdf5e16 " fs/9p: mitigate inode collisions"
> 
> Do you have any better ideas? I'm happy to test anything you might have,
> since this is 100% reproducible on my setup.

Adding the regression tracker as I've not heard anything back on this :(

#regzbot introduced: 724a08450f74

Will
