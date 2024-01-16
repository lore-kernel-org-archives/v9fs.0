Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D81CD04;
	Tue, 16 Jan 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428388; cv=none; b=kxq/2ysLsPWHvHGeUFWsQbBJu34v1PEd9iCpZQr6dFsXEC/YPA5EezqzDvrxIQjOH+g/3ePXyqvfg2OY9CEfy5BgTXVA9837WyY9GCc8N4jv+UpIjV+GmJ+aB+biisRKjVKcRjfY+SBn5NzKARtyRrfZ/B3EyWs2hQ7xkY3ps78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428388; c=relaxed/simple;
	bh=UX3kq6YtyE1PdEHxyUdmIdodg5pGEfTgztIGkSGO21A=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Rr/dpH8BlmXvtjU2TjdRtZg7XOoTqRBSLyelmqfnhyTzWlwgdwYD0DcbSVWtsLnjnJFiUSAppLmozzLv8zCXprPnQWu5SZc1Mm+FRojSgQzbuunyAuswNYbouqStp7dwQKAqbl4zIjcL8FEAtD7nPIfrTcg/MmSxW2bnqF7e3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXZnaAwB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXZnaAwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705428388; x=1736964388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UX3kq6YtyE1PdEHxyUdmIdodg5pGEfTgztIGkSGO21A=;
  b=jXZnaAwBHadPGV65xNBZ/H8bwkiXw1xXcvHPPUpxVoID3vaaApwv3Eq2
   pc9eyluZ/hTR4JqZ2y5Pe7MTDWu/VeOqj0X++ZnGInMzeF/y20OwJmd+N
   ob3N9H7sjhgSU6qbvy8e/lqgR/dKKepqM2ZLbBmgWSprKykP2ZbJMyV38
   9raZsIp1mM+jKLqzpqO1JZen647YE7fgbJ0MImtix6c8OLUZg+YRAZcaa
   yvmwymF0s8UnHzyGrFOQCZQYx08qZRUnOzVyhMqPaTB55RyHm/LCbioCc
   HqLdOc1b4YvC22FYyLb+pFNMqzdHhcqTs4Pszn4scvPfawDfF1RtmdzwT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6650936"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="6650936"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 10:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="18552426"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jan 2024 10:06:23 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPnpM-00012m-2R;
	Tue, 16 Jan 2024 18:06:20 +0000
Date: Wed, 17 Jan 2024 02:05:40 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH 2/3] usb: gadget: legacy: add 9pfs multi gadget
Message-ID: <202401170130.QaAJQe4j-lkp@intel.com>
References: <20240116-ml-topic-u9p-v1-2-ad8c306f9a4e@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v1-2-ad8c306f9a4e@pengutronix.de>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 052d534373b7ed33712a63d5e17b2b6cdbce84fd]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Grzeschik/usb-gadget-function-9pfs/20240116-095914
base:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
patch link:    https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-2-ad8c306f9a4e%40pengutronix.de
patch subject: [PATCH 2/3] usb: gadget: legacy: add 9pfs multi gadget
config: alpha-kismet-CONFIG_NET_9P-CONFIG_USB_9PFS-0-0 (https://download.01.org/0day-ci/archive/20240117/202401170130.QaAJQe4j-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240117/202401170130.QaAJQe4j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170130.QaAJQe4j-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for NET_9P when selected by USB_9PFS
   
   WARNING: unmet direct dependencies detected for NET_9P
     Depends on [n]: NET [=n]
     Selected by [y]:
     - USB_F_9PFS [=y] && USB_SUPPORT [=y] && USB_GADGET [=y]
     - USB_9PFS [=y] && USB_SUPPORT [=y] && USB_GADGET [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
