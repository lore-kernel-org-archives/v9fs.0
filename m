Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92F12FB01;
	Wed, 27 Mar 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566142; cv=none; b=OuqDK3HEYlmXa4mqAuPy9kIU296g+RW81xpxE6rmSQUx2m0DZECRNUFrRuFzi6xNxm1aAXeJy5svwp1jpQymFMJnhZNvNJ705ZhgqBrnzsRaJ9QVZcY0wkISzFtlVum589UeDudKKmYQ75SemeO/CydzRK3qSdnD2gf8IrWzlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566142; c=relaxed/simple;
	bh=Mkjkay7Z0Vj+E8vwdVGwj0OsZgK9nBJ7enE6cPyGExw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdewmW++iMtfjVPAyJYu/P0E+ZyUHOwIf+D7U4gBM+AbbJd6jxiSocCsWHWMXTTSYos0vUHxLPvg9/OPnG/MjJc+pXUZi72uzzxj7pSieGxI7C7ZoVW8/koYrFEB+k+2WACaXYXq0cqyxyE9OUwDfGGXiPc/KPmHz74tAOX56wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1MMhwUA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1MMhwUA"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ff53528ceso66407f8f.0;
        Wed, 27 Mar 2024 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566139; x=1712170939; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G43Y9I+3uus2Fv/YCLNGCC6IN7NsddtveLn+lJcwAXE=;
        b=S1MMhwUANdjwKEZI14njOvbHsOZMHWYwCHhGy7TFPAZIvIeTujTLvdfWDLJK7Z+y5m
         ZXsHXYQiN2CQTNrT+yGBhACZmW7y0yEP0s2T4HiozCw71cxazaCShifVfAWM+BGOwkmi
         oyhGZhqmBg2wtzOj1FOPfAySCsGIb83NbSg3b0W0DBOy8i8ib9bx2/B9+NyuqBwN7EO/
         i2gtNQSxzMulu2YjTgIAz+wP4rOW6RWbWjmQSXdHGEM52EXsdrhSxmNkIy0/xlfyw3pR
         6n3jLQRqCMs5lnE5izSJUjNXQ7m/w3RQ9cX9wAtL+1eAKidqS1CHwc8QPJZ2tUKZbDjb
         RnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566139; x=1712170939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G43Y9I+3uus2Fv/YCLNGCC6IN7NsddtveLn+lJcwAXE=;
        b=pgCy1HmWrUuMVQ3qxjUXTuKsVOmE6PpI4vafHhvixgs+SRbtD1OljRDeND+JdsdnwW
         Wp/tddl2y69396pWpNY5BorchfTj2Oxzf3XaqzEVueFFAux7rYYvMGSQb3C11ojAeEeQ
         V7CMHrgcfjRl9umCGFy6kuBvOmt+5U/JwlfGtag/p9w8KBkxd7zTVTX+Fxn4pNkSQVc8
         NGLyDf3NCgIMiIkXuxhY5D735kuu0QLRhR8anH+j4eN5wwIcQFqYqG1/Bs3YvZcDOXd2
         fwaPrnSt2Ycc9NGQK5bzWFD9vGnS1BwcxTiY/i3VQqoI/SeAzOJTxYX1gaKFbBAYRQb1
         dM/g==
X-Forwarded-Encrypted: i=1; AJvYcCXmLSrNAFa1Lkp5EshL4V/MPhjZ1kwVzn1CIGl/OIZnGVRcXbZ7QfG1H2hlM16RZSMWWSXMDNupFulfQI1M8y2oOqg9mZIv2tVLxd6Hq3E5fTyalr9JSoyFTSxI+RpcFXx5
X-Gm-Message-State: AOJu0Ywcj5EUaJQT21fv0+waYunF74fQR+JiICex/DP25GEts8O3QLNN
	gX51zjPmvAK76WjqmhFM6l3N8nBLsA6xOCde6S2WVryDJfSlu8QFkXfmOoH/MIJ62qx9K/Zwt5F
	2g1PDdz9pm5Q6QfUSDdiQzQ+CA3QDqEt6ifY=
X-Google-Smtp-Source: AGHT+IF3uK8BNj55j5GBkzVOsoRtME4sRuRyuXZ1Yo73eCITL53hu+yrnhHrXwg4fZIQHBJexfPsMc5dhyeUKDaRz0g=
X-Received: by 2002:a5d:6e0d:0:b0:33e:7896:a9d7 with SMTP id
 h13-20020a5d6e0d000000b0033e7896a9d7mr601323wrz.67.1711566139396; Wed, 27 Mar
 2024 12:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <00000000000055ecb906105ed669@google.com> <20240202121531.2550018-1-lizhi.xu@windriver.com>
 <ZeXGZS1-X8_CYCUz@codewreck.org> <20240321182824.6f303e38@kernel.org>
 <ada13e85bf2ceed91052fa20adb02c4815953e26@linux.dev> <20240322081312.2a8a4908@kernel.org>
 <20240327115328.22c5b5a3@kernel.org>
In-Reply-To: <20240327115328.22c5b5a3@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 12:02:08 -0700
Message-ID: <CAADnVQJ2SyJq25wvV2kf8Mepic_rYyGNYh7KpdGerFi6a-jQJw@mail.gmail.com>
Subject: Re: [PATCH next] fs/9p: fix uaf in in v9fs_stat2inode_dotl
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>, asmadeus@codewreck.org, 
	Lizhi Xu <lizhi.xu@windriver.com>, 
	syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, v9fs@lists.linux.dev, 
	Linux Regressions <regressions@lists.linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 11:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 22 Mar 2024 08:13:12 -0700 Jakub Kicinski wrote:
> > On Fri, 22 Mar 2024 14:26:07 +0000 Eric Van Hensbergen wrote:
> > > Patch is in the unapplied portion of my for-next tree along with
> > > another one.  I was hoping to hear some feedback on the other one
> > > before i did a pull request and was torn on whether or not I wait on
> > > -rc1 to send since we are so close.
> >
> > My guess would be that quite a few folks use 9p for in-VM kernel
> > testing. Real question is how many actually update their work tree
> > before -rc1 or even -rc2, given the anticipated merge window code
> > instability.. so maybe there's no extreme urgency?
> >
> > From netdev's perspective, FWIW, it'd be great if the fix reached
> > Linux before Thursday, which is when we will forward our tree again.
>
> Any progress on getting the fix to Linus? I didn't spot it getting
> merged.
>
> I'm a bit surprised there aren't more people complaining TBH
> I'd have thought any CI setup with KASAN enabled has a good
> chance of hitting this..

The proposed fix is no brainer:
https://lore.kernel.org/all/20240202121531.2550018-1-lizhi.xu@windriver.com=
/

+ v9fs_stat2inode_dotl(st, inode, 0);
  kfree(st);
  if (retval)
    goto error;

- v9fs_stat2inode_dotl(st, inode, 0);

Please ship it to Linus asap.
I'm surprised this bug slipped through.

It does affect bpf developers and our CI, since we run with KASAN and use 9=
P.
