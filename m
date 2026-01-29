Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FF2264A9
	for <v9fs@lists.linux.dev>; Thu, 29 Jan 2026 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672226; cv=none; b=hx7R0txjkmioHOXeHyTNftB6goQhanOlpKKsPaS8I6i/mnnoqD1tiiCpU3wakrFvhW5jv3gTAfQDa8uTwajF/vuvr/TNHp9ooyE1XESbCp13FJpjjmGku+Hlro9W49dSuSxxWSyBJNb5hlFcaHJ94HQbdeiVQ4rnKqcbJF65B0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672226; c=relaxed/simple;
	bh=oPw/nsqrWP4LErhWBk/YfEBooRpjecURWVx0sDitESY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcU+v83qu2IYJlGL7lU4sJab9Wf05iEx79Tqr/OmWveLBOtDmpznTapI0H/8SFXhykOKJQLQeL4BvJVU9KSp/qQGTAxwsNRHwTQS5vs2QDWW+ZeJ2q21KsjZcaSSrg/nQ11mkD3/g1WB6KYzs6hLpYMvr+2X+mc/MLK7hDjnkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Utfzl1e3; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Utfzl1e3"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3CEA914C2D6;
	Thu, 29 Jan 2026 08:36:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1769672219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQDqB+mpzOzpDLWettESVpWi4zTuQoKZ83rJ5PXlXsE=;
	b=Utfzl1e36A2wZv76F17RVhsSsXY0plzYVCueTuT85WwlXMo1A38GOI7w8DmPKUgsaSjKLY
	28kUw9EOU1a7YYghh+r3TM9fBC9H/6y8hiA0QFzI8vWSTFunw8BsAJj7liML7O8AKuimDm
	IbGyQKd+g0qg7xNLiGdA+9hR43thY5644oMToIvD+kV4qTqWXU3TPHzp35/HebnU5aaL9q
	NoyKrZjsOYhLZIrtCWCmhAYJx+QOQ9E6GQKL86rZwsGsu/kFpPbptpWBw8lB0kW5YACTew
	VgjRwkmTHrfUE3s9f/ndkr+YkoahiOK5WRpl56T1bfBo7pXfQDA3EWG2R4lFmQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d3792bec;
	Thu, 29 Jan 2026 07:36:55 +0000 (UTC)
Date: Thu, 29 Jan 2026 16:36:40 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefano Stabellini <stefano.stabellini@amd.com>,
	xen-devel@lists.xenproject.org, jgross@suse.com,
	v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH] 9p/xen: protect xen_9pfs_front_free against concurrent
 calls
Message-ID: <aXsOCNkLvUHex-YT@codewreck.org>
References: <20260123184009.1298536-1-stefano.stabellini@amd.com>
 <aXRXbFVmilATqvfO@codewreck.org>
 <alpine.DEB.2.22.394.2601261354410.7192@ubuntu-linux-20-04-desktop>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2601261354410.7192@ubuntu-linux-20-04-desktop>

Stefano Stabellini wrote on Mon, Jan 26, 2026 at 02:09:01PM -0800:
> > I don't understand this priv->rings != NULL check here;
> > if it's guarding for front_free() called before front_init() then it
> > doesn't need to be checked at every iteration, and if it can change in
> > another thread I don't see why it would be safe.
> 
> xen_9pfs_front_free() can be reached from the error paths before any
> rings are allocated, so we need to handle a NULL priv->rings but it
> doesn't have to be checked at every iteration. I can move it before the
> for loop as you suggested.

Yes, please move it above the loop

> > > @@ -310,9 +306,18 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
> > >  
> > >  static void xen_9pfs_front_remove(struct xenbus_device *dev)
> > >  {
> > > -	struct xen_9pfs_front_priv *priv = dev_get_drvdata(&dev->dev);
> > > +	struct xen_9pfs_front_priv *priv;
> > >  
> > > +	write_lock(&xen_9pfs_lock);
> > > +	priv = dev_get_drvdata(&dev->dev);
> > > +	if (priv == NULL) {
> > > +		write_unlock(&xen_9pfs_lock);
> > > +		return;
> > > +	}
> > >  	dev_set_drvdata(&dev->dev, NULL);
> > > +	list_del_init(&priv->list);
> > 
> > There's nothing wrong with using the del_init() variant here, but it
> > would imply someone else could still access it after the unlock here,
> > which means to me they could still access it after priv is freed in
> > xen_9pfs_front_free().
> > >From your commit message I think the priv == NULL check and
> > dev_set_drvdata() under lock above is enough, can you confirm?
> 
> Yes you are right. I can replace list_del_init with list_del if you
> think it is clearer.

Since you'll send a v2 for the loop check, might as well do this as well
if you don't mind.


> > > @@ -473,6 +482,11 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
> > >  		goto error;
> > >  	}
> > >  
> > > +	write_lock(&xen_9pfs_lock);
> > > +	dev_set_drvdata(&dev->dev, priv);
> > 
> > Honest question: could xen_9pfs_front_init() also be called multiple
> > times as well?
> > (if so this should check for the previous drvdata and free the priv
> > that was just built if it was non-null)
> > 
> > Please ignore this if you think that can't happen, I really don't
> > know.
> 
> That should not be possible before freeing priv first:
> xen_9pfs_front_init is only called when the frontend is in the
> XenbusStateInitialising state (see xen_9pfs_front_changed). Once we
> store priv we immediately switch the state to XenbusStateInitialised,
> and there will be no more calls to xen_9pfs_front_init. If the backend
> forces a re-probe, xenbus invokes xen_9pfs_front_remove first, which
> frees priv.

Ok, this makes sense to me.
I don't have any setup to test xen so trusting you here, but this looks
sane enough so will apply v2 when you send it

-- 
Dominique Martinet | Asmadeus
