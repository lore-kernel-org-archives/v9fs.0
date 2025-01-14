Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41F8493
	for <v9fs@lists.linux.dev>; Tue, 14 Jan 2025 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889047; cv=none; b=Ld9r0WzG1nwFY5pQ+mBuOV7Wk7gxZJgGntF9glUWNvS2O0v6UUeARVqYaMzxCrYxfTL7YeMmG7mSND+qRxtUYT4yvUiYB5E7BjcZ3+AuGTSR7ejozBNkvgMjeXnHENJ9pAdi+Lenzp4/W8NL2+xawD+kHc0KYseloVuolC/ibWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889047; c=relaxed/simple;
	bh=Gehn6nm4b/WYXpVQVFly3xLzTIPXbuRUGDuJRyrlK+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TPWcG1ZDH4n4Yxw66PqlH/rnCEnC9NFuedLGlcG4SP8oUzHioZxtNM0yiu1hVJA4MjS3Z0lkUoZ9UtGmDT27hJ4mHwYo9K3L1yTgBL4XDZwAooTPDlBKi/5RQh/TrCfZWyGx5uztV4trfTzj0IhSoAD1UM6RNplACS7iNl5g3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=N/p7UDxD; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="N/p7UDxD"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 48987240027
	for <v9fs@lists.linux.dev>; Tue, 14 Jan 2025 22:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1736888466; bh=Gehn6nm4b/WYXpVQVFly3xLzTIPXbuRUGDuJRyrlK+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=N/p7UDxDoNJD84b70Hxb8x8pVYsELrP51SMU9b6uM69AcpEjiCkt8J0oQkKj3iHiR
	 zGJwWZ5jhYCJqlWDZt6KOp7gsv9zsiR7RDIxr0OSfgxfu1S+Bw+mYWfCo8lckqQPL3
	 +i6XxWugEIkugeOP1Mh802n2WDJTrvCufc6KkK3dHfJ2X+b36GzufHcjHh7Mr7eEZf
	 V/lk4dr9q6nfYG1+MN9aqydYCGFWId8zex/8ftenxWafzMi1teo8+11tpaeOvNq4qL
	 sipk5rHYFLIjlSW5uqd88vHCxnmq8vsJjM/gF7H//97wTWCKLDRLkf4HNxPBdkSpLZ
	 nrLmYmIlspEDQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YXhPF5JPyz6tm4
	for <v9fs@lists.linux.dev>; Tue, 14 Jan 2025 22:01:05 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: v9fs@lists.linux.dev
Cc: 
Subject: -otrans=tcp with IPv6 address?
Date: Tue, 14 Jan 2025 21:01:04 +0000
Message-ID: <87ikqhcdpr.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It seems like it isn=E2=80=99t currently possible to mount using an IPv6 ad=
dress
and -otrans=3Dtcp.

I think the issue is in p9_fd_create_tcp in net/9p/trans_fd.c as it only
validates IPv4 addresses and returns EINVAL otherwise.

Thanks,
--=20
Joshua Murphy
joshuamurphy@posteo.net
