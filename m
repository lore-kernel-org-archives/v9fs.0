Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591F54785;
	Fri,  3 Jul 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093631; cv=none; b=DoC5L9G933QCU2UN8C42zL1HN8ldeYdfbyHnK5IbpifH7V5im9RqsDvkclwqa1D+IHlE4P2ta63gLSONcvH86dTlwsuVRAEbaPjsM47RSCNp4+hXT6Ru7DqINfkRK6Ap4clw2gkvfW6TGJT9dHF89/GqFGU9Ny3h5n6GJtZy1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093631; c=relaxed/simple;
	bh=Rv1Rf07/5G8ZHCa1NcsYTUuzs5DOal8Bqb9q5OjJxXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+qzVKPkur84cNOD3G+YfNQ/Ae+krFFdk2L8ihXe2oO3LGnavLyiamVnd1vP5MFX4XImmJK9UXbRDJDetkWpR1HD6ZANVHnBlAWFA+JE84zGemCk+nectyHGWuf2EMtvTknguWvKcV6VFcm82ZZ6HgXnkCkmqgxpYbT6To80opk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=AvKRG2le; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="AvKRG2le"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=DIsXCV9qjmanPKNVgpMGlx8XZlt9xnowLh8jTe4nwqM=; b=AvKRG2lexRTfwD5kzSo3FtnhoF
	PkXQcdfDO6aYn+6dlmPZcDEkfdUQWrgvu7ZqL+bk87pb1OW5aE75oixEUOVO6LgJNHJKjpLft9arg
	v8fofTMVW5D65SDwgqHXpKA9rhq/RrlizHA+jWI5KCgOnUz9xKhJU4NZ11cO92lPdJPB4fNJlpyiJ
	NP9apm8s5DFoVSIMq1HeBD2mYqYpCU8CiAc/c8dK52/tu8W3MJsS3kClTgxIN5ixcRV03V6aYLfPx
	7eCx/XxVSDYm044TdHo5WAdwlioXj99gglVeNWUwCAftmqHyn5Qd9ZVjhwyhum47zdB64d+5nQP6K
	X1Swz+r79RaFxFeITkXzPM43sy9ANW3dP2Si7TnPJAsn/1aiPvxHFuG/K4OrPqFbBCClmGu4hDX4g
	8bUkDu0rP1y8fRzBDJLbqDhxE9Z6Ds04RtHI0t43GVs6TaOTylafdJekIQgVCX3idx7AJoXEo8FK5
	WzCEp+jv94rvkE71QqddMy9Z0TRBN6u4GvzurIn2t12RxG671OuhZXCyAQwSFNeKOkPwRHZix6nmF
	bAqAhC7kYEvB1NYNHx4cBC8Ne5CzXY+h+RKpDSXH4QMXlmcKLGgF1fUlL6F3CQzND3duzY79u9uzb
	H6sXd3Mh74HXGtOZFYNuGePPz153JSQn8b92gEaac=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v4] 9p/trans_virtio: reject mount tags longer than NAME_MAX at
 probe
Date: Fri, 03 Jul 2026 17:14:01 +0200
Message-ID: <4770766.cEBGB3zze1@weasel>
In-Reply-To: <20260627211012.4042372-1-michael.bommarito@gmail.com>
References:
 <20260626111906.801890-1-michael.bommarito@gmail.com>
 <20260627211012.4042372-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 27 June 2026 23:10:12 CEST Michael Bommarito wrote:
> p9_virtio_probe() reads a 16-bit mount tag length (tag_len) from the
> device config and kzalloc()s tag_len + 1 bytes for chan->tag with no
> upper bound. A malicious or compromised host can present a tag of up to
> 65535 bytes; that tag is later copied into the single-page sysfs buffer
> by p9_mount_tag_show() (memcpy(buf, chan->tag, tag_len + 1)), a
> host-controlled out-of-bounds write of up to ~64 KiB past the PAGE_SIZE
> attribute buffer.
> 
> Reject an overlong tag at probe time. A 9p mount tag is a name-like
> identifier, so bound it by NAME_MAX (255): that limit is independent of
> the sysfs/seq_file page size and is far above any legitimate mount tag,
> which keeps p9_mount_tag_show() safe at the root without hard-coding a
> seq_file implementation detail.
> 
> Fixes: 179a5bc4b8cb ("net/9p: use memcpy() instead of snprintf() in
> p9_mount_tag_show()") Cc: stable@vger.kernel.org
> Suggested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
> v4: bound tag_len by NAME_MAX (255) instead of PAGE_SIZE, per Christian
>     Schoenebeck's review of v3 -- a 9p mount tag is a name-like identifier,
> and NAME_MAX avoids hard-coding the seq_file page-size implementation
> detail (which could change and silently break the bound) and resolves the
> off-by-one he noted.
> v3: reject at probe time (PAGE_SIZE) instead of truncating in show().
> v2: sysfs_emit() in show() -- dropped; probe-time rejection preferred.
> v1: bound the show() copy.
> 
> Build-tested ARCH=um (net/9p/trans_virtio.o, W=1, clean; NAME_MAX resolves
> with no new include). The original ~64 KiB OOB write was reproduced
> pre-fix; with the probe bound a tag_len > 255 device is refused, so the
> show handler never sees an out-of-page tag.
> 
>  net/9p/trans_virtio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index b0d0094ec8e2c..9fa63e3ebf673 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -633,6 +633,11 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  		err = -EINVAL;
>  		goto out_free_vq;
>  	}
> +	if (tag_len > NAME_MAX) {
> +		dev_err(&vdev->dev, "mount tag too long (%u bytes)\n", tag_len);
> +		err = -EINVAL;
> +		goto out_free_vq;
> +	}
>  	tag = kzalloc(tag_len + 1, GFP_KERNEL);
>  	if (!tag) {
>  		err = -ENOMEM;
> 
> base-commit: 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4


