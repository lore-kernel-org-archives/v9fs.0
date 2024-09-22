Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6753A4AEE6
	for <v9fs@lists.linux.dev>; Sun, 22 Sep 2024 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727036795; cv=none; b=mBblh4BmVsqiQk8whTO6G3Y3lGxLbbyzn3p+zWRO/HMhLOwgLCgbLugnTRZXEsYFYRTJ6xlTkCOKggPOZkKnSyyqGbx52l/42OBrQjYnNdrByyDWJMj/Y0+vJp0QAswxExPUYFn0/FBw6wyiriDGV0g4Q8dOlVzBdhRS8LTL9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727036795; c=relaxed/simple;
	bh=30E2ZrcpqAJXR/rQlNeag+vBjVRGwF9eqgwqsjL4Qyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8hdRznb0oy0wXtACP7NFJ8P6micmA4V1IG8xoNL9OiFJKQ0fBhasuBr/65hzn29VLhC4EIliybB5U7rOZZ9y+Wmvqcx76n8w0QjTEGU1AGZodyLFS1QAH2fY494lXjJUtsA1hBlJ/rkU5L1wziIVIpKoM3aZEn77Hg7qac3lWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=y+Cetb23; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="y+Cetb23"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1C76114C1E1;
	Sun, 22 Sep 2024 22:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1727036790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7dZ8UIKFzbGUVg3pSKlD91524IzhscrWvBGhjOvt7w=;
	b=y+Cetb23XgV5Ris3lDR3faJ2AdBYrWTZnR63raarh4QYi8UZ79ta+gE/JggRqU5a9MCl0w
	dpAZ4v5F7p8q3IYJq1gjV6qCMlBF2EV3vz4ev1jDNNTUd+7wqx7wOw/qWlGV2BFwiBOq13
	gETITZulgpjVcdTIFTnBlten8BGwASBT4JdlAjt8YiWsTa/g4BDhSgatus3VStsVvmWj4d
	zdS+cZuV7XMJWotrAo8BAF2uv0rX6QEqikN7Y784d77SAf6YGEOc1LzCiwawuH5zViT4Io
	ISxrDKhNN6Zw61n5SBRQCGg3CQxx4G6rSKF14UTyeIThsTvGvXwLa5vG0B5XOg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a9b140c5;
	Sun, 22 Sep 2024 20:26:25 +0000 (UTC)
Date: Mon, 23 Sep 2024 05:26:10 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	xingwei lee <xrivendell7@gmail.com>,
	sam sun <samsun1006219@gmail.com>, lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] 9p: cap xattr max size to XATTR_SIZE_MAX
Message-ID: <ZvB9YsV8BZSFoDrC@codewreck.org>
References: <4091309.WcpKHNDlqE@silver>
 <20240901-075b24ce58df695232e3d345-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240901-075b24ce58df695232e3d345-pchelkin@ispras.ru>

Fedor Pchelkin wrote on Sun, Sep 01, 2024 at 10:16:55AM +0300:
> the issue is still present in upstream kernel [1].

Right, I didn't register the end of discussion, thanks for the reminder

> Considering the remark from Christian that limiting the allocation to
> XATTR_SIZE_MAX seems too Linux-specific, maybe just fail silently with
> __GFP_NOWARN flag passed to the allocator and return ENOMEM? I submitted
> the patch [2] sometime ago which looks still applicable to the mainline
> kernel. It was superseded with current discussion.

Hmm, at high level, I don't really see the problem of being
linux-specific here - we're writing a linux client.
Something larger might work in the very specific case of the acl call
here, but normal userspace getxattr will be truncated to XATTR_SIZE_MAX
anyway (in do_getxattr), and returning a size larger than that will
yield odd behavior for userspace: calling getxattr with a zero size will
return a size larger than XATTR_SIZE_MAX, then trying to call getxattr
with the returned size will just fail as the buffer is silently
truncated to a shorter size without any way to work around that; it
sounds more coherent to me to just say we can't do it in the first
place.

Anyway, I guess a malicious server has an infinite number of way to
cause nuisance to our clients here so this is the least of our worry,
and not giving a warning is better than giving one, so if we're not
doing anything else adding NOWARN is probably for the best but I'm
really not sure I agree there...

I'm getting less involved with linux as real life commitments increase,
so I'll just defer to whatever eminent folks think about here --
Christian (Brauner), please take your pick of either of these (or
anything else) and I'll apply it:
(just adding nowarn to the acl path that warned)
https://lore.kernel.org/lkml/20240202121319.21743-1-pchelkin@ispras.ru/
or
(limit to XATTR_SIZE_MAX in 9p's xattr_handler->get() op)
https://lore.kernel.org/all/20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org/



(and I see vfs_getxattr_alloc() hasn't been updated to error on
size > XATTR_SIZE_MAX either, but we don't use it anyway)

Thanks,
-- 
Dominique Martinet | Asmadeus
