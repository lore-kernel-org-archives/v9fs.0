Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C44F5FC
	for <v9fs@lists.linux.dev>; Fri,  8 Mar 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884380; cv=none; b=WbUCC9TqOAzKXLNKc8PpXE1vu06wRKU+hurf3kK0s2JkdWJMznBTYVWSBPVPplqrUgweKz4DKQniKjTIXL0fZiK5urNJGj+rO+SFKa6ktQatAXXpCRXs3zGlMLP8APktBxlM0qOPzbaMX1mxOD2WUqbkKw5MYNLypxKBtCwdl/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884380; c=relaxed/simple;
	bh=sH4bAKDnIswJKnbTcqpk0Pb3FW7/UPFUpIR+aBApz4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4eNpgo59n+D3Z3cOvUFXsD0gzLn8SnYhp3z4TxsJMtXnL8h75dEQHgIUcuqZayrw1ctYLHuF+sxd8iTIO2XhOtcM0e2E4LTp/9GRWZj+YaUnYtRvnXcCAwsHbUxpX1NFntKf6Jt8STkNi9XyHZW8CivxViZ37S9tPZeVknYMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XfPB/wLx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XfPB/wLx"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44e3176120so244356966b.1
        for <v9fs@lists.linux.dev>; Thu, 07 Mar 2024 23:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709884376; x=1710489176; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hrvCXGaVO3HhvR4A5xt8TDit+qLJ9i7NLCGUzaXWqIQ=;
        b=XfPB/wLx85k3u2ujabDtmfYJjFTzayKaQrIuhvNetKOohSeBgHs/xm6qD0Jw97SJK/
         CPDGIKaJUD/myH2c+9ratvo1ha7hF4/0YycWLq6ExwffmcxPvSSXgdZO94E9kQNgxPXm
         fmdQtPY2g4D0+jQjUpsHWb5oKWR0MtFGD8LoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709884376; x=1710489176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrvCXGaVO3HhvR4A5xt8TDit+qLJ9i7NLCGUzaXWqIQ=;
        b=YVv9xrxEI3peTgxsJ4+3l7DpVtC0X7I9ow2RKjdmN8uOvK/2HxuGEHwhwOyHSDirrz
         Fd9uS6NdszXcFAGVciSxbOf9unwdewmjvtqRY0kxb/6n7sXQ7MCfTIvCZOFHsBfi8GP5
         y0hHXFq1XlFxQRtPLHJew9nJUBS+a7kJj+ikcDfj8KNXanOB35Rm2TsLSTDKYeWYQwtx
         K7B1i1sbcBGsX8OXEfD2LuWWLwEMyI/gRVg7NcG4mFUhkby1mZJOGWliDd4VEFLvziVC
         g6HesbvCNsVAxuKTjxNWhzcZARguZWOwXtnqp7RL1AgNHJBQid2KypZ/9n31tZHTyr0d
         U/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHHyI3p9hxxVme98EqBp25MVoqVfMOcS2E/ljWS5+AKCqvrPZiAF7VmvASZDWEP3QVo7qqcD2DJOENPN3OL+62pc6EiQ==
X-Gm-Message-State: AOJu0Yz/96aXAbWhhJRJ4rltT/GwntRd6SNxXtNriANPjpamAVjCugT9
	+vhU0Z2VA3jUZsTB0DcgUQ3APB0Hh63nJoy0oQRUYS0loJ9fM2kG4+6BNytVmHllakSKQm8MX8t
	SWzoyGsk9LGzF8dxR8fEyqaKyGT4xpQVyDQ7Fjw==
X-Google-Smtp-Source: AGHT+IGfxe+G6Hzhhm3qO2+tkAluEdwQIf++vT61Cv18s0V9jevPsUAy++K+ZRtxdczK/SgeeJRbLSjfJGJhUS+augI=
X-Received: by 2002:a17:906:a2cf:b0:a44:488d:8e42 with SMTP id
 by15-20020a170906a2cf00b00a44488d8e42mr13783793ejb.66.1709884376420; Thu, 07
 Mar 2024 23:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk>
In-Reply-To: <1831809.1709807788@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 8 Mar 2024 08:52:44 +0100
Message-ID: <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 11:36, David Howells <dhowells@redhat.com> wrote:

>  (2) invalidate_inode_pages2() is used in some places to effect invalidation
>      of the pagecache in the case where the server tells us that a third party
>      modified the server copy of a file.  What the right behaviour should be
>      here, I'm not sure, but at the moment, any dirty data will get laundered
>      back to the server.  Possibly it should be simply invalidated locally or
>      the user asked how they want to handle the divergence.

Skipping ->launder_page will mean there's a window where the data
*will* be lost, AFAICS.

Of course concurrent cached writes on different hosts against the same
region (the size of which depends on how the caching is done) will
conflict.

But if concurrent writes are to different regions, then they shouldn't
be lost, no?  Without the current ->launder_page thing I don't see how
that could be guaranteed.

Thanks,
Miklos
