Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7A20A5EB
	for <v9fs@lists.linux.dev>; Sun,  3 Aug 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222944; cv=none; b=cpQIJJoDGSNe2wGSWmM0cnxl91B3fmjPFeXjkRRRWwLBVr1MLdZvRwXDZCG+/OLLYXkK2sU5zh8XtQPfDq0v9F134DPwWwT4fbBC8yb51kmAqln2BwB3gIEOHdoxmqXUBC0nSXXgrghUutpERFSw4Ekyo0Ts3v5KB4GdFwDajik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222944; c=relaxed/simple;
	bh=+BxCQVXtTe+xoz4eJ9sHAveL3+qt5++cybtEn1AaG/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l0UJweqXPXCuFM/k4G2gkuyOWVXchBElNuGT5JCm4FjiiQAmBoWa+08sRv3X8OB1aMMtUn2/NyWFkaF92Yy7PW/NzSSkN5j+L9SGGD7MvAiP8Bm6tugsZO7bLj+Lic0wFwvsBc058g1MxzqcTv02pNTrwy0pCuGkp8M/RgtmBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c056ae7c0so663693439f.2
        for <v9fs@lists.linux.dev>; Sun, 03 Aug 2025 05:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754222942; x=1754827742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5+xCIY68eQod8HShjZie1OqXUWvIMyxZ5G/valhey4=;
        b=CP77nItcPaFsph8a3DvWYNc1lrRRE6STPrQCxUbCv7oAC9zim1n2owTS1JgxjoK3+u
         YRvlBMNXnCFl0bwN/+JOh1i7iCFNgMLT2zghAMMMj5CI72WFwoJ5aUWyY87sYGBoW8HH
         LBXW9kfDFj6b320n9SFgVZc+nCSy8JT5t3rzlq5Zqctj9dWaQFe7UiecVj/vJ1T4VXau
         LWKuBjtxnC9Zs2XSDf7u7SFuIWs7M8aYNjiGYfOqFueC2m8Zv/CmQN6wmA8cVfyqER1i
         yQQvi5hZ6HUeE74aBFEl6Zer3ajxvE1dsPIsxeSNTXXn9JXibKSxMC9SSBDnJpuKFlth
         VM0w==
X-Forwarded-Encrypted: i=1; AJvYcCVP4ib0qKHTSG9CBWj96mleDTp6bSCx0RsEtLlaldfTfRHeTc7fv3g8T1s5JboYgwcbh6wh@lists.linux.dev
X-Gm-Message-State: AOJu0YxdBN5f4+4ndhnO0v0vCtofFvyMvbOwvzifTcUEiNjWB/X1/rM/
	b5SJFWEClBPIDpd/DazQM5i5MFo5uGE3OnHCUSlTDy5BtVgXuTOTZUKFqjkWFWwkONXWFKySIDI
	XVKAjlhbTBwDXiYUmDNJj/SZcqeZsh15r932YUB81Cx2XfySKaaxz5d+jCBU=
X-Google-Smtp-Source: AGHT+IEI73yOX7LuYSonRTZStd7VDhDxkqzJkzexmNHlJCJ1YhLhqOvcqAg6Qh64hhfeEztD7/M6cYE5zqbG4QmcfI8nTwAfsPR1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3303:b0:3e2:81d9:cbbc with SMTP id
 e9e14a558f8ab-3e41611a082mr111370915ab.2.1754222942254; Sun, 03 Aug 2025
 05:09:02 -0700 (PDT)
Date: Sun, 03 Aug 2025 05:09:02 -0700
In-Reply-To: <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688f515e.050a0220.13f73d.0000.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	eadavis@qq.com, ericvh@kernel.org, hdanton@sina.com, jack@suse.cz, 
	jlayton@kernel.org, kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	mjguzik@gmail.com, netfs@lists.linux.dev, oleg@redhat.com, pc@manguebit.org, 
	sfrench@samba.org, swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit da8cf4bd458722d090a788c6e581eeb72695c62f
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jul 1 16:38:36 2025 +0000

    netfs: Fix hang due to missing case in final DIO read result collection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cfbcf0580000
start commit:   66701750d556 Merge tag 'io_uring-6.16-20250630' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e29b8115bf337f53
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1400348c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b2048c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: Fix hang due to missing case in final DIO read result collection

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
