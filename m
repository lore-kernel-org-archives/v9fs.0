Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28336414A08
	for <v9fs@lists.linux.dev>; Wed, 16 Sep 2026 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587746; cv=none; b=RxD+9vkGs/1lvprsplyBbrsZlSftJHfttAWnMvrc/VsyuqIc7MhvW/tejSaTzsnLccb8i6F60c9pQRgNR8cEPJWOt4i7xFu05tqZNY1JaoGa3D0JeVC3s83jWKf+OVWaraIPLV6EvvcDztq0BdoxTTRKcXThHWwp1epsoWZPEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587746; c=relaxed/simple;
	bh=Fq3BkwNwppeKK1UWo2It9BObdFKKPRXP4NeynFNoMfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyLd1blbJxfzSiEnzy4Ny/+FDbr27ebcF/nB9M1PhIQjz2YnnyenisH9/YLtaYakfStysRYulmV1fd8bNjWghCGBL0lMIBZ2qpAUwCkpn28efcWpjJaJjuzsdriwpppyocawIZPBI2dQXGEFY2LVcB8FQQ0cGQrsyZhlILEWnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwuRX0ey; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwuRX0ey"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so598485e9.1
        for <v9fs@lists.linux.dev>; Wed, 16 Sep 2026 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789587728; x=1790192528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fq3BkwNwppeKK1UWo2It9BObdFKKPRXP4NeynFNoMfA=;
        b=PwuRX0eyruTSpL/Fs7pA1XolED4UH8QNh509W7f0i1FbfXN86Xl2rB6AinFZQnpbGX
         hrLP3PIipVcuzyh/LM3eSCQNfRbIKnDH4+RN/HyC2YlmuCQ7+s9TEY0NtKF4XLjFUlFO
         wbo20smwx8Oj8CSJ20x6pGrfJPIU1gLyIw6iaClZYCF4FSpW1+mtCE0nwzrlj8YfM7pj
         SOojZ7VcwirPIw4e/zSJVXPAE6mEqh2y29+B9aCK6pqfVCLKXmhPYtUIo38GGlm1EIx6
         gX1alupZ7ZrzdSP/IeAeDCTKTdV+fuRZE20Btz1hzT3ATAFJtfOfRJz1nz91S0ymdUj1
         s0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789587728; x=1790192528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fq3BkwNwppeKK1UWo2It9BObdFKKPRXP4NeynFNoMfA=;
        b=knJ4s+IRc7uZLw04GZ7AitySjM3cebab2NeYFgjmjYvf5Bu/3Xcs9NudrzkJYBezSG
         QIj/yyqsisCauewqaEpb0BuXUH1WqHjst6aR5zgFhwJ6D0opnUDOxmnBx+PPrAdO7fOo
         HEcPOx1aoStLg1vBRadZyKnqXpzU8J/nEuTd/IW1aXUxZOZcG83K85gRdi2ONBxtKurt
         trYTBlgm6tyTBppB2ariI2KDH/v2mFlb+iLEn8jSc5AjJRv2IIK11p3glDjurqdLM2aX
         qIU6GgB/Syxq9VmROcC6qtuvxQq0uvUHI5mHajRUtBr85cDKieGkFDzYH45AK6YuhXLz
         vGiw==
X-Forwarded-Encrypted: i=1; AKwUvBwq62OQetw5krO4GgzkMwwnHwRcnPQRhssIy3R5EE0JWfQ4tgfXI6N6cFSDLjoMuCqNWN4I@lists.linux.dev
X-Gm-Message-State: AFuF++lCbd4ma6LUHLBLEZmt27Z6niwm4KIwLZYW5Bc4OWYSCrHJrqWi
	SO4Uwg8igogqCKh4jg6ZiScX/qPLR7fGftx5lqD3OelSDzCA20a5BSfH
X-Gm-Gg: AYBFou2GRZLO5CpO4+vs1yHIFRPpbtCwELOjJt+kx0V7N+dne010ICan+2ffNmXlAmU
	e4Ws4ApwR3om7N1T7sammUKznsKYKJpQ7KxA0K9N3AecPL5tid2MV10NrScpEaglRIxbapLoRnn
	d2RIy4xxxp+z2R3zxtaaoVsUt/OrF4EI3wi7mLs0mFBx5hnvwrSQRDF3GB/rSSck8LjrFG/zXgh
	1OsTfseCHZUfF6vlHhQFWVbrOxu/Au3HR8eGC0VmeY14xlOu3kFA+v7Aw3A8ScgrvQTLKsGMiyF
	R9EliY3fQNMdhgh8zIJtj9YBb66INeJ2PxISbHOqavUVqdiM+rHFgtwbOePWh32MiBIFjww1hSN
	02lXlKcquIixBeeDg6SEIG1W1lLVlFiC8ZAMrBBMiP0+lyXmbXIn760IXTTi1YAIKWTZaMIoN5U
	Pl8vDaU6IxdWn7vx7JAy0AWeMPdBGoElGhYfvlq7q445885KlewjAghK/Eax6W6RywDHlJTX3Hb
	AXy924HgRWzJEN5npK2cFINURBjMFK/8g726hNmEE7nYFPYP61Q4pAkO0Dvt/zXl+qNnPLPTou7
	DOb1Zr6ann4R6Jw=
X-Received: by 2002:a05:600c:83c4:b0:49c:ff9f:f6b6 with SMTP id 5b1f17b1804b1-49eac463960mr49616985e9.6.1789587728274;
        Wed, 16 Sep 2026 12:42:08 -0700 (PDT)
Received: from mskvarla-mac.redhat.corp (adsl-dyn31.78-98-85.t-com.sk. [78.98.85.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bcc7d1esm9174964f8f.0.2026.09.16.12.42.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 12:42:07 -0700 (PDT)
From: skvarlamatus@gmail.com
To: asmadeus@codewreck.org,
	skvarlamatus@gmail.com
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stefanha@redhat.com,
	sgarzare@redhat.com
Subject: Re: [PATCH v3] net/9p: add vsock transport
Date: Wed, 16 Sep 2026 21:42:04 +0200
Message-ID: <20260916194204.99506-1-skvarlamatus@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aqiGy_7S_cYs_6or@codewreck.org>
References: <aqiGy_7S_cYs_6or@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 14, 2026 at 23:44 +0000, asmadeus@codewreck.org wrote:
> Right, diod has an open issue[1] for vsock but since there were no
> obvious client available either it was never done.
> I don't think it's difficult to do (probably more work to add the option
> parsing than the actual vsock support)

Definitely agree. I think with this in the client, it could encourage
more servers to add vsock support too.

Thank you Dominique and all involved!

--
Matus
