Received: from c1521c0h.mwprem.net (c1521c0h.mwprem.net [122.17.135.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360A1AB500
	for <v9fs@lists.linux.dev>; Mon, 25 Nov 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=122.17.135.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563000; cv=pass; b=R9CtkwEUtd+BZqqDnZb/xqZ7zzGCBVOc83v5V2z07MnhTmuvWm18RhBu/gQPGf31P3vLmjRH0LQPaTQfVZPyzuDWcGa+RLKLqx7E6414z/fiGy21kaoDKGbbLzXxZvRw4VBgPMW51FsirwY2vu7r7rB07B5+VXaXDn8+cHS5LV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563000; c=relaxed/simple;
	bh=4NPDwwNBJrqobK34eXVgHRLUUUsimz0Cf3DgCzrS8OA=;
	h=Content-Type:MIME-Version:Subject:To:From:Date:Message-Id; b=n03/ZcYBZTRZQoYVM8+PXCZkW/eQgqzC5Iaa7kZUDD/nDVrIsjs+NoyY4ifsjZdAlKZere7O3N9dsBQ47llJGFcePW/Ejrf1FYCkmr0xj6sLkVq/6/wy2/Vyi5nwIJG7+8oIK3nsnwCwvwGD7/Z/D4nLWmYdQa8fKZijJ2gVwJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=robert-harewood.com; spf=fail smtp.mailfrom=robert-harewood.com; arc=pass smtp.client-ip=122.17.135.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=robert-harewood.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=robert-harewood.com
Received: from [192.168.0.149] (unknown [146.70.201.136])
	by c1521c0h.mwprem.net (Postfix) with ESMTPA id 85EDDC4AD077
	for <v9fs@lists.linux.dev>; Tue, 26 Nov 2024 04:23:32 +0900 (JST)
Authentication-Results: c1521c0h.mwprem.net; arc=none smtp.remote-ip=146.70.201.136
ARC-Seal: i=1; a=rsa-sha256; d=mwprem.net; s=default; t=1732562612; cv=none;
	b=PvUQ3eIcoj8jTGYmRCt2+PgwTT2L9upy/tbK8d8FwigVmHXru9pUYdQ+0WNHPTIuYpaeA87MKZ0uo3CUjHxOuXtgQqpVAE2ejYY/FahODvOTFjilHwOm3kXgaBoNEFV8l/rVFMYG+lEkawRTLU3xLzglfQuQDeGi2AcboqX1gzw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=mwprem.net; s=default;
	t=1732562612; c=relaxed/relaxed;
	bh=4NPDwwNBJrqobK34eXVgHRLUUUsimz0Cf3DgCzrS8OA=;
	h=MIME-Version:Subject:To:From:Date:Message-Id; b=ae5j/FgyLm0t8Tfo9naI0WMARJfoynEV3fhKqM2t4gvyff0s6TiUeq3RgJXeDGuVlM9gDSYRqwZ+BjrB4HJvfcDoeM+8B3nnBXhIdCndwVAYS2IeoCHOC2VEBq5FU8ixcZcUEJWo0VKi2bXBK7jTCdZrOFiNtX89B8sV4LdtnQk=
ARC-Authentication-Results: i=1; c1521c0h.mwprem.net
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re:
To: v9fs@lists.linux.dev
From: "Robert Harewood" <info@robert-harewood.com>
Date: Tue, 26 Nov 2024 03:23:32 +0800
Reply-To: "Robert Harewood" <rh@robert-harewood.com>
Message-Id: <20241125192332.85EDDC4AD077@c1521c0h.mwprem.net>

Dear CEO,

I hope this message finds you safe and well.

I have a team of investors who are interested in providing capital to your
business operations and projects without any upfront costs from you. I'd
love to have the chance to discuss the details with you further.

Please let me know if this is something that you would be interested in, and
we can schedule a call to further evaluate the details.

Thank you for your time and consideration.

Warm regards,

Robert Harewood,
Robert Harewood Advisory
The Broadgate Tower
20 Primrose St,
London, United Kingdom, EC2A 2EW.
