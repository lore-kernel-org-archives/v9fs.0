Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E41CD208
	for <v9fs@lists.linux.dev>; Fri, 28 Mar 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175325; cv=none; b=q2N0DvxSjpZXa7RkIc1jpdnMwuvygdqjmF5coUALdwHwo1xCAfxokcx9Fg7KPC8QFCFK5msPE0OaGmrMF1/e1+dp1mfw++o4SzRWnV8WLNcU5Q2sEPHgYr6ZQH2mxhT87DRmT0JtCvM6qfpDYGaIPZ98J7RbVjd34vIOKsh4v50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175325; c=relaxed/simple;
	bh=9u95qfVKYEZf6M88dSEifsWoCD8sVYPu1+QrOe8tpdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f3nJgEmkMYg0rk97htRvBNRtlCjsjRtfycpkgiXyorY6l4sXJZNbivqumggFCvSXD+J6EVHz2kMlNgmmpX8sB33Qk4pvmhyAhyCftHiMkpdxBLXAzKlhesvQJsqFDlsIFnAEfhjKs8iEk53FNtG+VtYPmnPacE/KNmo+CNOx7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85d9a52717aso211901639f.1
        for <v9fs@lists.linux.dev>; Fri, 28 Mar 2025 08:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743175323; x=1743780123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jR1mo/hCOtE3isFlkNzr3KUW3jS8AIZP6mXHPyq23eY=;
        b=H6RNDsLSinzWhDcuUGsF0evyWNfy6hkOzjkzrodLmWA99Fnzn+s5paPMI9PkFaAZqH
         SG8stFn84bS9PetoSxv+OH+nLZE5xQ/03JjOyhTfxAiWTf8fWVtWnpFTYtQav+jeM690
         1HFIz9dfMefg3w7XF9QdHaVQoNoITbvbe6RWYMhiu2h6g43nZiVON//U3k+KPofjOLIf
         0SF4GeVsYpIMvKHku7UHn1DwdyPsWMxUZ6GLxT/9LS5EJBG8fNzBZ690EM/nkfkM9yte
         NCaLyh6tdIRmnBullkYajSp6nOjn5PrLNMiBeUQEFqwKZ9gn8fZK8RIFbMtDjYTmkBt/
         jbXA==
X-Forwarded-Encrypted: i=1; AJvYcCUcxGHXGtkSBarxPM1XGtxTEp3ttKPhjpu2rSP003Pf9pgmqvla8iK1A6Tkzn1crFTfTXSo@lists.linux.dev
X-Gm-Message-State: AOJu0YwnogC02CyU2QRaT9lwoYY+WDVZZo5U3UhAWcwktkVgcTeOuvDR
	FWhJyYrUrCDfYbFUzZ4O2vC/Q8GvyzI3hS3OQtYUMU5zFedXFbOfQh+l4kuRbCuhuFAeTy5F10w
	SFnZX8gXybCVhxwcl02X1PQM6UCWVr+onJAFFWYGM7YtQxrK+2xR2FGk=
X-Google-Smtp-Source: AGHT+IElOaU5aRIupz74EKbuSIxjuKtTVjRX81gJc0lcI6gjdITkNBPpSaXxPL8+zRjuYGJj3QnRTP8hXZNuoJpP4xv0FZKbVDAc
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:3d1:79a1:5b85 with SMTP id
 e9e14a558f8ab-3d5cce290e8mr94000855ab.21.1743175322807; Fri, 28 Mar 2025
 08:22:02 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:22:02 -0700
In-Reply-To: <20250328144928.GC29527@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com, 
	netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
Tested-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com

Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1598064c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16682a4c580000

Note: testing is done by a robot and is best-effort only.
