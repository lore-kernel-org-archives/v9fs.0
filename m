Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640057465
	for <v9fs@lists.linux.dev>; Mon,  1 May 2023 19:44:06 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 07011C01F; Mon,  1 May 2023 21:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1682970239; bh=+DVIqAPcioRb471iCCPgn44QlLAG4x958YK8gLftMLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFRzJPKQZFKYuYKLKePBwZVaVN7oxXgdaRAhbgyW/bw128f+lpo5BoxIwVZCEGBam
	 p+LLX2wWBngxFNv8S+58hAZOTIX5gYGLSrOhvhynMulONnp+hlkZFdi1JSnkORMLUC
	 oh03ebJRekHwpH+luT/wy8L/QkXxT5n+N3NyXSSW8KZxh+i31b+oxd++Gl3IQeTt1Q
	 FLktKy3sx9tcWSJdgkH46m8ZGdDYG5dAsoOage60gig5HxJ7YogNSkMHsp9Urw2T3S
	 Pea0PENMuYcU/Kt/4OLKBJQ9NVRnkerK84KuAzgDggbjUAUMQuITyLTvSpuQBdYQnY
	 ElmOUsViUr14w==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id A6FA9C009;
	Mon,  1 May 2023 21:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1682970237; bh=+DVIqAPcioRb471iCCPgn44QlLAG4x958YK8gLftMLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWi+576CYSLSpjDg1y/njtImgDrwg1rsPVa5U0/vf3tIwSMzzXJeDGTJPEU4Mxt2X
	 BH0oksLtz3+Ld0wBCoPHm0Qn2QvGSMIgsAjqbuG+15Z9jjBKIVpEiJvM6V0FlgKM9H
	 GuI4MgBLigoTpTeA4p37tKt0DWNL+QO2arqBxTWWhWdIkm7qEy08QlQFrB9u75+OR+
	 yJhhkxMofUuWXCluAIqGoATJHV7smVouGepPkmGKOb7EJ95epvU0KwyM+sKygVSLjb
	 0tO/E1Aqm5IuQEFggsq3acJKLgbpSWP0Mnlfge5bJ91suLfzcp9OqIYucPF/q+9riU
	 xdZ8vKqtgKxww==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id bd218157;
	Mon, 1 May 2023 19:43:52 +0000 (UTC)
Date: Tue, 2 May 2023 04:43:37 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/9p: Remove INET dependency
Message-ID: <ZFAWaQbDR1_r5jf-@codewreck.org>
References: <20230501190602.86281-1-jandryuk@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230501190602.86281-1-jandryuk@gmail.com>

Jason Andryuk wrote on Mon, May 01, 2023 at 03:06:00PM -0400:
> 9pfs can run over assorted transports, so it doesn't have an INET
> dependency.  Drop it and remove the includes of linux/inet.h.
> 
> This allows configuring 9pfs over Xen with INET disabled.

Good catch.
Could you add depends on INET to NET_9P_FD in net/9p/Kconfig?

That aside looks good to me; we probably ought to cleanup the includes a
bit more aggressively...
-- 
Dominique
