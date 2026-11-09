Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243161;
	b=mLzZWC4oKAjFuHoShcyDmXvDuZbDfqS7+XtZ+0XilpSmaxib/C2PTJdNQnwVIMjvJKTm
	 YwIxLUGrgouXyty1loK6Y0Oht58TlRnm6kWPH+XUj5VYRplEMu8ziuTNzYQThel39dZYK
	 ksHaXf24Ll+c+i9pAPpKVhU2ZfS981F/ns4PG0gLrEu5Pq8+gURXjNNHYyWjv95F87Mkt
	 XB5+TSrO8A43QjznBOeyDEizAtd91OBqZGKwU03bEMLPHd+M93sG8Mhdn0mlQhNHrdFyW
	 H630GIvUYV5BeNPMEICM28qz6nZ9maTLAPHeIScgWksaywKFJj50CmKaRUe+brsL52Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243161;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qEvsgASyiiyks7x4vS2QsfumVfMFULPYeul4eGRCqq8=;
	b=SSAuayEkbyKJK7uWvhdj6S2bLV788AEInViUsNyUiI4jxmuzERdrn0YKgwRO1FyvkQr8
	 HGBwot54+39zJi80hJbry4m9Rm9kKcZLngNVbv/NFjvTTvigK7XOxT4HdEqLap1rnDW58
	 jZ2GT9uPhlGYuQBLt9yz/vts6pyisRgZVfK/jQwWiSosmVRpd4KL42dF54zHyEPm7banJ
	 wCfFY+ZuaNqxDYsNb/AaSBTRfgWR/4LeDKKXa91v2nRAY8U1CLTL59Xn4BI0JG7/dv92V
	 ZiiOXvLIBwh+3ErMAEaOiAMvyrNbIJ0Hqr8O0h0LrIa3cv2+CxnAD0SxiafzhfhkDOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U49LbYej;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684860A261A
	for <v9fs@lists.linux.dev>; Mon,  9 Nov 2026 16:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6684860A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U49LbYej
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794243161; x=1825779161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TqNuFJ4AUkWwd8Ol2yEOSN/851PbYbnaXPGmKn08RS4=;
  b=U49LbYej3/zOLAX/s/zRPBUEzofEwKDU7pldh60XkBiN9/4agMCAbAH8
   Rs2a/ddAk0emizRfpkR8r96dgM803krBxOlUtxXHTAf3q0VDNEVlDMCvi
   iBxcqWsGXn8RGz5eRQSrvx0tSw/6/K4kTk3DfMKoeuQCc/kc/JUM/EEtT
   WjZXmjO1VpaZGnepsXZtANQarxZ+Dp7eptLMuO9mLS9iARFBe+gpT4oZR
   jZ4zI+fFrOAAj+DIu33SoxiZm5gDHEKpYJKqI1ucn/q7BJbb3MSw2o6ce
   gPphiRIMfsQ7XIuM4t5iYcWH2Lru/2eTS+F51wcYxnscAsngN0n/y/fiq
   w==;
X-CSE-ConnectionGUID: 34lCHq+kSYWvuaeNOF/xoA==
X-CSE-MsgGUID: hNx8G4ErQkyfm/rq6Am6HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2869708"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2869708"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:52:40 -0800
X-CSE-ConnectionGUID: rAJgo+LIQ5qJaAcLhRcsAA==
X-CSE-MsgGUID: DyX+TZT8Tfq6txXlnCdk3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7773963"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 09 Nov 2026 08:52:37 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0E10F99; Mon, 09 Nov 2026 17:52:36 +0100 (CET)
Date: Mon, 9 Nov 2026 17:52:36 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, ericvh@kernel.org,
	lucho@ionkov.net, andreas.noever@gmail.com, YehezkelShB@gmail.com,
	corbet@lwn.net, linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH 0/3] net/9p: Add 9P transport over USB4STREAM
Message-ID: <20261109165236.GW176724@black.igk.intel.com>
References: <20260924162333.147033-1-alan.borzeszkowski@linux.intel.com>
 <auKzZIyFW2CTci1b@codewreck.org>
 <bc1ec916278d94116bd9b60e40b549612e3ff3a4.camel@linux.intel.com>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc1ec916278d94116bd9b60e40b549612e3ff3a4.camel@linux.intel.com>

