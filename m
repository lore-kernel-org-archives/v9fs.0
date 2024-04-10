Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037E2BAEC
	for <v9fs@lists.linux.dev>; Wed, 10 Apr 2024 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749432; cv=none; b=bODP8F7lfl7lhOeONWmaEMO8HDd1fdr8P2bxdZj3Nu74Jn3G3RxM8RllGuNNBYN2xkoxhVWB8A9XZsn2RJYC2z5fpsOFVIzI9/Jz7IvoiyPRuVlQYLQbPT/qhA/lZN8072US9QYXnZ3Tog4AxEiSu3qHq6Jv3ENfIeEfZgeEa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749432; c=relaxed/simple;
	bh=TcPNuJjWOY5aK7/UqfvyH/9tseYzEOaZO8R0vGAZnCU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=GZAlb1jlT7d0Hxs1J/2vcqfYCBN8+kO8HJRvgmrwLUhrPrY2PPb1lXCW7bCom5eOz+Lh1eZ+TPcIVMIbXHaw3rfoX4SY8cAifWilPRLL1cenUmFRGe2dWFd+n6Hv1UquGFZ4Nb5D9+lhUz39YHyaU3OmFagNRo/+51NumywmWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JipybYet; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JipybYet"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712749427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLzMSRLwrH+R29al0wP2YWFNItEMeT2lBV+f4oXzwo4=;
	b=JipybYetJd4WYNCXmuXZGpgCYqpOO5+PJV03JsSUFpJ4mrku1m//SBs/AxvoM+hmEcSMZg
	YmpaAD4Z0oA4bMF9PkKIWaJfsQ4/W0orXekQpELk37QoHCgEautOrd27yNb6d7lLxZS6jh
	tU9czR4mQOnciAiFYqv1DJWJMUEmGgU=
Date: Wed, 10 Apr 2024 11:43:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <29d9bb670a489a38dc9112e21dcf73d44b67d2f6@linux.dev>
TLS-Required: No
Subject: Re: new 9p kasan splat in 6.9
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: v9fs@lists.linux.dev
In-Reply-To: <1f79a506bdf50cfd456acfa876df8a502d64b976@linux.dev>
References: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
 <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev>
 <ikookkidwzvjwuexmsco437lusgk24rffec7pyxwnquhydsk4p@evfumg2ygpsq>
 <CAFkjPTk1WE_LuuiJ-fz3v_BHKZUaNSA2LUPD+KAULeH4R9rgCA@mail.gmail.com>
 <oyo4rhetu752bdnh3vlojiq5apgndnvsg3g2qcftvoho5vqr34@n6li2x5jwpml>
 <1f79a506bdf50cfd456acfa876df8a502d64b976@linux.dev>
X-Migadu-Flow: FLOW_OUT

I'm having a hard time reproducing the=20

April=201, 2024 at 8:27 PM, "Eric Van Hensbergen" <eric.vanhensbergen@lin=
ux.dev> wrote:
>=20
>=20April 1, 2024 at 8:12 PM, "Kent Overstreet" <kent.overstreet@linux.de=
v> wrote:
> >=20
>=20> Any other details you can give me from your environment (how is
> >  9p mounted, is this qemu?, etc.)?
> >  It's qemu, standard mount options:
> >=20
>=20>  host /host 9p rw,relatime,access=3Dclient,trans=3Dvirtio 0 0
> >=20
>=20

I'm continuing to have a hard time reproducing on my test system - I've a=
dded a bunch of BUG_ON to the code to catch where I thought potential pro=
blems might be and have not tripped across any of them.  Can I get two pi=
eces of data:
  a) which 9P CONFIG options are enabled in your kernel?
  b) what is the underlying file system on the server
  c) what version of qemu are you running

I'm going to try to spend all day today chasing this down, I may revert a=
nyways if I can't reproduce since there's clearly degraded behavior -- I'=
d just feel better about it if I understood what the problem was.  In
your reverted version that doesn't experience the problem, was it just th=
e last two patches that you reverted or the whole series?

   -eric
