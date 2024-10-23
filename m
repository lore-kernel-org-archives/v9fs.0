Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1562171;
	Wed, 23 Oct 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696446; cv=none; b=fQ9ms1FHyib9/xIpgVvdbvJxme7Og6vRszIXUeDNdE4xoRs5iBz5Xqk7pdWJsQoBXGCSB89ttAm8hSgtgXKq1PAMjIN5jpFafR/pYHX1YUtwqQLkmLFBngj6SBultm/ZZNMhlMiXDUbJq5YzWGxUaTL0/SRU43OTTFfE/ExnLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696446; c=relaxed/simple;
	bh=taE8zoZsuDjUP07UaX3+OcRzpCvHXDeBn3RxXkE2UpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjfcwLdJXyA8gly9Z0CKuaJug299zCMguMIsMuj62ZrrAi51mYQD67t1sGcgCt6jrPktpAxLnBOO50dZL+5e2RC4aMVhiiejz322FPpSofjtLkCtkKKoVL4cNamx6agwYqB1gWMZGeR0wb0s5WAu3cGgBntaXGpc4tZLnTHdErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfJCbfBL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfJCbfBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795A0C4CEC6;
	Wed, 23 Oct 2024 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729696445;
	bh=taE8zoZsuDjUP07UaX3+OcRzpCvHXDeBn3RxXkE2UpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfJCbfBLL0yBJA2GLMFVvqDg7PBoIIJ3qhwikNb1aWwaszYTVxOW3Kr2JqNy5F4Ml
	 mCpsu6x0GCH3cmcGvzWTU5TGr3GpCHCa7dTXN4aZMTqka0RRVbl5JdSRZxXNMjCJsj
	 NCbt23CYWiHWWwo1qcFQaYJfAynI4vd1THLHROkbC/jaDzxyxHrWI2LpmrPMF4G99L
	 QEnog9LT22+Kuefr6hudLAjio29XTM9Detyqdoit0VltL/ec/PR2FAvrYPMuvAZ8vg
	 PyRiCOpWv/XYMcGlaGoPFe2Y+X7/c2xV9AdQ5/WZaB0C+2NkTtLIUHZnyZli+jPquX
	 3QmxDULChjgrA==
Date: Wed, 23 Oct 2024 16:14:00 +0100
From: Will Deacon <will@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>,
	lucho@ionkov.net, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com,
	keirf@google.com, regressions@lists.linux.dev
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
Message-ID: <20241023151358.GB28800@willie-the-truck>
References: <20240923100508.GA32066@willie-the-truck>
 <20241009153448.GA12532@willie-the-truck>
 <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>
 <Zw-J0DdrCFLYpT5y@codewreck.org>
 <20241022150149.GA27397@willie-the-truck>
 <ZxgudMCSgbDOEjpD@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxgudMCSgbDOEjpD@codewreck.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 23, 2024 at 08:00:04AM +0900, Dominique Martinet wrote:
