Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2566612EBCC
	for <v9fs@lists.linux.dev>; Wed,  1 May 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573160; cv=none; b=f4F5A8cAmP0bBpX6oZzVG5otAdRA333p1+BFfiRLNximJwnUQI8yRQ9LVn5qXgi093dI4csMfw9ONZoNDxmuD3ys4ntshiMZuqB/kc1wlxipOBhs6cDw8EGyzfPKAZJPyigA6CmhVX0gM/WwWiAUCGrPQuBAG7u5+/9UHfh8kaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573160; c=relaxed/simple;
	bh=0fX7DMTnyqd2OctZ1Pn8GWeMAq5i4D6ET5kIT05SFxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udFf4cQHt1GnIliLj7KyvXiSIAk1ZyYQN1JI+fG1VizV/RsJ/Khek2eUP99UK/dFbDHvd+FIwjLk2Se1p2W1FLu/jKa5u/HSbs1Mm6XbFuMDveLBb9j4LnckAP3XFBBNioxwVOm9/6rhkyDx2/eCeuYl7UIJL/9GkM8gCmOr6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 693310 invoked by uid 1000); 1 May 2024 10:19:18 -0400
Date: Wed, 1 May 2024 10:19:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Grzeschik <mgr@pengutronix.de>
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
Message-ID: <96fe85f7-eaf1-4231-985b-14514cf53f3d@rowland.harvard.edu>
References: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
 <20240116-ml-topic-u9p-v4-1-722ed28b0ade@pengutronix.de>
 <1fb801bf-3bef-4f95-8036-fc8634679141@rowland.harvard.edu>
 <ZjH_cx_0uBLc6M6L@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjH_cx_0uBLc6M6L@pengutronix.de>

On Wed, May 01, 2024 at 10:38:11AM +0200, Michael Grzeschik wrote:
> On Mon, Apr 29, 2024 at 09:51:20PM -0400, Alan Stern wrote:
> > On Tue, Apr 30, 2024 at 01:33:26AM +0200, Michael Grzeschik wrote:
> > > We move the u_f.h header to include/linux/usb to be
> > > able to compile function drivers outside of the
> > > drivers/usb/gadget/function directory.
> > > 
> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > 
> > Given that you're moving a private header file to a public location,
> > don't you think it should now have a name that's more meaningful to
> > general kernel developers than "u_f.h"?
> 
> Fair point.
> 
> How about func_utils.h instead?

Yes, that would be a lot better.  Especially if you put it in 
include/linux/usb/gadget rather than include/linux/usb.

Thanks.

Alan Stern
