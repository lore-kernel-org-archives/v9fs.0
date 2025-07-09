Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F023BCEC
	for <v9fs@lists.linux.dev>; Wed,  9 Jul 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087888; cv=none; b=dM/vHv+iLNmCTWMThz6qdp4Km6WRsyVSqVPTnCbUj5m66UZdty9EQnOQUDOOqpBEHhZA9tVsYbujXlMi76XJ8GL9Ahi56XDSBOyQ5yE7Fi161E4/hF1awn++oZFXCpG0ZmbTg5Gei3e4gFu6VxKdj6Btan+Y94zlNQNiS5e6zcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087888; c=relaxed/simple;
	bh=oRGJxOoY6Sb9QvNhIjZ1ZJhSnfSKCQdsXzj4pLtR8xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFpdQNqOOUX+LhbD/VhU4PwJgRK/t+yczcZNN+cBY2DuhXRO9bheYM7VOuTV6+BjPjEw1QOFgzl82HHvoF5qsjRapU6OsLlOtraMrvUbb75lcIz4wP1052v0IWan7hIfHEGuPHfTb9M8wIZuAUQGhj7GX7vS7LUi5PSorP639CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=evXpZ3aR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="evXpZ3aR"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso201003a12.2
        for <v9fs@lists.linux.dev>; Wed, 09 Jul 2025 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752087885; x=1752692685; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oMoCHTAV5NeIpZMq+DMEKC+TktfxuQeI3NG81ytBeE=;
        b=evXpZ3aREIZQc3SI/rKCJEmn0eL2zZHLZ37yrePU8oH9IqclW8aLR90wDl6IJ194xp
         DSb7dgHxl0AB1Z6J4wjDG9U5/kXmVYIfe/iuSxu4hsYo0FoAMfrTjjB/c5TzjfVwyKPn
         wPwcC6CnLPpPxeZQZH8H3ZLqgONZPKLIzz4ARANcLvFkM31i/KPs91hJtwDkRkTLRYj8
         0Dqi7dYBdR/UVv3nMY99abhVHu0LOgzBeHZ2EKF3RT8IQqn/rzlFi1XXIenRt6lm0Aa6
         6ZaPUEyIOLnO9+Uzx6XX7J2BeGqVzcerhHghEVubJ23DHUnzLF45mSFwrEviIDNRkRmE
         C5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752087885; x=1752692685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oMoCHTAV5NeIpZMq+DMEKC+TktfxuQeI3NG81ytBeE=;
        b=kIPOD57s0+l5nFyKQli1kcM5HiRHZnp16Gnm96faiJJP5SxAn9pCUYuHiDyyQB3DsA
         WBjvX99ShT/QEaiuurl2KGKadeTL5nEnloG1EF7BzjyRkSXcW7phX8Xa5nP+/U4k8uUS
         LF6uYjzCB/dGuguuSj/8A63Hzf2YMlMPyAEOoeQMqFQ0MwnGVT7UWBT16+H1ufl4CyL+
         drJN/UfFV373LaZVdpkGmuZwQHMHfCKfXH+xibbOA7m+AgLPSw5sQ2qh1/VEeVnP8qD7
         JAOHb8vpP/qm8qmEWolVGKJfNZaAAHAgzK3tBUK7vBnHfWBHcBJ9XVt8aDmFR0Rbl2lR
         hg2g==
X-Forwarded-Encrypted: i=1; AJvYcCXGZainMgbRrhzu1/3hTBJFKaG7Y8iDMEtXkE+rK+G5f/YBx8n0jxQvqnzrYMiYlDgvhxTs@lists.linux.dev
X-Gm-Message-State: AOJu0YyJkDeUfG8izco9DIYFtF2ezxYdQylI6oLSG8t5OfUCPrnAhdmc
	Zf1DroBI4/jtnyo8Uuab/1Q713BvyAm64shh/AQte617YL0O5mgGDYk1HCS+WrkSS/Ss5UxugkU
	K+EMSdC23rlQO0UR79Ag0yCVCBeyuVTps5AhMRpDgKQ==
X-Gm-Gg: ASbGnctukIIYpr1Iezjwi0v5fTXXAFH6UdFWgSU/4+iw2jbObi1csfQYbnkpt3JSfrp
	CI+E0DiP7fIVb4ioNvzBlxm8jSQbXWprbWOceKqzCc3oei1H87C39wLhMiwUMrgrkoilnsVzB/q
	WXK6aeXMZUhX9wKVWtvDLKIPIjPAdqE2dnvc+3EKgyjywJoh0Q9M9HmYMEcyn2tD70LGSoU1VQq
	3NBOqaK+A==
X-Google-Smtp-Source: AGHT+IHHFatUYcYPUIaiNLDpnLA9ZJlzI11FgOes6AgoJS9tnoz2rAKkdasV4aiimfA44DVTmm7JJ+DkAfN2TlJGB04=
X-Received: by 2002:a17:906:c116:b0:ade:450a:695a with SMTP id
 a640c23a62f3a-ae6cfbea8f3mr343461166b.61.1752087884599; Wed, 09 Jul 2025
 12:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk>
In-Reply-To: <2724318.1752066097@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 21:04:31 +0200
X-Gm-Features: Ac12FXxBjj4Q8rQSAFMTvxq4Dux5Rk-Aycgaq2Qj_9vYK8pVlc0gHVgIsMegDWo
Message-ID: <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:01=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> If you keep an eye on /proc/fs/netfs/requests you should be able to see a=
ny
> tasks in there that get stuck.  If one gets stuck, then:

After one got stuck, this is what I see in /proc/fs/netfs/requests:

REQUEST  OR REF FL ERR  OPS COVERAGE
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D =3D=3D=3D =3D=3D =3D=3D=3D=3D =3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D
00000065 2C   2 80002020    0   0 @0000 0/0

> Looking in /proc/fs/netfs/requests, you should be able to see the debug I=
D of
> the stuck request.  If you can try grepping the trace log for that:
>
> grep "R=3D<8-digit-hex-id>" /sys/kernel/debug/tracing/trace

   kworker/u96:4-455     [008] ...1.   107.145222: netfs_sreq:
R=3D00000065[1] WRIT PREP  f=3D00 s=3D0 0/0 s=3D0 e=3D0
   kworker/u96:4-455     [008] ...1.   107.145292: netfs_sreq:
R=3D00000065[1] WRIT SUBMT f=3D100 s=3D0 0/29e1 s=3D0 e=3D0
   kworker/u96:4-455     [008] ...1.   107.145311: netfs_sreq:
R=3D00000065[1] WRIT CA-PR f=3D100 s=3D0 0/3000 s=3D0 e=3D0
   kworker/u96:4-455     [008] ...1.   107.145457: netfs_sreq:
R=3D00000065[1] WRIT CA-WR f=3D100 s=3D0 0/3000 s=3D0 e=3D0
     kworker/8:1-437     [008] ...1.   107.149530: netfs_sreq:
R=3D00000065[1] WRIT TERM  f=3D100 s=3D0 3000/3000 s=3D2 e=3D0
     kworker/8:1-437     [008] ...1.   107.149531: netfs_rreq:
R=3D00000065 2C WAKE-Q  f=3D80002020

I can reproduce this easily - it happens every time I log out of that
machine when bash tries to write the bash_history file - the write()
always gets stuck.

(The above was 6.15.5 plus all patches in this PR.)
