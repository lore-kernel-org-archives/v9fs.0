Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A1538D
	for <v9fs@lists.linux.dev>; Tue, 24 Oct 2023 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqzJHfRE"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4a8737c4305so1730910e0c.2
        for <v9fs@lists.linux.dev>; Tue, 24 Oct 2023 00:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698131615; x=1698736415; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oqEDViZg3ewWb05nBr9MRK+4/rWk/WGbfau1EiuUjgw=;
        b=PqzJHfREPMm5HE0dk53qlG+H+ILJ4ahnxRCJ5V8RMFEe67SQN9YPFTVKHmcLDDwMn8
         jZd4Z0Wl5WTu20n268EGxNhuy0Iw1H6MT1Kr8AlUaTo5dTg6ZH7K+RWdaSWvuiPb3ihg
         xyURXT/qaDeoGsg0EIOQKaFqkMW2PC0iQw0jpvzWbXSP2QwZOeCkq4qNkzRBLlOHQu/0
         7MqJT09bn/yxR+ygJNuoGtr67cMN2HCQS3ZyGBD4c9bhsx87W2hYx0QZVa7+Mu2fxmM1
         SyFk2EUlJS6X2wum5D83hZWBwbzBCBwEetgTToV8aaelo6bG5S+Xvb3DCmRW+rDo0eaP
         c7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131615; x=1698736415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqEDViZg3ewWb05nBr9MRK+4/rWk/WGbfau1EiuUjgw=;
        b=DfwrhUM56qZa8sYMj8aEJHtS4uRBWp/yVC+JsDPaoh4eXffWE3amh1uQvnli2X3Gcr
         ywrmrYl9W0c1olIGkxtqsnKyCAX5mZ8ucao3Jazz4B3QMFhnySDZOdMcj/HM4QBNYtMb
         9b/PCSe9tS0gwLF45QsHKoFyfOzk8l312d/oJWFlxyJtZmqIYLfO+afwRqwxaOzj8EIG
         CMISsY1EVoaCQJ9igHsFUz9+E+gtkbru0bR3BqA/2FA0DqvHk/OH9VMUHsqoK5wHvJK8
         s/kxk5jXhDXCYKlrK5HPjeJFS90sd8AuG31KTnx8kt5CrJ6Flo7WUALxrw2BBLgtqsJQ
         J04A==
X-Gm-Message-State: AOJu0Yw6MaNyAUdJHQ08vLvh4b4afDwGUMTScFpjflWmxOn/Sqh5f0No
	5cUnstLfXYztKBUY8fT2disiu75wq3tkGLZpM+b0qQ==
X-Google-Smtp-Source: AGHT+IEha15F/HfbRonO5wCvAER08BRo9X+uEGgCV2C1H2ZIe+vmNmtIuZpQu5YqZMA3KogxFN2+5j+jpuOt8zWCu9k=
X-Received: by 2002:a05:6122:4682:b0:495:cace:d59c with SMTP id
 di2-20020a056122468200b00495caced59cmr5708011vkb.0.1698131615026; Tue, 24 Oct
 2023 00:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231023233704.1185154-1-asmadeus@codewreck.org> <20231023233704.1185154-2-asmadeus@codewreck.org>
In-Reply-To: <20231023233704.1185154-2-asmadeus@codewreck.org>
From: Marco Elver <elver@google.com>
Date: Tue, 24 Oct 2023 09:12:56 +0200
Message-ID: <CANpmjNOUSci41NssMKgrNjC5P0doPWPekiizMOfjrr11CV-ogQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] 9p: Annotate data-racy writes to file::f_flags on fd mount
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, ericvh@kernel.org, linux_oss@crudebyte.com, 
	lucho@ionkov.net, linux-kernel@vger.kernel.org, 
	syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Oct 2023 at 01:37, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> From: Marco Elver <elver@google.com>
>
> syzbot reported:
>
>  | BUG: KCSAN: data-race in p9_fd_create / p9_fd_create
>  |
>  | read-write to 0xffff888130fb3d48 of 4 bytes by task 15599 on cpu 0:
>  |  p9_fd_open net/9p/trans_fd.c:842 [inline]
>  |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
>  |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
>  |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
>  |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
>  |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
>  |  vfs_get_tree+0x51/0x190 fs/super.c:1519
>  |  do_new_mount+0x203/0x660 fs/namespace.c:3335
>  |  path_mount+0x496/0xb30 fs/namespace.c:3662
>  |  do_mount fs/namespace.c:3675 [inline]
>  |  __do_sys_mount fs/namespace.c:3884 [inline]
>  |  [...]
>  |
>  | read-write to 0xffff888130fb3d48 of 4 bytes by task 15563 on cpu 1:
>  |  p9_fd_open net/9p/trans_fd.c:842 [inline]
>  |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
>  |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
>  |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
>  |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
>  |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
>  |  vfs_get_tree+0x51/0x190 fs/super.c:1519
>  |  do_new_mount+0x203/0x660 fs/namespace.c:3335
>  |  path_mount+0x496/0xb30 fs/namespace.c:3662
>  |  do_mount fs/namespace.c:3675 [inline]
>  |  __do_sys_mount fs/namespace.c:3884 [inline]
>  |  [...]
>  |
>  | value changed: 0x00008002 -> 0x00008802
>
> Within p9_fd_open(), O_NONBLOCK is added to f_flags of the read and
> write files. This may happen concurrently if e.g. mounting process
> modifies the fd in another thread.
>
> Mark the plain read-modify-writes as intentional data-races, with the
> assumption that the result of executing the accesses concurrently will
> always result in the same result despite the accesses themselves not
> being atomic.
>
> Reported-by: syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com
> Signed-off-by: Marco Elver <elver@google.com>
> Link: https://lore.kernel.org/r/ZO38mqkS0TYUlpFp@elver.google.com
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>
> Hi Marco, sorry for taking ages to process this patch. I've reworded the
> commit message a bit and added a comment, so given this has your name on
> it please have a look.
> I'm planning to send this to Linus during the merge window next week

No worries, and thank you!

>  net/9p/trans_fd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index f226953577b2..d89c88986950 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -836,14 +836,16 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
>                 goto out_free_ts;
>         if (!(ts->rd->f_mode & FMODE_READ))
>                 goto out_put_rd;
> -       /* prevent workers from hanging on IO when fd is a pipe */
> -       ts->rd->f_flags |= O_NONBLOCK;
> +       /* Prevent workers from hanging on IO when fd is a pipe

Add '.' at end of sentence(s)?

> +        * We don't support userspace messing with the fd after passing it
> +        * to mount, so flag possible data race for KCSAN */

The comment should explain why the data race is safe, independent of
KCSAN. I still don't quite get why it's safe.

The case that syzbot found was 2 concurrent mount. Is that also disallowed?

Maybe something like: "We don't support userspace messing with the fd
after passing it to the first mount. While it's not officially
supported, concurrent modification of flags is unlikely to break this
code. So that tooling (like KCSAN) knows about it, mark them as
intentional data races."

> +       data_race(ts->rd->f_flags |= O_NONBLOCK);
>         ts->wr = fget(wfd);
>         if (!ts->wr)
>                 goto out_put_rd;
>         if (!(ts->wr->f_mode & FMODE_WRITE))
>                 goto out_put_wr;
> -       ts->wr->f_flags |= O_NONBLOCK;
> +       data_race(ts->wr->f_flags |= O_NONBLOCK);
>
>         client->trans = ts;
>         client->status = Connected;
> --
> 2.41.0
>
