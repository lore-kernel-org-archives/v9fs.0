Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32115624B;
	Thu,  9 Apr 2026 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775697725; cv=none; b=Z1NwdiC3LuMt4PG8lY6ZiKLk/sQFtthPjS2uj/DJh5jMzM0FqAD95x0oUT8SfL6ZZ/Iz2eaqw9nr3lsY/g1Q40D3jWUFzVGqykckYmaA40Vy3/NAin2GDFREplVku6bD0Guz0cLcXyFL19mVYZU9IcWFkWdFq1l79ej5kjtgqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775697725; c=relaxed/simple;
	bh=elulk/ZpJDsxBMzDKe0Kd4MC4mECsZ61D3/iO1RkC2g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EyuCD86+EhMqC1U1MapBhfHzmyN79YzCcQ/A7uerHb2eWFjf7VU3v97BRSHQZwY6JivZjKC29PdQb87E5hToYmOP1IxpJq5gYCQC7oHDabhcfrCKan3rU5WrHFeRlWQhUZ2NNqDgCJPjiX2Xl3lztfwPjGKGCyASLKbSHnSJQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnJapHJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnJapHJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370EAC19421;
	Thu,  9 Apr 2026 01:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775697725;
	bh=elulk/ZpJDsxBMzDKe0Kd4MC4mECsZ61D3/iO1RkC2g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GnJapHJKe/HcZOCFYIm07nVyDKrwigPbyjYyrSsW8Mm2/ftOESrd7Pzd8WTgHWeYZ
	 6ZFyYUC2BbfPK4Ffb58/pWyptZgDxhVTRvMqdMCL8BjLGG/D7kWQ96Er0GyabOad71
	 YEbAz0QO2aSNVwg6sv3y92xgHq3FvP7vD7HOqo8tFX/BknDgYGQktKF6y879L32zYK
	 Ku91geuUsqYTNnkRQs8banQnmvqDXvopU9ikDY5aX1hIOTVqBTJamxhHvmo4CVE6yd
	 /xU2xMdFgz7qyo2zAcUQII5j4WgWE0xPD2AzVoet/fCRs1StF5izKzTlWWSIIbChWB
	 eyagM4crCXe4w==
Date: Wed, 8 Apr 2026 18:22:03 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Eric-Terminal <ericterminal@gmail.com>
cc: asmadeus@codewreck.org, ericvh@kernel.org, lucho@ionkov.net, 
    stefano.stabellini@amd.com, v9fs@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] 9p/trans_xen: make cleanup idempotent after
 dataring alloc errors
In-Reply-To: <20260324153023.86853-2-ericterminal@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2604081821530.2873990@ubuntu-linux-20-04-desktop>
References: <20260324153023.86853-1-ericterminal@gmail.com> <20260324153023.86853-2-ericterminal@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Mar 2026, Eric-Terminal wrote:
> From: Yufan Chen <ericterminal@gmail.com>
> 
> xen_9pfs_front_alloc_dataring() tears down resources on failure but
> leaves ring fields stale. If xen_9pfs_front_init() later jumps to the
> common error path, xen_9pfs_front_free() may touch the same resources
> again, causing duplicate/invalid gnttab_end_foreign_access() calls and
> potentially dereferencing a freed intf pointer.
> 
> Initialize dataring sentinels before allocation, gate teardown on those
> sentinels, and clear ref/intf/data/irq immediately after each release.
> 
> This keeps cleanup idempotent for partially initialized rings and
> prevents repeated teardown during init failure handling.
> 
> Signed-off-by: Yufan Chen <ericterminal@gmail.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> v3:
> - Split from mixed series into a dedicated 9p/trans_xen series.
> - No functional changes since v2.
> 
>  net/9p/trans_xen.c | 51 +++++++++++++++++++++++++++++++++-------------
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index 47af5a10e..85b9ebfaa 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -283,25 +283,33 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
> 
>                         cancel_work_sync(&ring->work);
> 
> -                       if (!priv->rings[i].intf)
> +                       if (!ring->intf)
>                                 break;
> -                       if (priv->rings[i].irq > 0)
> -                               unbind_from_irqhandler(priv->rings[i].irq, ring);
> -                       if (priv->rings[i].data.in) {
> -                               for (j = 0;
> -                                    j < (1 << priv->rings[i].intf->ring_order);
> +                       if (ring->irq >= 0) {
> +                               unbind_from_irqhandler(ring->irq, ring);
> +                               ring->irq = -1;
> +                       }
> +                       if (ring->data.in) {
> +                               for (j = 0; j < (1 << ring->intf->ring_order);
>                                      j++) {
>                                         grant_ref_t ref;
> 
> -                                       ref = priv->rings[i].intf->ref[j];
> +                                       ref = ring->intf->ref[j];
>                                         gnttab_end_foreign_access(ref, NULL);
> +                                       ring->intf->ref[j] = INVALID_GRANT_REF;
>                                 }
> -                               free_pages_exact(priv->rings[i].data.in,
> -                                  1UL << (priv->rings[i].intf->ring_order +
> -                                          XEN_PAGE_SHIFT));
> +                               free_pages_exact(ring->data.in,
> +                                                1UL << (ring->intf->ring_order +
> +                                                        XEN_PAGE_SHIFT));
> +                               ring->data.in = NULL;
> +                               ring->data.out = NULL;
> +                       }
> +                       if (ring->ref != INVALID_GRANT_REF) {
> +                               gnttab_end_foreign_access(ring->ref, NULL);
> +                               ring->ref = INVALID_GRANT_REF;
>                         }
> -                       gnttab_end_foreign_access(priv->rings[i].ref, NULL);
> -                       free_page((unsigned long)priv->rings[i].intf);
> +                       free_page((unsigned long)ring->intf);
> +                       ring->intf = NULL;
>                 }
>                 kfree(priv->rings);
>         }
> @@ -334,6 +342,12 @@ static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
>         int ret = -ENOMEM;
>         void *bytes = NULL;
> 
> +       ring->intf = NULL;
> +       ring->data.in = NULL;
> +       ring->data.out = NULL;
> +       ring->ref = INVALID_GRANT_REF;
> +       ring->irq = -1;
> +
>         init_waitqueue_head(&ring->wq);
>         spin_lock_init(&ring->lock);
>         INIT_WORK(&ring->work, p9_xen_response);
> @@ -379,9 +393,18 @@ static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
>                 for (i--; i >= 0; i--)
>                         gnttab_end_foreign_access(ring->intf->ref[i], NULL);
>                 free_pages_exact(bytes, 1UL << (order + XEN_PAGE_SHIFT));
> +               ring->data.in = NULL;
> +               ring->data.out = NULL;
> +       }
> +       if (ring->ref != INVALID_GRANT_REF) {
> +               gnttab_end_foreign_access(ring->ref, NULL);
> +               ring->ref = INVALID_GRANT_REF;
> +       }
> +       if (ring->intf) {
> +               free_page((unsigned long)ring->intf);
> +               ring->intf = NULL;
>         }
> -       gnttab_end_foreign_access(ring->ref, NULL);
> -       free_page((unsigned long)ring->intf);
> +       ring->irq = -1;
>         return ret;
>  }
> 
> --
> 2.47.3
> 
