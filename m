Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2C343896
	for <v9fs@lists.linux.dev>; Thu, 28 May 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982786; cv=none; b=pzFBHObEvlmUBOv83CNFGhHgVRfb4aQB8pOqyS6em/fAJXz3pqOunY6InAHZn3dAbXO0uDbE8064khWUe/JHUHy99yk83xSvLcRKZxKm4PxVdF4SuJ6YoOop9fcDyp+Up3vUv+OozhmBfW6TIkGX8yKK3+Y0gWdmiyaLanslU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982786; c=relaxed/simple;
	bh=T17YT6Trij2o82he4vP6UPG8X3Ow0HdS5Qxp6G5B8Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrb1+kiqAdB4ln7IUZ9kEokGgpn4O1RGBob09VymCxygZwWOV6Dqw7pCGmwC1qLYtsP1A8kEu/ncmlic6tQs4V3xk/Hwca7Mc6gI085khbKi/6IF+VSGmKNVB/BZ+vkGyma8Snd4NtacJ8wfQqis/Af0Hs1vfgRQAGDB2x7uaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaM7P/T7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaM7P/T7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779982785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9T1R4aHkni96xuKFICzq8s+aIOMuJcyuxaX5Fv8qoM=;
	b=aaM7P/T7mvX/G+kCpRhV/ZFgOZo/H0XAm3WpC1+2SS6KhqECwkffQPExXbgSqWxbxctrWr
	VEkOARBV/12hvcKkGfTWBIvUFZnFfrBbgSPHnxTGQLO1dKsVk4AKW3/WR+5NBtbDDDtoJl
	GN9Kx7dCnh2uBqyx+Ije/JNOWXQYvMc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-mDG2qC5BOBG06r0S7nAXYg-1; Thu,
 28 May 2026 11:39:38 -0400
X-MC-Unique: mDG2qC5BOBG06r0S7nAXYg-1
X-Mimecast-MFC-AGG-ID: mDG2qC5BOBG06r0S7nAXYg_1779982777
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 703821956046;
	Thu, 28 May 2026 15:39:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.62])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3353F1800465;
	Thu, 28 May 2026 15:39:35 +0000 (UTC)
Date: Thu, 28 May 2026 11:39:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: skvarlamatus@gmail.com
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
	linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [PATCH] net/9p: add vsock transport
Message-ID: <20260528153931.GA52916@fedora>
References: <20260527073447.86538-1-skvarlamatus@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4WWBzVM1ux0roUOO"
Content-Disposition: inline
In-Reply-To: <20260527073447.86538-1-skvarlamatus@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--4WWBzVM1ux0roUOO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 09:34:47AM +0200, skvarlamatus@gmail.com wrote:
> From: Matus Skvarla <skvarlamatus@gmail.com>
>=20
> Add vsock as a transport option for 9P client connections. This
> allows mounting 9P filesystems over VM sockets without requiring TCP/IP
> networking or additional userspace tools.
>=20
> The implementation extends trans_fd.c with vsock support, reusing the
> existing socket infrastructure. A new p9_fd_create_vsock() function
> handles vsock connection setup by parsing the CID from the mount source,
> creating an AF_VSOCK socket, and connecting to the specified endpoint.
> All other transport operations (close, request, cancel) use the shared
> fd transport implementation.
>=20
> Add CONFIG_NET_9P_VSOCK option that conditionally compiles vsock support
> into 9pnet_fd.ko. This follows the pattern where socket-based transports
> (TCP, Unix, vsock) share trans_fd.c, while specialized hardware transports
> (virtio, xen, rdma) have dedicated files.
>=20
> Usage:
>   mount -t 9p -o trans=3Dvsock[,port=3D<port>] <CID> /mnt/point
>=20
> Signed-off-by: Matus Skvarla <skvarlamatus@gmail.com>
> ---
>  include/net/9p/client.h |  6 ++-
>  net/9p/Kconfig          |  9 +++++
>  net/9p/trans_fd.c       | 89 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 103 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 838a94218b59..4eb2f6b22496 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -122,8 +122,12 @@ struct p9_client {
>  		struct {
>  			u16 port;
>  			bool privport;
> -
>  		} tcp;
> +#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
> +		struct {
> +			u16 port;
> +		} vsock;
> +#endif
>  	} trans_opts;
> =20
>  	struct idr fids;
> diff --git a/net/9p/Kconfig b/net/9p/Kconfig
> index 22f8c167845d..63a5b5b25063 100644
> --- a/net/9p/Kconfig
> +++ b/net/9p/Kconfig
> @@ -32,6 +32,15 @@ config NET_9P_VIRTIO
>  	  This builds support for a transports between
>  	  guest partitions and a host partition.
> =20
> +config NET_9P_VSOCK
> +	depends on VSOCKETS

