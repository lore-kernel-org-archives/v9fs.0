Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F0634EB
	for <v9fs@lists.linux.dev>; Thu, 25 Jan 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191925; cv=none; b=gz/sbW5pg6/fC4ArF9qkBomRLgrSv50yvFs4xXVmwSQs8IKUbd5avssasuRuaMpQhzoH2RfHAPO5QtqgJMX83b3IeQeptIbYCZ69Lrp/vbEEGFvOuGmHDwnR7HJkHCOoLciWAfakOyJJ9MlDrz1PgGsqdH6XyN76Sh/SZqWvTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191925; c=relaxed/simple;
	bh=E87yYMUmIZQHj4uCon05JeVlBr+VAITmiBQh7svNdRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nE16CcDQGNSSq5v1wj8NMvD+J3EVQEpP9ASmzhiPfujnm3N90mjtVBbyV5HiU2pqvPFsa6SloKcXCuZKxU7LD9XNpcRNJDUvie/FFR0ato9lgI4s3sTe1xVruBF6mPtEepKoaQi4G+fQ7uLBgSpxnwDvggOJHGNQfRND8629oOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NieLKX/U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NieLKX/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706191922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACqcEjg537hZBJWAT4QAy+L6J3AJYKEx3L1s6N7xY70=;
	b=NieLKX/UX8/kUky3wzVmk2R8DK1IRNo3hE9cib+UOSVxtU2E2/EH8SGLLpaL64SF/+N7Sv
	+MDT8+jmO2w3MmT5rj9XFFJLwjjIJt9wocHgjPCeoSYBthoK1tJ3JbztfJr1YVp6S8MS3j
	8kz5Y5puU+IZMgpSOdLmmRE75O2dKQw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-Ton7HokXPSWRswBc5p_IDw-1; Thu,
 25 Jan 2024 09:11:59 -0500
X-MC-Unique: Ton7HokXPSWRswBc5p_IDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A4A21C0BA46;
	Thu, 25 Jan 2024 14:11:58 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 060CB51D5;
	Thu, 25 Jan 2024 14:11:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Gao Xiang <xiang@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Eric Sandeen <esandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
Date: Thu, 25 Jan 2024 09:11:54 -0500
Message-ID: <B01D6639-6F09-4542-A1CE-5023D059B84F@redhat.com>
In-Reply-To: <520668.1706191347@warthog.procyon.org.uk>
References: <520668.1706191347@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 25 Jan 2024, at 9:02, David Howells wrote:
...
> NFS.  NFS at the very least needs to be altered to give up the use of
> PG_private_2.

Forgive what may be a naive question, but where is NFS using PG_private_2?

Ben

