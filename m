Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADFA8635D
	for <v9fs@lists.linux.dev>; Sun, 16 Mar 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161119; cv=none; b=GkVw66aPXOHmoVvlo0/WtA1L/pkiI2ua/V+XDn8+uR3Vw52KIoSEF3U3ToODLZZlANAakcXBc3Mvs5ylJtoSryLYiiIdRrWuEr4872gOEgwTHZXYFGo6FCXWitB/OTSw+BLUjiAm0XT2R7oAjCq+8GHG9nCPKDFsL0dlnJbx0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161119; c=relaxed/simple;
	bh=0QXGS5iVuXHcAvS/0hqCndkzSq1YfD6XQh7mcbPBOf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC6vI3FYBZ8PQTWfGGfXZ7tUrWOBeRW34db6+r/sciUUMGeqSOr7yMbB0EgNrvrXtztRDb+f4DoBsfICMcqNV5hCThuiVZkUM+g7idMrfw/v4qaCEQ+HKaFZmwPMJPRUB/wjCSMaBYH55UGwqPOgi6qzTsXZIPB6hOSkc0Hy88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=e8MXZGcy; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="e8MXZGcy"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AB6CD14C2D3;
	Sun, 16 Mar 2025 22:38:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742161117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RlB1QbSiOnZaKekMAr/vgezkQBYKoxSdFXFD/Ejndw=;
	b=e8MXZGcyuVrogffYOHRxtKt0mvz9ZgwRa85JJ6G3lsRCcbMwiUD+v5Dps63qnKwNK2zUEv
	PfLqs8z4brtNSEQ1jXIp3cyKoDzkibzv9O6PL1mbfjIU0xPB9Jv7ggRHvbwF9W3+9MG0fS
	YfO3dC2V/ojRtPu/itaXWPosmg+h+CAPWJhrpojh2xV0sjBt6VPNqzex5IFbVPXx/vEzvq
	iNZmwRq4OAFkKJ52UsEmjT2SVz/9pHgwwTMQ6L20PrO90BoNqE6UnxJtwz4DI9eUx2BAsa
	K3cFbOjZRjc10FHGyNLD/AS/iYhA3OZVzUJRZuuSrflXxnkY8u/F23Z87rbaUw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 092278d2;
	Sun, 16 Mar 2025 21:38:33 +0000 (UTC)
Date: Mon, 17 Mar 2025 06:38:18 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robert Morris <rtm@mit.edu>
Subject: Re: [PATCH v2] 9p/net: fix improper handling of bogus negative
 read/write replies
Message-ID: <Z9dEytS7GXL87OVP@codewreck.org>
References: <20250317-9p_unsigned_rw-v2-1-9d7a94a916ae@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317-9p_unsigned_rw-v2-1-9d7a94a916ae@codewreck.org>

Dominique Martinet wrote on Mon, Mar 17, 2025 at 06:32:56AM +0900:
> @@ -1633,7 +1634,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  		if (count < rsize)
>  			rsize = count;
>  
> -		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
> +		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zu (/%zu)\n",
>  			 fid->fid, offset, rsize, count);

I obviously ran make W=1 after sending this and noticed I forgot to
update the format fields, let's pretend this was %u for rsize (same
below)
-- 
Dominique
