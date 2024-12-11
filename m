Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A41C4A25
	for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952767; cv=none; b=c0v80TeRNHUfKfM5gauUG+VakrzFjTrUyLctf77UuMmaWefm1tZhbDoyroi6FugF+wXU1taTsor5tIhlz07FEZRJHhOAAd5Gm7HLW4w9h76baT/LBZq/ErvmIQrTequ7S6vTP7ZEnBrk3HwU6bS8DGfiFm2rdZGydLi6U0W00lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952767; c=relaxed/simple;
	bh=iQHe9o0OFC8o625cYkLtRXrWxS/+TJviekTccK7gui8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLMuvistT3fXQvyAyGTo9RBoA2UJqcswl6hgk1sgnFPcva1F0qWvqPev8CSzDIYTrfnnG6WkpF5g9zyAeytHTcDStUD5HwOS+2HiBL0SqDdo4NwHd2VnEJICGS/DPQyD3xQyCGNUS24dVuJtnid9NDQ50Db9ji1wYc8kZobaZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZFyp0Xz6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZFyp0Xz6"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6a618981eso430309966b.3
        for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733952763; x=1734557563; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R3OGAQ5vsTFqn13bOxJ7t9i7h4BntnMNyLupbofgMFg=;
        b=ZFyp0Xz6dwG1+BFKnJLdneRtocuWA2/NTxkxGbaHMexYKfgfljTiM5KsWoLciYYUkc
         lZhlcd81DuN+TGcoypab2z0DGXVSA5fUnNRRhGopIbUrXDhVFZNn+FDhNEdumbrT6vnF
         CGQr8+mbh4a+0zNpUaXjWxCau6VU/quBYVluo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952763; x=1734557563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3OGAQ5vsTFqn13bOxJ7t9i7h4BntnMNyLupbofgMFg=;
        b=QJc61aPIrSHicCtxmmfMHNTXDtZsa6qs5gUnH6Dsy4XnQqEWyjhSQfm66NEU3d5CRz
         zp1tVYckYVydg4Fdyj9aTRqA803WxAEp3wKWG76Q9KerJucpxI5zb9bIVcB6V4PpwuJx
         F5c/2EF+ZgR3iXjw7D4YwtIOi6x8FMZr/fT7DbfixzmoBTiqfkARsry/UfKwkiJRQJDY
         c0Bjb1nY4LAELZK3LIR2IDLkyPjKDFgHqPAgVP5ifLjg7/TS5XP28QQJUGdJrlOkBJSV
         yHDDxjA9bI6QTzKp6TSyXEUQ6cv+2ZOiTeOFIN25bw18U99wUBg3pq3mmECT7CR34E15
         Pkcg==
X-Forwarded-Encrypted: i=1; AJvYcCVU994RWktIunH1WcMGT3qBRQqeV9ssLfcX8M6F5MFADzR51K9QgeE6QUaQ9+ZpxgXD1qk9@lists.linux.dev
X-Gm-Message-State: AOJu0YzMRvq7rrhlpsw5uRhOAaieZw8K7dG9h37qopNcqHIRmggu8AXG
	cTELiLM6f1+5nKoTNT4JDuRXLFKkWU4t5wTJ+ZfuvCZuLK4FXpO2/56BbCiATsTm7+6v3ISGnA9
	BBcw=
X-Gm-Gg: ASbGncs8IMKOVDev6Ln7foaALmVIR5TL020lcScJIWKBiid5HebyqfnChBbxOJa6ZhI
	cGt15zCiEEnJzoN9tY7aFjF4+8VGQ3G6Huvcx5crClZ+iRX6Hl+4p3IpDa7eJ+KDqyliF5/aGMr
	iFrjKp5Mb5x9nz5LB7gr9dppJEHZWxXbpM8Yu/8QaHoQc16RP6bgvZIZPWHPOSjer2ze7Sqs8KW
	mH3exOm+NB0ECO6F5IJYCVnzjzMLQEWEAEb3xfAjhw4mL8LQrAr686JVvUwIP/MUp32cLmfAFX4
	iF3TFxIxauvcVloDP85QsArJH63n
X-Google-Smtp-Source: AGHT+IFAQ9DzwOMieu/s1JdMmySQ3s2FFX//veDW6gFa3a3rYOEPOuFU3aRnRh5j+R0fo5gLrfIrvQ==
X-Received: by 2002:a17:906:3d32:b0:aa6:834b:d136 with SMTP id a640c23a62f3a-aa6b11f866cmr348882966b.33.1733952763474;
        Wed, 11 Dec 2024 13:32:43 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67117df90sm639683366b.170.2024.12.11.13.32.42
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:32:42 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1397716566b.1
        for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 13:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXs3Nqo7x6MQhdaZHIDx5yJ2nW4cfgLKmgkmmeXE/dKQqWJHyiD0R0rknPNYuWMUXPPX4nb@lists.linux.dev
X-Received: by 2002:a17:907:7747:b0:aa6:8935:ae71 with SMTP id
 a640c23a62f3a-aa6b10f5d3amr449688366b.12.1733952762458; Wed, 11 Dec 2024
 13:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <675963eb.050a0220.17f54a.0038.GAE@google.com> <20241211200240.103853-1-leocstone@gmail.com>
 <Z1n-Ue19Pa_AWVu0@codewreck.org>
In-Reply-To: <Z1n-Ue19Pa_AWVu0@codewreck.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Dec 2024 13:32:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiH+FmLBGKk86ung9Qbrwd0S-7iAnEAbV9QDvX5vAjL7A@mail.gmail.com>
Message-ID: <CAHk-=wiH+FmLBGKk86ung9Qbrwd0S-7iAnEAbV9QDvX5vAjL7A@mail.gmail.com>
Subject: Re: Alloc cap limit for 9p xattrs (Was: WARNING in __alloc_frozen_pages_noprof)
To: asmadeus@codewreck.org
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com, ericvh@gmail.com, 
	ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs-developer@lists.sourceforge.net, 
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk, 
	Fedor Pchelkin <pchelkin@ispras.ru>, Seth Forshee <sforshee@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 13:04, <asmadeus@codewreck.org> wrote:
>
> Christian Schoenebeck's suggestion was something like this -- I guess
> that's good enough for now and won't break anything (e.g. ACLs bigger
> than XATTR_SIZE_MAX), so shall we go with that instead?

Please use XATTR_SIZE_MAX. The KMALLOC_MAX_SIZE limit seems to make no
sense in this context.

Afaik the VFS layer doesn't allow getting an xattr bigger than
XATTR_SIZE_MAX anyway, and would return E2BIG for them later
regardless, so returning anything bigger wouldn't work anyway, even if
p9 tried to return such a thing up to some bigger limit.

No?

           Linus
