Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F561991B8;
	Sat,  8 Mar 2025 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741472282; cv=none; b=NoBhpgdwdIcxKLGpVHAT8kKQV6zk0gYjZmXE/3xbiMXVQgyXHeZvdPJdmwy45JUQfVPulM5cXRZrerJq5mWKEghG29hmt8Pg5LAhrHEDuCIUJLJCSa21H+TsAy+OH1YQkDKfUA7GVQ5BpnfdKgQgziAw6hcc9ppIhc+MuKzvvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741472282; c=relaxed/simple;
	bh=kZv6LxTH/6n2vTyi1JUBq+dNjhqKNCxYk40ly0nOxpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8lPM5BkJo2GiF4cDtkHiCorh9jIunVbxAeTnLBrobk8NwB14T3wx3VuRudY8EPAWL4mglcKOt/C8b3LIdlYpQydiYHhI98Ya3URtumuZSA6aye6cJDNBJn5MDZr/EnDXLneJFcN++vU+OIYEP3XftkGLjeYS2hPI2vx6S8wK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=OmO4Cfyb; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="OmO4Cfyb"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 280EC14C2D3;
	Sat,  8 Mar 2025 23:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1741471753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qkRfR5iIp370h0vHcYYkHnqzKAOlLr+Ap7PNgEbI9dQ=;
	b=OmO4Cfybste8NJsXHK1eL6LkHTRvzadMRu8tTWuUIiN5IHy3YlsjrvzciUgw5JM8Lsp7uD
	e1icptW5PgNBXaSF6uH01kbYQDmnQT3pe/QvplEpXbnX9Ys9dDvut7naD4vrtNKPDZHaue
	51YMzar8z+1zHUOXLhUM4VXyr3F+4zZP/KPn5hu91qWjN9ssGgV98QBFUCg2b97H3kzeEN
	E8R7fHhg6NbF0goNPB3RzF5y+W5YOXmIXUO9gbOswGEC4vmXF5WTzT/yOv828HZ7FKA6b3
	7UyD8fKi9h7nVzLZmh8JZCHixacbOe26iYbVlRs+ksJKIYQJgqXHO46G50pn/A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 65d45deb;
	Sat, 8 Mar 2025 22:09:08 +0000 (UTC)
Date: Sun, 9 Mar 2025 07:08:53 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Sishuai Gong <sishuai.system@gmail.com>,
	Marco Elver <elver@google.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com,
	syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
Subject: Re: [PATCH] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
Message-ID: <Z8y_9b6RFZASviUs@codewreck.org>
References: <20250308-p9_conn_err_benign_data_race-v1-1-729e57d5832b@iencinas.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308-p9_conn_err_benign_data_race-v1-1-729e57d5832b@iencinas.com>

Ignacio Encinas wrote on Sat, Mar 08, 2025 at 06:47:38PM +0100:
> Writes for the error value of a connection are spinlock-protected inside
> p9_conn_cancel, but lockless reads are present elsewhere to avoid
> performing unnecessary work after an error has been met.
> 
> Mark the write and lockless reads to make KCSAN happy. Mark the write as
> exclusive following the recommendation in "Lock-Protected Writes with
> Lockless Reads" in tools/memory-model/Documentation/access-marking.txt
> while we are at it.

Thank for looking into it, I wasn't aware this could be enough to please
the KCSAN gods.

Unfortunately neither have a repro so will be hard to test but I guess
it can't hurt, so will pick this up after a bit.

> Reported-by: syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com
> Reported-by: syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
> Hello! I noticed these syzbot reports that seem to repeat periodically
> and figured I should send a patch. 
> 
> The read-paths look very similar to the one changed here [1]. Perhaps it
> would make sense to make them the same?

I've just gone over read/write work and I think overall the logic
doesn't look too bad as the checks for m->err are just optimizations
that could be skipped entierly.

For example, even if read work misses the check and recv some data, the
p9_tag_lookup is what actually protects the "req", so either cancel
didn't cancel yet and it'll get two status updates but it's valid
memory and the refcounting is also correct, or the cancel was finished
and read won't find the request.
(I guess one could argue that two status updates could be a problem in
the p9_client_rpc path, but the data actually has been received and the
mount is busted anyway so I don't think any bad bug would happen..
Famous last words, yes)

Write likewise will just find itself with nothing to do as the list had
been emptied (and p9_fd_request does check m->err under lock so can't
add new items)

So, sure, they could recheck but I don't see the point; if syzbot is
happy with this patch I think that's good enough.


> [1] https://lore.kernel.org/all/ZTZtHdqifXlWG8nN@codewreck.org/
> ---
>  net/9p/trans_fd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 196060dc6138af10e99ad04a76ee36a11f770c65..5458e6530084cabeb01d13e9b9a4b1b8f338e494 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -194,9 +194,10 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>        if (m->err) {

This is under spin lock and I don't see the compiler reordering this
read and write, but should this also get READ_ONCE?

>                spin_unlock(&m->req_lock);
>  		return;
>  	}
>  
> -	m->err = err;
> +	WRITE_ONCE(m->err, err);
> +	ASSERT_EXCLUSIVE_WRITER(m->err);

Thanks,
-- 
Dominique Martinet | Asmadeus
