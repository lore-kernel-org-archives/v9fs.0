Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345319E7F7
	for <v9fs@lists.linux.dev>; Fri, 29 Nov 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900507; cv=none; b=cwGTacJgp6CgySY1zOYWyBIfegB88m3ZKvQcH9MZ1R6QJ4qI15CazoGbVlxgvYmsSaJjNFlzB7jM7WD8sl0zT/MH4E5mUOcP8RNV27L+Gj6sYwFxf7tl6T+3fEEkJaPDuq7BQ47Ok/wqIyrkPk3FeG1uxrZDSiOKr4py63aO5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900507; c=relaxed/simple;
	bh=GnhFjpEQk2QTU3xMRMxYSIU7Dc+xnhMFHvUYOX0FzPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oKzUsqGZ+ynBSJJvEIeewL3nfqrnlJEgA6aatNwH23QMPTt5oNlfrqDBPbxHFedx2hxqlJlkOTBpj7/uzqlvg7h0ebTvv4OTy7fFefsuAM70fat4cE6cQJkcgruv6ugD/FSsdwA3urQNf1rmTmzYRHmgyMuTQimOzEaKyLhMPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso219892639f.1
        for <v9fs@lists.linux.dev>; Fri, 29 Nov 2024 09:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732900505; x=1733505305;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cabndGigWtS979m0rIc0e06+sfnwrdqk4oGx1hUPQVw=;
        b=vr9cZVmcsBw6GbPBS0l6UIV9PQl4WPEg4JyDD4RFONFeqeUCE3FVBk/m3v80Usd2Nn
         A/qmekWNHiO9LNRqBmUZCaHHJHTdb9PeuyiTHHv9jfFp7c5nrE34jU4zE0WLfk+NF0Wb
         jITTdmP6CElEMJneCOfJb0pUu2LGDm+QvaXd8MZ+FnMrOAtOeCADI3DlGiwq1I4LPSS3
         oNny3yTdhHJJDZHwqZmbqtxV45CYXR6nEMGtIqw0uRZ/Toprqsg5raob6MvKZSYQIInd
         Pn9jy2DOrp44n8Hl5r0cnnVG+ThTicCBav7d7oyYCqKNZB+5r1LVyp/S8sqFbuCEC003
         697A==
X-Forwarded-Encrypted: i=1; AJvYcCUD/0F0YowIEv8TVNC0A47U+23d3DEY5BEvO7HBs4XTU+Va0KPn19p/b0WtdQURKjWMAZk3@lists.linux.dev
X-Gm-Message-State: AOJu0YySC6vBlcTzVTfeviT9idPWE1vYeyzc6TuDQfv1ctnFyMzURJ2Y
	uZ1KrdsgTzjcLQPlU7/IygCEA78x7ouGejq0HOaoJkUlMR00+Ny0k+Y0YMRbaoI5LIg8tf5AClY
	FWAFo/4QreHIKfpF/IFewbsiiMUTRnwYQaEZjC4oNuNWOlcL+Sa8/MF8=
X-Google-Smtp-Source: AGHT+IHe8uD7Va/t9RghiydunC7nRHm/GXM4J1aMUOaYHKIypML+ORhOP4P4xsuLh0/azcIVXHk232/8no/NPRjgk/tTxHq54l6N
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3a7cbd23d37mr83760205ab.9.1732900504111; Fri, 29 Nov 2024
 09:15:04 -0800 (PST)
Date: Fri, 29 Nov 2024 09:15:04 -0800
In-Reply-To: <4020304.1732897192@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6749f698.050a0220.253251.00bd.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_read_iter
From: syzbot <syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com>
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

Reported-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com
Tested-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com

Tested on:

commit:         2aece382 netfs: Report on NULL folioq in netfs_writeba..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-writeback
console output: https://syzkaller.appspot.com/x/log.txt?x=159cf3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=225053d900535838
dashboard link: https://syzkaller.appspot.com/bug?extid=8965fea6a159ab9aa32d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1328f3c0580000

Note: testing is done by a robot and is best-effort only.
