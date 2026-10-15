Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E14CA779
	for <v9fs@lists.linux.dev>; Thu, 15 Oct 2026 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792106934; cv=none; b=R/pK1vARk6yTgQC2v9Q9owzMy5h5A5pSV9RJ+aEsiK06Vyt7QpJ8SgpfYwhuEYAnIgn+QG/3vEO1/1voAHDhW2YJyDz5lkBC3rgXhZVkNCKdTU9cQfNWFsWPL0ax7img8CxPFyg5StaQ6GFxfUgc+DZs3PCmpTV1MJPqO4LmGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792106934; c=relaxed/simple;
	bh=JneeYzqCv/oOdNYpw16kvgOfgfvyeDhWV4Vz4P7+2uY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FjvVIK+4HIpudUOPyDPEUXQNGFIR0+DTFoe6EEMdIapfjUCtjmsfCNGSeUGXxn432BkAkrxtya9BeslyGUOcsPPYSPYFr1Eu6oxch6z7dMiF8QPhqI52mzPRhid3MhhGCHCDSJ0tKDWwZQwffmME43gdSgsWkYFrsj+MGdzJ1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=z9fUovrW; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="z9fUovrW"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3A3E114C2D6
	for <v9fs@lists.linux.dev>; Fri, 16 Oct 2026 01:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1792106923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=+TG9gu9SAHK5L/6RpTa8jNPOkl8EWOtowAQHM2GTErc=;
	b=z9fUovrWj7lkFI8rdWNMKm0r9Ah7t5cVVJeiCxCDIy6ViNlWn59Waem/fO3aPWx1i43vbN
	9OIMk+Llna276haAC74v3iRdFpg2zCa6caYij6b84yf9Gz5CBoAgN8Jg5nnAaH2qivvMXa
	h4s/fh9JHDRg/oL6IX2uTR1AIERfADFgqBXoUuOdebOmFodOuJPzKTrL5LXAxLssagBdtS
	yOqNbLyRRuawwLaxOBCY3+oPomq1yQWALkGilWcZ9soxXhEMCAOKoGMEuzVQLHjFpRTO+d
	1lzqowVljVWspE6sFw1Pf7XgZ4gnam7ER3bb5QfB5CuZuekbzvDOuZy1tLLtjA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7693f032
	for <v9fs@lists.linux.dev>;
	Thu, 15 Oct 2026 23:28:41 +0000 (UTC)
Date: Fri, 16 Oct 2026 08:28:26 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: v9fs@lists.linux.dev
Subject: 9p sashiko reviews
Message-ID: <atFhmm3tPZJsWEw4@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi all,

just a head's up I've asked Sashiko to send mails to the list going forward:
https://github.com/sashiko-dev/sashiko/pull/690/changes

Let's see how that turns out, if someone has an opinion/wants a change
feel free to ask

-- 
Dominique
