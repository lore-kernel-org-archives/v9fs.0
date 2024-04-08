Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF351118B
	for <v9fs@lists.linux.dev>; Mon,  8 Apr 2024 04:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549253; cv=none; b=qHyrCsBCICuN10C5xztDATxPqSucBwyb16UGo7BdJBU23NZ10gUZ6nt2PXNhcs7mlf0KAa0MIjuWnHComTMaN11k+JCV+TzWJn3MeEv8PWZCFz4DkJsx+wOMs7G/EdkZe9M9DSJoN8Z6nbvKH5vMz+QOmMHnaH+2sQa1CHa/0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549253; c=relaxed/simple;
	bh=njqWTsYPAzuW7rynlXUeP9YfmnMA6oPkTXC9DfPjLN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFlVh8Rdtt5wpn9Boysg//dHrT4Gm9MNMbfzQuEGe81i58ysUqJ7een3xvX2rJN+oTf3cU7r52Qr7CsgJU1ILcFQKe1eLgLmBxKq8KHi18BZUPF+IShD0oV8YBfgtH8CJvEQyRTx8YOz/WPR7XE7hQ5SiIzFoO8Ihl6SAnEDhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jic/+cXe; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jic/+cXe; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jic/+cXe";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jic/+cXe"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 907AEC01A; Mon,  8 Apr 2024 06:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712549248; bh=VMYPnxtVqW9SrdzvUbvX/TTtgCZbPOH2rqB48+b8miI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jic/+cXeEZcgq7OZD1oXsAw6lk8fjHfwf4R9wCURj1O6dg4YYG7bYIr/5TCnhLkyH
	 0p+7mmb24Zvfp0j3ypx/k3aWnxHGXzxLreb4QWzZMNQiv0rZKlHQb4HNFW1cYH0fUJ
	 uxXmwjO6mm6C8nMWMQGaTyD+CHN+rDhQPggEkicfwp52z+qoRm76KNr6YMDiLcGMxv
	 FUT3R8LEgvhnSnanRAkyq9Ip4G3gZi1yKUHyopkgYlBPH3ymWpN5cIEpL8lWOFA/UP
	 lo3yh3KrB0WD+KGTcEtW5BAc5EAovRpxOBblzBwqCVnYlltk+7Xd6/xozLx49QWdKq
	 d4uJ9/ESp+znA==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 783A9C01A;
	Mon,  8 Apr 2024 06:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712549248; bh=VMYPnxtVqW9SrdzvUbvX/TTtgCZbPOH2rqB48+b8miI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jic/+cXeEZcgq7OZD1oXsAw6lk8fjHfwf4R9wCURj1O6dg4YYG7bYIr/5TCnhLkyH
	 0p+7mmb24Zvfp0j3ypx/k3aWnxHGXzxLreb4QWzZMNQiv0rZKlHQb4HNFW1cYH0fUJ
	 uxXmwjO6mm6C8nMWMQGaTyD+CHN+rDhQPggEkicfwp52z+qoRm76KNr6YMDiLcGMxv
	 FUT3R8LEgvhnSnanRAkyq9Ip4G3gZi1yKUHyopkgYlBPH3ymWpN5cIEpL8lWOFA/UP
	 lo3yh3KrB0WD+KGTcEtW5BAc5EAovRpxOBblzBwqCVnYlltk+7Xd6/xozLx49QWdKq
	 d4uJ9/ESp+znA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f55e105c;
	Mon, 8 Apr 2024 04:07:22 +0000 (UTC)
Date: Mon, 8 Apr 2024 13:07:07 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: v9fs@lists.linux.dev
Subject: Re: ftruncate fails
Message-ID: <ZhNta7QZBrIO71mJ@codewreck.org>
References: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
 <ZhNP4SISzZOGwy4A@codewreck.org>
 <A9C784B0-3B04-4EBF-8AFF-DD5088B5EF67@linux.dev>
 <74C91BF3-4BC7-46A7-9BB2-1360E07B6FE5@linux.dev>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74C91BF3-4BC7-46A7-9BB2-1360E07B6FE5@linux.dev>

Itaru Kitayama wrote on Mon, Apr 08, 2024 at 11:22:56AM +0900:
>> FVP and just mount -t 9p FM /mnt

FVP is the arm "fixed virutal platforms"?
I've never used it and the doc I just found doesn't clarify much but it
looks like each individual "model" provides its own emulation program,
so they each might have a different 9p server.. doesn't look like
qemu-based either.

We have had other reports of problems with 9p recently (since 6.9-rc1)
so I'll keep digging with qemu for now, but writing down to try FVP
eventually.

> >> - Does this reproduce right after boot/mounting the 9p filesystem?
> > 
> > Not immediately after the boot/mounting.
> 
> My reproducer wasn’t explaining what a kselftests was showing.
> 
> If you build the “mm” subsystem and execute one of the programs,
> gup_longterm from the 9p mounted directory, you’ll notice the
> ftruncate error.

Okay, the failure from gup_longterm isn't what you describe in your
first mail (no bus error, ENOENT on ftruncate)
I think it is a new bug though:

openat(AT_FDCWD, "gup_longterm.c_tmpfile_vKvLVC", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlink("gup_longterm.c_tmpfile_vKvLVC") = 0
fstatfs(3, 0x7ffcf7f74920)              = -1 ENOENT (No such file or directory)
ftruncate(3, 4096)                      = -1 ENOENT (No such file or directory)

I think that used to work, we need to fix this.


If you can reproduce the bus error though I'd be very interested.
-- 
Dominique Martinet | Asmadeus
