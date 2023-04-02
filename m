Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB782F2D
	for <v9fs@lists.linux.dev>; Sun,  2 Apr 2023 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=9zUEbiCR+KSKiHO2ssoVmAlcES3Ydor7Zr4UwI7Brus=; b=oQ+4P35WfrG7M/ZawBx9CKeB4V
	GmxxFa2oQC5pgCPBWgxzv11FAYneTHJRLng+EzoMciTy2z6wi/zJ0Oxh3Xwc7jBhO1+pQNvlu5oA8
	aQLaVrFe7M4phOG+U9nYcV6AmzfUijTw5TBtSBfWPKWB2yBbI4DcpNU8vACeb2x7KyKK1VSQzzi7W
	mgejIyb+W01Td/Ux/RRXtVneve0Dx/r4TmCziyq+xlex4c0is2n8jYY2rf7RoANT6z018LDGmCvOF
	1HNyYlYQavPJDXKy1TZenhdILCFKRNsyldHIUmfr4AA4ZSojkuMMZznATa+1eWm8C24DDP2BygbZ/
	iu90/+Jf09OPFKSDqCj+FOkZNunvTVONAIR/xpKAHReRmphJXddT35h2ftAyHeqOu5fXrrP/clntB
	cymGljOCg+O+Uc2Df4aSjwDcQqX3Gnrj8tZ1hZQsyrPd0McS9igwxQ5XyEdQMiz6FxxQYOPqK5VF1
	vkKYdaKH2Rzj1bylmtQ7/U/w5HrI+M7iIUZoeYEfvL1ImxU34qypyX/bjICvgmioslPZVt6KAGBU+
	L6iiFlKWHDpuN9TaU4jeldfPJR+zfVx5Pe3wZmwMb+qZHgQN7dRLXFKY+K3bDMgooWZfyQNdnJCSh
	AhdDtH+qrppx0/N8h2EIcwCTooPDVPCeMMdsJ7pIw=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs-developer@lists.sourceforge.net,
 Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, ericvh@gmail.com, lucho@ionkov.net,
 asmadeus@codewreck.org, rminnich@gmail.com,
 Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH] Update email address and mailing list for v9fs
Date: Sun, 02 Apr 2023 15:48:19 +0200
Message-ID: <4901173.k3S2UP3QcN@silver>
In-Reply-To: <20230401-ericvh-fix-maintainers-v1-1-e3c535b2b5cf@kernel.org>
References: <20230401-ericvh-fix-maintainers-v1-1-e3c535b2b5cf@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, April 1, 2023 9:06:25 PM CEST Eric Van Hensbergen wrote:
> We've recently moved the mailing list to lists.linux.dev to move away
> from the sourceforge infrastructure.  This also updates the website
> from the (no longer v9fs relevant?) swik.net address to the github
> group which contains pointers to test cases, the protocol, servers,
> etc.  This also changes my email from my gmail to my kernel.org
> address.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bc223f305..6567bae7137b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -224,13 +224,13 @@ S:	Orphan / Obsolete
>  F:	drivers/net/ethernet/8390/
>  
>  9P FILE SYSTEM
> -M:	Eric Van Hensbergen <ericvh@gmail.com>
> +M:	Eric Van Hensbergen <ericvh@kernel.org>
>  M:	Latchesar Ionkov <lucho@ionkov.net>
>  M:	Dominique Martinet <asmadeus@codewreck.org>
>  R:	Christian Schoenebeck <linux_oss@crudebyte.com>
> -L:	v9fs-developer@lists.sourceforge.net
> +L:	v9fs@lists.linux.dev <v9fs@lists.linux.dev>

So the old list is officially dead? Migrated?

>  S:	Maintained
> -W:	http://swik.net/v9fs
> +W:	http://github.com/v9fs
>  Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
>  T:	git git://github.com/martinetd/linux.git
> 
> ---
> base-commit: 707823e7f22f3864ddc7d85e8e9b614afe4f1b16
> change-id: 20230401-ericvh-fix-maintainers-865452e6c43a
> 
> Best regards,
> 




