Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1DC72618
	for <v9fs@lists.linux.dev>; Wed, 15 Apr 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243722; cv=none; b=CJbIH5W1cg40YL/D6oqXWj8doiQ9xA+xYB+Bgt7f0MN/nzZrZA3jdX1UmcbhKmq5cEMG5yMOmIpQNrSd5cFF73ny94aDs0JdQPhXvpnGVLUqG9a63Q8WKanjnXh/muoL5gRWRKLnP5qf3gAL11kYqOwfktLokM/ggwRkXvtLN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243722; c=relaxed/simple;
	bh=6Veu3+OJTF13t1/QXFGJ7fP5M24qm+9jH9gWhW6qe/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyK7dZwCqSplpEOOHRaAxns5Nm6EKLMmprxFLi3KuRCUh44XnevFvUdEY5BY5poIM2vbIc24StqRh6hCzjjIdKR+8zRUEyiaKFh2ZF0ptwZmBXBXtGBuigKjUHPx6F4s70lW5tQ4Sb8xOHsSjXKO8NRj9Z83OJiA3ahwVC8AOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP01i8sQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP01i8sQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d70c30767so2062673f8f.0
        for <v9fs@lists.linux.dev>; Wed, 15 Apr 2026 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776243720; x=1776848520; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlGudTqrzaNt1I4lqmhLbwqt94V5J4w43GUmCskM5sw=;
        b=iP01i8sQQGTQRNZ8iwusex257PkvRxnzGCMlECqXJ7pSp6Fpu7wVMcNKFPWSvO8/uS
         ksFN+zsKUylU4b8fGKkMGFSabM6ZCCn2I91cZjF/KI1YhU7Gg+jjVhM5et92yLiwXIZM
         pUnhSISpoIz79BDFEjjwqdvKcc1VMrix2jQIqZyM6dgdCKxLQEZZZULEOm3QFw1UZbt3
         vZI7CfBnolh0ry7Kng6s3SKNMGPYjWZz6QjQeOdZc+UnWIgqA+qgQszmOXPHggi+QMOg
         P8SsrkIMt1dCwcD40SLK3coS7GH+yDMCoOUCTd+yIVLZgS+RkpFmk9N6hUxZNoqvOjuu
         RZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243720; x=1776848520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IlGudTqrzaNt1I4lqmhLbwqt94V5J4w43GUmCskM5sw=;
        b=h/lvAxydV2vSLeO6KMlYTypLg4EDwax3OjMyQWdpDKXYmx2JJ4+zK99egZHR2RAeXr
         Mfy9T83a20T2KKwqAmoyJagh7/VTS+mHNQNaBOdSnM6W9S47MSwl0dAIvWdFaflv35lM
         EaVjYIdfO08pD09UcKN+YQcPFxwUW/aHp1H/KNRe7tplQZwjxAjT2iMLhdv3Uw7fzpHu
         JybZV0bCn8pHn1zZreDGMcObtMK/o3LA7D7YW6I4GyhD/AkTaKBm/XddgmQiwk5w8F4N
         PKjiPjOkC3YiQutnXvRFe4+WUnJb2vJ0/lmL4VKdObM3U7k6ghco+lUxrS8JFQ96uSgr
         L5Uw==
X-Forwarded-Encrypted: i=1; AFNElJ80hSbtZ0pBCk4MEKjzsoHhtGr4VJ8CpNEVCD5XcGxEsHGb5AeiwiVp18FuSO/6qKv+YKwm@lists.linux.dev
X-Gm-Message-State: AOJu0YyfVDyzLOBDmOy/W2NLYYIUv+2hsY47vvzBH3AS19F1r0hwlggl
	AgtD7EoXj4LlAPzoXqOv8QLMuS4TLpkYmSIq+RfYxIESHASptCGpj37yWS0ns51H