This must depend on NET_9P_FD too.

> +	bool "9P VSOCK Transport"
> +	help
> +	  This builds support for a transport for 9pfs over
> +	  virtual sockets (vsock). This is useful for communication
> +	  between virtual machines and their host without requiring
> +	  TCP/IP networking configuration or additional userspace software.

The way that trans_fd.c is structured right now still requires
CONFIG_INET and CONFIG_UNIX even if you only want the VSOCK transport.
If someone wanted to build a really minimal kernel in the future, then
it would be necessary to separate some of the code. This is not a
serious issue since TCP/IP and UNIX domain sockets are very standard
kernel features that most systems cannot do without, but I wanted to
mention it.

> +
>  config NET_9P_XEN
>  	depends on XEN
>  	select XEN_XENBUS_FRONTEND
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index dbad3213ba84..6f35f2d84313 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -28,6 +28,9 @@
>  #include <net/9p/9p.h>
>  #include <net/9p/client.h>
>  #include <net/9p/transport.h>
> +#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
> +#include <linux/vm_sockets.h>
> +#endif

Kernel code uses #include <uapi/linux/vm_sockets.h> rather than the
userspace <linux/vm_sockets.h> include path:

  $ git grep vm_sockets.h
  ...
  include/net/af_vsock.h:#include <uapi/linux/vm_sockets.h>
  include/net/vsock_addr.h:#include <uapi/linux/vm_sockets.h>
  net/vmw_vsock/af_vsock.c:#include <uapi/linux/vm_sockets.h>
  ...

