Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC703FE1
	for <v9fs@lists.linux.dev>; Tue, 24 Oct 2023 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykemZekV"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7a7e11a53c3so3435965241.1
        for <v9fs@lists.linux.dev>; Tue, 24 Oct 2023 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698133811; x=1698738611; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZE7XIsMiCUi3JKd3SPomLA7US0XZO9rx0ByHQaJB4g=;
        b=ykemZekV/aptgZ+lNuZUKj25YhxCCP41dZk6Adg2fOs/Vt5jenQkmRXtM2p6wtQHkg
         aiaD5VkHdKBJqPYKd8ogyCZ4ZRJgBE6Mef9dzdgQzt3cibjABzKKjFQpLIel1SA1cyLs
         CwdEFLfDzK8hA/68EMBFcxNOr+cRFj1s4ocnYTh/Z3QrGJM9dQLP08ttyIXgVuiU9pPZ
         45a87r08NPrhKL7E75aB9YfCAC7YtDOj0TBbmGYj7Jn03CdlUC1vMKeNxgsX4Fy6Cab0
         E8wNu2aSWNGKdqVcGDDLrNZ8DjkNoDYlpTNaJmO5yyfHe5iDoYq0SqPna3BskHG1PhOy
         wFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698133811; x=1698738611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZE7XIsMiCUi3JKd3SPomLA7US0XZO9rx0ByHQaJB4g=;
        b=jgkMpnXgv+c4uAyWrxRd6NWq8d0eANeykaesAIUgMhQ7YrDT7cUCFMDITk9hnEvav5
         MTmP+3S4r9ieCzOE3hT0uvQFjpOPSeJJ28J+eOOMN6lK2GUsmoxFX85aEB8HLuhT0EfD
         tY93jodmWroo4ksEAgg9oZuD7BFVcU7fQKhw1SVyuoJkuGuThM/4mU7gGFWkyTfa+hSM
         SRZdoA4XpRsprmk2jb++JWtH+u/FqcJfW7ZN4GeRTdbwawnP8cTIjMmLYvwRswF2j2kd
         GOgvc8YI1/GD1l/+AMmqIdWn9bkyHuXgERjd3vWUihSzoRxtceA3LmN3psy2FzIZvVmK
         ITJg==
X-Gm-Message-State: AOJu0YxMcQNYVi+fkZi91PgpfPZGWm5Wh4J5pybD2XUA1zkw9yEbSG/8
	GbKQ8ubiiWMmVEljuqDgcQ+CHC794RJNzPgYhfPUIw==
X-Google-Smtp-Source: AGHT+IGwu9GdRFq9XAPrEmJXirS3r9/lI8b9aPDEJowUtsOtQk6U/vdFv5hY2u/1EpolLmaMqiH76eXmOaINFL+gqyU=
X-Received: by 2002:a67:c896:0:b0:450:cebb:4f15 with SMTP id
 v22-20020a67c896000000b00450cebb4f15mr6824109vsk.1.1698133811022; Tue, 24 Oct
 2023 00:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
 <20231023233704.1185154-2-asmadeus@codewreck.org> <CANpmjNOUSci41NssMKgrNjC5P0doPWPekiizMOfjrr11CV-ogQ@mail.gmail.com>
 <ZTd13Eh1ryuyQqyr@codewreck.org>
In-Reply-To: <ZTd13Eh1ryuyQqyr@codewreck.org>
From: Marco Elver <elver@google.com>
Date: Tue, 24 Oct 2023 09:49:32 +0200
Message-ID: <CANpmjNMGbzg7MLFY-hpA0=bt24bMkmfTE9cvSjWTVLLG20WLNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] 9p: Annotate data-racy writes to file::f_flags on fd mount
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, ericvh@kernel.org, linux_oss@crudebyte.com, 
	lucho@ionkov.net, linux-kernel@vger.kernel.org, 
	syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Oct 2023 at 09:44, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> Marco Elver wrote on Tue, Oct 24, 2023 at 09:12:56AM +0200:
> > > diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> > > index f226953577b2..d89c88986950 100644
> > > --- a/net/9p/trans_fd.c
> > > +++ b/net/9p/trans_fd.c
> > > @@ -836,14 +836,16 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
> > >                 goto out_free_ts;
> > >         if (!(ts->rd->f_mode & FMODE_READ))
> > >                 goto out_put_rd;
> > > -       /* prevent workers from hanging on IO when fd is a pipe */
> > > -       ts->rd->f_flags |= O_NONBLOCK;
> > > +       /* Prevent workers from hanging on IO when fd is a pipe
> >
> > Add '.' at end of sentence(s)?
>
> I don't think we have any rule about this in the 9p part of the tree,
> looking around there seem to be more comments without '.' than with, but
> it's never too late to start... I'll add some in a v2 after we've agreed
> with the rest.

Sounds good.
I think if there's 1 short sentence (1 line) comment, it's more or
less optional. But I'd insist on punctuation as soon as there are 2 or
more sentences.

> >
> > > +        * We don't support userspace messing with the fd after passing it
> > > +        * to mount, so flag possible data race for KCSAN */
> >
> > The comment should explain why the data race is safe, independent of
> > KCSAN. I still don't quite get why it's safe.
>
> I guess it depends on what we call 'safe' here: if we agree the worst
> thing that can happen is weird flags being set when we didn't request
> them and socket operations behaving oddly (of the level of block when
> they shouldn't), we don't care because there's no way to make concurrent
> usage of the fd work anyway.

Yes, that's reasonable.

> If it's possible to get an invalid value there such that a socket
> operation ends up executing user-controlled code somewhere, then we've
> got a bigger problem and we should take some lock (presumably the same
> lock fcntl(F_SETFD) is taking, as that's got more potential for breakage
> than another mount in my opinon)
>
> > The case that syzbot found was 2 concurrent mount. Is that also disallowed?
>
> Yes, there's no way you'll get a working filesystem out of two mounts
> using the same fd as the protocol has no muxing
>
> > Maybe something like: "We don't support userspace messing with the fd
> > after passing it to the first mount. While it's not officially
> > supported, concurrent modification of flags is unlikely to break this
> > code. So that tooling (like KCSAN) knows about it, mark them as
> > intentional data races."
>
> I'd word this as much likely to break, how about something like this?
>
>         /* Prevent workers from hanging on IO when fd is a pipe.
>          * It's technically possible for userspace or concurrent mounts to
>          * modify this flag concurrently, which will likely result in a
>          * broken filesystem. However, just having bad flags here should
>          * not crash the kernel or cause any other sort of bug, so mark this
>          * particular data race as intentional so that tooling (like KCSAN)
>          * can allow it and detect further problems.
>          */

I think this sounds much clearer. Thanks!
