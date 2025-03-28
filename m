Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A922F19
	for <v9fs@lists.linux.dev>; Fri, 28 Mar 2025 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167238; cv=none; b=oo739JKqP4cqBOlbflwxw9sfNlC6LYCcvA3/xjmlQ9dCmeRtyKHAmMnjkoTqjyULFTyX0SvFUpvwgLkn5pQPzLyFImSsewI/hs5ZhuJP+fbgpmpBMjMpN1QmuxQ0TjxCVSPdx7CsFhbQ84+ty19Gykiz+kF1s8QTJmGi5pnhOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167238; c=relaxed/simple;
	bh=jJSbhidB4wtrA44KDjDfyYcFbDomkPCPcofw8Bs0CBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ork3DaqnW8+jdBBebvapaJx2sR9UhUgGksDA2ZFQ9VDwYK7Pn3hhlpr2VXMq7sxm6HtmbmKXAjWvL7CXcUnoFzLomv4Tirv3ZVguBBgDASsipA8eryOakEQIpi4dnWa9sSnnkk5ju3Jc+PFq+6i8gfIB7RAEeq4apMxzoo0VYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SM21I+OY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM21I+OY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743167235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jsbGK2j9zIC6mJ/vbpDwVvR2z0iK01j/LkGPGiz+mZM=;
	b=SM21I+OY50yCKhHCEma0hkZsZ8/pY/i0wBk0y+Jp2dZlI0yfoqr9niERGGE4VYlINaW6eR
	f+3c5jFx8qQEGAjARxfoSnl5rcB4qkP05TRl0mRKmIFPRpiB2sX+3sZ9eCVacpahD5nrKU
	wF65gKxHDaxxJ/tdAU0xygAqzt+wA6M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-1CIOfj-jMNCTUr9Jro5TdA-1; Fri,
 28 Mar 2025 09:07:11 -0400
X-MC-Unique: 1CIOfj-jMNCTUr9Jro5TdA-1
X-Mimecast-MFC-AGG-ID: 1CIOfj-jMNCTUr9Jro5TdA_1743167229
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45D681956075;
	Fri, 28 Mar 2025 13:07:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.74])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 309EC195DF83;
	Fri, 28 Mar 2025 13:07:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Mar 2025 14:06:34 +0100 (CET)
Date: Fri, 28 Mar 2025 14:06:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, ericvh@kernel.org,
	jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net, mjguzik@gmail.com, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250328130625.GA29527@redhat.com>
References: <377fbe51-2e56-4538-89c5-eb91c13a2559@amd.com>
 <67e5c0c7.050a0220.2f068f.004c.GAE@google.com>
 <Z-XOvkE-i2fEtRZS@codewreck.org>
 <49c26b3c-cab9-4ee6-919d-c734f4de6028@amd.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c26b3c-cab9-4ee6-919d-c734f4de6028@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/28, K Prateek Nayak wrote:
>
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -687,7 +687,13 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
>  	else
>  		n = p9_fd_poll(m->client, NULL, NULL);
> -	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
> +	/* Failed to send request */
> +	if (!(n & EPOLLOUT)) {
> +		p9_conn_cancel(m, -EIO);

Thanks a lot Prateek!

Can't really the changes in net/9p, but I am not sure. !(n & EPOLLOUT)
means that pipe is full, nothing wrong. We need to kick m->rq in this
case.

Dominique says:

	For me the problem isn't so much that this gets ERESTARTSYS but that it
	nevers gets to read the 7 bytes that are available?

Yes. Of course I do not pretend I fully understand the problem, but it
seems this is because p9_read_work() doesn't set Rworksched and doesn't
do schedule_work(&m->rq) if list_empty(&m->req_list).

However, if the pipe is full, before the commit aaec5a95d59615523db0
("pipe_read: don't wake up the writer if the pipe is still full"),
p9_read_work() -> p9_fd_read() -> kernel_read(ts->rd) triggered the
unnecessary wakeup. This wakeup calls p9_pollwake() shich kicks
p9_poll_workfn() -> p9_poll_mux(), and p9_poll_mux() will notice
EPOLLIN and schedule_work(&m->rq).

May be the patch below makes more sense?

Oleg.

#syz test: upstream

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 56e62978e502..aa9cd248a243 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -669,7 +669,6 @@ static void p9_poll_mux(struct p9_conn *m)
 
 static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 {
-	__poll_t n;
 	struct p9_trans_fd *ts = client->trans;
 	struct p9_conn *m = &ts->conn;
 
@@ -687,13 +686,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 	list_add_tail(&req->req_list, &m->unsent_req_list);
 	spin_unlock(&m->req_lock);
 
-	if (test_and_clear_bit(Wpending, &m->wsched))
-		n = EPOLLOUT;
-	else
-		n = p9_fd_poll(m->client, NULL, NULL);
-
-	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
-		schedule_work(&m->wq);
+	p9_poll_mux(m);
 
 	return 0;
 }

