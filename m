Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FA21772A
	for <v9fs@lists.linux.dev>; Mon, 15 Dec 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817208; cv=none; b=SL2rHpF3EiBdlR/KcdooVRVcqLAYL6CW+GnasjSpY49BmZbZltXJKkKBwOWGuqlXEFJX8sAfD4I8h7aYHVKSNy3ZklLEEu02oj9focaPpqk/87vvur5uWO+RnjlsLjEIB8ysqbvAb2LQCZg+D7ez/wLKD5D5Wv1NrXFpkWJ/JGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817208; c=relaxed/simple;
	bh=0qPtXJRp3OJPSd/o8yFmg/Io2rTT/KEiiswkpXq8Qi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe9EG50qha5gg2GuQ1tbuVBTDI7uTCwcWzu6Ym1IP1YqQTUZEDsu64wL+yQE1Jra2HSAcePKc1BGHmc4MJvh5qak7EDM6LjcI2o1lOgPoNwC9dLO4WnFfv9Rf9zHvZ20mHgOLvGIiKqvnqXZ6MpK86cLv3NtOf5SjtbQeasWGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W0v5E46V; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W0v5E46V"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7caf5314847so1248282a34.0
        for <v9fs@lists.linux.dev>; Mon, 15 Dec 2025 08:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1765817198; x=1766421998; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SoCDHDPheLIuvfNyBhqCR3ZYhOapE4jht+oC8y0apU=;
        b=W0v5E46VQFM3i4hwsrlIeDNPYmjsecOfnBaTwwgBzTxTXsDzvdAKPpk/Hkh8qUf0D2
         UzfKqNMtq11pj1XEJbtdOOqLZrYHxU/kmaWjdhafvVUBdejoZchh+9NjeYy+Xpyx2f4C
         hABL6FOSeZI5EbBKBK3G36j9xzqVL4lo3YENSlM9vuNIzFWb+O/jFtFtFxjd5865Angs
         2VWbPzW0WVhBqpxjFRwwCsB9E+NzG+u0BmLvjN2LvPOrKiSoT7hnKQsPyzkguuJBKBzM
         APE3H9IvWwv8FaS4MIxldmek8B8pfaisK/OcRSeceO/QtKrbBH0gi0/zc4AEK5BWkXq5
         Iokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765817198; x=1766421998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SoCDHDPheLIuvfNyBhqCR3ZYhOapE4jht+oC8y0apU=;
        b=rN5dCWOoRu895ALxdYR1RB4fMB2LxEFAb0N5rS9GC+DLP0KuYBJwod94HhWH1FtBBb
         mtdZQTKZtxpWfUi7FkgqQElm4OU78jdiym1P+O3IE/3N9gwGNQwjW50ALs5JaIvtG0Hh
         I6PC/6i/bG2lsnaWrYRhImMneyaA7swhN7Yrr61YWcqj6zo26KWEBaaltVvpeAtglmy+
         4yi+s4SM71XnZD0ZcgXzVaMf4VAmiGdIiD1Jr0x6brUuSPZe+tsnHp1gDttrjdTMOHA7
         tOIssK1VIoWfNNydVAkHVPFTfCracSXxBwTWZlCrkZ2T0EBK0YIFE7KIMgPLIPjze3k7
         9uRg==
X-Forwarded-Encrypted: i=1; AJvYcCW0fOxmVJp3uo0Wpevj+gvAUQ3FPC/NnpMSAdIMkxYMhKoku2hrJJOWvI7/e7Tnl78KEx6G@lists.linux.dev
X-Gm-Message-State: AOJu0YxNQ4ihR4bt3Z+8Hjc7/9OKpYtax56aP4PaumGwSgOvQyVmZt9Y
	bcf6NIIntOBchCMBLeZMJqu7STlwvJS8/7zURjzQQan4BTt0tkJSOPZY5+HXGlyVKg0=
