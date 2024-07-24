Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD51CD1B;
	Wed, 24 Jul 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843156; cv=none; b=M6wq4m4rWCRKjAINwtAoFCGLqtQyZ3pn/Z7SJ0tEO1yHLbFk5K619f0gvx+S1a4kekKjel8Ap7jaomYap5abOIMfnlmdfPBPGVEj7lxiswkA6AvW60gD4Rr8OXCb37nhD67XztfOJY6n/M4xXiuHfSXa1WlXe5dkWOXJwf5CTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843156; c=relaxed/simple;
	bh=cAhXkiyor6s16nnGBLDyjymMroOdUo09u+giTo+wxxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vE0uFKjtRmd/n3ijWKRzawdVlQZsiyeJbHUHkBGIIEFXtuSp+mj2KEF/WrUuQqlyUWn7s+AwzIu58iRUqSDB52lW8rJ7jv1l+xDm3pH3PG+NWYWquHAZX9Y/u6tUdfi9Txk6x1CDna5xtkRLK1MY/4bSE/4/LlffoD5vK2m+enM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Ef6dNUHi; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Ef6dNUHi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=OgzOE3prpiOu4gb4IlTfQnO4lPJmO3BSVmEBt4F2lXc=; b=Ef6dNUHiZ/d2j6R1
	T4AZl45qJhJQw27Gv0OzZiuKesBx1vSFyDS1MOl6WTu23HXN6A1mn4YAZA5+EqtYQFtgLJLnoAy0a
	hJTX7RRPwKMU7SioAKPmHdKNID+3vfBzrhYKAc5dck1WLF9qyaSAGH21FgdS/1EHwtr+4UzN0a78C
	qbERcwwzguOhEQiB0oJK4dzdIogCaj4P3gDRArw+5ivqiBbO3VD6u+3JnyVfAw8ja1nujgeSbWwgs
	bVeHe+rutVI152epL+AaAJLabbcIudE1S1iWOSNL9UQ2aMyQBHsrOhvEIFlxlOzqy1DbMpuPrYWhA
	67QRzrHNfSw398U6Hw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sWg3i-00D4Bt-09;
	Wed, 24 Jul 2024 17:45:50 +0000
Date: Wed, 24 Jul 2024 17:45:49 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: ericvh@kernel.org, lucho@ionkov.net
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: 9p goo.gl link
Message-ID: <ZqE9zUXO3agBjno7@gallifrey>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:43:25 up 77 days,  4:57,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,
  I noticed there was a goo.gl link in Documentation/filesystems/9p.rst

    * VirtFS: A Virtualization Aware File System pass-through
      http://goo.gl/3WPDg

Given goo.gl is going away, I was going to expand the link, but
the link looks fairly ill; it goes to a sciweavers.org site
that has an abstract, but it doesn't seem to download the full document.

I can see links to the document around, but I'm not sure if there's
a 'right' address.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
