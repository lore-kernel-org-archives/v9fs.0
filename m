Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DD1E7C03
	for <v9fs@lists.linux.dev>; Tue,  2 Dec 2025 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764675334; cv=none; b=ATX66p7LOpKKfmLPbZ4/P+9OhWRnq5X9o0w32dQb5mHfeo0M7vEpV5CE+fnoM6Q0IaIObww3VZ0ta1fmbx7gHcY/8i9Gi/WUiL368GUIF/h0HX80P7m0FkoMDTENSGFrvy3EAJhpNzCj1p9Xgq1YapGm/pefr6KNynJlVGoTa8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764675334; c=relaxed/simple;
	bh=EKtE24rAorwSn398aJdTDpmUEpG+VXohwSxT3HNpVtc=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=kg1pP+HPDK71WW3aTXwNZMnJgQAyBcZKRFuZWet1z7m4rqosiEVjpxbcMplmQ84y8IKyq2uGWsJFV1i3H758XJdK9F/+KDSxS4qYD8Z1Eh2J6XS308n0LruIbZo5IBdWTdCCzAFalM7Bwlfvi/mCojDZQKppydN9thH6Be7J15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=VmjuRU9D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8wLFwsq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="VmjuRU9D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8wLFwsq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BB45EC0218
	for <v9fs@lists.linux.dev>; Tue,  2 Dec 2025 06:35:30 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 06:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1764675330; x=1764761730; bh=gHTpSUS0Z9
	6HZbYMDsgz29vAkCLMb6u2eKVoENVfAqM=; b=VmjuRU9DUWQrHs30mXw2leUxax
	0a7qSPpYl7xGnMkML5FLeQ6256cwFquO4ztdqo7f7aoZ8Hr4h9+ZFDAfvrJATaqt
	Rm23AD39+79/lx4fpntFBbVkqgKSSBAEesyQrA5JsvdM/MerUY6ZkwBSsMZ9YHfp
	t8il1kdfjSTY+crW/UqGtSRVHE8IkhYZfIAvN1AHwjYzXYY+74ZYv/+3uHkZIjN0
	Ed4/tf4JkkSw2Rnu3KnZC8/TX04yNfC5g6rcRCeD2hZGZ/P+ZKOrlSg4nT/z6mN1
	eo3O015YuWaltHZSGY6Ds6JtQ/qsUIUH58/4RhpM8sYIMMRLIWx6+vtyGc+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764675330; x=1764761730; bh=gHTpSUS0Z96HZbYMDsgz29vAkCLMb6u2eKV
	oENVfAqM=; b=K8wLFwsqb9LWOxb5yzrB/AhswEnW+IBjTqNAKSyllXu8bmFUy7N
	DQVvPuHfag7R7O8BrC3KR2S6P3T0W/ctNNpcaXLIdSqtbQgzmCJcPLzQN9+jAZoa
	yHSj0vYpn+u4EIHxWJUkVhYoDfxukdmqD4NHSjOgpr20PB1/7V7jXFIutzScmsMh
	phpo0xgPDOiYeUgE7nXBbjFuKjqbbQ8T6Z0Pc+zRFfXyAo2UUssaucg99NPdkURj
	HNSgXrKUlsfEctEcHGxJO4VP4sC/BRi6D5IB3/SlQxnqrsu2SCNTRhrGmR3iyQgg
	xqY70kkSV6jaYhq2CW+ycGi0w8oRp0VWroQ==
X-ME-Sender: <xms:As8uaZZ5vQbh4vZhiFebNzmYJF6D1J4rALkBwG1ukIfvYjDrPh4Ukw>
    <xme:As8uabNcwB_JKR92pXZHO2I9OZ-4vzxHexVLaVHZYc-wQCcTey9WJnTg4ED3yjUgY
    Cme06GnLnhcjjt8J01elue3kNAUnfgcdWbVpZxYuF2LeuF-j-MTbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhepofggfffhvffkufgtgfesthejredtredttdenuc
    fhrhhomhepfdfrihgvrhhrvgcuuegrrhhrvgdfuceophhivghrrhgvsegsrghrrhgvrdhs
    hheqnecuggftrfgrthhtvghrnhephfduvdffveffhfelgefggeevgeetjeejtefhvdettd
    ffgeekfeeiudetieehieeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhivghrrhgvsegsrghrrhgvrdhshhdpnhgspghrtghpthhtohepud
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhn
    uhigrdguvghv
X-ME-Proxy: <xmx:As8uaRpmi8ZRdlIULLG8YYK9HUrEsb-GHWaA99sEtROqQGvRjg10JQ>
    <xmx:As8uaTlWg9tvOIIOSf9drUsgR8V4rhpX8lkH6EcvrVjrAOCPyTHvKw>
    <xmx:As8uabHhEwKTm2cmIw7yL5OQUGoLfRY82oiHmvu1PqVga0fdrjHHrQ>
    <xmx:As8uaUoLEw4vFLwvbzyJF7Lt_HwnW-uiqLZae6U0Xo0c4kk69LuVNA>
    <xmx:As8uab-ihoL0ic4zntA6fL-yvqksoUajF6ZLvYgoXotDMq2A_OfRuxBR>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 019C3B6006E; Tue,  2 Dec 2025 06:35:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Aso5u8V0xQUZ
Date: Tue, 02 Dec 2025 12:35:09 +0100
From: "Pierre Barre" <pierre@barre.sh>
To: v9fs@lists.linux.dev
Message-Id: <496d10b9-40fe-4f81-8014-37497c37ff63@app.fastmail.com>
Subject: Directory lseek doesn't invalidate rdir buffer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

It seems that xfstests generic/637 fails on my 9P implementation because lseek() on a directory doesn't invalidate the rdir buffer. After seeking, getdents() returns stale cached entries instead of fetching from the new position.

v9fs_dir_operations_dotl uses generic_file_llseek, which updates f_pos but doesn't clear fid->rdir. Then v9fs_dir_readdir_dotl() only calls p9_client_readdir when rdir->tail == rdir->head, otherwise it returns cached data without checking if ctx->pos changed.

Would a custom v9fs_dir_llseek that clears rdir->head and rdir->tail before calling generic_file_llseek be the right fix?

NFS does the following:

static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
	[...]
	if (offset != filp->f_pos) {
		filp->f_pos = offset;
		dir_ctx->page_index = 0;
		if (!nfs_readdir_use_cookie(filp)) {
			dir_ctx->dir_cookie = 0;
			dir_ctx->last_cookie = 0;
		} else {
			dir_ctx->dir_cookie = offset;
			dir_ctx->last_cookie = offset;
		}
		dir_ctx->eof = false;
	}
	spin_unlock(&filp->f_lock);
	return offset;
}


Thanks,
Pierre
