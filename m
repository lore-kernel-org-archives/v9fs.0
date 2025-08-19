Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5E248896
	for <v9fs@lists.linux.dev>; Tue, 19 Aug 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620106; cv=none; b=jcRRoaaCPdOBMFHzTlY12NfPOebUWXMqqUi4L8zx1dd7sG4BsNvZh9HVycvc4h4L1tI2q3xKmT+XDcsZ9yqs2Tr5fHjlHo6Z5ZHPTUE+LEHSgwujl/5wHB8xZcRc55e4Sx+0/XffJ4QBhb5LhnPkPQE8UEblH0Ukb7zDx4b0/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620106; c=relaxed/simple;
	bh=kr+F4blUg6FODR+2BQWkkRgkHiFy8Hzr+twDnZG4NyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnYhTjipIuKd4cn1z1Ev2+PewqUDgA8vcEm7mtd5mtcZLYkuXtnYYOJBG3W3h5Y1MYMNzX5aoZKE6T3+r7TyJKgXfgd0XN+t8+WgqA5PKzKB3E9J3wzcInuqT9wGNZMgfTMaIbVQjFzCaXMUW6J6TADFySlkAqZ65fT2191yhQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8JQcS13; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8JQcS13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755620104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kr+F4blUg6FODR+2BQWkkRgkHiFy8Hzr+twDnZG4NyI=;
	b=E8JQcS132o+/U5oNwTeM4KyAtLSY+jlin8vPIG+XKfTGaQYu9PW1pKY/pjvY8deVSa4yJE
	u7TnMXfym0gUp0brzlMKFFWC+qigM0mVCPg0pRlluyN9/UbeO19RuCGwBuIPqP1zc+NtV3
	KejO+mqfCTXrPW8Nm6yKiG5bdHGEJag=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-3o2EMjNHMyeBJ5Vh3nX_AA-1; Tue,
 19 Aug 2025 12:14:59 -0400
X-MC-Unique: 3o2EMjNHMyeBJ5Vh3nX_AA-1
X-Mimecast-MFC-AGG-ID: 3o2EMjNHMyeBJ5Vh3nX_AA_1755620096
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4928A180036E;
	Tue, 19 Aug 2025 16:14:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.95])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AF8BF18004A3;
	Tue, 19 Aug 2025 16:14:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Aug 2025 18:13:37 +0200 (CEST)
Date: Tue, 19 Aug 2025 18:13:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	syzbot <syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, dvyukov@google.com,
	elver@google.com, glider@google.com, jack@suse.cz,
	kasan-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	willy@infradead.org, v9fs@lists.linux.dev,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN
Message-ID: <20250819161329.GC11345@redhat.com>
References: <68a2de8f.050a0220.e29e5.0097.GAE@google.com>
 <20250819161013.GB11345@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819161013.GB11345@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/19, Oleg Nesterov wrote:
>
> Reported-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
> Tested-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68a2de8f.050a0220.e29e5.0097.GAE@google.com/
> Link: https://lore.kernel.org/all/67dedd2f.050a0220.31a16b.003f.GAE@google.com/
> Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Prateek, I turned your "Reviewed-by" from the previous discussion
https://lore.kernel.org/all/67dedd2f.050a0220.31a16b.003f.GAE@google.com/
into Co-developed-by + Signed-off-by, I hope you won't object?

Oleg.

