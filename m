Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54374F797A
	for <v9fs@lists.linux.dev>; Tue, 19 May 2026 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195730; cv=none; b=DQmyF6R4Opvj73ksFSirDf/6m4N/LZgggBV6ePIXSBcWZ2yELx2qvVA76cZhTI4e+jSpVVgeT2D6JzZhXE2GxM5RPFEfi15vdZm54u/prc0RuWiU9J2z1xJz/UblrioIyPLGL65JsOGIC7aGWIuW8JgmYPdMsI5Fb8SkRIeMg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195730; c=relaxed/simple;
	bh=fsL6R78yo1XIwU0DoOtvi4ZpYkwPnM2HAW93yVOxuYk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Fhd/8CO5YsBVoX8uAytmWiRliwwSl/86/eFehHtlVswxgSOlK077X84/ozNVlimFYtEEEzVAF1N+zX+iob4xpIwZDDSSIA7vAZfmVH/+djfcw5Y/SJYC7cF+d9Xz/41ZOztZOm5dzsxnBSwavRBimtXGA907haAjPgyedDeHK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=sqjMiLHW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/NR7CVK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="sqjMiLHW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/NR7CVK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D29057A002B;
	Tue, 19 May 2026 09:02:07 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 09:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779195727;
	 x=1779282127; bh=+0MRqd1OjWt8SYiTt49fm/XBiRze4j1TMiYODb85HtM=; b=
	sqjMiLHWDNc+riMvYWWdRDCKGXDbCgSqLwoIGKgeXyfvkMeVgmeEFiuWQGdqTYTu
	RmomLFBRr5usn2DYCKvxLFxqDs2r3USu8g+x6o/n351QmndoPXFoXmX49XN1Omta
	RRQ0jyAEgfEo5Ro8dRdFpFozu5aJ7UgHWvs95DpJXmgGQ1sHjB37LoMinUN8ibnt
	m/QHBk1THpM7Wf9C3dGUzbwAPcacD/J7tXSm32iu3hkoV987YdWC+xoS5gcjChE5
	tNz8Nh84xZ393oyi6dGNXFZNWh1NvZP53Nve0BcX1i7E0iwWCKIkzaTOGBiAceZp
	Vs2eTDU0cnW/IzMMHDvWPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779195727; x=
	1779282127; bh=+0MRqd1OjWt8SYiTt49fm/XBiRze4j1TMiYODb85HtM=; b=b
	/NR7CVKXoZd4ttVCFvT8rZuw0uwGUDERo1YEa7i6KrvyI4H4Qp08rfJjw5hRZdaF
	vfGLZc5ZahbhiOcJdpk6Hb5jgorOX5Qfs2Avq+zfwF5I8hpP82y57hpJs3ZjTsLH
	TKOwSi1goLFZskNbvFSk8v1MJHPNcUYAh/b+BdRWeyEyN9xnbapoLOvTTZ6bhZ60
	kjcdYrPyt3l+qU9boQOjMlg03mWXt+5Z98d457K2OkEkcq8wrA752sFAXY7KKFE0
	n3Zc6Qy9+fa8r+bRp3Qj3tqcUkiiv60iZuBoOvDn6UObh9m1cYCKO+Di1l8EBKbp
	EUYd7OocQmj5FIQ3V1pVg==
X-ME-Sender: <xms:T18Maq1-BpbpbilKVzzzGuHMRWAK1E44umymG7QzTHhck0d_VcUAcA>
    <xme:T18Man4xnl8RreoxunfUtSEP_k-GuF5jKkc_3YhpvTxcIMXt73OKwPpg0YnpTt1KQ
    ffkiIxXzZIZ56tsK6JG_qeRYmmWzEZFjO2ukM_CJalh42Yk3kgysA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedukedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfrfhivghr
    rhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggrrhhrvgdrshhhqeenucggtffrrghtth
    gvrhhnpeetgeeivdffhfeihedvkeefueekgeeivdekheekjeeuieejiedtffdtjeetvdff
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpih
    gvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprh
    gtphhtthhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthht
    ohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepvghrihgtvhhhsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidrug
    gvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:T18MasfABFdzd_E5vPQfLtvlAwLE5GeajO9A_B4zEHA0gaNwmEy_OA>
    <xmx:T18MaoQ--u09csj5zOcB-S6xQqY0dHPoIsiumCf8r25pVOcK8YqdAA>
    <xmx:T18MataRQbWo_Dh6og_9SVIBwdo2ZJ_AR6NXFmsMwVJxjhxPqiz3cw>
    <xmx:T18MajdXoqnJ-8jviuldDM0hfQBU82KrONmr9WtSMiuJJ8mzhsK_WQ>
    <xmx:T18Malk3lIxVNC64p3LmguNIIRJZED6QAM4_czPqlEphsEf-MvfNYzoM>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 271DE216008A; Tue, 19 May 2026 09:02:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 19 May 2026 15:01:46 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: asmadeus <asmadeus@codewreck.org>
Cc: "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Laight" <david.laight.linux@gmail.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <babcc401-e78b-4086-80b0-087e927806dd@app.fastmail.com>
In-Reply-To: <agxXUItqeMqTrESo@codewreck.org>
References: <20260512132032.369281-1-pierre@barre.sh>
 <agxXUItqeMqTrESo@codewreck.org>
Subject: Re: [PATCH 1/2] 9p: use kvzalloc for readdir buffer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks!

On Tue, May 19, 2026, at 14:28, Dominique Martinet wrote:
> Pierre Barre wrote on Tue, May 12, 2026 at 01:20:31PM +0000:
>> The readdir buffer is sized to msize, so kzalloc() can fail under
>> fragmentation with a page allocation failure in v9fs_alloc_rdir_buf()
>> / v9fs_dir_readdir_dotl().
>> 
>> The buffer is only a response sink and is never pack_sg_list()'d,
>> so kvzalloc() is safe for all transports, unlike the fcall buffers
>> fixed in e21d451a82f3 ("9p: Use kvmalloc for message buffers on
>> supported transports").
>
> Thanks, I need to run some tests but picked both patchs up for testing
> When Time Allows before pushing to -next;
> I think they're sane enough in this version.
>
> -- 
> Dominique
