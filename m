Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D29B4E1AD
	for <v9fs@lists.linux.dev>; Tue,  9 Apr 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628493; cv=none; b=d4MPFcUuRmQcG+CyIlNNxsms5aUbnh0X3DW+HWMCDsEuqyZDf7fzYn+KxAPEki1JF+BduZZ6T9KlO9r3WVYrJEHPsBTcY4D3qp6/43NSNO+CNMW8u54wcOk1rZk8iK8CaElN2pG/JCmYaj5FK4LMlyMnUTzbJzzhD0+F//bAaNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628493; c=relaxed/simple;
	bh=caiEz1Y2F2lw0Zx7EwPfM3qqvv6m2/zBh3nMy/ppEew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMTZGgPwuCcKWKZc2WK9UUBFFwKmGQX2Gq3op7XLrmby/aj87F66TOm/K04cFCX/oGq3d9PhoDzY5bpWoB2U8GRNIw3moJDwfjWvuDt+FoyhJuZomjjnAdto1RvxO4W5BoAmh0yd7HA/qijWJ6xwi+Hm9oB9vPanIpLvGPn+Qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=FdiMS4CZ; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=YOjen1AF; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="FdiMS4CZ";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="YOjen1AF"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 61C19C009; Tue,  9 Apr 2024 04:08:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712628487; bh=X/zwXjtoZ9oN8IrmEqIPdBj8K5Kr/wSKtv5+pVhHVxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdiMS4CZSUVvkA/Ju5YS1zHgJCgpoBdSvA7SmKMN3EtT1GHtqnnWb/w8j9+y0D97+
	 NeAA5j756Q/Kp4Wvp4YUPW8jbIOVo/oFT5mN0uUWjVLXb2Qs+0djCaf2n8QOsRF+DB
	 s1CcnIuW6AoXhj6CDn+w1rNRYx/BF0ReXVp4tI7dqG+LyyVWcEpDJBXbKc+Nn1Ykux
	 yLrH0BjMsY0Kq19TeJbHVWwbfmyQ/6rcQR9a/dY4+Cl+4dMVc7x36cWqr0B7BEQhhD
	 0Zg6mvISgXUu7Yx1MGTyUBrtSep0m0qX9MS+he9tPy3X22thMHxptxbcmEzOM0lLyi
	 09v+JSUMhCz5A==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 1FC60C009;
	Tue,  9 Apr 2024 04:08:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712628486; bh=X/zwXjtoZ9oN8IrmEqIPdBj8K5Kr/wSKtv5+pVhHVxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOjen1AF64GKcb2GDJuvCxtOWxJRtAJBFM4npt6wpANRAw4r89VO3uqU2BaLbKLco
	 ZTort/6gGF+vSfB7RNB7t2SCTsvnPY2STeTdzYrRCCjCMzbFcoeCBkxtF4gydPOBQq
	 Tv24LrJ7AQPQlkQ6I5WdPTUAL5C5nUjbfSCnvJayPHHMtCI+HsjsVfdXT3NPaY6f32
	 XTKqR0DYtU0BhQdArzBqDTVYhywa/MSYB87pjIhhPCSNauYbsUCokN8qK5hfzW0NV1
	 EkqX0+B3lerakdXoOXKp00GPcwssR/8AORSKubTBFpDe32nwC4TJxWCn3tLdo13DtR
	 Du6565eCnRoqA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 71763975;
	Tue, 9 Apr 2024 02:08:00 +0000 (UTC)
Date: Tue, 9 Apr 2024 11:07:45 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>
Cc: v9fs@lists.linux.dev
Subject: Re: recap of 9p problems in 6.9
Message-ID: <ZhSi8cq-uFpXdTwE@codewreck.org>
References: <ZhNvwwYRN4-EczYi@codewreck.org>
 <7b4724a5be3a5a5f4ab550741741ecf3479f7139@linux.dev>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b4724a5be3a5a5f4ab550741741ecf3479f7139@linux.dev>

Replying to both mails at once

Eric Van Hensbergen wrote on Mon, Apr 08, 2024 at 11:14:07PM +0000:
> Thanks for looking into these Dominique - I've got the reports queued
> up and am just looking to ring fence some time to dig into them before
> I commit to a revert.  The change in handling of inode matching and
> keeping inodes around in the cache longer are likely the root of all
> of these, but the old code had so much unexplained corner cases I
> really want to understand the problems before revert.

