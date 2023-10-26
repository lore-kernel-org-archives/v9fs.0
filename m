Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71EE2DF72
	for <v9fs@lists.linux.dev>; Thu, 26 Oct 2023 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="UJ8adKPL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=r2dz3acTOn5lRwuIUAODszuiv28kHPULtXvdoKcdzhM=; b=UJ8adKPLz6HgOt1eyoE2Yxb4rl
	sbIkrJfDqY6lYjk1o6QzyI1j0A8iwcAUQHfb3e4ZrHbIF2kuLXXr9o/Q3uP3f5mKicqU/bkGHGRIs
	3mvz2p+G0uPR5lsB+b2HX1CSL5fc/irlyOtf5kontKRZUu+RE6jmSH35VP64g+YgSsVQDCEz7gR8V
	wEdyCUjO4r9SDEDiaaCBB7mIzlXMMdRm6wP67qypTkx6Ui/LmH1t+jPrYtj/Pxtk3NUEk4rQJ+KRf
	t6P/o6I2QaKvmFLwAVvCzi5CjY0V95+Tbd4h4B+Qs5OlptGAOJQKqe9YMQfbdE9KYo0rYwRC2HxW2
	WEdAiDyKiIefb5ulvu1yzeNqT7+SuFTnFYd2kDUgF5i4q0I74vwoQYndvzakSWO5X+kqTXuG0FJT1
	tMuccsohlEW2IG8XJyMhTFI4Bv1umvGyyqzAJbKOQZn+/fzFRo4LDivjMIxzvDUhEeNk5wnz/BB/K
	ANQSxoxLepGy2dfOBqiVZB2NCpXjzBViwbKCia4jWtMLYcEvZeDwbnh/1kSCgLTtELou3yiOikK/K
	2wcznNnHEkCaYXolMoIQ/bt3Mch+2RqyZDQZB1vIa4rKwmBf8cG5PswMD5eHRVDmx/s+Mn+q45i8/
	Q8S1v1RqDNsPCoXnBOaoS9bPM0s6QAuLcETr0i/sA=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Dominique Martinet <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org,
 Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH] 9p/fs: add MODULE_DESCIPTION
Date: Thu, 26 Oct 2023 14:47:33 +0200
Message-ID: <2207070.NGFuZe4fYI@silver>
In-Reply-To: <20231025223107.1274963-1-asmadeus@codewreck.org>
References: <20231025223107.1274963-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, October 26, 2023 12:31:07 AM CEST Dominique Martinet wrote:
> Fix modpost warning that MODULE_DESCRIPTION is missing in fs/9p/9p.o
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> Probably doesn't really matter after all this time, but noticed this
> when double-checking there weren't any warnings left in W=1... Might as
> well get rid of this:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/9p/9p.o
> 
>  fs/9p/v9fs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index d525957594b6..61dbe52bb3a3 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -732,4 +732,5 @@ module_exit(exit_v9fs)
>  MODULE_AUTHOR("Latchesar Ionkov <lucho@ionkov.net>");
>  MODULE_AUTHOR("Eric Van Hensbergen <ericvh@gmail.com>");
>  MODULE_AUTHOR("Ron Minnich <rminnich@lanl.gov>");
> +MODULE_DESCRIPTION("9P Client File System");
>  MODULE_LICENSE("GPL");
> 


