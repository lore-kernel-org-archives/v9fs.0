Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853B39A4DF
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288548; cv=none; b=Ip/GX06sQ23yGh4mn3IlTWV6ofiuws5HBvPUR82+Pd5ytBCvjTuxQ52G1to2Y/Xk3NmxIF9RWpTYON4ncE42mBrHjvrgn6Jl7gYo5a7UQEYnbtep+GcQQeELrHLmmI83fyVWs7Ny7hVX06ypVBO6LYxqrcq/lUimaPCR9ijmubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288548; c=relaxed/simple;
	bh=+b6aPq1NVT72v58zk1Z6bZujHvCDeiVr/OnQEWJD7n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjEpsTJaMGs0vr8rzNqLpVf07oku40hu/9gjPdr/cAridPSYmhop27uY3F5aTVeZGnRTrt8ghyFZVuTk/rYtAPYipEE8j/Yq4VN37Ycis5ZMblcHQOsq3u8r7pVoBqFUEfwWnQXg5B5Tt5/HKiTcFvji1j/MVstUPbMHxIykBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=VdlXBUcJ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="VdlXBUcJ"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3A3A414C2D6;
	Sun, 13 Sep 2026 10:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789288543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0ccU6ILa7ga3j5CbFi+H02+mMd7dy+It3g3tgQxMk4=;
	b=VdlXBUcJ98DzCpnjNsjroiwEgsAiyP2m07Eja2ejaimXf7KRfMFO2a0Anb6B5MGnAqLVR8
	DAkRnvlgtJMYHWxm5tINaGvh+MC9765RGBn5q6rETymrHblzs5JtEtwtDnVK0aItAy+9tT
	t/5QJ0Gh/RLQHoMj+PY6j3FjhvFQ48W3ks8Vtey5R/1aM6R+CsDvCA6tdW3JT0N0hEM6ms
	iwk9Joy4/bk1+AmRPT9wFyWOooc00IQXObQ2eL7yV/U9u3JI9RxIdohYjHl7AuzbGEeXc+
	QjcJSUF5s0DdPz8MXtKN4dfq/IPu0Peep4pRAjgTuz4gwRexd/vBMsM9k+nUow==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 009f7706;
	Sun, 13 Sep 2026 08:35:40 +0000 (UTC)
Date: Sun, 13 Sep 2026 17:35:25 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jackie Liu <liu.yun@linux.dev>
Cc: ericvh@kernel.org, linux_oss@crudebyte.com, v9fs@lists.linux.dev
Subject: Re: [PATCH] net/9p/usbg: require an exact match for device tags
Message-ID: <aqZgTW38erDV7AZs@codewreck.org>
References: <20260719040346.88295-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260719040346.88295-1-liu.yun@linux.dev>

Jackie Liu wrote on Sun, Jul 19, 2026 at 12:03:46PM +0800:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> p9_usbg_create() compares only strlen(devname) bytes while looking up the
> configfs instance named by the mount source. A source that is a prefix of
> an instance name therefore selects that instance. For example, source
> "foo" binds the "foobar" channel instead of failing with -ENOENT.
> 
> The configfs layer passes the instance name to usb9pfs_set_inst_tag(), and
> the transport already uses full string comparisons to keep these names
> unique. Use an exact match for mount lookup too.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Thank you, there was another identical patch earlier that I hadn't
picked up yet so I'm taking their patch instead, but I've added you as
co-developed-by to the commit instead.

It should get in 7.4

https://lore.kernel.org/r/20260607121907.12588-1-zhaoyz24@mails.tsinghua.edu.cn
https://github.com/martinetd/linux/commit/9ee83ef8d24f11feb55fd0d222c0ec19f09dbd3f

-- 
Dominique Martinet | Asmadeus
