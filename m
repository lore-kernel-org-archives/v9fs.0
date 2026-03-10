Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C03B0AD9
	for <v9fs@lists.linux.dev>; Tue, 10 Mar 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148931; cv=none; b=kckQe+lXKVnPS+x/nqxEYNiMaHZQJRZXRizJF30lVhUtn1bFJ/AXurJKBGgbUaoWdva+E+4QM3hn6PyqcYAMv4W0eQK4iFff+y+2dlXMEYKLjpR7HRk8pVrRB4StvOSbkfXIHzETE3/68o0oxo4ZdLiMLAXDlpeJ424tpFb6RCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148931; c=relaxed/simple;
	bh=7C48eJwQxF2SZSyojjO4eehKdtPdDBqSboD/LkVXOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JH5D31Wd6rCIo7w5YuRVdwJVDXB4W+EGqHFvW0nLiVXGqqUCqDCE8RXkY7lB9TJVTuXX0uT4SnNf5MaN4zwvlhq8NXKygwRUW5ZRytS8c6i96vcyCxVrRIDBIU4UtVxDOSmUN839/jCnxb/6UbB8xMiGCBuE9mu/1wiyBumWo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADQQpd+b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADQQpd+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
	b=ADQQpd+bpcMvyiI6BuK6I/AtlFPVjRaT1jbvm8x0bcg2sn4Mv+l/q+wGsOaa7zGZavpvJL
	HOw6n0NTrJxN8BVrJlzy+3Oyq/AicE10gafpjzfnHFVMImjvlOy3qRSEO7jpexZVWETsUQ
	RoRPrXnJkd5ZbUZ0X+x9wM3CIJYSD9c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-tawSBv6TMe2mXV2omL3-qw-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: tawSBv6TMe2mXV2omL3-qw-1
X-Mimecast-MFC-AGG-ID: tawSBv6TMe2mXV2omL3-qw_1773148925
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd849cd562so1322190785a.0
        for <v9fs@lists.linux.dev>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148925; x=1773753725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=YkX8HsRlSQTu/aG1KfnqJUdhi9r+RbmOcX2M1jmBxHUjxntByMp2j5nE5dwRBnnUhk
         UKYZMnzAfnpUNeU1NT9UwpERX8RiOhLcxIkTr4yVjOKZXcXjlvvdgnQHs9N0LFGT6F94
         SPDnWkCSg/T/0skCbCj6LoFQOh+GQ/9eNjuTtiS5GmyW0S+IGpkdDVuR1moySDBe18C2
         ZrrG4/eDwAP8ysvqtRAqwcygVn3o06DkgmPFLispXch3nBYb0K55ZjkYlf6I3Ur3W6wk
         l8PLcOBj4Gi6Me0M4ylCpo7cG9oQS+gyqeqGq+1h5ZnCgWUZ1u6Dok9towpRwI3tahZR
         8mWw==
X-Forwarded-Encrypted: i=1; AJvYcCUR7y1wRPqbUj0y6Eb6fATObY2BQxz8DbDh9C5IHXKpzkx/j/xUD0GSK2G9w7pLkwkrzSmA@lists.linux.dev
X-Gm-Message-State: AOJu0YxR6nLxMu1ksqBUxcnhgxtabffcWVEiRfsha0QYiSjAfuyH0nP4
	L0p/uKDiTGrvCUTTMrexmCMDp9lsZsLhVnCArzZ+ABtEcYfm5GSmaEbQXs7lRYDEWnoks5j8VgG
	JC3lOsp2NMZhI1ZbX2OWpsa/yKm7gRNINPMtbxYuRRxQGly6rYHaLvhk=
X-Gm-Gg: ATEYQzz3xkZ7MqjBP4fpSQgXyExHRhVJWR/WJDxR0VouN6VkPcUWZd5DLyH+6GEzh96
	0Jri0Hj/9gzpbuUMhxs2+mWVceDn0lbg7e+55fNafwLP2bCwoEOe2HjS3ZTIWRyyI34UmNEQr+b
	1UpPJCCnx5eTLWQtE/Weo2kA4bolqSWqb5sWysBeU8AoAz14xHg2WxShNtMbrEHeh9G5loK1XBM
	ghpEOSO8Nk5ynUY1dz41y1kFMDK57AoiSzfzdk3lnYqRhmN9wN0tX2LxF26RhR+XqY2mUJOZ+1K
	9YIhEAuodPZ+7jfFXr8hM4VrtQ+9bJsoUsJvs0YF64g9Rqz7/09mQGdXlVYKbmDhqeUstoEof1Q
	si9kVs4SW/pQVgdw8kJ2GlLZ05Uqldybb2TS5hQnBQqbe+ivDecwLPl4E
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830783385a.45.1773148924646;
        Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638;
        Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Q5SwiwC9nUC-ArURMswWwRk-ei0tgHAgK1FrzFbrSU_1773148925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

