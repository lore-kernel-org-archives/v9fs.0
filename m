Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B07747F;
	Mon, 22 Jul 2024 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721614261; cv=none; b=KDzT5F7k3ssbTY9C9Au6ogc5xKdgVN+r2aseV7Ys5ptmhSACaLgOOJZU5w7YJu3M4Vp4IgT+osFARqoHa2/IYMUzcIAV7LbYVjC2w1M/Lvvv4A9hvg9OQQIFeULHPs4Ugz58e7RJF3C+TdtQ3Xs57W9v3KlWJu40udSykLsSJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721614261; c=relaxed/simple;
	bh=DqCgC/c3s9Favave3nv1YMDm0RGrEYC1Cxb9EP9Ys6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+WacmmOXxv6lnb8p3kpmTYtmFBk69ukNd7yML4wET+AVMaDjUYaD801ym2amMOc50i7u0KAAo7btia3Orvjj9SGOteq/l5urOS9BG2Ol/++omnZ24eaHhWA5xEt8oQ0yKKyLfBGi6eK16VNd2zb/5pJ1AHosC2KQzdDWOdUaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qync40Vh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qync40Vh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721614260; x=1753150260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DqCgC/c3s9Favave3nv1YMDm0RGrEYC1Cxb9EP9Ys6k=;
  b=Qync40VhwhrGpa7Y+j2UtqlrA39Sn0w6r36xiUy7TS2HlTUrtiqA4f7o
   bgY9QLvIFSukU136AQRcYhcCPD+hqUllhOq6P55C9aGtKIHgCIHNNDMlH
   GZu4/y5hJSilpme+jhJEcPD+QYQ52HkA1QNYsK63byvYP++/8g9TzmvD7
   MHvwtVjWvPrk4cMAOvbZopqtju1Tppp3W236CRXfKVSzgNwcXod5/IgnZ
   JmLtYsqkNZ3IZO7GwqasDx8sYpZfOFW/hVHFvpypQ2nifWqI7a10fA8er
   W6BrjkOzyOJYzJ7E3Au3QC3LDU7pHvJq4HTBeO58/+qt9evSq9ihVocE5
   Q==;
X-CSE-ConnectionGUID: gNnxYO7sR7KtXHaR3+6v3A==
X-CSE-MsgGUID: 5Iil3sbUTMG4bvzdeyF9xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19338588"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="19338588"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 19:10:59 -0700
X-CSE-ConnectionGUID: SbkeeR7FRKeBEK9JRb8tYQ==
X-CSE-MsgGUID: etfCb4j5Sl+lldNDKrRV0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="89177499"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 Jul 2024 19:10:56 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sViVo-000kno-2Q;
	Mon, 22 Jul 2024 02:10:52 +0000
Date: Mon, 22 Jul 2024 10:10:06 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH v8 2/3] net/9p/usbg: Add new usb gadget function transport
Message-ID: <202407220933.WQ9L15Zw-lkp@intel.com>
References: <20240116-ml-topic-u9p-v8-2-409e659ca4dd@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v8-2-409e659ca4dd@pengutronix.de>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2c9b3512402ed192d1f43f4531fb5da947e72bd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Grzeschik/usb-gadget-function-move-u_f-h-to-include-linux-usb-func_utils-h/20240722-070652
base:   2c9b3512402ed192d1f43f4531fb5da947e72bd0
patch link:    https://lore.kernel.org/r/20240116-ml-topic-u9p-v8-2-409e659ca4dd%40pengutronix.de
patch subject: [PATCH v8 2/3] net/9p/usbg: Add new usb gadget function transport
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20240722/202407220933.WQ9L15Zw-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240722/202407220933.WQ9L15Zw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407220933.WQ9L15Zw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/9p/trans_usbg.c: In function 'p9_usbg_create':
>> net/9p/trans_usbg.c:407:35: warning: variable 'cdev' set but not used [-Wunused-but-set-variable]
     407 |         struct usb_composite_dev *cdev;
         |                                   ^~~~


vim +/cdev +407 net/9p/trans_usbg.c

   404	
   405	static int p9_usbg_create(struct p9_client *client, const char *devname, char *args)
   406	{
 > 407		struct usb_composite_dev *cdev;
   408		struct f_usb9pfs_dev *dev;
   409		struct f_usb9pfs_dev *tmp;
   410		struct f_usb9pfs *usb9pfs;
   411		struct usb_function *f;
   412		int ret = -ENOENT;
   413		int found = 0;
   414	
   415		if (!devname)
   416			return -EINVAL;
   417	
   418		mutex_lock(&usb9pfs_lock);
   419		list_for_each_entry_safe(dev, tmp, &usbg_instance_list, usb9pfs_instance) {
   420			if (!strncmp(devname, dev->tag, strlen(devname))) {
   421				if (!dev->inuse) {
   422					dev->inuse = true;
   423					found = 1;
   424					break;
   425				}
   426				ret = -EBUSY;
   427				break;
   428			}
   429		}
   430	
   431		if (!found) {
   432			mutex_unlock(&usb9pfs_lock);
   433			pr_err("no channels available for device %s\n", devname);
   434			return ret;
   435		}
   436	
   437		usb9pfs = dev->usb9pfs;
   438		if (!usb9pfs) {
   439			mutex_unlock(&usb9pfs_lock);
   440			return -EINVAL;
   441		}
   442	
   443		INIT_LIST_HEAD(&usb9pfs->tx_req_list);
   444	
   445		f = &usb9pfs->function;
   446		cdev = f->config->cdev;
   447	
   448		client->trans = (void *)usb9pfs;
   449		if (!usb9pfs->in_req)
   450			client->status = Disconnected;
   451		else
   452			client->status = Connected;
   453		usb9pfs->client = client;
   454	
   455		client->trans_mod->maxsize = usb9pfs->buflen;
   456	
   457		mutex_unlock(&usb9pfs_lock);
   458	
   459		return 0;
   460	}
   461	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
