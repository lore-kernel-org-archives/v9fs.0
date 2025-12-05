Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227212C0265
	for <v9fs@lists.linux.dev>; Fri,  5 Dec 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764936546; cv=none; b=nOA9vn78INUmZFT6qLDSwuUORNApDtRrj7UFEHtldhSgUe5amJkyEcy4ycXErEQ4GfpfC9TQVaiMFibeA1GvMfqxKmtUaw/469VTC2tTrelhxGZecVqDfdGcb4v4na4yvhXOdF9MHf2Xob45aIVNVPO0SO+/488oh6XRYM5UT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764936546; c=relaxed/simple;
	bh=LaOiU5bWnuebDcDGPmZl4kS1pqOs9u+qoKUghe2ucy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZpVUOvCiC0RE48mn8/06lZC18gsIesvlf9UrpnLbfN1yTqUlUbex/S8zbX4fTdg05dm53IDSaqam7zXIGXYqCJ8LyYvPer/wfpqcbtPm073JKXURQrORJOjF740HfsbVkabWjR906Hd1Ii3goazB1H6BfKwvu5Y8T/XJs87FHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=s6PXVKof reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=dPU2tHJO; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="s6PXVKof";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="dPU2tHJO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1764937442; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=nDQbuCR0xlv5qS7HgYyT3GoyUmABzZVoQRnEZkWUh3E=; b=s6PXVKofvvjugA2ttQpc+vsiTk
	lS12Yz1SNA5IVnjo+Esm5EgpBPiSPDKPDpCrYj3zUESVFQyQnYvleeObVuFH9aTo4CI4dv3CsWZd3
	SrkL9K9zeII7vsFr2/gbqnUbNchJ3Bjc8rkrQQVV3QjbNCYHL2NB1dM96Dk/CrVSrSSk3dhdnVqal
	34jxADZ+u0IXUUlOYgDzDKcURnVhgS6cf3aByfhtn79A9RzPuVaTVVseyoyP1R6BVTXeWY7YMMccq
	0lH86gv+tdpXEoOf/IPjUzmLKtLliXjqZuREmTg55WxOXK+wg0j7m6CqRBLK5+mISX/euIeLe/yoc
	WgCSWTUw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1764936542; h=from : subject
 : to : message-id : date;
 bh=nDQbuCR0xlv5qS7HgYyT3GoyUmABzZVoQRnEZkWUh3E=;
 b=dPU2tHJOVa8Cw/bmUcLXhUtEi9Pv/FTkwhvRTzv3rcLhtHGhF/l+xSEkhXDqc8mGV4P+S
 eEQzbQXxVGiCPSwM//EYqdH8mCQCNeMvecCV1yhnAEzVWCSbt4r5hrlWcPFFhNsa/jZpZIS
 CPaooqondSU99I97Uf1KcPRfcVgC3lmvylqyXbLDmx1fY1WGM5XKG604e83WYfcCWu8QlbW
 J+c1D8071FA4LwJXfdQG8lu2KlEriZ9bEk+osjNKNTu7SsQ9NM9NPBNqf1NikQ2BrbPShqg
 cnDRn9CbnU/Fy3nfAnvoplRmULf/ksOBzstqdUnR1j5mHz/KQRnRyydqmWDg==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vRUcA-TRk4wX-Kz; Fri, 05 Dec 2025 12:08:46 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vRUcA-4o5NDgrjBW5-lSAe; Fri, 05 Dec 2025 12:08:46 +0000
Date: Fri, 5 Dec 2025 12:53:04 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
 eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aTLHoPiC93HTc-VM@pilgrim>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org> <aSdgDkbVe5xAT291@pilgrim>
 <aSeCdir21ZkvXJxr@codewreck.org>
 <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>
 <aS47OBYiF1PBeVSv@codewreck.org>
 <13d4a021-908e-4dff-874d-d4cbdcdd71d4@redhat.com>
 <aTBTndsQaLAv0sHP@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTBTndsQaLAv0sHP@codewreck.org>
X-Smtpcorp-Track: wkwVBS0a8HB7.GxQ0xs_-OO5R.kfX8fgRwhdQ
Feedback-ID: 510616m:510616apGKSTK:510616sykM-zowXn
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Thu, Dec 04, 2025 at 12:13:33AM +0900, Dominique Martinet wrote:
> Eric Sandeen wrote on Tue, Dec 02, 2025 at 04:12:36PM -0600:
> > Working on this, but something that confuses me about the current
> > (not for-next) code:
> > 
> > If I mount with "cache=loose" I see this in /proc/mounts:
> > 
> > 127.0.0.1 /mnt 9p rw,relatime,uname=fsgqa,aname=/tmp/9,cache=f,access=user,trans=tcp 0 0
> > 
> > note the "cache=f" thanks to show_options printing "cache=%x"
> > 
> > "mount -o cache=f" is rejected, though, because "f" is not a parseable
> > number.
> > 
> > Shouldn't it be printing "cache=0xf" instead of "cache=f?"
> 
> Definitely should be!
> 
> > (for some reason, though, in my test "remount -o,ro" does still work even with
> > "cache=f" in /proc/mounts but that seems to be a side effect of mount.9p trying
> > to use the new mount API when it shouldn't, or ...???)
> 
> ... and Remi explicitly had cache=loose in his command line, so I'm also
> surprised it worked...
> 
> > I'll send my fix-up patch with a (maybe?) extra bugfix of printing
> > "cache=0x%x" in show_options, and you can see what you think... it could
> > be moved into a pure bugfix patch first if you agree.
> 
> Thank you! I would have been happy to see both together but it does make
> more sense separately, I've just tested and pushed both your patches to
> -next
> 
> 
> I also agree the other show_options look safe enough as they either
> print a string or int. . . .
> Ah, actually I spotted another one:
>         if (v9ses->debug)
>                 seq_printf(m, ",debug=%x", v9ses->debug);
> This needs to be prefixed by 0x as well -- Eric, do you mind if I amend
> your patch 5 with that as well?
> 
> 
> Remi - I did check rootfstype=9p as well and all seems fine but I'd
> appreciate if you could test as well

I just tried your 9p-next branch and the issue is gone for rootfstype=9p
using cache=loose (I've also made sure that I reproduce the issue without
the last two commits of your branch).

So yes for me that fixes it, thanks for the patches.

-- 
Remi
