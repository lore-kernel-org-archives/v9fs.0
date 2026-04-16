Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BAB1F09A5
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776305246; cv=none; b=ilCAh4mmR4Dk2OliTgg5SF6UkT0hVi951MO5bEvBU6y9JVCXJL8yqcizlfYSuFwHuNbsq1Rz+AYWTfYG+97K0xNwmMA4ta+2AlsWsfrFrDkuEhaj/dvax0v1kjxhWpL9CLSO6m29fv/+CNX3j/X1zYq+KyfTCEGGj4LdhyactcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776305246; c=relaxed/simple;
	bh=oS3uKrsUzBQNQqQQIOWqdves4k5MQ6GURR/AJBvuCC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVbMSC2Zm1derSGHQH4A7XGptG/j5cdIFI66D/cefsiC06Bc8odieEFiY62ox8+3c7sUTha6rIZwN3RgKu3L7fuKGlu4y8UbQ+sd9N8y5dSoVTDpnqtvNIM5Qi+AgTfuFL1Pm3EAYKUrcknis/xgabeC50rfi7Gejfl7DKRjfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=G1tPEYIB; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="G1tPEYIB"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 04E8C14C2D6;
	Thu, 16 Apr 2026 04:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776305243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0MsWW6tF186aGAJbaRd0sXc+T62QMaBAq56cNqKTKQ=;
	b=G1tPEYIB3tj/jEel3Zf6VKpXRqQvBfTImc+q+Gzn6JlAr0HUD3bwNVAVwfLyjyVKhcxoRC
	YhLTFYuo4WUQb6H8x6R5brioLuZ+57mvJ2lpV49mZ9CLXP0BZ5ODkXolct59zu1hjAQG6v
	LVZjTHpuMTnsk6e1KIYyhZQKf1iwwQNkElLwklCyqovOCyc4Qd1lAZ000oGE+hYpaKW04x
	EE7rfLkWkkXcvVKijkc3liULXlTNAmgQ0Fu1rXN8q1HFmzumr8HoPLjJ3do5WVoPz7sBDU
	3EM2z3SoDbGHJ4ilGQeXRrOky3JgFz9m+zB2VAoymiwA4u63Y9Qi1peGSRGGjg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a5717ecc;
	Thu, 16 Apr 2026 02:07:19 +0000 (UTC)
Date: Thu, 16 Apr 2026 11:07:04 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Eric-Terminal <ericterminal@gmail.com>, ericvh@kernel.org,
	lucho@ionkov.net, stefano.stabellini@amd.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] 9p/trans_xen: replace simple_strto* with
 kstrtouint
Message-ID: <aeBESEDdGyf53Ttw@codewreck.org>
References: <20260324153023.86853-1-ericterminal@gmail.com>
 <20260324153023.86853-3-ericterminal@gmail.com>
 <alpine.DEB.2.22.394.2604081830330.2873990@ubuntu-linux-20-04-desktop>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2604081830330.2873990@ubuntu-linux-20-04-desktop>

Stefano Stabellini wrote on Wed, Apr 08, 2026 at 06:30:43PM -0700:
> On Tue, 24 Mar 2026, Eric-Terminal wrote:
> > From: Yufan Chen <ericterminal@gmail.com>
> > 
> > In xen_9pfs_front_init(), parse the backend version list as comma-separated
> > tokens with kstrtouint(), keep strict token validation, and explicitly
> > require protocol version 1 to be present.
> > 
> > This replaces the deprecated simple_strtoul(), improves error reporting
> > consistency, and avoids partially parsed values in control paths.
> > 
> > Signed-off-by: Yufan Chen <ericterminal@gmail.com>

FWIW this patch 2/2 was apparently truncated (won't apply because of the
missing context line), but looking at V2 there doesn't seem to be any
actual change missing, so applied anyway...

> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Thank you for the reviews!

I'm picking these up for whenever I can send the patches.
-- 
Dominique Martinet | Asmadeus
