Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF17080D
	for <v9fs@lists.linux.dev>; Mon,  9 Dec 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759284; cv=none; b=F+feWvrN4tTcDZDnKfeVT5ZDPBbs9Nfr8zIzt8QEgTK8y/88sZP6yqlh4vLQJVxSSEjR0CQ8Z9/9SbblSNJmzEGefoK+fZM2WKiFfXD0QIBYH9auLls4/avzgSDBMzu3mX2J8omDnIMMvNMAbVjsHDXGtvyerFYbO8TfFNeoFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759284; c=relaxed/simple;
	bh=2Dedd2vUs9wtEkS0vodNwo3Jh1txyu+cCb548r41asA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R6GHO1OOXdbdPH/Na6RHS4uaMw5FnmoPk5Sh8fWsNMHA0Sre+IlHxytAMjkFSmu9Si+Keimrl5UcTknFGwglH7DYQKfHpmefhwb714drLCfyj1a0u0YXPSdFv5krOHOhLPA+k9mI1OroyYalyUjsiYNXhWHcSv/FYeIsseY6BBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841a4a82311so402316439f.2
        for <v9fs@lists.linux.dev>; Mon, 09 Dec 2024 07:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733759282; x=1734364082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tF4g3pt7ky2erV0F6R9jVr8caMJGAFPxOtEHV23Ad4=;
        b=CRDgjPL3RbfIGPC7J158vnPESK7IJLsUOUwY7DS+I/EpaJG/OucHSZFwWIDjNv0EWF
         w6z9pgCdmOsGD0x5yCo4uoRRuFtuRZv8GkhqeuGxvfQoFYAUUXeUWOLZhlErMs47Bp46
         Dd/foekGHHGjLOCVPOgvWHD/p4lPqV1ag89mncsrRrFK3Av2lUcgUP6AqGiGMleXBbo8
         Kvkui7PWyJNEg7HUyEI7duSGcVIw/oRa9BjvFtnB3AD19CcvOElW/6tDZzA3fTFJUPhG
         GwmrjGiT7m1Q85xcVOpZxxeQVX1U8b58o+WvWTPro5XF/QdIDTVJwa148Aj/UuOAvoiW
         2Jyg==
X-Forwarded-Encrypted: i=1; AJvYcCXUzsseUo91e+mjucvhVyVW+9nle0Y71S9VnFtbssGTjcuXq8rPIgYibAgVQ7B7J7TKAl5W@lists.linux.dev
X-Gm-Message-State: AOJu0YxIUfrUuwPGUNMfwIREHxY7gmnT6eUEYjRh3Y6SEI7wQ9x5XTy0
	gYebXDkWhQsZaJE0V1Cobt3K5B8VbKI9icEja/TZvC+pRYChB3XdMZkh6in+soFBRx4j9W/6tsE
	kPJ0Ljw9sn7Gff++fWQX70aiHcfNAPEsVe4kOk+rLTHqojrvg1ejNCCY=
X-Google-Smtp-Source: AGHT+IHN1EMFE03sgaQqK4y7BbVOLdBHTae2KEnIyygrmJwPzDii8aQ5fklIsfK7D8aVF8hHDayL40VUi8dbax5ZXENxxSpFylmm
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1682:b0:841:a1c0:c058 with SMTP id
 ca18e2360f4ac-844b51b2564mr112146239f.9.1733759282294; Mon, 09 Dec 2024
 07:48:02 -0800 (PST)
Date: Mon, 09 Dec 2024 07:48:02 -0800
In-Reply-To: <2132559.1733758162@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67571132.050a0220.2477f.004a.GAE@google.com>
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_open
From: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, dhowells@redhat.com, 
	ericvh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+885c03ad650731743489@syzkaller.appspotmail.com
Tested-by: syzbot+885c03ad650731743489@syzkaller.appspotmail.com

Tested on:

commit:         fac04efc Linux 6.13-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ee54df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b041310d53c18b96
dashboard link: https://syzkaller.appspot.com/bug?extid=885c03ad650731743489
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f654df980000

Note: testing is done by a robot and is best-effort only.
