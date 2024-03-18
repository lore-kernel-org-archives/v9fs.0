Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9035A791
	for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797884; cv=none; b=kCmen9K0OXdNWXWhf93h8/37nbGX6vI62ODboHY5utEuuSmUVNWsbIRa57bCLKW0lASLgTKFacBvBYHA9ROOVjbsrOBlizTW/beeI8h5gFS4YDHcEjzc63i7vheGMdQwSD5ReqTRkhb8ye9hG3NR5XE5h+mOiC8XfNd//Np2IRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797884; c=relaxed/simple;
	bh=O4umbVjFHYUDfEMizAn5kUkkWDtKLtGnkvI7A/r4rMg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RMBxrN34flvvXrb/iQXz8uO3Y1Fg53YxWdnWQ+xul2T6Z9fnpPAMj90MXrW0+0bEndMxCDbF7tggf5shz+filLWaj2s8QhQzQPlkkRJ6sswYc8ZR7p4GgTX2kriBt2wWRSyH8b8Me0wjtYpP2Ww0hE1lWLWQA1kYKKijGEETlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbfd4781fcso319775339f.3
        for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 14:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797882; x=1711402682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJmAzOZTchuP4uA1qhK5Bek7hETqC3bRqV9ZUNXqqkg=;
        b=bDTwwdi4GAUL4h+zokCEG/pZv8oX0N1p96VUEnv3BN+Wh6jTYFAVhes/MMgrl28Ehp
         gGRtzBiSPXKOphcjQuW/Em69MNGgeZsHPksZXuvG54rSvjq/PtHq+QXMgTUnDGYftTiW
         b6jt/7JX5smYtqzBGElgD+kqSZngnU8QpNGv+yAWQW9mAI/6O/bOFFVThGttTZaXdfuz
         MNWXDfkWPo4HF2UqQbEbuVvUQgGHe0oP6LGkSJeagmPraKhuO6bbijsEe79XxwpHhu8k
         aye5y5nzkpkOFPrtbk+yO9DA/lNowcZfHXxdOyD2bb/mNPOrZ15lC9mSoC1+ZeHo0mwk
         OzVA==
X-Forwarded-Encrypted: i=1; AJvYcCWKtxB+9Q6h5+Wa0FDcsuJDOUggb/fJLya8w0AZEE01rplDodYgg9FhCLX1rEWJ0Q58bU97LvcZyCALSxNL/A5BnEgb9g==
X-Gm-Message-State: AOJu0YxSMWQX9ja3p0+VnLYa7BerDh0P7D64neVEGhyDDrXep9aYCSVD
	djq7qfzahrlwcCvnQBCuAa/CgdOLr8bxZpb/bhd+ighYGZ1tBlar5fbYfsA120ZtlDE91ht399S
	Jy/2JgpEq+Xkni7FgCKSOITp+/u6Gu+j6tO3Ycex5lBvjnZtmEoHA7Vo=
X-Google-Smtp-Source: AGHT+IEE0bl1tT2EzGs5vApz2wZu53dx4QAXfi7kjhMEVBTjBAHVikJmo68tYp6WxIDBl91ZI6pdnd0yhhgF/4otTEnc3TJgJEZQ
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1656:b0:7cc:76d0:cc1f with SMTP id
 y22-20020a056602165600b007cc76d0cc1fmr25629iow.4.1710797882097; Mon, 18 Mar
 2024 14:38:02 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:38:02 -0700
In-Reply-To: <B6E22992-FF45-44E3-8FBE-D157BED7B922@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b942f0613f62cdf@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, charmitro@posteo.net, ericvh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/9p/vfs_inode.c
patch: **** unexpected end of file in patch



Tested on:

commit:         bf3a69c6 Merge tag 'for-linus-6.9-ofs1' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=eb83fe1cce5833cd66a0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160cdef1180000

