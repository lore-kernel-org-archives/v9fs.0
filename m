Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80573803D6
	for <v9fs@lists.linux.dev>; Tue, 29 Sep 2026 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664162; cv=none; b=EREf6cJKfJm2z37kCejXB3FVTOCoVtO85B/cjbpka5W8XDGEOmkMj/YQvfuGSOp1NWs+KS3e4efZtsUvkvYXm1x7lBiRcOzQqoiupXD46flrSv458Y1h3ehJsIFvxZyI59t9uU2kBu4fyrHPLfjgnVj+0i5mOP7+w5HHz/ksuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664162; c=relaxed/simple;
	bh=eD3aM0hTN885DZDJGbILVdaFcCSySeWIFbdgXoX2TFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/FNCqTwliRp4LDWHYxXpzeomLXEOSfGQMdd51aKWQ5imn6z+UxKNFlKRCzGYO2nEBeX/oRjEbvcOl3VIjtpZOLnFnlk9zX09t/JYnbY+BNyoJAkrVkW18xlzhsU1+FZdIwK0+4el3qRp4oDRDcieSKyHWby0cMJIA+cGeunXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKiosH33; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKiosH33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790664160; x=1822200160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eD3aM0hTN885DZDJGbILVdaFcCSySeWIFbdgXoX2TFg=;
  b=NKiosH33xre0vUEI5jdGq4rjj7+bEGGfp82+r1aqgrhzalKZvBTJZe68
   B6ltlpz01NUVhogy0OoYs+u9FUbyDV0AFuxIyhEi9TRlIjpmqzUC1s8wq
   Rum559kjMZohcgh9MchI+CWzmxMXFlg/PtRS+wVp08zIIo9B3XBhT7Q1D
   EOfOtmTB77txZdh3utvug1yvqVnq2Lb9BPoyxSZz93WlpUT5KOQ7szLqk
   E+zY0pffYa/C4KLvbqHbTKCGkRLdR49MImDf01sE6hnun6ZodZW697+sG
   ybkLIvt1Hshbqk2p96gc4+AXvu2Dc6X5mY6HjgQf7KN6EYX0ThyzS/ZB7
   g==;
X-CSE-ConnectionGUID: ++E/8JwmTmWLb9bG3ZPwOQ==
X-CSE-MsgGUID: ZAcdvjyGRhOCgTYCwYMhMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90239253"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90239253"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 23:42:40 -0700
X-CSE-ConnectionGUID: gjeF6tBaS3q+98OnTRjoOg==
X-CSE-MsgGUID: J4Cas1MXQ6ivk9g3xD4M9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313220375"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 28 Sep 2026 23:42:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 2216299; Tue, 29 Sep 2026 08:42:37 +0200 (CEST)
Date: Tue, 29 Sep 2026 08:42:37 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
	andreas.noever@gmail.com, YehezkelShB@gmail.com, corbet@lwn.net,
	linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH 1/3] thunderbolt: stream: Add tbstream_dev_from_file()
Message-ID: <20260929064237.GL106095@black.igk.intel.com>
References: <20260924162333.147033-1-alan.borzeszkowski@linux.intel.com>
 <20260924162333.147033-2-alan.borzeszkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924162333.147033-2-alan.borzeszkowski@linux.intel.com>

On Thu, Sep 24, 2026 at 06:23:31PM +0200, Alan Borzeszkowski wrote:
> Add tbstream_dev_from_file() which returns USB4STREAM device behind a
> file. Expose it to in-kernel users via separate header.
> 
> Required by the 9P Thunderbolt transport driver to validate mount
> source.
> 
> Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
