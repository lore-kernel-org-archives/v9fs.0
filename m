Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53E3D97D
	for <v9fs@lists.linux.dev>; Tue,  3 Oct 2023 21:58:03 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 7E29CC020; Tue,  3 Oct 2023 23:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1696370274; bh=VaMPR9vTSeNuv9UUlAuWQrxY0o/yWBumBbUme/UtQSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2VlZnQFgPYscwuU/pQZTOyXezD4821oSbFctUhbb4g4ohKxF6x7ztA1Bkw0qHEzJ
	 hdwkfxcPRIBK79hdyHdQeM0EQpTQWX8N/3djGQOoopGQaQ8ObreLFwPRmTRJED9bH5
	 afcgP1jOjMHPOiE6PlvenYftH6sVhxXuxsSoQH5vrgGfDZYmycc8hGyisVP9MWRC6S
	 XPTOKHIeMMkEW41a70rMjnV5qRXu+sIioFx6phdhBm0IbHApdeqpdHZlkKwFlsjcqq
	 nnYmf8rllBtVv8/UWQp448KZxyePogqqMzr+ne0vXDoHvOE/29J6LtobARGuP8ZHbg
	 zW9zPt3hzuSwA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id D62F3C009;
	Tue,  3 Oct 2023 23:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1696370272; bh=VaMPR9vTSeNuv9UUlAuWQrxY0o/yWBumBbUme/UtQSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntNDqYJUj3LKdZOSYPLAxo7SwyvXz+PePGLQ45IvwZhnt2wpkxYD4aiLjXr4Igvub
	 boDbsOqDr7GeBojwmuO5WOyHVvWQ0i7pgeuw0nJp5JUdW4cTAlCzueDvcVwWcDpJ94
	 Se6Ra3D1jmd0iTqEe4SkYQivZEkJ/7Qs2fM0zLWh2pMPRkXUWiwk6FizZqZOWZzS27
	 2xnUy8qhRwbY0CEA8fn0jyB5qRruc0zZ6luV6Zoj9Up48R5Rqh/fb2id46ZzxzBF+3
	 MLqrrpJzmcS3HANBbUzuylNH1ywKCw0WJy+sq+lGUo5MxaJCzGn6yMCyI7G6d2irxN
	 grsR4aEmfW+OQ==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 3fe28c50;
	Tue, 3 Oct 2023 21:57:46 +0000 (UTC)
Date: Wed, 4 Oct 2023 06:57:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Subject: Re: [PATCH 03/29] 9p: move xattr-related structs to .rodata
Message-ID: <ZRyOSzUKFNOXaSZf@codewreck.org>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-4-wedsonaf@gmail.com>
 <41368837.HejemxxR3G@silver>
 <ZRfkVWyuNaapaOOO@codewreck.org>
 <CANeycqptxu1qWAHLc76krDmfgesANPX+FLEV51qhtXam6Ky9nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANeycqptxu1qWAHLc76krDmfgesANPX+FLEV51qhtXam6Ky9nQ@mail.gmail.com>

Wedson Almeida Filho wrote on Tue, Oct 03, 2023 at 10:55:44AM -0300:
> > Looks good to me on principle as well (and it should blow up immediately
> > on testing in the unlikely case there's a problem...)
> >
> > Eric, I don't think you have anything planned for this round?
> > There's another data race patch laying around that we didn't submit for
> > 6.6, shall I take these two for now?
> >
> > (Assuming this patch series is meant to be taken up by individual fs
> > maintainers independantly, it's never really clear with such large
> > swatches of patchs and we weren't in Cc of a cover letter if there was
> > any... In the future it'd help if either there's a clear cover letter
> > everyone is in Cc at (some would say keep everyone in cc of all
> > patches!), or just send these in a loop so they don't appear to be part
> > of a series and each maintainer deals with it as they see fit)
> 
> There is a cover letter
> (https://lore.kernel.org/all/20230930050033.41174-1-wedsonaf@gmail.com/),
> apologies for not CCing you there. I was trying to avoid spamming
> maintainers with unrelated changes.
> 
> We need changes in fs/xattr.c (which are in the first patch of the
> series) to avoid warnings, so unfortunately this can't be taken
> individually. My thought was that individual fs maintainers would
> review/ack the patches and this would be taken through the fs tree.

Please include all related maintainers in cover letter and any "common"
patch: I'd have complained about the warning if I had taken the time to
try it out :)

(b4 made it easy to download a whole thread, but it was't obvious this
was required -- I honestly prefer receiving the whole thread than too
little patch but I know some maintainers are split on this... At least I
think we'll all agree cover letter and required dependencies are useful
though -- I now see David Sterba told you something similar, but only
after having written that so leaving it in)

By the way the shmem patch failed to apply to 6.6-rc4 and will need
rebasing.

With all that said, I've taken a few minutes to check it didn't blow up,
so:
Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus
