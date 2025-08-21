Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5723C506
	for <v9fs@lists.linux.dev>; Thu, 21 Aug 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749168; cv=none; b=iijUXa0eYYRtAJ8vQlmUEZfZkj3QsIc/XzruYaX4WxtzkbWuDqM7ABl6DEASPutoW1JG1tPCteQfpA7V24wHSkqlYEAta4oUbbaXV74CDulM0/tRvReqWOqUlTHCJyKbcVbj6ycIXJSlorJPszIQMHKjsFOIfZLwKBqHdz4sRSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749168; c=relaxed/simple;
	bh=CzX3JaJ7NwONLAn2TTeNBMK6lIbHD9i+uC1AXEIdOFg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FGSTamnYDmDwqavcuv2SL0dx5Tn4pr7Jq8oroMKhZA0B5vB4Q2JxWE4ghtQsNQh82N0UbPcP7JX3ktfIpuPUvb9NcCkrfkv/8cVPBSuoD1Ra7Vm2u3idJytjjjfgEI/OVhjHpltvfN96mC/t3qykpGHtJvGi94vpuwwNFxK9DIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e67189ba24so6802445ab.2
        for <v9fs@lists.linux.dev>; Wed, 20 Aug 2025 21:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755749165; x=1756353965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcPZ7h1w38XKs5IO8/ha7JNh4WrNn3KTQrDcAx81ZOg=;
        b=kHikZlFEsG3gD2EAEeSqLpe67f9FxEzfwBnZJcRXHG7BH2t7XUPi8FoAWFID5ZfRRT
         /7Ngu7yx6RegjAX/8hMGym96ac0FtgmBG4f4pcIjLV+omUYyQgwlJQp47ZrfbTovF1rS
         wvXIgR+XE68MxoTiDcunxZn8pv5IphTiNSb8sGdIGZCZr+4Qu+xEroC6qGz5j4xuuJBg
         n9mhDePbEotLTHhvoAa9M3tL9zIB8hYdvl3wT7ha+8Ctn7AEjtgJ8eGkQCpx6TWPcO1l
         CpMr1AiW/a04E9BNkCnU30Q8ZyBgEo64gPeNz6Cb+VQaGcCv+FS4MUSQpjlSfBL8zE83
         SmwA==
X-Forwarded-Encrypted: i=1; AJvYcCXDQt4Lv+8iVlJcUe/BrCBfrvrGkwu38Jt2bFyqqnEnISaf4suUouOUhZkkHy2w4RlV3MkG@lists.linux.dev
X-Gm-Message-State: AOJu0YxM80oi39Sxqgj0qeeznfLYrukX6k6IqN3RTQ5O5bjp9V1GSv3A
	wuKVk0w9iCRYwuA6oy3GvNW0w5PMVn37VgPzcGi4gQeD7MnqtIjLdc3RBYp0xqEyQ1G1BthG769
	Zvt4M7LStZWi489vUpzAXmejV7zocCcEKKGLXNzOJdcBNbzuET/OB/TjWWmk=
X-Google-Smtp-Source: AGHT+IGhvQdQ1rnNUg7em2QGQiFzvqEhT3LwDf6es0ungmVDt4/JphxGZD7eCFZIEomXzEnT23TdbSP+cmIP2cVrADIEKOeFTSIe
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b49:b0:3e3:cc1b:2b5e with SMTP id
 e9e14a558f8ab-3e6d6acf0c9mr19983935ab.15.1755749165619; Wed, 20 Aug 2025
 21:06:05 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:06:05 -0700
In-Reply-To: <aKaW9bi5INq7OwGy@codewreck.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a69b2d.050a0220.3d78fd.0016.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
From: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in v9fs_get_tree

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
shift exponent 32 is too large for 32-bit type 'int'
CPU: 1 UID: 0 PID: 6530 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
 v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
 vfs_get_tree+0x92/0x2b0 fs/super.c:1752
 do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
 do_mount fs/namespace.c:4138 [inline]
 __do_sys_mount fs/namespace.c:4349 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4326
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6fe798ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6fe87a7038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6fe7bb5fa0 RCX: 00007f6fe798ebe9
RDX: 00002000000000c0 RSI: 00002000000025c0 RDI: 0000000000000000
RBP: 00007f6fe7a11e19 R08: 0000200000000280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6fe7bb6038 R14: 00007f6fe7bb5fa0 R15: 00007ffebc4cd908
 </TASK>
---[ end trace ]---


Tested on:

commit:         5303936d Add linux-next specific files for 20250820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156cb3bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2619a6495a03d773
dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fcd442580000

