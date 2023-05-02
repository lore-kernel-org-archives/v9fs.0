Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515849479
	for <v9fs@lists.linux.dev>; Tue,  2 May 2023 23:33:13 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 7A45AC021; Wed,  3 May 2023 01:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1683070391; bh=DCCDMXns57nPsLdJGb9E6WpE+yDkCf8eWVUNtOrwEJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fElTX+cfICmZL/Fu+WBThks+fQBSCYqochAQKPK3NFK2PEcYAp64RlVcgHOswe7Ad
	 FeLCZ5ezU6FqXoBLBr37O5mnEhy3HJmFjIb/Hs2pXeopC1IgSxV5LFVRY57YXIhEFr
	 dOnUf8uF+V/OgDqIcQLPT7bfg4PbRSZUxIM/Hp4BczNij0VK28QB9Ry5t0XNGhENOT
	 nkspQCmnyMddo99E0cc5YEXQwndjTbsjoXA4G+lRE8kEowC4ENl3OGFdemaYBp47m4
	 0CGH73YIdSiDoOz7GYfDIl6DhfhQUhAdQBX4r1hqY8t610tHQHryBXBuO1noOl2nGX
	 /4kj1J4j5SX0w==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 5DACFC009;
	Wed,  3 May 2023 01:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1683070390; bh=DCCDMXns57nPsLdJGb9E6WpE+yDkCf8eWVUNtOrwEJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtQ3nlWPVXFopl3E1YZUCIWANx5teA4UF9pzxP7h1tdN/ZfjKGtb9QMHX1t2LtAfI
	 9OHKoimKjVXbx1cTMLcRLGhh9UY7Uk4f3RTt3/t1z+6PKH9l5R95zp6rVdeH66jilk
	 KQw1jrFOSj6TnYxiBqetin31Rlg+uA8VeG8e6jFFd3RMkZ11pU8cNAJ8+xT4lD3ewb
	 DcAOeYNdMdlqd3lnjo23oxG33adB0IETWclFyIr6ZRdE0qiom2KG4hMX5ARklmopHR
	 iu+T6SB1r0qoZF28eB2VaK9MmeZvyHwHZxDoTWSGtrYE8Mndre1XE/zQl4Y+ZM4Uz8
	 wuYfVtWC9TgKA==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id 08906240;
	Tue, 2 May 2023 23:33:04 +0000 (UTC)
Date: Wed, 3 May 2023 08:32:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Simon Horman <simon.horman@corigine.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/5] 9p: fix ignored return value in v9fs_dir_release
Message-ID: <ZFGdob9PRHSR-6ff@codewreck.org>
References: <20230427-scan-build-v1-0-efa05d65e2da@codewreck.org>
 <20230427-scan-build-v1-1-efa05d65e2da@codewreck.org>
 <ZFEiOdK0/UxKiPQQ@corigine.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFEiOdK0/UxKiPQQ@corigine.com>

Thanks for all the reviews!

Simon Horman wrote on Tue, May 02, 2023 at 04:46:17PM +0200:
> On Thu, Apr 27, 2023 at 08:23:34PM +0900, Dominique Martinet wrote:
> > retval from filemap_fdatawrite was immediately overwritten by the
> > following p9_fid_put: preserve any error in fdatawrite if there
> > was any first.
> > 
> > This fixes the following scan-build warning:
> > fs/9p/vfs_dir.c:220:4: warning: Value stored to 'retval' is never read [deadcode.DeadStores]
> >                         retval = filemap_fdatawrite(inode->i_mapping);
> >                         ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Perhaps:
> 
> Fixes: 89c58cb395ec ("fs/9p: fix error reporting in v9fs_dir_release")

Right, this one warrants a fix tag as it's the only real bug in this
series.
I'll add the Fixes and fix the typo in patch 5 and send a v2 later
today.

-- 
Dominique Martinet | Asmadeus
