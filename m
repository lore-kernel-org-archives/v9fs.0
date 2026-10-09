Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D594E535A
	for <v9fs@lists.linux.dev>; Fri,  9 Oct 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557420; cv=none; b=GYgO4XbGkG+WTr1jWInxRQXXiS5IieSgaJrJeLDaOZ1mmGxWOFeneC7LGa7PNWaYzKdlve0IVWvqKIf0OCHuSVsZu2z5A/GGhAPKlhRhVRxO2f0NhHqYVhpKU3bTBXYppgW3g9JWv1ke6r7VB/kjwhrU0iRjaMTXFfy8tA7xzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557420; c=relaxed/simple;
	bh=QMBBcDwgjsDjyl3EBe3JFAp/DeQlExENh9tN3Jkup4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:content-type; b=QH2ltPCaBoGe1aMXaRj2ouqgRkslMjz96nuU/+Izfc6ecdg7/aDETCwJ1SvZNn86OPGIZ1SDOyZAbM2xq/GhW8vUYKTc++pjdYO/wog7M6Cpm1nBGLmuiEtrieW8DINxYIAC7e3q8Lak0s08KrfABrsgrRvWpiag1uV5yUXVUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPpMUSjJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPpMUSjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791557418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
	b=MPpMUSjJKWDeV93oZwlkWDSCJejbn/WNsD1x/38+o5QA4BIxcmmbJ1w3l8jQRhkSWJO+g7
	bg0yt+v0n6AYlwljL+S7Y8Z+A7lv1S5QL5Ga9elEtI4/ryqLg+igZ4G/qn16lw0NzEXY19
	96Wx89+d4nMjMdonE2m9QhSzITklMa4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-iPmkvi1eNHiwMIQsCBUDMw-1; Fri, 9 Oct 2026 14:50:16 +0000
X-MC-Unique: iPmkvi1eNHiwMIQsCBUDMw-1
X-Mimecast-MFC-AGG-ID: iPmkvi1eNHiwMIQsCBUDMw_1791557416
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9179d9cde17so67082756d6.0
        for <v9fs@lists.linux.dev>; Fri, 09 Oct 2026 07:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557416; x=1792162216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
        b=Q6A3OdHae2EOD24hiB3dEE4wyOZxMEKatvOyslwOwrm6RPGDILf+dTf1UU8CdB2Gxc
         lGJN6YlVT+nL/DQaHU0NCdwYPRiQnGree/ygkcBvYy7KNw230aWV6a+4CQgHScelmsI5
         Z3tt5gVuWb3jaRfh7W44zvPvCH0861wJg/tqlwzQM9N6X6quxDL+mUabltJuXSAwMQ6t
         /ZtFPqPR+ijYhxljFpg+qvvhM5xT6XOiBw9/xyApP8zvUSkkh9Pt/RKSKGFGbJQfZaGT
         RA4mQ7Fyh4V+5k28Xwu3ATjCibkckMS5OBCBAJ7yoyp8niWh0O0UYUHkD4xwcCfpIWfO
         38fA==
X-Forwarded-Encrypted: i=1; AKwUvBw59K0IMJ8g1TsLuNVIhzxbGh5y6fIK9Rd/3ivj8B8hF7KLds+iL+sYSS5g0kRCUP8d/KUh@lists.linux.dev
X-Gm-Message-State: AFq9FYJBCWPZsx17kOHNu6cu6qDTn+P44qhhVcofX1rflcq013yqZgfU
	44z8lAaflihOHg8s0TbylyAOvaLg40d2fFagtJ+RUXGMf13YTIIgmgKj1U3iyEzvGNbhbtcKBF2
	7TbthRwCtq+x8xT2WJqmP+HRa7B8Vf53NVDK6WGJWhfazGeDjoH/oYBw=
X-Gm-Gg: AYBFou3SPaRD4j1HOnGJ8PdEsZ1P6txxP/dsXkbgDbvoi3GRPHO29PEouW5JzSI5qAe
	63vwCxzd2W8DwHa+5ruvU3e7dy5cfumxKsEfCMsQ1x2D9P+7d7by506AsLQfnSE7KZn4205Ri3q
	MBGFHeCX6WY9XSC3GxxPgKJx8TxSZFuPkvq1kwsVu8rN8pB/Q2Ze1oBs2AlIsYpCDR0gwhet8Zh
	4DRRgJotSZ11lu9cQyQU2+UBLC9lUUplZ0leQCRiyVu2TnzVZvPmFKIiPnX53kpDVdhmXEtDwtf
	NYLQrd5MtJKAiOkt8r1IyN/5UJ9yU6S4SBQdM8klnIOd+YUmp6vkS1awnjJ6K5k8/CUmYUf0I+8
	N+1U/XwNZYBaKGnp6Un/v9A2s3a30QuAJGtv8W0tS0E+mVdRQMVMuFrMGpze9eJCzK87O+ALgbF
	5VfRJxreyuDRs42A==
X-Received: by 2002:ad4:5def:0:b0:91b:53e5:9263 with SMTP id 6a1803df08f44-91b55531337mr36208756d6.21.1791557416021;
        Fri, 09 Oct 2026 07:50:16 -0700 (PDT)
X-Received: by 2002:ad4:5def:0:b0:91b:53e5:9263 with SMTP id 6a1803df08f44-91b55531337mr36207516d6.21.1791557414875;
        Fri, 09 Oct 2026 07:50:14 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550dfb6csm20185456d6.45.2026.10.09.07.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:50:14 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [v3] fscache, cachefiles: Fix resize handling
Date: Fri,  9 Oct 2026 14:50:10 +0000
Message-Id: <20261009145010.2380147-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1091807.1791483394@warthog.procyon.org.uk>
References: <1091807.1791483394@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p77BgNW-Uesgikrs6KSzeBNL0eb9ITaViUCaNqIR6AM_1791557416
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi David,

Reviewed this on your netfs-next-5 tree. The resize helper it changes is not in our testing branch.

For Ceph this is the right split. ceph_fill_file_size() stores the new i_size before __ceph_do_pending_vmtruncate() trims the page cache and the cookie, so the worker can no longer see that the file shrank. i_truncate_shrank records size < isize at the truncate_seq bump. Without that, a truncate that is still above the stale cache size takes the grow path and leaves the backing tail in place.

IMHO the same flag is right for the other filesystems. AFS, 9p, and cifs_resize_file_locked() still have the old size at the call, so shrank is a direct comparison. The grow paths pass false, collapse passes true, and cachefiles shortens only when the caller says the file shrank and the backing file is actually larger.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

