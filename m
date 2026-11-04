Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776300;
	b=woNekpRlw/fH6+6epeUxC3J1vOr0bml+AoHKl2Z1dHbITDjOvX5OaKx083kwuT2s+afP
	 gzNIG9XqqpDwUt5PEeq6kiG6HlE5eFhuMOyoZz5XFMqcMHpNjvcj+GMp/F2Rqsgd5gDpa
	 /+WL3iAdcFKIVeHqInBKg+oW/VIyib9Zc1v12X6UL7vWQ5tzkoIrvWxGdI+lNVCqVOszU
	 71WfWR81Y2V8BdXsSsK9JeDIvLE/zWQyzSOM2xNxdcpXWnIz6LcoEUKEZrZyHhmwgFC3A
	 o9HaS3u/aCVkduwEYQONU2rxp1nt8ysrdZ2DqKxn25+fsQ3E+t5lu4KAp7GDEgeQU6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776300;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8auKS3Hs+fw/HPBpfVqCvIVthE9qkv8jg4rIo47pQew=;
	b=Hpjci7eH9lEouOMDN4QZ3drs6njOGBDq8DoUdKqTUzy/TVuNXtts/xSbfcH/HTxce59w
	 XbIxmN9SHPiyFhJ3ty1ElhPyygco5zqMW49Isw4HGDfkb6VN9vrsNaJLlpp15PUCcsuyD
	 j+HiYMCmm3gAUePpDM6OnMODPH6RIC5Sm7xe5qZ1hRcMqX7qpaniY/X0euxk2nQcP+mvr
	 ZOKK0Ts0ukvn/2G/jkh2n+2f44C0gtE6cJso6otYdsGgvoKXQlNJlm0dZg1MMNRv18SaH
	 gISvx+dg7xm25SjbnQ4kVZRLDR1VnHErSRymx10OybRyuFECluZUSHc2wSae15gGASA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYpX59dV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1621606A31B
	for <v9fs@lists.linux.dev>; Wed,  4 Nov 2026 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYpX59dV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41CB1F00919;
	Wed,  4 Nov 2026 07:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776300;
	bh=8auKS3Hs+fw/HPBpfVqCvIVthE9qkv8jg4rIo47pQew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YYpX59dVKb83JPrVDvWbqj0z8Cqn+b3RShXn9J0Y00jZgKutViDfJN2y5TNLxui4x
	 es5HGGQ6tuMFBUGJem7dcwHpgndgevKd8MaUEKlpNciOsEiKE3dcxqsbdAVrRyAdEU
	 4S9LdltMqaPUQOC4QVm2zj35tOO+0k2GIoHc8hvSMc1JL/9BKrlVifcacIuojZGji2
	 C5ynOsH53gXoaAzdFHmp7fR2cXjVoqW3ZpEo+9VHmA2WmPezLLs5Iozoz4VuTKFB3D
	 CxH5i0flygYACjBdO50pBbq/k4WZqX5FlSprQwO/O63AXiM+vAKiKkbyQzUd8hoSW9
	 T1yahUTG2d+Qw==
Date: Wed, 4 Nov 2026 08:11:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: v9fs@lists.linux.dev, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Latchesar Ionkov <lucho@ionkov.net>, 
	Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH] 9p: put the request on a duplicate RDMA reply
Message-ID: <20261104-massive-orchid-tarantula-e4199c@quoll>
References: <20261104022806.1484080-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261104022806.1484080-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:28:06 +0000, Wentao Liang wrote:
> recv_done() gets a reference on the request from p9_tag_lookup(), which
> the normal path hands over to p9_client_cb() and that puts it. The
> duplicate reply path jumps to err_out without calling p9_client_cb(), so
> the reference taken by the lookup is never dropped and the request, its
> tag and its buffers are leaked. A duplicated reply for a request that is
> still in the idr is exactly what this path is here to handle, so drop
> the reference before bailing out.
> 
> Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/9p/trans_rdma.c | 1 +
>  1 file changed, 1 insertion(+)
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




