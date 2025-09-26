Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C22741A0;
	Fri, 26 Sep 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878859; cv=none; b=i3hSNF0036VDj3CTjkvTwf1vT7z+ZqWBZUEaS8qyhQ9XDkLenFJJ3GchqEuDJ8T56q6iRO71wdQWvQnBabENDYhdJmygW+1YksTu9clVA4AfFdDyIP+zpSi94XkodLe8hMb8Cv4W6gu0h2fBWIPs0l2jdfhtoXgWYMehuArLukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878859; c=relaxed/simple;
	bh=qfXgb+yYLhRa2IcpPHI2iywFY1Y2Fm3oR9YEiLZQd44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qfF5P4/Dapw5Uj4KmgsQojsEM7NKMJnZU2dKYT+wxR1mNNACBjxrLByCeIDgktNFetqzDrRpkfHeGuHK16bTY32iD2MtyicuSczSZrWFkXr18W6T9eU0K15oaoCMmHbJgpGE8xIEqdyN7viILweljgBu/yHyiJrgH404wCKk7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0otqkrD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0otqkrD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7259DC4CEF4;
	Fri, 26 Sep 2025 09:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758878859;
	bh=qfXgb+yYLhRa2IcpPHI2iywFY1Y2Fm3oR9YEiLZQd44=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l0otqkrD1Hbv9WNoKeuZRDm1jZVn3R9sSeFgfuy0ObQhchDL/a/zTqkOdwmAxNvJV
	 DiNtxviCvd3si9aIT54sH2ejxz7nZjruXNRC1ZzrCmwkVI4AhnrmIr4RmwOAlfubIw
	 y6P4kiYzGOwsj4l7uD+0CBIh5sRiGRwtcz84AUePiEqh7e+XFxvxLBGpF5sshaW5uK
	 ma+9KCHqIZJhnAtKiopBpwG6V8N6iHMk9wqzTBnjckrW9p5fEt8jX33/INQ6YlQ72z
	 6ttGuE2/KQIHtH7j7KodKRM2JvUesZlhlszMEKk0MbqG0LSejsr7mF5ZoRWKDYUb/T
	 n7sWs4gKxa49w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F41CAC5B9;
	Fri, 26 Sep 2025 09:27:39 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Subject: [PATCH 0/3] Split patches sent earlier
Date: Fri, 26 Sep 2025 18:27:28 +0900
Message-Id: <20250926-v9fs_misc-v1-0-a8b3907fc04d@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIBc1mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMz3TLLtOL43MziZF1jM2Mjg8TUNAuLFEsloPqCotS0zAqwWdGxtbU
 As/KtgFsAAAA=
X-Change-ID: 20250926-v9fs_misc-36320aef88d9
To: "Randall P. Embry" <rpembry@gmail.com>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=878;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=qfXgb+yYLhRa2IcpPHI2iywFY1Y2Fm3oR9YEiLZQd44=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBo1lyH+7NBIAYbEA8NOLVRhtoIVCFkD0YMEyn5K
 r+Ga74xinqJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaNZchwAKCRCrTpvsapjm
 cNIMD/9ZXhaWrq3pKI+K2orBC21oEcSf3qlXPhQsbLpLxWhfabSaDWI6ojpw3uDrNLGduPo2iAy
 IRRZbEUMFia2kPXomFhhG52rbAWJyT6AYqwzMqsJfcR6NEhX05pP81H/X1nPbqKBN7hKZFAMZVu
 d7/3OeDnIpkoXGGMtwa5WBhA8LAjC7aG5iUr9AEUGE4xf/nOgcjXoB5nZTT0KHBFbzplttMDdt2
 Qo65psDVWdEpH1LlQ3aocA5YK3GarAR3yIfn6c+y4CHMPNoWMoNHTRxLJQpxL7SftONwvbvdIn0
 1iKCTqDasoYu/8YQqXIht30F+9Fsn1o/YEyn94AimHbZEDzsIOzRfFOIX8moP9QGrd7DF78whh4
 iqR4tlotSm12eILBaf/c6X2ep4g/Oh4RNV7yzaMGyBDRX4w6oWs1rgtp/po3FH90qFg71v7pD8U
 sTlrJeB3LzQsmFqjNDrU5KMq/iVQk9QgJUWbbwMQEsPqQ96oPyzHHg/ev+dC3qIbgugb/XuFNFf
 HTWxun331eeqtcJot7tw+WsVVY0vUAOU3bWZx5OhSlh7ddVhZkuOwIufxfjV+IAjSTkITf1DTWz
 /WGWbWCby2YXTtDPuUtCYx6taI8oaZT9qt5aosrvLhzr4wgOngxoa1fH/djuBj0R0cfQyfwWFfC
 bhPcsEbD/K2/SWg==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

This was a pretty simple patch overall but "bullet point" commits are
not great for later debugging, so just split this commit in 3:
https://lkml.kernel.org/r/20250925122802.72580-1-rpembry@gmail.com

Randall, I kept you as author, so please comment if you have anything to
say about commit messages or anything else, and I'll pick these up and
push to Linus in a couple of weeks.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Randall P. Embry (3):
      9p: clean up comment typos
      9p: fix /sys/fs/9p/caches overwriting itself
      9p: sysfs_init: don't hardcode error to ENOMEM

 fs/9p/v9fs.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250926-v9fs_misc-36320aef88d9

Best regards,
-- 
Dominique Martinet <asmadeus@codewreck.org>


