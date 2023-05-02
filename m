Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD219479
	for <v9fs@lists.linux.dev>; Tue,  2 May 2023 23:31:53 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 03BF4C009; Wed,  3 May 2023 01:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1683070305; bh=6sjh6l6NERLsu+JXUQWin9N0CADzXow+URLH3qXqjjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hv9p9i0QmZVMC9Bb1ldfPZ6Qey6mCkF/ZU6qKI2PqKFFtW9U7E2BZzWzlxgUnig9F
	 /TKc8rs+6Ata24QfNTAZpi/r286fyh4DZxu+TAWkw0NgtDhvXDF9tacPWnHxjiCc7o
	 s7VLBedfPxfCojQqtf15j/hFA5j+v7adS6Rr+FYmfI5wWKfayKFnXGiu8QPG07J0V6
	 h77sLsAU/oRDvo90nc9t9LKyqPGdevYjnulx/tfnAUrQpBMs26G631NtuqGa9jYTMH
	 y4T9Srnnm9t6X7E5cXUi4lbUjEoV1AW021kCsS7uqF0DCsLrvbNgtosoN4++RgTuJd
	 66XhbX9roqYsQ==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 7C83FC009;
	Wed,  3 May 2023 01:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1683070304; bh=6sjh6l6NERLsu+JXUQWin9N0CADzXow+URLH3qXqjjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3Hv3qoBmvA2YVtjpyNUs+nF5IJ/J44szGSFt1JURWHL/ojSGsv/FGfDEr+mojxp7
	 fx03JZV1THs4MXhxSxKROhJyd2sbOlXfbQuCD88+/3dMWOLVFQh64gJA/qxdf5zB0n
	 QrCyRWkCj5nwnh13j7PMjovfWf9+2mIlHkRC4ZWfBlRHxEKEBOfVpAYUgrFrjOlgxQ
	 btfvzczW/qgeThngnFzs3R1K/2+DyDw33F3MKbYapTWvMumBfH0xOqbkN2grUSrnAU
	 aes9sl9pXZxMdtMGbyld4baeNgY2vYUrItiyn9EXSZs5fouq1OVUxz8Yx4O2pjq4oP
	 4eNiMN9KwO6yg==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id e9aa5fcf;
	Tue, 2 May 2023 23:31:39 +0000 (UTC)
Date: Wed, 3 May 2023 08:31:24 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/9p: Remove INET dependency
Message-ID: <ZFGdTDrPa1LD899y@codewreck.org>
References: <20230501190602.86281-1-jandryuk@gmail.com>
 <ZFAWaQbDR1_r5jf-@codewreck.org>
 <CAKf6xptMDRVet-C_1H7txPb_J_xq+XnNxwrQVbNWL_2JGnbHgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKf6xptMDRVet-C_1H7txPb_J_xq+XnNxwrQVbNWL_2JGnbHgw@mail.gmail.com>

Jason Andryuk wrote on Tue, May 02, 2023 at 08:03:15AM -0400:
> > Good catch.
> > Could you add depends on INET to NET_9P_FD in net/9p/Kconfig?
> 
> trans_fd.o builds without INET and without UNIX.  Looks like trying to
> use either TCP or UNIX sockets would lead to runtime errors, but it
> also supports generic file descriptors.  That could be useful for
> someone.   Since it builds, would it be okay to leave this patch
> unchanged, or do you still want the depends added?  Leaving the patch
> unchanged provides more flexibility, though the runtime errors may
> surprise users.  While I built a Xen kernel without INET or UNIX, that
> is an unusual scenario.  Typically INET and UNIX sockets will be built
> in anyway even without a depends.

Hmm, good point; the socket interface is common between INET and
UNIX.. And you're right about the ability to use plain fd as well.

How about 'imply INET'? That will automatically select INET when
enabled, but allow someone to disable it explicitly.

It's rare enough that I didn't know about it though, just found it in
Documentation/kbuild/kconfig-language.rst ...
I guess this version is fine as is if you think it's too minor, I agree
kernels without INET ought to be rare enough and if it builds for
randconfig tests I'm fine with this.

-- 
Dominique Martinet | Asmadeus
