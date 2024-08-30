Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BEB4D8AD;
	Fri, 30 Aug 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030981; cv=none; b=p00Eav8CM2fUdHEZH8yWCmQ1OlzZPsq7/RslNjhiwQe87vEcGo9l48DVagn6MAdqFIqoQWUY586SzlRT2GiTGQvscRFe1Bx+ZGRe5jEHPf4M056Kzr8ysr3Px/JsJ3vFxuuC1BWcCUBZwhhEb+QkGRYB83mq5Iv6ZhXncLZ8r2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030981; c=relaxed/simple;
	bh=/CToR2noGOmvfazw9DBbjHmDtYon0YLhA9vEC/k1uIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0w+gePoNbQ7LIDCwUlyWMO5POz0rD5Gu7948WZs2IkLJ6P2yiyjClEHQBu25LZu7nA6Twg9dKDeyj9Gwc8fiNzk0cHDO3PLSKwvV/4kn/Scer7H4JBAy+pl1GHHkpzEZZxg+m5W9CscWr1f2R2sj8lnRjcaJlCnNhqw09TfCo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dE3YC7Yi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dE3YC7Yi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725030979; x=1756566979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/CToR2noGOmvfazw9DBbjHmDtYon0YLhA9vEC/k1uIs=;
  b=dE3YC7YiVH2idPYGqYNN2Cj/bj7z4cVPykoqREcc7wb/Y/H2AB6YaRGU
   M7JlvbY8w2CrqnQRxt1hZPm77G102OVFtA83Ia/SnxzT9UuZTtiWmaBl+
   ytC0aeRVWlFwM0YT1qWdjJz2jF1GRZ9Z1hFnJNwh8mFHVa27CzX2khPA0
   ppiOb/tZEw74yoU1HMqMgSIQuxwpHNWmo4F2vMIDC9tUL69//3etQ4Ajg
   UZBNw56gJ2kzV6FWdWLdlG/aZemv1GDRvjN9/glMDhZyJNNBtHvrnoBE2
   OaC+qAfMP5Slb7/JdS2qudbyMCUTi5yJNGvwSiXXLW6jyWTlAyNQvRwUS
   g==;
X-CSE-ConnectionGUID: T6LiRbLeT5CXQFFonfGpvg==
X-CSE-MsgGUID: XnQQ5+0jQ7WvLISQYM14OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34343609"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34343609"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 08:16:18 -0700
X-CSE-ConnectionGUID: 7lCWqmbKSfCRo2rYoIM5mA==
X-CSE-MsgGUID: zyJK6N7QTpeG04QKnMQBow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="94736036"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Aug 2024 08:16:15 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk3MC-0001Ze-2l;
	Fri, 30 Aug 2024 15:16:12 +0000
Date: Fri, 30 Aug 2024 23:15:40 +0800
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
Subject: Re: [PATCH v10 2/3] net/9p/usbg: Add new usb gadget function
 transport
Message-ID: <202408302200.rlcB6d6K-lkp@intel.com>
References: <20240116-ml-topic-u9p-v10-2-a85fdeac2c52@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v10-2-a85fdeac2c52@pengutronix.de>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-linus]
[also build test WARNING on linus/master v6.11-rc5]
[cannot apply to usb/usb-testing usb/usb-next ericvh-v9fs/for-next next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Grzeschik/net-9p-usbg-Add-new-usb-gadget-function-transport/20240827-064810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-linus
patch link:    https://lore.kernel.org/r/20240116-ml-topic-u9p-v10-2-a85fdeac2c52%40pengutronix.de
patch subject: [PATCH v10 2/3] net/9p/usbg: Add new usb gadget function transport
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240830/202408302200.rlcB6d6K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408302200.rlcB6d6K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408302200.rlcB6d6K-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/9p/trans_usbg.c: In function 'p9_usbg_create':
>> net/9p/trans_usbg.c:373:30: warning: variable 'f' set but not used [-Wunused-but-set-variable]
     373 |         struct usb_function *f;
         |                              ^


vim +/f +373 net/9p/trans_usbg.c

   368	
   369	static int p9_usbg_create(struct p9_client *client, const char *devname, char *args)
   370	{
   371		struct f_usb9pfs_dev *dev;
   372		struct f_usb9pfs *usb9pfs;
 > 373		struct usb_function *f;
   374		int ret = -ENOENT;
   375		int found = 0;
   376	
   377		if (!devname)
   378			return -EINVAL;
   379	
   380		guard(mutex)(&usb9pfs_lock);
   381	
   382		list_for_each_entry(dev, &usbg_instance_list, usb9pfs_instance) {
   383			if (!strncmp(devname, dev->tag, strlen(devname))) {
   384				if (!dev->inuse) {
   385					dev->inuse = true;
   386					found = 1;
   387					break;
   388				}
   389				ret = -EBUSY;
   390				break;
   391			}
   392		}
   393	
   394		if (!found) {
   395			pr_err("no channels available for device %s\n", devname);
   396			return ret;
   397		}
   398	
   399		usb9pfs = dev->usb9pfs;
   400		if (!usb9pfs)
   401			return -EINVAL;
   402	
   403		f = &usb9pfs->function;
   404	
   405		client->trans = (void *)usb9pfs;
   406		if (!usb9pfs->in_req)
   407			client->status = Disconnected;
   408		else
   409			client->status = Connected;
   410		usb9pfs->client = client;
   411	
   412		client->trans_mod->maxsize = usb9pfs->buflen;
   413	
   414		complete(&usb9pfs->received);
   415	
   416		return 0;
   417	}
   418	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
