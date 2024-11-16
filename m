Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F6190685
	for <v9fs@lists.linux.dev>; Sat, 16 Nov 2024 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745567; cv=none; b=Sf4B7XZW+FmkaeglPVLvPf+sZlbBaLSLd9FsSZX3Ay+vvg5caQZZxTAJXTZ7FosZzaLSDVtIeH9AqSR0KaFHDqzBrKhLDTN8+1jlB2HLtG4IkvKqMrAIP6zaa2IetyfODZa+vO+NncWqXy9V1H0k+TL3Lto67BYfhKfJNkvqZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745567; c=relaxed/simple;
	bh=5p/GsZ3KdSwZ4T53Ya/h/UBOD0APZ0Q5ZWllav3BenQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhOLA4Se3AQktiXumJX4jZFJlkKXd/rNl5JuYd/85YaIpgFY7JHrstfJqkWaHlhqokTKWfQr9wpFUYNN/LGv6ipN+FQFWnv4kTrsdGKP/dQsvA5VUxm60h+vcxnBvTSI10HqD3el8nU6uAEyGH7MyvhNVR5vqLQVrRJBAhy0BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=fUXGN8qo; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="fUXGN8qo"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8676314C1E1;
	Sat, 16 Nov 2024 09:26:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1731745565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7nbY+v8nPJu4QhtFphfnna/kbiMcsSCKLRHDLEHV40=;
	b=fUXGN8qoHnOGZNN8Td6rwdsXlRv/1j/IskjkGE2Qwl9W5wc8Ev+A2KmauuR5Bw9W7ROZQw
	NUcR7AmJJyfXgl2d3VkK3j1Ut8sWYiW0hlOfGyR1HieiD3vxDRDNauu3qk3AMdlUO42ABs
	c7cs7aRGvB7VKhq0XrzxNFIZKOWR+6cmdOi4YQKPrr1AFPd9/8U7Up525NgmUbXtMOID5H
	ZkRUISeNpM2mZuuv9KdhVTVqBlOUnH0atj0dEMHeqDZvIwI2+Ar/8Wdmnkte5cLi+JEY7y
	XZL2FhAisZJkUUvHgsbFhmLK7g83gCm5q2E8wuzSDKzQER8n2a2lP0FjiJOxkQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 53609ca6;
	Sat, 16 Nov 2024 08:26:01 +0000 (UTC)
Date: Sat, 16 Nov 2024 17:25:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v1 1/1] net/9p/usbg: fix handling of the failed kzalloc()
 memory allocation
Message-ID: <ZzhXCi_0m3X2AHpJ@codewreck.org>
References: <20241109211840.721226-2-mtodorovac69@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241109211840.721226-2-mtodorovac69@gmail.com>

Mirsad Todorovac wrote on Sat, Nov 09, 2024 at 10:18:41PM +0100:
> On the linux-next, next-20241108 vanilla kernel, the coccinelle tool gave the
> following error report:
> 
> ./net/9p/trans_usbg.c:912:5-11: ERROR: allocation function on line 911 returns
> NULL not ERR_PTR on failure
> 
> kzalloc() failure is fixed to handle the NULL return case on the memory exhaustion.

Thank you, I've taken this in 9p-next and will submit it to Linus next
cycle

-- 
Dominique
