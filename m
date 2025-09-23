Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E82D838E
	for <v9fs@lists.linux.dev>; Tue, 23 Sep 2025 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657544; cv=none; b=NsB/vYvN9jgt63f7t+KfLrzFeyH5UwSsSAzCnIKieCKGxpSuxFvPe5Vyjs42Zj/+NS7Ew2QPVp2L3nM7YlEOFLGLSY329WbX1T31m0ZQ6aXVuqdPlUkd2v9mkFrnORoZWiMbEPrQT69LprqO4n3ArQDAr43DSfb5LAhT1qsEvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657544; c=relaxed/simple;
	bh=WbRxxvPu2PII9+tVZPTYHIku5xjnJJfqpOzcsOGOcTg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GxmZXzqMyplCvNX9vOYBZGxrurFEpJXngxq98Ab7A/pwDN16ln2pBzC1bgUdYc9CkKGoLgykUDXzqyoXmqPIR1R5OCLe0OcMYTmKPMsdb0wMKXSQNvLgoOVfAtBoAr/rZKJgeRBTpXtnwWd8IfHlvamtDaYQlmMyHGkECk+p1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42575c5c876so33916715ab.3
        for <v9fs@lists.linux.dev>; Tue, 23 Sep 2025 12:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657542; x=1759262342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcaaZPCV5Qrgwa3vKDEUNa/ct40/p9wKCLJtyWA+kyQ=;
        b=EnXfg1eWmb68ke4CgXtyWyCdZJG7lfKyTohgSiz4MXMPrHRVwRER9nyONqj8ApQagv
         hszlENSE7UDwxhDkXqAzcmThAxowCLrGfn9FP8ThrX5vwBfsarVD8yiPBt27LxVpCAt3
         sPuyYcCfR2zIzTTgsbB8u+tNGmfUzQFa4iUcUuj7h7swk3tcGZ492rK2kAmF9KheZ8hX
         2FS66aM9dF5IiPCr+U2Ve4Lmr2O5gYO3tGJgLJUS6jdf0H6Yf8KKgwv4Kinls5LhCY2o
         QrigilyuplealCj3ZfMCXJoNdmoq57Y9lc9f/sLbGbxrN+OuFnCBbdLwzEpqtH0Oj+yb
         S8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkQLUgmuRPBDvVtTdnDLRZjO0bfG42ZkhjJqiRbg46Dfwgbq/4UHeQrRQl+ZXhYBz+ZwCz@lists.linux.dev
X-Gm-Message-State: AOJu0YwH6+wXo1lxvqW8ghvxs4iT5s0eUoHoiHw+it35w1XO0kNAb8/6
	Lnhh2pucw4ooJZG2sqiAbO4MJZXXfsfQSVkzQhyEpPiLVgJv5NEgrs0yP96VY1on51+6aJr2EY0
	G8GGR96NbH4FZlVwOBwiGxLuUYQluZJZO4l+85r5C3rvn2bxK5qBBmlXVE0c=
X-Google-Smtp-Source: AGHT+IH4ryecd7+jD4K6kYGAIwNEyzeiCtIWaDcMQ3DqckIrtsaX5FHyU9Wx/aV8dwEqItA12eZFVdFCQBiegXhWf5yf0gEyZVTH
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160f:b0:423:fcd6:5487 with SMTP id
 e9e14a558f8ab-42581e28b8emr65860075ab.14.1758657542574; Tue, 23 Sep 2025
 12:59:02 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:59:02 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2fc06.a70a0220.4f78.000d.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, danielyangkang@gmail.com, 
	dhowells@redhat.com, eadavis@qq.com, ericvh@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lizhi.xu@windriver.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a3de58b12ce074ec05b8741fa28d62ccb1070468
Author: David Howells <dhowells@redhat.com>
Date:   Thu Aug 14 21:45:50 2025 +0000

    netfs: Fix unbuffered write error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162dc142580000
start commit:   5189dafa4cf9 Merge tag 'nfsd-6.11-1' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16828c5d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103c7805980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: Fix unbuffered write error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
