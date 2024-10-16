Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA11B78F3;
	Wed, 16 Oct 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072131; cv=none; b=LStYsgfb0Pw/WwXhSHoJDrF6HO/QUWpiyDqnNyuRQbPgtq2Vs+2UC5NpGkWOc0HjQY43QZDuOzJzhp4IeUXokvd4j8QZPBvCoLEaLhEgO+atvBqszGlRwrtIjDvb8oZUtgs1EnxkTkQE57G0EGRsU9OpDDn/7XuQW/m550VmDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072131; c=relaxed/simple;
	bh=D4ZIvpLXGjOGc57fdQgXtrHNIKToHnqKt5ztXwXmG2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbMBWAUH2yCtbMbWcCcWAZjxgPZmf43SXFpx4p1erMQdt4mOJtOBerLprc6NGIAqUQHa9NCGFr4I06sc5YvclA0/VNZBtN/f75wZVqD8fGD01poCsh30E/gu7OcCGotVMlvyPWvaw62aMqDmm1b1xk/QZEFBNyQeYP7rpjiRoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=oR1R/nO5; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="oR1R/nO5"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 69CE214C1E1;
	Wed, 16 Oct 2024 11:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729071588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKKCM8vsmuJw2e87CzOm6FJ2PosV5LE229Af8qrBvGs=;
	b=oR1R/nO5g1A3VVcMusNHveBTxJMzDmKsfMq84X8iH2qEBU8P0doZj5QGMYa4WQ+aJ8PeS5
	cSe911T5vLNSvg9baUet9qfW0M4IqNoH+WwYhFkIEPO13y3usYr/q0RgaBWQJ74SCu6b2s
	kguSW0KVQMIYcOmMyjF34bWnvRmEHeGS3hkQZq67Cph+PiojPU7TXVPWHAzRGFCKnA9LA6
	BGrZsLjTA9dm+8RrPPJ739OzVsz/vX9eIcEx6IYOudl8W3R+9EMzTNXJTkA93Oij4AcSn1
	FXshK2xiJ45eE4Incr6Q7yqt2xUBGYGyhY4iug5DCfFBUwoA6/FI/vGxuzR0cw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c1fa19b0;
	Wed, 16 Oct 2024 09:39:43 +0000 (UTC)
Date: Wed, 16 Oct 2024 18:39:28 +0900
From: asmadeus@codewreck.org
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Will Deacon <will@kernel.org>, ericvh@kernel.org, lucho@ionkov.net,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com,
	keirf@google.com, regressions@lists.linux.dev
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
Message-ID: <Zw-J0DdrCFLYpT5y@codewreck.org>
References: <20240923100508.GA32066@willie-the-truck>
 <20241009153448.GA12532@willie-the-truck>
 <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>

Thorsten Leemhuis wrote on Tue, Oct 15, 2024 at 08:07:10PM +0200:
> Thx for bringing this to my attention. I had hoped that Eric might reply
> and waited a bit, but that did not happen. I kind of expected that, as
> he seems to be  somewhat afk, as the last mail from him on lore is from
> mid-September; and in the weeks before that he did not post much either.
> Hmmm. :-/

Right, I had hoped he'd find time to look further into this and kept my
head in the ground, but it looks like we'll have to handle this somehow...

One note though he did sent a patch that seems related and wasn't sent
for merge:
https://lore.kernel.org/all/CAFkjPTn7JAbmKYASaeBNVpumOncPaReiPbc4Ph6ik3nNf8UTNg@mail.gmail.com/T/#u

Will, perhaps you can try it? I'm pretty sure the setup to reproduce
this is easy enough that I'll be able to reproduce in less than an hour
(export two tmpfs [sequential inode number fs] wthin the same 9p mount
in qemu without 'multidevs=remap'), but I don't even have that time
right now.

(I didn't even read the patch properly and it might not help at all,
sorry in this case)

> CCed Christian and Al, maybe they might be able to help directly or
> indirectly somehow. If not, we likely need to get Linus involved to
> decide if we want to at least temporarily revert the changes you mentioned.

I'm not sure this really needs to get Linus involved - it's breaking a
server that used to work even if qemu has been printing a warning about
these duplicate qid.path for a while, and the server really is the
better place to remap these inodes as we have no idea of the underlying
device id as far as I know...

So the question really just is do we have or can we build a workable, so
the question is can we resonable do any better, or do we just want to
live wth the old behaviour.
(Note that as far as I understand the old code isn't 100% "loop" proof
either anyway, a open(O_CREAT)/mkdir/mknod could happen to get identical
inode numbers as well, it's just less likely so folks haven't been
hitting it)


Thanks,
-- 
Dominique
