Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0D20E319;
	Fri, 18 Oct 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277661; cv=none; b=XjcADxX47vLtJ/koxxokBPCqWXh6tRVXohNGOsdrZfEP2WGpFS8eKc6INTdSgliAkDu6C9Q730K5Ny9JWPYXDnJRtqDdi0ykbnqSzwZXmrmuQXK9/w4oitd6utlp5AeBrDFOaDRHV4vqpEZD2tnzduhAWrKT4ANg1AKq5uuWzP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277661; c=relaxed/simple;
	bh=9SbWM3CvnOHvW/bRwBdcAebrRpW8x9mDPVAVuIWwSFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEUR4mDl95agWe/daUL8s2EkL3fUaA/qsRCZxfZ1wNwT7jPWmHPsWetBYdsZkq2g754+GDLUhvZYsQvzmcwGh1r/dXQtDNE1QdF+eQfApkti680HXgUk4kAYAIPmCLTGPcS1OX/YDqpIJe4oHGYqegpDMtzTUL+auQXAMDbhrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=x2ex08Ev; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="x2ex08Ev"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=A4bFeDIAbwabxt/OL8jHcFGOxHJoyVHPgzeE8LqQeFw=; t=1729277660;
	x=1729709660; b=x2ex08EvMgtQrQuk00B237Ua2a733hEsnhTBziOHImXxWM6UDGYwSduLIbvxv
	4T2An91v/wEUDSXOj0euciCNw4qwgU+KDF4HtJtV+VDRUkXK3kEsVtcSBYXBeYRYwbfcwRKNcNyRJ
	RWje0O2Pu2sWte8QBWJD8jxLu4KzlobwPdXc1LLLEjyggA6VdtYqsvr8S8r/6a0Lo/s8i7G/e1WAv
	3LVz77u4VDG/sOGucoHsvADl4gW/DJbzDj1QZtWYFyFnwJ+17lWdPheMAk65uSozCeOKwYimOdgQS
	zp9L9RkFqK0yVfkUlU4fXxhmcCTQroFZYsLz2fIezFWfslwxRQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t1s76-0005JI-76; Fri, 18 Oct 2024 20:54:16 +0200
Message-ID: <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info>
Date: Fri, 18 Oct 2024 20:54:15 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same
 name
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>,
 Pedro Falcato <pedro.falcato@gmail.com>
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com>
 <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729277660;1c3e423f;
X-HE-SMSGID: 1t1s76-0005JI-76

[reinserting a bit of quotation below for Linus]

TLDR: Linus, I wonder if it would be best if you could merge the patch
at the start of this thread
(https://lore.kernel.org/all/20240807094725.2193423-1-pedro.falcato@gmail.com/
), which can also be found as 79efebae4afc22 in -next if you prefer to
cherry-pick it from there. Either now or after 24 to 36 hours, which
would give Eric a chance to ACK/NACK this if he sees this mail.

For details see below.

On 18.10.24 20:36, Pedro Falcato wrote:
> On Fri, Oct 18, 2024 at 6:28 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Wed, Aug 07, 2024 at 10:47:25AM +0100, Pedro Falcato wrote:
>>> In the spirit of [1], avoid creating multiple slab caches with the same
>>> name. Instead, add the dev_name into the mix.
>>>
>>> [1]: https://lore.kernel.org/all/20240807090746.2146479-1-pedro.falcato@gmail.com/
>>>
>>> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
>>> ---
>>>  net/9p/client.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> Can this get picked up to rc4 please?

Eric apparently has not much time or upstream work currently (but
recently showed up in a discussion about another regression:
https://lore.kernel.org/all/Zw-J0DdrCFLYpT5y@codewreck.org/ ).

>> It is causing regressions in my environment
>> #regzbot introduced: 4c39529663b9

If anyone wonders, that is 4c39529663b931 ("slab: Warn on duplicate
cache names when DEBUG_VM=y") [v6.12-rc1]. That's also why I'm CCing
Vlastimil, so he knows about this.

> FWIW, seems to have been picked up into 9pfs-next
> (https://github.com/martinetd/linux/commit/79efebae4afc2221fa814c3cae001bede66ab259).
> Seems like we're just missing a PR to Linus?

In that case: Linus, given the circumstances I wonder if it would be
best if you could merge the patch at the start of this thread
(https://lore.kernel.org/all/20240807094725.2193423-1-pedro.falcato@gmail.com/
) directly, which can also be found as 79efebae4afc22 in -next if you
prefer to cherry-pick it from there  Either now or after 24 to 36 hours,
which would give Eric a chance to ACK/NACK this if he sees this mail.

Ciao, Thorsten
