Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D0330301
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057304; cv=none; b=EN7m3pLQvOTODFevMN2BUuCRC0OQx2oQ6ZTX7HM2GWSGwADqCjaLNuA+wK1Qisua1JBvjeMMxrEVZMLukP+fa98fN9Db4klGSaFSuAqG4y7nV3QxCsNqaap5nmB8U1TXT7URx39g5cl2KccjPOtke/Kf8NhqGJmbHXr5oj0W4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057304; c=relaxed/simple;
	bh=h+fQ99qrEfGvjKV0AR3JOEG4em0edW4iby5ipZEoibM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+IBUh6QQ5lGjhO9Hwts9wjRJH5bWiyKuiAJOka+z9rZ6u++jHebKpCF2e5CmvXl+U5DrTqfO62bui+eSxJ1SerCPBxv2qfFpoSxvwKqY0JYnTsanGp4bpOBUfsPw9ttL+QXMmg0PKLgtxUZojs+HBSM117Ob2PA+GKvUofCfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSPR15w4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSPR15w4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783057301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLp7JBppxrQNeK2bkAKu3qTx9JCltO+cf9OJPQmO7Is=;
	b=JSPR15w4k089YVMMvqAdopdpGG4uK4PWwtpUoa2bWHDI6AYTetrYzzKBEFv6XBN9vIsm2N
	aujtVWXgYQkZDUsyaPSYHogETBEGXMZKs5fY/bqZ+ZGwRIydymTz3v+Do9oHkw0dYIGgJm
	QzN8IcovZxzlizm5H9mfdnHs3D6blyE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-DBZLwBiUNoCms8btFa7OAQ-1; Fri,
 03 Jul 2026 01:41:38 -0400
X-MC-Unique: DBZLwBiUNoCms8btFa7OAQ-1
X-Mimecast-MFC-AGG-ID: DBZLwBiUNoCms8btFa7OAQ_1783057297
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57B3B193E8B1;
	Fri,  3 Jul 2026 05:41:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD2EE1800592;
	Fri,  3 Jul 2026 05:41:34 +0000 (UTC)
Date: Fri, 3 Jul 2026 07:41:33 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: skvarlamatus@gmail.com
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
	linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [PATCH v2] net/9p: add vsock transport
Message-ID: <20260703054133.GB448934@fedora>
References: <20260701155922.95502-1-skvarlamatus@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7+83Ftc4nKYQpn3M"
Content-Disposition: inline
In-Reply-To: <20260701155922.95502-1-skvarlamatus@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--7+83Ftc4nKYQpn3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 05:59:22PM +0200, skvarlamatus@gmail.com wrote:
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
> The privport mount option is not currently supported for vsock and
> returns -EOPNOTSUPP if specified.
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
> Changes in v2:
>   - Add depends on NET_9P_FD to Kconfig
>   - Use #include <uapi/linux/vm_sockets.h>
>   - Reject privport option with -EOPNOTSUPP
>   - Use fc->net_ns instead of current->nsproxy->net_ns
>   - Widen vsock port to u32 to match sockaddr_vm.svm_port
>   - Widen p9_fd_opts.port to u32 and port_str buffer accordingly (in p9_f=
d_create_tcp())
>   - Add vsock to Documentation/filesystems/9p.rst
> Link to v1: https://lore.kernel.org/v9fs/20260527073447.86538-1-skvarlama=
tus@gmail.com/
> ---
>  Documentation/filesystems/9p.rst | 12 +++-
>  include/net/9p/client.h          | 10 +++-
>  net/9p/Kconfig                   | 10 ++++
>  net/9p/trans_fd.c                | 97 +++++++++++++++++++++++++++++++-
>  4 files changed, 124 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems=
/9p.rst
> index 3f65db648db0..d1bac30b3c9d 100644
> --- a/Documentation/filesystems/9p.rst
> +++ b/Documentation/filesystems/9p.rst
> @@ -50,6 +50,14 @@ mount points. Each 9P export is seen by the client as =
a virtio device with an
>  associated "mount_tag" property. Available mount tags can be
>  seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_tag=
 files.
> =20
> +For server accessible over vsock (VM sockets)::
> +
> +	mount -t 9p -o trans=3Dvsock <CID> /mnt/9

If you respin this patch, please add the port=3D option because it is
absent from this example and it could be missed if one doesn't read the
paragraph below carefully:

  mount -t 9p -o trans=3Dvsock[,port=3D<port>] <CID> /mnt/9

Other than that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7+83Ftc4nKYQpn3M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpHS40ACgkQnKSrs4Gr
c8jW4wf/RNJsWNQHO3OkT+F6Ic6uLAOH3Kh05rIv0UnodXFsTyK1MfqOiYOedI01
I2tAhOU3DB3sW13b78tlOB22FCc2sN5l9UMQB58UkdrKJIPX5JaTdzwosuMASIRo
t0k7ctM2TETGhIqn0FwxsFs5dUXmdQJDkRjXqfbL/udVhr+OiBn6faT7bxwO/PLH
fjtEVDT8No++IF1Fyw+cXXjHCD/az/jshxdyOs8Lih8W835vNO8SFLVlXgEZRQ1Z
qJwjjNLxrOAOfCdbpMUu5VkyNBPnTGh8qVxBVdvJrV6HM/RbL/5aDc0GkO8Rz18C
xknZPlvBRQSHcKaLyg6PP8TVbJVS/A==
=R738
-----END PGP SIGNATURE-----

--7+83Ftc4nKYQpn3M--

