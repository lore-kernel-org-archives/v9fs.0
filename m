Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3E19993B;
	Tue, 22 Oct 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638034; cv=none; b=kPj/OWtVYrq8ULJoSvQpdPwS6d4YXhpzMPwe+0mPiQTbLk6R/ITSRE48wO5OmLP3QjdN6LmH5taKl3rleZCNO6DHUXZS8dIaR6UzWfSHEi+iUMALNbnu5WwO6gmjLyjCGJJIUC+FGH4gakAckND6gjS1RLg0HbzkbbSdOw7m2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638034; c=relaxed/simple;
	bh=JYYT6NWVKVJy521RVnpBOsTsaJ9xWTminJzbGkzYAz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvUZU2qYTKJPGHX2cvu9UEaJ2LkjOkfVkbor8IidTmbKz4pX6FlgjQvGvTAA6NG1XxeJo0FvKSNgiOloFawZtmKqp28Nm95+d2RGD11gAUkgjxZjOHTnUZlfIISIt8PvnPGn0vcWuFqAqnqenR6OvQA+YUSWN3/JfHhU8tPdFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=zP0hOuJ/; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="zP0hOuJ/"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D9E7C14C1E1;
	Wed, 23 Oct 2024 01:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729638024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+PhWiLsE/ON3mjmkRzMiGc9kBu8+BamSMdruYQygqY=;
	b=zP0hOuJ/+I+kvxnPXTKILVZTmq9uW8IIrcrjnp80IaKnWS5i0IhCUKrro+bqGxoZqsEcwj
	KBt499xq3KuVUaW78haSqWdXWgAs4BQ2Hz8QHw+MuPUGoxdkfSvGtZ5ItmtAfrVCbkdX84
	kjroIim/F30dRDmisbgE866fgYzQKxxY9A6oah6jXXAXXu2THwEaIDuoAGWcnHAJb/p5ba
	Vzo3niNheJlOyIxE5Mp90DGhMRSWbnqX/vkytJrOsYa7tGHoGMV+QHfigYuK6X6ySSEGCB
	otqfiC7i7PH76WHSgVW1jbaQA3aNwNPXM2GaOc2gpRbnFNLEwxQl10mWibMFtg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1226a4ff;
	Tue, 22 Oct 2024 23:00:19 +0000 (UTC)
Date: Wed, 23 Oct 2024 08:00:04 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Will Deacon <will@kernel.org>, ericvh@kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, lucho@ionkov.net,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com,
	keirf@google.com, regressions@lists.linux.dev
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
Message-ID: <ZxgudMCSgbDOEjpD@codewreck.org>
References: <20240923100508.GA32066@willie-the-truck>
 <20241009153448.GA12532@willie-the-truck>
 <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>
 <Zw-J0DdrCFLYpT5y@codewreck.org>
 <20241022150149.GA27397@willie-the-truck>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022150149.GA27397@willie-the-truck>

