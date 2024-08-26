Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08643AAB;
	Mon, 26 Aug 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724638894; cv=none; b=IwAu2plQezAOAA+Sjfin5vhqBRYbvAxi8u+nbYKSeEasKMpUVnqT75RD5BclB2vZdkPpDGTibRm/ivQRoAAZEsN33E1x567vLG6SeRqM1k5iqfzHI+gzIpTByLg+761ug6mi8lriT48oRlDPA2EP1wQtJgnjPd4hjzYS2xAKiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724638894; c=relaxed/simple;
	bh=LHRqAegiK4jGGwd1Shwu36MobrsG7kVPV45/+DUPqps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5zf9BZKkv7CbMcmU9u0f/2D8KYx7imiHixbo0kNUobaFQV13LWPCPGbRKVZgyxsBitK+iAgQaTB7vttjMpprdkQCh5CXfXWgvlqXXo465QTXK0NolQtChuEMUWBIoawQvIGhk4iTofQk2fsxuo82TLe4K4uvBIuvc+wZHlNmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA3ZE4Qu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA3ZE4Qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA2BC4DDFD;
	Mon, 26 Aug 2024 02:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724638893;
	bh=LHRqAegiK4jGGwd1Shwu36MobrsG7kVPV45/+DUPqps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tA3ZE4Qu4AnGYyKSMxiWxXZTvz9WVXPUbepPafL92ssK6Dse9j+xJDwJ/xN27+kQ7
	 retxYNoFgy6Mfh++C3MunFdJPMWwdJAnTRugdTKBtbeWX+jIcbLUpX9aAqGMaFeXKY
	 7hREUrAXAcqJ9i2HbEGjH4e4aaLIVe7ayLfnMh9FR2pOcJnVA9AfUqS3HR9yabB18O
	 wFa1O+BrpVywLBZv9Fgi49Xm79WZdZoQNrdeje90EvLIYU1HndHxgRb167ifYwRTKk
	 bh7miHqFLW4VNVLb2AnL9a7H20cvnZr4LKfbQ8v8AltPGtQlJ+0IV7Zz3I3l+axGIE
	 S3pfIAaYcBH+Q==
From: SeongJae Park <sj@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Docs/filesystems/9p: Convert a goo.gl URL to original one
Date: Sun, 25 Aug 2024 19:21:29 -0700
Message-Id: <20240826022129.81139-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZsvX90dovlI52Ohd@codewreck.org>
References: 
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 Aug 2024 10:18:47 +0900 Dominique Martinet <asmadeus@codewreck.org> wrote:

> SeongJae Park wrote on Sun, Aug 25, 2024 at 06:09:49PM -0700:
> > Google URL shortner will be unavailable soon[1].  Replace a shortened
> > URL on 9p.rst with its original one.
> > 
> > [1] https://developers.googleblog.com/en/google-url-shortener-links-will-no-longer-be-available/
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> Sorry, we (9p maintainers) slacked on this one - there's been a better
> patch for this one:
> https://lkml.kernel.org/r/20240725180041.80862-1-linux@treblig.org
> 
> The sciweavers link doesn't actually work, so it doesn't make sense to
> replace as is.
> (although you could argue that it's probably been broken forever an
> nobody noticed, so it could just as well be removed...)

No problem.  I agree the other patch is better.

> 
> There's no patch queued for 9p, so if you (Jonathan) want to take the
> other patch please feel free to.
> If it goes through the 9p tree it'll get in the next time we send
> something as I don't feel the need to send Linus a PR just for this, so
> that might be a couple of months further down.

Either ways look good to me.

> (I don't like patch series where folks are added in Cc on individual
> patches because it's never clear who is expected to grab the patch in
> the end...)

Sorry for that.  I thoght lore.kernel.org should help getting the context, but
I understand no one can convince all.  I'll try to take a different approach if
I have a chance to send patches to you next time.


Thanks,
SJ

> 
> 
> Thanks,
> -- 
> Dominique
