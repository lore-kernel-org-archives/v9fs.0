Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67822CBD9
	for <v9fs@lists.linux.dev>; Sun, 15 Feb 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146804; cv=none; b=HdPDSIwrGapGod46UGncaMT4odf2bNdJHZ1/LMudG1FcZg12XyqWNM9gsmju69BlDbocVBJmk12EyUHQRZjDJLnI/w8wRpwdQOE1B4XcABcUnq9YpZ1dHawBizzT1l82LJyzFVRxnhwRvmmFyu92mJMUCxe1KWXR7R3DuIMlytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146804; c=relaxed/simple;
	bh=+GB7qHZaUX+EsxbFmVgSjrXD5tZfbgWbUE7dLpM1xdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeODKCysHzI+OmFSfyIigZpOzY2z/mbQgbzxpOfR19OFYp2iUaXXK5z2eXhBg2gXDW2sCzV5O0HyCNJu62h+LQx3z6tOQ17mmdk8Kfeaz/KHDMO9TZxL+vh22ghJpG3hTqxU9xcsBvKcNeIPO/OPT+Tf6ejWBvLxV84WrJL4GuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ohM1tTgf; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ohM1tTgf"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4AEBF14C2DE;
	Sun, 15 Feb 2026 10:13:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1771146799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X6PMMPGz+jLe5ualpnm5Aab0p5EjTgChnMRnoKKA/Fs=;
	b=ohM1tTgfFBEmPiR3IPGDXoOqOAcf/5fyLo5GMbtawe3lv4QXeHSR6Tfjg3CTsEKJa/0r1a
	ECI8dgKfua712El69ShX/WNWoB2KFNbkwlbSG627Xwz1xs43TzGJpLVdxDalz0jjV3cL7/
	cVBlZExsUsBaLyjBuBnjzWsFsV792UAtl5pYusQwv29XiJyxfB+chicskwqc1j+oR/cQDi
	/XM5hKkxeFBul4d8OX/BEite+SJTT4Vdwe0wYD4Bu5ahgPhkPi9iMS0rzVGa3NJimBYveZ
	ej9pC0glbNQ/PetAYqOaWK+pt1KaVQIq7WvLmpH4n95kLPt5Tr/MyHUKcm3bnw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id acf4b99f;
	Sun, 15 Feb 2026 09:13:15 +0000 (UTC)
Date: Sun, 15 Feb 2026 18:13:00 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Stefano Stabellini <stefano.stabellini@amd.com>
Cc: xen-devel@lists.xenproject.org, jgross@suse.com, v9fs@lists.linux.dev,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	sstabellini@kernel.org
Subject: Re: [PATCH v2] 9p/xen: protect xen_9pfs_front_free against
 concurrent calls
Message-ID: <aZGOHNhDe1PPJCRO@codewreck.org>
References: <20260129230348.2390470-1-stefano.stabellini@amd.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129230348.2390470-1-stefano.stabellini@amd.com>

Stefano Stabellini wrote on Thu, Jan 29, 2026 at 03:03:48PM -0800:
> Changes in v2:
> - move priv->rings check above the loop
> - replace list_del_init with list_del

It looks like I didn't reply a couple of weeks ago but I did
pick it up and just sent to Linus now.
Thanks!

-- 
Dominique Martinet | Asmadeus
