Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568961DFF7
	for <v9fs@lists.linux.dev>; Sat, 25 Jan 2025 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737774033; cv=none; b=G3opvKFYz5GOwncttp8zEuY3xkGMEK+p88O1uBAjsXwjlgLd7IstYB9JK9RT2ZmSYmQFzymOVA+ol3MQldn8cStsXjEWFa1tI/Tgu1g8ECueeasNAu0sJT/P7DnJGww26ukhyYY/AvxerQVfqFH8g9177KvA3PBmIcPmkbATepg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737774033; c=relaxed/simple;
	bh=nPoWs0j/FbVtMqDLEAceagWmK9YAB2D0+4SfkF1WfC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rQBd9CafSRJqDlIv3U/SWuhfnEEAmEhtRrh3/pxbH7APVL5yF3ZBEbt065UVg9qRxrjfGTyfR8pbhwcZ3Kf1MVyKUSnuQOW8PketQNoaQxOdc+UJSW6GPsZvGCgJw/PwmHnCpZCvci7vfozxGbOKH2vTDy3bqC7b5+YK3PlsHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=FheXAlG5; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="FheXAlG5"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C2FAB14C1E1;
	Sat, 25 Jan 2025 04:00:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1737774021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=O5f851qRREiHBVKHFyuMmfkoCAE7d1nG3HYdRKnU32A=;
	b=FheXAlG5GJ0MokHvtex7hbTGo5fnZB0FDD0UA54XEkSmWtvV4UOEzkIxsRvpGUBWWdzsOy
	tn4AqEgwjRH1LNsRwrxZ7WGqC7t4TfBn7OHG+67jn1LayPp2JWyPH9f3gO8qKoP9PxyBt+
	upGZgem6hg2dTrm1cSa3IMpXVqTMZQdMNDnNnC34uOz/GCvg7xza+bhO3n19YxRDjOXyFf
	YVWqazdGdqu7IXSAJEbDZxk05yAxgzsxvTsUfbnXTQ8OeFnaPY75WTkzYxW4Qbjr7VyZZy
	8XNL2CFsS5J+o2vaEHOVLxsgKLh89t7OI3rgW876D2fBLa9okmulZjfYiDGW2g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b39dda37;
	Sat, 25 Jan 2025 03:00:18 +0000 (UTC)
Date: Sat, 25 Jan 2025 12:00:03 +0900
From: asmadeus@codewreck.org
To: Joshua Murphy <joshuamurphy@posteo.net>,
	Daniel Verkamp <dverkamp@chromium.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH] net/9p/fd: change port to char *
Message-ID: <Z5RTs5XANcDxvZT0@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABVzXAnHmyXtsNPHrYDCubifhrGdDyy_W7=mX_FQ58Pwt1swFA@mail.gmail.com>
 <20250124211432.5698-3-joshuamurphy@posteo.net>

Joshua Murphy wrote on Fri, Jan 24, 2025 at 09:14:34PM +0000:
> The port variable in the option structs is changed to char * to
> remove the conversions from u16 to char *.
> 
> Signed-off-by: Joshua Murphy <joshuamurphy@posteo.net>
> ---
>  include/net/9p/client.h |  2 +-
>  net/9p/trans_fd.c       | 14 ++++++--------
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 4f785098c..62be2073e 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -114,7 +114,7 @@ struct p9_client {
>  			int wfd;
>  		} fd;
>  		struct {
> -			u16 port;
> +			char *port;
>  			bool privport;
>  
>  		} tcp;
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 2fea50bf0..2874c7348 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -31,7 +31,7 @@
>  
>  #include <linux/syscalls.h> /* killme */
>  
> -#define P9_PORT 564
> +#define P9_PORT "564"
>  #define MAX_SOCK_BUF (1024*1024)
>  #define MAXPOLLWADDR	2
>  
> @@ -49,7 +49,7 @@ static struct p9_trans_module p9_fd_trans;
>  struct p9_fd_opts {
>  	int rfd;
>  	int wfd;
> -	u16 port;
> +	char *port;
>  	bool privport;
>  };
>  
> @@ -746,8 +746,8 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
>  static int p9_fd_show_options(struct seq_file *m, struct p9_client *clnt)
>  {
>  	if (clnt->trans_mod == &p9_tcp_trans) {
> -		if (clnt->trans_opts.tcp.port != P9_PORT)
> -			seq_printf(m, ",port=%u", clnt->trans_opts.tcp.port);
> +		if (!strcmp(clnt->trans_opts.tcp.port, P9_PORT))

Daniel pointed out at the inverted check (thank you for these reviews!),
but it also needs a null check, because fd/fd_unix variants will not be
setting this field so the strcmp will crash with trans=fd or trans=unix

> +			seq_printf(m, ",port=%s", clnt->trans_opts.tcp.port);
>  	} else if (clnt->trans_mod == &p9_fd_trans) {
>  		if (clnt->trans_opts.fd.rfd != ~0)
>  			seq_printf(m, ",rfd=%u", clnt->trans_opts.fd.rfd);
> @@ -804,7 +804,7 @@ static int parse_opts(char *params, struct p9_fd_opts *opts)
>  		}
>  		switch (token) {
>  		case Opt_port:
> -			opts->port = option;
> +			opts->port = args[0].from;

This is a substring from tmp_options that will be freed when parsinig is
finished, so we'll need to kstrdup() it here, which means we'll need to
free it when we're done with options... So, err, at the end of
p9_fd_create which doesn't copy it to the client, and in p9_fd_close for
tcp success (stored in client), and in p9_fd_create_tcp on error
(fd_close not called), and I _think_ that's about it...

I didn't quite estimate the clean up path would be this messy, this
"simple cleanup" is ending up being more complicated than the originial
version so I'm thinking we're better off keeping the int -- what do you
think?

-- 
Dominique Martinet | Asmadeus
