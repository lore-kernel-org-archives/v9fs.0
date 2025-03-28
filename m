Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C71386C9
	for <v9fs@lists.linux.dev>; Fri, 28 Mar 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167240; cv=none; b=ojrwpFH5nagIec9l8D8wExYc23756f1BPi0KAnpz13fGHbglO0HD2cJYlyLwnoLDhKcfjeU/XPmUuxr3ZlVEkzKYBnRBiTc79lPTv2ABSCH3dX7LkbMs/raug9oy46YKByof9sBRC9liQWizC0A404YwOIc3fcfrMtJCpLJQ53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167240; c=relaxed/simple;
	bh=18AGhfcFD+sl4i26F/8k9Hh0opJHcfcjgiWEpZ4Hmms=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=a6Y0ECt+E2E7pjSVPR2nSOGBtCgyVvxVbdQ1U8WX62dBzF+NpLq+8LatvGUHu9wKZPsfZy3U20BTDikSLQ7Rp5GbiAXZt0kGHKddYB6wb+yN/+KHhriRUulH5fJtXR3GKRnzOSRzfbZ7scmnzGUrj2LF6TfyQ4GFKjhxQC19rjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85dad56a6cbso355176439f.3
        for <v9fs@lists.linux.dev>; Fri, 28 Mar 2025 06:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743167237; x=1743772037;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAfoxNuGzgxWEJhmNYxQtIYzBWdfo5NXnHbxZV227/w=;
        b=B6cwgqEazSCXxVC51EVI21z+ATfo044hsXg9i1fj1Ftok50FIoKgP14zd4oH7E5PxQ
         cZQrHyzz1kLuduBcYhTOfGKTIosuHaePXQk4I1qkbTvnyQni54Ps8A5jaxZtlwc5wybc
         ZoXCEXQf/B+ZeyP4jEDo5mmFZ78BsKXlQPORe79aQLGBgXPSukxx5cJ+39zjvPXWutjZ
         Gk8Z9HA7PjoLJDXFozFURlSUsNYMG+bj2Md3ivVb8rIUbKCQFFZC6T7GN0yoq994Rcgh
         bonZRJDqCgHpLVTUeTD7RFJURR2lyO7k+slby+k+gkmXupH9MVzOmwzzn1q3iQaX9ekt
         4Rxw==
X-Forwarded-Encrypted: i=1; AJvYcCVXBpjoBSFEeZnIDbGuiq4y4jS7ZnnrIEfvQz0BfWOiZPNJyv3zr2gTZBQt6ddk9qKt0n8w@lists.linux.dev
X-Gm-Message-State: AOJu0YyKxXoFLZLOjzuh7Lk2TZHP09Hr+YclC6OpvAjWXltaL3GUvpqq
	TjAj1554rHhMPIJ4uIPv9WYf7POvayo2OwXBxCbBWNOev+uaGOpuiS1koARJWg2jGIABVriJ2rp
	j1kzP4j8YHH+LjrOAvrT+kg/KjYqqgGu2N2C+1ULXjX4J0WgyC8S0cew=
X-Google-Smtp-Source: AGHT+IH6wVHESQTV9mVYABBHu2hTRpjrYeIN5Cgm5PoFYmYHdyo7xs8FyaZWDWh5DyqNANWLt3eSJS0iHeMOnPsQ+2tkJmDtBYAO
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:3d4:6dcf:d8f5 with SMTP id
 e9e14a558f8ab-3d5ccdc1f92mr81410695ab.1.1743167236412; Fri, 28 Mar 2025
 06:07:16 -0700 (PDT)
Date: Fri, 28 Mar 2025 06:07:16 -0700
In-Reply-To: <20250328130625.GA29527@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e69f04.050a0220.2f068f.0076.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: oleg@redhat.com
Cc: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com, 
	netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

> On 03/28, K Prateek Nayak wrote:
>>
>> --- a/net/9p/trans_fd.c
>> +++ b/net/9p/trans_fd.c
>> @@ -687,7 +687,13 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
>>  	else
>>  		n = p9_fd_poll(m->client, NULL, NULL);
>> -	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
>> +	/* Failed to send request */
>> +	if (!(n & EPOLLOUT)) {
>> +		p9_conn_cancel(m, -EIO);
>
> Thanks a lot Prateek!
>
> Can't really the changes in net/9p, but I am not sure. !(n & EPOLLOUT)
> means that pipe is full, nothing wrong. We need to kick m->rq in this
> case.
>
> Dominique says:
>
> 	For me the problem isn't so much that this gets ERESTARTSYS but that it
> 	nevers gets to read the 7 bytes that are available?
>
> Yes. Of course I do not pretend I fully understand the problem, but it
> seems this is because p9_read_work() doesn't set Rworksched and doesn't
> do schedule_work(&m->rq) if list_empty(&m->req_list).
>
> However, if the pipe is full, before the commit aaec5a95d59615523db0
> ("pipe_read: don't wake up the writer if the pipe is still full"),
> p9_read_work() -> p9_fd_read() -> kernel_read(ts->rd) triggered the
> unnecessary wakeup. This wakeup calls p9_pollwake() shich kicks
> p9_poll_workfn() -> p9_poll_mux(), and p9_poll_mux() will notice
> EPOLLIN and schedule_work(&m->rq).
>
> May be the patch below makes more sense?
>
> Oleg.
>
> #syz test: upstream

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 56e62978e502..aa9cd248a243 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -669,7 +669,6 @@ static void p9_poll_mux(struct p9_conn *m)
>  
>  static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
>  {
> -	__poll_t n;
>  	struct p9_trans_fd *ts = client->trans;
>  	struct p9_conn *m = &ts->conn;
>  
> @@ -687,13 +686,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
>  	list_add_tail(&req->req_list, &m->unsent_req_list);
>  	spin_unlock(&m->req_lock);
>  
> -	if (test_and_clear_bit(Wpending, &m->wsched))
> -		n = EPOLLOUT;
> -	else
> -		n = p9_fd_poll(m->client, NULL, NULL);
> -
> -	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
> -		schedule_work(&m->wq);
> +	p9_poll_mux(m);
>  
>  	return 0;
>  }
>
