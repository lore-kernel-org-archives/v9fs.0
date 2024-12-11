Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B6F20371B
	for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948884; cv=none; b=qTla43YXpKpRdiRdYHs3ME1FG+4DlhjHsEsOjeM97RYNw0msfo0q78vrBWGSDEE0EXI8AL3/y8tRzxPJW6+76nSo1dyiHunoSfwcuJZrAbvBV5FrOhUN3PE3nRnSSvOfVQmj+15lJvjsagTVgKi4kY7Sjt+AxmmtC3ffhUMhars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948884; c=relaxed/simple;
	bh=BxTkdHAwDUKkT0yu7rQNK7RCeSpDgxVH7CyMEcU05oE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rRtF0U1nLyvkpQVmB4GMtlAbNbVL1HqvhiPfPVObgzY/wN9gQ3VqqzyRko24QoP6ZQMU0oYZWxx0/3yyw1jt9X2QqN7yzsBW0dSluT++mKcOkq/4mFIXyn4spK415YMWtTQNeT0RWsk7IJVRA2Csspyl5v12mb1L4ryh6v71adQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ac005db65eso4633325ab.3
        for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 12:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733948883; x=1734553683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWvuUMY0G+wmikjDT3RK+2qc8QdMPprFL6z15qVZK/A=;
        b=pDhFnxjBNzNxoQ1zVU7erRnXetvS5wvoGLN7RTl61L9Gl5ypXVpu2b9DQXkID5+Xik
         Qo5oFo6citcyEfFFApzg4dWFVgdF5ohm/ZsAn6FE0Chcrcv8Dn+fG4wJlVZzbFi+fWTn
         Y2iro5Y7VOoMWpzGfyIvl42UWYApO23W2gVF7N5nXa0TLfTL2WMTdp0xth/3F0fThb5g
         9V00cNSDvGEUJUk379Jlp/ThkR08+8sfWGEQ5KC3IywYQRgaVo1XeeSgLWzA2g7kZrr4
         mqkNf6eYKPa3PsgsG5gHNg/7Lg564PQA+WG8WPNgx0uChVr5Ou71f/NPfHwOd9SIfhIE
         9m8w==
X-Forwarded-Encrypted: i=1; AJvYcCV58V9250vHPN932zyTMZSLBFRc4EtUPsT4lQvxzE8dxARdO7wbE1oncDvY8s/RCQ1gDcaX@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2VmMxePp8B+esDmEjyAGNvokI33WHm0bHMSZ7airzyQ/tr9/h
	nh51EABzjYIxZXzES35JvB1mimVHSwh3uuyBSVEsqMTolZ9YNAR0IkR0oDP6qXLIjSaQ2gfEI2h
	/FT3pYqf5XM1OWGHJWjPZcnikvnOi7yDwcRROXVh3gu6GvSYd8f++GXg=
X-Google-Smtp-Source: AGHT+IFU4/JJhgeFmeUgOTOiFlptRuRRWPCJkZ0E7Hx/P2REuhArQvWWkxw4t8dMVmrVYchAgd8/ib9uHjlZQsLpg9MXrqKFdQ0W
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1609:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3ac49fdfa0emr11002455ab.1.1733948882793; Wed, 11 Dec 2024
 12:28:02 -0800 (PST)
Date: Wed, 11 Dec 2024 12:28:02 -0800
In-Reply-To: <20241211200240.103853-1-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759f5d2.050a0220.17f54a.0045.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in __alloc_frozen_pages_noprof
From: syzbot <syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@gmail.com, ericvh@kernel.org, 
	leocstone@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	v9fs-developer@lists.sourceforge.net, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/gpu/drm/i915/gt/intel_rc6.c:139:19: error: static assertion expression is not an integral constant expression
drivers/gpu/drm/i915/gt/intel_rc6.c:140:12: error: static assertion expression is not an integral constant expression
fs/bcachefs/str_hash.c:164:2: error: expected expression
fs/bcachefs/str_hash.c:165:30: error: use of undeclared identifier 'inode'
fs/bcachefs/str_hash.c:169:55: error: use of undeclared identifier 'inode'
fs/bcachefs/str_hash.c:171:40: error: use of undeclared identifier 'inode'


Tested on:

commit:         91e71d60 Add linux-next specific files for 20241211
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=03fb58296859d8dbab4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12987544580000

