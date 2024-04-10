Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7B51802A1
	for <v9fs@lists.linux.dev>; Wed, 10 Apr 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769642; cv=none; b=X+MNECD6cm/vdqmUzoZ2D7xh1Z26YSqhqVZdT0ebE+VeYFUDR6LtNtC9Guy7VlV6dm++pGua3IZ4Utc8I6hurJ4Kwemt1XzZOeR9+x2NwWQDDSXG9rHKKu1icIU5K2fsJWO/xFZigCQdceDGrmy+zfxhAhxrBalsGTWWL0H/KgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769642; c=relaxed/simple;
	bh=PsWpXs1NuPSwl66x69zyrxYf/hlPwxZ6XcZqVGM8uSk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=PfI1LLUKf3zVNp0vB1n6nIcakqnDlQPgU5zxvqMHXUD8Heugp3p2kPwJXPBNRDu6EUfaGoUbV88CVZmq/gSsa6cE2j2cMmRkeR9OLLFMOZkpwvZmCTHtUEnMua7/OzRCD7iruxBwMqLn5WBoDzaAy+L5OQOeIsbaGiEveOrVfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h8/ybpG/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h8/ybpG/"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712769637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDLzmJERFTN3jGbjrcjN2a55mLz0Ori0S0tO3SCFuC4=;
	b=h8/ybpG/XOuTbHx1JDOhmF/3hfR7tjKsKYAI0ip4i8Np5QBqal2AZqV10/N8fGwH4mgEGq
	izTyCCxeEq4GfT1PE46NmAr11yqcYQt2apH+Us5ubPM0zeenui5Qp8OWcjW0Rol9wUXet/
	9h0CFh5d8v+xcwS3Y7VyzKfUFgDtB1I=
Date: Wed, 10 Apr 2024 17:20:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <74f117635037a82dc2fb2923993cf329b6939b7e@linux.dev>
TLS-Required: No
Subject: Re: [GIT PULL] fs/9p patches for 6.9 merge window
To: "Oleg Nesterov" <oleg@redhat.com>
Cc: torvalds@linux-foundation.org, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240408141436.GA17022@redhat.com>
References: <ZfRkyxUf8TIgsYjA@1149290c588b>
 <20240408141436.GA17022@redhat.com>
X-Migadu-Flow: FLOW_OUT

April 8, 2024 at 9:14 AM, "Oleg Nesterov" <oleg@redhat.com> wrote:
>=20
>=20Hello,
>=20
>=20the commit 724a08450f74 ("fs/9p: simplify iget to remove unnecessary =
paths")
>=20
>=20from this PR breaks my setup.
>=20

Thanks=20for the bisect and detailed reproduction instructions.  I am loo=
king at this now and it seems to be related to another problem reported b=
y Kent Overstreet where he was seeing symlink loop reports that were disr=
upting his testing environment.  Once I'm able to reproduce, I'll try and=
 get a patch out later today, if not I may revert the commit to keep from=
 disrupting folks' testing environments.

      -eric
