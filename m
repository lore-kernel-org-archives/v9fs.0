Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591418F66
	for <v9fs@lists.linux.dev>; Sat,  1 Apr 2023 21:00:19 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id C62A3C01E; Sat,  1 Apr 2023 23:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1680382810; bh=G3TpORB302rpUESWCTLWtrKhqiCxbte4Q9GPCCJyQmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7FV3gAb1lhSl8mMWywcM/YJFv8SOuVi0+j0pEAjU/kWNLZedAs1XCUYofiO2USDD
	 +R/HJFgJm5LpryuPPLINDB+67alzMHJfyGRLpdfqQsnx9bWlY/le8MoFwSHw5rq5MS
	 h6mfQYNK+9L65CfByZam6XAhES/tGTHzHy6F+Z9r4k3tTMrgSLVy/3tzld83bOD6K5
	 3OxhhsX5PGa4Kzx9BBC/usazT1aPWxGRbfSDo3FvSxrI6PB46H8ysKYdI+70VJ8HA7
	 52HgV8Sg2F9yCz7RLJa+5V84PeNXCSLs99HQbFFCWyRQwnmvXoVeZSPmUaEZEC130W
	 APzLr9jP73KrA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 16B3AC01A;
	Sat,  1 Apr 2023 23:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1680382809; bh=G3TpORB302rpUESWCTLWtrKhqiCxbte4Q9GPCCJyQmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0mHXB8DBExGVDIJexv4pQqAfbkHD5/a+0xb/MWDxBevhucVujPNXmhdhugY20RgJq
	 kfQiHjZmpwo0A5Cv5WwBDNi87m62rOz14INzO77005Lp+28CWvxG+qJr0lB4vUUgKO
	 7awyJDUMsbw3GMdod5sO/S6XtFNOcBALG90cGBW0V6MxvBBfvNt4ZH/GL7WLWt6/9Z
	 KXZ5R8veLoCE7eXyFSOjgyKDwm5QPlep0qymLEtSsOYdQPh6L6RIUbPEHtEiIzLegk
	 LoGip+LagTM/NO7zzalJ04lPUq8zPfQO2bgkSX5K2p0PcOzx0GKfUBMrX8hMQERmds
	 MdoYPQ1bX1bBQ==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id fc614c44;
	Sat, 1 Apr 2023 21:00:04 +0000 (UTC)
Date: Sun, 2 Apr 2023 05:59:49 +0900
From: asmadeus@codewreck.org
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs-developer@lists.sourceforge.net, v9fs@lists.linux.dev,
	ericvh@gmail.com, lucho@ionkov.net, linux_oss@crudebyte.com,
	rminnich@gmail.com
Subject: Re: [PATCH] Update email address and mailing list for v9fs
Message-ID: <ZCibRa/WlySRnSF4@codewreck.org>
References: <20230401-ericvh-fix-maintainers-v1-1-e3c535b2b5cf@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230401-ericvh-fix-maintainers-v1-1-e3c535b2b5cf@kernel.org>

Eric Van Hensbergen wrote on Sat, Apr 01, 2023 at 07:06:25PM +0000:
> We've recently moved the mailing list to lists.linux.dev to move away
> from the sourceforge infrastructure.  This also updates the website
> from the (no longer v9fs relevant?) swik.net address to the github
> group which contains pointers to test cases, the protocol, servers,
> etc.  This also changes my email from my gmail to my kernel.org
> address.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

Acked-by: Dominique Martinet <asmadeus@codewreck.org>

Just a nit below.
(BTW, I think we can de facto start using only the new list pretty
quickly, there's little reason to stay on the old one)

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

As far as as I can see there are no other list (or mail) that has the
same descripion as <mail> field; you can either drop the repeated
`<v9fs@lists.linux.dev>` entierly or we can give the list a name
like some (few) others do e.g. "9p filesystem developers <v9fs@...>"


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

Oh, I was wondering what added that, it looks like a b4 feature?
That's interesting, I didn't know b4 also had whistles for sending mails
as well. I like more infos in here, I'll have to give it a try...

-- 
Dominique
