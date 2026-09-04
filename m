Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB744999F;
	Fri,  4 Sep 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529065; cv=none; b=WcPeoc6/mvCfOImvPcoW2aR5bsCL99u9Z/CjgZ5PjvyuEmG4iPVb8ub3Zhb8P6h3y+Nurn5imIAaYVEnCThowwS4NbVTYls2l8QjbkzYYPXLFrFbWsh/kjaoPLcYs4269S571rGphI6Vj/my6oq7ObAwlN5HFrqWiDAHGGU8lzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529065; c=relaxed/simple;
	bh=Njjasc3IX0xlY9+6WXjjzKL0xM4yf+35381p8OsefCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oi6F/yNJIFf0HKSa1J1m156maDT3HDyU6X8am4JKw5CKuHJeUrXV43Dw16SwQiHUX8pediq+ioTd7dXwCiNPmfCIz0u6eXi5C5en/DYShjL/zT7QvQ3dBt+We8H4WB/bps1u+Vu14bQJ5HfyCp9++FvPMRbfwbYe9p01B79olPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=XHknQjvt; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="XHknQjvt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=oSirYoF2RY8du2LiY0yBrNRVUm+QqIhfZ6Fhn2chzu8=; b=XHknQjvt0NgxRsBupg7P2PhkNT
	D+1Ta/5ErjnUtCVk4uZKvSILseCTv9YqGiog8X/com2Sf5bCdgFMPj7tlZEAFwE8eMkajTZ6FLYtS
	fn4E36B6a4C7qSifjje8LcAbZ2EtzfhW3s4ipyrO25meFYlu74ZIdzNvbUKO3czv/YCBWn9Q17AuC
	VmZn2eTDDGEPuG5t+/wl1uOmQnuSw0MCnjrIqx5gQM71qkmY1tnI4oZtKUCc6XRp8WklST0QfaAE3
	7TTzzbBV6tqQK8gn8g2GPTNXzSNeJhuRYHcm1k6vQJTDoWEt14Zlgjo1JY7JvSMje+CJH2S/82BcI
	XC/XafggGOz8rQGGivKdDZLdezOa/zocJx3ZH9QzQyPMskYhBHAUorVTezU5gzSC1F/4fcNE3uZAI
	CPjNa/6hPOehcMKztjodixp142mgKal9Rt+rZN/MzOYKYC006c+1aEeALKEVr2Aoee1ifNu63gBlx
	fw8JdE3giIyDE+VPv5yc8YJJmHdfmKsGdBmn3ko9HLM6GZ6ygi4YkHL2dOH9ESgBHNayeLIMmuHYD
	BOSBwryYimjxUeGvmZmk+zlize6xNWGXJXEm3SKwpk72HOClCsybA+46jlMbqlj8PRMhGwBTjbchY
	Xej7eMLBAZpw7kSESRXL71JYm2C0jICTxiPiHgnio=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Hemanth Selam <hemanth.selam@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] net: fix typos in comments
Date: Fri, 04 Sep 2026 15:10:18 +0200
Message-ID: <12963525.O9o76ZdvQC@weasel>
In-Reply-To: <20260904112100.34541-1-hemanth.selam@gmail.com>
References: <20260904112100.34541-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 4 September 2026 13:20:59 CEST Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

But didn't catch the double spaces in the commit log. ;-)

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  include/net/9p/9p.h     | 2 +-
>  include/net/9p/client.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
> index fd7a034b8278..22ab7486795d 100644
> --- a/include/net/9p/9p.h
> +++ b/include/net/9p/9p.h
> @@ -120,7 +120,7 @@ void _p9_debug(enum p9_debug_flags level, const char
> *func, * @P9_RCREATE: response with file access information
>   * @P9_TREAD: request to transfer data from a file or directory
>   * @P9_RREAD: response with data requested
> - * @P9_TWRITE: reuqest to transfer data to a file
> + * @P9_TWRITE: request to transfer data to a file
>   * @P9_RWRITE: response with out much data was transferred to file
>   * @P9_TCLUNK: forget about a handle to an entity within the file system
>   * @P9_RCLUNK: response when server has forgotten about the handle
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 55c6cb54bd25..f3aead8939ef 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -97,7 +97,7 @@ struct p9_req_t {
>   * @proto_version: 9P protocol version to use
>   * @trans_mod: module API instantiated with this client
>   * @status: connection state
> - * @trans: tranport instance state and API
> + * @trans: transport instance state and API
>   * @fids: All active FID handles
>   * @reqs: All active requests.
>   * @name: node name used as client id




