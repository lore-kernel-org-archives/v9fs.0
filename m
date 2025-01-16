Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7818FC8F
	for <v9fs@lists.linux.dev>; Thu, 16 Jan 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056818; cv=none; b=B/Y92O7qfxG4zGH1SLpOzME8ZWKzZ+nqcW3OvzpGicnRkX/xylIugVllh8PU4/zsaabAhYYkZusd2dXY7A7G+gswDLq7hq2B1VMpwVzsf+rlOAbXv7wdYDO42eng0349KRgXlNVdALpOAkKy4+gH6j2NoLNpEjaIgiPAu3yhkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056818; c=relaxed/simple;
	bh=1yndz/0IJx6eVmKW5OrNx+dBe4DGHK3wij1/OX3kiCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2P7/4VWSoESGTi3FTnHRbeDuxzusqKbv1tfte2JM4nHiQfgvwnOZu2AIY9ZCZNhtrS7RH9CRTGk2NPdgjf4LG9kloUoX+/734W0KaAl4vhWhW6oMoQrK9hUuztr3oQjOzYkM7dnoHg8nIo6SW3g6ohFnCEDAXRMQ8HbJxGNF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=xvooJbva; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="xvooJbva"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id DC58114C1E1;
	Thu, 16 Jan 2025 20:46:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1737056806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RmXprdE2GFAYWCznubaJa3px04qMAl2W32bQ8ZQRd1c=;
	b=xvooJbvaylftrx/Vq5H568/cRpU746LxZCAFgKgZ+4fjju8oTGCka9bK7w4f4L9qPiJiY9
	k2gylu4t9w0i6aixmOfIbrG64MPh3IBgvhsdZx5Up2GWJTQyJu7V5E1umKBJTjeZGiNuEG
	of+tIDsht7/LIdDcdOHBo1hjkebEUJUOdXuVjFO3aTmybszg/iYNTqsXs4LTKmkrYYwOdS
	x3kL2MhVvVkyh+y6sLaAF2n/mYP3w6IHcm8Ye0xY84rEwCBM+e5VzOoq+yiAb20UyaJ6JV
	zpr7r54fDOz1U9TKCOC/cPx829lseqHO+zuQG0EgHqreGO9dc0yZM8qSlRE6uQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c3cb4163;
	Thu, 16 Jan 2025 19:46:43 +0000 (UTC)
Date: Fri, 17 Jan 2025 04:46:28 +0900
From: asmadeus@codewreck.org
To: Joshua Murphy <joshuamurphy@posteo.net>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH] net/9p/fd: support ipv6 for trans=tcp
Message-ID: <Z4liFG9zHHHslkp6@codewreck.org>
References: <20250116160701.8024-3-joshuamurphy@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116160701.8024-3-joshuamurphy@posteo.net>

Joshua Murphy wrote on Thu, Jan 16, 2025 at 04:07:03PM +0000:
> Allows specifying an IPv6 address when mounting a remote 9p file system.

That was fast! Thank you!

A few comments below; I'll try to find time to test shortly once
addressed.

