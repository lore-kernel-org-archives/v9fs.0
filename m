Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65673136E0B
	for <v9fs@lists.linux.dev>; Wed, 27 Mar 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543532; cv=none; b=m31Ren5Qb1q+H0UAAx2XlRCyoBpGN2bXC3nEprY3jeYZLF+Kw8hXMq48dC3YpjrN0rFUjxeJNOcx5geFPZdUnlCptsLJj1KduNdVoxSe3CCu8t0dCYZUQDPqPc+mozF8I6CwksBNa6syMhMfvX4LG9sE8tnI5bQGGpf1f1xFsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543532; c=relaxed/simple;
	bh=nkRw+hEyffQkd47xH6yhTGRY43bQKFbnoktzkBjZ19w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9UNGJK4WotYvGY0tAvTK2wV4jTp6udt7tz5Q4uk6bOMRIA7FlxEcBQohkl0lt1YL+lcTEA5hmGTGQwDDU/K1IgVbID3oec9d3rVtIi6oO0oF6T+4Kh7kDzX61p+M9CUYrfzKdZ4sv4Xfog9DJnVHu4mwiLhYBKPGcrV13l9g+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uc0nrNwb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uc0nrNwb"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513e6777af4so11952247e87.2
        for <v9fs@lists.linux.dev>; Wed, 27 Mar 2024 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543527; x=1712148327; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIGX0zkEWaN83RrWauYFLuhRKQU73+opfJC/SaE++k0=;
        b=uc0nrNwbx56yQ95Wh2ILU4r2MbKrCR8gpT0nyU92BVJcp1GRDBXhmioFpQuihKTAp8
         A6buWijoRKntr4DyqXflylA28OvmHcrKMhFpq5gB9KPjUgJyW9UN9OzPqZD0dC+SEWZ1
         /cCQHm2nPjSTv5U1th3PmMqTmuZXMXjmrKzZ0fhWZaVh9K0f2qABZ3SftqAQAhYNcOn/
         8os5dMWAJEEt6JUnxynPtWAwIFfyipWZCfTXFBlx4I6aEa8/AkMLgMdX+qnOBJ65tdeJ
         T1CfKp3mI7VJQipRaorEkFIM4977jTnN3B2ETSc3d6MA1uS1qk91kDkT+HhhoKI9LSRr
         bwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543527; x=1712148327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIGX0zkEWaN83RrWauYFLuhRKQU73+opfJC/SaE++k0=;
        b=dlbdtsC4wj3RmXf5ZnoKfspRYEa8+GA5sD+0mJYZ/xjrmxJWHRBNRl2sMxBkCNCO3z
         f/8X7Wi9DS19xy2mG6UcJBFlMlyMltEymxWZD2wJhDboertjVXGkkReUx2c+0qCBxRF2
         hOaVE0sl11CZcTinIculliy2dKfqbND73jnWgDRsmDGU4CceIDjHifz7upC9eJTLg23M
         0q/aL2uJ5q8X4nlNDfdpqHQBJqk1Ol0tO8PgayIG9fzVZOE/3/OLW5Z0XvtE9JKWIgL9
         KdHWWMpl+NBB1T4wFCPeL+NuLQH8KOLShi19f6h2UCzm8g2Osuf0UgEgeORoVvocDw5z
         XluQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqt9ZJYnuqVJdU639BTiU4mStHJzZvKuBVrAPI9I0dEAnzPvsdk55lHoWOex7Cnsix3+h2Watac17fHblKpYzyFy7Leg==
X-Gm-Message-State: AOJu0YycIWgefHGkOZ+o91L8VzAnmF2oPLpn3rPc0WD1VJ+GXDFwAZKF
	+L6+C4qPWhupYxmewEmim5Qg/e8LQqBuRNMk/noYh1okO5b59j99Y8x+i8IoQp4=
X-Google-Smtp-Source: AGHT+IFTe6KK5NzzAQw6DLzrYupzSMTGssF+U7deLYZAVBSrCE4A0Uj/ENe1tzZVoUoWNlZVC8fZZg==
X-Received: by 2002:a19:5e10:0:b0:513:e14d:15e1 with SMTP id s16-20020a195e10000000b00513e14d15e1mr2258015lfb.57.1711543526649;
        Wed, 27 Mar 2024 05:45:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:45:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:03 +0100
Subject: [PATCH 10/22] drm/virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-10-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=794;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=nkRw+hEyffQkd47xH6yhTGRY43bQKFbnoktzkBjZ19w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPi5ln/NE6yYKe/g2hSdNaOWNown5itxMAzc
 cWpPjO510+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT4gAKCRDBN2bmhouD
 11JMD/9Dt0RXRxFqSwBoM243YFGwfb5rVSQTy5OQh673qccdjX4eVM7SH9KlmSEgdTRMu4skrvI
 TfWq6TFqSZmtEnLc+eNLQkIfdFU+wIY2BonQcKxwqaCVqKm5g0IFaZ07Cdol7LLV4bzHyqatim9
 YT9oVJlOnK6xwmVsULUXLNqldmTbnAjwDv/8saYEC/2HwNY6MdGJxwZuMEdCfTtd4S7BIs1Igp3
 Kd1gVLGKaUTYSbKGotlfnWBfXe+leesFc8cG2JNru47NKJ9dPuIOzgc6BpoGvAZPvD/cGGCmJR1
 V7mEZK1DEES84YfWjv7MUh3LAH4N2q+eelTKo7zg/E3uZx35ujWPAfSWc4M2LoAFVKs6yBPBdV3
 G7sGHXO3ijYLapANaowLjkLX2F+idzDM0PHiKDJzKg4vHGd0DKxKtEU+556d8L4FRriH6NHgtRO
 f2CiZT8Lxy97gIjC+CP4ASmNGWXNHrSNcw5kJ3xBkIf4EIaZOZfym/vTS9bZdLBHt7vcnAnjnsv
 YvU49CRKoalhEetDEz31X9vW2OpnC4ihmhy6KNGzG3Q85EQX7G0ltCu8IlYsqkGB25rpP79kdG3
 h6bMp4fQteqgCj4rtFzlGJkrOXJ/U9k9jcDUnvZtNzm/kvSDib52qqN37X7Asb5pv/RYggWh6DE
 bcqvemCVVipRGCg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 9539aa28937f..188e126383c2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -154,7 +154,6 @@ static struct virtio_driver virtio_gpu_driver = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name = KBUILD_MODNAME,
-	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
 	.probe = virtio_gpu_probe,
 	.remove = virtio_gpu_remove,

-- 
2.34.1

