Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8BD14F11E
	for <v9fs@lists.linux.dev>; Fri, 28 Mar 2025 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743136986; cv=none; b=KWVDL65oSsbsMDiTbSAwiSpwHzzyFPmmRjrPZ1NtmfaP6BZRGf2hGi8ydyvuT8RylDjjM0faPdmEkVNr8+nnOYf+9Id0wtdxIzWX2CguTaSuNLNr+rXH/CkbwmT3LlLBOFcux81/CgTisz/J/RZ98aDTLRM4CgvyTf8uLb23Cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743136986; c=relaxed/simple;
	bh=js7lVUj/SeoCBiYflPxyZS1OX5HQtjm0DSuCarpQVOk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FOpGK+27XCgVtSFvNm3ORw9TDKIr91hgs07tuYcLxhZSXCdl9kpfW57tnylrBnMAaoJoRu90RgbAICmgAsj1IHwVl9v2fLboHWsnVoPnpfgyU1GVfXX+yTMKQjuzEOc6S2sev0aB72T0PichaZbcHOBsLJGUN5Ly7ncndo6FaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85da19887ebso391698639f.0
        for <v9fs@lists.linux.dev>; Thu, 27 Mar 2025 21:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743136984; x=1743741784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uDB2tY1hUjqwKYCX0GkGa9GQ8Dhnk/SPYhijdcB1Zw=;
        b=DQ0SbeCaqIOUtTj3yBw13O2DW/hk0BUbmND9QxA6DDzZwwwTUrToXvkZQWaZJFWiI+
         WRjw9h9rC9Y5FIg+E5jQF/tTvbTwYOYzWRrSi72O7+LuEbYgQhG9oshGhAhQLqLSxCK7
         RmDa9neLG1XVbcQ3Uo2Zs+zaTP3yBszYt99CRfQPfC/6EIDhrpGyhaGOGxgCm1neEXc0
         Qma/Efzj/oxNuEcoDf/58wiH9LP3IrpLPWnScyIkjsuCOTmimfM3QIvmgKIsJ80k705H
         wCIVAjIh7aMxWoSGTvcfsnp1LUhWmtk4V0Attu05iw8fqwfowgSitmghHccHbhiUNTBo
         9SDA==
X-Forwarded-Encrypted: i=1; AJvYcCUfMG/Kbzlg7UKtRt4e1r5R7vg1rcfzj0px8IsSDXPip9t3mwabk+MYm1TsWR18Cl2YrhVA@lists.linux.dev
X-Gm-Message-State: AOJu0Ywjiul4CiUXpRVg/nMvjJhJsOov8BUmgCxTLHLPSE/dyf6705Ob
	bx9W6bTCvC4VQuPO+utowredoO/0tpuv9K6pVNRjGih7kvpoybQ8lhtr/54otJ5ryF3dKIcM4No
	B02SRlTlLREQG1EeM7yoqkECdQn/ZG22+4HoSd8jDBn4A26tznEUz6o8=
X-Google-Smtp-Source: AGHT+IGWgZFryTvbQEfzj3JsavMzFoFExpg1aIjajV07MaP4R+0EXVOn6LPyfYjxRCyNxZA4kryrJUyJ/SpS825l7GjAM0x5LOEH
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3d3:f040:5878 with SMTP id
 e9e14a558f8ab-3d5cce2c7c9mr76000105ab.21.1743136984504; Thu, 27 Mar 2025
 21:43:04 -0700 (PDT)
Date: Thu, 27 Mar 2025 21:43:04 -0700
In-Reply-To: <49c26b3c-cab9-4ee6-919d-c734f4de6028@amd.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e628d8.050a0220.2f068f.0057.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com, 
	netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
Tested-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com

Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1285fa4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121eede4580000

Note: testing is done by a robot and is best-effort only.
