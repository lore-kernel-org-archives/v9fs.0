Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE41FC08
	for <v9fs@lists.linux.dev>; Wed,  4 Dec 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277065; cv=none; b=k4zNb93EZlL1LCopZDa9xy0b7toZ5tL2J9qvidOksqLqppwuqqsb3xI2NlLBHam+rQ646+A+YoSmXO+R7mN3I0e+7NpIXor8A6gsfBaXBeh19+Gv79sAjejmg5kv8U9Ux+CJsLwyI61bYHBoh2hMv/Fdg3SQLuAsuv74We4v8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277065; c=relaxed/simple;
	bh=rWtZF8Dus1RjbJZaZTLBXSr66OIKeFm9TueYUIt7Zoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kTQ6+qpk39IJ7NuIrHvJg1ZLYBMH5AprVMBtywekOBERulEjgp59xOYWXtpHA1o5iA5Ro4F59yCYycWcUP3psGU4w9saJtLV55Uxdf13GpMU7I47NWsdXU3T+GrPJMTLjh6l1HDfBhcjlesrbx12O6rS/t1baGf+qV66NLnYzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e1e6d83fso89656245ab.3
        for <v9fs@lists.linux.dev>; Tue, 03 Dec 2024 17:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733277062; x=1733881862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojyRDzOs4L5r1zvt5rLALFwRhgSLoRI+YAka9dryW2U=;
        b=UV0p+A8TdrRBQNz8NtSIFyfbUYKuxpftQwKYZTWyYVWZCt3c4WzTEvoMrYrRc/Jju3
         NRPnyhI/fT6/Fqlr/5xPPyAlFoLM6+AfnuSc+GqeNjORipr+ZRPDOkjYi8bekxRMS9ry
         xVTpmAepNKMxxivez57FYQYyHFZg7k62jxQs1qMvmlYJPYjVuh7UH86/CnsP7KnBu+oN
         m8UCBE2C2nWjd2pQaG2YI3FTIi1ONIUjdl1cSiO6y/pRFYpBnkAe2zdy3o75K5zuBpdC
         J4vSqFQaVdlKHBl482DsOQ755TyioQqdjLZFqpn5Sur+QXvHaPlXnvNJPYNBphIt5lyq
         o4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB7oFbKjJKzGC9FkVzspHlVySrhX4QmEy4ohOfAHYqSYj73EMCq0QnPWn0c7JWf1cclwuO@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd9QnWdU5yPM9/pYMbW7wLwZYyY3IXz4ouPjIu67BPu90zdb0v
	bWIQ2HaDSo3WrNCybU6XrEy61jyb3khMU5uZLKWbAGh7Z9XbPCTEv03MX7fSgNXRlSa2JFruHJP
	Aby3vqdf+25wAEdZ0FLblKaiqV4fQgwhWtAHeS/1m878Ce/d70kTnfhA=
X-Google-Smtp-Source: AGHT+IGmDky9ubXMdmWEyJvsqWfLs/KF8vdb5UnF3UfBT6VPtkSCq7Mi1MPMv2mpAS+sZb0fM/xrpgyQuWJKEeTuR3Zk+AqaSlPn
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:3a7:21ad:72a9 with SMTP id
 e9e14a558f8ab-3a7fed5f51amr26749215ab.17.1733277062597; Tue, 03 Dec 2024
 17:51:02 -0800 (PST)
Date: Tue, 03 Dec 2024 17:51:02 -0800
In-Reply-To: <589149.1733244622@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674fb586.050a0220.17bd51.0057.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_retry_reads (2)
From: syzbot <syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, bharathsm@microsoft.com, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com, 
	rostedt@goodmis.org, samba-technical@lists.samba.org, sfrench@samba.org, 
	sprasad@microsoft.com, syzkaller-bugs@googlegroups.com, tom@talpey.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com
Tested-by: syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com

Tested on:

commit:         12588c3f netfs: Fix hang in synchronous read due to fa..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-writeback
console output: https://syzkaller.appspot.com/x/log.txt?x=135e1fc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=5621e2baf492be382fa9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
