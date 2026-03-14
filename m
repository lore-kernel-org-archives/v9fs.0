Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B91A6813
	for <v9fs@lists.linux.dev>; Sat, 14 Mar 2026 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773468116; cv=none; b=NXaPiQsSm04MCv+sNtXmfL6+EHr8q9HEt3xkf5fr75l+YRWiVyI4lhsL28jpLCaaI6ohQ1smqwS1MPEWch2Q+1627Dy4AKjQ3SU9EpB2cbYaZ1XcXQ9L7sQL1BI6TRgG2qSB2HCy0mTOPPCOdQelDrKQKAtoiY5eKmDA+JEI0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773468116; c=relaxed/simple;
	bh=AvtvzcdCSVbGsbjHwimwreG7EVSCVEoOn7iAeppjrkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJywFVtdwhnWw4dyV7KvBhq/O2vCjA7KrlvXqRBzrFX4u7I7vnCaZuhmRXq0+pyi3bo0mYIyxcn6eOPQ8yFAltU54nHbseEn5OtDDAC+Obm2vXPNm9CbQXJUnUhppc9ZkAtmP9xZFGQv4uc5IY5NkqQUe4rpejmt0o3FSuEgmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qsaHRV9A; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qsaHRV9A"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6F6AD14C2D6;
	Sat, 14 Mar 2026 07:01:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1773468105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcp67iuIViZsl+G1DOnI57D0svrPqokbvFTenZiv2zw=;
	b=qsaHRV9AWokT7+tqd8VDzCQgQq7UfFbdMuZbWfeIxDmU+ZXol1eMN0buMEdNoxHLmvKp77
	rVyRNCXXYZeGfjUG6WMpr+dL3rcelriWLSz+pm9aEsNs2NCnPiYoRucqzaM4PmnGj7Dg+0
	rq9gD8Le0iOlyEVuilljAixs5OZ2ZqdweGm4qICaf6izC0tM3W78T78OqLcUwzFMFpi2PW
	krVaLbonF52GLGzVSl4rO8r56GoxbTl19kapU8974CpK4zs0EZ4sGFZgtrHs4jYSsMgRrL
	XdSvNGHDL6NEijfTdqf/YxtPjDkbBwtH5aZOjeeuZndfnPkszsMaeyfMhW81Kw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9d694874;
	Sat, 14 Mar 2026 06:01:40 +0000 (UTC)
Date: Sat, 14 Mar 2026 15:01:25 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Hyungjung Joo <jhj140711@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org,
	v9fs@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <abT5tabfYV9a9RF_@codewreck.org>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313171659.1225180-1-jhj140711@gmail.com>

Hyungjung Joo wrote on Sat, Mar 14, 2026 at 02:16:59AM +0900:
> p9_usbg_close() tears down the client transport, but usb9pfs keeps
> using usb9pfs->client from asynchronous TX and RX completion handlers.
> A late completion can therefore dereference a client that has already
> been freed during mount teardown.
> 
> Clear usb9pfs->client under usb9pfs->lock when closing the transport,
> detach any pending TX request from in_req->context, and make the TX/RX
> completion handlers bail out once the transport has been detached. This
> keeps late completions from touching a freed or rebound p9_client.

Just to make sure the problem is the usb9pfs struct being freed, not the
p9_client itself which is still alive after the usb device is gone
(until umount)?

I'm surprised free_func isn't called after unbind, which should stop the
queues (through disable_usb9pfs)?
or are the ep being disabled not enough to ensure the callbacks are not
in use? (e.g. disabling prevents further calls, but doesn't wait for
currently running/queued requests?)


(Also, thanks Michael for looking -- I'll let you do a first review
before looking deeper)
-- 
Dominique
