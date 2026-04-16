Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419039B4A0
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331098; cv=none; b=T3CdhEeLOCyrxXlOUb/NxEWWVPuc7iTMDsGq84M205kxgYVmezmVK0fFPkpsH2H/S2YVPy5OIwpn6a0g3hzR0W5+oP99b9A0pqSnyxj2PE+CP/cUbTJo0/YvtPrOcdXHr2DM69qnaGRx5KZSmfuDixFTEjbbFuLBpetPebAZjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331098; c=relaxed/simple;
	bh=xRvxm8qG7RvcSNR6TnRYUMXS6QVlm2Lz0dsVOitMLK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+vFEAjv/uP1ITvpEodqBiKcPDW5MK5+Swvc1mI0f+OhbJtHz//Qpsswhc84/R14vXMW/Em5Lu9Ve4zsk/m1qde4E2EWPy4VWI3j0+uevOR7/auTZmOkdXwOOFa7Gbwh2Wrwy3XpNYEfl3qC3kiClNuzR5pg/z6Y0LuuM3sXy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxbgSsUp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxbgSsUp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b8efed61so4538065e9.1
        for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776331095; x=1776935895; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuZQZL889ZnDbuNbGRRXjZqQbzzmhhDBl+7CF09awAs=;
        b=cxbgSsUpNj6Ik9JJVnma90QWBYN4mQMJDyDWROx3+08+LMJXGz1Pmjy8o8QleGl7jC
         GBKMqBEAnQ1zdixBfaL4AVwJiSAWS9buCLvpmp4j10CMEtD1j9SDga7oyQ1ViLsF+oro
         B5DtZ6HG2v+5WGbAbHHnBNSUgrjP/9kEEIrzGN4bC8pIU95WTH5BTH7Em0ot5GkvFL3Q
         h85fH3PQRjTOmcWn3rFFV0p12OHtEunA9dqjrSSBBj2/sdjc5gKzXcp4swJeUcIp7wxs
         Nf4fSeMLpxbjf2Sg5uciuGcXfVMk6kRz+7gGu9pFuab5r/CbvPpJ67F873ggsRkzVef1
         +1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331095; x=1776935895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IuZQZL889ZnDbuNbGRRXjZqQbzzmhhDBl+7CF09awAs=;
        b=RpdML+vAP9a0aPWFRp3yEfNrZzr9eBwh/G38Vb4N00DSQuf/MdYTLo7ARmuCFqM8mF
         uvv67gej1PV33zMdCEJERS53bAQcSBpK8xE+9bbfjRmzu1plqXpxyQW77XmAzk15zULg
         wJt1aMdnMN8v1xqdSeAJW5kshNP60nlKE1ewTxBUu8vx7vUyzKedb68lBEwUgrKaXVmS
         WeRujFq2JkO/cwl6GNKqB+0Mn9IQrSZK/63cNeKpz9RJRHg1hBwGWmlA0acwl12Ellry
         //FAdjrWwPThDbY3ga6dN5At/OKG444LdnkxYi5zx3hT2krFTolrkPwWE8Fx5qtB4Q07
         R7og==
X-Forwarded-Encrypted: i=1; AFNElJ+btmY6UGy7IZaNMMQjCT4eeCkFtE+sebNJVEXeodlaoml4zE9XUx/YVsds5ZrnVRd23LrR@lists.linux.dev
X-Gm-Message-State: AOJu0YyOJxMg+butKvOusve/6cVNzbmuSN3odJVZaNpCowi+y7h24KMy
	sRxnYu+ovkN4QujZJ/jTxtl/PeOWt3UnCvmgHOiTEbkUkh4iA9fuyPt1ruMAAWBe