> Will Deacon wrote on Tue, Oct 22, 2024 at 04:01:49PM +0100:
> > > One note though he did sent a patch that seems related and wasn't sent
> > > for merge:
> > > https://lore.kernel.org/all/CAFkjPTn7JAbmKYASaeBNVpumOncPaReiPbc4Ph6ik3nNf8UTNg@mail.gmail.com/T/#u
> > >
> > > Will, perhaps you can try it? I'm pretty sure the setup to reproduce
> > > this is easy enough that I'll be able to reproduce in less than an hour
> > > (export two tmpfs [sequential inode number fs] wthin the same 9p mount
> > > in qemu without 'multidevs=remap'), but I don't even have that time
> > > right now.
> > > 
> > > (I didn't even read the patch properly and it might not help at all,
> > > sorry in this case)
> > 
> > I think this patch landed upsteam as d05dcfdf5e16 (" fs/9p: mitigate
> > inode collisions") and so I can confirm that it doesn't help with the
> > issue.
> 
> Ugh, yes, sorry I'm blind it's there alright (you even listed it in your
> first post in the list of commits to revert)

Heh, no worries. It has a funny leading space at the start which is
weirdly jarring when you read it!

> > > I'm not sure this really needs to get Linus involved - it's breaking a
> > > server that used to work even if qemu has been printing a warning about
> > > these duplicate qid.path for a while, and the server really is the
> > > better place to remap these inodes as we have no idea of the underlying
> > > device id as far as I know...
> > 
> > FWIW, I'm not using QEMU at all. This is with kvmtool which, for better
> > or worse, prints no such diagnostic and used to be reliable enough with
> > whatever magic the kernel had prior to v6.9.
> 
> Yes, that problem isn't specific to qemu, anything that re-exports
> multiple filesystems using underlying inode numbers directly has this
> risk (e.g. even diod/nfs-ganesha tcp mounts ought to reproduce if they
> don't mangle inodes); I agree we need to handle servers throwing junk at
> us.
> 
> It's easy enough to reproduce with qemu if remapping is disabled as
> expected (I don't hit the VFS warning in d_splice_alias() but the
> behaviour is definitely wrong):
> ----
> # host side
> cd /tmp/linux-test
> mkdir m1 m2
> mount -t tmpfs tmpfs m1
> mount -t tmpfs tmpfs m2
> mkdir m1/dir m2/dir
> echo foo > m1/dir/foo
> echo bar > m2/dir/bar
> 
> # guest side
> # started with -virtfs local,path=/tmp/linux-test,mount_tag=tmp,security_model=mapped-file
> mount -t 9p -o trans=virtio,debug=1 tmp /mnt/t
> 
> ls /mnt/t/m1/dir
> # foo
> ls /mnt/t/m2/dir
> # bar (works ok if directry isn't open)
> 
> # cd to keep first dir's inode alive
> cd /mnt/t/m1/dir
> ls /mnt/t/m2/dir
> # foo (should be bar)
> ----
> 
> This can also be observed with files if mounting with cache=fscache or
> similar (but interestingly even keeping the file open will properly
> disociate both files in default cache=none mode); either way we won't be
> able to properly work with hard links if we assume the server isn't
> reliable; I guess that if someone wants that we'd really need to
> implement some capability negotiation at mount time so the server can
> tell us what is supported and unless that is done assume the server
> cannot reliably assign inodes...
> 
> And if we go that way then we just shouldn't ever look at the inode
> number?... Which seems to pretty much be what the old code was doing in
> the "new" path of v9fs_qid_iget(); the compare function would just
> always say the inodes are different and get a new one...
> The mitigation Eric implemented is similar enough (re-added a 'new'
> parameter, and fail if I_NEW isn't set when new was requested), but it
> looks like v9fs_fid_iget_dotl() isn't called at all when accessing the
> other overlapping directory, so that wasn't effective here as some
> higher level of caching caught the inode first.

Nice, thanks for digging into this. I'm now pretty grateful I ran into
the vfs error rather than whacky filesystem behaviours.

> I've also confirmed reverting the 4 commits listed by Will do fix both
> behaviors (along with a fscache warning when hitting the duplicate inode
> file, but that's expected):
>         724a08450f74 "fs/9p: simplify iget to remove unnecessary paths"
>         11763a8598f8 "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
>         10211b4a23cf "fs/9p: remove redundant pointer v9ses"
>         d05dcfdf5e16 " fs/9p: mitigate inode collisions"
> 
> 
> > I'm happy to test patches if there's anything available, but otherwise
> > the reverts at least get us back to the old behaviour if nobody has time
> > to come up with something better.
> 
> I think that's the sane thing to do, let's first go back to something
> that works and we can try again if/when someone has time - I've
> certainly just spent more time here than I have, and starting over is just
> a matter of reapplying the patches in a local branch so it's not like
> there's anything to lose (afaiu this was intended as code cleanup to
> make the code more maintainable rather than fixing something specific)

Agreed, and I'm happy to test any subsequent patches now that I've got
my Android environment up and running again.

> Thorsten, is there a preferred way reverts should be done?
> In this case it'd probably make sense to squash the 4 reverts in a
> single megarevert? At the very least getting anywhere in the middle with
> the uaf isn't something one would want... And they all made it in 6.9
> together so there's no benefit in splitting them for backport either.
> 
> Once that's decided I'll prepare something to send Linus in a few days,
> I don't think there's much point in sitting on this either...

I'll leave it up to you, but I'd personally do four separate reverts
because it makes the whole process entirely mechanical. I can't recall
seeing a megarevert before.

Will
