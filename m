Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE9EA49
	for <v9fs@lists.linux.dev>; Fri, 22 Dec 2023 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UHLaNfBU";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qpWJAUAn"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 00A62C01D; Fri, 22 Dec 2023 02:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703207271; bh=4ozmH151xu58IYSuMT/BMJQH629RfyPY+CsrR3SsG2s=;
	h=Date:From:To:Cc:Subject:From;
	b=UHLaNfBU/9fTOcuS0I4jxgafL5G5GdqRYSmC1CGmtiUpoTjH+N/QxL+FGs7968uWe
	 9jtlAvMojqNiT6VWM/4ryF4RQwPRmWsJwivP5dyDzZsJ0I3laZvum8bDR4f/ATDlXw
	 9U3ul0Xhh/0kF9jebzNEUW5BgkEJr85ac1Tbr8LmToJ1QfyyImPs17p8UaYrshJyTX
	 1vksgm7lVYtdPFUbxhu0SzQ36DrFsJIygeWtZPscehusPWVwMfEExSx5siHKx2alAW
	 lN4+T8uJ/7syC8sBblEVpNi1sUZNubxvV8WX7td5rolNUhI0Y5lukS4e85En0zMSc1
	 oXv1Ie0Z+rgjQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 9408AC009;
	Fri, 22 Dec 2023 02:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703207270; bh=4ozmH151xu58IYSuMT/BMJQH629RfyPY+CsrR3SsG2s=;
	h=Date:From:To:Cc:Subject:From;
	b=qpWJAUAn/kfKjL+tKGxlgjWFtAbCKpeJmdHiwCDFbAXQ8e3PZMaOHXkYtXxLbrwKA
	 BH+6FuGhdPGG6mOt0TPflzeouav3j2MMUzP8HuPA99+atmv/5nrPoWxqvW9CyIn+Zd
	 UHtvoa/IGxXQkjb7w8OYpn8cN4D9+KCutuJjrvngPvNm5mgzO54frYMnZIR/Lj/+uH
	 6EfWMKwlcTMgHTPnP81OGxtUR+V/YD/wzObQkfeOn30zvd8nG7q95CXdmgJ2oGxPck
	 U/fY1aUnLgQ+ePJTttgrxzjjcP6kNrDNnTV9WKR2uD3xbiyAesSV9eMMuI1ijiE/YY
	 JqPenbqWqpdiQ==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 46d12d02;
	Fri, 22 Dec 2023 01:07:45 +0000 (UTC)
Date: Fri, 22 Dec 2023 10:07:30 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.7-rc7
Message-ID: <ZYThUpCUMJUMP3Oy@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.7-rc7

for you to fetch changes up to ff49bf1867578f23a5ffdd38f927f6e1e16796c4:

  net: 9p: avoid freeing uninit memory in p9pdu_vreadf (2023-12-13 05:44:30 +0900)

----------------------------------------------------------------
Two small fixes scheduled for stable trees

A tracepoint fix that's been reading past the end of messages forever,
but semi-recently also went over the end of the buffer.
And a potential incorrectly freeing garbage in pdu parsing error path

----------------------------------------------------------------
Fedor Pchelkin (1):
      net: 9p: avoid freeing uninit memory in p9pdu_vreadf

JP Kobryn (1):
      9p: prevent read overrun in protocol dump tracepoint

 include/trace/events/9p.h | 11 +++++++----
 net/9p/protocol.c         | 17 +++++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

Cheers,
-- 
Dominique