X-Gm-Gg: AY/fxX6ooTOQg2O+P5uldcPigfEPkw/sJY30fX2XilOEs20pnDy87UsCm21ZkYxZdu7
	JKJaFSY1kf740YgMd2D58JrPRar0zk0oNcWdJAiACuK9At0bxvBI5s/4hcMjMTMsjCZWRp6beDd
	DBWdafpfVWZtRMHiL17W70qvlIYpG/qc2clXGFNw3WysIhS7fspeP+RCC5SCMWEG8kP62jQLjoL
	GPBLtBhwiHG//8mSgMl27voBf/ZE54X9AuK/SX9OITaP2k9GE5UBGUL0NoCwfQ/Uzq1kaeuajrY
	2rALBlYbmDe6glGGRJEG4kE9upOWILG4GYByNPvA7WB1OYVN3sAvahkQmISB4bGQX+1VKqt23bH
	EkmhwlUmrAVEiZo2t7PMcDd1YCTg7CeUm6bN5Ieas/zQO4ptZGqmooEWcHgtiPQjJJscvXw==
X-Google-Smtp-Source: AGHT+IGn7h1f7+juW0DPeV9odWZu2HhRoumaEqzK4HN3WAhofgYoYohcZLYH8XSf9AQ4dU/zTy93pg==
X-Received: by 2002:a05:6830:4493:b0:74a:6ea5:a0ed with SMTP id 46e09a7af769-7cae83836e5mr6964283a34.33.1765817197817;
        Mon, 15 Dec 2025 08:46:37 -0800 (PST)
Received: from 861G6M3 ([2a09:bac1:76a0:540::2d4:95])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb2fcc39sm9701624a34.19.2025.12.15.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:46:36 -0800 (PST)
Date: Mon, 15 Dec 2025 10:46:34 -0600
From: Chris Arges <carges@cloudflare.com>
To: asmadeus@codewreck.org
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Christoph Hellwig <hch@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2] 9p/virtio: convert to extract_iter_to_sg()
Message-ID: <aUA7aqpEBWIN1lKQ@861G6M3>
References: <20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org>
 <22933653.EfDdHjke4D@weasel>
 <aT4PZUtvirfq3Lov@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aT4PZUtvirfq3Lov@codewreck.org>

On 2025-12-14 10:14:13, asmadeus@codewreck.org wrote:
> 
> (Chris, sorry, I had dropped you from Ccs as you were Cc'd from the
> patch itself and not the header... See [1] for start of thread if you're
> interested)
> [1] https://lore.kernel.org/r/20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org
> 
>
No problem. Would it help if I tested this v2 patch? I still can easily
reproduce the problem.
 
> Christian Schoenebeck wrote on Sat, Dec 13, 2025 at 07:02:00PM +0100:
> > On Saturday, 13 December 2025 16:07:40 CET Dominique Martinet via B4 Relay wrote:
> > > This simplifies the code quite a bit and should fix issues with
> > > blowing up when iov_iter points at kmalloc data
> > > 
> > > RFC - Not really tested yet!!
> > 
> > TBH, that bothers me.
> 
> Well, that just means "don't bother spending time testing much (or
> debugging if you do test and run into bugs)" and it likely won't be
> merged as is -- this is enough to start discussions without wasting more
> time if this gets refused.
> 
> > Also considering the huge amount of changes; again, what
> > was actually wrong with the previously suggested simple patch v1 [1]? All I
> > can see is a discussion about the term "folio" being misused in the commit log
> > message, but nothing about the patch being wrong per se.
> > [1] https://lore.kernel.org/all/20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org/
> 
> I agree we're close to a "perfect is the enemy of good" case here, but
> while it didn't show up in discussions I did bring it up in the patch
> comments themselves.
> My main problem is I'm pretty sure this will break any non-user non-kvec
> iov_iter; at the very least if we go that route we should guard the else
> with is_kvec(), figure out what type of iov Chris gets and handle that
> properly -- likely bvec? I still couldn't figure how to reproduce :/ --
> and error out cleanly in other cases.
> 

If it helps I can work on a more isolated reproducer. Essentially I found
this when running some of our internal testing tools which spin up qemu VMs
and run kernel tests. I may be able to whittle that down to something
externally consumable.

