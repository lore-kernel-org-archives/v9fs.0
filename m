Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD12727FD
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308007; cv=none; b=KfGW1nsQSuCJg5fVQGzKqdDCw6kG9Qfzaz1bBlBA7hXWGrYvDIath5x7w+3zchpqZ/u9RBedYBHkyK1BP1ZOZ4/piC2gApeZGAm6R7jMLFMJ7EXyHt5TCqlT/Ms4HKkRhpY2Otuq5oYGXy0xP8dsQg5VvM78YeHZQKLUCDm1ggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308007; c=relaxed/simple;
	bh=uw4TJRcZecoYqhluEdXNdZaZx+M53Sr/JbHlnLY9DjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL/Tgyjysg3RK8mL9SwXPDB/brYNbuEYiCIgIBxhCGnf30nM8yqBEy43tlHUmSvB8OytrmPsJLniP7haBm6YRs7Zx1ESu4OdnE/Y7zKLsWCMIwFKp9FdOqpPmzyRvVOKs1wGNA3iw4rrD8chnzoMjY3W+nDOQROupAwKMu+pP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=VIxOU/hi; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="VIxOU/hi"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CC69914C2D6;
	Thu, 16 Apr 2026 04:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776308004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJgzEL0OfHe6N3xps6g3ofo9dCYH4b5e+rS7BaFxA9E=;
	b=VIxOU/hiRoBur8Omrpk+v3YaYcLNbRygg1HAFzZs3VjShlLGQsNNrkZuC6LTjQMA+IDv5j
	q/AcCry9RHTTOv/Nv8gDb1qi/F/qEZToZm/UKThCwidwRwnyXAi1PdSq4vfvoEdrc42Ieq
	GsROYmHb5aqX/7TVosAJGVchIs922X9FfJy7HvUPJmHay1lUxQb6lS/PY5jvJjb9zDI1o/
	258lITZr75ipHMSqv+NNNrR9GKi8k8WzFfU9ZMnGHUVRW8Et+IixD7TJNm7CbNs4KhwU/G
	/03vBRqdlLvpYo7KCYY0fTdnDhLJy15jks0M3oMJ72tO3ZRwMmE4evth28lGhA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 94f1f706;
	Thu, 16 Apr 2026 02:53:20 +0000 (UTC)
Date: Thu, 16 Apr 2026 11:53:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, Pierre Barre <pierre@barre.sh>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, sandeen@redhat.com
Subject: Re: [PATCH] 9p: fix access mode flags being ORed instead of replaced
Message-ID: <aeBPEcmAaVv5Vt5d@codewreck.org>
References: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
 <2406037.ElGaqSPkdT@weasel>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2406037.ElGaqSPkdT@weasel>

Christian Schoenebeck wrote on Thu, Apr 09, 2026 at 04:51:07PM +0200:
> > diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> > index 057487efaaeb..05a5e1c4df35 100644
> > --- a/fs/9p/v9fs.c
> > +++ b/fs/9p/v9fs.c
> > @@ -413,7 +413,11 @@ static void v9fs_apply_options(struct v9fs_session_info
> > *v9ses, /*
> >          * Note that we must |= flags here as session_init already
> >          * set basic flags. This adds in flags from parsed options.
> > +        * Access flags are mutually exclusive, so clear any access
> > +        * bits set by session_init before applying the user's choice.
> 
> That phrase is a bit suboptimal, because V9FS_ACCESS_ANY is actually a bit
> combination of single, user and client. But OK, I currently don't have a
> better phrase for it since the access fields have to be replaced altogether.

Yeah, it's not so much that they're mutually exclusive that we need to
clear the default value before applying the settings.
The key distinction here is that it's not "any access bits set" -- if it
were arbitrary values then it wouldn't be acceptable to just or the
flags out, you could risk e.g. creating a client with 2000L but setting
another protocol in the flags and there'd be no end of things to check.

Something like this?
           * Default access flags must be cleared if session options
	   * change them to avoid mangling the setting.

> As for the actual behaviour change; makes sense to me:

Yes, that works for me.

Note your patch converted tabs to space and couldn't be applied -- if
you have to send patches by web mail please attach them instead, that'll
be easier to apply than a corrupted patch, even if some tooling like
sashiko won't run (it doesn't run on corrupted patches anyway..)


If you're fine with my wording for the comment I'll modify it in place,
otherwise we have a few more days to discuss this before I sent to Linus
for 7.1-rc1
(and I'm really sorry for my lack of reactivity, I'm sure I'll miss some
patches anyway...)

-- 
Dominique Martinet | Asmadeus
