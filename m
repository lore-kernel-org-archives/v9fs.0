Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D318FDCE
	for <v9fs@lists.linux.dev>; Thu,  2 Jan 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824084; cv=none; b=NqUpOU3ta1eNFAS1HgabtlGDNWcjuM+vCW5O+dGJd+hKfDHya4MSQZZJBhn4u2MM4nshpa3NW96bvN38NiLhDo4m05967wZ/SDWn5Jt7ff7u+kFYYbj1jUwQoWfZ6tHQiwqnpV7ckkcxXVHWbXtXmdvuVkISp2buWE7Asbd3NCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824084; c=relaxed/simple;
	bh=1l7KX15v2hYO7/BBaaDy1ajQpfzIODpddRxH89eCA+s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PWkYWTBCrieRWI1PVP7yPvVs2+R+djjvOJQ2VBmmHI5VBaEu/fNGbSPjp1qd5FepnU3SBbpBtJmiCqnnPvZgeILw65x/p4aIE2/veSw/U9pGI54uYV1z0RzMRwFXXk6GDbjyoEooGvZrK/elFxdV75NkaR8G7x4FgSrrf111xdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a81754abb7so204153225ab.2
        for <v9fs@lists.linux.dev>; Thu, 02 Jan 2025 05:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735824081; x=1736428881;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gzITfB90HL1YElQpTmVxgwkKnzL/0uebWHg4c9jdHU=;
        b=dJfzf2GA8vrfNudRY2KJC5cA2BAIAXgSyMw18W7s3rTYkYdn6jYjRaW5eoXWkn5h2a
         imi+bMiZyviCVRnx+PWbALXXUobITr6TLcY6ZmrJHlUYSE06w0lX9LW9H90Qhgo9QwaN
         GI/qcsEVCPv+f9O0qHyzuEp+CeYhnEBAmIi2roZNoPbmpd+1rAuNb43n2henYgQ0vXgJ
         PklqxkkVy1RvULj1dtcX5/FeLVjogA7un4STLp5qSHt+HFL73bLbcEkJbl3oyLoWDV9d
         ymRvqiSqprVMzWlSsfClwznidYsUo0MEBEiiM7sbDv8SLfr2Jtm8lBzsS0olVCyYTDVh
         DesQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrKKxo15H9rhjycPZsc5bDOwBgGYCZqeyAETmFcJUFBZ9OVYPi6lhyAFL3u5xkuCYFCz/I@lists.linux.dev
X-Gm-Message-State: AOJu0Yyec1E+c+YbE+9B/MYnEIRX0H6TgBhULlVLLCWyQ1Pvs6B7raeT
	HxPMHIPnf9R3wEf9alZhHfmS7Bsd9TZIg6CVLicPpULmZuNYeSwAD51XQtRBGsG6Z4+6BFelhoO
	vYu2FkKwJItypEo4Hh6QeuOGhtQ/d88IZsVVDU8+U9YCyt0x2Ae33vkQ=
X-Google-Smtp-Source: AGHT+IH+Wbk8vTtiHPu4GH2M7NjdzM2GBWwotevvFiQGLtK0BGPJ93iYRSObryn7/gVaddOgyIRA8wffcgHqkRroS77HpmEXlNoR
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:3a7:e732:472a with SMTP id
 e9e14a558f8ab-3c2d1b9b8aemr357409875ab.2.1735824081559; Thu, 02 Jan 2025
 05:21:21 -0800 (PST)
Date: Thu, 02 Jan 2025 05:21:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677692d1.050a0220.3a8527.003d.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Jan 2025)
From: syzbot <syzbot+list75d45855cfd4822a17ee@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 33 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4079    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 46      Yes   WARNING in p9pdu_vwritef
                  https://syzkaller.appspot.com/bug?extid=94b73a3e8ea625efcd05
<3> 39      Yes   WARNING in __alloc_frozen_pages_noprof
                  https://syzkaller.appspot.com/bug?extid=03fb58296859d8dbab4d
<4> 25      Yes   WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
<5> 19      Yes   INFO: task hung in v9fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
<6> 11      No    BUG: corrupted list in p9_fd_cancelled (3)
                  https://syzkaller.appspot.com/bug?extid=15a08eabe3d3838fb641
<7> 5       Yes   BUG: stack guard page was hit in sys_sendfile64
                  https://syzkaller.appspot.com/bug?extid=752d89f7bf8e6a664e8f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