Hi,

On Mon, Nov 02, 2026 at 04:39:15PM +0100, Alan Borzeszkowski wrote:
> Hi,
> 
> On Thu, 2026-10-29 at 11:45 +0900, Dominique Martinet wrote:
> > Alan Borzeszkowski wrote on Thu, Sep 24, 2026 at 06:23:30PM +0200:
> > > This series adds trans=thunderbolt, a 9P transport over the
> > > Thunderbolt/USB4 DMA tunnels exposed by the tbstream character
> > > devices
> > > (USB4STREAM). It's designed for simple host-to-host file sharing
> > > over
> > > single Thunderbolt/USB4 cable.
> > > 
> > > Today the only practical way to use 9P over a USB4 link is trans=fd
> > > which, due to its design, cannot fully utilize USB4STREAM
> > > capabilities.
> > > Thunderbolt transport offers a simpler mount (no fd redirection
> > > required),
> > > busy-poll support and substantial throughput increase compared to
> > > FD
> > > transport.
> > > 
> > > User may mount 9P export with following command:
> > > 
> > > mount -t 9p -o trans=thunderbolt,aname=<exported_remote>
> > > /dev/tbstreamX /mnt
> > > 
> > > Thunderbolt transport achieves a median 1.21x more throughput
> > > compared
> > > to FD transport under same conditions, and the advantage grows with
> > > concurrency: 1.03-1.09x at 1-2 threads, 1.14-1.27x at 4, and 1.34-
> > > 2.28x
> > > at 8-16.
> > > 
> > > As an example, 4K random reads, 4 worker threads. FD transport
> > > achieves
> > > ~53k IOPS, Thunderbolt transport ~66k (+24.7%). 4K random writes
> > > follow:
> > > FD ~28k IOPS, Thunderbolt ~33k (+19.4%).
> > 
> > Thanks for the patches
> > 
> > We've kept adding new transports for 9p lately but maintenance is
> > becoming a burden so let me push back a bit: is the increased
> > performance really worth it over trans=fd ?
> 
> >From the data I've collected, yes. trans=thunderbolt is at worst on par
> with trans=fd and with increasing amount of threads, trans=fd lags
> behind.
> 
> Thunderbolt transport also offers busy-poll support, which boosts
> performance significantly at low thread counts. It cannot be used by
> trans=fd due to its design around polling.
> 
> And regarding maintenance, this transport is simple and much smaller
> than existing ones.
> 
> > 
> > If this could be used to bringup a system with a root filesystem like
> > it
> > was done for trans=usbg I'd see the point, but otherwise the simpler
> > usage could be addressed with a simple mount.9p helper, and at this
> > point I'd consider usb4stream to be used for perhaps one-shot copy
> > and
> > not care too much about 4k random IOs (so less affected by latency
> > if msize is large enough, and for a one-shot backup it doesn't matter
> > too much if it takes 6 instead of 5 minutes)
> 
> In case of one-shot backup, I think my drag&drop scenario from cover-
> letter fits it well. Assuming single thread copy, both transports
> achieve similar results, but with busy-poll enabled, trans=thunderbolt
> cuts about 1/3rd of copy time:
> Copy from 9P client to a server, using trans=fd, takes 22m29s while
> trans=thunderbolt + busy-poll takes 14m50s (~1.5x faster).
> Reverse direction, same improvement: reducing copy time from 41m07s to
> 26m56s. All done on default msize.

That sounds like a good reason to include it IMHO. Also I like the
simplicity - no need to run a separate descriptor feeding process :)

> > If you can convince me this is worth it and can take care of the
> > transport for the forseable future I'm not dead set to refuse this,
> > but
> > I can't say I'm convinced right now, especially as I can't even test
> > this (I don't own two computers with working usb-c...)
> 
> I would be happy to maintain Thunderbolt transport.

If Dominique is okay with this, I suggest to send v2 with a MAINTAINERS
update as well.
