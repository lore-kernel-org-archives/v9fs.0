Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70338DD0;
	Mon, 11 Dec 2023 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZTaiK5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FF9C433C7;
	Mon, 11 Dec 2023 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302708;
	bh=nIyuqcp4+4582x1GA9+XcGxtdjfRCxJK9Ur7alA/OAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZTaiK5Hs1zkFuyL8Ccm4MUAI7dzy6fHvQtOQP5QeL4ZU8FE5u/fDIYOIYjBN3ksM
	 VXLRHOlJrkSfItbJ0VGSaF6IZWFQ6e5ZAuJI2A8y665EGsp2SZi4bXQQjn1AhPRjT0
	 YrIoaxY7qCKLgO3d8G70VDMWfyVfQHUe1WI9J1EndI/O/RKfyUNwgVdAvj+QGgfSY1
	 qCMyOvDEoKi/uulMaVKNU5cAG8rytCsqDdDjic5hU7bp75KYKVlPIuzQiBdK+A9YuP
	 Rhja9p0ckqfW5W70JKXViaS8WmchCK1QSc5pFkqul0qwZ+PFlE64nrz3SNx5l7Qsan
	 67WMgQtyjvfZw==
Date: Mon, 11 Dec 2023 13:51:42 +0000
From: Simon Horman <horms@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <20231211135142.GO5817@kernel.org>
References: <10981267.HhOBSzzNiN@silver>
 <20231206200913.16135-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206200913.16135-1-pchelkin@ispras.ru>

On Wed, Dec 06, 2023 at 11:09:13PM +0300, Fedor Pchelkin wrote:
> If some of p9pdu_readf() calls inside case 'T' in p9pdu_vreadf() fails,
> the error path is not handled properly. *wnames or members of *wnames
> array may be left uninitialized and invalidly freed.
> 
> Initialize *wnames to NULL in beginning of case 'T'. Initialize the first
> *wnames array element to NULL and nullify the failing *wnames element so
> that the error path freeing loop stops on the first NULL element and
> doesn't proceed further.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Simon Horman <horms@kernel.org>

