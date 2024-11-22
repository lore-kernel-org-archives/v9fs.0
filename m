Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C91BC9EE
	for <v9fs@lists.linux.dev>; Fri, 22 Nov 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286183; cv=none; b=TMy0yR+hi3SiDx/tw5xD3FNCTTs87FV/LBy/h2Z8wsA/wk1oUv/3f1IJDsnSX7OBHJIR8XkeGDa9pcrFhszuvrobBeEgRvZfLXBf2ydquK3dM058YmWOblo7lkWvQt11wjoZtm45IGVUc3j6oWT6ePj0H1Yev7TGSlmBT2nagPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286183; c=relaxed/simple;
	bh=+uinDo0lwq6B8/fmThCcMntjzgH5HjwLRV2uQLD+tRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKmlfTSapzGuqktcrx21/jWzWeNriMIm+abBsfP28x2YmFJDtZI57so6Cvs7YWZziEu6UhfSpvDghOPwXSRuZdsyymJYBfXHMO4UerBKJLdO80elc86VgGNaKxZ+VKnbLLf2lomumVKKTqqttPC7xaw3cFu8QPxyWMgMwAiy8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=H9pW8oao; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="H9pW8oao"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id E1E2B14C1E1;
	Fri, 22 Nov 2024 15:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1732286173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8v3+aQO1zVNTDKznW1DiFi9l9+YX7MeVTMpaVHPOvE=;
	b=H9pW8oao5PKjueGtaVXyFvQ8wm/8qmT4yo9QeGkV5eRrBUvsTVNtF2Oqqy7rpW04CjGwiq
	y9/5ObirE/rFJocrKksXYSnhCpP0FfhO6QwaIR92CiD2R8r45kdnGbjfkFDOuuIuoRqUV9
	h6Wj8QVbhjQF/pcolpMhMNKrS3IlRV5PqjFapY528TnG9TaFOZkBRh1jhjuh/yodWfrA7B
	+vBZdEFa2XLDDxNgBdoWvoFMcERcTn0tz5CQmOn0RSCmFHaVpTfWxICqiaUSL0XyEUSCWl
	wCRswW2eU430Xw3NhFtdT5xTD+yOaj+4000L6gpSEvMosWAaqb+NLaqKNB4f0A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id df0f998c;
	Fri, 22 Nov 2024 14:36:08 +0000 (UTC)
Date: Fri, 22 Nov 2024 23:35:53 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Alexander Merritt <alexander@edera.dev>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Alex Zenla <alex@edera.dev>, Ariadne Conill <ariadne@ariadne.space>
Subject: Re: [PATCH] 9p/xen: fix release of IRQ
Message-ID: <Z0CWyXuMiifOv7HO@codewreck.org>
References: <20241121225100.5736-1-alexander@edera.dev>
 <Zz_F9wMda68xhvKa@codewreck.org>
 <a6570b47-217c-4e92-a64c-16fc34494e3e@suse.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6570b47-217c-4e92-a64c-16fc34494e3e@suse.com>

Jürgen Groß wrote on Fri, Nov 22, 2024 at 02:54:06PM +0100:
> > (style) I don't recall seeing much `a = b = 0` in the kernel, and
> > looking at it checkpatch seems to complain:
> > CHECK: multiple assignments should be avoided
> > #114: FILE: net/9p/trans_xen.c:290:
> > +		priv->rings[i].evtchn = priv->rings[i].irq = 0;
> > 
> > Please run checkpatch on the patches you send (b4 can do it for you if
> > you want to start using it)
> > 
> > 
> > code-wise,
> > I also don't see where unbinf_from_irqhandler would free the evtchn, so
> > is it leaking here, or is it implicit from something else?
> > We only free it explicitly on error binding the irq.
> 
> unbind_from_irqhandler()
>   unbind_from_irq()
>     __unbind_from_irq()
>       close_evtchn()

Thank you, I didn't go far enough.

And also, bah; I just spent 30 minutes thinking why would setting irq to
zero prevent anything, but the bulk of the patch was using the correct
device for unbind (as the commit correctly says, I just saw double-free
and setting something to 0 after free as being related)
I'll just remove this darned line, as the free function can't walk a
ring twice anyway.


Also this made me notice xen_9pfs_front_init calls xen_9pfs_front_free()
on error, but that init is part of a front_changed call and I'd bet
xen_9pfs_front_remove() will still be called afterwards.
If init failure ought to free then it probably should unset drvdata
first like remove, and remove (and possibly many other dev_get_drvdata
calls) should check for null; otherwise it's probably best to leave it
to remove to call free exactly once...

-- 
Dominique Martinet | Asmadeus
