Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0221B2194
	for <v9fs@lists.linux.dev>; Fri, 28 Mar 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169745; cv=none; b=ckuV8AumDxl/9JPhorHQ4ZmpF1B0eYhYXVk4y59pop1r4mT5nIkEUUBAW7IYJdAoe5Bkff3vdihwDxVV14qIsEJ3G5BAvNpdR6fwTHRblVuYvtzesDZUHm8P92VoRU9rwwGbwXqPdpIz/H7HvJ3YQABzvh8S8YJ3ZDcZG/oyc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169745; c=relaxed/simple;
	bh=ksFQUOP3EzZfL9D4/0O2XSC5+UR6AEx8dV1lPhH8BeA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jDJj0jzXEHX5fzZggtDWnMbLdi5gnzcQhxSwZNuis+1a+03t7MpOdDeUlGtMG+uQM+dA2CAGXvSGn0RkFP129lXlSoR9UaFE9tpC9G5TowzgITrcJcgnYPHbBDC4YI6In/9yjn42YcwX5LkgDKwEmQgdzlfyTHvZfeRtkqsmpj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43d333855so20620065ab.0
        for <v9fs@lists.linux.dev>; Fri, 28 Mar 2025 06:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743169742; x=1743774542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZccP94vSlfyk6BXUvEnclbkKMxBWU/FoFWjWqAr+xSc=;
        b=WeToSaOKi/i9X9rKZXKoorTpya38Pp5j9XgphepmFbmrPvGlNdmuPL15Th5ThDXHu5
         j84vnxQeLSr9qJzhZdt42u72ZksNLTuzJMUQsaIPeM1JUvtMoJQV+3JYbdCLaC5c/tTP
         ku2YEiHw9emp3Bj383AXLHklFTRH2bs8xB7z/D45KoR7J2ctavkXHfbXtWexzPKr+emP
         mBcQyeiu2ZgIQrOnAEQU+Ubm0QDHvSosiGZJ2QvP8PkQMx3dSltLsDCyJxnQD6GD5izT
         zrVUXnw8cY1A5twGNKmC8/1Fl4b+RKvrch2urX+EK/R3vR5otiYQ1H4WYtd+8p/NW0t+
         OC+g==
X-Forwarded-Encrypted: i=1; AJvYcCVUm3XMhdtNpQXLROgxheRT82XNT9Myw7BOHnOYiEoKiLo5/qUj91IOxEDsPDfps1o8vWh7@lists.linux.dev
X-Gm-Message-State: AOJu0Yws0S+rcQYjmebMdLpeDWwqgggW+8IOZW4/DaMJwCJYzYnSIXHx
	P56t85uX137BAA/Z70M6c3Cuispiitc7ai39ahZNlhzfw1eWp8VYwwU1ToXYRJCbMZwekFLK75K
	FxbRUcQtkMpHAfwhbr6wKC5alWPJs+R+gkVQNRcnzo5cgQ43SLdq6HSs=
X-Google-Smtp-Source: AGHT+IGwRYua1iETzdd0MEmIL3HDNfodpZ6kzAALmumare+moQZbATVg3Tb/phYquDGYuvTGiVbb0t0/KM3tnAOm1426Ww8zs2hT
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1689:b0:3d4:28c0:1692 with SMTP id
 e9e14a558f8ab-3d5ccdc1e0bmr85604945ab.5.1743169742505; Fri, 28 Mar 2025
 06:49:02 -0700 (PDT)
Date: Fri, 28 Mar 2025 06:49:02 -0700
In-Reply-To: <20250328132557.GB29527@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6a8ce.050a0220.2f068f.0077.GAE@google.com>
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         acb4f337 Merge tag 'm68knommu-for-v6.15' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bab804580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c3bbe7ce8436a7
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146b9bb0580000

