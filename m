Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9017CF
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EauMH4RY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0429C433C9
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 04:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704513707;
	bh=WNcyVpXG1GRWrFI76+0GZQpjvd9G/dLNIDNFxT5d8Xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EauMH4RYqzl87Xy09YM76DIsTVTV3uIESymhVGxJiGcqzY8ERVKJFOX2hfvmbsFzF
	 APSXuXH2uxBpdFgt0+NgSN20svXw2Y72Rp8O+LmW91c14WGV4BSSH1JNJCYpOkgSZp
	 IPxeXt/a5Wh9llYZem454tuH85+gM1kt57t3dScJox6wPgvt+a5XvrC2tDnJIHQkzh
	 /Pfalx/AU9Lc86a1KEj/5EqRk0tXc5egV3vSrZMZ2PS2m4sLLV+ap5X67UMkIgM23V
	 /J/dUcA4bf0rpKNqj4zCV+IYlSILoHl1QSlvqSic2asFdIvfze3Sy24aoFp57zfKnE
	 wpWM9y4dEuoRw==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso2060907b3.1
        for <v9fs@lists.linux.dev>; Fri, 05 Jan 2024 20:01:47 -0800 (PST)
X-Gm-Message-State: AOJu0YyZqOawekmR4WkTMw8HmwbCJokNgTArQnQeDNpM2el6mzYZn9TL
	6RXIEKfuN1asKqboETEe1mBSfbrBo6dhy9g1WGo=
X-Google-Smtp-Source: AGHT+IE/rOfuwYu8sCE3ZLUi5QGX1lv6+Ej945Qb/9B+UHw10MeTNfMVlmEboTh4o/E7p615E+F12xdirbIsf/aVP+8=
X-Received: by 2002:a5b:f0e:0:b0:db5:1c85:86cc with SMTP id
 x14-20020a5b0f0e000000b00db51c8586ccmr137692ybr.39.1704513706872; Fri, 05 Jan
 2024 20:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org> <20240106-ericvh-fix-cache-dups-v1-1-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-1-538c2074f363@kernel.org>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Fri, 5 Jan 2024 22:01:35 -0600
X-Gmail-Original-Message-ID: <CAFkjPTn4aFieUDkN-cysxjSk8VSi+dUdffS=gbEu8LaSESMkmw@mail.gmail.com>
Message-ID: <CAFkjPTn4aFieUDkN-cysxjSk8VSi+dUdffS=gbEu8LaSESMkmw@mail.gmail.com>
Subject: Re: [PATCH 1/9] fs/9p: future-proof qid2ino 32-bit support
To: v9fs@lists.linux.dev
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Ron Minnich <rminnich@gmail.com>, Latchesar Ionkov <lucho@ionkov.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ooops -- realized after I sent the series out that this one can be
dropped since I completely switch up the format of qid2ino to a macro
in a future patch.

On Fri, Jan 5, 2024 at 8:11=E2=80=AFPM Eric Van Hensbergen <ericvh@kernel.o=
rg> wrote:
>
> The qid2ino code had a check to allow a reduced precision qid to inode nu=
mber mapping, but it only checked if the sizes were
> equal.  Change to check if the ino_t is smaller than qid->path
> before using the reduced precision version.
>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/vfs_inode.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index b845ee18a80b..6d149ba12bc0 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -1192,18 +1192,25 @@ v9fs_stat2inode(struct p9_wstat *stat, struct ino=
de *inode,
>   * v9fs_qid2ino - convert qid into inode number
>   * @qid: qid to hash
>   *
> - * BUG: potential for inode number collisions?
> + *  We add 2 to qid->path to keep reserved inode
> + *  numbers reserved.
> + *
> + *  Its possible in the future we will make qid->path
> + *  just a hash to lookup inodes, but this breaks too
> + *  much right now.
> + *
>   */
>
>  ino_t v9fs_qid2ino(struct p9_qid *qid)
>  {
> -       u64 path =3D qid->path + 2;
>         ino_t i =3D 0;
>
> -       if (sizeof(ino_t) =3D=3D sizeof(path))
> -               memcpy(&i, &path, sizeof(ino_t));
> +       WARN_ON((qid->path+2)=3D=3D0);
> +
> +       if (sizeof(ino_t) < sizeof(qid->path))
> +               i =3D (ino_t) ((qid->path+2) ^ (qid->path >> 32));
>         else
> -               i =3D (ino_t) (path ^ (path >> 32));
> +               i =3D (ino_t) qid->path;
>
>         return i;
>  }
>
> --
> 2.41.0
>
