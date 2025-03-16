Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBFC18C332;
	Sun, 16 Mar 2025 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742160283; cv=none; b=LuwrqT2uOO25uwh0dWrWezQm6gYaGzRCAqVDckaSVCyEiDBnqy05yO8zjt1GZOKlhEZgl7PyGc4GyjuhCkZfTo19j15gSTjOILW8AD1idav77RuyF/ubCZfc5VhCP8Myjw0R5n6hSO+nO7pjDxuh/oktchOaZobIZV96BOFpdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742160283; c=relaxed/simple;
	bh=ELgUU3NlKYeZRSc73AiMF+kP/N4Hb6nF2/wYDGzXXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEE0qe5lIofiNf3QNr6iwi1ayBL/djCeFLzv0BJzilxjZoOp11R1+gSJSok0CbrFOMD0l7SrhiZ38gGepA1AgIoLttWSI53V6Xb6vIu3cAgyLd8MHBgoZ/bNtS26PE9+/r8ESHGnIYqT6rz8Paa1ZHuuVvugcs5LkzsEOVzueL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=QqrG2dxG; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="QqrG2dxG"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id ABE1A14C2D3;
	Sun, 16 Mar 2025 22:24:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742160273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLUDOqXtw4gqTBMsEkmL5NysZ/9QGbLvuf1DQUOyuH0=;
	b=QqrG2dxGNY78946uMzb7yj7QiDYUDkWsomzMbTBXsLmX+ab2qhxJL4K8ZjQVvwL9QEt0O4
	TZdF3FlvW0rB8XqsxgPz/F5a609GH8hU2meMDSCxQRlQYxz4z7x9Aqmmv0qTdtdn2MAapS
	IPrlJRtRvE2EiTWC2HKYXKJv0PepMyOKTw4SRkTne/j95FElSQGTvmjmkf2Ux7Jzro3LNt
	8Wv6sNV7wgIjfLWBj5uleddOvoxE6fND6dU3ib5M1hSWMmz6zJtoMSulmoM9uHeN32xX2j
	nzlYc139vIxX8Wnw5nR9bRIIBkMzFgWyCPZy/419ecfKICbMFGQOItM2uoxbfg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ab19b731;
	Sun, 16 Mar 2025 21:24:27 +0000 (UTC)
Date: Mon, 17 Mar 2025 06:24:12 +0900
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
Subject: Re: [PATCH v2] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
Message-ID: <Z9dBfEf0naCsNrNv@codewreck.org>
References: <20250313-p9_conn_err_benign_data_race-v2-1-0bb9f45f6bb2@iencinas.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313-p9_conn_err_benign_data_race-v2-1-0bb9f45f6bb2@iencinas.com>

Ignacio Encinas wrote on Thu, Mar 13, 2025 at 07:08:19PM +0100:
> Writes for the error value of a connection are spinlock-protected inside
> p9_conn_cancel, but lockless reads are present elsewhere to avoid
> performing unnecessary work after an error has been met.
> 
> Mark the write and lockless reads to make KCSAN happy. Mark the write as
> exclusive following the recommendation in "Lock-Protected Writes with
> Lockless Reads" in tools/memory-model/Documentation/access-marking.txt
> while we are at it.
> 
> Reported-by: syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com
> Reported-by: syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
> Changes in v2:
> 
> Drop unnecessary READ_ONCE in p9_fd_request (that I added in v1)

Ah, sorry; I think you misread my comment for v1 (or perhaps you
disagreed in the response and I misread that!)

I was thinking that style-wise it's better to access the err field
through READ/WRITE_ONCE everywhere, even if it's locked; so suggested
this diff from v1:
----
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index f163f6fc7354..65270c028f52 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -192,7 +192,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 
        spin_lock(&m->req_lock);
 
-       if (m->err) {
+       if (READ_ONCE(m->err)) {
                spin_unlock(&m->req_lock);
                return;
        }
----

OTOH, looking at this again:
> --  if (m->err < 0) {
> -+  if (READ_ONCE(m->err) < 0) {
> -           spin_unlock(&m->req_lock);
> -           return m->err;

There's this access out of the lock so perhaps this should look like
this instead (with or without the READ_ONCE)

+       err = READ_ONCE(m->err);
+       if (err < 0) {
                spin_unlock(&m->req_lock);
-               return m->err;
+               return err;


Anyway, m->err is only written exactly once so it doesn't matter the
least in practice, and it looks like gcc generates exactly the same
thing (... even if I make that `return READ_ONCE(m->err)` which
surprises me a bit..), so this is just yak shaving.

I don't care all that much so I'll just pick this v2 as it's more
consistent, but feel free to send a v3 if you have an opinion, or if
someone else chips in.

Thanks!
-- 
Dominique
