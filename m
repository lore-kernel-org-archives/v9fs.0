Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F84407
	for <v9fs@lists.linux.dev>; Fri, 27 Oct 2023 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="vWOyKBsb";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="vWOyKBsb"
Received: by nautica.notk.org (Postfix, from userid 108)
	id F349CC022; Fri, 27 Oct 2023 05:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698378153; bh=y/stKboTHsqJvzjY1OwTwMJdw+f8rbvk9J6LcpLr6UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vWOyKBsbrYQrkIY/uefLXDTy9INAUqZ80ozwYs2+VHqm+z83mgSc1sUXTRElVGL+A
	 gxpPCD70lUe4oSl8OV/M9nl7N3QF5ZJ6PhKBv3t8h3Tx5ZmTNRmGtVhO+5NJtQXgQ4
	 0bKf4Rvh5f6MVkbtNK1lfJnu1CImdNnQyj7c18htDjUCCxbRD0JvgPouD+OgfJVeEo
	 wzkgyFz4LqqeMKRz9h2p4PgobvydqO7IsNeBX7K9PJEaa0jOIUeIOhQNQr/CH3u8TH
	 3IBinzTzzIUe1jr5Qva9YTtJGsHJqRW9CuIrVhVcju75474whsgzHl01zttE2Vgk8r
	 Yq5OVgKWErc8Q==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 0FF59C01C;
	Fri, 27 Oct 2023 05:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698378153; bh=y/stKboTHsqJvzjY1OwTwMJdw+f8rbvk9J6LcpLr6UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vWOyKBsbrYQrkIY/uefLXDTy9INAUqZ80ozwYs2+VHqm+z83mgSc1sUXTRElVGL+A
	 gxpPCD70lUe4oSl8OV/M9nl7N3QF5ZJ6PhKBv3t8h3Tx5ZmTNRmGtVhO+5NJtQXgQ4
	 0bKf4Rvh5f6MVkbtNK1lfJnu1CImdNnQyj7c18htDjUCCxbRD0JvgPouD+OgfJVeEo
	 wzkgyFz4LqqeMKRz9h2p4PgobvydqO7IsNeBX7K9PJEaa0jOIUeIOhQNQr/CH3u8TH
	 3IBinzTzzIUe1jr5Qva9YTtJGsHJqRW9CuIrVhVcju75474whsgzHl01zttE2Vgk8r
	 Yq5OVgKWErc8Q==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 5ab81bb3;
	Fri, 27 Oct 2023 03:42:26 +0000 (UTC)
Date: Fri, 27 Oct 2023 12:42:11 +0900
From: asmadeus@codewreck.org
To: Hangyu Hua <hbh25y@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: 9p: fix possible memory leak in p9_check_errors()
Message-ID: <ZTsxkzODZ9yve0XL@codewreck.org>
References: <20231027030302.11927-1-hbh25y@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027030302.11927-1-hbh25y@gmail.com>

Hangyu Hua wrote on Fri, Oct 27, 2023 at 11:03:02AM +0800:
> When p9pdu_readf() is called with "s?d" attribute, it allocates a pointer
> that will store a string. But when p9pdu_readf() fails while handling "d"
> then this pointer will not be freed in p9_check_errors().
> 
> Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support functions")
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Thanks, pushed for next
-- 
Dominique Martinet | Asmadeus
