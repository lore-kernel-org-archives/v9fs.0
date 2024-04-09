Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99C10E6
	for <v9fs@lists.linux.dev>; Tue,  9 Apr 2024 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621471; cv=none; b=tJJNZC3wQ5GKG5O7ELnNURUe4A2+dXHO4pbcVQWMbTBNWkDMn+RvptTJlOUp6Zs7pBaf5DMsYyupGQb0DYbrPcnv5zMXFnZ8HN75XpQybYApWtuhBQlnFXlburJC26L395jVmQLUDOyHrh6usDAxK6wq5AHtriFVA3QgurqM954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621471; c=relaxed/simple;
	bh=9w7Mh5KmKcJE15AgBlES4Mx7bygayhFJRiFDtBDpZ3U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=kkGAPMseYlIcSjdEbxfh4pfHn5i4GgrTL+EkFuhm1BqH+snSc+nTgJuHR8QJGN/rUBMC97/CqYeiv54jyq+flnOif3Hca26rrQESQ9JsgeBRtsHmF1tzGhiYEJYBIbjMz/cBZAjpH52NPaBRal+hSAXh3h6DmO7y/OqAA1hBD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qy2q9WZ3; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qy2q9WZ3"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712621467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1yC/MOgFbKZrSqEPTNFzTfIGseZXFLm2hWhUteEXF0=;
	b=qy2q9WZ3vkWlqsgwdiNQaoaUQH/raLFRnJd/NXVXl91hLLc/z8C/vTfTKbgBYgauhg40yQ
	XseZvARc0w+Jy2PKCjpvNzIJwmjouh7IszX3NdJgEtQ3rTYPSeYiTjtck8fSnldLpLDnFv
	FeMWzmE+tdNOHxJclAfyAs0tRJOskhk=
Date: Tue, 09 Apr 2024 00:11:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <7b4724a5be3a5a5f4ab550741741ecf3479f7139@linux.dev>
TLS-Required: No
Subject: Re: recap of 9p problems in 6.9
To: "Dominique Martinet" <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev
In-Reply-To: <ZhNvwwYRN4-EczYi@codewreck.org>
References: <ZhNvwwYRN4-EczYi@codewreck.org>
X-Migadu-Flow: FLOW_OUT

April 7, 2024 at 11:17 PM, "Dominique Martinet" <asmadeus@codewreck.org> =
wrote:
>=20
>=20Hi Eric (& anyone else reading on the list),
>=20
>=20* open / unlink / fstat|ftruncate etc fail
>=20
>=20https://lkml.kernel.org/r/E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.=
dev
>=20
>=20I didn't confirm yet but I think it's a new bug? maybe the 'fix dups=
=20
>=20even in uncached mode' patch dropping v9fs_drop_inode(); that's easy
> enough to test just a new bug so didn't look yet

I was thinking about this one a bit more -- this smells like the old anon=
ymous file bug -- but I started thinking a bit about it.  fstat ultimatel=
y leads to a getattr -- in 9p classic those happen against unopen files o=
nly so it'll go looking for a transient fid which won't be there if we've=
 unlinked.  Its possible that in this scenario we should return the "cach=
ed" information for the file (which we have in the inode) if we can't fin=
d the fid via a walk (which we won't if its unlinked).

Not sure if ftruncate is that same problem or different - right now the t=
runcate code seems to be in setattr.  Need to do a bit of tracing to see =
if that's the path we are in.  There was a truncate bug spotted in legacy=
 9p, but I think that's something different.

So...is this a new bug?  Maybe.  I thought I might have removed the "fail=
safe" fid lookup of open files off of an inode -- but I see that this is =
still there, but it only uses it if the inode is still linked to the d_en=
try and we've just unlinked it.  I can see in the VFS code path its pulli=
ng the inode from the path (d_backing_inode(path->dentry) -- so maybe we =
just do the same thing for getattr if we fail to lookup the fid.


It would be really nice if we could just get to the file structure, but i=
n both of these cases that seems to be "lost along the way" in the VFS ca=
ll-chain.

      -eric
