Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005DE335072
	for <v9fs@lists.linux.dev>; Wed, 15 Apr 2026 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245275; cv=none; b=GyFn7uOaN9G1ziIhhFctN9SvyLXggtZ8yD2OKxVjGvwgKZ119Q3uZjGF8ld3CbVEhaC8iWiymDkBs7JXcjxFizaIofk9Em4eE1JO+jGAU7eHmhmlz33cJ9uysxZSeBaqPyDe/8uxY08DRG6m5Rm0owqEY0lk5KkK4NmV7VJAZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245275; c=relaxed/simple;
	bh=Lvupuq8xdit5K2I0Jzx3LCJZdtqgDFY+C5+XvoWGHeQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZElii+eJq4NGe+zPXvhj7ZdPX7s6ba/C3DC9pZS8lHU9PYwCXzj5OxfaNBrW7dd672OecqwaK8pBwVui1aUoH5E0FdwdkKSqQMs4KbneAm71+7xHsioaBuLnA1FtnSyezHymU1ok+bcn0O93RfGucnP496A5UhSsYPVaxJ1ushg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=oLjwnHdz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gixh7Io0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="oLjwnHdz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gixh7Io0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4EF8CEC043F;
	Wed, 15 Apr 2026 05:27:52 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 05:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776245272;
	 x=1776331672; bh=2WqTYNXZhCFvSA9DIiElo3vl0X3y7dli8NSKan/BrfI=; b=
	oLjwnHdzgWK4bZE+/BAfgFCtFMPvbMdyMvcjM0tFjw3QEOpBn7s6MHwkOWQWs26l
	ge9r9L0yh/QaYi8M6ok2a0YoIgFIcFLK/7p4rsMosPhQUVolaSuZM/YScfRNt7W4
	phRL15Qkrs+Wed3Ktvs5bH0k5zwNOP92wsKRYiOZGW6n2sgpbJJKFyd1v1xvdeD/
	m6SkUmystNlzo3CoFHqHtAJfFCxmOLTWBVxtB4IvoXVBfM+0iWSyfBNcqAHHtPoD
	omEdhIoOZ4S/Za/UbZKt/UCFXAQuw5JkbFh1j0cqabjqjfE1loSWdAiJoKJxZYFL
	a13PLAspcvATi9oQSDOkaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776245272; x=
	1776331672; bh=2WqTYNXZhCFvSA9DIiElo3vl0X3y7dli8NSKan/BrfI=; b=g
	ixh7Io00sTXLgoHhk/jJKsWmfGtuzAxE1NEl3dvwFtuJk4aAA3lLz4iUmflDROmz
	5tBfrv/jQHf0InsE6dI8YxB9IU7BumhkZl40uEe8zMvtJDvPM0hHfY7yxZuHeCZ7
	TmWX9SR8yR3vpSd1J95dwBpPIgeH5S5NIqvlM0nz+Hdrd4KaEUgVPYMAk9o9rwvl
	vWHfBWwiVC+oATyhdYF2jYIYRp7VotCbj//lJFhd/I+IUnm5CxUizB+obQkCIWXa
	HykO5vKCqgaFTssocBkaanjyi6rKBkuky9e0oB2HrA9JNxMf1XlC9Oz4ZY3f7Grc
	2c++e0mFcr3pM3/alTgYA==
