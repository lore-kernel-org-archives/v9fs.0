Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81189175A5;
	Thu, 23 May 2024 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716495948; cv=none; b=Ehi/R6Na2eogxSSKCokY/+TBVLZlHGTczVZuKHKqxAXhfkUZcdXmLTDEA1mfUA0ckKBbWem9w3t0pHLSxdBsvV6YPD30f7cR0BHTlvCvONUqZ7dBYxhsqSSmWYTgN6H4noDGHF7SnXPGiCY93EV8Yor0n2nfo6ZK20iAmp3Ofxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716495948; c=relaxed/simple;
	bh=LKhQHsSrnnAo0BE32SPWbRof1Q809utUpT3FUynBKyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu7JdchwNTmrZnjxsH7jkN9B6bkO7TEPKdsBjGC2TfrZiDtko5JVeYo4h82zD6xNREW2kMEbLHrbmE11IzE1GtmGGp6LJjkbN41B4ums7sV5UKJHOf6VeLGpGFgUyoY8xhNsLubyNKct8AI78TS1zFJesAbOlbjkwkerXmgl4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crYORmdp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crYORmdp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716495946; x=1748031946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LKhQHsSrnnAo0BE32SPWbRof1Q809utUpT3FUynBKyM=;
  b=crYORmdptGuspqlUb+ZbsstmtpNlfl6AnXUNOuw/NGk86dWUv0oEoL+7
   5x1SNwKA32hJRW5HJOqtENIV3rd7U4/KMQjMdaPMqBGk6wrQZBePrE5YD
   9toAmjAfSXQW5AE1FaVvpgyi5OZdSxbVagr808RPPKB29JTMQLAujfzwd
   qzTuJIcqr4dDd4cJdggLQh1sUFQb39yoGP/tRkzyqNaKlaU/KjGA8oJ1M
   6vA1fUpTfLrvwpaUMJjS2oImKJjxB7CfBLuFJ3wV2rpPh+1OjDJIyvC1U
   pceml3vlTYSQBWAbMRyQ648xb3VIi2Dtw7c6o1p3soI0kkZmatt/P6Ymo
   w==;
X-CSE-ConnectionGUID: PBqeYMyzSDeUuuwL1LPWSQ==
X-CSE-MsgGUID: Oxyi5u3aTkKnBud1fBcMKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12694363"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="12694363"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 13:25:45 -0700
X-CSE-ConnectionGUID: JQPjwt5uSHSfoDQrSuGEpg==
X-CSE-MsgGUID: 6cnjPq47TqOCPn2NpU480Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38189693"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 May 2024 13:25:43 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAF0P-0003KD-0R;
	Thu, 23 May 2024 20:25:41 +0000
Date: Fri, 24 May 2024 04:25:18 +0800
From: kernel test robot <lkp@intel.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: v9fs_fid_find: also lookup by inode if not found
 dentry
Message-ID: <202405240422.ZWrRj5Ck-lkp@intel.com>
References: <20240523113638.1196299-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523113638.1196299-1-asmadeus@codewreck.org>

Hi Dominique,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.9]
[also build test WARNING on linus/master next-20240523]
[cannot apply to ericvh-v9fs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dominique-Martinet/9p-v9fs_fid_find-also-lookup-by-inode-if-not-found-dentry/20240523-193912
base:   v6.9
patch link:    https://lore.kernel.org/r/20240523113638.1196299-1-asmadeus%40codewreck.org
patch subject: [PATCH] 9p: v9fs_fid_find: also lookup by inode if not found dentry
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240524/202405240422.ZWrRj5Ck-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7aa382fd7257d9bd4f7fc50bb7078a3c26a1628c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405240422.ZWrRj5Ck-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405240422.ZWrRj5Ck-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/9p/fid.c:17:
   In file included from fs/9p/v9fs.h:11:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/9p/fid.c:137:2: warning: non-void function does not return a value [-Wreturn-type]
     137 |         }
         |         ^
   fs/9p/fid.c:139:2: error: expected identifier or '('
     139 |         return ret;
         |         ^
   fs/9p/fid.c:140:1: error: extraneous closing brace ('}')
     140 | }
         | ^
   2 warnings and 2 errors generated.


