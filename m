Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81AE24205
	for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249142; cv=none; b=cwHhHes5CLwlCTvDoXc44qZhufAu3bj13prWD5/Dt6yC66936qgh0nkmH0YQXZVvIrkBBHuFNPFeBqydVE9Upvuxh7yR1jzFGcoxDNgGjVuV//wavUPMfT6GCr0OwNZb5ufKBJskXlqXR8s2b/7PB0I/j1gWZ3f28ZA85wZGa+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249142; c=relaxed/simple;
	bh=K2pixndlAt0g4SBukt7putx+lOUiXXfFepG348nJw7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hec+fIwuy2hr9zWzf/aOfCw1z8U/ZbzjeFSomzpXZheqZsnwd8txPwXGvHR9Scyo71s0sboDq3iABNXjIUEsqZ95gcyUyInsmbgSBAqbGNI6ds+J/z++sZxI3BAa9O9p1NHLArOtFdKAyezx9rvJWFirMhhk31yHL76oIc+6cbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sl7ipRfN; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sl7ipRfN"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2D3D514C2DD;
	Wed, 17 Jul 2024 22:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1721249136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edQiV/OV4HNnkEERcTHu2WNm6EsvYcrYLHW7axpXgKc=;
	b=sl7ipRfNBNiUPWUMSfsBbV10cKvjd/m2F+5FPsPhRbX6BbXAjiHx/xv9Zns5UX3N2JHQHI
	a7VJ4csn6xKWly9GBZ0yJlESjUhajRD3HaW/HfTiLCfUzqWNSNv9ciJO9cEXDMH0zU4E1l
	6ekrgFl0/b7LpgA2XtOGh1eHtQr1pIvmsatA0EzBBBuZs9Syw2sOuHeLA2VnQso2tIuZfw
	lX/rglEJlm4BxPghcJWLrckQKQumKI19jsAbBbW3iIz9HBZ/jx7olJw+drnQ5T9ZT4ZZ25
	tH5JlFmJwi/Hm0w7KwZmhRp2nU4d8hgiepX0kLh7I99Pd/ZNS/FYilW5fAfsYA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 33098d5c;
	Wed, 17 Jul 2024 20:45:33 +0000 (UTC)
Date: Thu, 18 Jul 2024 05:45:18 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: Re: hangs after merge window changes
Message-ID: <ZpgtXjz3pbJKUjL7@codewreck.org>
References: <20240717102458.649b60be@kernel.org>
 <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>

Eric Van Hensbergen wrote on Wed, Jul 17, 2024 at 01:01:26PM -0500:
> I held way back on adding anything new over the past cycle, so this
> sounds likely some external change maybe perturbing an older issue.
> What guest side mount options, qemu options and qemu version are you
> using?

Mount option if any would be much appreciated, yes.
Also, what version you upgraded from to limit the limit the search a
bit; the previous 6.9 tree?

Also couldn't find much infos about the CI in general, given the traces
I don't think the workload matters all that much but it can give
something to start with e.g. running from initrd and mounting 9p or
using 9p as rootfs; that shouldn't make a difference but might as well
try to reproduce from something close to the actual netdev CI given the
low reproducibility.

> Dominique, you aware of anything coming in that might have messed with
> this?  Maybe the new common code refactoring underpinning
> readahead/etc.?

Given the trace it's probably stuck in __wait_on_freeing_inode (the only
schedule() call in find_inode_fast), so we could be looking at
fallbacks from the iget changes but that made it in 6.9 already so
that's unlikely...

I have a feeling that adding cache will make the error go away if you
just want to fix tests for now, so would be great if you could try
adding -o cache=loose to the 9p mount options; hopefully the inodes
won't be freed as often and that'll make the race harder to hit.


I had a quick look at other globals fs changes and nothing stood out,
it's going to be fun to track down.

> On Wed, Jul 17, 2024 at 12:24 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > Apologies for possible duplicate, I tried to search lore and haven't
> > found anything, but also I can't find the exact 9p archive there :S

The new list is here: https://lore.kernel.org/v9fs/
You probably didn't miss anything :)

-- 
Dominique
