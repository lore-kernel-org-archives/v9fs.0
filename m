Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253964;
	b=1qkRHkFlEV/oRPjDxv0yRRhxZJNN/m3t3CJ0feY5wZxv4W8yBR/5kcg5AiCptY0b1SO9
	 vH1CU47bVjafgniDnGRFaEUxKjhl2cN/77GCZGrHk3TLXGt88/cFxEYp82CYXYihUGPCG
	 16C9m1Srj7kvV0pm+G79q0lcHPVS1oG2+GTjWTL2wejvga9yYzJ9tjHupJeV+FSuQ5CTZ
	 vOGeSyg2H5Om6v5PNF5/WSlOHG5+ocoPVdsidajgZMPEfbrXGjrX4JI9hqP+c32/c6Uwr
	 wJFc2HFZOSLUWPqLUT99Kwr97GUMycfeIvGk55Df40wCXf7iJ/A+/DLzUWzyNMO2FyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253964;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TVw3BohKuLMa7W+lADfBwRsku9YoKiKZKOxm1/KhoH4=;
	b=P+impdhB0p0mOmPyoieCmhEjJOTdppczTkYq+pTkWdqERw3g14bKdk1bDoQW8Jo3+1Wg
	 yh/7PKLhLFlrdFzXwUZcgaz1hqVR1TPtpRh9lAd0J7QWud33HQdakGm6L3jiZ1mT0Yph+
	 FwPB7/FA22kgd07Mu+VEV5U4cWEmxu5kQMvW5o++rHGCu/Z+BCmT0tc3TQKbWQ4x7zNZp
	 KJtCwNnjSU+9xMcVXQQZYkDCT5IDEY+AFsgDnJwWML2UKW/BcBkw+29gO2hWJdByy68lT
	 m792K4wO1cHPi07ihOU8pE3a9Y1CripSfJKnkQVlUty2JOdTbrW64tgGAJ5CLnxQUTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=XfGeKiAJ;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B902606A31F
	for <v9fs@lists.linux.dev>; Thu, 29 Oct 2026 06:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B902606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=XfGeKiAJ
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id EA86914C2DE;
	Thu, 29 Oct 2026 07:05:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793253961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TVw3BohKuLMa7W+lADfBwRsku9YoKiKZKOxm1/KhoH4=;
	b=XfGeKiAJRMTyb5BFZKDXvcC78UdYBJc/q8U7/DUOnispkb58psA16jIRFs6n2uIci6Qj0d
	YZ5ylWY1SaXdZcfhQ4gcRF1nadR721uvmVL4ajmh3ofbB/jwgN4iPtJufy8cb7thjA1F0Y
	PHhp5bwM/CyTyJQPYzF+le9Xm/0qyyz19s0AicfCjw6u/I/sPHgwXS/4tXrf2XiHqjX8cW
	GJpxfweAQCuYwNyutbcpYaQFNEhQfWmqYICd0u+m7dPGfuUwz2R1mKX0GNQMHtRnKMTkJX
	5DqjIm3x61nDvZ4JN0sANM4PtTg9Mnbl9b42700IgW66OOvBrD641FsrLf+DCQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b67bafad;
	Thu, 29 Oct 2026 06:05:58 +0000 (UTC)
Date: Thu, 29 Oct 2026 15:05:43 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ankit Thakur <codeankit.thakur@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] 9p: fix header guard comment in acl.h
Message-ID: <auLiN_HvzFiEOUDh@codewreck.org>
References: <20261024092154.1844-1-codeankit.thakur@gmail.com>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261024092154.1844-1-codeankit.thakur@gmail.com>

Thanks, I've picked up the 4 patches

-- 
Dominique Martinet | Asmadeus
