Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E2207A03
	for <v9fs@lists.linux.dev>; Fri, 24 Jan 2025 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712865; cv=none; b=oDWFDYRAEPalCXvGMXW84pR5HOXPb499vlfjmjQi6iOGts6ZKzJUD2NRLA8azUKUEcUB0sOxtW35UDfWYJaIcYqlHpA/kNzmN+qtOvcKM57pES5H2t4XVSPE39biSWdtIMysoa1oaH5CohKEaPhg4FQ5plRyf3/QbuGO70rlbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712865; c=relaxed/simple;
	bh=noKCdvM0WlEE+MchLoX3l9C6xw5NueqLYuvYwwJLCUo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U1YYFFZ9LMw1vF3sWefHsKQOaPLi8WzEWvMK+tUUej1EfwPAe4+uiixNT5nIExA3+hkWB26zCcwvLEFotDbtE8tL3hbW3giozwF1bg3NpIAYZr1TOKutQtuYvtJVLrbI0ouFvrSW8oeSsVvLJTYjC4hH3oXYF5syvVvSr35NUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844eac513efso120135639f.2
        for <v9fs@lists.linux.dev>; Fri, 24 Jan 2025 02:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737712862; x=1738317662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gyg5A+pSRl/9vrMhTDV9sQnVz/Fz8nOwR9hSfvBXT2c=;
        b=S8CCCn9OzvFAsKa3Yt9AVg3OmOXdXl0OYM63wHEOB4o2zgTH3zKEzAEKvwpP1jWljX
         C2AMmv434sGnTqXkoseHyF9/qKecOfwfBbCIX+pQWfZG4nedKPFWEfCtFK9dGo8FZp0e
         rB5xlDLI6se6VsSZaZd9ppJHB5tQQE1wgqotliVIBxcgJfy3H19oP2YxmGv55VlIyc5n
         XuQslq03SwZUp1BYdmWipzXOWJfEXJhQRye2xnB5XbmuvQVMXQfGst4e27k/Oz7HyvNP
         CU5ByhrLSucRUMyPvl21wg6pk7UiKuKoWPCSXBj6YPBmnhiUITZG0kSCrCl3jslRheTH
         pYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR70XINqGpVPe2NyDc6k4wZ/XsUhQ40qSeszKXLW6Y/Z5l8j9ZSr1fg36tUkBApj07unEQ@lists.linux.dev
X-Gm-Message-State: AOJu0YxAJScdrmdcoqbRDt4uRKNyG1uZ6kS86mmy8e6jZA2r08HPkezh
	JiLr3I/KZfYxkgEh7oX7M7nP223Dwq3DS6Ie2CMMQZU+8/E9h92kT3XbfSg+UZ8v0jlxUELQEOl
	2jT+MMgmsm6xHlcPEG908yKbWQJ3GYSYlFulakgKFr0FSBq2wURhSa14=
X-Google-Smtp-Source: AGHT+IHNmbYX4pwyDvn2ssqUMiKuKllezhf3IxwA7NgwxNVsoz53NgR5eNMtzqywrwPyfORjdzG1DiqJiBHPvglWzLK4IFIrM6XQ
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4409:b0:3cf:ad21:b7bc with SMTP id
 e9e14a558f8ab-3cfad21b9b7mr111298545ab.8.1737712862604; Fri, 24 Jan 2025
 02:01:02 -0800 (PST)
Date: Fri, 24 Jan 2025 02:01:02 -0800
In-Reply-To: <2479147.1737711515@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679364de.050a0220.2eae65.0018.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] BUG: stack guard page was hit in sys_openat
From: syzbot <syzbot+1f18c9b1bb51239d82f2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f18c9b1bb51239d82f2@syzkaller.appspotmail.com
Tested-by: syzbot+1f18c9b1bb51239d82f2@syzkaller.appspotmail.com

Tested on:

commit:         ca56a74a Merge tag 'vfs-6.14-rc1.netfs' of git://git.k..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b53ab0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20efd0735e510e1c
dashboard link: https://syzkaller.appspot.com/bug?extid=1f18c9b1bb51239d82f2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
