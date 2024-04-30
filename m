Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D268E53A7
	for <v9fs@lists.linux.dev>; Tue, 30 Apr 2024 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441883; cv=none; b=mfPBWskjYt4j9+U8LWcz2ffM5+01LN4cmN7/0vqwaH2y40N3YLGswM5/y+piaKvtPIeNdMy+PdhDjzhMnSUFFY4Vnc2eHRcjon661pg5oCYGkK00aJ1QIfVDDoyuYkZfFdA6Pno0qq2EjkvqcKsHHVixUPG2lW4dn6IT0wYURxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441883; c=relaxed/simple;
	bh=1dZFllmSUYIU5Tu60QYWUdcFtWjeeWfLdtbeuvwZiCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTgSUaoyxHpmV5tiMC5Dc1oBsXWeIVkjFP0XaxwPqinkDqdlxNxRVDf4MoxqCBBUPzpflkLpwKlcF0Tt8xV1qkiJDJx+1regztbAeFHVdksff0YMItrSOOPLp+lAp+vYDEAEssFI6utjZsffZymHYHaaFWQxpKyZGapND4hUIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 640741 invoked by uid 1000); 29 Apr 2024 21:51:20 -0400
Date: Mon, 29 Apr 2024 21:51:20 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
  Latchesar Ionkov <lucho@ionkov.net>,
  Dominique Martinet <asmadeus@codewreck.org>,
  Christian Schoenebeck <linux_oss@crudebyte.com>,
  Jonathan Corbet <corbet@lwn.net>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev,
  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v4 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/
Message-ID: <1fb801bf-3bef-4f95-8036-fc8634679141@rowland.harvard.edu>
References: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
 <20240116-ml-topic-u9p-v4-1-722ed28b0ade@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v4-1-722ed28b0ade@pengutronix.de>

On Tue, Apr 30, 2024 at 01:33:26AM +0200, Michael Grzeschik wrote:
> We move the u_f.h header to include/linux/usb to be
> able to compile function drivers outside of the
> drivers/usb/gadget/function directory.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Given that you're moving a private header file to a public location,
don't you think it should now have a name that's more meaningful to
general kernel developers than "u_f.h"?

Alan Stern
