Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5845940
	for <v9fs@lists.linux.dev>; Tue, 19 Mar 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844805; cv=none; b=uTJkJhqqWkFD3MKdzwZ4BhQLr5NKQe6MX/lL/ScJN4+6ciic0GlxCbn3CseCPN8wvh9wf17bVItxV7agbxMbCZgg1jt9iS1cqNM+S5xf5GNnPTDp8e8cGLwVUMbLyLuRb/AAtfhmBhuMlzgXUxXBMRyBVEupBM7mRpcMOOGD1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844805; c=relaxed/simple;
	bh=YDzUh/eQl+mEnGxwe5Gug0b7tbo2rKGScA/OLfLsBeo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ynt6N4x9TPXiGLeXbL36ugtdsEBuSg1E+CsmferseDnf8HruuUoDwFP0UEI/EsgqlfNZdAAeDE52cMjNiRc3plmZAGAyFS0V0+WQTKa/AhIZKdmCJWhHMWHYwPBPFt+UGt654GFS+F28XQcYiqaC+3yqLo6npRA0j/lPEWJ8XDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-368185c12d7so12276495ab.2
        for <v9fs@lists.linux.dev>; Tue, 19 Mar 2024 03:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710844803; x=1711449603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cP3VvSaVvmQglW2lPvq1ZHeDi+uTFdnhbYpShcSJcJE=;
        b=oXzyC4s7ZTBt/1hyzy2tk+sLRbP62mFOZFuNl+ux6gUTN5XI58/S4coTsXa0qNKy4W
         1NjjX23yzlyuEWczgd/x1wBOjiskPgcQ5EODyCpBFJIwlwOQiM7+yqvtOp04jgRJ3PP+
         j+QutONCD4+NsqlGRUO3e2g4X7gA+foyOORZge/BaLqf3v/cV25i+Z6kXo8bvc8kTJEa
         Zj2YeqzFbITRv+pBlwUJBHTpz2Y5sNVZKrTpSZXRErKQNHo04QKdiP/7+B21EgsjTwDk
         NnGa+JSVhuoA1Ed5HWGDUPO+oyOQdOu8xbzf6dZPmhJgKpyllVwufIdfgsydXaesRKL8
         1s5w==
X-Forwarded-Encrypted: i=1; AJvYcCUw/ENrmhk/M9KA7g0iwat8EWK4T6rp91KxI5PtzIaYwTAaPM3s35LQF37m2T08GVbKzEXLMs0quvmwxovrUiWebglMsA==
X-Gm-Message-State: AOJu0YzKe7JaFzPXCM+Il6Ya0jdYTtNb6dC5kY9pXxUsX71JRjy0+xQ+
	40PN7ErV4hQ1kw4Sf6aNxv4jdjogIFYUw8fJJztLlpf+1WQN6wUI4VSk89VZOXx3eSx972UmNhh
	/XRIDI/tCCoxe4ciExzmmSAHfWGvTmttNfoa+rgO5GPlvN7+AFwgst5o=
X-Google-Smtp-Source: AGHT+IFvsG5IdN9U7xP8X/k7Ypy7CjsO9580BstBbgc142+jM/jkuItQhABSrMzWqAurMfaURsFZoIxDt80B92I2eh947/VIKpm9
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:368:4274:71c4 with SMTP id
 g7-20020a92cda7000000b00368427471c4mr177919ild.3.1710844803105; Tue, 19 Mar
 2024 03:40:03 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:40:03 -0700
In-Reply-To: <m27chy8qz8.fsf@Charalamposs-MacBook-Pro.local.mail-host-address-is-not-set>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c15e4306140118c9@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, charmitro@posteo.net, ericvh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in v9fs_evict_inode

=====================================================
BUG: KMSAN: uninit-value in v9fs_evict_inode+0x109/0x130 fs/9p/vfs_inode.c:356
 v9fs_evict_inode+0x109/0x130 fs/9p/vfs_inode.c:356
 evict+0x3ae/0xa60 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput+0x9ca/0xe10 fs/inode.c:1767
 iget_failed+0x15e/0x180 fs/bad_inode.c:248
 v9fs_fid_iget_dotl+0x375/0x570 fs/9p/vfs_inode_dotl.c:96
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0xc02/0x12b0 fs/9p/vfs_super.c:142
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_lru+0x6d7/0xbe0 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3089 [inline]
 v9fs_alloc_inode+0x62/0x130 fs/9p/vfs_inode.c:228
 alloc_inode+0x86/0x460 fs/inode.c:261
 iget_locked+0x2bf/0xee0 fs/inode.c:1280
 v9fs_fid_iget_dotl+0x7f/0x570 fs/9p/vfs_inode_dotl.c:62
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0xc02/0x12b0 fs/9p/vfs_super.c:142
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5499 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-11567-gb3603fcb79b1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


Tested on:

commit:         b3603fcb Merge tag 'dlm-6.9' of git://git.kernel.org/p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=175f8006180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d08e4cfe8c38e605
dashboard link: https://syzkaller.appspot.com/bug?extid=eb83fe1cce5833cd66a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1250b481180000