> That's enough work that I figured switching boat wouldn't be much
> different, and if nothing else I've learned -a lot- about the kernel
> scatterlist, iov_iter and virtio APIs, so we can always say that time
> wasn't wasted even if this patch ends up dropped.
> 
> The second problem that I'm reading between the lines of the replies is
> that iov_iter_get_pages_alloc2() is more or less broken/not supported
> for what we're trying to use it for, and the faster we stop using it the
> less bugs we'll get.
> 
> 
> (It's also really not such a huge patch, the bulk of the change is
> removed stuff we no longer use and massaging the cleanup path, but
> extract_iter_to_sg() is doing exactly what we were doing (lookup pages
> and sg_set_page() from the iov_iter) in better (for some reason when I
> added traces iov_iter_get_pages_alloc2() always stopped at one page for
> me?! I thought it was a cache thing but also happens with cache=none, I
> didn't spend time looking as this code will likely go away one way or
> another)
> 
> 
> > > This brings two major changes to how we've always done things with
> > > virtio 9p though:
> > > - We no longer fill in "chan->sg" with user data, but instead allocate a
> > >   scatterlist; this should not be a problem nor a slowdown as previous
> > >   code would allocate a page list instead, the main difference is that
> > >   this might eventually lead to lifting the 512KB msize limit if
> > >   compatible with virtio?
> > 
> > Remember that I already had a patch set for lifting the msize limit [2], which
> > was *heavily* tested and will of course break with these changes BTW, and the
> > reason why I used a custom struct virtqueue_sg instead of the shared sg_table
> > API was that the latter could not be resized (see commit log of patch 3).
> > 
> > [2] https://lore.kernel.org/all/cover.1657920926.git.linux_oss@crudebyte.com/
> 
> Ugh, I'm sorry, it had completely slipped out of my mind...
> And it was waiting for me to debug the RDMA issues wasn't it :/
> 
> FWIW I never heard back from former employer, and my lack of hardware
> situation hasn't changed, so we can probably mark RDMA as deprecated and
> see who complains and get them to look into it if they care...
> (I'm really sorry about having forgotten, but while I never have much
> time for 9p at any given moment if you don't hear back from me on some
> subject you want to push please do send a reminder after a month or
> so... It doesn't excuse my behavior and if we had any other maintainer
> active that might improve the situation, but at least it might prevent
> such useful patches from being forgotten while waiting on me)
> 
> (... actually now I'm done re-reading the patches we've already applied
> patch 10/11 that could impact RDMA, and the rest is specific to virtio,
> so there's nothing else that could go wrong with it as far as this is
> concerned?...)
> 
> 
> 
> OTOH I've learnt a lot about the scatterlist API meanwhile,
> and I don't necessarily agree about why you've had to basically
> reimplement sg_table just to chain them (what you described in
> patchset 3:
> > A custom struct virtqueue_sg is defined instead of using
> > shared API struct sg_table, because the latter would not
> > allow to resize the table after allocation. sg_append_table
> > API OTOH would not fit either, because it requires a list
> > of pages beforehand upon allocation. And both APIs only
> > support all-or-nothing allocation.
> )
> Having looked at sg_append_table I agree it doesn't look appropriate,
> but I think sg_table would work just fine -- you can call sg_chain on
> the last element of the table.
> It'll still require some of the helpers you introduced, but the
> virtqueue_sg type can go away, and we'd just need to loop over
> extract_iter_to_sg() for each of the sg_table "segment".
> 
> If I'm not mistaken here, then the patches aren't that incompatible, and
> it's something worth doing in one order or the other.
> 
> 
> 
> Anyway, what now?
> I'm happy to delay the switch to extract_iter_to_sg() to after your
> virtio msize rework if you want to send it again, but I don't think it's
> as simple as picking up the v1.
> 
> I've honestly spent too long on this for this weekend already, so
> I'll log off for now but if you have any suggestion I'm all ears.
> 
> Thanks,
> -- 
> Dominique Martinet | Asmadeus
