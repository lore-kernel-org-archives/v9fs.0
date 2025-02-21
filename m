Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02220DD4E
	for <v9fs@lists.linux.dev>; Fri, 21 Feb 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144005; cv=none; b=SWvC0Q+R1s1egRhe/W6KynaFNkr7d55eroBUsvbkXBYq+TMO0mTIp11ItL/BpL629g2fUvDd0+3u809Gqg7jE1hGKDm6yu/jecOFcNpIbfv2kTbBobhaHa4D59r3vgn20aiaAV1OAd5nOZ1YY717qZYCwwoEY8hx2DU0vBn/1cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144005; c=relaxed/simple;
	bh=4vCKVNEsEgWIs64ubjYODu9ezwCabVqJz8/9mUMtinc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O6vYExR6uNmOmq40fsPM5QD02kbukanmLFAAWoN7OyXzllYiSeWq2RkNJYmPA+GBibp9gCXywckvTWJV2nEP+B9USkSA41AXQvjKyi49f62qMbaeQPcXddPExM4Pz+Hh8gw6sVq1E9zyWnbPUoAtj/gfTVXOKi0XYmYJZoDQoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2b6d933acso16249715ab.3
        for <v9fs@lists.linux.dev>; Fri, 21 Feb 2025 05:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144002; x=1740748802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKOeUNmgFq9mGFTlFKpVDLkAHhwJwc1BYdbAZYlmsac=;
        b=RFqbXYzgzMrJJwyQ1UBP77q8b33pwNub5tm3eTrqjfIg7IpTspzrxHI77hodpFsoot
         C3RKF2SJnFWx/KorW/SOjJPgZpCmX7TClQw1piGhJFvNm3Gpr3zNRRaPQtXEINEp/aXi
         8k3UJaimkZvXBFw5+8DdBjYtWeYTdeiO2EjL/P/LCuUyPgWwm8ylswO4qZrI/SoCG9RX
         meh7h43OeZsouglovEd+plNWGHiqU0A9wwpHSI28oiCC44PbZIrjbpzqGsA3IvSh7e95
         Jyl4JjqNS2vivar6P+aTvwuP3ou9tgluIV1X9QQRIypFfvUKHO10cmZfaiWh8o7wNbfS
         45NA==
X-Forwarded-Encrypted: i=1; AJvYcCXOvVLvNXF8pMM4RYNQWaWuDEzwUoKocZXm7b/rnnMj7DvqkUIXRDg+qhynkC5wQI4OiCs4@lists.linux.dev
X-Gm-Message-State: AOJu0YzUjmwlqolJ3Z6UK7zHwOE676krEmIyu8yo1mGK4Rpkwg8mfJ8G
	90T/k8b8T0HQUd/FRdUKmRrzgbnQOW49mP9o4SyYVetGWCVg2vYYgA3IZrqwmWNRnstQrYpJI9W
	wYQ2qcQWbbkE8DXAaQ5eyq9FCzTbUc9fFguovmJcmZzb8NxIGbBkuqWE=
X-Google-Smtp-Source: AGHT+IFk7iXIGjPM3Cd4yMSgfW4vr1fE96DRJ9EACQSHU1A21Wn9X6x85b6VG+vkzitZxJM+02ayoLSehtNh39Na0i/XwqFmq+M9
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:3d2:5a0a:7227 with SMTP id
 e9e14a558f8ab-3d2cb48229dmr21416275ab.13.1740144002400; Fri, 21 Feb 2025
 05:20:02 -0800 (PST)
Date: Fri, 21 Feb 2025 05:20:02 -0800
In-Reply-To: <6792ffb7.050a0220.3ab881.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b87d82.050a0220.14d86d.04d4.GAE@google.com>
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_openat
From: syzbot <syzbot+1f18c9b1bb51239d82f2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, bharathsm@microsoft.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, idryomov@gmail.com, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, marc.dionne@auristor.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netfs@lists.linux.dev, 
	pc@manguebit.com, ronniesahlberg@gmail.com, rostedt@goodmis.org, 
	samba-technical@lists.samba.org, sfrench@samba.org, sprasad@microsoft.com, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com, v9fs@lists.linux.dev, 
	xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e2d46f2ec332533816417b60933954173f602121
Author: David Howells <dhowells@redhat.com>
Date:   Mon Dec 16 20:41:17 2024 +0000

    netfs: Change the read result collector to only use one work item

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cb3ae4580000
start commit:   9528d418de4d Merge tag 'x86_urgent_for_v6.13' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7f05e16f48c5834
dashboard link: https://syzkaller.appspot.com/bug?extid=1f18c9b1bb51239d82f2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17808824580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129252b0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: Change the read result collector to only use one work item

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
