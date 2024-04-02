Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD921798E
	for <v9fs@lists.linux.dev>; Tue,  2 Apr 2024 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021234; cv=none; b=t6dOxuEnUBkjipKPmscgckFl8jS4YXUgocMw8ZqxwzpWM1vgMtiayruf2q2sMtR+7tjhwn6vYd01QabXlk6Sky6F6YqE4udGoOhR1Zruc8qkTs8NmZMfQPTSRd7tEx2Z8aFw3yRZjLWM/+/q5c2Odq9B/RRBO/ZkqqJVSqUTvzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021234; c=relaxed/simple;
	bh=0ug7U0yN3ND2jjEY+rPHPLVq1XLubabee8f5pzCIcpo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=j3fkCrhOHK+vBaTheBgPzRUYi+B2lwrs6N5PEuVYzbunHjeB/ViNkWs3sll50MDTZ5oKg/gi3ng6H34aNQquo20q2twAJTQb0Hfk6y+7rxd+aeoV2Q3CsKjzKaI+Bw1vABQebviOyiGWtQSgudMF4jHdyhDeEljFLL8zd+pwSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NVr8bsbl; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NVr8bsbl"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712021228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jFxywGLos105UmtIqPrvhJ34uSwYX8zeYy1qYjENCg=;
	b=NVr8bsblBgZGjTaFJwvkSAx4eNRyiF9uLbQM3LtK2qyYg5aCy7h30nGcolC4PqFduRfvyJ
	qiLmYSrd0U3amrYzGeSlxUcefXo/ymMszlUTe/aBUuieEudWHj9/rdep1QmSGUO/yrJwBP
	ozSHME4IDsSgO9d/NweKqaGV5GYUw4g=
Date: Tue, 02 Apr 2024 01:27:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <1f79a506bdf50cfd456acfa876df8a502d64b976@linux.dev>
TLS-Required: No
Subject: Re: new 9p kasan splat in 6.9
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: v9fs@lists.linux.dev
In-Reply-To: <oyo4rhetu752bdnh3vlojiq5apgndnvsg3g2qcftvoho5vqr34@n6li2x5jwpml>
References: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
 <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev>
 <ikookkidwzvjwuexmsco437lusgk24rffec7pyxwnquhydsk4p@evfumg2ygpsq>
 <CAFkjPTk1WE_LuuiJ-fz3v_BHKZUaNSA2LUPD+KAULeH4R9rgCA@mail.gmail.com>
 <oyo4rhetu752bdnh3vlojiq5apgndnvsg3g2qcftvoho5vqr34@n6li2x5jwpml>
X-Migadu-Flow: FLOW_OUT

April 1, 2024 at 8:12 PM, "Kent Overstreet" <kent.overstreet@linux.dev> w=
rote:
>=20
>=20On Mon, Apr 01, 2024 at 07:33:50PM -0500, Eric Van Hensbergen wrote:
>=20
>=20
> Sounds like things were rushed a bit then, and there's some room for=20
>=20improving the testing.
>=20

Well,=20most of the patches had been in there almost since the last relea=
se, its just I didn't have time to test and incorporate fixes during the =
-rc cycle and most of the ones I saw looked like corner cases from kasan =
so I didn't give them as much attention as perhaps I should have.

> If you need testing automation I might be able to help.

I do like your dashboards and what not, not sure if I'm up for trying Nix=
 again though ;)

>=20
>=20>=20
>=20> Looking at your example above -- is it the case that most of these,
> >  there is essentially a missing log file that isn't being created by
> >  9p?
> >=20
>=20
> Appears to be, but it doesn't happen often enough for me to repro
> locally.
>=20

Okay,=20that's useful to see if I can track things down.

> >=20
>=20> Any other details you can give me from your environment (how is
> >=20
>=20>  9p mounted, is this qemu?, etc.)?
> >=20
>=20
> It's qemu, standard mount options:
> host /host 9p rw,relatime,access=3Dclient,trans=3Dvirtio 0 0
>

access=3Dclient may be someplace for me to start, I don't usually use ACL=
 based checks in my regression sweeps.  I'll update to add that to the ma=
trix as well as put fstest back in the default regressions.

trans=3Dvirtio,version=3D9p2000.L,cache=3Dnone,access=3Duser

should still be the most stable, but this recent set of patches does chan=
ge inode (and inode_no) handling and I believe by default they may stick =
around even though with nocache they should always be refreshed.

     -eric
