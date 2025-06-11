Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFA2882A0
	for <v9fs@lists.linux.dev>; Wed, 11 Jun 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650913; cv=none; b=gOVE1HjsQ1dPxFL5vKK6A7vSVs09p/FgpMupkkBOkUxs0jjFaS90SQ7ykcZ2BVSjpuEKIeZHmblsHNBpy0L1hAe0f37r1pT0kDSHZi2GF0W9loHzF6ontfUKBrCBYnH0Ilc+RM3AgX53I7EKlaeSt0bro3bKQ9lwDeOqpVXwZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650913; c=relaxed/simple;
	bh=crgnnjHZaqIsGOZjsjV7ZUBqvIC371P0i+OWUX75ppo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sumJj/uGGDoFZCo3h1l08+9sTvcaRBhCTUcIHcOuDGSOhlm8VkA/+VcjV9mUFyD17xw3+au/NZj+sY3FyOQokDmi7o8oNLgCpTCaCSFUpgM89PUqH/g4pmgt9V/5CDDUGAjRzy/b4ew4tRIR+reOmG3P17aiVwzfxjpl7co2lmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=293treE8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="293treE8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso2570671a91.2
        for <v9fs@lists.linux.dev>; Wed, 11 Jun 2025 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749650911; x=1750255711; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMCP5+i49Ei6OGx1t9OxUl2Teswzg233SMev8hs02gA=;
        b=293treE82dFVIzknAWsFS9E0ygEzjSBfVC2HpSKrPnSOkNkT7fvdCxySGsZg5YuOt2
         HpV5tTqIhPJCRpNds1epTXYe61RSSKEd2pQOyQd5HC2Hzln8WyP+oX+2eAxOw/14qi3b
         4uMdakVPla9/u954PzMN/nqUAtQv19j0KGXcePKckygetQJVoTn+9zfaI5JKjChbJ1+6
         4x0wqHjhxkrI1MwgCZPC0mXqLHu+vwFS8AmDL1uuJlCVemNntDMcgKo+Yn4L27++Boj7
         c3tPbyzz8hDWaY3djZvnzT6W+gnEcE1Fo6gmekf5OKduFSzlyJK2hccyZUqNYYsMnnyg
         k7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650911; x=1750255711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMCP5+i49Ei6OGx1t9OxUl2Teswzg233SMev8hs02gA=;
        b=fKFB/mm115aRF8axzMB55A/Fc5gOLl9GLG2zK8fUDMDdQsl+W0G41uGlbX9Qto/3sv
         4318/6OXCncrZiZGYnCZsFeH2kSAYQ38UN8V+ko0XsetQ7eNPj19jjjFFD3BgVJJZXmc
         MOEb9/567ojrFgXeicyCUnqSUsr9KPk8er9N5KZjm/AqZs3VMHLuIS9m9sf595noDg0I
         cltGTDNkRmKohT4RJzlOy4L7BXnPkV2jGjmlqludC1JLFUt9rfCK31mafDApBBlRuWvu
         kz/4r0f6UK22tQ7dWc45alqTpVY4PPAb8c1IXuMzqMmMmLp4wgjzfl86Io2+6sNcxmzx
         0amg==
X-Forwarded-Encrypted: i=1; AJvYcCXi1aRDG0iYofMhUOvrnff5ZoYOSYV+IH4vmkjreQQ2ir7KiJ6lm5XdPMGVdorwE2LiJD5p@lists.linux.dev
X-Gm-Message-State: AOJu0YwGqE/n4W4G6tAwGOgUBkvwtlCSpBmN8/tsu/AWRDLemFYbDyiU
	w0rUbYuHlbd+37nvRHbLpDJ0+QzOOUBeBsbg09wSzYWW3x8LeDE5k4HzrwEJRSTUM1qc4bxylAc
	fMmsJ8NSo3r1LgFRWV9T0oM05cSOP0WWGjvDsiq7/
X-Gm-Gg: ASbGncsAme/o5Sec+ssFNyYGHQ2+lc3aNE4UlfxRb72CwyGsym8b8+gqgYJfyTtd8kN
	CLWCguePcF0T05kf9wV4xsiEGNVmIe3ns8+7tmN16XH1wXNB4jHNIBuYWYGa4c2xX54kRsYp3cK
	WMRcxI/Anrp1G7e8oJ5DqJiTxQlddpqtswZKvmXkjAB8SiLx5NBdRjecdD7lo9zZlFBKgvF42I8
	g==
X-Google-Smtp-Source: AGHT+IE/zvALO/G36bMoEv9R3dBG9othx0hsbt6Wq2S7X1wCHNt0X1XpaAnFyLsBZjSEIc47LngfEr1Y5l2TxATtW/4=
X-Received: by 2002:a17:90b:3c0b:b0:312:1dc9:9f64 with SMTP id
 98e67ed59e1d1-313af26720fmr4514767a91.31.1749650910565; Wed, 11 Jun 2025
 07:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67b75198.050a0220.14d86d.02e2.GAE@google.com> <683b8ea2.a00a0220.d8eae.0020.GAE@google.com>
 <aDueHCMDLPs2UtY2@casper.infradead.org>
In-Reply-To: <aDueHCMDLPs2UtY2@casper.infradead.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 11 Jun 2025 16:08:18 +0200
X-Gm-Features: AX0GCFtUWXqinF3FxOk9yB1Et5-WWvCDPttaSsMJxKkZJmtGttcHC7lVof6yARE
Message-ID: <CANp29Y5H3VTZAVZjde5bVRajDUESAnCX+6H1wD90ArpT=EiU3Q@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>, 
	asmadeus@codewreck.org, chao@kernel.org, dhowells@redhat.com, hch@lst.de, 
	hdanton@sina.com, jaegeuk@kernel.org, jlayton@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 2:26=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, May 31, 2025 at 04:20:02PM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 80f31d2a7e5f4efa7150c951268236c670bcb068
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Thu May 8 05:14:32 2025 +0000
>
> That's not possible; this commit is after the original report.
>
> That said, there _is_ a double folio_unlock() in this patch, which
> I'm about to send a fix for.  It's just not fixing the original report.
>

Thanks for bringing this up!
The underlying problem is that syzbot has merged several unrelated
kernel crashes into one bug report (`kernel BUG in folio_unlock` is
just a too generic title). The reported bisection result seems to be
correct, but it refers to only one of those incorrectly merged bugs.

I've just sent a fix for the syzbot's crash report parsing code [1].
It won't affect this specific bug report, but once the new code is
deployed, syzbot will re-report the two underlying findings
separately.

[1] https://github.com/google/syzkaller/pull/6081

--=20
Aleksandr
