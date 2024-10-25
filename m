Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C021171D
	for <v9fs@lists.linux.dev>; Fri, 25 Oct 2024 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818848; cv=none; b=VE13k9fXFRaMYpyJ7u68Bb+JYuXNQ0o3CvT76fW3mYRujr9as7cCy3NA5bmbiIZuLqSrzOtRpdEymbVIHIkrPsGuVa9OYq2NJobNRc5uIp9ulL5BhCjZbrY8vv8fupD4eXA65GDV1ePLTGqWdzsaNaM8PNx9w5Y5xZ2NqzlidNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818848; c=relaxed/simple;
	bh=pDpDrDPgqn1rWuPf4vWJjM/QhwM5DXeysn5Qug/olq4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dSsY5IytLgZUbc/MC87L+ykQrgoQzmEjQxSjvc0xRj1pTQgwtZXXopIdXI9R8fV8d/k2xBnHtt4duOETZ4f8jR/Ha6qE2L1rqfLTZMV0Lay0tQnUgke8YqVzwwVk31nQS5x0QtVim7P7Hw7tyVdZtpdaK3QmQcp5IHc2G8n90ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ae775193so15436585ab.1
        for <v9fs@lists.linux.dev>; Thu, 24 Oct 2024 18:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729818846; x=1730423646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOZsZyIJmZeHEQPVNHkWmGsoWMx76fs5Fvyz/nsiQgY=;
        b=BFDBcxzRkYs9WGXaEOFi7omzQMRjyay3I123/4NF8sZT6wgTqunQFidClly+W/I7XV
         H79FOq8XlsEkKcDX7YXEG3Ex63GWG/sSZxEmIhHzZ5fu69acqKktx2Th4+uEuTcMVOVT
         3UXKsBOmhcsP2ya5tkbWycw+8SNSLvLYtMgCSHfS+jAfEgWrq890CSTAaG/LTVxYYDXt
         4UjfNEObDzBHGCXJ/ROySd/F+jT/xmUa6WNDcfK42ilQKkhSeG0+PQ4TNHtRMZ7mMt8U
         srKiJc7JKMCiMMNDa1+QT2Z8srvuVCbHmixNUcZR0kRp3BA0gTiJ3NPBgqLP1ca7QzY8
         nieA==
X-Forwarded-Encrypted: i=1; AJvYcCWtBv2YWipaBtz5V94kg0P0EMQKQ3JBAZC5Hh+n80hPKWhhciNjVkXQV2v4A0eNqiwOmt8M@lists.linux.dev
X-Gm-Message-State: AOJu0YzmBrM6SjZEWS6JQHlXEF5dtIzviFi/3ZNiJvThPHPPVMSBU5R6
	plMjS6QeIyUljh3KniZhBUyvLN3ZQclJBrigWW8sGWp0l9J7NLGFYuR+t527oMYVR9t8yftheQp
	d1dyAFS/JX5E0SWE1yanyAffk5fSZ58pLtChc1EDmQ4T3Uf6OEv+DMKk=
X-Google-Smtp-Source: AGHT+IGOjltPBrz6CEsrXS0y1SoDlaDKKPoKA5PSdGZVz6ycSLBxXb8Nnn0qnpjr6zRJ+fl8sGud8IaiQJe6+LFu8+phyUzjp/zo
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a4d592fb67mr91969855ab.2.1729818845820; Thu, 24 Oct 2024
 18:14:05 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:14:05 -0700
In-Reply-To: <000000000000a519120616f973cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671af0dd.050a0220.2eb763.00ce.GAE@google.com>
Subject: Re: [syzbot] [fs] INFO: rcu detected stall in sys_mount (7)
From: syzbot <syzbot+de026b20f56e1598e760@syzkaller.appspotmail.com>
To: andrii@kernel.org, asmadeus@codewreck.org, ast@kernel.org, 
	bpf@vger.kernel.org, bristot@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, ericvh@kernel.org, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, juri.lelli@redhat.com, 
	kpsingh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lucho@ionkov.net, martin.lau@linux.dev, 
	peterz@infradead.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	vineeth@bitbyteword.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126a5e40580000
start commit:   3b68086599f8 Merge tag 'sched_urgent_for_v6.9_rc5' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
dashboard link: https://syzkaller.appspot.com/bug?extid=de026b20f56e1598e760
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1775971b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1290b320980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/rt: Remove default bandwidth control

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
