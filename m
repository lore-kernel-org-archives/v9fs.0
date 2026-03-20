Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5E3C8707;
	Fri, 20 Mar 2026 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017960; cv=none; b=qa3yl7pC4Oz135DPUMQo+OQTz5vMRqecUSMyA34BUYt+IClBgESZNaX9olwSHt54PGnKoatyQ+zhHxYuz7LxDfssHKgr9mfDnChadNP7GLlT0n3EFdtJKUYSHKAYAIYFcYJalBq5UxesiZTJgWQZAAcoCD5tjCo+KI3gRTmg5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017960; c=relaxed/simple;
	bh=4iiQc6D5pVCaJSRR5ZQK4imq4nBJK/eLpq14osdIgJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ajc1gRNeABpTEfG0DtkeuY8uKFbXAUUdvNUKR314Zp32mYeq09x7QvA1ztz/GcLZQMthDPHTgp9K5VqdN4JjrVq7wSqfCQGHPpM8vjAs2svoOQMVWwLDRuS2zq/dslCj2X2lVDb+3v53Gvl1L1pGPCd6HwRQ4O7af9l7EP0rc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=fXtRRtpJ; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="fXtRRtpJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=mBvql6GpQc7ec6387oO420FA/OXu2ops1c5AxcrruVY=; b=fXtRRtpJ2A8b2iS3SqscrbVmCM
	e3w8QnaV49avP6P/NPM1Ix18VQ0GrPuT027g1J8KYBFL48SHqXi/9xQ4dpZUsS588SAr5caa4LsV9
	f+3xohp9aZO6wmegqs24hoO6+bzbixv9E7B8zrJdjOIzTmcY4moMrLp+ehaK+7leNnrTDwX/Mupje
	0JRUy6MMfqQwbYPx14y1j7uZeQURKp0mcO2RJ7ehJMpSh/qRI7zcf2TR3EtpWYVrcdJlmFJ8xHEOz
	4/OlEDvPvlv6q0BHi4DZ5SZcP7nHE4HbTcFXpqgHL0QCULEUajLWJMZHsXV70hDmDwMR0s/7X1+kp
	JL7rbZV7+CklNA+vWMBEkLy1MA/q6gddt9CWf/X/UrMK6PfGPhEKHh59ljHnzzo0zHKpYYW+yql7g
	s4R2tivvzVTNhr5POg1YiD72Ndva2Z/lv911ra0ilJ8r1bhnX0A30F8/zDSmhV8nTleduI2vpLoaw
	BZGex2hCLBaJG/DcMX6Ay7Mj0gP8YnHNNAH+7PAjmY0e+dUBWaTh5aokaQxCq/NgUxwP5TwiFl/rZ
	QRB08pRa80QUDcimNIPAYLbmRtjREnFmP68Oz6D/wiDhzWY7L1gl4Zph9W+cWyEculI/RXdCeqzdk
	zzHCXou7RTaTg4nsVXlph8VmeppwJGyzKm0UHgw0w=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 Kit Dallege <xaum.io@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Kit Dallege <xaum.io@gmail.com>
Subject:
 Re: [PATCH v3] 9p: document missing enum values in kernel-doc comments
Date: Fri, 20 Mar 2026 15:45:47 +0100
Message-ID: <7922954.EvYhyI6sBW@weasel>
In-Reply-To: <20260315190633.73536-1-xaum.io@gmail.com>
References:
 <20260315170702.65160-1-xaum.io@gmail.com>
 <20260315190633.73536-1-xaum.io@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 15 March 2026 20:06:33 CET Kit Dallege wrote:
> Add kernel-doc entries for all undocumented enum values:
> - p9_debug_flags: P9_DEBUG_CACHE, P9_DEBUG_MMAP
> - p9_msg_t: all 9P2000.L message types (TLOPEN/RLOPEN through
>   TUNLINKAT/RUNLINKAT)
> - p9_open_mode_t: P9L_MODE_MASK, P9L_DIRECT, P9L_NOWRITECACHE,
>   P9L_LOOSE
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Kit Dallege <xaum.io@gmail.com>
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>



