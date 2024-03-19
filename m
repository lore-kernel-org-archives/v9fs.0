Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766DF9E5
	for <v9fs@lists.linux.dev>; Tue, 19 Mar 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866473; cv=none; b=lqLPvCn5foUlQH7w8gGCW0i5O8KGITUPLc02e5tXXroYKAjlTkvVRxKXmIzKZetZB0DR33yYsJMQ++l1VyTaD2EMAr4u0XphC1QvTqgr2YrcB8cHCoFVnwXrhP2v3Lbh2kfBEeN63sIyiaso51ztaYEKSqX5jplu0wxJJcVpRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866473; c=relaxed/simple;
	bh=nRp7+YyTBHw31NX7xj7EtsXhg3dkAR+p6w1ZMt+sOEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThEpqmgwh85lGDivYXOnw1GbijIkET8zgTgFNC7ANOMoAyn1Dcr6FhulTKQMdkgphbhmzfnXCc6/sY0QBYN5xhOcsZ4LmkFG7TnWAS/l7XadJNGxcqoT+JOmuFUtAL8Ph4fYHdTYepw0yhKUv7jyRjoKOLWCqh7KHbyTrsCesKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LX6KDbRI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LX6KDbRI"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56ba72fffd6so328593a12.1
        for <v9fs@lists.linux.dev>; Tue, 19 Mar 2024 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710866470; x=1711471270; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=LX6KDbRI2kWb42hsSLXduAp4nrHfgws2azIQyh/Lm3Tcb3bRozDwE8UawChfvtkW3Y
         FaOnfANW9nwM1Pf8xnSBAnFvXPxQOdGVFzNhKKJ6jexhLYOPxqbg80SA5AI2jRw1gq15
         p9eiVjsEVUsMLerQFgkPS0JENJEGfEibWnSVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866470; x=1711471270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=c8IMV7V0JdncdgodAxaWGdXW2o/jD+H0NJV2huksyOdMh+kQsl6QiEAD136ImD2iHF
         NfwKDaGf1W471fOlQC8eXT7fsVsRZW93x7NZGJI9VRV4er+h+SORuS21QSFFBjuCrC+v
         AGDYA+oUTxoAmdoRObJXNdab79O/jkBYqZYoFlMCfKKioR42ElE/zUHXHIc1di0NTHP3
         Pj1Q8oFj5nim4t593oi/ENWwZUjIxHHLMuNUcShl02oSl2BZX+xirpS4tfBcZ2MYMwge
         76R1h/IcKFYZdeZYRTx6v7RPhyEGFPLiNJbCxhLVaWkfS80raPBGSFnnBBdKoFxd6lpJ
         n2gA==
X-Forwarded-Encrypted: i=1; AJvYcCUuXZMj25Ok7xwBRUUsCwVXOc2PIZHbWipAvLFOAl4ecpWLDLOp0DFTxVFMkeg0t5wY+nJ2J9GqQiEO/CCduQFHMedwfA==
X-Gm-Message-State: AOJu0YxEE/jkhyvQifD7kKMTnV7CJvE+zD58qAwbT0st3kX3J0T7vq2F
	YUeVzrz1Vj4zz8deNQBf3ERqGUfzCyYDh2nwAhVaiHytBTMFDb3ZfVapFBYue1JSqhJ1AneP4cU
	SeKYYYK4fLQrtGNpjxN0tr5bost+LwafULDhR/Q==
X-Google-Smtp-Source: AGHT+IFDeEEaIOtSBG5DGppYGHWRw4rXZqpgILKwzYCMW4SSXhcYWj+KFRDuw5xeuXxFLrQ0w0/J7Jaydr+ESekL/l8=
X-Received: by 2002:a17:906:70c9:b0:a46:6bb8:1ec4 with SMTP id
 g9-20020a17090670c900b00a466bb81ec4mr8429584ejk.76.1710866470240; Tue, 19 Mar
 2024 09:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk> <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
 <651179.1710857687@warthog.procyon.org.uk> <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
In-Reply-To: <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Mar 2024 17:40:58 +0100
Message-ID: <CAJfpegsCBEm11OHS8bfQdgossOgofPcYhLTFtw7_+T66iBvznw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 17:13, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 19 Mar 2024 at 15:15, David Howells <dhowells@redhat.com> wrote:
>
> > What particular usage case of invalidate_inode_pages2() are you thinking of?
>
> FUSE_NOTIFY_INVAL_INODE will trigger invalidate_inode_pages2_range()
> to clean up the cache.
>
> The server is free to discard writes resulting from this invalidation
> and delay reads in the region until the invalidation finishes.  This
> would no longer work with your change, since the mapping could
> silently be reinstated between the writeback and the removal from the
> cache due to the page being unlocked/relocked.

This would also matter if a distributed filesystem wanted to implement
coherence even if there are mmaps.   I.e. a client could get exclusive
access to a region by issuing FUSE_NOTIFY_INVAL_INODE on all other
clients and blocking reads.  With your change this would fail.

Again, this is purely theoretical, and without a way to differentiate
between the read-only and write cases it has limited usefulness.
Adding leases to fuse (which I plan to do) would make this much more
useful.

Thanks,
Miklos
