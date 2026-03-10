Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FB397E96
	for <v9fs@lists.linux.dev>; Tue, 10 Mar 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147250; cv=none; b=UAqAMvsrGNBYdDlheabszpd6kxc31BMEc2zulhTu40ovBq6DP5CctbBR2n3MreeJKtpGZd1c1Jdg3R2EGoRUVhQTETAfo+AqRhum5vo3iTx1/7u+rT38+Ttq5h9hwg0NnB41Q6feLZs0+6sDjX/jCbJ3BPLm33/Y1eSCMozR4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147250; c=relaxed/simple;
	bh=TgoJchP8+G/BTHDKgmEWupOwORUqE0/FZPIUEYu9Z9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb1CtkXalnSrBlGUtR1btP3T3zKseUPF5KLddPhAA3x60Hv6t0tM0BkA5qV3tq8TP8PiDp1khUq0zuD6Qg3vlPDmQ7AZHO9CWmyiiJRq7lOOh9G5W0gJbD5uK+/cEzPCrx61c3OsKxv9dLwdzV4tXfxm/zMvnaUPv+oaWtXlWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXQoTynz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXQoTynz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aeab6ff148so1315ad.1
        for <v9fs@lists.linux.dev>; Tue, 10 Mar 2026 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773147248; x=1773752048; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
        b=KXQoTynzJbkjiUm+V2aKdtQekHCsQTLAk6TYwui2b0uXcoJxj6r318O9NEJ6YJe5NM
         gg5C+u3qjuCh50ssp+c6Rbssbpnsq3g9FohngmeMkJ2NyysvjxrZXYbP8tc+hM295sam
         YSqcAn3fYMLBwRZdFQjlmMtTlJTuZT0pOJYKyq7cUQ9x9SZ9P4vsnKQSN2Q7HdA34xgD
         G7Caukn+0TLArLbM+8VqlND6tfR+A0p8trto9KpxEebgbwF13J+agbT28ej1kt6J+rzI
         QsAEuVC7UNgKPEnMlLRkslC2GCue1mUAzAnoLfm0uFIrvWmmgqT+685zh6f0G7HhashM
         2ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147248; x=1773752048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
        b=xQzMftCDnwyOi1G370lSBBFkJVMsgMtdIPEJAga6NfudsUbP+TJl3UD1i+U2cY9m+S
         ucQ9FYyrKzPcBkmqRNrzOCjh1VquMnJm/R7wyPDbPr6FgZJfzJQJ+Kjg2Yoj1RHYw3SF
         DAgH9DUWQJ5CLrXvsirpcN+yMntWs8mmxsNbbB9B9emtfOEz1EQLjH9wg9ehAfSvGB4y
         rsvwIJxqUTmMhXl1WvH8qd0Lgya5W7hwcLif7DsiuFJziR9eqo4FvQzSDUF38qCudP7Q
         i1LSwaNij3qU7wogVlPtIea0eWoQOH4mP3oyx4rPz7QO+BnNU/BhiLy95x5jEGppmbgv
         lEHA==
X-Forwarded-Encrypted: i=1; AJvYcCWPXkz/G5Pws+OqUoJ31+2AWsWzQXoKl8khxdTtD8e/kY5l6byfa5KB/PU4vjzDBYQGk65f@lists.linux.dev
X-Gm-Message-State: AOJu0YzcIL15jhGixnBldN7Tdr3N0w5F1Wj+IdXLj9aa4f30c7Nzql0x
	UV/Pp/NQ0Qjjq0DwxYWtVKJuYpmunEnWE+f37KV6nyaZ8/jectb2FEvpAM+dVpYmuA==
X-Gm-Gg: ATEYQzyTkxknY42+RrdDEh9RJUQ2X3zxhAysy9Gjrkp0vseQeZntYMkvbINiC0eiIty
	y49Cu+j/Ho0oVRaCWzcoMdOOSag8OmERzv43+oj1tJbjWba9ncmqpzWJFu03rZRhlHQMP7WQBf8
	wECSUC/SghpF4O7tty4yCY916CVAQscZuAsJ/UcaE18TrSJaKRLwLBlRK7Lzl785Oxw5zqzKEu2
	Mbvid//VqpVCB9vWO8yFJjzHDXQObT8n/UPexLJoZfJAW5ZOp02d/x5od5n0Rio77RzBmXoHoo9
	pXPUoowrt5FNvomX60ZbPSWS6+2QbaWD+YI9lpf98X6/IaC5G35BkN/+dDwMenrmBhx0AjS+txj
	0FPToRxGjcORwiQ14FnmVVcYtVqRPLJb0dju6AccnSOOSubTkuTqKJAYh253YlAgAk4lIltzB1g
	ik516RQvvbHpr8iW8F5f1DVdpvTasNG3vKMTec/wc4+vGpprhAiHTD+Scp/A==
X-Received: by 2002:a17:902:ebd2:b0:2ae:45bb:bc4e with SMTP id d9443c01a7336-2aea30ebe48mr3008685ad.24.1773147247400;
        Tue, 10 Mar 2026 05:54:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0cb73dsm12445679a12.11.2026.03.10.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:54:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:53:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAUYvx6VEdSmInm@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>

On Tue, Mar 10, 2026 at 12:49:12PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/vfio/vfio_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15d4dbaf9ebcfb2e67627db71521e0..d71922dfde5885967398deddec3e9e04b05adfec 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -923,7 +923,7 @@ vfio_ioctl_device_feature_mig_device_state(struct vfio_device *device,
>  
>  	/* Handle the VFIO_DEVICE_FEATURE_SET */
>  	filp = device->mig_ops->migration_set_state(device, mig.device_state);
> -	if (IS_ERR(filp) || !filp)
> +	if (IS_ERR_OR_NULL(filp))
>  		goto out_copy;
>  
>  	return vfio_ioct_mig_return_fd(filp, arg, &mig);
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

The cleanup alone looks fine, but I'm not sure if the maintainers would
be happy about the tree-wide spam, since each patch might go through a
different tree. I'd wait for Alex's preference/ack on that.

Thanks,
Praan
