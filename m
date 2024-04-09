Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E24E1DA
	for <v9fs@lists.linux.dev>; Tue,  9 Apr 2024 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628943; cv=none; b=k05oN9vF4udLwW+uk0wjlkeUaRW8UehDETpDyEMk8Q2N0rIDsVLa3HD5roXai4/KJC2QBGE5v7eoZWiSTd/h9CqkdnQfjFzNox0t3NqFpJnU0vL+Ixuk+tt/84Z4e4nDhwHjhMdBOi2JxTvRdsONqmqqHu5emdF8HHzS/GKbgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628943; c=relaxed/simple;
	bh=SgzqgQkqNTneotRqIBR7UfyZbyJM+i+gcTFFvMSFfQw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=WCC00fZB9zFOQFimOv9FbhV9ykvUUzNU6/mOIVZeISlFd/CMhuRJHHE2+jDSMHraLrjqG6M4uGUyTkGksxwalJPP7d0gey62uIun052Du+mIoXoU4HwV+gkf+yGMr334qo0g6BzvEWWXMZMMlOLVzw9nkWHjiFYjeCMg4+WXW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfDey952; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfDey952"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712628939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PM/BRJ8VlLToGmQWvxrNgONtx4+Axf1u0ehj/5jt+/g=;
	b=YfDey952Q6jIh8ZPc8l6weLsFvLhhs+OzNprUKqPf/RGeSEK23j1t911XF8jzHPiyWu3qL
	dzg9OLMEWS4wm+kN/9rC5sHfUgYiuwQfd/oe4MywpB17A8u1M09aozqS2TmpG7SD/NX2D7
	LWBedk6jDRWjTnRHcw9fKzcbWg6rtdU=
Date: Tue, 09 Apr 2024 02:15:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <0d0b731bab0a074d37bd876f423b18e0034bed61@linux.dev>
TLS-Required: No
Subject: Re: recap of 9p problems in 6.9
To: "Dominique Martinet" <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev
In-Reply-To: <7b4724a5be3a5a5f4ab550741741ecf3479f7139@linux.dev>
References: <ZhNvwwYRN4-EczYi@codewreck.org>
 <7b4724a5be3a5a5f4ab550741741ecf3479f7139@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 8, 2024 at 7:11 PM, "Eric Van Hensbergen" <eric.vanhensbergen@linux=
.dev> wrote:
> April 7, 2024 at 11:17 PM, "Dominique Martinet" <asmadeus@codewreck.org=
> wrote:
> >  * open / unlink / fstat|ftruncate etc fail

Okay - a lot more digging on this one.  I'm wondering if these issues hav=
e to do with changes inside vfs_lookup -- there as a bit of code that was=
 in there that I didn't quite understand.  Previously we always created a=
 new inode on lookup (unless we were in cache mode) -- this leads to a lo=
t of duplicate inode structs floating around.  One of the simplification =
changes was to remove this (but I left the comment in which talks about p=
arallel unlinks) -- now the unlink in this case isn't in parallel here bu=
t I wonder if we were sidestepping this bug because unlink was essentiall=
y operating on its own inode and the open fd had a distinct inode structu=
re that wasn't perturbed.

There's potentailly a relationship to the ACL issues Kent observed as wel=
l since there's a similar code path in create which uses a new inode and =
then associates ACLs with that.

I'm just still struggling why this requires a new inode structure if ther=
e is one already associated with the qid.path -- unless the inode numbers=
 as being stored in the qid.path are being reused too quickly and there a=
re unlinked inodes which still maintain that number in the cache??

      -eric
