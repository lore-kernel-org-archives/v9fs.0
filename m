Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FB12F5B1
	for <v9fs@lists.linux.dev>; Tue, 16 Apr 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276999; cv=none; b=BVMW09jSL3ZrbxMnAEgMueHsIzxdpaNA40LfzSjcb1+xJC7d/zQ+gEXOGQKVxX8QqfKXpbxa19102NS5CZ16VFZp3SaD2DLnq7h74nF43Q8V/GdVWjKH42mlMAR1JrF/e5fvM05nyL7f9Mdn9nWRT4F2pzjGNMvrVXurir6j0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276999; c=relaxed/simple;
	bh=a/inbAZaZkyOKJgBNR+5znTznFm7ELdzO93P8ffhB0Y=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=koh/gfx0CMIE9YgO+tB5muLbFFDYYAVmvogA7jguY08yByeLOnlQI/irSB1b2K6pM9oE+aSOti9O1a4peyMx/ifkcGaQv6hsuVfWUEdKfEfTrjXYB01EML2waYrlRDxRDWL2Sagi2PqjYjkOL/W+Yzwe1i711DSYxdnZoNRFtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XgB9BdEs; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XgB9BdEs"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713276991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9250ocBfIiBtt4WHAPqFNPSj2DLRzg8mHSvw/GSmH54=;
	b=XgB9BdEsSamtnkhi+CiQUxax6E4RNgvjuOXgmmih9BHw9w8rrIOMXlC1e+lMs4VPh6svKy
	H+rhc4hZr5WRtZxKtY/9/yBZo7k1iBkM64ffPAAbIjR9VeDf15oP5XOS1acbim/4JPpTUo
	tA0xwqSLZ8kEPz4KJuMQbXHy5L8fJaQ=
Date: Tue, 16 Apr 2024 14:16:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <d7164a3abce2d194041d9179a9ef153d75edb099@linux.dev>
TLS-Required: No
Subject: Re: ftruncate fails
To: "Itaru Kitayama" <itaru.kitayama@linux.dev>, "Dominique Martinet"
 <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev
In-Reply-To: <74C91BF3-4BC7-46A7-9BB2-1360E07B6FE5@linux.dev>
References: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
 <ZhNP4SISzZOGwy4A@codewreck.org>
 <A9C784B0-3B04-4EBF-8AFF-DD5088B5EF67@linux.dev>
 <74C91BF3-4BC7-46A7-9BB2-1360E07B6FE5@linux.dev>
X-Migadu-Flow: FLOW_OUT

Itaru,

If you can, could confirm that your issues go away with the pending-fixes=
 branch of the next tree?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?=
h=3Dpending-fixes

I work for Arm as well, so if you could point me at the revision of FVP y=
ou are seeing the problems on I could also have a look at the server side=
 of it and see if its breaking any assumptions we've been operating under=
 using Qemu as our primary server.

     -eric


April 7, 2024 at 9:22 PM, "Itaru Kitayama" <itaru.kitayama@linux.dev> wro=
te:
>=20
>=20>=20
>=20> On Apr 8, 2024, at 11:08, Itaru Kitayama <itaru.kitayama@linux.dev>=
 wrote:
> >=20
>=20>=20=20
>=20>=20
>=20>  Hi,
> >=20
>=20>=20=20
>=20>=20
>=20> >=20
>=20> > On Apr 8, 2024, at 11:01, Dominique Martinet <asmadeus@codewreck.=
org> wrote:
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  Itaru Kitayama wrote on Mon, Apr 08, 2024 at 10:44:51AM +0900:
> > >=20
>=20>=20
>=20>  With a recent kernel I see below program fails (Bus error) if exec=
uted
> >=20
>=20>  from 9p mounted directory, not with the local filesystem (Ext4).
> >=20
>=20> >=20
>=20> > I cannot reproduce on 6.8/6.9-rc2 with qemu and a couple of optio=
ns.
> > >=20
>=20> >  Bus error would be some problem with the mmap of the executable =
given
> > >=20
>=20> >  this code? so probably doesn't have anything to do with the cont=
ent of
> > >=20
>=20> >  the program itself...
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  A few questions:
> > >=20
>=20> >  - What exact kernel are you running? (or closest approximation)
> > >=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  v6.9-rc3
> >=20
>=20>=20=20
>=20>=20
>=20> >=20
>=20> > - What server? (assuming qemu) what mount option? (tried default
> > >=20
>=20> >  cacheless and cache=3Dloose)
> > >=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  FVP and just mount -t 9p FM /mnt
> >=20
>=20>=20=20
>=20>=20
>=20> >=20
>=20> > - Does this reproduce right after boot/mounting the 9p filesystem=
?
> > >=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Not immediately after the boot/mounting.
> >=20
>=20
> My reproducer wasn=E2=80=99t explaining what a kselftests was showing.
>=20
>=20If you build the =E2=80=9Cmm=E2=80=9D subsystem and execute one of th=
e programs, gup_longterm from the 9p mounted directory, you=E2=80=99ll no=
tice the ftruncate error.
>=20
>=20Thanks,
>=20
>=20Itaru.
>=20
>=20>=20
>=20> Thanks,
> >=20
>=20>  Itaru.
> >=20
>=20>=20=20
>=20>=20
>=20> >=20
>=20> > Thanks
> > >=20
>=20> >  --=20
>=20> >=20
>=20> >  Dominique Martinet | Asmadeus
> > >
> >
>
