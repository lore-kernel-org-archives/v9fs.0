Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E53D0A1
	for <v9fs@lists.linux.dev>; Fri, 29 Mar 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712758; cv=none; b=YGWbTVJ0oDS+fUDvnyKwhi41pjrZrSuMTZeFw035SKfPC8Y3P066yiz2Dnr+aWb4CpJLVHfj1WGZ5iiInGzMfPv0gSPUTtKNMGc34wp1jLH2pH1BqZD1TDHKlJQjzNhYrSBppYVpF1L0m2+j3pOqML9nR85Zwfrn6mA752DaHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712758; c=relaxed/simple;
	bh=kNMj+YT8/hRCP1/RW7aCBo3XA153NEDluUwsJT0u81M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GzNKwKV7xpbvOsi0sEeRBGhO2dh9Ed7enVnqvcI02WK79JEhE8JsAoLNPufM4hwtuBETaDEyYT7cYr7SI8GnHmM5J87NDGgZyv1nSmd8ucolpjbe7NSmrC7ZCoWEYWVxEDcWiGX+J1KewLYa0/GJXIeHNCPRdTMOgjiIGJcgSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipqMQXrg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipqMQXrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711712756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+LLP6jd0zeIvxHanQorL3kqCJpFSSxGEDWd7CPARJUA=;
	b=ipqMQXrgdMsGEYu0j2osRY1fuWMLdGgCZe4aPgvsS5bk6utG0ntwpfmtSAISqalJkEKcmO
	ODoh3JoxMvdipSvz8JnT3J6zg3uIGGraKI4u5ItiEuaCYYgl53hsadV79Xl7MzJQZTatep
	BKlyHXq5EkuCxt9NN/NwArCx6bkgRqQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Kw14ldw_OLSJokCCuczslg-1; Fri, 29 Mar 2024 07:45:55 -0400
X-MC-Unique: Kw14ldw_OLSJokCCuczslg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-568b1075d18so1196496a12.3
        for <v9fs@lists.linux.dev>; Fri, 29 Mar 2024 04:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711712754; x=1712317554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LLP6jd0zeIvxHanQorL3kqCJpFSSxGEDWd7CPARJUA=;
        b=jxirS7tGIJQoAsunk3+GurtASVenhk86ZaRulI/qfL8guLAnmlwZGv2SL4RAsWfuXm
         s5nT3gJaVDko3gWdsKcUtFz8MnJwX+PCh3GCqbVskEfLlGcDi7SWl6QLo8Tte9iLDHpz
         QS3YLwXIQXviNYB8aWFYOdVseF3H/kU3UKZEa2oBtGx/cmtxNVLHyK2C7ZvUDgx3eUOe
         pAFbECqzCfB1Egx2TTI4TNmhWuhIEcH96XugCIUIL1fZ/URtkDzH9OkIPhZKom6NVPMI
         3YhfxVAFKTaCrvkFFiGJZCaYynuxX+wJofE2sAQ6nxabKuCXz1noV61CdOF5YwzHwOrj
         P9PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7lAlBY97bLZaSpsWQu550l2ZSWlCGAx+ezK8BUMR8WVizZDW4FUQDa/J8YmnXxFotITHRBy5oX+ybUOB3M/LotwoIWw==
X-Gm-Message-State: AOJu0YzPGt1jJjbfKPoeKODY0Ftg4qyO7jMMKh67NY2Ha4zC33Q8xX5j
	VYOugNBSzGOjDnmh7mb77T/cOs804slgs8RBirAxJNW1xkNTxiUIoMxrWVcc6BbQa12zl2p+4BQ
	0ZbD7iGTIpYrKmDvUVziwn/QI4qmPKDi2tku4KPaPetczRoR6raM=
X-Received: by 2002:a50:9b1b:0:b0:566:4aa9:7143 with SMTP id o27-20020a509b1b000000b005664aa97143mr1413879edi.14.1711712753975;
        Fri, 29 Mar 2024 04:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYo6QfJYFEsVSF15QDDFwx8DOxbmiwf/M/DPk0Gc7NLZc79Ft95vFE1vuYwIhBFYvCdq0kyQ==
X-Received: by 2002:a50:9b1b:0:b0:566:4aa9:7143 with SMTP id o27-20020a509b1b000000b005664aa97143mr1413848edi.14.1711712753534;
        Fri, 29 Mar 2024 04:45:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id e12-20020a50d4cc000000b0056bf6287f32sm1991237edj.26.2024.03.29.04.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:45:52 -0700 (PDT)
Date: Fri, 29 Mar 2024 12:45:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	v9fs@lists.linux.dev, kvm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 16/22] net: vmw_vsock: virtio: drop owner assignment
Message-ID: <xhr3nq5n5acn6m7lg7ai2cfaqvlc2a2nihruj54f7um2bjdpaf@tivbri5udlrb>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-16-0feffab77d99@linaro.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240327-module-owner-virtio-v1-16-0feffab77d99@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 27, 2024 at 01:41:09PM +0100, Krzysztof Kozlowski wrote:
>virtio core already sets the .owner, so driver does not need to.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>---
>
>Depends on the first patch.
>---
> net/vmw_vsock/virtio_transport.c | 1 -
> 1 file changed, 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Nit: you can use "vsock/virtio: " as prefix for the commit title.

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 1748268e0694..13f42a62b034 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -858,7 +858,6 @@ static struct virtio_driver virtio_vsock_driver = {
> 	.feature_table = features,
> 	.feature_table_size = ARRAY_SIZE(features),
> 	.driver.name = KBUILD_MODNAME,
>-	.driver.owner = THIS_MODULE,
> 	.id_table = id_table,
> 	.probe = virtio_vsock_probe,
> 	.remove = virtio_vsock_remove,
>
>-- 
>2.34.1
>