vim +137 fs/9p/fid.c

987a64850996db Greg Kurz           2020-09-23  103  
987a64850996db Greg Kurz           2020-09-23  104  
3ed8491c8a75ce Eric Van Hensbergen 2005-09-09  105  /**
ba17674fe02909 Latchesar Ionkov    2007-10-17  106   * v9fs_fid_find - retrieve a fid that belongs to the specified uid
3ed8491c8a75ce Eric Van Hensbergen 2005-09-09  107   * @dentry: dentry to look for fid in
ba17674fe02909 Latchesar Ionkov    2007-10-17  108   * @uid: return fid that belongs to the specified user
ba17674fe02909 Latchesar Ionkov    2007-10-17  109   * @any: if non-zero, return any fid associated with the dentry
3ed8491c8a75ce Eric Van Hensbergen 2005-09-09  110   *
3ed8491c8a75ce Eric Van Hensbergen 2005-09-09  111   */
3ed8491c8a75ce Eric Van Hensbergen 2005-09-09  112  
b464255699077c Eric W. Biederman   2013-01-30  113  static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
3ed8491c8a75ce Eric Van Hensbergen 2005-09-09  114  {
ba17674fe02909 Latchesar Ionkov    2007-10-17  115  	struct p9_fid *fid, *ret;
bd238fb431f319 Latchesar Ionkov    2007-07-10  116  
4b8e992392a246 Al Viro             2014-08-19  117  	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p) uid %d any %d\n",
4b8e992392a246 Al Viro             2014-08-19  118  		 dentry, dentry, from_kuid(&init_user_ns, uid),
b464255699077c Eric W. Biederman   2013-01-30  119  		 any);
ba17674fe02909 Latchesar Ionkov    2007-10-17  120  	ret = NULL;
aaeb7ecfb48ad4 Al Viro             2013-02-28  121  	/* we'll recheck under lock if there's anything to look in */
22e424feb6658c Dominique Martinet  2022-01-29  122  	if (dentry->d_fsdata) {
aaeb7ecfb48ad4 Al Viro             2013-02-28  123  		struct hlist_head *h = (struct hlist_head *)&dentry->d_fsdata;
9a268faa5f8627 Sohaib Mohamed      2021-10-01  124  
634095dab2a200 Al Viro             2013-02-27  125  		spin_lock(&dentry->d_lock);
56a79b7b021bf1 Linus Torvalds      2013-03-03  126  		hlist_for_each_entry(fid, h, dlist) {
b464255699077c Eric W. Biederman   2013-01-30  127  			if (any || uid_eq(fid->uid, uid)) {
ba17674fe02909 Latchesar Ionkov    2007-10-17  128  				ret = fid;
b48dbb998d70b7 Dominique Martinet  2022-06-12  129  				p9_fid_get(ret);
ba17674fe02909 Latchesar Ionkov    2007-10-17  130  				break;
ba17674fe02909 Latchesar Ionkov    2007-10-17  131  			}
ba17674fe02909 Latchesar Ionkov    2007-10-17  132  		}
634095dab2a200 Al Viro             2013-02-27  133  		spin_unlock(&dentry->d_lock);
7894f99a4c6ef6 Dominique Martinet  2024-05-23  134  	}
7894f99a4c6ef6 Dominique Martinet  2024-05-23  135  	if (!ret && dentry->d_inode)
1543b4c5071c54 Eric Van Hensbergen 2023-03-27  136  		ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
ba17674fe02909 Latchesar Ionkov    2007-10-17 @137  	}
bd238fb431f319 Latchesar Ionkov    2007-07-10  138  
ba17674fe02909 Latchesar Ionkov    2007-10-17  139  	return ret;
3ed8491c8a75ce Eric Van Hensbergen 2005-09-09  140  }
3ed8491c8a75ce Eric Van Hensbergen 2005-09-09  141  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
