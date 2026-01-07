Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342C3328FE
	for <v9fs@lists.linux.dev>; Wed,  7 Jan 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816179; cv=none; b=mk/f4gQdlGRfSIZ4kxNq+Mv67Pyo6DiXeHzbdB8CKel0CADUCz/bABiY4HgbCEIxAjHY0t9qoL+234csghnrUg3W4O62OvkrPc3pRvBOutibJpJl8EQ5S6YSS2hg2k4A0VsY4YHef4DdDuZ5Ap3pTUjfnDGES0LXMfg2VoeWCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816179; c=relaxed/simple;
	bh=EdqLmR/vTtC4shURYZcRG3MXX8+nwq4eJKZlphnjnDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxfbEy7UfRoVFFFVXJxgBHII8uAs2bxxhzc+Z4w4ytBtDT3VDLI0uSpjXQPpU7OiOnZuD47cRYFwetDMzhVQuw3GadEukQTuvxoYvDJdlJlE3XlSH2Ywn4ya+ESkT7VEckbf+hPbcACyRK16gXMq6T8IaHuuNj200dGA8GaPHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/C7Lrm8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/C7Lrm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767816174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWr/kTdOxY1MciDgOv6CTkiIz612rQ5gPdJwgdkLMw4=;
	b=K/C7Lrm8FmDPfbhfh+tWtu/zLMI86UFhiLdJBaa7P0rf1q4lRqIhUd3JFFoq3tBRDTSJ23
	9lpurAiPI5dzrsLTQ8m/D4nXDewfFalOV3lt23EEINpCi/o5eYYnnKNycfS1Ry1vsE6PMH
	FoxQm7IneOLPBow/TW9iFEwTPiUsBjQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-Vjx2pUfnOsu_12uKVxdlGw-1; Wed, 07 Jan 2026 15:02:53 -0500
X-MC-Unique: Vjx2pUfnOsu_12uKVxdlGw-1
X-Mimecast-MFC-AGG-ID: Vjx2pUfnOsu_12uKVxdlGw_1767816172
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78e602d09a7so27831497b3.3
        for <v9fs@lists.linux.dev>; Wed, 07 Jan 2026 12:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767816172; x=1768420972;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu+APFi4DB1BEixYf1NERY7bmC13ljDpUozQin2rblQ=;
        b=lc2tD/2o3N2RXzetriOunNPDooAe0aj3bV7hbtD3wTb3hHaz9RZnqtBScO/FrYqOAE
         PckyCxfk0tINHCPCQpL5G9jMt0zJRWhrStma3E78j+kEza6CG+RZXAe+JJwTNYUXrd1k
         yms4yNnJJIeoLWWZnIMXr0olnWotQ2gCrXnYlpjCud1FQNCdRtRt1biddzjDtVlPQiu0
         fG5SEPxFFrKwNP7nGeLFw7yB/r9YKy4b/qQucP2IiKVLANuird+B4lFMqElgIrjvWHlq
         KxQP6boA880qKA2OsIOdKbvgqwnqLTPb20ZKQI4GEGQdvnEv/9GP9lKCaWX2A6VkidVK
         +KGA==
X-Forwarded-Encrypted: i=1; AJvYcCWO6Lg752k+zetWdo5IeaRJpKKT6QkilwL14QxmVxiIUG9SLCDiFLhhG9x3UkG8S42zpZ49@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr/p+ryGg8BOHHJ01vkAVeK7XmXdNV7jmtjfP+Caik4kBouEf6
	iNCB/Nj0jWjzusHTfGYajkWBXuYPJFzmS3n9JK+AeMD1itVlBfHoo++rUr7C4ofMn2juVIKeN/J
	peJ6kRAmSqHFAwEHQkFaYyHuSq+i5oJvXGa8XVmVjeL+0fWdo7jem8/k=
X-Gm-Gg: AY/fxX6UcXr94lMfTayR1RiyKUDHrxeqpl+dNE0+T/m0XJNSWmp20gLRm8FuJS44HB9
	u4W4XYHLDLjnJ6dq4//7yCmoyW5VS9wkYo4EDg1IOhpLpY9ne9TUsH3BtJXTK9B3FfOypkvsvIO
	iE7hpF2+fyej8u16myydRKeZhinb27uNZoGxnOazmac5bv8vu3NHIVCNgUjlEH3u7eqCXgiCkT0
	7hj8eNFUu8b2h7J8++rtOJXOnt3rEmtaxLtpFlxKrUXudR0A+q4AYOurpyQDzKBSiEGfbngigVC
	nJpHh05k8lKKqgA+4hb4qGdAgLh/z9QdBW9yJqdvXomXXBymu2G3zcNAauB8NGw/SSVDMXIEAVT
	U0lOsl5yTwRIdU8aTkNGVipyAvyOsC3TvKzTaxsCL
X-Received: by 2002:a05:690c:6002:b0:78c:8cf2:e1a8 with SMTP id 00721157ae682-790b57fd697mr35186517b3.41.1767816172481;
        Wed, 07 Jan 2026 12:02:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFtanv8xfnFTTRT6tEbrRIY8LovgzhbuRiJibqFx8Wg+Ad59na27viUk0nz6iFz80kLE3f9Q==
X-Received: by 2002:a05:690c:6002:b0:78c:8cf2:e1a8 with SMTP id 00721157ae682-790b57fd697mr35186317b3.41.1767816172118;
        Wed, 07 Jan 2026 12:02:52 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa5534f2sm22153297b3.10.2026.01.07.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 12:02:51 -0800 (PST)
Message-ID: <591f69efdf89ba02c36b042faa3486eca0cec76d.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH 5/6] ceph: don't allow delegations to be set
 on directories
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>,  Al Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Steve French <sfrench@samba.org>,  Paulo Alcantara	
 <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam
 Prasad N	 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM	
 <bharathsm@microsoft.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker	 <anna@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov	 <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, Xiubo Li	 <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Hans de Goede	 <hansg@kernel.org>,
 NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, gfs2@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Wed, 07 Jan 2026 12:02:49 -0800
In-Reply-To: <20260107-setlease-6-19-v1-5-85f034abcc57@kernel.org>
References: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
	 <20260107-setlease-6-19-v1-5-85f034abcc57@kernel.org>
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6sTzorvGym7mKgxnM5cOgmMPC9SZmXMLTRtCwk8XX2U_1767816172
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-01-07 at 09:20 -0500, Jeff Layton wrote:
> With the advent of directory leases, it's necessary to set the
> ->setlease() handler in directory file_operations to properly deny them.
>=20
> Fixes: e6d28ebc17eb ("filelock: push the S_ISREG check down to ->setlease=
 handlers")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/dir.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 86d7aa594ea99335af3e91a95c0a418fdc1b8a8a..804588524cd570078ba59bf38=
d2460950ca67daf 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -2214,6 +2214,7 @@ const struct file_operations ceph_dir_fops =3D {
>  =09.fsync =3D ceph_fsync,
>  =09.lock =3D ceph_lock,
>  =09.flock =3D ceph_flock,
> +=09.setlease =3D simple_nosetlease,
>  };
> =20
>  const struct file_operations ceph_snapdir_fops =3D {
> @@ -2221,6 +2222,7 @@ const struct file_operations ceph_snapdir_fops =3D =
{
>  =09.llseek =3D ceph_dir_llseek,
>  =09.open =3D ceph_open,
>  =09.release =3D ceph_release,
> +=09.setlease =3D simple_nosetlease,
>  };
> =20
>  const struct inode_operations ceph_dir_iops =3D {

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

