Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7B7B
	for <v9fs@lists.linux.dev>; Tue, 25 Apr 2023 07:14:58 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 929D1C01C; Tue, 25 Apr 2023 09:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1682406540; bh=WcQrJlJzF6e/odauxjm74X7K3OwhiQWeXCWu83AFdcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiJGFvOHQZTf0Betqp9PjDJZWrqAaJTYR13lkIjHOy/Aoo904+6j3GvfoIEyY7N3k
	 V6x1VZoiM7RbYUnQ3FmQhCKIvkwYzd1z8D+LNibRl6xRH1au7PTLQgwJbseZF6gbt4
	 +kcSq/FHSt+YqwzHJJG4ohJ+m1cVN5CGJJwU2dzKffQNhfMtkqh9pOekq29UlXTLZ5
	 lkQ/Oe1vQSukedyvrtP7JV34I3xN8JdrLwUQput0WupZy6L7eV0YkLRALeYrijBIj/
	 mcFcPnTXB/48ILL+qRTWuEvivTJFi+N6tGDecBiQ9E7/M+uMUe7GdyuaVrxQHq1FtY
	 uzx8tTpb07hwQ==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id DBE66C009;
	Tue, 25 Apr 2023 09:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1682406540; bh=WcQrJlJzF6e/odauxjm74X7K3OwhiQWeXCWu83AFdcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiJGFvOHQZTf0Betqp9PjDJZWrqAaJTYR13lkIjHOy/Aoo904+6j3GvfoIEyY7N3k
	 V6x1VZoiM7RbYUnQ3FmQhCKIvkwYzd1z8D+LNibRl6xRH1au7PTLQgwJbseZF6gbt4
	 +kcSq/FHSt+YqwzHJJG4ohJ+m1cVN5CGJJwU2dzKffQNhfMtkqh9pOekq29UlXTLZ5
	 lkQ/Oe1vQSukedyvrtP7JV34I3xN8JdrLwUQput0WupZy6L7eV0YkLRALeYrijBIj/
	 mcFcPnTXB/48ILL+qRTWuEvivTJFi+N6tGDecBiQ9E7/M+uMUe7GdyuaVrxQHq1FtY
	 uzx8tTpb07hwQ==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8f084e71;
	Tue, 25 Apr 2023 07:08:54 +0000 (UTC)
Date: Tue, 25 Apr 2023 16:08:39 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	v9fs@lists.linux.dev
Subject: Re: [PATCH] fs/9p: Fix a datatype used with V9FS_DIRECT_IO
Message-ID: <ZEd8d7W6HnHE_66m@codewreck.org>
References: <80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.1682405206.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.1682405206.git.christophe.jaillet@wanadoo.fr>

Christophe JAILLET wrote on Tue, Apr 25, 2023 at 08:47:27AM +0200:
> The commit in Fixes has introduced some "enum p9_session_flags" values
> larger than a char.
> Such values are stored in "v9fs_session_info->flags" which is a char only.
> 
> Turn it into an int so that the "enum p9_session_flags" values can fit in
> it.

Good catch, thanks!

I'm surprised W=1 doesn't catch this... and now I'm checking higher
(noisy) W=, or even clang doesn't seem to print anything about e.g.
'v9ses->flags & V9FS_DIRECT_IO is never true' or other warnings I'd have
expected to come up -- out of curiosity how did you find this?

Would probably be interesting to run some form of the same in our
automation.

> Fixes: 6deffc8924b5 ("fs/9p: Add new mount modes")

(Not a problem per se: but note this commit hasn't been merged yet, so
using commit IDs is a bit dangerous. Might want to remark this in the
free comment section so Eric pays attention to not break that when applying)

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique
