Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718C78BEA
	for <v9fs@lists.linux.dev>; Tue,  2 Apr 2024 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712020385; cv=none; b=V01FrCQySDcJorvE+NEiWGCp2hjC5nukhVVdHFjnRXPo0I6+UFZOgyltD/eEvn9faM9TASaK+MyliAZTdxvFbbMaxhyS3LQbYcy+QfXcSaqSHY89cIK6NDwAa27Zc0X29V8qd/4sKsZH/Et4DlO32rLfh7zogdwJEwE+vNQrxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712020385; c=relaxed/simple;
	bh=PpE9lkbsP4lZUJtpUa54FaZBIpmxlemNGLVq8Ro5lOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caz5kQf3GlDza2kT9BOk/CkF+WZMXPX+Qld7zlCSDi8qyTbLeUcZ8uYvfrwLeSTw+dXD6euyNv3ZXMED9iQljLOGCdzRhzF4nD7MYTK9abteFOFahKyYsfgoxnwJpZfSsVOBOVMo86d/0kuavtCuWpNeXjpoykYJmI+Ocqbt7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D63csG1f; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D63csG1f"
Date: Mon, 1 Apr 2024 21:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712020380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oxBIGTaEgdcxvjS2HEX/mNpHiZMYFPe1Qt1PT0o15cY=;
	b=D63csG1fmj0G+5FC9MiMmPJ36UHDMPfxulcSk894b6r5AS2orgYaLu5HtaLQ+ehMmxBxdj
	Ll9FvVxBmu7cAWB5HKJb2+AEyFqQeTwaIRCZt6/lvXb8BtXNHOwTKxfnhXfTFqkyQ+dlWU
	DuvTIlC8KhD8mPZnSCIlxXCnUm1QGNA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>, 
	v9fs@lists.linux.dev
Subject: Re: new 9p kasan splat in 6.9
Message-ID: <oyo4rhetu752bdnh3vlojiq5apgndnvsg3g2qcftvoho5vqr34@n6li2x5jwpml>
References: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
 <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev>
 <ikookkidwzvjwuexmsco437lusgk24rffec7pyxwnquhydsk4p@evfumg2ygpsq>
 <CAFkjPTk1WE_LuuiJ-fz3v_BHKZUaNSA2LUPD+KAULeH4R9rgCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkjPTk1WE_LuuiJ-fz3v_BHKZUaNSA2LUPD+KAULeH4R9rgCA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 01, 2024 at 07:33:50PM -0500, Eric Van Hensbergen wrote:
> I've got standard regression runs with dbench, fsx, postmark and a few
> special case ones to check problem areas we've had in the past.  There
> was a pretty extensive rework of some of the caching mechanisms -- so
> I was expecting this to be a busy cycle.  There were a couple of fixes
> that were in the pipe but missed -rc1 because of day-job deadlines
> landing same time as kernel merge window, but these are mostly
> upstream now except for a few legacy fixes which are still in my
> fixes/next tree.

Sounds like things were rushed a bit then, and there's some room for
improving the testing.

If you need testing automation I might be able to help.

> Looking at your example above -- is it the case that most of these,
> there is essentially a missing log file that isn't being created by
> 9p?

Appears to be, but it doesn't happen often enough for me to repro
locally.

> Any other details you can give me from your environment (how is
> 9p mounted, is this qemu?, etc.)?

It's qemu, standard mount options:
host /host 9p rw,relatime,access=client,trans=virtio 0 0
