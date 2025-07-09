Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D228C84D
	for <v9fs@lists.linux.dev>; Wed,  9 Jul 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056792; cv=none; b=j0xLobUAX6buF665kkELlpkOXJ/+xuzgpFoWp2eJi8ELsW/PXeyK0PENQlltXCjwiL/tlEtzhDwRHK4snz7a4AcYEB69ontwYiu1zlPMHp7NweU58KVOwInS6uPXSycegZ5tBIvi3U4PDry3MIcAeOJfjf5YbEqxwG6C7T5YZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056792; c=relaxed/simple;
	bh=wbnVGbjHNz2co8d+fXBHn4JejafVFSAL2G4zjFDrvs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egWx+lpa3/lMltN1kQslpTi/BvR6L0sxfMp73tjXDjJ13RTsTpaCvKlJLnhlCX26aicUp2u5JwR1suoHzCmbd4sWlzV62TYPAfvIF+GyApJKcKttsxK85qWZxfpCREEOoz8wTYjYVru4PD8x1T7Te+lNzknYoWQmZ9/0L/HTr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SMoDh0Ci; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SMoDh0Ci"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acb5ec407b1so936917866b.1
        for <v9fs@lists.linux.dev>; Wed, 09 Jul 2025 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752056788; x=1752661588; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=SMoDh0CiQtAKP8ez6Xt+jpQ2grd+sg/yMFKz5npj9ySsMJDy3h2RVIQc2ygfVFq/2h
         96y4snzbHzsRxH5KhVaiv4OFYUAMJLV3hrtJ6ZztbuvhEIHeR0gCJgVa4Wa9wXOrEMzG
         MAlnNgkShUx9IP57J2Sjp4Ae3pkpsgbu0nf+h8SD3hqWWjWL/uUICxhfqjAuN18wgZJY
         pRijqClRpeVP0mkbcedQ+5/BfLlgvNVYmEC7NwJxLV6OyyyFi7sVYTTWtWSTzY/qfekt
         3YhdhWsFdcL+SqDv43mXGW9ySH5W4VhREl5m6DHY3fm0L8I1tCNA9hb5OwhAiSoQN2h5
         AMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752056788; x=1752661588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=whMabJbzM+UfUAcIn/41gC0TELh7e5hW8AbncJ6gys5S4jqEYv+RcTJkz+k4JtzmNe
         y/9i5W8UD1w2Vb8k/MvtoA14JJVbJ8WCJMU3Js5UcwUdhqR9+Vyh106pIQZr5XH26U8V
         zabotbrxtIfqQZqIEQH50hvdURZEIjqf5AjShitK7XWCgrMZU3vPpuFRKAnrVQLPiEGz
         sh5SH55xOjrPg0rTmM8FLT5/U2kFMQrb4YqJJbCuXj0ONygm0N3T6s4Rx6fGPJhWAodS
         voe9IRIeog2B0XY3NxsL+0Z10goSbhaWTby2LHNDeUU6goCJkZc01CGuq4VoaZgjn9M0
         HMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV/uVdvWZgq6alrpOY2t+lqKpIKt6Ms1aGJRPB9yKr0OPoD4nmShTGMT3qRL7NAtGoPcyh@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5P/gL9GcLt1bmnI+3i2UKfcLBMtOtegDht563Jjy/7aIxlyYo
	t72N1c4FjqJAPKD9DF2hgLqrCExqLGL5L4mfeTwkOkCSFgNEKhhuBlDmUW5yefHEYGDdTyvqDFc
	ZyA3EPdvP/949jZHK8pTa0ppM8goxVIL16FXfTQVE/NUqdFnJyE90Dcc=
X-Gm-Gg: ASbGncsDll38ocZuHiCJ3OifoeGrodAfeaR0UH8B+UItU27uMARa146P939WfuO8bIg
	rPQWJG2enp5dXF82vUnOcp6vc476XRfXzjpJI+fJfiNkwETq5IuKOp5g+KlyeHhe9Cf3U6iIhDK
	qD/6XxrimliUUWIuuKwtSFtqN9RwK00bsi8MbBpdY2e+P/izyMg3X1Ejb7FSHPTe4CAxcOT6/PR
	vnifenAuw==
X-Google-Smtp-Source: AGHT+IGbqwygDCctWSd13zB7txA8nj1LhT4JGyQ85VQ1ULmFhI635wDH8IR1PaEr0MvmBrrgrCIFH+uxlqg39uXxl9g=
X-Received: by 2002:a17:907:1c15:b0:ae0:bdc2:9957 with SMTP id
 a640c23a62f3a-ae6cfbd985amr185279366b.61.1752056788493; Wed, 09 Jul 2025
 03:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 12:26:17 +0200
X-Gm-Features: Ac12FXwp4fbGLXVwqf6tAOr1y42YQrXGTBI6Q0Kfy3_DmIljAuOKBpuGHKZXSZ0
Message-ID: <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

David Howells <dhowells@redhat.com> wrote:
> Here are some miscellaneous fixes and changes for netfslib and cifs, if you
> could consider pulling them.  All the bugs fixed were observed in cifs, so
> they should probably go through the cifs tree unless Christian would much
> prefer for them to go through the VFS tree.

Hi David,

your commit 2b1424cd131c ("netfs: Fix wait/wake to be consistent about
the waitqueue used") has given me serious headaches; it has caused
outages in our web hosting clusters (yet again - all Linux versions
since 6.9 had serious netfs regressions). Your patch was backported to
6.15 as commit 329ba1cb402a in 6.15.3 (why oh why??), and therefore
the bugs it has caused will be "available" to all Linux stable users.

The problem we had is that writing to certain files never finishes. It
looks like it has to do with the cachefiles subrequest never reporting
completion. (We use Ceph with cachefiles)

I have tried applying the fixes in this pull request, which sounded
promising, but the problem is still there. The only thing that helps
is reverting 2b1424cd131c completely - everything is fine with 6.15.5
plus the revert.

What do you need from me in order to analyze the bug?

Max
