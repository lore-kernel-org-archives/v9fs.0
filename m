Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE54EB5D
	for <v9fs@lists.linux.dev>; Tue, 19 Mar 2024 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829564; cv=none; b=upG3DOM6HhkgjK6p0HWbhhSONPUcKQDrYMeNeF4SIc5ubLQjPqp0QDZMveO2R+9j3yN1F0PU2Y1GTYnM3AaCtigLw5/ECtb3CXSkqg2iPGWOvjNchompibO/424h7hWnnE5qUtW2t8w458vs2no7eGBpsCB2o2ml+A90/Ta1evY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829564; c=relaxed/simple;
	bh=Vdnf5nY/czOnJuaGBtdc0SPAtrzeEIXDsmcxSs4q/hk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qR36gZrHF4Ft4QCNu6pTxhtc0jRDmgU3/M5qMlKyhhRLWUkqBNQ+BkL+8ff0vc/AnQAs0NPiRk3h3FYtjikebDiW+Fs3zqEykDpdIY/fYONzKR7SShveVb2W+K2lpVS6nvK1VtBn71gJ7WulM2AuXn2gQ/+pr2gkNdGdyJjydAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so462693639f.3
        for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 23:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829562; x=1711434362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGyIYPow4NlrefKnKPQPE6bAcLRxnsVwIJ5cTlLJan8=;
        b=WXqHn8JEtA2d+ESpNvGOjvVlXAOq/qoOJBzRl0nqKfa7OpO86S/nqmgnrg1izOvUfT
         2YN/4WLVcVN71zH2B2KSI1Xf9bjlD070x+nn1+owMLikgZdZloDUI90fhbQtAKb72izx
         MkaOvz6lQ7+Qzx8nx6QsCKqiybW4z5YwA3qiKzZ+lPNGudhAsKvSCbBufftAjjZIZq3l
         a3FcOHyCefKYqZ6TYVYtlsrBqv4lmXOn2ohMG3rQwuLrt5SNTn5DOs3B9nKjaTXqGh0q
         FTTAtqW/4ylLv4+d4gsy6LvwCAZ7xbhgMyKjWm/mu/3wZnSnRBOiBGromqaoZudyTJzx
         MiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2jIvWmyPQw3A+ilnilf4bGwGnVYsdvJF3E2nQEsriFJXhTvd9fFVzuB2jhZ6gARZ1qWWjXOh1+IRT/Xt17cJYTawoQA==
X-Gm-Message-State: AOJu0YyJ1H1G467vlPhX962mCrhNsySYD3MBfNYAxSJySZuyV0fwRIj0
	IHxentMxFn/zX2tSHUhpMTjfglpvFxqqB9xPUsRN6wlN2ppQfNZUjD6OV4269EF+KvUzDEBh8BB
	+YmQnRUZ4SdiXayMzvemMu7tsIpsVNEG9yhahRxTdEPbmPlYoSb7VkSk=
X-Google-Smtp-Source: AGHT+IE2QD0gDlbEx3Hy3y/Bkl9ZHnqqTTwLra5wel1Aa+fBhvD4Qk670jJxAR1r48q58RoFOTHF+8ak7zpqJ97cuZoc/2yby5Dw
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c7:b0:366:b696:e943 with SMTP id
 r7-20020a056e0219c700b00366b696e943mr559353ill.5.1710829562024; Mon, 18 Mar
 2024 23:26:02 -0700 (PDT)
Date: Mon, 18 Mar 2024 23:26:02 -0700
In-Reply-To: <ec51cc1d-beaa-4aa1-a54d-e503223dd365@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050e6310613fd8ccd@google.com>
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

commit:         b3603fcb Merge tag 'dlm-6.9' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=eb83fe1cce5833cd66a0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a5fe81180000