Will Deacon wrote on Tue, Oct 22, 2024 at 04:01:49PM +0100:
> > One note though he did sent a patch that seems related and wasn't sent
> > for merge:
> > https://lore.kernel.org/all/CAFkjPTn7JAbmKYASaeBNVpumOncPaReiPbc4Ph6ik3nNf8UTNg@mail.gmail.com/T/#u
> >
> > Will, perhaps you can try it? I'm pretty sure the setup to reproduce
> > this is easy enough that I'll be able to reproduce in less than an hour
> > (export two tmpfs [sequential inode number fs] wthin the same 9p mount
> > in qemu without 'multidevs=remap'), but I don't even have that time
> > right now.
> > 
> > (I didn't even read the patch properly and it might not help at all,
> > sorry in this case)
> 
> I think this patch landed upsteam as d05dcfdf5e16 (" fs/9p: mitigate
> inode collisions") and so I can confirm that it doesn't help with the
> issue.

Ugh, yes, sorry I'm blind it's there alright (you even listed it in your
first post in the list of commits to revert)

> > I'm not sure this really needs to get Linus involved - it's breaking a
> > server that used to work even if qemu has been printing a warning about
> > these duplicate qid.path for a while, and the server really is the
> > better place to remap these inodes as we have no idea of the underlying
> > device id as far as I know...
> 
> FWIW, I'm not using QEMU at all. This is with kvmtool which, for better
> or worse, prints no such diagnostic and used to be reliable enough with
> whatever magic the kernel had prior to v6.9.

Yes, that problem isn't specific to qemu, anything that re-exports
multiple filesystems using underlying inode numbers directly has this
risk (e.g. even diod/nfs-ganesha tcp mounts ought to reproduce if they
don't mangle inodes); I agree we need to handle servers throwing junk at
us.

It's easy enough to reproduce with qemu if remapping is disabled as
expected (I don't hit the VFS warning in d_splice_alias() but the
behaviour is definitely wrong):
----
# host side
cd /tmp/linux-test
mkdir m1 m2
mount -t tmpfs tmpfs m1
mount -t tmpfs tmpfs m2
mkdir m1/dir m2/dir
echo foo > m1/dir/foo
echo bar > m2/dir/bar

# guest side
# started with -virtfs local,path=/tmp/linux-test,mount_tag=tmp,security_model=mapped-file
mount -t 9p -o trans=virtio,debug=1 tmp /mnt/t

ls /mnt/t/m1/dir
# foo
ls /mnt/t/m2/dir
# bar (works ok if directry isn't open)

# cd to keep first dir's inode alive
cd /mnt/t/m1/dir
ls /mnt/t/m2/dir
# foo (should be bar)
----

This can also be observed with files if mounting with cache=fscache or
similar (but interestingly even keeping the file open will properly
disociate both files in default cache=none mode); either way we won't be
able to properly work with hard links if we assume the server isn't
reliable; I guess that if someone wants that we'd really need to
implement some capability negotiation at mount time so the server can
tell us what is supported and unless that is done assume the server
cannot reliably assign inodes...

And if we go that way then we just shouldn't ever look at the inode
number?... Which seems to pretty much be what the old code was doing in
the "new" path of v9fs_qid_iget(); the compare function would just
always say the inodes are different and get a new one...
The mitigation Eric implemented is similar enough (re-added a 'new'
parameter, and fail if I_NEW isn't set when new was requested), but it
looks like v9fs_fid_iget_dotl() isn't called at all when accessing the
other overlapping directory, so that wasn't effective here as some
higher level of caching caught the inode first.


I've also confirmed reverting the 4 commits listed by Will do fix both
behaviors (along with a fscache warning when hitting the duplicate inode
file, but that's expected):
        724a08450f74 "fs/9p: simplify iget to remove unnecessary paths"
        11763a8598f8 "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
        10211b4a23cf "fs/9p: remove redundant pointer v9ses"
        d05dcfdf5e16 " fs/9p: mitigate inode collisions"


> I'm happy to test patches if there's anything available, but otherwise
> the reverts at least get us back to the old behaviour if nobody has time
> to come up with something better.

I think that's the sane thing to do, let's first go back to something
that works and we can try again if/when someone has time - I've
certainly just spent more time here than I have, and starting over is just
a matter of reapplying the patches in a local branch so it's not like
there's anything to lose (afaiu this was intended as code cleanup to
make the code more maintainable rather than fixing something specific)



Thorsten, is there a preferred way reverts should be done?
In this case it'd probably make sense to squash the 4 reverts in a
single megarevert? At the very least getting anywhere in the middle with
the uaf isn't something one would want... And they all made it in 6.9
together so there's no benefit in splitting them for backport either.

Once that's decided I'll prepare something to send Linus in a few days,
I don't think there's much point in sitting on this either...


Thanks,
-- 
Dominique Martinet | Asmadeus
