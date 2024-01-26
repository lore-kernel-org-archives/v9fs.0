Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED92230C
	for <v9fs@lists.linux.dev>; Fri, 26 Jan 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300503; cv=none; b=IcMnQaKlt8l1lgmA7y897INM0oUGskZsYII9aBCbKyqErWCBoLB47IzWrdRfBhHp6UlYaf9qRCy/3CA9J6mLH9emT3hcFVtVb2XlKFBKeHnDsnjNwVD+WX6Jw0PFJ+flWZK53KEktuALk5U/TLQEMyfLDIkY0DUoBuH5UcJ9RKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300503; c=relaxed/simple;
	bh=Akgsm6+HkBafk22uHWeJvvyTWrGF+bVDZo+zlEfsZzI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iLmi9bn9QeRK7LP4NciT4P0Qm7S+ZXLj4o9n/PF6fhbF7Ut7jZyK4HRX8xu7Zz4LrXo2DNWX173RFoCGkcnhNgKDS7zQrkkqyISgrNSaGZEvhczN2Lcd+CF7zKXUD8vaF3D8NdT/qPKMsfsckWvQ+TpJ8vz6nQjkEICCQ+Yf3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tchbsm51; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tchbsm51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561F7C433F1;
	Fri, 26 Jan 2024 20:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706300502;
	bh=Akgsm6+HkBafk22uHWeJvvyTWrGF+bVDZo+zlEfsZzI=;
	h=Date:From:To:Cc:Subject:From;
	b=Tchbsm51K7P+Ae6Wt/singcVNDcY3Nz0+Z6Ry7P1hRJWWOMUnCYse5iLhspAxfJ3Z
	 Emb2jnjYt0nMPasSNw12LC5gpuTRyhPJNOu1qgOScFX1/nQ5czEAvxNpe2gKw8DwNM
	 DDVi1qXM8nz48rydwjkDa7TB3L7/bsmoubpD5WEnoVq49xOpywngRmKKiFk621LCxV
	 m7Q/i0TrQB86Qw6wAg6rB2EsQg22DSI0wwRBzpPkgxkYeS+gIXpbHp1GP3lpMWQsn/
	 1kWOX95JzLgacqkhMWEFe70qz18jY8PC1lHJM+mAEP1zg1sGvJztjo02IgSgA5p9Hw
	 rCBK4hD5sNg3A==
Date: Fri, 26 Jan 2024 14:21:39 -0600
From: Eric Van Hensbergen <ericvh@kernel.org>
To: dhowells@redhat.com
Cc: v9fs@lists.linux.dev, linux_oss@crudebyte.com
Subject: fs/9p: regression in 6.8-rc1
Message-ID: <ZbQUU6QKmIftKsmo@FV7GG9FTHL>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I caught a problem in the new netfs code when running in 9p when running
with nocache mode.  A regression sweep is turning up a:
 [ 1084.438387] netfs: Zero-sized write [R=1b6da]
when running my ldconfig test (included at the end of this)
it reports:
/sbin/ldconfig.real: Writing of cache extension data failed: Input/output error

I will try to dig into this later today if I have time, but not sure I'll get
to it so I wanted to make other folks aware.  I'm not sure how much other
elements of my test harness are contributing to reproducing the problem.

	-eric

--snip--
# setup chroot

mount -o bind /dev /mnt/9/dev
mount -o bind /sys /mnt/9/sys

# test mmap via ldconfig doesn't produce lots of errors

chroot /mnt/9 ldconfig -C /tmp/testldconfig.cache > $LOG.log 2>&1

if [ -s $LOG.log ]; then
    echo "FAIL"
else
    echo "SUCCESS"
fi