My opinion here is that there's been quite a few people reporting to be
impacted, so while I agree we need to understand the old cruft
eventually I think it's time to rollback and try harder to reproduce
the various errors we've been reported and investigate in another branch
(not even -next, as that is also used by people for non-reg -- breaking
other parts of the kernel's non-reg will just make people stop using 9p)

And when we do finally manage to reproduce this that'll make another
workload we can test regularly for future regressions, I think we need
more of these (like my parallel unlink code); everything I'm running is
either too nice (e.g. proper build without parallel write accesses
within a file) or too synthetic (fsstress etc); more "real-world" tests
can't hurt.

> The create/remove a file multiple times in parallel could be linked to
> an underlying issue with only using qid.path for match -- the old
> extended match logic also matched i_generation number -- but I
> convinced myself it wasn't necessary and it required a fresh getattr
> very time which seemed excessive.  The alternative is to work this
> into a server-side fix, but if that breaks all legacy than that's
> likely unacceptable.

There might be a new problem but I definitely also hit some refcount bug
in the old code with that, so I'm thinking there's a place where the ref
isn't obtained in the right order causing a race or maybe it's missing a
ref for the dentry list or something (we properly unref when freeing the
dentry, but I'm not sure I trust all paths to properly take that ref
when adding to the dentry)

That's a hole I digged myself, I've just fixed perf (again[1]) to allow
hooking on the fid refcount tracepoint and I'll dig into this.
If there's a reproducer that should be easy to figure out even if
there's a bit of noise, will work on it over the next few weekends.

[1] https://lore.kernel.org/linux-perf-users/ZhPn0EwXf_bPBj-p@codewreck.org/T/#m8768e2b920e7111364c8f1309f09edb607d5aec5

Eric Van Hensbergen wrote on Tue, Apr 09, 2024 at 12:11:05AM +0000:
> April 7, 2024 at 11:17 PM, "Dominique Martinet" <asmadeus@codewreck.org> wrote:
> > * open / unlink / fstat|ftruncate etc fail
> > 
> > https://lkml.kernel.org/r/E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev
> > 
> > I didn't confirm yet but I think it's a new bug? maybe the 'fix dups 
> > even in uncached mode' patch dropping v9fs_drop_inode(); that's easy
> > enough to test just a new bug so didn't look yet
> 
> I was thinking about this one a bit more -- this smells like the old
> anonymous file bug -- but I started thinking a bit about it.  fstat
> ultimately leads to a getattr -- in 9p classic those happen against
> unopen files only so it'll go looking for a transient fid which won't
> be there if we've unlinked.  Its possible that in this scenario we
> should return the "cached" information for the file (which we have in
> the inode) if we can't find the fid via a walk (which we won't if its
> unlinked).

The file is still open so we must have a fid around; in cached mode it's
probably ok to return cached information (and a quick look makes me
think we do- we're not failing fstat here) but in cache=none we just
need to send a TGETATTR with that fid... and I just checked and we're
doing this correctly; it's qemu using fstatat with the parent directory
and file name and failing with ENOENT instead of using fstat on the
opened file, I was sure this worked before but this apparently hasn't
changed with 6.9 ; sorry for the wrong conclusion.

> Not sure if ftruncate is that same problem or different - right now
> the truncate code seems to be in setattr.  Need to do a bit of tracing
> to see if that's the path we are in.  There was a truncate bug spotted
> in legacy 9p, but I think that's something different.

Yeah, I think we're doing the right thing here, we're sending setattr on
the opened fid and qemu fails as well.

I checked qemu code and this doesn't seem to have changed recently, so
I'll reply to the other thread saying that probably never worked and
needs addressing on the server.

That leaves the other bus error problem that might be the same as
Kent's ultimately, but I can't figure how to hit that yet.


> It would be really nice if we could just get to the file structure,
> but in both of these cases that seems to be "lost along the way" in
> the VFS call-chain.

Yeah there are many places where we could really use the file structure
to get the fid that operation was meant to be on and we can't, but at
least the lookup from dentry here seems to work!

Sorry for the noise on this, we can take that bug more leisurely.
-- 
Dominique Martinet | Asmadeus
