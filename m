Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778106;
	b=PIDwLGeNxh/ZbQFmu22/v7JQczNgoUwCLdKR8OIbGq9Z0ElNXX59xDpBXRyx2/GiKLEg
	 uNAGv6jmqNrrrr0PWXQt8KoG4BeJFO2s4ydGTOFhWLY7TjqW2A/AIM6jmbP2ubVQsC/cx
	 AjAJMk2TzK8gu8w/dRa5jeN73lVDYfB5OQZvwu/sONIbWg3MbojPI2qzT9O0FQoyVn4fa
	 9Psn+0yD6h6A0P7j/QCesXrXymBnBg7WkN7f8Bm6BQS86gwmk9FykN8hKcIDwsDzaz7+y
	 PFM2ecU9aFD5IFrssJgsR5AKwRLkBS/FzexjoWHdxPKhEEqWRAtFCC99AaB+GwsCe+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778106;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+vmNRmBEJduyhMSAlpQIfUWamJQvfLJpmps9k+n/gV4=;
	b=024DecjJ4ZTozh2EoKMj0c+OkGLcp0wePPiiCD3kJlXiu3d6YvV90HQIlveb1Z/yFI5t
	 Pjx7GeeM+xjk9UyloIhgNFaMrlas36aQ0biMKBdGWTzY+2+Z4S4nRRCDuhOuHRKL/2/c4
	 /N29YwUMXt60OwFjio0ev1rVER6/TukE2HrZaHYcWWklo8GAp3CDd+24H5LQTz27AyHod
	 8Au+2droUbNmiS9/p7nQqFCz9XZWas1SYnitBBNH7i7jLcgPM4zAgfz3rooGrtjMFSuGj
	 OpRgKcSIVgUEoiPHdiM7dRTaiLrzuI2yx4pDyHpEOpRrwUJHAfM41wc8eaUf2YP2rdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cA/c+NK7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01284606A333
	for <v9fs@lists.linux.dev>; Wed,  4 Nov 2026 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cA/c+NK7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7EB1F000C1;
	Wed,  4 Nov 2026 07:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778105;
	bh=+vmNRmBEJduyhMSAlpQIfUWamJQvfLJpmps9k+n/gV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cA/c+NK7pGtu7O6PO0/d8IgzYPtl/r//ZsqEnS1NWXYkriiC+z6m6uiWpiap6qU1X
	 qowg9eU5gA779fOssVIyXW/DgXkqJsDLkuLsdo3gJMzDSiRJGI5jINrjyHQVCG9QTv
	 m7uWMnURAPz/iUW87FRohnzTxSs2FFSHhGMZOSDVk5kWs0UrvfUO2rIvJQ2iDPCsar
	 HAhGM7EtXmFYONebwbjf+jMAI56KVBDBMwZVEpEYANlqV/sZpe6jKF4z1DWiHSbdZg
	 4gXn9R2lAa9uQY8BaudtLhpNqHU2AWRbuOw/w8sPMJdIh4kXXBJNk1GEeIsvGKzjIL
	 HZy/7BM8hhIjA==
Date: Wed, 4 Nov 2026 08:41:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev, 
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH] 9p: release the request when the response tag is not in
 flight
Message-ID: <20261104-cautious-classy-tuatara-5db54d@quoll>
References: <20261104022807.1484097-1-vulab@iscas.ac.cn>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104022807.1484097-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:28:07 +0000, Wentao Liang wrote:
> usb9pfs_rx_header() takes a reference on the request returned by
> p9_tag_lookup(), but the shared error check returns NULL without
> dropping it when the lookup succeeds and the request is no longer in
> REQ_STATUS_SENT. That state is reachable: a cancelled request can still
> be found in the idr with REQ_STATUS_FLSHD, and a duplicate reply can
> arrive while the client still holds the request in REQ_STATUS_RCVD.
> Only the parse and lookup failures may return without a reference.
> 
> Split the check and put the reference on the unexpected tag path, like
> the other error paths in the function.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/9p/trans_usbg.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




