Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148E3C8724
	for <v9fs@lists.linux.dev>; Mon, 27 Apr 2026 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296485; cv=none; b=lGkQsbKw4E8vzyzGTFVYWa2DKyUIjH6vLRb18x30xRZqDg1qk7o/FHB4xS8oxyPWVi+PAL3NfBJSL2rlqMyZgNP2QaSESPZmMlLkTlGHLdzQK53abw7UGKiHCRR0T2kADs+b8w92jfOl7O/1chdocxzcSp/a2TaryI4jYScvCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296485; c=relaxed/simple;
	bh=U8w1lsPfuUGsefPLYyZkUTI+b1/xtzbb9XDDTEz0fR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Af0nbaKI10rjtDa1ZNwVLCtn4GUClx7GhT2QGarXVPb+YcpuIZrbZ/zXKqkZemgR+/JdysN7EmgN96UStDu6+4B5U7hUxO8ETBNtEkfbQLPbMEPbSjRpHJ1CDuOLSe1v9jKRl7L+Xx6GDBxyS3cpGh+tG8t9xwjMxkNLCBUq/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThcWN1ab; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThcWN1ab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777296481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUhgCt/hT7CJHj4DXtd1AoSh/+uk55Ss5eXjpceqVPM=;
	b=ThcWN1abrGl0pX1sbLye3OPpjCpNvnHdBe6+2SAfO7Uuc1TdzizPEcMSH8HZmJxifbXXLf
	MkhBmrSDg9Ms5IZzZLcjUc4MPrOi1pVOhwZh4W+T1+4rpw46DaJBnKNhEhrRp1ijHzxHup
	jHBfJOSCVwOm6C9t9O8kFXZIkGIATbY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-xvuMkHvJNe-8r8RECjYy7g-1; Mon,
 27 Apr 2026 09:27:59 -0400
X-MC-Unique: xvuMkHvJNe-8r8RECjYy7g-1
X-Mimecast-MFC-AGG-ID: xvuMkHvJNe-8r8RECjYy7g_1777296475
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66EE318002C6;
	Mon, 27 Apr 2026 13:27:53 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.48.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C3B3180047F;
	Mon, 27 Apr 2026 13:27:40 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  ceph-devel@vger.kernel.org,
  gfs2@lists.linux.dev,  linux-nfs@vger.kernel.org,
  linux-cifs@vger.kernel.org,  v9fs@lists.linux.dev,
  linux-kselftest@vger.kernel.org,  viro@zeniv.linux.org.uk,
  brauner@kernel.org,  jack@suse.cz,  jlayton@kernel.org,
  chuck.lever@oracle.com,  alex.aring@gmail.com,  arnd@arndb.de,
  adilger@dilger.ca,  mjguzik@gmail.com,  smfrench@gmail.com,
  richard.henderson@linaro.org,  mattst88@gmail.com,  linmag7@gmail.com,
  tsbogend@alpha.franken.de,  James.Bottomley@HansenPartnership.com,
  deller@gmx.de,  davem@davemloft.net,  andreas@gaisler.com,
  idryomov@gmail.com,  amarkuze@redhat.com,  slava@dubeyko.com,
  agruenba@redhat.com,  trondmy@kernel.org,  anna@kernel.org,
  sfrench@samba.org,  pc@manguebit.org,  ronniesahlberg@gmail.com,
  sprasad@microsoft.com,  tom@talpey.com,  bharathsm@microsoft.com,
  shuah@kernel.org,  miklos@szeredi.hu,  hansg@kernel.org
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
In-Reply-To: <20260328172314.45807-2-dorjoychy111@gmail.com> (Dorjoy
	Chowdhury's message of "Sat, 28 Mar 2026 23:22:22 +0600")
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
	<20260328172314.45807-2-dorjoychy111@gmail.com>
Date: Mon, 27 Apr 2026 15:27:37 +0200
Message-ID: <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: _jel3t4I0itBU-MM1TZEESMKHJ4AdrfifQzLJofPG-8_1777296475
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

* Dorjoy Chowdhury:

> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/=
errno.h
> index 92e7ae493ee3..bd78e69e0a43 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -122,4 +122,6 @@
> =20
>  #define EHWPOISON=09133=09/* Memory page has hardware error */
> =20
> +#define EFTYPE=09=09134=09/* Wrong file type for the intended operation =
*/
> +
>  #endif

This is what POSIX says about EFTYPE, in the Rationale for System
Interfaces:

=E2=80=9C
[EFTYPE]
    This error code was proposed in earlier proposals as "Inappropriate
    operation for file type", meaning that the operation requested is
    not appropriate for the file specified in the function call. This
    code was proposed, although the same idea was covered by [ENOTTY],
    because the connotations of the name would be misleading. It was
    pointed out that the fcntl() function uses the error code [EINVAL]
    for this notion, and hence all instances of [EFTYPE] were changed to
    this code.
=E2=80=9D

So I'm not sure if reusing this name is a good idea.

Thanks,
Florian

