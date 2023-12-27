Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72254653D
	for <v9fs@lists.linux.dev>; Wed, 27 Dec 2023 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdPS9y1l"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e734d6cbe4so43022567b3.3
        for <v9fs@lists.linux.dev>; Wed, 27 Dec 2023 10:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703700474; x=1704305274; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFd4G9rmsxMs5BM7zOeY+8z1QgmIi4Fu3BnW1NgXxSU=;
        b=TdPS9y1lxBmGrmRJ61oKF+C4PT+pzIwyU/L3ZjqrKpO6189hnUcsFOGUbNeu3S3QWl
         ov7H0Wvp1mhCvNLZ60DWg2lJb9pUfFZsm0JvD8Z0/F68QyE7pcfvy3cLyGNwzuI4ILl3
         euZ4PZhXmuYjkzGRo/Gebyz3pZOystsid6udZho/m3KplnOlUltPCRMvDrAoSzXbaX8S
         oA6N6D0EGOxihzkN5HFyQ8yF7cHYXATqXAy5uPsnA7l3tEtwjkxOtyOyfpo8SQQrbrwx
         fomz0OQIoIYAbJ3DHjoyk+Z00Mp4chCFcN5T99x7L0QzBCkCGvOPhms7c9pu5Crf4sOK
         bcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703700474; x=1704305274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFd4G9rmsxMs5BM7zOeY+8z1QgmIi4Fu3BnW1NgXxSU=;
        b=IDA6WCBUO4DQz6+eBhjAEvhvfRf51qWJOTCQGPT8JJ9791w8gG6bUQ/ITar6o717hf
         BASrB8sMBvpiUzWqQQDWRhi+Gf1ACn0ooiXlG4IicR14WHVy5vQe5xhIbQK+kWJ5Sx5a
         gef4day33GkbyBNBGgbDeNZyj4KbDtsR1jNOGADfSCJ9VSEPGh4X0HSC+6qdY9VLu2OS
         svyMOs6V1m6SDgA5TGubS5dZKh34Judcr2ilp0fzzb/Z+s61t5yXp47GX0bopq8OGd21
         M+Ox+nQKvasEsNzwFizhFsSI79Sc1Wq7fEj6z2KbqJJBcViSnzEGh2exPGhZf9WkztSj
         DdJw==
X-Gm-Message-State: AOJu0YwUNsEX4nvsvoI7V93hhyWU/P/uV/9hJ328y/zPKG6MZeR9gJLx
	L3Ak/7vcXAoa/xRylf7w3eHsNBMdsmLyL7rCPrI=
X-Google-Smtp-Source: AGHT+IHqVpywFuXgM20LcrgqY7E6/YBVI4HgTARQ7ElPW3NEq+h54OM3WvBGVeuhKCbvhOTvRGHegnsrKceR1JLEdIo=
X-Received: by 2002:a25:df07:0:b0:dbc:d90f:95f6 with SMTP id
 w7-20020a25df07000000b00dbcd90f95f6mr5415081ybg.66.1703700474509; Wed, 27 Dec
 2023 10:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <ZYvcBbcNOHEQ-JMw@codewreck.org>
In-Reply-To: <ZYvcBbcNOHEQ-JMw@codewreck.org>
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: Wed, 27 Dec 2023 12:07:43 -0600
Message-ID: <CAFkjPTnc89-DRbmk_apwpZgf_p2bcOe1gktdReWYBBnVHZKpwA@mail.gmail.com>
Subject: Re: cache fixes (redux)
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, Christian Schoenebeck <linux_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 2:11=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Eric Van Hensbergen wrote on Tue, Dec 26, 2023 at 10:13:20AM -0600:
> > - The fact that we never seem to use multi-walk (this isn't a cache
> > specific problem, it actually is somewhat worse in non-cache mode).
> > This seems to be because fid_lookup goes recursive before entering
> > multiwalk.  This should be a fairly simple fix - I'm just going to add
> > an argument to limit recursion, but I'm noodling on whether we need
> > that path a bit first.
>
> I'm not sure multi-walk is possible in practice: even opening a file
> directly through e.g. cat /mnt/long/path/to/file will have the VFS check
> permissions along the path, so the VFS will need to stat all elements
> along the way.
>

Well, the server will do perm checks (ideally on walks), so do we
really have to?  Feels like overkill to check in both places, in
principal we expect/assume server perm checks.
>
> > - figure out why even in loose mode we seem to be sending a lot of
> > stat/getattr -- this seems to be related to some code that came in
> > with the cache code.  It seems we almost always stat/getattr because
> > we are constantly creating new inodes.  There's some comments in
> > vfs_inode.c:755 that talk about needing to do this for parallel lookup
> > -- but this all seems like a hack.  Anyone have better insight into
> > why we need this?  We always to the stat/getattr to retreive the stat
> > to compare against because we don't trust qid.path -- which I think is
> > wrong.  If there is an issue with unlinked files, I think we can do
> > something smarter to differentiate them, maybe using a qid.type
>
> Hmm in loose mode we definitely should be reusing the inodes...
> No idea why we had this in the first place, I'd say rip it out and
> compare?
>

Yeah, I was thinking of using one of the unused qid bits to mark
negative inodes so we dont collide on lookups after unlink (although I
dont know how often this ever happened and some of this will be more
straightforward with all fids tracked in inodes versus dentries).

it did strike me that inodes are only unique per filesystem and I
doubt the servers guarantee uniqueness across underlying mounts - but
in principal we shouldnt have to rely on looking up inodes by qid.path
anyways=E2=80=A6.however nothing I=E2=80=99m planning on should make this w=
orse, but
something to keep an eye out for.

> >      - QUESTION: it seems like P9_QTLINK and P9_QTSYMLINK are no
> > longer used, can these be recovered?  I was thinking of reusing one of
> > these to mark unlinked files which we could do a more comprehensive
> > compare for if its actually necessary.
>
> Since we don't support reconnects, unlinked files have been working just
> fine with servers that keep the underlying files open (e.g. qemu)
>
> What's your plan exactly?
>
> We don't have any way of driving protocol changes forward (and there's
> no compatibility negotiation on client connect...), but I recall
> Christian also was looking forward to some other changes so we might
> want to try to move this forward again...
>

Well, those bits unused (I think) so shouldnt be protocol change.
However we can bump to
new protocol when necessary (9p2024?  its been 23 years, why not?).
big on my list would be qid.path -> 128 bit and qid.version -> 128 bit
and maybe include filesystem uid in qid to differentiate underlying
mounts and maybe i_generation.  This would help with cache maintenance
and uniqueness concerns.  I=E2=80=99m also thinking of how we might handle
security differently (use kernel TLS, public key auth integration,
etc. although those might not require protocol changes).  i=E2=80=99m also =
in
favor of dirread senantics for cache modes so we retrieve attributes
with the file list.  What other things should we be considering?
maybe time to start putting together an RFC.
Its probably worth driving things like qid changes together with the
Plan 9 community versus making 9p2024 a linux-only version since there
are still folks using and larger qid space is likely a reality on
newer systems).

       -eric
