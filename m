Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333411272A3
	for <v9fs@lists.linux.dev>; Tue, 30 Jan 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632886; cv=none; b=Mc30DaecX20MM2eER/K5+YR6FqXO2LOoPde5rUY5V7LuY5mXulTF9x2XI3gzodCgBBp6Z9aDnsH4Zq5HWTLNRXCdBru5DhxZwLun7rz1g+89FKI/mKi/RH+Txn7phj+43KUMuoGxLYBqQJE6fc0De3532rmEBmWuQc8Ug9gzDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632886; c=relaxed/simple;
	bh=xjzjJrysSvPLCMEzQXvZ+Yu3MMpIhvxElmjRfyJJaJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFno38FmstpE2jPkEOG0kHUjir1qArCeMBjeO7XqxLffUEesgvg0wAogZ3vEA1OKAanHrMbtN5NUWRkwZmROViKCuDq9bps0Cx9dDffVIxeyW0BmNyyxDDz5DAwd3odebI3jjwNuMs53e4Fe4nRcz3kkFQDZr5GhKUWmahMWVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0GFknfUJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GFknfUJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d8d08f9454so186895ad.1
        for <v9fs@lists.linux.dev>; Tue, 30 Jan 2024 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706632884; x=1707237684; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90dsUhogDic1HENZzxBxVkMyjCg4enXsEvtqV/HnIcY=;
        b=0GFknfUJpv0If3rp6vB4o2LqnOm8Z0c878rY0baOsaa82x0l5aliKEy9oDmy6sVC4I
         kTgByxFvoKa1vQq/lBEPbWsrPTulxkBVy+RCI22IPr8vwBlet+7J9+5JCf6RyJM+DzaW
         FlYnc7tCeOqgfJmse5hjkIjVQrUX0ihKauYoOrmUmyXogDV+V4EnrruPB7yNSc5qVl+D
         U5hDh2wJrP1wIFN2JAFpbUMkuzZyyNi+vLo7IdKLfQaQa3qFSr5lJwFn8aqLqZeQ2Its
         jYJUpUFyJJRWZL8B8R8gDH5Ut1vaH/4NwbNjdA8gEBLp3HbM5y7YnCJnRyul0uJx7XGU
         r9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632884; x=1707237684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90dsUhogDic1HENZzxBxVkMyjCg4enXsEvtqV/HnIcY=;
        b=keMZvDkmBjtytTJZG3TbAGwU1qLWCNs05VuI3hs/94u+cW4KkB1sM9kPLYyTNkjavD
         bOdZrqEBiyRtWlRIzuHGrTnqcGldP2VEBXlM+sxYC/AjV1ow8wUutyudsBKxC20/keE9
         aO9lFbaPErK6uYa6/bkvj1hhjvAeVrozdNR6I6LnrCN9RyPe8+MizM7NVeQqlcJQ+gjl
         taqYAdVFFhLlTRDDC67F7mYuODF1FiSlg49Y2lrkDTicuhabf40lCJq91Qk6wk9Fp/ta
         ZLItHcFxs+OBCdyHMzZHx1MmkyfnaJvo0Z8xA8x0S5NWEFYjR9r9oIUiiPU1fIPC9JVQ
         2tsw==
X-Gm-Message-State: AOJu0YyRO2AlSdFAOj4oKiZuKcVPC3KwP3Z9W7aPZOemamrFlyl+BQIx
	zSySSHWWoj9iGUI/lTr+K2oFfbND58RJbYTxH0wcB5Lk9hhT9CwcGkkI2QiPYczjrloCkqWKtj4
	g8AM3f8DNOsVQA92sh8wJgHAP7B94glaMBTXO
X-Google-Smtp-Source: AGHT+IHIP7C3utp4fY/dALdbVUWF+osAYCzO9ppmlrDUJjiU1ke2Swm5Kxm7V+pizKtZTAN6z4eEbMWQ0Gqqu4lSIek=
X-Received: by 2002:a17:902:dccd:b0:1d3:7db1:388b with SMTP id
 t13-20020a170902dccd00b001d37db1388bmr233504pll.11.1706632884096; Tue, 30 Jan
 2024 08:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <000000000000ee5c6c060fd59890@google.com> <20240126142335.6a01b39f@kernel.org>
In-Reply-To: <20240126142335.6a01b39f@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 30 Jan 2024 17:41:12 +0100
Message-ID: <CANp29Y65E_jqfhkipGzJQ5DuDhpZzLrNJmL=foAgk9cgD8L5tw@mail.gmail.com>
Subject: Re: [syzbot] [net?] [v9fs?] WARNING: refcount bug in p9_req_put (3)
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+d99d2414db66171fccbb@syzkaller.appspotmail.com>, 
	asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	netdev@vger.kernel.org, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending the same reply in plaintext]

Hi!

Thanks for reminding me. I've just regenerated the list of
classification rules based on the latest linux-next[1], syzbot will
reclassify all findings once the PR is merged.

[1] https://github.com/google/syzkaller/pull/4471

--=20
Aleksandr


On Fri, Jan 26, 2024 at 11:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 26 Jan 2024 01:05:28 -0800 syzbot wrote:
> > HEAD commit:    4fbbed787267 Merge tag 'timers-core-2024-01-21' of git:=
//g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11bfbdc7e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4059ab9bf06=
b6ceb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd99d2414db661=
71fccbb
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > userspace arch: i386
>
> Hi Aleksandr,
>
> we did add a X: net/9p entry to MAINTAINERS back in November [1]
> but looks like 9p still gets counted as networking. Is it going
> to peter out over time or something's not parsing things right?
>
> [1]
> https://lore.kernel.org/all/CANp29Y77rtNrUgQA9HKcB3=3Dbt8FrhbqUSnbZJi3_OG=
mTpSda6A@mail.gmail.com/
