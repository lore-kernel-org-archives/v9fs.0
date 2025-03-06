Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9961EDA10
	for <v9fs@lists.linux.dev>; Thu,  6 Mar 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251846; cv=none; b=bb2GWJvwtb3l4Zey3AtNjcx5H8hxEMS4khEog2newBiv3YQvQ3ObodTZVKN9mkTJQpBCbwPY04729Bcs63XCo02qVSRzgRTpQ0J5oF2t44KRt0QAI+mkF8csWtmNPShCA2VwD7nv61uoZi4KcpdVVBAWlervxgj3gCyqjQuS6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251846; c=relaxed/simple;
	bh=ruAfKKuJv4D//haITjZ4loefKlVdbyEM29MI7QA1oWg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oViZGK1HNcOx33YVyw/bZKWBoBopg92SGXVIDWZPo+sQUdAu8fZDBLgmoxZ5rM6KoLKQA970nZ9mDvBoC3ZbXCUOFgIHGRgSf+9t+FULDN/BiIzMflpWsRJ0GkdpG70ydA2HDIc9uJQZzQDdpnWKr3eqGj3h8XOuL2eVl3ybrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d43c0dbe6aso5171775ab.1
        for <v9fs@lists.linux.dev>; Thu, 06 Mar 2025 01:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251844; x=1741856644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PlUf2EDtc8+GWdOxIDmfUU+aGd5sbW4hhN7UakkYqw=;
        b=u51BLl/2eaPJ9rOdv+Zxjl8gnpSLaQSGqOwtJd7K96UMOKxEYYETiDvvxZX50zdfRb
         b4oHMOE/Y1YTPQJ7/YFzhAB63/Jsi8jSDFEDXtzay272fIaterBWcz6mJ65r+EkC9kRx
         +zRnPsa4LnDL2JJn8aBGkQtQYCAcU2NEmNL9ieaft4FbNYK2GRzSniKByptYyCjYTcR3
         yfQK355itwQOfbCcGgM7JDU1lxKcog83GNSGJiSPdiYMb/eAU6A7v3P/R0IKzkt/bLEy
         X1X1nIH2mCB9F9y/tIhgim3QEQgV4l4cXE+WMJpq33znpQuFSFFUnSh1ar+EU06Qy0Bw
         OmTg==
X-Forwarded-Encrypted: i=1; AJvYcCUpSwUCxK0gGO9gyLNTi1o1lLVvzM+840w2hKt5+hZxWZ3XmqbK4GriAcdmbdryieXlJ+Y9@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5mqGFYDEnefxu+meoJybjIzdzV/DWAC9WOLxqMQWlTC4PFJkc
	aaovgXuapDImJz13OWIh+A591C86BYLNdbLJJOkjlym9qv5dkv3VOwAkdlLvLo9GGjr5DnP0xK0
	OAJAPZWth9kUWMw2Ch/0o8YSrLbzW7WBfVlrYM4JMZek+Cuf9sITe0W8=
X-Google-Smtp-Source: AGHT+IGTBLARltXQf7oengpyI6p3Xjnj/feG2ACDCutrMgIXebFL36ZwMXTWYi4jeppRR1zG6cu4U/sqPkb1QpRrtRzIkxgmvrIo
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:b0:3d3:e09d:2a9f with SMTP id
 e9e14a558f8ab-3d42b891005mr83529435ab.8.1741251843985; Thu, 06 Mar 2025
 01:04:03 -0800 (PST)
Date: Thu, 06 Mar 2025 01:04:03 -0800
In-Reply-To: <67a11d8a.050a0220.163cdc.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c96503.050a0220.15b4b9.0030.GAE@google.com>
Subject: Re: [syzbot] [udf?] general protection fault in d_splice_alias
From: syzbot <syzbot+a9c0867e4d1dd0c7ab19@syzkaller.appspotmail.com>
To: amir73il@gmail.com, asmadeus@codewreck.org, brauner@kernel.org, 
	corbet@lwn.net, eadavis@qq.com, ericvh@kernel.org, jack@suse.com, 
	jack@suse.cz, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	mjguzik@gmail.com, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 902e09c8acde117b00369521f54df817a983d4ab
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Feb 3 21:16:09 2025 +0000

    fix braino in "9p: fix ->rename_sem exclusion"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d77078580000
start commit:   69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a6d4df5fcc342f
dashboard link: https://syzkaller.appspot.com/bug?extid=a9c0867e4d1dd0c7ab19
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125d0eb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a595f8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fix braino in "9p: fix ->rename_sem exclusion"

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
