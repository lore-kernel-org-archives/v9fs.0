Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516B1D7994
	for <v9fs@lists.linux.dev>; Fri, 28 Mar 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186063; cv=none; b=YGXo2qcU0iQooCwpSbOCVPDF3nSsqR1F2uPsIlLKvay06M5npcxXw8+Js0eKbv0RSt5QJvKwD5/dMrzchVVkKO1CYaCf1vZOZR/wbPlWJi+54PYI4XoOAnqLZE3OPXM9TxwAOyV62YWCoyjgVVmUOAnDI4wTmGy3Ai8rrFd4BWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186063; c=relaxed/simple;
	bh=RflAqQK0UiKASqVIdkZflxaWM7HtW92Gh/JZzSfUr6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBikeJakoargzpa43hVmdt3TY7IFfq+KhfS2k9oXu5TwyxAj5VIcxAhjfoOkX7RVUWbKCxqCA4+q/wHpYq4ac7dNVzLj1Ai8auO6T0qHzcobavn8RALeAYip7u/wXexlhEWErkqMYZUNACNWDkzzXdonr9YMs4cqf+HBSGiwBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmTQgc/+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmTQgc/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743186060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RflAqQK0UiKASqVIdkZflxaWM7HtW92Gh/JZzSfUr6M=;
	b=hmTQgc/+zMbynmgA+PPBZDKprkjxot+MsPgdWwslKvYiWPoCnu+9IPbu8a5Vvbwxhfj2Z/
	L8KZjEe2zvmhACvpsKMp/Dl7qhQNN3KIZIQj8B8KJc0lytQAT6+U7VSPx+68jvwzZPzMqg
	B9R1y2Nsau0yATxxq+GGHicvWd4We9Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-Dw06vJc5P6KLU9A2zMXTdQ-1; Fri,
 28 Mar 2025 14:20:57 -0400
X-MC-Unique: Dw06vJc5P6KLU9A2zMXTdQ-1
X-Mimecast-MFC-AGG-ID: Dw06vJc5P6KLU9A2zMXTdQ_1743186055
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2029C19560B1;
	Fri, 28 Mar 2025 18:20:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 21A4E30001A1;
	Fri, 28 Mar 2025 18:20:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Mar 2025 19:20:20 +0100 (CET)
Date: Fri, 28 Mar 2025 19:20:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com,
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com,
	netfs@lists.linux.dev, swapnil.sapkal@amd.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250328182011.GE29527@redhat.com>
References: <20250328144928.GC29527@redhat.com>
 <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
 <20250328170011.GD29527@redhat.com>
 <314522ae-05a4-4dfb-af99-6bb3901a5522@amd.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314522ae-05a4-4dfb-af99-6bb3901a5522@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Prateek,

On 03/28, K Prateek Nayak wrote:
>
> Yours is the right approach.

OK, thank you, but lets wait for 9p maintainers.

but...

> If this gets picked, feel free to add:
>
> Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

No!

My version is just a slightly updated version of your initial patch.
It was you who (unless we both are wrong) actually pinpointed the
problem.

So. If this is acked by maintainers, please-please send the updated patch
with the changelog, and feel free to add my Reviewed-by or Acked-by.

Oleg.

