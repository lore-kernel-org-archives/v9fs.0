Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC23E487
	for <v9fs@lists.linux.dev>; Mon, 17 Jun 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661034; cv=none; b=lmKx9Yo/59xADDIkaCopVyc3J3XYZTDPVAMjbgfLDuytIu9GHKYgHEDV1NwXZz9zHM7ZINcunZvW0wpplPWzGqi12uXLjNSn/F41dUfS6j7nFaWha20BO0oSj0h7mwkEv/PV72DCAP9DXTLfxwO+g/tPhXJZ3Zn0iAmJE6az0KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661034; c=relaxed/simple;
	bh=K5996YmuF9Yp/VeUlVnALyukbdeZvYdysz4v9fM3yfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHi3g8hOGi7X806vtu66Jt9rUnkvAniD9rd+ejKmPVZJcQmRq6JiUi5llBq5+DdkByjm5hczgaWZUuzEXjq0WhVIEzXbmZXHYqemAELTKRju0b++RwJxSjb6i3oc0fb5LhvNWmHtSWyBrxO0TJlL8cNvkmGN1IwyZ4563PPTqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=gRJsNVcg; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="gRJsNVcg"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5AC4A14C1E3;
	Mon, 17 Jun 2024 23:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718661024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiIgFPt+sEVlD3kUlLI3/jKRfS5oj8sZw2II+1SmJqE=;
	b=gRJsNVcgQ9b9/aamX83T1THpiGBoNbun7e2YBuUibZpxVBifs/D/JFC8KwlYEHn17DvvKt
	D40r91JM2hXgVut6vW+l1LwrB5RyfWk8988PASY9mj80Os7I0ZPoLdfQffBgisSWiMTJWK
	oifVvqMPeVoOxHDbxnshbKF94wGZlTdYrMog5B5G9U2EfEDMiFpfphTPa0QO8ymtPg0zKD
	C5l0LH9K0T/xwb4Wtmv1K79gSu4Q/N3zpIHVcOEppgyazxG6yy5TP4bvMUsZKEojerjx2P
	s48UJ+XD4RKV+iPOAklHilqq6GjZV4zIEMSolexVTwnPBJTvLJbUBgAMqIGogw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d3703de6;
	Mon, 17 Jun 2024 21:50:16 +0000 (UTC)
Date: Tue, 18 Jun 2024 06:50:01 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Kastner <ckk@debian.org>
Cc: David Howells <dhowells@redhat.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Luca Boccassi <bluca@debian.org>, TJ <linux@iam.tj>,
	Emanuele Rocca <ema@debian.org>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <ZnCviUrk5iQGrE4x@codewreck.org>
References: <Zj0ErxVBE3DYT2Ea@gpd>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
 <531994.1716450257@warthog.procyon.org.uk>
 <ZlnnkzXiPPuEK7EM@ariel.home>
 <57e56ca5-bbbc-495a-926e-54d7e2f5e76c@debian.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57e56ca5-bbbc-495a-926e-54d7e2f5e76c@debian.org>

Christian Kastner wrote on Mon, Jun 17, 2024 at 07:10:56PM +0200:
> On 2024-05-31 17:06, Emanuele Rocca wrote:
> > Meanwhile TJ (in CC) has been doing a lot of further investigation and
> > opened https://bugzilla.kernel.org/show_bug.cgi?id=218916.
> 
> just to loop back to the MLs: in the referenced bug, TJ posted an
> analysis and and added a patch that fixed the issue for multiple testers.

Thanks for the mail, one of these days I'll try to understand how to
make bugzilla automatically put me in cc of all the 9p bugs..

Analysis and tentative fix are of great help! Looks like we now
understand what's wrong -- if I understand the description correctly we
know the correct size (files aren't modified in the background, just
other threads within the VM, right?); and the problem is that the netfs
IO reverts the size back to an incorrect value when it completes?

If so then the fix looks odd to me, the problem ought to be fixed at the
netfs/9p interface level, I don't see why an unbuffered read should
update the size metadata when it's done...

David, what do you think?

-- 
Dominique Martinet | Asmadeus
