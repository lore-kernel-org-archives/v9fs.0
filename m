Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A43C28
	for <v9fs@lists.linux.dev>; Sat, 30 Sep 2023 09:10:01 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 501DAC01F; Sat, 30 Sep 2023 11:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1696064620; bh=59HjiSLDEo3+ACXnA5m66IoUgd/1egFkIi0M5pdESts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBVy22hfrzzimlLx4ac3xF3glYA5pDuixrF+XOfESrcnRhN3mrpcPyqPqAnPjr8Go
	 En/swRkI5QFSkym6/De8FjPwMuP/s/QpKjXyMbz2ZVaf2vTUOWsWXSkdI/LFzo1Ocg
	 H40djEZSB8cM9e5t4B5UQuQcvofll6DBWPl+4sNDf58EbdRVLJ1eksS+sxmp7AThha
	 TfHNEFnqe8Os66YWaL+nno5snduCrgv3mnSdSf+gjihHsE+Ys1Lgi5fLdTq997E0I0
	 uZLCunzIbtA7o1u8G+ChCHSaU45aREsaUiUrrliWqU7tLQczC3NdY3v3QkiPtcuAyN
	 e3t0TtKk0CUYA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id C7991C009;
	Sat, 30 Sep 2023 11:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1696064618; bh=59HjiSLDEo3+ACXnA5m66IoUgd/1egFkIi0M5pdESts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iw0vHfxRkAHS1WfrcDJdZmjG5MMjaNPpGr+3uo2ujOYAGp3KLHj8VUDhrDJ8oEcAF
	 U+os1aA5XJxPhVIujNlfifVYvjhaXAq7KmE6+k2mRxHb4ze+GDNotHcNxGYz8N8cwT
	 pO3zg2egZxTOYHxeTGHqh7x89o2ajW6Gu/n7iOqaicYyiybcQYPlxKHauFsfzOzAmk
	 Hw/6RjA3H6k+sDKaLW68ayZplMEcli3uBwdIvitEAEKQNDmkvwkF0sXT/5zpMu834h
	 1DtzBTRnq8lk8yDcEI7rTlkgIXpVl35SC1uPl61GCTfUq9W+l6bBk0h0/htYLHeyAO
	 mkQdNslNkGyUg==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id bceda604;
	Sat, 30 Sep 2023 09:03:32 +0000 (UTC)
Date: Sat, 30 Sep 2023 18:03:17 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Subject: Re: [PATCH 03/29] 9p: move xattr-related structs to .rodata
Message-ID: <ZRfkVWyuNaapaOOO@codewreck.org>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-4-wedsonaf@gmail.com>
 <41368837.HejemxxR3G@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41368837.HejemxxR3G@silver>

Christian Schoenebeck wrote on Sat, Sep 30, 2023 at 10:12:25AM +0200:
> On Saturday, September 30, 2023 7:00:07 AM CEST Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > This makes it harder for accidental or malicious changes to
> > v9fs_xattr_user_handler, v9fs_xattr_trusted_handler,
> > v9fs_xattr_security_handler, or v9fs_xattr_handlers at runtime.
> > 
> > Cc: Eric Van Hensbergen <ericvh@kernel.org>
> > Cc: Latchesar Ionkov <lucho@ionkov.net>
> > Cc: Dominique Martinet <asmadeus@codewreck.org>
> > Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> > Cc: v9fs@lists.linux.dev
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Looks good to me on principle as well (and it should blow up immediately
on testing in the unlikely case there's a problem...)

Eric, I don't think you have anything planned for this round?
There's another data race patch laying around that we didn't submit for
6.6, shall I take these two for now?

(Assuming this patch series is meant to be taken up by individual fs
maintainers independantly, it's never really clear with such large
swatches of patchs and we weren't in Cc of a cover letter if there was
any... In the future it'd help if either there's a clear cover letter
everyone is in Cc at (some would say keep everyone in cc of all
patches!), or just send these in a loop so they don't appear to be part
of a series and each maintainer deals with it as they see fit)

-- 
Dominique
