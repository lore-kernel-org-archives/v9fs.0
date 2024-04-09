Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838A86AC2
	for <v9fs@lists.linux.dev>; Tue,  9 Apr 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662815; cv=none; b=OjXTgq9larSP96QfJB1Zq92eeJj41EUkgeXCqes/m0Z8F7ZAvtOaL/LK08Az5fFZuQbjKgK7lsDTeZrKEFPFZKWE5x31ohUpDOpRXheId9cGbMAUwdNN4o4SGgpFunbZIUOwjjfEI5bWEV2Y8rdP/PAUsTh7DLPqitrktilqsoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662815; c=relaxed/simple;
	bh=cgqUZKRQa+ynBFr8C+3uMj9pr/RwkKGoBjb2aedYgeA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=FvwRn3pnBR2y8vtJAXURLBogMCRiZPjUGFO3/DcfEddWNvZxEl/15qObs3H4Ngz7PHXgb5OmOSQjBSVWdXL5ieaE8jXWZcdLEwLtPIonwl+lmmd0A8UCN+LEo3+6LRr3zTTVxiagxasFymFXBjvO+IV3U5tZeaf9OagafhmjLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nicPx1FT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nicPx1FT"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712662809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwcuf2ebBb1YjT+L82yKElDPrOD7RPNoX75PRywFmPM=;
	b=nicPx1FTiPk6dMAb31ZLrV7l0YaRCBIbgOhkofpNckpSgHDqP/sgXtTVwbCS3zewmIDT9Z
	lER83xIEtGnMAIZ2Ux3ng1mNdlwFIuGYKGNJfi3lVBNbcRHUWG8zMqvsIzcf22s7iPaPUG
	RtsKCEZZc0Nd3aNylaVB9fv5EHSB/t4=
Date: Tue, 09 Apr 2024 11:40:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <ee6adbc32495bf76d7a943752ec5eed152eafd1e@linux.dev>
TLS-Required: No
Subject: Re: recap of 9p problems in 6.9
To: "Dominique Martinet" <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev
In-Reply-To: <ZhSi8cq-uFpXdTwE@codewreck.org>
References: <ZhNvwwYRN4-EczYi@codewreck.org>
 <7b4724a5be3a5a5f4ab550741741ecf3479f7139@linux.dev>
 <ZhSi8cq-uFpXdTwE@codewreck.org>
X-Migadu-Flow: FLOW_OUT

April 8, 2024 at 9:07 PM, "Dominique Martinet" <asmadeus@codewreck.org> w=
rote:
> Replying to both mails at once
> Eric Van Hensbergen wrote on Mon, Apr 08, 2024 at 11:14:07PM +0000:=20
>=20> Thanks for looking into these Dominique - I've got the reports queu=
ed
> >  up and am just looking to ring fence some time to dig into them befo=
re
> >  I commit to a revert. The change in handling of inode matching and
> >  keeping inodes around in the cache longer are likely the root of all
> >  of these, but the old code had so much unexplained corner cases I
> >  really want to understand the problems before revert.
> My opinion here is that there's been quite a few people reporting to be
> impacted, so while I agree we need to understand the old cruft
> eventually I think it's time to rollback and try harder to reproduce
> the various errors we've been reported and investigate in another branc=
h
> (not even -next, as that is also used by people for non-reg -- breaking
> other parts of the kernel's non-reg will just make people stop using 9p=
)
> And when we do finally manage to reproduce this that'll make another
> workload we can test regularly for future regressions, I think we need
> more of these (like my parallel unlink code); everything I'm running is
> either too nice (e.g. proper build without parallel write accesses
> within a file) or too synthetic (fsstress etc); more "real-world" tests
> can't hurt.
>=20

I=20do agree with this, but want one more day before I give up.  I'm goin=
g to work on this today and tomorrow to see if I can fix Kent and Oleg's =
problems, including looking at a partial revert (as you suggest, maybe ju=
st reverting the inode_drop patch would clean up most of these for the ti=
me being since everyone doesn't seem to be operating in cached mode anywa=
ys).

Sorry for diving down the rat hole last night, I should have just looked =
at the trace.  I've added access=3Dclient to my test sweeps so I can see =
if Kent's problem is related to acls.  fstest just takes so long to run.

     -eric
