Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA113D506
	for <v9fs@lists.linux.dev>; Wed, 10 Apr 2024 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736169; cv=none; b=VBEhLCwQPkD2/0IJLIVO77p7JrLfLKx+O2V1Mi8WC/pZJfOa4Pdz/2PoKGkig0Rzs4GXRifnLqodGXoPJ08DI4bIQuNXxYaYjaJ6TEgB/AkHIUWKlpiJUFeotoPlQ/6TulK+TOU4EMP38aJu95xfvYWFxSqf7UMjD8GuUxOyY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736169; c=relaxed/simple;
	bh=d1PN1Hm45NhCEHeS1enwZRk3BBE6Kbx5SrWseLrZK54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lHlYAQhw+53YMMLhDH3UMQTtPd09GzUzORMF6cumA8mOAKqAJPgwcw0rOEMRHfizUqqAroljcr+KkwMOQ9F0MzM0mPS4v0lVSbO0QKFSbEl2K52uCEeBpv1iP4uSIL5Wwhf6z0djGMybAqZMHKPQgtP/L3qbgbBNy7Q4V2GwrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pk97KuT/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pk97KuT/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712736165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXu5GyWFLRYVVgKT/xx47xxPPvyqqTS3jJA/xlCkkm0=;
	b=Pk97KuT/mE9r5AWVFdqO6INc6z4HesNnp8Eydu2oWb9B1SKZTBktWULMTV6CAv5WHqzYfb
	lEV3l0VSl46VIecpkz+PButrh4dcw0SGAOKtlkkT+cdzv/cTu9TaijbzP+0LS2xbwPCKPq
	mqsjrSmvjJQcMxrmicBH/NKgjbxKZms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-6lN2Ag3KN5SjVyY36DsAqA-1; Wed, 10 Apr 2024 04:02:41 -0400
X-MC-Unique: 6lN2Ag3KN5SjVyY36DsAqA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4162b9b1702so30268225e9.2
        for <v9fs@lists.linux.dev>; Wed, 10 Apr 2024 01:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712736160; x=1713340960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXu5GyWFLRYVVgKT/xx47xxPPvyqqTS3jJA/xlCkkm0=;
        b=TQ86GJjSrNn0dZa4bnP67ouqn6YciSbyfdZOLL2etCfERiDDJRtSsAD5IkgbcdSVcx
         fI4ZOWz9D3WSf3TSyzGlnAQJLZP7HkiKcDWif9iy44/KF+KAv7+waoUwmX2eJet/9Zut
         E3IZzmVflzC0yKwS3C8mMR3OVfhdg/wZxTZE2cQwjGkVtSW0OvQpQrUFlIwGugdHWXB8
         PxphwDgSKTVN+gDmNEiV7SSNu6SP3tzfA4Ibb/zlXnXuF9mE0XvmtTMBKy2Ea2lyA3OO
         L/xEo45aSFxbnnSS+uU4xbCQKtHAdYp2N3/0RL2Y4TGAVPXN60X3VXTVIm4cb3g4yadI
         dAGw==
X-Forwarded-Encrypted: i=1; AJvYcCUJMXG5uE4YV1clL4Z0794Li2pP4qtszTdDhSJn2gdz7WaYCg4i1tB/T6hlso8SkP9PPOQOgN3Pv0GWdcpsGhCFQV/Ang==
X-Gm-Message-State: AOJu0Yx+eGOVzTq+jrVQtx+7b5lxNqxCvR1sgJ3F1FJBlmITuFE7x7tg
	IdQ7r9B66O2AJXbUEfk8I537Dzh7VwhBsUjfhK/bIRWbS29C3IsSUcWRZFVGEo6wyXtAoZqsVLE
	8fyediYpZYsneYeHJPEELWHnkY2YNTY68K40HeLZES6md8htXDSw=
X-Received: by 2002:a05:600c:1e05:b0:416:6eaa:6179 with SMTP id ay5-20020a05600c1e0500b004166eaa6179mr1616266wmb.6.1712736160185;
        Wed, 10 Apr 2024 01:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmI+bK+Bmn5+2XukodBdn2GXQ92haKG6VohgZt2mHVdjYtyJPyqjLehKUQ4vb5gN6ueySe/w==
X-Received: by 2002:a05:600c:1e05:b0:416:6eaa:6179 with SMTP id ay5-20020a05600c1e0500b004166eaa6179mr1616221wmb.6.1712736159530;
        Wed, 10 Apr 2024 01:02:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:8bde:8cd:63ff:6fae:3872])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b00416c160ff88sm1491111wmq.1.2024.04.10.01.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:02:38 -0700 (PDT)
Date: Wed, 10 Apr 2024 04:02:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Hildenbrand <david@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gonglei <arei.gonglei@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alexander Graf <graf@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev,
	kvm@vger.kernel.org, linux-wireless@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 00/25] virtio: store owner from modules with
 register_virtio_driver()
Message-ID: <20240410040140-mutt-send-email-mst@kernel.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
 <285be63c-8939-495c-8411-ce2a68e25b2b@linaro.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <285be63c-8939-495c-8411-ce2a68e25b2b@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2024 at 09:41:57AM +0200, Krzysztof Kozlowski wrote:
> On 31/03/2024 10:43, Krzysztof Kozlowski wrote:
> > Changes in v2:
> > - Three new patches: virtio mem+input+balloon
> > - Minor commit msg adjustments
> > - Add tags
> > - Link to v1: https://lore.kernel.org/r/20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org
> > 
> > Merging
> > =======
> > All further patches depend on the first virtio patch, therefore please ack
> > and this should go via one tree: maybe virtio?
> 
> Michael, Jason, Xuan,
> 
> Will you be able to take the entire patchset through virtio?
> 
> Best regards,
> Krzysztof


Hello!
Yes I intend to take it for the next merge window.
I am also merging the 1st patch for this release (it's a bugfix).

-- 
MST

