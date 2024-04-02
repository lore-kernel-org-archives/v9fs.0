Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E528F55
	for <v9fs@lists.linux.dev>; Tue,  2 Apr 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021665; cv=none; b=pz2cIEPUUsj1cTgVJIJb6NiT8v5PnVa94jNV5WMOG5QH1RKW1+/Iqwi2I0+6yzWcYwrNQFQes+634vMffu2r/DHzcrRhMjTOEivboLBdKH6zieKoKQ3lwq4RF6XwL31xtNBDt7ocLZTC16I4C5Bf6SxBSCSFnA1FWWW/hYy3Bc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021665; c=relaxed/simple;
	bh=AClj+vzpVq7EhBkhgvGsLo65xGWZfPnxl2a/djkMK5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE6EX5+t/q7a3d1EJC1uwVmYHKn1YbJQAXgrL5jyJohyALVpU1nGOtsETsUIH8eBP/A47nq9D/FuXQApAvh66p0UVD4v6epeDyoA/D1c8HYSMtgLbm68CDwSew+E2cTIwcwrSfZjWkTNpQUbWROcmsQNkplRs1ON7oLqt+COtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pNzTtqw+; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pNzTtqw+"
Date: Mon, 1 Apr 2024 21:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712021661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kFGKhiBCtCQbsR+HDSD6HrepOE12cTX3+iMKSfCcx5A=;
	b=pNzTtqw+hPYHmE7Gr3X6RduFCNe8SyHrMlH/emZalwN/uEQ4lFqtA4FUXELOZk6o792vGo
	/OfXxOunTTeVmcJEEsC2TZnS4EAr20Ou0C0+NinWGUea+2lG59We1D6i2I4s0Shp7u7jnT
	gZL1AXO9iSekx6iws/AZbzuIkY6l4QU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>
Cc: v9fs@lists.linux.dev
Subject: Re: new 9p kasan splat in 6.9
Message-ID: <anmfiaisaei4owk2a7of6nowbkdtwpmaw2x4asprvnd5lkqbfc@l4ydzro6uyao>
References: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
 <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev>
 <ikookkidwzvjwuexmsco437lusgk24rffec7pyxwnquhydsk4p@evfumg2ygpsq>
 <CAFkjPTk1WE_LuuiJ-fz3v_BHKZUaNSA2LUPD+KAULeH4R9rgCA@mail.gmail.com>
 <oyo4rhetu752bdnh3vlojiq5apgndnvsg3g2qcftvoho5vqr34@n6li2x5jwpml>
 <1f79a506bdf50cfd456acfa876df8a502d64b976@linux.dev>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f79a506bdf50cfd456acfa876df8a502d64b976@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 02, 2024 at 01:27:06AM +0000, Eric Van Hensbergen wrote:
> April 1, 2024 at 8:12 PM, "Kent Overstreet" <kent.overstreet@linux.dev> wrote:
> > 
> > On Mon, Apr 01, 2024 at 07:33:50PM -0500, Eric Van Hensbergen wrote:
> > 
> > 
> > Sounds like things were rushed a bit then, and there's some room for 
> > improving the testing.
> > 
> 
> Well, most of the patches had been in there almost since the last release, its just I didn't have time to test and incorporate fixes during the -rc cycle and most of the ones I saw looked like corner cases from kasan so I didn't give them as much attention as perhaps I should have.
> 
> > If you need testing automation I might be able to help.
> 
> I do like your dashboards and what not, not sure if I'm up for trying Nix again though ;)

There's no Nix required for my stuff (yet :)

I can point my cluster at your branch(es) with whatever tests you want
to run if you'd be willing to chip in on server costs, the hetzner
machines I use are ~250/month and one more would be sufficient.

(imagine what we could do if someone ponied up for a dozen of those, I'm
doing all my testing with just 2 - the 80 core arm machines are
_wonderful_).

> access=client may be someplace for me to start, I don't usually use ACL based checks in my regression sweeps.  I'll update to add that to the matrix as well as put fstest back in the default regressions.
> 
> trans=virtio,version=9p2000.L,cache=none,access=user
> 
> should still be the most stable, but this recent set of patches does change inode (and inode_no) handling and I believe by default they may stick around even though with nocache they should always be refreshed.

If you don't find a way to repro it or otherwrise track it down I might
be able to try that in a day or so.

