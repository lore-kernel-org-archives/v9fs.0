Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3103B71CC;
	Fri, 26 Jun 2026 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479831; cv=none; b=s4LBY8AvZ5vL8rJ5m9W1f0HQTQ69PEesIWtqJow9xuTKiVSF86F17rHLEGpxAevFC9gpsLeod0PKr3UaOagNFPXISU2d9RD5PG2ai/DTtBfqAc+JH3k5eBzGC3o1GDAVfIsMDFD1BTQFqdZaTPLF6ybdJdGyQRLm/s+uhuxEsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479831; c=relaxed/simple;
	bh=vk+281fPAlMMk0Sya0V/bH11gRksWae8+V1I/vXXspQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jV2khv2LdC0+yE1Q4wmQqb6/DqryuNJGzoA+Gpbfdx4ZqbgHCPJQ9FBsLpdelhqePOkj+rgqPXWCMfcQ3R/Ap/PJnOgfgfZ5hmRGFTA6qLOiu+u/1o6M3kvUKKaT2MwIDTBLhlDEMs88zOygEu6MHUtjrm8RtZ+c2k9q8bLX/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=iS3GbbVa; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="iS3GbbVa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=/9fUOZG6pu9Q3z9mjFVpOoeDI6mViFC2FWrMNrDGrus=; b=iS3GbbVa1Z6uGafy/Gqfz2BkOe
	da8hTq9tu9wQH/1YHIH4biva+c1whP5hTKmrn6PKFA42FEa1iy0BTsv5MamInfmy20VwtH3LuOcqt
	FjdkNXS/lhI8Giqppr16ofKovi56F1iyR349ZTX0VQMY720GhqeW2YMMAi4D4DunUL43QvGZ7u02f
	pYbz1xE4ILQoqSMYXucEy+yEEBbuCurhglA1dnoqP7TQN09PbZBVTltzaANGG84qROqwTr6wWQ6/q
	ROJbq7PayufCnHB8BQfkpaRWjoEmi4x4MGVyKtw6P2rQ9TKZoqztn03Nj1XRJF1Qcj0KDbb0wdBYe
	i6N3WLLnKIQG4ZH2gD3KHJPVgAlhY6pIAkYjfs1XYVBWHsKieg21GtOezHMrSSW47TDOJbMg/wmI0
	5G7Y0KBvbKKsjtQGWuAO4qc4KKXvJ9b1HSc+GUVa3s8Ncgx4dAHbQyGsFT+b65vBhHFFKgXGDUXgr
	bZCImk20Ezub3eCku+01pTCEzN/eMYiBUQ2G0ETLpVdt2yKYh4aJqtyDPSR6CcTpEdlDCB5ePBLkB
	6oOEHGjs5eDX903ZDMKw+w6VxwjU491p+T1iR0mED6UNG0wkFfB6KE2lksSREneVMcn8/Oc8U7tJc
	/NDptOoqeg047kcXAVtq/FCopySP5IlrGdZ6hctMo=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] 9p/trans_virtio: reject mount tags that cannot fit a sysfs
 page
Date: Fri, 26 Jun 2026 14:34:31 +0200
Message-ID: <14038397.uLZWGnKmhe@weasel>
In-Reply-To: <20260626111906.801890-1-michael.bommarito@gmail.com>
References:
 <20260610114206.3749904-1-michael.bommarito@gmail.com>
 <20260626111906.801890-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 26 June 2026 13:19:06 CEST Michael Bommarito wrote:
> p9_virtio_probe() reads the mount tag length from the device's
> virtio_9p_config.tag_len, a 16-bit field, and accepts any value up to
> 65535 with no upper bound:
> 
> 	virtio_cread(vdev, struct virtio_9p_config, tag_len, &tag_len);
> 	...
> 	tag = kzalloc(tag_len + 1, GFP_KERNEL);
> 
> The tag is later emitted through the world-readable
> /sys/.../mount_tag attribute by p9_mount_tag_show(), which copies the
> whole NUL-terminated tag into the single PAGE_SIZE buffer that the
> sysfs core provides:
> 
> 	tag_len = strlen(chan->tag);
> 	memcpy(buf, chan->tag, tag_len + 1);
> 
> A tag longer than the page therefore overruns the sysfs buffer. Under
> the confidential-computing threat model, where the guest does not
> trust the host, a malicious or compromised host can advertise a
> ~64 KiB tag; the first read of mount_tag (udev reads it at probe) then
> copies host-controlled content past the end of the 4 KiB page, a slab
> out-of-bounds write.
[...]
>  net/9p/trans_virtio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index b0d0094ec8e2c..15568f40509c4 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -633,6 +633,11 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  		err = -EINVAL;
>  		goto out_free_vq;
>  	}
> +	if (tag_len >= PAGE_SIZE) {

That should be tag_len >= PAGE_SIZE - 1.

However you are still assuming and hard-coding an implementation specific
limit of seq_file. If that limit changes there, it breaks *silently* here
again.

I would rather handle this more aggressively by using NAME_MAX (255) as tag
length limit; safe and avoids complicated alternative solutions.

> +		dev_err(&vdev->dev, "mount tag too long (%u bytes)\n", tag_len);
> +		err = -EINVAL;
> +		goto out_free_vq;
> +	}
>  	tag = kzalloc(tag_len + 1, GFP_KERNEL);
>  	if (!tag) {
>  		err = -ENOMEM;
> 
> base-commit: 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4


