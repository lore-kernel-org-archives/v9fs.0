Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA935EE4
	for <v9fs@lists.linux.dev>; Fri,  5 Jan 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxoXCc64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10631C433C7;
	Fri,  5 Jan 2024 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704480662;
	bh=UbItJCHwWDz7DZUW5IGEGe0FMtNyl4vfMn7ynwq+q38=;
	h=Date:From:To:Cc:Subject:From;
	b=dxoXCc64dwEy5hJynvgC/ElpQ2ENIySr4Q4zMzq45R0UDF63hj9Py+lnT6/AL7P61
	 HEbK8X9FLPQRrPO6GN87YjD7qcjSGbP7YXzEnA768tO0bI7z8GWOJWsdCUB+gaICPN
	 jgmRYcuAl/XeFc9EIA2Rwqg/lsioZ3c8RKlkDC/e5/mRu3yPYnFWyWzYZ8AZsjGTpP
	 byI2ZGTmBeV6r5umciVuz4x/UJAF/Qo4wXw+vhYIi/mZHQhspVF2e4gY+zrcNpWIGf
	 X5awXtirGmQDjQzZFZsXY3DeSPH1L4RM7fRplZMiPsBVejLEiXCVSLfyYCr0OOKQ1p
	 7rDH6CBMCDLyw==
Date: Fri, 5 Jan 2024 12:50:57 -0600
From: Eric Van Hensbergen <ericvh@kernel.org>
To: v9fs@lists.linux.dev
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, asmadeus@codewreck.org
Subject: inodes in dirread
Message-ID: <ZZhPkZFWUyBXRcdo@FV7GG9FTHL>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Anyone know what the inode in dirent is actually used for during a 
dirread?  Right now we are hashing the qid to an inode number, but
I was planning on re-writing this so we can let the client allocate
inode numbers for itself to guarentee uniqueness.  However, that
would mean I'd have to allocate inode numbers is dirread (if we aren't
using the cache) and then immediately discarding them which seems
wasteful.  Puting qid.path there "works" but I'm not sure what assumptions
I'm breaking.

    -eric
