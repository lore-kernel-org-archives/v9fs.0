Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577813B297
	for <v9fs@lists.linux.dev>; Mon, 18 Nov 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951667; cv=none; b=KcmDGSiTx6PaKOQ9GF+afgjahl059je16TW08KV3KyQyaV4aMCxXKfBAeetJozcykTrQDVfhHObMSDIaAvRflQFT9ntBN8Q42YalNA4LC6efcqbYqh+c1D2I29Hc7ZD9ogPnL0ukiU2zMvwXttvmp8wmLAbD1UU3O3NFGapWgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951667; c=relaxed/simple;
	bh=q9Qgt2DmgQFigkaYeiK/TKVRJt1z5fm0Ha46dAqq1u0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rkbPUncaasnm5UgWJ8E+QJnJWduiUv/Om8YadOeVooYqR57ZtidKcEbjgOqsZvXByF1BZ8hNb3H2yIn7jeVhbjigS//mPKOp4BBERUhV3Y1PHUvEz8E0C5zrVHNTFVq5VivqhmacAb003Axjy6BuCOPHrKnpMJ+nHmWa/2y/VWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77085a3d7so5303365ab.1
        for <v9fs@lists.linux.dev>; Mon, 18 Nov 2024 09:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731951664; x=1732556464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+eyOHdkIZSYMZRH4DcsQR8I81X6UeSZ86aZEWeyMBA=;
        b=C40+KrvmitQVmfaWD3W6Sdz53HrKz/+qhpyEFwpmbLOcMah43UkBqivrSLYd3muGzp
         vL3LbxoFijWh8BuwoA6F/+NvCY5ZohuzzrU3c4EmfKP5dkZzKhJMnaoGQ58ZofMYTS7D
         xAr7vjLsrKizGxHBGywqJG6bD5YFz8wArMdv34ggvVHTXQ8+Lgyo6+nyhnRHAOgPDXXH
         9rctFZV18GfxJ6AMPFLCt9uKd8fxjrI+ex5EDN6kFeksOSCvu8BNk9RLDOPBS+cScTX0
         elFLLphUtju+UyChstvR5Q7v3RbwCAAMCdUhGzp3AbeH2t8y74/Foi+ag0LEiYNgORCo
         XdTA==
X-Forwarded-Encrypted: i=1; AJvYcCVzyGiWzRa3a1aQqQhMv/q8ypeVbEG9ybIFZ4iKEfd2vZZ4vKljnj10snpOIxGLlWHm8F34@lists.linux.dev
X-Gm-Message-State: AOJu0YwvMTakRj6EuA58qrP5TTGDW2w9vaJgCPx5hf3xr8j0S/m9xysV
	H5umaOSyJqaW+s+P95Q0ehAzEVxYtWaCCEuSgAdqM2KLbXKGv8FqYGzQLKmdbHGXtjc8lyt4CoN
	OcWg0mp+wNnGsC3TcJeFKgb11shvballV+QtXF3SVLnN/BbW5EHPCooc=
X-Google-Smtp-Source: AGHT+IElwG55NQquD0GWFUFxabkI3rZ7NfRUYnvEJbi5TbWuwX/VdFh46AaPLhqYxQVETibg96kShUvE3RMzLvCLW3O+ePH1FTcs
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1382:b0:3a7:158d:6398 with SMTP id
 e9e14a558f8ab-3a777448011mr1522735ab.7.1731951664002; Mon, 18 Nov 2024
 09:41:04 -0800 (PST)
Date: Mon, 18 Nov 2024 09:41:03 -0800
In-Reply-To: <949458.1731950611@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b7c2f.050a0220.87769.0053.GAE@google.com>
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

commit:         2aece382 netfs: Report on NULL folioq in netfs_writeba..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12714930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55f8591b98dd132
dashboard link: https://syzkaller.appspot.com/bug?extid=885c03ad650731743489
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