X-ME-Sender: <xms:F1rfaSvHwb9rOZJMRJdOjz3ZiBc1LVdBY2JnElFaI_Xuvqc3Ksx0ZQ>
    <xme:F1rfaSRDpX8bvv8vyyR5GXBT1aiF5uuEDVG8JXekpK7OOw5w7aGUgSYTZU_BiekH-
    trJM811TtD7pxNAJH6aqPWZokkriOqZzV6Qxzry_oq-9gc4wSgsO-h5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfrihgvrhhr
    vgcuuegrrhhrvgdfuceophhivghrrhgvsegsrghrrhgvrdhshheqnecuggftrfgrthhtvg
    hrnhepleeuhfejjeefiefguefggfekveeffedvveefhfeggeekjeelkeffheelgfegheev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvg
    hushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegt
    rhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlih
    hnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhn
    vghtpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:F1rfacX7YthkCCxr8D-4WxAUxoYpnBiD2dQ2x-zuGRMJh51p0zQm_g>
    <xmx:F1rfaaqQQVK2gzx4KHUp9vL1VwWAuxCUEm1o03mLsGByR6BwezQTuA>
    <xmx:F1rfaQSwdSoesaZ8MwBF7N8VkN1v6TIA5BqOVqZPBqfX712JJq3b5Q>
    <xmx:F1rfac2EWBqwPkokHGY-od5jRLgKmBQIxTfxkYdZkz8wc3vYaanz3Q>
    <xmx:GFrfadfy_jM3vtUW8gZHCmh3eG-G5B6fo6VmHzWjhfK93DoEizKdX2ij>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C951EB60070; Wed, 15 Apr 2026 05:27:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 15 Apr 2026 11:27:21 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: "David Laight" <david.laight.linux@gmail.com>
Cc: "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>, asmadeus <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <a93672d6-1b99-4d4f-a8e4-c7f8b0d10b36@app.fastmail.com>
In-Reply-To: <20260415100157.4aa33364@pumpkin>
References: <06399e04-b019-4c3d-b941-5771b6ac33c2@app.fastmail.com>
 <20260415100157.4aa33364@pumpkin>
Subject: Re: [PATCH] 9p: use kvzalloc for readdir buffer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi David,

Perhaps what you describe can explain what I was seeing there: https://lore.kernel.org/v9fs/496d10b9-40fe-4f81-8014-37497c37ff63@app.fastmail.com/

Thanks,
Pierre

On Wed, Apr 15, 2026, at 11:01, David Laight wrote:
> On Wed, 15 Apr 2026 07:45:08 +0200
> "Pierre Barre" <pierre@barre.sh> wrote:
>
>> The readdir buffer is sized to msize, so kzalloc() can fail under
>> fragmentation with a page allocation failure in v9fs_alloc_rdir_buf()
>> / v9fs_dir_readdir_dotl().
>> 
>> The buffer is only a response sink and is never pack_sg_list()'d,
>> so kvzalloc() is safe for all transports, unlike the fcall buffers
>> fixed in e21d451a82f3.
>> 
>> Signed-off-by: Pierre Barre <pierre@barre.sh>
>> ---
>>  fs/9p/vfs_dir.c | 2 +-
>>  net/9p/client.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
>> index af7f72abbb76..487c177aae38 100644
>> --- a/fs/9p/vfs_dir.c
>> +++ b/fs/9p/vfs_dir.c
>> @@ -70,7 +70,7 @@ static struct p9_rdir *v9fs_alloc_rdir_buf(struct file *filp, int buflen)
>>         struct p9_fid *fid = filp->private_data;
>> 
>>         if (!fid->rdir)
>> -               fid->rdir = kzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);
>> +               fid->rdir = kvzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);
>
> That code isn't really well thought out at all.
> The default for buflen seems to be 128k + 24 - 24.
> struct p9_rdir adds another 8 bytes, I'm not sure whether that doubles it to
> 128k or just adds an extra page (which might be 64k not 4k).
> It also looks as though the user can specify an arbitrary buffers size (min 4k).
> So who knows how big that (and other associated) buffers actually are.
>
> The buffer seems to persist across readdir() system calls.
> I can't see any code that might attempt to honour seekdir().
> I hope there is a global lock that stops multiple threads issuing readdir()
> on the same fd in parallel.
>
> 	David
>
>>         return fid->rdir;
>>  }
>> 
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index f60d1d041adb..6d9b9054841e 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -765,7 +765,7 @@ static void p9_fid_destroy(struct p9_fid *fid)
>>         spin_lock_irqsave(&clnt->lock, flags);
>>         idr_remove(&clnt->fids, fid->fid);
>>         spin_unlock_irqrestore(&clnt->lock, flags);
>> -       kfree(fid->rdir);
>> +       kvfree(fid->rdir);
>>         kfree(fid);
>>  }
>> 
>> --
>> 2.51.0
>>
