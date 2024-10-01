Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3419B3C0
	for <v9fs@lists.linux.dev>; Tue,  1 Oct 2024 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776084; cv=none; b=no69jKXNcntr+YiOGltNs364E7vb2yqSnL4oaKskAalzw6OFnVtG6gj13ioij4l22peKK7ULuyvidJYgClqdQ5FmoaK/YxXtIIpgMzlTq7Ec9oGfjVw7jUkTXx4FdHCVg70ezoFLLegvwFDinRfN65XkQOquzTTJ4lnpMBniSBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776084; c=relaxed/simple;
	bh=JstjSzRX98qxQWqnfLsMllsEDmjl14O7nvcM2y5DxRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyV+OtvKniOUiapmvYhHTlZNEE+hk8pm41sVfbxQNo4sCuuDaAPO0ZvfuAyd5gi04jC1RrZ0tWqthkEJjp9xlegxYpMELp6odHi+MBG+n60zwscLG70+jRTlZxLlrmTbPUCt6Hu0wFyYpf92FY7dF1X65FgyHNp0uDW/636JWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908AE339;
	Tue,  1 Oct 2024 02:48:25 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E9733F587;
	Tue,  1 Oct 2024 02:47:54 -0700 (PDT)
Date: Tue, 1 Oct 2024 10:47:47 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, kernel-team@fb.com,
	v9fs@lists.linux.dev, David Howells <dhowells@redhat.com>,
	Manu Bretelle <chantr4@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] iov_iter: fix advancing slot in iter_folioq_get_pages()
Message-ID: <20241001094747.GA1483717@e124191.cambridge.arm.com>
References: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>

On Mon, Sep 30, 2024 at 11:55:00AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> iter_folioq_get_pages() decides to advance to the next folioq slot when
> it has reached the end of the current folio. However, it is checking
> offset, which is the beginning of the current part, instead of
> iov_offset, which is adjusted to the end of the current part, so it
> doesn't advance the slot when it's supposed to. As a result, on the next
> iteration, we'll use the same folio with an out-of-bounds offset and
> return an unrelated page.
> 
> This manifested as various crashes and other failures in 9pfs in drgn's
> VM testing setup and BPF CI.
> 
> Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios")
> Link: https://lore.kernel.org/linux-fsdevel/20240923183432.1876750-1-chantr4@gmail.com/
> Tested-by: Manu Bretelle <chantr4@gmail.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  lib/iov_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 97003155bfac..1abb32c0da50 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1033,7 +1033,7 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
>  		if (maxpages == 0 || extracted >= maxsize)
>  			break;
>  
> -		if (offset >= fsize) {
> +		if (iov_offset >= fsize) {
>  			iov_offset = 0;
>  			slot++;
>  			if (slot == folioq_nr_slots(folioq) && folioq->next) {

This fixes booting for me with my 9pfs rootfs. Tested on next-20241001+this patch.

Tested-by: Joey Gouly <joey.gouly@arm.com>

Thanks!
