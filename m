Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25A1BE6A
	for <v9fs@lists.linux.dev>; Thu, 20 Jul 2023 21:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6ADC433CB;
	Thu, 20 Jul 2023 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689888398;
	bh=kiS1mvvLqMomPKP3LvMcePZMepLiS1H+LHoNnXv7rRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BWH5dmlIZV0y3Lts8MXNeGamiGJr7RNyuJ1BsB1tPKBqW2o12DUltuxqtxbg8Ievh
	 umYVgcwv6SOR4W9wJqH4+5Kq5o/Y3sOYTDrO59HyDidykbS33JYMtgRelvj8kuQaRw
	 x7+NULw3gbSvpTUqzF6z7FV8CA69tXkcW2HAMRJm8NHMwXIMaLqfE8dGAo5Scmk67K
	 k1kN2mPXYI0efTLH/ANGuUjviKyf2ZDmWEuVK5EUW/wmWbLWiHWHxdXc3qoFWzJp3Z
	 O9UDF3MXmBPc7/NLAoaWTiMX8nEEayGZik3aOjPS+2JIBybi1CdLj4psYHIqEJ5bib
	 jW0q1ebemGvXA==
From: Eric Van Hensbergen <ericvh@kernel.org>
To: lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com, 
 YueHaibing <yuehaibing@huawei.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20230720143506.33860-1-yuehaibing@huawei.com>
References: <20230720143506.33860-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] fs/9p: Remove unused extern declaration
Message-Id: <168988839781.88307.6903188486537085585.b4-ty@kernel.org>
Date: Thu, 20 Jul 2023 21:26:37 +0000
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 20 Jul 2023 22:35:06 +0800, YueHaibing wrote:
> commit bd238fb431f3 ("9p: Reorganization of 9p file system code")
> left behind this.
> 
> 

Applied, thanks!

[1/1] fs/9p: Remove unused extern declaration
      commit: e6ab0b914c12acefbb0880dded48cb930ccab5cf

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

