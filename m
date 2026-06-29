Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4593FDC0E;
	Mon, 29 Jun 2026 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734270; cv=none; b=q2qS+VHrW455L3QDTu8S0Z1hKTdobKk4jhjI1OBNGv6RoJGbAx2cq7ncT/jqkzF9KfnMztzFLacVchIkNpPcv8ZbqHcVyrUYscBeQ7DH42B1JkbHdApVB9/vVRqFU6SBdgpkleNXb9fsl36tyo2xh9LsKDLwzyEpgjoXl/vyzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734270; c=relaxed/simple;
	bh=NZqUfl1cZE1bkMxsFVuA4dW+8WY84xsrSDPum/dYfPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkt2JIF3/kPt8yYznlH+3vGe/QSIrBpKC2MY3AbOmmXowWHCnOuFM42YXSMM5lKKj3sR0XA5S1wKMq6+HVsdukpXSpkzah4+AJCbU+XBpuMSAbGMRBu148uaEL8RtOlaxBt08o3fSnmxViKNQlcE3WxxSrRDflVV7vFhOh1BwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJ2iKjr/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJ2iKjr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782734269; x=1814270269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NZqUfl1cZE1bkMxsFVuA4dW+8WY84xsrSDPum/dYfPo=;
  b=OJ2iKjr/6vxmEP3SvKs34OFDKveb33myjSiUzOUvp3qCNDkqMd1OwmdD
   qjZfaF3uA43szo2seFYmWzBETpbOvRYs/cQpDPdUL0SzVtME3S3XLkk6z
   EoFBLQm5zg8yN2f8338irwKHxYMNcBch7BKkSZEh3H8F3LoSo3ro/GU47
   ceQqDakXUK+6QvM+KGuDawSnrELQLCodCyjl8uGx7LRokPQgsA4HPDyGf
   uO/7EL0iPlLYbypgv9FkQhbIz1DetIeNee3zx9cLgFo6xUkJ/FhKbeh0A
   YtJpRujSJx9PVDVYVvfzdRQH+h3iyhlAyMjos8/ouscUsHPoBO/heFqay
   w==;
X-CSE-ConnectionGUID: pknV7gwXSAKi8+x0of2UoA==
X-CSE-MsgGUID: C7aaXP4HRPS78tcfK/dXdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="85967643"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="85967643"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:57:48 -0700
X-CSE-ConnectionGUID: uRvrpWgCR6CzXM98XFVcJg==
X-CSE-MsgGUID: 8ABGAF7oTV28855M5ELmPg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jun 2026 04:57:45 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1weAcQ-000000007Mj-2oxv;
	Mon, 29 Jun 2026 11:57:42 +0000
Date: Mon, 29 Jun 2026 19:57:04 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: oe-kbuild-all@lists.linux.dev, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] 9p/trans_virtio: reject mount tags that cannot fit a
 sysfs page
Message-ID: <202606291938.9FOZRc5c-lkp@intel.com>
References: <20260626111906.801890-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626111906.801890-1-michael.bommarito@gmail.com>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Bommarito/9p-trans_virtio-reject-mount-tags-that-cannot-fit-a-sysfs-page/20260629-093057
base:   4edcdefd4083ae04b1a5656f4be6cd83ae919ef4
patch link:    https://lore.kernel.org/r/20260626111906.801890-1-michael.bommarito%40gmail.com
patch subject: [PATCH v3] 9p/trans_virtio: reject mount tags that cannot fit a sysfs page
config: arm64-randconfig-r063-20260629 (https://download.01.org/0day-ci/archive/20260629/202606291938.9FOZRc5c-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260629/202606291938.9FOZRc5c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606291938.9FOZRc5c-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/9p/trans_virtio.c:636:14: warning: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
     636 |         if (tag_len >= PAGE_SIZE) {
         |             ~~~~~~~ ^  ~~~~~~~~~
   1 warning generated.


vim +636 net/9p/trans_virtio.c

   587	
   588	/**
   589	 * p9_virtio_probe - probe for existence of 9P virtio channels
   590	 * @vdev: virtio device to probe
   591	 *
   592	 * This probes for existing virtio channels.
   593	 *
   594	 */
   595	
   596	static int p9_virtio_probe(struct virtio_device *vdev)
   597	{
   598		__u16 tag_len;
   599		char *tag;
   600		int err;
   601		struct virtio_chan *chan;
   602	
   603		if (!vdev->config->get) {
   604			dev_err(&vdev->dev, "%s failure: config access disabled\n",
   605				__func__);
   606			return -EINVAL;
   607		}
   608	
   609		chan = kmalloc_obj(struct virtio_chan);
   610		if (!chan) {
   611			pr_err("Failed to allocate virtio 9P channel\n");
   612			err = -ENOMEM;
   613			goto fail;
   614		}
   615	
   616		chan->vdev = vdev;
   617	
   618		/* We expect one virtqueue, for requests. */
   619		chan->vq = virtio_find_single_vq(vdev, req_done, "requests");
   620		if (IS_ERR(chan->vq)) {
   621			err = PTR_ERR(chan->vq);
   622			goto out_free_chan;
   623		}
   624		chan->vq->vdev->priv = chan;
   625		spin_lock_init(&chan->lock);
   626	
   627		sg_init_table(chan->sg, VIRTQUEUE_NUM);
   628	
   629		chan->inuse = false;
   630		if (virtio_has_feature(vdev, VIRTIO_9P_MOUNT_TAG)) {
   631			virtio_cread(vdev, struct virtio_9p_config, tag_len, &tag_len);
   632		} else {
   633			err = -EINVAL;
   634			goto out_free_vq;
   635		}
 > 636		if (tag_len >= PAGE_SIZE) {
   637			dev_err(&vdev->dev, "mount tag too long (%u bytes)\n", tag_len);
   638			err = -EINVAL;
   639			goto out_free_vq;
   640		}
   641		tag = kzalloc(tag_len + 1, GFP_KERNEL);
   642		if (!tag) {
   643			err = -ENOMEM;
   644			goto out_free_vq;
   645		}
   646	
   647		virtio_cread_bytes(vdev, offsetof(struct virtio_9p_config, tag),
   648				   tag, tag_len);
   649		chan->tag = tag;
   650		err = sysfs_create_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);
   651		if (err) {
   652			goto out_free_tag;
   653		}
   654		chan->vc_wq = kmalloc_obj(wait_queue_head_t);
   655		if (!chan->vc_wq) {
   656			err = -ENOMEM;
   657			goto out_remove_file;
   658		}
   659		init_waitqueue_head(chan->vc_wq);
   660		chan->ring_bufs_avail = 1;
   661		/* Ceiling limit to avoid denial of service attacks */
   662		chan->p9_max_pages = nr_free_buffer_pages()/4;
   663	
   664		virtio_device_ready(vdev);
   665	
   666		mutex_lock(&virtio_9p_lock);
   667		list_add_tail(&chan->chan_list, &virtio_chan_list);
   668		mutex_unlock(&virtio_9p_lock);
   669	
   670		/* Let udev rules use the new mount_tag attribute. */
   671		kobject_uevent(&(vdev->dev.kobj), KOBJ_CHANGE);
   672	
   673		return 0;
   674	
   675	out_remove_file:
   676		sysfs_remove_file(&vdev->dev.kobj, &dev_attr_mount_tag.attr);
   677	out_free_tag:
   678		kfree(tag);
   679	out_free_vq:
   680		vdev->config->del_vqs(vdev);
   681	out_free_chan:
   682		kfree(chan);
   683	fail:
   684		return err;
   685	}
   686	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
