Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5139E9BF
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069969; cv=none; b=mplfFNpzPIBDMcTExzVWl6OF0aRN75zIjajS69dxyJ6UXYCXzkSADY1ZvwJl10KrEdNgW9FxBX2NL3fnR6lt91yRU/WhKepwAdPS3/PHSfHvCVc0oDxU26k3y2vUi+7curzeYrTUnaThhNoRG51NOCmJbDfncH9mal9nVSBp6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069969; c=relaxed/simple;
	bh=OYXbkZRCmj0Vtl5yt/RR3TrcrmDsqtUig1eeG145l/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ppDEWR2ce/oHkKnP7UoBInO6c2iqLJez0ATCsa6TRHqu19iNPi/zPlSuvWqY/zxssC9pE6YPNpBQzXo9oOhhCFybYUmgmv30vzA92XHeOoYf5igKsji2JLMQYvI4pcU5Jn9dKkdFBxysslWI23LgK9M65dLLZvkbGDbqDL66cqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJVoGYNe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJVoGYNe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783069967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTpObJaVrcNKVP17RC5GvTDRVbm9gpukLCyO+TLMZDw=;
	b=GJVoGYNePU4mbqzVePPsEumnZ+5ZCPJIJuV4L+pIIPktxTlvfcXL8DjcOuingUL8eauxFI
	cghjdpQU0BUP0E3ph1aiK0oIqi2xEGLs/0Y9nZQtMrbUbYyPMkr0vYNTfjvm6PRM299g9X
	PsbuFd57QGQw+/9VgpU+OvlaiexwmVA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-9YYX7aaFNKqs5ORfOGdoJw-1; Fri, 03 Jul 2026 05:12:46 -0400
X-MC-Unique: 9YYX7aaFNKqs5ORfOGdoJw-1
X-Mimecast-MFC-AGG-ID: 9YYX7aaFNKqs5ORfOGdoJw_1783069965
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493b786d550so3502615e9.0
        for <v9fs@lists.linux.dev>; Fri, 03 Jul 2026 02:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783069965; x=1783674765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTpObJaVrcNKVP17RC5GvTDRVbm9gpukLCyO+TLMZDw=;
        b=dpJRpp18JwqpTkD6Lvb7s2//RNEtZmNkq0uVjPVw7jQqjiJxNmQi2KTK6d1y0qzVsK
         bGFgCtuNxZuI0i1vQC+Msr5ENputBRtH3msPU8dvB4Xt3iclZoC6VqxHBRKZPqF9pFQE
         KA2uRKj50BcQW1LMAjYBFY7cmpJ7odQutsRA0mTsVUEoc0aAlkTTWlLjtSkUkVjrHfp5
         6Ev6fKRNe8oVEQjg9dpUr7qu7dwezGe6yyplsQFPb4KOi6sFz2Ba+ScqeXDrWlaqx3RN
         LX4/duHTjKE1rLm8mELDPtVrL8d9S0FFXmnre0eG91IemadDS12YCevlprKz1zVteIuE
         r1eA==
X-Forwarded-Encrypted: i=1; AFNElJ/flV0cTmGekz4byuSRc7Mj5G/JzCN8dH/vom9R+LG8/NmZ6DbM3bPweMhcizf6k4T+a8r/@lists.linux.dev
X-Gm-Message-State: AOJu0YwnHf8NQRhn7gE/x5eZKymCGcDTEfvAWuU2iUung6+3PtR3J2ES
	j1rd/E3UlbUJJOu2loIauuLmdiAN2fIkrz6ZdEWoR4GoGO5fINC4rhKigG3sB2PocvjCCZ76vif
	Qp2MGT03dFgZIEVEbwrHCc+nuRz7D4rqmnj7TMLIrNzr6jEZKnj4Qytc=
X-Gm-Gg: AfdE7ckolPcDmr4z5T8xO9LadRi2ewJaeo0BW1bpHUAgSJzk5yFWe3oTpJbXGAMogex
	vT+MCExWXaSMUdtPozU90FSLAoXydxMP9m+R0uzr2GLgPnDuhqEk6sGHhjc90JU7L/pzGojFhAM
	d8osOX5CJqbM65H4N9JjzNWF/it+jmw8jsoPGp9B/QKNoF4xZIv/KTgQczVyv0CIKlzsblcIhZZ
	2HA+2civLErbjtqkRhKdyYuAZTDC1wgW0g9O3lfBlqHBY2H9dGlrEJ7e/FF1yDb0ot2VpirAJIE
	VqVC34zax8iGc/JrMXzwRfzM2Foy9jqztFAQhKtftBCDeSGZRcJ8Knc9LnXIbmWgZUn2CsE71eR
	OHrALIoEy5etrhKBL0HUrhoP2AzpetxyeqLS5uM4Rdi7elX9et5obt9Vkw45u
