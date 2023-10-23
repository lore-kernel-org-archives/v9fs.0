Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DCC15EBF
	for <v9fs@lists.linux.dev>; Mon, 23 Oct 2023 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Tv6qq0Ff";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="F+TJdycl"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 7AE94C01C; Mon, 23 Oct 2023 14:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698065714; bh=OvVWLrUGhJVAxZCx/955CCt7646tJfq+nBVmL70GKIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tv6qq0FfdtIa0ETxo0gtZ0NVKEwTuTf6qX4QTdip3ILiE1QFJ5MfrUVbIAXJ+txZW
	 ztmhy8A2t4p1IQBsfVr668fWHM3ZdPu3PnXhC42y+SQpNgF4aOC66rzeC5oQT41VC9
	 1q168LrTJwi/7+KOHpQm5OYpI6aaZgKChZHVSMFvc9kuekCwN5Y/3GC5mcDiPgfAr6
	 Cif1xz7njKHZZ25gayE7Xdrd66L41GGkH6iA8ghLHhSgHS0LwPC6t76/IxApM0OpX4
	 A7lyZQoS4fXiqmEBt+7GlRS0uYKARVqdKHNBhAwY7DNrStzGeaktzkMHMCB9G0eQ2j
	 /jUnkj0UPROUw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 4BD9FC009;
	Mon, 23 Oct 2023 14:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698065713; bh=OvVWLrUGhJVAxZCx/955CCt7646tJfq+nBVmL70GKIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+TJdyclf75Zc4GwrXa7jJpmSl1BHz8cB4g1BSfdL4EnnE1GuANR22ymcQ9SARAct
	 4FFYxN1dTvRWH4PIFwT/3NJgelnFgbo9v2arJPzTQZJ0aoNOKAS/g0pXMFK1tas6Ev
	 P5xjKOL2PvrLt3SpGBtqFLZre/nW6q7rk3o4HgfmSrfX4u83ZAxd0NO3xj534ESHI4
	 QSzMY/QP6nGNWkmPlbyDzYqu26qd7FcXSEyQ+qvPy4eiMqYGoPBOolKO6Y9AZo3EJ8
	 j/zvQM3sUyghJ2u4NscatN5rdBYYBy5Uhi/+O1EQKSp8b2Q6h7oak9rGN32dWwK89E
	 uDthuwDHqTkGA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 50e0490b;
	Mon, 23 Oct 2023 12:55:08 +0000 (UTC)
Date: Mon, 23 Oct 2023 21:54:53 +0900
From: asmadeus@codewreck.org
To: Sishuai Gong <sishuai.system@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH] 9p/trans_fd: avoid sending req to a cancelled conn
Message-ID: <ZTZtHdqifXlWG8nN@codewreck.org>
References: <AA2DB53B-DFC7-4B88-9515-E4C9AFA6435D@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AA2DB53B-DFC7-4B88-9515-E4C9AFA6435D@gmail.com>

Sishuai Gong wrote on Tue, Aug 08, 2023 at 12:44:31PM -0400:
> When a connection is cancelled by p9_conn_cancel(), all requests on it
> should be cancelled---mark req->status as REQ_STATUS_ERROR. However,
> because a race over m->err between p9_conn_cancel() and p9_fd_request(),
> p9_fd_request might see the old value of m->err, think that the connection
> is NOT cancelled, and then add new requests to this cancelled connection.
> 
> Fixing this issue by lock-protecting the check on m->err.

Sorry for the (long) delay in reviewing this, and thanks for the patch!

I've got a bit of a mixed feelings on this, as there are other obviously
unlocked m->err accesses in the work functions and we don't really want
to take the req lock there everytime.. These should be ok in the normal
p9_conn_destroy that disarms poll and cancels work before calling
p9_conn_cancel, but the other calls to p9_conn_cancel are simiarly racy
and for example a cancel that'd be initiated by the write end could
process a new request in p9_read_work after the reqs have been drained
out...

On the the other hand, this is better than the current situation so I
think we should take it for now until someone has time to do better;
it's just leak in the unlikely case this race is hit but we might as
well close part of the problem.

I don't see how that'd break anything anyway, so I'll push this to my
next branch tomorrow after testing the rest of my patches.

> 
> Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
> ---
>  net/9p/trans_fd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 00b684616e8d..e43a850f5190 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -671,10 +671,14 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
> 
>  	p9_debug(P9_DEBUG_TRANS, "mux %p task %p tcall %p id %d\n",
>  		 m, current, &req->tc, req->tc.id);
> -	if (m->err < 0)
> -		return m->err;
> 
>  	spin_lock(&m->req_lock);
> +
> +	if (m->err < 0) {
> +		spin_unlock(&m->req_lock);
> +		return m->err;
> +	}
> +
>  	WRITE_ONCE(req->status, REQ_STATUS_UNSENT);
>  	list_add_tail(&req->req_list, &m->unsent_req_list);
>  	spin_unlock(&m->req_lock);
> —
> 
> 

-- 
Dominique Martinet | Asmadeus
