Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9F13C695
	for <v9fs@lists.linux.dev>; Wed, 25 Sep 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276714; cv=none; b=W1n2Hq8TkvaiiqunzYF7IvFcKCsP66tCqcecvdjnwZBNOLG8Sb28gTjuyJq12YBK3PZ5/nHk9dvrRGJFDXbjPL6Zwn/Prsl2QZNhitC3XM/h0BRezo6+YnDvxw6MxbjhGl5WRAprW6fBzOuMWWGWeLd49oj/Dnq97C5hilR9PpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276714; c=relaxed/simple;
	bh=i4aWQ74F68GcZ66T0SPUsPClUeL1Pwn1OnLNsTQW20M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmzCxvlHhImOHhdWYt6t99fglwFa2oiLzmUJHNIoSwSU9G+FcxoEwHDPdZb4hYgEoKH2ioprsFD17sHbotGDOCmWkUX5rnZSMo814WYd3fONK3E6zliEvY+92qhfLiaAZDoI27RalbLMv2gBPil38lupYT3BmrgJIoqId/9syRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc3z3azD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc3z3azD"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a99de9beb2so439088085a.3
        for <v9fs@lists.linux.dev>; Wed, 25 Sep 2024 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727276711; x=1727881511; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4aWQ74F68GcZ66T0SPUsPClUeL1Pwn1OnLNsTQW20M=;
        b=Gc3z3azDBzIWaLQovaKU8EJXxbx6FWwt0BrmM0n38SFzMkGjmlwuj2A7dBN909SKyc
         Yx+eHPNmrjWJ7QgD5JrC89p4bzQ1DLs17LOkrie6szKjjr6fNm09tEhYDKzJT1dguVZj
         5k4lYM8r0FTR33oFWWWKS9MUszV8UtBzNOFoVbvCJe5ErtbC3G5M8dxzvA4Z1E2fxslz
         KRe6SuvodfiF2c9mBpo9FoHfWdxpugBwxE86DZBkyTNGnneztBMBHMeCgoJz1O71ThsJ
         P5QKnXJdHNEHIS1H0KC7XjsxB1L8lo/J9DCIWlEYiruWgtgZN+TpI6zCJ5QmcTxlmHUm
         C3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276711; x=1727881511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4aWQ74F68GcZ66T0SPUsPClUeL1Pwn1OnLNsTQW20M=;
        b=lCbmBWl5xUxsJxQqbK4Gq2+eTxjVU2hLnF1Npd3UHFDDq/mET2VUoBRVKXwtcKpIIR
         b87+TV486duWbUwGku6lUZS5IPtv0tyiIO1NIGRUhd+sSzfYu5An9LPsFrniuQuW468t
         NceQ/CN7rpoBslGc3j0u19NSJSfQHZeiCQ1CzU14a3uPQZPzBRnRqO/P7Wz4ZAp2ZS7W
         GsPPYIR83x42ydM9fX0jWgFnsMKtWjJyvtJYuoGjYltKUuDXiRx27UtukgjgFXEFtzqJ
         jz+JFwBTK6zgqFW3Pc9LfQtSPsgIVBpcXI/BrIPG4+ckJyDNLnqAKTTAC+D7MN1epeox
         FASg==
X-Forwarded-Encrypted: i=1; AJvYcCVNuRsc58yV9hRY1wM1NFCpdSeNZKgWmMf1lQUvUWqjf9g71avg7G7y5PkRiE3K6zS+d+3g@lists.linux.dev
X-Gm-Message-State: AOJu0YybkViDNFhr2q/V2oWHKLvhFuHvG9HJxhynMVLa2fsMnpCeh898
	YF2RBOYsaYZnrO1lfHj1B44zu+ZC+R8oMDN/byzzGs5vV//+2v9haTB/wyy2HeUfFY07fkXm+o/
	DZox8FcuzBsHH+CZN9z81wV8FlwI=
X-Google-Smtp-Source: AGHT+IHLRkUkrQz9oX2/jWpdyBnuBn0AH6wAkFvLI7fK0CnB4oT1RUmW00sdQaCzOkjws2SMxFckIGwkQIeAn/NNTSY=
X-Received: by 2002:a05:620a:4145:b0:7a9:b04a:b324 with SMTP id
 af79cd13be357-7ace74658ebmr362468785a.64.1727276709328; Wed, 25 Sep 2024
 08:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com> <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Sep 2024 17:04:57 +0200
Message-ID: <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:22=E2=80=AFPM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Thanks for the link.
>
> Also can you try the third step on your standard linux kernel by omitting=
 FAN_OPEN_PERM in the mask and share the observations of git clone operatio=
n. Does it succeed ?
>

So it depends on the definition of success..

I do get this error with the fanotify_example watching 9p mount:

root@kvm-xfstests:~# /vtmp/fanotify_example /vtmp/
Press enter key to terminate.
Listening for events.
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/info/exclude
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/description
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/applypatch-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-merge-commit.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-receive.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/update.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/post-update.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-push.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-commit.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/prepare-commit-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/push-to-checkout.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-rebase.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-applypatch.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/fsmonitor-watchman.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/commit-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/HEAD.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
read: No such file or directory

But git clone does not complain at all:

root@kvm-xfstests:/vtmp# git clone https://github.com/filebench/filebench.g=
it
Cloning into 'filebench'...
remote: Enumerating objects: 1157, done.
remote: Total 1157 (delta 0), reused 0 (delta 0), pack-reused 1157 (from 1)
Receiving objects: 100% (1157/1157), 1.13 MiB | 1005.00 KiB/s, done.
Resolving deltas: 100% (812/812), done.
Updating files: 100% (136/136), done.

I did get the same error with FAN_OPEN_PERM:

root@kvm-xfstests:~# /vtmp/fanotify_example /vtmp/
Press enter key to terminate.
Listening for events.
FAN_OPEN_PERM: File /vtmp/filebench/.git/info/exclude
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/info/exclude
FAN_OPEN_PERM: File /vtmp/filebench/.git/description
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/description
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/applypatch-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/applypatch-msg.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-merge-commit.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-merge-commit.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-receive.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-receive.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/update.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/update.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/post-update.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/post-update.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-push.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-push.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-commit.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-commit.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/prepare-commit-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/prepare-commit-msg.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/push-to-checkout.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/push-to-checkout.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-rebase.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-rebase.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-applypatch.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-applypatch.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/fsmonitor-watchman.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/fsmonitor-watchman.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/commit-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/commit-msg.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/HEAD.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/HEAD.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/tSXZBNw
read: No such file or directory

I do not get fanotify error when watching and git clone on xfs mount.

Thanks,
Amir.