X-Received: by 2002:a05:600c:8715:b0:493:bed7:6d7c with SMTP id 5b1f17b1804b1-493c2b8943dmr130142255e9.25.1783069964669;
        Fri, 03 Jul 2026 02:12:44 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:493:bed7:6d7c with SMTP id 5b1f17b1804b1-493c2b8943dmr130141635e9.25.1783069963996;
        Fri, 03 Jul 2026 02:12:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dba0esm15938954f8f.7.2026.07.03.02.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 02:12:43 -0700 (PDT)
Date: Fri, 3 Jul 2026 11:12:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: skvarlamatus@gmail.com
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org, 
	linux_oss@crudebyte.com, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stefanha@redhat.com
Subject: Re: [PATCH v2] net/9p: add vsock transport
Message-ID: <akd7QliTAWpkmE0Q@sgarzare-redhat>
References: <20260701155922.95502-1-skvarlamatus@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260701155922.95502-1-skvarlamatus@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dEi5wZjfi9BPImt3lp6qvTajHQ4dEBiRwC3i5_sMy-E_1783069965
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 01, 2026 at 05:59:22PM +0200, skvarlamatus@gmail.com wrote:
>From: Matus Skvarla <skvarlamatus@gmail.com>
>
>Add vsock as a transport option for 9P client connections. This
>allows mounting 9P filesystems over VM sockets without requiring TCP/IP
>networking or additional userspace tools.
>
>The implementation extends trans_fd.c with vsock support, reusing the
>existing socket infrastructure. A new p9_fd_create_vsock() function
>handles vsock connection setup by parsing the CID from the mount source,
>creating an AF_VSOCK socket, and connecting to the specified endpoint.
>All other transport operations (close, request, cancel) use the shared
>fd transport implementation.
>
>The privport mount option is not currently supported for vsock and
>returns -EOPNOTSUPP if specified.

Why not?

I'm no expert on 9p; it's just out of curiosity.

>
>Add CONFIG_NET_9P_VSOCK option that conditionally compiles vsock support
>into 9pnet_fd.ko. This follows the pattern where socket-based transports
>(TCP, Unix, vsock) share trans_fd.c, while specialized hardware transports
>(virtio, xen, rdma) have dedicated files.
>
>Usage:
>  mount -t 9p -o trans=vsock[,port=<port>] <CID> /mnt/point
>
>Signed-off-by: Matus Skvarla <skvarlamatus@gmail.com>
>---
>Changes in v2:
>  - Add depends on NET_9P_FD to Kconfig
>  - Use #include <uapi/linux/vm_sockets.h>
>  - Reject privport option with -EOPNOTSUPP
>  - Use fc->net_ns instead of current->nsproxy->net_ns
>  - Widen vsock port to u32 to match sockaddr_vm.svm_port
>  - Widen p9_fd_opts.port to u32 and port_str buffer accordingly (in p9_fd_create_tcp())
>  - Add vsock to Documentation/filesystems/9p.rst
>Link to v1: https://lore.kernel.org/v9fs/20260527073447.86538-1-skvarlamatus@gmail.com/
>---
> Documentation/filesystems/9p.rst | 12 +++-
> include/net/9p/client.h          | 10 +++-
> net/9p/Kconfig                   | 10 ++++
> net/9p/trans_fd.c                | 97 +++++++++++++++++++++++++++++++-
> 4 files changed, 124 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
>index 3f65db648db0..d1bac30b3c9d 100644
>--- a/Documentation/filesystems/9p.rst
>+++ b/Documentation/filesystems/9p.rst
>@@ -50,6 +50,14 @@ mount points. Each 9P export is seen by the client as a virtio device with an
> associated "mount_tag" property. Available mount tags can be
> seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_tag files.
>
>+For server accessible over vsock (VM sockets)::
>+
>+	mount -t 9p -o trans=vsock <CID> /mnt/9
>+
>+where CID is the vsock Context ID of the remote endpoint (2 for host from
>+a guest VM, 3+ for guest VMs from the host). The port to connect to can be
>+specified with the port option (default: 564).
>+
> USBG Usage
> ==========
>
>@@ -115,8 +123,10 @@ Options
> 			========  ============================================
> 			unix 	  specifying a named pipe mount point
> 			tcp	  specifying a normal TCP/IP connection
>-			fd   	  used passed file descriptors for connection
>+			fd   	  uses passed file descriptors for connection

nit: unrelated change?

The rest LGTM, so for vsock point of view:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