X-Gm-Gg: AeBDietRlncuTuZvSOsctWyyVqiks2/ASAaiQZd3kXUiLeVtcNdrz8zm6UEtSJaXaP7
	f7xnv1BkSAXmKQvWhiGpKglQK+i2gw7+LZGFgbL4+jGC2SjYGM3FFYLX8cEyE4NPwx6EigzPrQ7
	+8tywJjQPWlekAKTdoXHygjZZJGkUaeOHW2n4dTX+NwIbWbgEJMwN2CbYq5RXrZgztRG5t8WwlO
	Xwt9PP0+9wTFzooebKK/gIselUFqOtfrpkxn48mX9t5+6e7mVvz/bJKne9DfYD6YHfO8cC8x8GJ
	Isyp54EorKbd3t7V56s2/jS2K7KEd6d9jkzMhvOHFUC5te3b0bceOqbzh1i5xXEyBOwkGYnROxd
	xDLldoFtDQkK9rx75PaizyC3sT+8pwhtjgzWFHPcPBadn0HcoDtNx7ARZwssjipBbcb4l42s/iT
	NeM1HcJtU7jxXqDEsD+e0Jstksfaziz89Ul3ujGY5vGZx0cXh+9A==
X-Received: by 2002:a05:6000:1868:b0:43d:7874:5d3b with SMTP id ffacd0b85a97d-43d78745de3mr16241424f8f.9.1776243719489;
        Wed, 15 Apr 2026 02:01:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d6desm3944547f8f.3.2026.04.15.02.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:01:58 -0700 (PDT)
Date: Wed, 15 Apr 2026 10:01:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Pierre Barre" <pierre@barre.sh>
Cc: "Eric Van Hensbergen" <ericvh@kernel.org>, "Latchesar Ionkov"
 <lucho@ionkov.net>, "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: use kvzalloc for readdir buffer
Message-ID: <20260415100157.4aa33364@pumpkin>
In-Reply-To: <06399e04-b019-4c3d-b941-5771b6ac33c2@app.fastmail.com>
References: <06399e04-b019-4c3d-b941-5771b6ac33c2@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 07:45:08 +0200
"Pierre Barre" <pierre@barre.sh> wrote:

> The readdir buffer is sized to msize, so kzalloc() can fail under
> fragmentation with a page allocation failure in v9fs_alloc_rdir_buf()
> / v9fs_dir_readdir_dotl().
> 
> The buffer is only a response sink and is never pack_sg_list()'d,
> so kvzalloc() is safe for all transports, unlike the fcall buffers
> fixed in e21d451a82f3.
> 
> Signed-off-by: Pierre Barre <pierre@barre.sh>
> ---
>  fs/9p/vfs_dir.c | 2 +-
>  net/9p/client.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index af7f72abbb76..487c177aae38 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -70,7 +70,7 @@ static struct p9_rdir *v9fs_alloc_rdir_buf(struct file *filp, int buflen)
>         struct p9_fid *fid = filp->private_data;
> 
>         if (!fid->rdir)
> -               fid->rdir = kzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);
> +               fid->rdir = kvzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);

That code isn't really well thought out at all.
The default for buflen seems to be 128k + 24 - 24.
struct p9_rdir adds another 8 bytes, I'm not sure whether that doubles it to
128k or just adds an extra page (which might be 64k not 4k).
It also looks as though the user can specify an arbitrary buffers size (min 4k).
So who knows how big that (and other associated) buffers actually are.

The buffer seems to persist across readdir() system calls.
I can't see any code that might attempt to honour seekdir().
I hope there is a global lock that stops multiple threads issuing readdir()
on the same fd in parallel.

	David

>         return fid->rdir;
>  }
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index f60d1d041adb..6d9b9054841e 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -765,7 +765,7 @@ static void p9_fid_destroy(struct p9_fid *fid)
>         spin_lock_irqsave(&clnt->lock, flags);
>         idr_remove(&clnt->fids, fid->fid);
>         spin_unlock_irqrestore(&clnt->lock, flags);
> -       kfree(fid->rdir);
> +       kvfree(fid->rdir);
>         kfree(fid);
>  }
> 
> --
> 2.51.0
> 

