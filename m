Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20E149C47
	for <v9fs@lists.linux.dev>; Thu, 26 Sep 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362509; cv=none; b=CGZCF20y+3nYk4s107BO8uhSKm1O7jDv2Q1ekjV7YSMS/PeZybR0FCWU9dqvoyd0TJGROS6KwenpdcAmDAKMGkS09wJ8MKghkw6eJua5Rla+NRx+zkDGbse9gObQOpSME0S/mKuPXNj73sj73xtzr0xAXCjbQUufYBmBVPoX7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362509; c=relaxed/simple;
	bh=6f4RCPlaw3fe47fY9+C+I+FJuQPAAMfVLR5982aQ8YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOAE/JTZNjeZS1M5RyjlAv2xD3fdJiAHGBbY9aKLD9/hzwbnmI4lIqvrDprJeyfMD9Mpw4FamH8dulAIEY2CcUbNiGjWwn2OtzZJGr1UfbXRYhiWbrzsfDTpDfz+4um7PSdoCxI3TCWk3rfCG/Q9FwLVElDrXraOkbk6vtOMKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JVh5yD+y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k6zrruqS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JVh5yD+y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k6zrruqS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JVh5yD+y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k6zrruqS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JVh5yD+y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k6zrruqS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3399F1FD11;
	Thu, 26 Sep 2024 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727362506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I66TZvlQQXJl0mLm9F8LBVAkCdixQJKGTf9/6Vbit+4=;
	b=JVh5yD+ywCYJk+U3u5H2FLvJ+KWolRaR4uafU4Q+moDCCMyJ/IoFHfLdsskHBaLEe7yJaV
	+fqc7kYII/Fa3/+P61ybxIZiI7jQuUph9WCwpJj3nf8DOKM08+cPEXk1fZC549VYyb6wv0
	qBbG4uCOlBhTS053R969HFhee6HznNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727362506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I66TZvlQQXJl0mLm9F8LBVAkCdixQJKGTf9/6Vbit+4=;
	b=k6zrruqSWqp8QEYTeL4LtVMnb5rnNdqhuEVuQlYueTNGH83Z4XvW5/Y1O8dOdeUBc2mq1y
	9EiSI4VSP6JcIDBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JVh5yD+y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k6zrruqS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727362506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I66TZvlQQXJl0mLm9F8LBVAkCdixQJKGTf9/6Vbit+4=;
	b=JVh5yD+ywCYJk+U3u5H2FLvJ+KWolRaR4uafU4Q+moDCCMyJ/IoFHfLdsskHBaLEe7yJaV
	+fqc7kYII/Fa3/+P61ybxIZiI7jQuUph9WCwpJj3nf8DOKM08+cPEXk1fZC549VYyb6wv0
	qBbG4uCOlBhTS053R969HFhee6HznNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727362506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I66TZvlQQXJl0mLm9F8LBVAkCdixQJKGTf9/6Vbit+4=;
	b=k6zrruqSWqp8QEYTeL4LtVMnb5rnNdqhuEVuQlYueTNGH83Z4XvW5/Y1O8dOdeUBc2mq1y
	9EiSI4VSP6JcIDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E89C13318;
	Thu, 26 Sep 2024 14:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sTmbBsp19WY+AQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 26 Sep 2024 14:55:06 +0000
Message-ID: <a72c7a42-0135-4ac7-9cd3-d872dcbe172a@suse.cz>
Date: Thu, 26 Sep 2024 16:55:05 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [v9fs?] WARNING in p9_client_create (2)
Content-Language: en-US
To: asmadeus@codewreck.org, Pedro Falcato <pedro.falcato@gmail.com>
Cc: syzbot <syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com>,
 cl@linux.com, ericvh@kernel.org, linux-kernel@vger.kernel.org,
 linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com,
 v9fs@lists.linux.dev
References: <66f0092d.050a0220.3195df.009b.GAE@google.com>
 <CAKbZUD08BQeK0R-KuU07=QUCW7GHbmZ0RgfUcOpzKd+Yv4b5CQ@mail.gmail.com>
 <ZvBIl8b9RRK9jgtJ@codewreck.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZvBIl8b9RRK9jgtJ@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3399F1FD11
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[codewreck.org,gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[3c5d43e97993e1fa612b];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 9/22/24 18:40, asmadeus@codewreck.org wrote:
> Pedro Falcato wrote on Sun, Sep 22, 2024 at 03:59:17PM +0100:
>> This was one of the issues I actually ran into when using virtme.
>> Fix was submitted here back in August:
>> https://lore.kernel.org/v9fs/20240807094725.2193423-1-pedro.falcato@gmail.com/
>> 
>> No replies nor was it picked up. Can it go through the slab tree?
> 
> Sorry, we're not getting many patches for 9p so I've been slacking and
> trying to batch a bit for when I can find time to pick them up -- don't
> hesitate to ping again if nobody replied in a week or two.
> 
> In this particular case I remember thinking it was a shame we're
> creating a cache for this when most mounts will be sharing the same
> msize but never found time to actually consider how to share the
> caches... But this isn't anything wrong with the patch itself, sorry for
> the delay.
> (and now I'm thinking about it, I guess the slab code has something to
> regroup identical caches? Just looked and didn't find it but I recall
> something like that...)

Yes it does, and it's active by default (although can be disabled), so you
should be fine without doing the grouping on p9 side.

> Anyway, I've just picked that patch up (don't expect any trouble but
> will be queued to next later today), I'll send it to Linus in a week.

Thanks!

> (I'm also adding the syzbot reported by so this gets closed even if it
> came later)
> 
> Thanks!

