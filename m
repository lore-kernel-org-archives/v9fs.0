Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89289136F
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3gUInsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16DAC433C8;
	Sat,  6 Jan 2024 01:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704505962;
	bh=GO+vqt0H/Ed3c8HPDsPoubHRQ9HKipTxjY7jGMh25C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3gUInsbgVeleU0UwfE/ySP3enVVJ+uwBo+1iqUJO3HsszHqmSUwxaHWDnTiG/kfI
	 LmdjpQQ8Zo934w2Ipftl8wxae6r6Yq2kgWlZzSz6V8Ey/lLMWJUTk8eHnm4Pqy8t5y
	 m8f7vyPQQcvPkN3Xk5QRvpBYDa9Zkg1o7zJPtjGqnS/ie9mv7SSXp9dZa2B6rrozDz
	 W1UMq87fgbD/Nv7f0GoQ/zmlY9K6jslzCN19GNHv7L5QlRzgDjTxCpQDvLRE1W26PD
	 exzHHa1PPnDF9LM5TZcUhue+fiBlt3uDL9jTLG3misq4nS+cY3aCU9S8WUV5l+0YH1
	 T02tYCFG7ks6g==
Date: Sat, 6 Jan 2024 01:52:39 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: v9fs@lists.linux.dev
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, asmadeus@codewreck.org
Subject: Re: inodes in dirread
Message-ID: <ZZiyZxQ2cykCIgmj@1149290c588b>
References: <ZZhPkZFWUyBXRcdo@FV7GG9FTHL>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZhPkZFWUyBXRcdo@FV7GG9FTHL>

On Fri, Jan 05, 2024 at 12:50:57PM -0600, Eric Van Hensbergen wrote:
> Anyone know what the inode in dirent is actually used for during a 
> dirread?  Right now we are hashing the qid to an inode number, but
> I was planning on re-writing this so we can let the client allocate
> inode numbers for itself to guarentee uniqueness.  However, that
> would mean I'd have to allocate inode numbers is dirread (if we aren't
> using the cache) and then immediately discarding them which seems
> wasteful.  Puting qid.path there "works" but I'm not sure what assumptions
> I'm breaking.
>

Disregard, I ended up backing out that particular line of inquiry
and just sticking with the modified qid.paths in the i_ino for now.

   -eric
