Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1201FDA
	for <v9fs@lists.linux.dev>; Sat, 26 Jul 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753538983; cv=none; b=UtaFSzPo1OLQe3R+rSoWBdh58TY97j+cYHc41Gds+/QMeBYJx5ysHH9kpkZx52MlrWjXamFASVGW6gVbIFr1lnayh8n198SouHDfaInp7+WAqAMZ8kEJ3iemx6k0H+OjcG1c+qOH0X5cXwQbHsWz7EweV+SQ1FHXvMIIGlUW7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753538983; c=relaxed/simple;
	bh=RLA1rEwvrN7u5zCLEB8KuDHJ7IDIoBzK9er8fw0Ccr4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=rSQvMSQCW3/iiick1m2DPssJGn+uNk+sjFm51AXk7iZvPL5jPT7j4BDpoLlTZ4GpHlEEYrFln2+pLkkJfE62OoFHRu01XcQPVQ/9Q7dhhCGGF4/VsOTXE8hn15fINdCOs8E0jPB2mn4y1n3YB1tIVekQDeJKxkio09Mg907VR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jADpHDk3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jADpHDk3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753538976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lxwu/gTwJWL5gSlwUWHVT20onXlaTf7AQbpyOWp3rT4=;
	b=jADpHDk3nGDyXPNPeEACaBWeQMlwSzJ31l7iyf4EUu9V/SwqXhqDtwyZKO1kJ+Skk62Di+
	8vATQO2T9WSJ4oaYYcDQNTSYqVg1OEUn2tgfj1S4GW4tUJsnEYvxds8zRMQQp2Os7G864C
	s0r873qazYugBsjDTFOBqMtvtpJVkkQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-rCgRp6yfNqCgGE4H2ry2nA-1; Sat,
 26 Jul 2025 10:09:35 -0400
X-MC-Unique: rCgRp6yfNqCgGE4H2ry2nA-1
X-Mimecast-MFC-AGG-ID: rCgRp6yfNqCgGE4H2ry2nA_1753538970
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 326A519560AD;
	Sat, 26 Jul 2025 14:09:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D107C195608D;
	Sat, 26 Jul 2025 14:09:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250724023325.16178-5-sandeen@redhat.com>
References: <20250724023325.16178-5-sandeen@redhat.com> <20250724023325.16178-1-sandeen@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: dhowells@redhat.com, v9fs@lists.linux.dev, ericvh@kernel.org,
    lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com
Subject: Re: [RFC PATCH 4/4] 9p: convert to the new mount API
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 15:09:25 +0100
Message-ID: <511061.1753538965@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fHY9B7iGG6i9ssAStn4F1YjS49OsTFDeDDZRd0NERtc_1753538970
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <511060.1753538965.1@warthog.procyon.org.uk>

Eric Sandeen <sandeen@redhat.com> wrote:

> +	case Opt_uname:
> +		kfree(v9ses_opts->uname);
> +		v9ses_opts->uname = param->string;
> +		param->string = NULL;

I wonder if it's worth using swap() for that:

		v9ses_opts->uname = swap(param->string, NULL);

> +		if (strcmp(s, "user") == 0)
> +			v9ses_opts->flags |= V9FS_ACCESS_USER;
> +		else if (strcmp(s, "any") == 0)
> +			v9ses_opts->flags |= V9FS_ACCESS_ANY;
> +		else if (strcmp(s, "client") == 0) {
> +			v9ses_opts->flags |= V9FS_ACCESS_CLIENT;
> +		} else {

Maybe put braces on all the clauses in that?

> +static void v9fs_free_fc(struct fs_context *fc)
> +{
> +	struct v9fs_context *ctx = fc->fs_private;

I would check that ctx isn't NULL.

> +static int v9fs_init_fs_context(struct fs_context *fc)
> +{
> +	struct v9fs_context	*ctx;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	/* initialize core options */
> +	ctx->v9ses.afid = ~0;
> +	ctx->v9ses.debug = 0;
> +	ctx->v9ses.cache = CACHE_NONE;
> +#ifdef CONFIG_9P_FSCACHE
> +	ctx->v9ses.cachetag = NULL;
> +#endif

You used kzalloc... ;-).

> +err_names:
> +	kfree(ctx->v9ses.uname);
> +	kfree(ctx->v9ses.aname);
> +	kfree(ctx);
> +	return -ENOMEM;
> +}

Instead of doing the freeing, you could just set ->need_free and if
->init_fs_context() returns an error, the context will be put and that will
invoke ->free().

David

