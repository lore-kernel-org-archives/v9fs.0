Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADC18C332;
	Fri, 18 Oct 2024 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287315; cv=none; b=d3gJ1OOhaqDLc4EWedXeZnJGtBRz3qlAVMtZmq2/myuWsgvxgq4XiqGnzVOG4wBy53YhpLTGGvnx3LmO9l+0d1kwE9qICfui44hrllrZYk/V6yZFYYIW5/aKJfh2KnoRW6ALuqktr6CGLhyZP81IJ3aSaWsSdXDkrhIraJZ8PaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287315; c=relaxed/simple;
	bh=0JJG7ZWIdGOJlptv0dy+ApYKEGxXb53eUSStdfKAWHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4N9jOEpKYv7xFFik520ArKTXn7LRb3omQ0xxjn7FjN5aFz6siRMJcMLnnIUto15/qUnRVdrbUv8w/I5RLyc9EOUlmZbk3WwawYm/4a5g2ctZNV5ApRB0jEEjcb9oQqEZi14dmnChVXIbfmXU0RoOJvsYCosziR/YzMJBXpCRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1dAeNhwe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jNCclp1D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1dAeNhwe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jNCclp1D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1dAeNhwe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNCclp1D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1dAeNhwe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNCclp1D"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF34621D2E;
	Fri, 18 Oct 2024 21:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729287311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axzGyzmJ+hGoR2JC/TBJ5+Ys6eofFYtEOxdTC16nNKI=;
	b=1dAeNhwefhyIAmDvhaM1XDyaQ+G3e8GqK/Wi3ivSWbKvZJGJMdV5urjf0cX9FL4OOtTEyT
	OhNOD3EUG9rvSSA7xD/rzSYM02/+7IMm41zXtGcvn0xjt5JbAtIwKUPJyXgUq+3lJNzEJv
	XTvCxR0eJ+gCgATEMaEG/MF+8EKMMx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729287311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axzGyzmJ+hGoR2JC/TBJ5+Ys6eofFYtEOxdTC16nNKI=;
	b=jNCclp1D4L/f/TBwr8Qn7LEtXpgEs4zLkahaqkMcvqn1Lmeel1ZGcRegqxQMZwx+nmn4MD
	wYfG+qWwsAfxxvAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1dAeNhwe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jNCclp1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729287311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axzGyzmJ+hGoR2JC/TBJ5+Ys6eofFYtEOxdTC16nNKI=;
	b=1dAeNhwefhyIAmDvhaM1XDyaQ+G3e8GqK/Wi3ivSWbKvZJGJMdV5urjf0cX9FL4OOtTEyT
	OhNOD3EUG9rvSSA7xD/rzSYM02/+7IMm41zXtGcvn0xjt5JbAtIwKUPJyXgUq+3lJNzEJv
	XTvCxR0eJ+gCgATEMaEG/MF+8EKMMx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729287311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axzGyzmJ+hGoR2JC/TBJ5+Ys6eofFYtEOxdTC16nNKI=;
	b=jNCclp1D4L/f/TBwr8Qn7LEtXpgEs4zLkahaqkMcvqn1Lmeel1ZGcRegqxQMZwx+nmn4MD
	wYfG+qWwsAfxxvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EDEE13680;
	Fri, 18 Oct 2024 21:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TkYaIo/UEmdDJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 18 Oct 2024 21:35:11 +0000
Message-ID: <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
Date: Fri, 18 Oct 2024 23:38:04 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same
 name
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Pedro Falcato <pedro.falcato@gmail.com>
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com>
 <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
 <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF34621D2E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,crudebyte.com,lists.linux.dev,vger.kernel.org,nvidia.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/18/24 8:54 PM, Thorsten Leemhuis wrote:
> [reinserting a bit of quotation below for Linus]
> 
> TLDR: Linus, I wonder if it would be best if you could merge the patch
> at the start of this thread
> (https://lore.kernel.org/all/20240807094725.2193423-1-pedro.falcato@gmail.com/
> ), which can also be found as 79efebae4afc22 in -next if you prefer to
> cherry-pick it from there. Either now or after 24 to 36 hours, which
> would give Eric a chance to ACK/NACK this if he sees this mail.
> 
> For details see below.
> 
> On 18.10.24 20:36, Pedro Falcato wrote:
>> On Fri, Oct 18, 2024 at 6:28 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>
>>> On Wed, Aug 07, 2024 at 10:47:25AM +0100, Pedro Falcato wrote:
>>>> In the spirit of [1], avoid creating multiple slab caches with the same
>>>> name. Instead, add the dev_name into the mix.
>>>>
>>>> [1]: https://lore.kernel.org/all/20240807090746.2146479-1-pedro.falcato@gmail.com/
>>>>
>>>> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
>>>> ---
>>>>  net/9p/client.c | 10 +++++++++-
>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> Can this get picked up to rc4 please?
> 
> Eric apparently has not much time or upstream work currently (but
> recently showed up in a discussion about another regression:
> https://lore.kernel.org/all/Zw-J0DdrCFLYpT5y@codewreck.org/ ).
> 
>>> It is causing regressions in my environment
>>> #regzbot introduced: 4c39529663b9
> 
> If anyone wonders, that is 4c39529663b931 ("slab: Warn on duplicate
> cache names when DEBUG_VM=y") [v6.12-rc1]. That's also why I'm CCing
> Vlastimil, so he knows about this.
> 
>> FWIW, seems to have been picked up into 9pfs-next
>> (https://github.com/martinetd/linux/commit/79efebae4afc2221fa814c3cae001bede66ab259).
>> Seems like we're just missing a PR to Linus?

If was Dominique, not Eric, see:
https://lore.kernel.org/all/ZvBIl8b9RRK9jgtJ@codewreck.org/

Can you send it as mentioned in the email? :)

> In that case: Linus, given the circumstances I wonder if it would be
> best if you could merge the patch at the start of this thread
> (https://lore.kernel.org/all/20240807094725.2193423-1-pedro.falcato@gmail.com/
> ) directly, which can also be found as 79efebae4afc22 in -next if you
> prefer to cherry-pick it from there  Either now or after 24 to 36 hours,
> which would give Eric a chance to ACK/NACK this if he sees this mail.
> 
> Ciao, Thorsten
