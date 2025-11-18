Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAF2FE054
	for <v9fs@lists.linux.dev>; Tue, 18 Nov 2025 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432044; cv=none; b=JqhM2HqsCMIuTVzhcNQdVwnue21MA5C46YfHhY/QTVyKH+HfS6isDsNj1XycwatCAxcEATx7DMFYgNnpxGJbbOwNhpElXBjC3rtTiPamuu1nMpmoFneQiKt076EcRiA0GdjRK1AH+dlLLXZHVq1Ii9PDu3L8oGAGC2M22zigE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432044; c=relaxed/simple;
	bh=dlmLF9eDqvRRwVwiR5uf+29W5y+IYOOawXUUlO087XQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IeNOT8CmKvE5iyavS3VLEmFKpgVzlpl/2YSiPLPMnXGEe9XiJxC7zLRdThV2RIE4mc2uZdM26qgJy29boVYbflQuFbpx+gqwvCHS6SgbcphsP/zTZNn+YrtRdmLjS2wKBsN7mWEoJ2xrqSIvvMOF87lhCLhVpLsfaUZ5K2moGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4330f62ef60so46824445ab.0
        for <v9fs@lists.linux.dev>; Mon, 17 Nov 2025 18:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432042; x=1764036842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38d0v+KJD8xAtevmblqmnkARv7pP13aeIOvfmJ6jnQY=;
        b=pxTOkTqrPdsxR9BVtNHz8cAmMWfZ2Wrr1XFf+My+8GWq+dkPch+uDYaaZ70B6D/dB/
         Wqwq9yR5I6ygYMtdxsYDDKYHftVsgTKknFAb4qpMRxcG6qdwswFU3wf/jR/wpONEaSwE
         Hb2zX9M0s2Spvjtq+eTuwGq+p20PhvFb6uTyApPvXHunjgdo45LnRWg3GykKSNhO5M7Q
         Db/NSuEilzHUwcxeQ7UEMNymCnolITPVJVDNNEDHJtNNKA9a3iGhbAuf+hfpjdMTbQHg
         ySsbqkgie/qW8ygLFDFSbUPHSBeEAsssvHKs8dsk6qiDfisgCjTcXlDhrweewC/mh7QH
         6ZVA==
X-Forwarded-Encrypted: i=1; AJvYcCXIKlkV4F3ev4xPEK3do+bp7Dbu6AS/jTb12ax1JmrG0q4MwcXn85MwUd3RLM8seefNJx4A@lists.linux.dev
X-Gm-Message-State: AOJu0YyaVDEzOu89YqN015nNtBWn+SfrCnPIun2g/V49sOXsz4DTdMWM
	VMI5deah9HYiuYuTfHIcywmyata/yMje7RD5ckldnCm2nqTWhUEvk/K3RroxPmHORmm8JHtuRsk
	w2kuScYCrCD+amGAvNWgliqy8KTD98cmfy5XPe59GTPnxlH2Sq7q5bU4BrRA=
X-Google-Smtp-Source: AGHT+IFBUrrhbVFmKD5i7UDUk4WTA1wRjO/D0/QhptYo+5JEOIHbdSkHvUII8FHjV/a+Sjfbpfbj0VMTYwFBgMcrzlv9n1t7/Aqi
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:433:3048:55ec with SMTP id
 e9e14a558f8ab-4348c94e241mr181458615ab.27.1763432042151; Mon, 17 Nov 2025
 18:14:02 -0800 (PST)
Date: Mon, 17 Nov 2025 18:14:02 -0800
In-Reply-To: <6751804a.050a0220.17bd51.009a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691bd66a.a70a0220.3124cb.00ae.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] INFO: task hung in v9fs_evict_inode
From: syzbot <syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, max.kellermann@ionos.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4d428dca252c858bfac691c31fa95d26cd008706
Author: Max Kellermann <max.kellermann@ionos.com>
Date:   Thu Sep 25 13:08:20 2025 +0000

    netfs: fix reference leak

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1478fb42580000
start commit:   4871b7cb27f4 Merge tag 'v6.16-rc6-smb3-client-fixes' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=12b5044868deb866
dashboard link: https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d7e38c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132ff8f0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: fix reference leak

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
