Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB393E3173
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088943; cv=none; b=uODjJHOU01dWgrWmCxoK7YT8g4FT8prRxN7Q6fHcOOIcsN/JYruOKzOOIgS/qDOMJtrQDZ9PwzqM0xqYLeUlQMW5jxro3T8wjKMPRw8rAvNkZxko29zhNeBJzgXh/+mYWKbYfwVPW4Sts2W9TYVbTchLQ5MO47vC5ICVpLPnULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088943; c=relaxed/simple;
	bh=y58A4R/lV+32ja/Aqt/oT42dGyKO0Q3lrcXoR2g/MdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txKwwh4E8lKmC32+DPmDhbnoQ/p8V8dm6rkZq3At9pdM1sArzYQXTCMI6805uSnwKfPHzOxVoWEZ4r31fu0/0Ug/6TVPt36/1XpNXwSDzSHad01uIrrMH9zLGGEIIYm09082z83v8xAsSAn5mKb9hL+71Zp4QNB4G8cLqXaYojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ivQut5dT; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ivQut5dT"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 435C914C2D6;
	Fri,  3 Jul 2026 16:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1783088940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YulAujzo35NDsDUK+zyEr88HJR/1QI1Hzab6PKjSfdo=;
	b=ivQut5dTNu94NAN4UEvRqsPhB25acGTxSaRvT8VMjITJHbfuC/ODQZ9WO+BjLftgN3wzBW
	M/qU+qsrYzUfOOFM8W95JiYk8MQJQ2V1P2S5h+Nd3he7GBj8O/2fG2x9o6R4f8UQ4rZ4EX
	AnFLqnRBhEsbn8uG+RrmFbhOU4/nlXqIZW2tK7SOmEzf3eNlW5FmGzh8N9k3F8Tl5Z5+Md
	FgqTHHsNHyVfSei8wtRmDhZRnWoEuD0UFyUshpL3N0KExjfdBXrG5/ir4Fwq5PIDtOEVX8
	Or5YySwagPLVQyp+suFZxVX4b/TU4K8Ux7XI+OmZOB96uy03/+SjKss2mHPSgg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4caf23c9;
	Fri, 3 Jul 2026 14:28:56 +0000 (UTC)
Date: Fri, 3 Jul 2026 23:28:41 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>, Barret Rhoden <brho@google.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: treat read return values of 0 as EOF
Message-ID: <akfHGcqke9qixd3Q@codewreck.org>
References: <20260702090941.1298188-1-brho@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702090941.1298188-1-brho@google.com>

Barret Rhoden wrote on Thu, Jul 02, 2026 at 09:09:32AM +0000:
> If your 9p server shares a synthetic file system such as sysfs, the file
> size from stat often disagrees with the actual file size.
> 
> Treat non-error reads of 0 as EOF, except in the case where the request
> was for 0 bytes.

> Tested:
> 	git@github.com:hugelgupf/p9.git, served "/" on 10.0.2.2
> 
> 	bash-5.3# mount -t 9p -o trans=tcp,port=12345,cache=none 10.0.2.2 /tmp/foo
> 	bash-5.3# cat /tmp/foo/sys/devices/system/cpu/online
> 	0-47

David,
that looks like something that should be handled in netfs - is it right
to do this on the 9p side?

I've just tried with qemu and with cache=none I get ENODATA, with
cache=loose I get the data followed by 4094 zeroes...

Interestingly there also are files with 0 size e.g.
/sys/devices/virtual/net/br0/brforward,
and for this one with cache=none I can read it fine, but with
cache=loose I get an empty file.


Barret,
thanks for the patch, please give us a bit of time to check; I'm
sometimes slow to reply (like for your sending the patch first without
the [PATCH] tag in subject) but I did see it, just hard to find time to
review...

Cheers,
-- 
Dominique
