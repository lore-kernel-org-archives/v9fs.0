Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534E3C454C
	for <v9fs@lists.linux.dev>; Thu, 12 Mar 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320257; cv=none; b=HFJ1yZ5x/i4Ps8XQt+XaaUeNG85T8eoNWGMvfQ6uByNwpbVxCO2S71XgTEA049hdomHd7OLEGh2v9iyL8yWLovlNPtUhsu0WHDVDhRLR0qkNtdYFINLBbC+/zKDNwMj1Tk+nNTlrnNQMfO24OGhDj9yj/WAEWhmViyYm2AVlYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320257; c=relaxed/simple;
	bh=Rr1jkAP22lZkLvo3o90a9fRSWh9+kilNKtAarSScWFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJI5n+aVpjQyl0zTECMn/uIU6ubbfYsRMb82XyHZsooEhpwafpnPgxIkxdDVA5Y8wssuQTaS9lpwWvtgNNREuhlLr2mTtySVQdr6OHf4VFR5yeCIb683M56l7DxJ4QyFKaJ4cKA1Oa3gMX1QB9uHkZEp6YHulz7rUS+0ja6lkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nVIyHmtx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nVIyHmtx"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a6cf8242so8849481cf.1
        for <v9fs@lists.linux.dev>; Thu, 12 Mar 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773320252; x=1773925052; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
        b=nVIyHmtxjvuHU2WooaPvVIJyWMLIavFAbnfF3EMwTyeCe6Jwh16Cc/2X5oR5JCY7xN
         Sa9SHT7wbmq/tQso5EeKa3cB0FFKwnbLFKVySuwjtZIgkFpm5Y5/y1sH3IN0ZjxujoTs
         cvi3DS59f6x8zSGKa30UG+1YXccClF6XKkfhX27a2mQ1iHcgjt07iiTvNDOusfoyyb4L
         tHa/jwISMxQfIP0HxYaAgcwqVI4491rQ8DHPUkX9vV3Vz2aY8KPu88HffHi/BD6zwcm1
         p6rnPX+s1J3sQAUNk2MURk7ASeBgJODP/YrfH9/YU9OQIT+mFcp1uUjG0i3nLTckdXon
         4D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320252; x=1773925052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
        b=Bzo98uuPi8uuWI9GKiFQPQzMlUJvJwj8ejVDF9j6OyKKNhTf43U3Qiutsc5cbHKuZa
         Cpdgip8KfPO47HOayHddNq6CyHvToj7YPMH/Ws4Z8kCLp9xaNczGSB6hjoiCdCNaaide
         6tFKm4Xz8SdI7tMmTdFB0yscrEB2fOIIrUPhI6hvSXLfRYqO+lT1q5On6/AxM5cdB/Ub
         hrEt7KAheQhIQqA/PI36tyQOd/SFllti4vhNFL/v602ZP4hmacQAg5YOFX6VmGi4i+m2
         MeRKJMPH88+swg24UAVzpoO94oTwakKlFotXxjBVW0w/nPOU7TbquKe5+uHearRecUFa
         2qAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKvon9G+X+7b912K2EbxbCa5qedE5sxptGSvnEP3W4VX3Tn9+3KQDuv2n3OTWFubevTXyK@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/u+cVWU3piBgWPrkI16WnlsNridPhhFHCgjuhMpO77wg3qy3w
	40TjQXUqTwkmAeMJltalDJvlng7J8SZjfcXL1kjBW5zRnM0aM2tOKXlMuPlHZXlkwBM=
X-Gm-Gg: ATEYQzyLSKpEpW0oJMieXqP8J/tSQlS4tlEWnCWuvH6UwORXXt04Icw3Mye0A7PV2JJ
	Ml94aq9IJXz4Hox3caqay2jBQSyKmnlyLrWbhuJYNYB2V5h0bcRfV6foUUCmuay1efO6s+CaGmr
	hNYqKulaI0Hcl7AnkzJNcX4xt8TYbrAQFn5OT61E9W5NtvUFXZg8h+BBhFlSZSd8D1y47+2p3aT
	SzRL6U0A8Vy5/DChrBSaCSSEgx3H8566i3dU1c2TN4vsOgcXYfuqf6jqkx+KrKpUMo0pENj1BnG
	tR5uJp8XlVnIxF6Go2y5GsUO3IWxoJc3OSIXH2M9c4Y/XMABaIKbnwEcnY/yeDphqFDG97XkSuN
	5HMANzeWG8av97uI4RBxb38rBQQYzQquN9e71KQGvECuhUeoxscUGn4oK7fdK3UYxvaEZLWrXJo
	jVq0kkAIW5d6ATC7g+Bo7BIXVmcKGeR2Huh+cMFqzNnetyQuVaNjrgl4bkokOzen/W+ExiaHBWc
	DaS08Ax
X-Received: by 2002:ac8:5d4d:0:b0:509:cbc:127b with SMTP id d75a77b69052e-5093a1bd58fmr77950521cf.60.1773320251710;
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd318fsm33341196d6.8.2026.03.12.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0fbW-00000006fKD-1POa;
	Thu, 12 Mar 2026 09:57:30 -0300
Date: Thu, 12 Mar 2026 09:57:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
	ceph-devel@vger.kernel.org, cocci@inria.fr,
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
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <20260312125730.GI1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBlpGKO842B3yl9@google.com>

On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:

> IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
> flawed API design. It usually implies that the caller is unsure whether
> a failure results in an error pointer or a NULL pointer. 

+1

IS_ERR_OR_NULL() should always be looked on with suspicion. Very
little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
implies ERR and NULL are semanticly the same, so fix the things to
always use ERR.

If you want to improve things work to get rid of the NULL checks this
script identifies. Remove ERR or NULL because only one can ever
happen, or fix the source to consistently return ERR.

Jason
