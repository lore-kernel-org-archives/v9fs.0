Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8F15CD78
	for <v9fs@lists.linux.dev>; Sun, 11 Aug 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416184; cv=none; b=ihtOHg0pPfl2HZklTitJFp1o2t2Z3xonWli0W7Rwb6J3FHyLCOzpXwJ6hI2vsnhMS3KfW7f6GJj+Gl2j9vmKUy/6hLhQzD5EwX7myYCgg7O0DOnkAl4l8TRyE+I+eiP23IXB1C2TevkrZSPVPRHjN59KIrF/OSE0V/OoUjZ5fH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416184; c=relaxed/simple;
	bh=L4Lv+V3TAvpIqLu3MSz4+YFRq/dbvUKkqeQBE+ixKpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uRQe39dxrJIBpEBACkFU8Gm4BjTejfsP4IWcggor0riQ4DaK6koWQtJ/UkEq5WMwdEPuJR8IQqpjcKhaFpv8ULz9CrHvahjkKLu+wnx5aYYLkpn/aa9JdCKLJbt+66XXIar0YOwCJxKxuONSXnHvjrQPW8wbyGFzT3gBaYKzVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b0bee2173so53564755ab.2
        for <v9fs@lists.linux.dev>; Sun, 11 Aug 2024 15:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416182; x=1724020982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVqFzBryEujNvLyT47tPqWQBFIh9FtkAq+KHfk8fPj4=;
        b=dAG8+9oMxe6eZZkr6WWVuZNsN92OdiiTzoQl4JPog1HfM1LosurBE9zf0JjT7iB9gL
         j+wY++zJaNoZNBW+X8WQtN/IfTZHHIWU8MMQbm/zG4re4rHrs9JszsXT3UcOTHeQjBY0
         Sucfn9P/8TQwxZQaAE8cQSAVWZAc5AyABlGUxALCs308my4UPgcz+C2KLmPVXk3Gb6Oe
         SGOPNNosQAZi1MXHaBxhuPYVxSfSkXIT7vpMYapNrxnXUXxMvdG5hp8HDsoS7JReEVfT
         w7D53+iXDDgYVGii8SAFGXnrzlYKSM8ctvG2hv7pK/ROZMoVw7aD1n5JXrvB4p7RuEi2
         2NBg==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZaEtv4zcj8D/yZ0yWyJ3ajUiA+msWq/KSJicOYqe7RhGy6T7/UWoXmB/48QhJ23Svp8c7lBN0I56T/ptsKuGkPzmZg==
X-Gm-Message-State: AOJu0Yww583YcU3oWo4r6HGtH9F6qKU8j7j4SL0FQ90bGHs7YMefiEiX
	1XknAzRVWRMQcz1TR8EWXTVkguRAGGmdz7GpMzKkoPQB1IVRfoiNiQxTDiTZOn7Sf76ffZ4CXbm
	+xruhmMTMj1sbetX6VZru6dhURSlquKiMlreDfBT1mEnjKdsyVYCx4ic=
X-Google-Smtp-Source: AGHT+IF7jkF4oBqJtIkn6QuGeZP/SaW+o6WVuB+UpJ1Q7K+E62/xT80ADTCE4nj7LwY0M348sXjLlvffGGJyVNNQbX8hhCmM1l+c
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:376:1fae:4604 with SMTP id
 e9e14a558f8ab-39b8709bc57mr6384475ab.4.1723416182349; Sun, 11 Aug 2024
 15:43:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:43:02 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005971a8061f70191d@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	eadavis@qq.com, ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lizhi.xu@windriver.com, 
	lucho@ionkov.net, marc.dionne@auristor.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2df86547b23dabcd02ab000a24ed7813606c269f
Author: David Howells <dhowells@redhat.com>
Date:   Fri Mar 8 12:36:05 2024 +0000

    netfs: Cut over to using new writeback code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148b014b980000
start commit:   5189dafa4cf9 Merge tag 'nfsd-6.11-1' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168b014b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=128b014b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16828c5d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103c7805980000

Reported-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Fixes: 2df86547b23d ("netfs: Cut over to using new writeback code")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