> =20
>  #include <linux/syscalls.h> /* killme */
> =20
> @@ -36,6 +39,9 @@
> =20
>  static struct p9_trans_module p9_tcp_trans;
>  static struct p9_trans_module p9_fd_trans;
> +#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
> +static struct p9_trans_module p9_vsock_trans;
> +#endif
> =20
>  enum {
>  	Rworksched =3D 1,		/* read work scheduled or running */
> @@ -714,6 +720,12 @@ static int p9_fd_show_options(struct seq_file *m, st=
ruct p9_client *clnt)
>  		if (clnt->trans_opts.fd.wfd !=3D ~0)
>  			seq_printf(m, ",wfd=3D%u", clnt->trans_opts.fd.wfd);
>  	}
> +#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
> +	else if (clnt->trans_mod =3D=3D &p9_vsock_trans) {
> +		if (clnt->trans_opts.vsock.port !=3D P9_FD_PORT)
> +			seq_printf(m, ",port=3D%u", clnt->trans_opts.vsock.port);
> +	}
> +#endif
>  	return 0;
>  }
> =20
> @@ -968,6 +980,60 @@ p9_fd_create_unix(struct p9_client *client, struct f=
s_context *fc)
>  	return p9_socket_open(client, csocket);
>  }
> =20
> +#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
> +static int
> +p9_fd_create_vsock(struct p9_client *client, struct fs_context *fc)
> +{
> +	const char *addr =3D fc->source;
> +	struct v9fs_context *ctx =3D fc->fs_private;
> +	int err;
> +	struct socket *csocket;
> +	struct sockaddr_vm addr_vm =3D { 0 };
> +	struct p9_fd_opts opts;
> +	unsigned int cid;
> +
> +	/* opts are already parsed in context */
> +	opts =3D ctx->fd_opts;
> +
> +	if (!addr)
> +		return -EINVAL;
> +
> +	err =3D kstrtouint(addr, 10, &cid);
> +	if (err < 0) {
> +		pr_err("%s (%d): invalid CID: %s\n",
> +		       __func__, task_pid_nr(current), addr);
> +		return err;
> +	}
> +
> +	csocket =3D NULL;
> +
> +	client->trans_opts.vsock.port =3D opts.port;
> +	err =3D __sock_create(current->nsproxy->net_ns, AF_VSOCK,
> +			    SOCK_STREAM, 0, &csocket, 1);
> +	if (err) {
> +		pr_err("%s (%d): problem creating socket\n",
> +		       __func__, task_pid_nr(current));
> +		return err;
> +	}

AF_VSOCK reserves ports below 1024 for privileged processes. It probably
makes sense to implement the same privport option that TCP and RDMA also
support. If you don't want to implement that, then enabling the privport
option should cause an error here.

> +
> +	addr_vm.svm_family =3D AF_VSOCK;
> +	addr_vm.svm_port =3D opts.port;
> +	addr_vm.svm_cid =3D cid;
> +
> +	err =3D READ_ONCE(csocket->ops)->connect(csocket,
> +					       (struct sockaddr_unsized *)&addr_vm,
> +					       sizeof(addr_vm), 0);
> +	if (err < 0) {
> +		pr_err("%s (%d): problem connecting socket to %s:%u\n",
> +		       __func__, task_pid_nr(current), addr, opts.port);
> +		sock_release(csocket);
> +		return err;
> +	}
> +
> +	return p9_socket_open(client, csocket);
> +}
> +#endif /* CONFIG_NET_9P_VSOCK */
> +
>  static int
>  p9_fd_create(struct p9_client *client, struct fs_context *fc)
>  {
> @@ -1038,6 +1104,23 @@ static struct p9_trans_module p9_fd_trans =3D {
>  };
>  MODULE_ALIAS_9P("fd");
> =20
> +#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
> +static struct p9_trans_module p9_vsock_trans =3D {
> +	.name =3D "vsock",
> +	.maxsize =3D MAX_SOCK_BUF,
> +	.def =3D false,
> +	.supports_vmalloc =3D true,
> +	.create =3D p9_fd_create_vsock,
> +	.close =3D p9_fd_close,
> +	.request =3D p9_fd_request,
> +	.cancel =3D p9_fd_cancel,
> +	.cancelled =3D p9_fd_cancelled,
> +	.show_options =3D p9_fd_show_options,
> +	.owner =3D THIS_MODULE,
> +};
> +MODULE_ALIAS_9P("vsock");
> +#endif
> +
>  /**
>   * p9_poll_workfn - poll worker thread
>   * @work: work queue
> @@ -1075,6 +1158,9 @@ static int __init p9_trans_fd_init(void)
>  	v9fs_register_trans(&p9_tcp_trans);
>  	v9fs_register_trans(&p9_unix_trans);
>  	v9fs_register_trans(&p9_fd_trans);
> +#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
> +	v9fs_register_trans(&p9_vsock_trans);
> +#endif
> =20
>  	return 0;
>  }
> @@ -1085,6 +1171,9 @@ static void __exit p9_trans_fd_exit(void)
>  	v9fs_unregister_trans(&p9_tcp_trans);
>  	v9fs_unregister_trans(&p9_unix_trans);
>  	v9fs_unregister_trans(&p9_fd_trans);
> +#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
> +	v9fs_unregister_trans(&p9_vsock_trans);
> +#endif
>  }
> =20
>  module_init(p9_trans_fd_init);
> --=20
> 2.47.1
>=20

--4WWBzVM1ux0roUOO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoYYbMACgkQnKSrs4Gr
c8hpwQf+NeWr0GaB9g3zU4M0eENfMtvYWHRQUU2b+M2Q4pVk08fyCdByJQsQDfCE
COeG+0Tzx1d35TJ+eA/7b2kz8ACZwfg7PyC3zXYTgzH290vQOKt4xlKI2RwiIYmU
yoLqfymd1nSuSWl4oYTKJTodhEDe+sBbFeBl6lZ4wJXDDybAfiBr5c1Jyu9jI3he
8nwpJv+tIIr+nLmLR91K9h8T5YpQit1jvD6YR6iil21TsIZsbg3jX+SZOgyYagzb
EFgqU+8NACP4VSwsn02AZlfkQya0Z6iEaYDcyp3erTbrz5zJoCDkvK/i806brIqN
6bzn1cu2tQ9kNkt9qKMrQHj6e4/Fqw==
=nYAv
-----END PGP SIGNATURE-----

--4WWBzVM1ux0roUOO--

