Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462BA185B4C;
	Tue, 18 Mar 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335295; cv=none; b=QhpVtrTU97ouq52WNiAwPqznZzmwTU1df7oZ8i56HX81RG26f2c4Tkt3Ytu9xAhUk6Dk1vLmwHw8kycWrGrDHG0JdGr5oZ/Icu0haMO0uNVy1OrxkYtOJihmrUxf9Dxx9OBvx2b6y1v0jswYeum09LV4rFAzf4dD6TcQLk3JJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335295; c=relaxed/simple;
	bh=YIUKm66kfHr0h8IKYA07cF6554QtrV077D8t9dWmvag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRod0op+8MDYEUwoLJFIBAJ68hFOVhX9f8BBNTvJIS/zFMxODcO1ACwxaq31HQXo+P17uTk2E32gfdNv8rHozJj2JXsuuqhHQJcsUrSkz9bEAs2vpeNWBNfSq3/kA+AB2zfBd7ws07Sc6OzcfAsURkZVLsfNQcFHqvEiYlBbR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=CgxyC/gm; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="CgxyC/gm"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 102CD14C2D3;
	Tue, 18 Mar 2025 23:01:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742335291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pv9fNmE/cWD6i+iJ7xO+TvGlhYF5oWWIi+8zg1cXvrY=;
	b=CgxyC/gmf0pNvInNbF4/+MgKnpuG4Of8YJAp6a3zhPtJzmc2i7YDR5FEriEOYz2Hp3iw4k
	Tx7bpFTSFgnNQ12J3GfcSNRvoNyHEN45pTfdkS87iiehTeOUTYhJJQc4P3HCYbtYIdNvnk
	4qAbhnfZippNbJw0EUfwL2gK7Jvq9A9C5NM8XY22WLleInv9jCe7RUMl//aOi23kPMRcrE
	OYt0rKLnU/QcMKx+z5HWv79jyKsBmaFMelZ0ofY4NZPB5SUud9mJRm0ClJYynt1SIFo93v
	S4p01yH2s1x9m3YHI1EQzhRnygnllvIHvrANSevqVWF9jgxaqZVo9CzKIyXEXA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b2d8b517;
	Tue, 18 Mar 2025 22:01:26 +0000 (UTC)
Date: Wed, 19 Mar 2025 07:01:11 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Sishuai Gong <sishuai.system@gmail.com>,
	Marco Elver <elver@google.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com,
	syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
Message-ID: <Z9ntJxTCg2Y0fcRc@codewreck.org>
References: <20250318-p9_conn_err_benign_data_race-v3-1-290bb18335cc@iencinas.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-p9_conn_err_benign_data_race-v3-1-290bb18335cc@iencinas.com>

Ignacio Encinas wrote on Tue, Mar 18, 2025 at 10:39:02PM +0100:
> Writes for the error value of a connection are spinlock-protected inside
> p9_conn_cancel, but lockless reads are present elsewhere to avoid
> performing unnecessary work after an error has been met.
> 
> Mark the write and lockless reads to make KCSAN happy. Mark the write as
> exclusive following the recommendation in "Lock-Protected Writes with
> Lockless Reads" in tools/memory-model/Documentation/access-marking.txt
> while we are at it.
> 
> Mark p9_fd_request and p9_conn_cancel m->err reads despite the fact that
> they do not race with concurrent writes for stylistic reasons.
> 
> Reported-by: syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com
> Reported-by: syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
> Changes in v3:
> 
> - Introduce a couple of extra READ_ONCEs to maintain consistency across
>   m->err reads (noted in the commit message too for future reference)
> - Remove racy read from p9_fd_request by reusing the previously read
>   error (arguably, the lock was never of much use)

Thank you!

I've updated the patch in my -next branch, and it'll go to Linus in a
couple of weeks with the 6.15 merge window

(our mails crossed, feel free to ignore the other one)
-- 
Dominique