> Signed-off-by: Joshua Murphy <joshuamurphy@posteo.net>
> ---
>  net/9p/trans_fd.c | 50 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 196060dc6..effd0261d 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -11,6 +11,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/in.h>
> +#include <linux/in6.h>
>  #include <linux/module.h>
>  #include <linux/net.h>
>  #include <linux/ipv6.h>
> @@ -971,17 +972,24 @@ static inline int valid_ipaddr4(const char *buf)
>  	return 0;
>  }
>  
> -static int p9_bind_privport(struct socket *sock)
> +static int p9_bind_privport(struct socket *sock, int family)
>  {
> -	struct sockaddr_in cl;
> +	struct sockaddr_storage stor;
> +	struct sockaddr *cl = (struct sockaddr *) &stor;
>  	int port, err = -EINVAL;
>  
>  	memset(&cl, 0, sizeof(cl));

That memset is for sockaddr size, should it be for sockaddr_storage?

> -	cl.sin_family = AF_INET;
> -	cl.sin_addr.s_addr = htonl(INADDR_ANY);
> +	cl->sa_family = family;
> +	if (cl->sa_family == AF_INET)
> +		((struct sockaddr_in *) cl)->sin_addr.s_addr = htonl(INADDR_ANY);
> +	else
> +		((struct sockaddr_in6 *) cl)->sin6_addr = in6addr_any;
>  	for (port = p9_ipport_resv_max; port >= p9_ipport_resv_min; port--) {
> -		cl.sin_port = htons((ushort)port);
> -		err = kernel_bind(sock, (struct sockaddr *)&cl, sizeof(cl));
> +		if (cl->sa_family == AF_INET)
> +			((struct sockaddr_in *)cl)->sin_port = htons((ushort)port);
> +		else
> +			((struct sockaddr_in6 *)cl)->sin6_port = htons((ushort)port);
> +		err = kernel_bind(sock, cl, sizeof(cl));
>  		if (err != -EADDRINUSE)
>  			break;
>  	}
> @@ -994,24 +1002,34 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
>  {
>  	int err;
>  	struct socket *csocket;
> -	struct sockaddr_in sin_server;
> +	struct sockaddr_storage stor;
> +	struct sockaddr *sin_server = (struct sockaddr *) &stor;

not a new problem but I don't see this being initialized to zero either,
I'm not sure if there are cases where that can cause problems but it
might be just as well to init `stor = { 0 };` or equivalent just in
case?

>  	struct p9_fd_opts opts;
>  
>  	err = parse_opts(args, &opts);
>  	if (err < 0)
>  		return err;
>  
> -	if (addr == NULL || valid_ipaddr4(addr) < 0)
> +	if (addr == NULL)
> +		return -EINVAL;
> +
> +	if (valid_ipaddr4(addr) == 0) {

Hmmm, I wonder if we could just move rpc_pton somewhere and reuse
that... It's not that complex but it's certainly pure duplication...
But then I found `int_pton_with_scope`, that sounds like an even better
match as we probaly want inet6_pton more than in6_pton for local scope
identifiers:
Could you try to get rid of valid_ipaddr4 and call inet_pton_with_scope
with AF_UNSPEC directly? That should do Just What We Want (e.g. try v4
first and fallback to v6), up till filling sa_family and port directly
in the right field or failing if neither was valid.

(yes, sorry, give a hand and I'll grab the whole arm!)

> +		sin_server->sa_family = AF_INET;
> +		((struct sockaddr_in *) sin_server)->sin_addr.s_addr = in_aton(addr);
> +		((struct sockaddr_in *) sin_server)->sin_port = htons(opts.port);
> +	}
> +	else if (in6_pton(addr, -1, ((struct sockaddr_in6 *) sin_server)->sin6_addr.s6_addr, -1, NULL)) {
> +		sin_server->sa_family = AF_INET6;
> +		((struct sockaddr_in6 *) sin_server)->sin6_port = htons(opts.port);
> +	}
> +	else
>  		return -EINVAL;
>  
>  	csocket = NULL;
>  
>  	client->trans_opts.tcp.port = opts.port;
>  	client->trans_opts.tcp.privport = opts.privport;
> -	sin_server.sin_family = AF_INET;
> -	sin_server.sin_addr.s_addr = in_aton(addr);
> -	sin_server.sin_port = htons(opts.port);
> -	err = __sock_create(current->nsproxy->net_ns, PF_INET,
> +	err = __sock_create(current->nsproxy->net_ns, sin_server->sa_family,
>  			    SOCK_STREAM, IPPROTO_TCP, &csocket, 1);
>  	if (err) {
>  		pr_err("%s (%d): problem creating socket\n",
> @@ -1020,7 +1038,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
>  	}
>  
>  	if (opts.privport) {
> -		err = p9_bind_privport(csocket);
> +		err = p9_bind_privport(csocket, sin_server->sa_family);
>  		if (err < 0) {
>  			pr_err("%s (%d): problem binding to privport\n",
>  			       __func__, task_pid_nr(current));
> @@ -1029,9 +1047,9 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
>  		}
>  	}
>  
> -	err = READ_ONCE(csocket->ops)->connect(csocket,
> -				    (struct sockaddr *)&sin_server,
> -				    sizeof(struct sockaddr_in), 0);
> +	err = READ_ONCE(csocket->ops)->connect(csocket, sin_server,
> +					       sizeof(stor), 0);
> +
>  	if (err < 0) {
>  		pr_err("%s (%d): problem connecting socket to %s\n",
>  		       __func__, task_pid_nr(current), addr);

-- 
Dominique Martinet | Asmadeus
