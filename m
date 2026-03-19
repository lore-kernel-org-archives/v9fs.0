Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589719CC0C;
	Thu, 19 Mar 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912129; cv=none; b=M59PkuxsNAhHoMrJWgh8+0mQrlSK8zcdkB3WeejRcAP969sz9NceO5lqk1PJxNJcHEJOqnNUx6alZwvST7ywwC4JrPgNRL+qQpjwoCb5wPnsgmNTVqOJ2/iGFKOqWcWhmCeXdtkWgVRB6rYrfhW6URaXBWz2oiBadrT+9S7ZfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912129; c=relaxed/simple;
	bh=yV+oNWSRfhNNk7KEfDwyzfekYC7fBTr325RYARQ8zHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZKVXOK3FggrEIzcBegZ8uPu5woInMBgEOg5+BLYSlztYHAUfdHKkiUdw4Tb4rwduENmg9yfv+/2gKfQunCvQuZQlrZPGyABy5otQJFt6WGXeoE8yF8rZ/11g9V3jT5+KDpVhUP1C3nYpZhqMZI72b30ff9CgNHAMFXmngUPLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VshL30hZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VshL30hZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B264DC19424;
	Thu, 19 Mar 2026 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773912129;
	bh=yV+oNWSRfhNNk7KEfDwyzfekYC7fBTr325RYARQ8zHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VshL30hZ8EOYxuQvRP/qBNP4WSff0BO902g/IGOJhERCTY+kIbXGLn9WL3QqYiXwY
	 t+c3Y8FNneUrEe+6wyhusqRRk+cFjo49Qcrb0TwDImPY1Bs5sRaK30b28H0n8c2dlX
	 MQlRWcV39/QRpanEhY6iu3EBShkJ7rBDssw9S2EI=
Date: Thu, 19 Mar 2026 10:22:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Hyungjung Joo <jhj140711@gmail.com>, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <2026031935-purely-guise-8262@gregkh>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
 <abs0Q2Sw3WvLYFbe@pengutronix.de>
 <abtDrEQ4ySmhujwG@codewreck.org>
 <abu-1VmxKlRgHcyX@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abu-1VmxKlRgHcyX@pengutronix.de>

On Thu, Mar 19, 2026 at 10:16:05AM +0100, Michael Grzeschik wrote:
> On Thu, Mar 19, 2026 at 09:30:36AM +0900, Dominique Martinet wrote:
> > Michael Grzeschik wrote on Thu, Mar 19, 2026 at 12:24:51AM +0100:
> > > On Sat, Mar 14, 2026 at 02:16:59AM +0900, Hyungjung Joo wrote:
> > > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > I wonder where greg did this review? Was this in another thread?
> > 
> > Yes, it was when Hyungjung Joo sent this to security@, so the review was
> > not public
> 
> Since the patch was already reviewed by greg, I decided to keep it
> as much as it is and include it in one in my series. This way I can keep
> the Reviewed-by and the Fixes tag for stable.

Hey, I just did a cursory review, feel free to drop mine if the patch
has changed at all, doesn't bother me in the least.

thanks,

greg k-h