X-Gm-Gg: AeBDietctRjts0tDCR/WkG68P7t3aamrgGV3z+Swdm9OmSq+qBIMyZBUaxE0MRF0pHa
	pw4mkhZo6V3rcHqd0Q4w1aCcG7pqVX/Gp4VfTb8RZ8TmEEYZW8KlHF9ot8ryo7aESgaAh6ZPgC7
	T1HjjDq9EoH/XZj6vAI+XNz8jT8tuw1shZGnTuQmwdJTisK9SXCgpq4/Lr+4esTmgtAAuL6VxBq
	jfwcmJJijxGQQzZbN7TiNyTlP0UWeE1y+CdRWUWgd3cUetiihOsIEt/IltKoYsnhKYi70UUJLwC
	FMyaymbZ0YHJo9zdIMoJYLzhroZqSpPTE0C6OHLJwaDa7vIxBCEQH34vAOb2Qq05CIE/Diln1aJ
	frcEjs1YUXBBC15QNlW63MmM3dqD1ziF/cKcFbFNC1b5TDTRxQ+mW0EGKLoxh9N72hHdipB3T1D
	nPW44AD4vc/7IXgoBx1KbqZNPgnnrqh7vY4aH3GL4J6VehvcrLHuyDYSOGS4BzWBKE
X-Received: by 2002:a05:600c:1e28:b0:488:9c3b:ff40 with SMTP id 5b1f17b1804b1-488f4829bc6mr34154325e9.15.1776331094504;
        Thu, 16 Apr 2026 02:18:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5827da4sm35917145e9.14.2026.04.16.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:18:13 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:18:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Pierre Barre <pierre@barre.sh>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck
 <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: use kvzalloc for readdir buffer
Message-ID: <20260416101812.59e857d3@pumpkin>
In-Reply-To: <aeBJ5pT0WtMp-LO5@codewreck.org>
References: <06399e04-b019-4c3d-b941-5771b6ac33c2@app.fastmail.com>
	<20260415100157.4aa33364@pumpkin>
	<a93672d6-1b99-4d4f-a8e4-c7f8b0d10b36@app.fastmail.com>
	<20260415113625.6d38441d@pumpkin>
	<aeBJ5pT0WtMp-LO5@codewreck.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Apr 2026 11:31:02 +0900
Dominique Martinet <asmadeus@codewreck.org> wrote:

> David Laight wrote on Wed, Apr 15, 2026 at 11:36:25AM +0100:
> > > Perhaps what you describe can explain what I was seeing there:
> > > https://lore.kernel.org/v9fs/496d10b9-40fe-4f81-8014-37497c37ff63@app.fastmail.com/  
> > (After seeking, getdents() returns stale cached entries instead of fetching from the new position.)
> > 
> > Absolutely.
> > But the fix probably isn't trivial.
> > The offset that you need for the seek isn't directly related to the number
> > of bytes copied to the user buffer - which is what I suspect ftell() (or
> > whatever gets used) returns.
> > I think there is some mechanism for arbitrary directory offsets; but IIRC that
> > requires the code put the 'file system offset for the next directory entry'
> > somewhere in the directory entry.
> > Such an offset would have to be one the remote system would understand.
> > 
> > A partial 'non-fix' would be to reject seeks to other than offset 0.  
> 
> 
> Thank you both for working on this and reviewing -- this is all
> historical code that hasn't seen much love.
> 
> 
> 9p Treaddir sends an offset on each call, so I think it'd be fine to
> invalidate buffer/remember whatever the client set in a custom llseek
> function and send this to the server on readdir call, but I honestly
> didn't give this any more thought than the past 2 mintes (I'm totally
> swamped and can't keep up/didn't even notice the bug report this
> december, sorry :/)

The problem is you need to get the correct offsets for the various calls.
So the directory entry sent to the user needs the correct offset the
server would use for the (next) directory entry.
If the latter aren't byte offsets into the buffer it probably impossible.

I have a vague recollection of some fs encoding 'directory block number'
and 'offset in directory block' into the 'file offset' for directory fd.

> I think some filesystems only allow seeks to 0 already? So given there
> is a precendent this might be fine, but I don't see the harm in allowing
> custom offsets: the server needs to be able to deal with junk offsets in
> read requests anyway, so it's not a problem for me if userspace can set
> something invalid and get itself stuck on EINVAL or whatever.
> 
> 
> As for locking the vfs takes the file's f_lock for seek, but there
> doesn't seem to be anything in the readdir path that would do that, so I
> guess it probably would blow up with parallel readdirs on the same fd,
> and could use improving...

There might be something, file->offset needs protecting for readdir()
the same as for read() (but not pread()).
At least once (for some filesystem on some unix variant) readdir() would
have been pretty much the same as read().

	David

> 

