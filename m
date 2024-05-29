Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE647187342;
	Wed, 29 May 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002693; cv=none; b=WQy4sveYqv9FCfp4UDk5vns3MhL1e9jpG81nMdRe3DJWAzFz0ASaGDN6DrCu774Nawcgu/cqnkrOT0qUlFIFmMDo9HPqkSAFIrd1kxAPQ4vtP32m6uA0sQd1kX3a2jO6GzkNcCfR9tm42hS5cEB5eFTQw2dvp9b/NFCk3LARyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002693; c=relaxed/simple;
	bh=hFZbOWvRADC2FMq/5Xi8ptXlvWg0ZrS9nutHw2tIf30=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mpeaF1NKDxuxPUCxf0iFal6LH0/m7YeD6RQmkGbs2uIbc2/tGtLQX4P/TF0ytN3jVws1cPgYjgzu5+JNWV7AAhXVNO+FgXxpvBwA4zxlECgpgb53D4V5onNScOzHkKhXMzvkoRSanOVODxjBmSTF9YozhUHfXuHd5a7qVVc8hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQV8AeoG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQV8AeoG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E8F0C116B1;
	Wed, 29 May 2024 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717002693;
	bh=hFZbOWvRADC2FMq/5Xi8ptXlvWg0ZrS9nutHw2tIf30=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hQV8AeoGEjzMst2rTZl6SaHJ7YmXZ+Uc0CXaoE8txiDN0d9ys7DGuMkDGRkxTu7Sf
	 C0OGqyxUoN3QKTZU+a9h5TLHG75PoyQ7xkmMZLh7HVCC9/WI+9IC3W0A5TlEysPGtd
	 XlVUQA+wlsgXkXBjZAQGpveXldX8o8n2c79o4U0Kjp+3ZZx1zcNiRSM+9n75RG3Z1o
	 OGORS2nktXO4lcevJOp16EkGpDtJPaqBC3CZWv9jvfmm6zo5i6gv3Bv4s4KS9b6Z4/
	 jOx4Gd3l3sddvrwUOmCMQK57QenBuXCNTbapwv7UZH9EnXqU7ciG2dETsZ3ayuR8aG
	 Frp6EftDQ3Q/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42FCECF21F0;
	Wed, 29 May 2024 17:11:33 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlaC1Sn6WZtEGsbK@codewreck.org>
References: <ZlaC1Sn6WZtEGsbK@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZlaC1Sn6WZtEGsbK@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.10-rc2
X-PR-Tracked-Commit-Id: c898afdc15645efb555acb6d85b484eb40a45409
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 397a83ab978553ca2970ad1ccdbac0cdc732efd9
Message-Id: <171700269326.30079.4116382654028598249.pr-tracker-bot@kernel.org>
Date: Wed, 29 May 2024 17:11:33 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 29 May 2024 10:20:21 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/397a83ab978553ca2970ad1ccdbac0cdc732efd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
