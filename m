Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF843B18D
	for <v9fs@lists.linux.dev>; Tue,  9 Jan 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55822753823so733607a12.2
        for <v9fs@lists.linux.dev>; Tue, 09 Jan 2024 09:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704820312; x=1705425112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74pgZ+nMyMyCi7Q0sf1ChPH+6TyfRgWiK4L8xKykjS8=;
        b=YaifskM4RTjQ1tQ0GEJyw8FxkqXtX5cA3tWGnCMnWtI1FxPSgSNvXF7JUOacv5Ty5m
         UKRDB9QvNaD6D9ZJHgdJN9jRGNPMoGZ+WJfvNTBAtEmnMjaxw42oRHX9H3leqGUCjwtv
         neU0AAU4S4fKKsbKiaDqPdSRrEhU5HYY1tBhsHZI0UqqHNp0TBHVLxKDVmG8+b59CIr2
         aMwR/S1uv6GD0RqWqlWrusfo4K7eFRX6W1++Ylq10qg/Wl0kcTFoVB1vhH2z4UK6dm/O
         ACeISWT802wyA76O/GctkcoXq7SVMJCZtP6IXQ0KmuyQUV5kv02tQ7rdT2SUsN7uukCl
         +B5w==
X-Gm-Message-State: AOJu0YxMfBH74RFsUiZC+asVfZXYqgbsrO/VHKX1cjXF3k24XeI4sg+1
	U+tt1YwMKd/6HXeO8CjhE6LZDXaDpAdDjw9T
X-Google-Smtp-Source: AGHT+IHScUSFW+BerkNOvwa9Kn0reY0XH7sLDhLUK9slMuYrFBu1MXHA75qRQcQtJUv8oQQaf4InpQ==
X-Received: by 2002:a17:906:3c07:b0:a28:a409:c1bf with SMTP id h7-20020a1709063c0700b00a28a409c1bfmr314435ejg.164.1704820312019;
        Tue, 09 Jan 2024 09:11:52 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170907174800b00a2a360d719fsm1234813ejc.221.2024.01.09.09.11.51
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:11:51 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a293f2280c7so365046466b.1
        for <v9fs@lists.linux.dev>; Tue, 09 Jan 2024 09:11:51 -0800 (PST)
X-Received: by 2002:a17:907:1c19:b0:a27:5397:74ed with SMTP id
 nc25-20020a1709071c1900b00a27539774edmr523050ejc.175.1704820311478; Tue, 09
 Jan 2024 09:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240109112029.1572463-1-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-1-dhowells@redhat.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Tue, 9 Jan 2024 13:11:39 -0400
X-Gmail-Original-Message-ID: <CAB9dFdt0haftd1LPo=_GmtcZvFR84w81eaARfUKW2KMSM5gxqg@mail.gmail.com>
Message-ID: <CAB9dFdt0haftd1LPo=_GmtcZvFR84w81eaARfUKW2KMSM5gxqg@mail.gmail.com>
Subject: Re: [PATCH 0/6] netfs, cachefiles: More additional patches
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:20=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Christian, Jeff, Gao,
>
> Here are some additional patches for my netfs-lib tree:
>
>  (1) Mark netfs_unbuffered_write_iter_locked() static as it's only used i=
n
>      the file in which it is defined.
>
>  (2) Display a counter for DIO writes in /proc/fs/netfs/stats.
>
>  (3) Fix the interaction between write-streaming (dirty data in
>      non-uptodate pages) and the culling of a cache file trying to write
>      that to the cache.
>
>  (4) Fix the loop that unmarks folios after writing to the cache.  The
>      xarray iterator only advances the index by 1, so if we unmarked a
>      multipage folio and that got split before we advance to the next
>      folio, we see a repeat of a fragment of the folio.
>
>  (5) Fix a mixup with signed/unsigned offsets when prepping for writing t=
o
>      the cache that leads to missing error detection.
>
>  (6) Fix a wrong ifdef hiding a wait.
>
> David
>
> The netfslib postings:
> Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.=
com/ # v1
> Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.=
com/ # v2
> Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.=
com/ # v3
> Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.c=
om/ # v4
> Link: https://lore.kernel.org/r/20231221132400.1601991-1-dhowells@redhat.=
com/ # v5
> Link: https://lore.kernel.org/r/20240103145935.384404-1-dhowells@redhat.c=
om/ # added patches
>
> David Howells (6):
>   netfs: Mark netfs_unbuffered_write_iter_locked() static
>   netfs: Count DIO writes
>   netfs: Fix interaction between write-streaming and cachefiles culling
>   netfs: Fix the loop that unmarks folios after writing to the cache
>   cachefiles: Fix signed/unsigned mixup
>   netfs: Fix wrong #ifdef hiding wait
>
>  fs/cachefiles/io.c            | 18 +++++++++---------
>  fs/netfs/buffered_write.c     | 27 ++++++++++++++++++++++-----
>  fs/netfs/direct_write.c       |  5 +++--
>  fs/netfs/fscache_stats.c      |  9 ++++++---
>  fs/netfs/internal.h           |  8 ++------
>  fs/netfs/io.c                 |  2 +-
>  fs/netfs/stats.c              | 13 +++++++++----
>  include/linux/fscache-cache.h |  3 +++
>  include/linux/netfs.h         |  1 +
>  9 files changed, 56 insertions(+), 30 deletions(-)
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-cachefs@redhat.com" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-cachefs+unsubscribe@redhat.com.

This passes our kafs tests where a few of the issues fixed here had been se=
en.
I made the framework use 9p and no related issues were seen there either.

Tested-by: Marc Dionne <marc.dionne@auristor.com>

Marc
