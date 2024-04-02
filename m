Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7348F7D
	for <v9fs@lists.linux.dev>; Tue,  2 Apr 2024 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022082; cv=none; b=c5P6t6XbfxvdYC9V3HfO6GW0AmwfKmXmPqa9wv1QcB7M/x2pIxnaN44ojhnihJoVXtBBZ/TL+nS5PQkFd+43845e2Jj7FsbA+Ea5Ze/aqQZJaGeVA9IWMXLG+rIVMFwWZUXsj5corXEgnvGTZSB7AYoqzOglyvP0XOCTmEgRwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022082; c=relaxed/simple;
	bh=t4mIbrxBZNm3V086qTcTQOkMnGu47K9Q6ISH6nQ03h0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=Y53d6efpoQzShjLk9hwkzela2lxm20K+B/NS+TP0Z7jLPyZiRd3nWumkQpBWxOvAjSgl+BZ19QRYLSx7ZdBzrwCVmihSBvVkT1qm1Ywgoebufmsr2h1UhymacACjM1Gj+BUNxRNGgD9IGq330lWyDS6IflzT1kEshtc0ewNY+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LBEOrpdD; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LBEOrpdD"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712022077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMVGsfnmFWvEQG/X4IE8w/mzKUPE6YOJlA5gxwFIxhs=;
	b=LBEOrpdD2ycV71B0zUqzJZw4wQ1pxWJMqna0x7ittumxflTx3AfJ9RocBopzd2b9Nt1s5s
	uSKK0ewOyDNrc2dYwwPxHRCtHZW5OOw68q7h7RphsEun4VnFtxLWuLSGmilbzHx2etzjNt
	WACDYlZ2Rf8SaY4d2JFteXswtZ1McEg=
Date: Tue, 02 Apr 2024 01:41:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <971365953aa75ae614edb5a22a73b72f5eff7700@linux.dev>
TLS-Required: No
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_init_request
To: asmadeus@codewreck.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 v9fs@lists.linux.dev
In-Reply-To: <000000000000c6ea9b06150b361c@google.com>
References: <000000000000c6ea9b06150b361c@google.com>
X-Migadu-Flow: FLOW_OUT

April 1, 2024 at 11:09 AM, "syzbot" <syzbot+0354394655e838206fba@syzkalle=
r.appspotmail.com> wrote:
>=20
>=20Hello,
>=20
>=20syzbot found the following issue on:
>=20
>=20HEAD commit: 8d025e2092e2 Merge tag 'erofs-for-6.9-rc2-fixes' of git:=
//..
>=20
>=20git tree: upstream
>=20
>=20console output: https://syzkaller.appspot.com/x/log.txt?x=3D17cb6d7e1=
80000
>=20
>=20kernel config: https://syzkaller.appspot.com/x/.config?x=3Da2fbd4c518=
bbb6b3
>=20
>=20dashboard link: https://syzkaller.appspot.com/bug?extid=3D0354394655e=
838206fba
>=20
>=20compiler: gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
>=20
>=20userspace arch: i386
                  ^^^^

Seems like my concerns of my new inode handling on 32-bit architectures w=
ere valid.
Ugh, I suppose we could look at special casing 32-bit architectures to us=
e the
longer qid.path evaluation logic and seperate i_ino allocation (which mea=
ns inode
on client won't be the same as inodes on the server).  Will try and come =
up with
a fix for this later this week.

     -eric
