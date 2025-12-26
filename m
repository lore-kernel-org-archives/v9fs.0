Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0956314B62
	for <v9fs@lists.linux.dev>; Fri, 26 Dec 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766754836; cv=none; b=c+r48nFoUmjoCT6A9mnP+09lMipvamTZXmtlgztBfx5i0t58B+yQhkOtKo/LOMnqPKHQjrqGdNuJgl4meUuGq/Qgm5DYQeS4hb9UBD+i9C/3w4a5kGJJDTybrd9aJ3dls8/QjgH1CMPrXrnYMonA+2keBV5TnFGzeyZs0MFhGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766754836; c=relaxed/simple;
	bh=zS4xcxztic1FoNAY75TmpsO/uawis3mjIn3zNgd9CCs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V69vJc1V0yzds+gfiQRMLwXL/mMSQZjqWtbq7qjPDB2grqH1KlaAIS+l2laLZPeWFJeSBkgU9TKpwbiIvwnvTcviYIKZRftdol4vCg8qrGQv2Ik5aAwrILV9I0HvGXmAnCltSrLRO+KK6rdOeVVsDFcxGUN+7DrqrBn8jkSHMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=ML5ULuIk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vf1UjDPx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="ML5ULuIk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vf1UjDPx"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E7701D00025;
	Fri, 26 Dec 2025 08:13:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 26 Dec 2025 08:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766754833;
	 x=1766841233; bh=ahtFGo6TwK2jNmFvgd3RU++nfpO550/N3EPQHUVuyOQ=; b=
	ML5ULuIkm1ZmkWyHbsz1MTuc8SE1QT4Sgo5PjcTnFG4jMk+u2H6NPJra9LgiX6vN
	ZRVmPUctDjVme7hz6i5D09RmIHXy40FotB+hmayOeINz7BaBs5EC6xKMEbFIfAFL
	Ra8hSDem2CVPQOvq+l7syYItNxfnyc1703Z4nJW3x6P34n5yb8T8iokOeRvTU6A2
	B+eeuqiOyIlnSmuANK5tDAabQmczygvvWCE+Ng+ImHrXvElPJpe5lxJPQ30sWCOc
	SQM5yGrTz3/yMBeDuSGsyBoK7QW542GUCZ7ka6DkAqJAthcM/UjJDikJO5BicOtk
	vv+0H2sSe4/N8OzlSwPfUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766754833; x=
	1766841233; bh=ahtFGo6TwK2jNmFvgd3RU++nfpO550/N3EPQHUVuyOQ=; b=v
	f1UjDPxMmh6UOYA7Y0ZH/F4nQ3lrK85ioaC1Hi6e6jHiScP5lUp/uSM1yIi7wSVt
	aP44171JuqxbR/NwRADWXFz5paIrl+OeftGPnFW1NE3bY1xH9gLmXcKasa1PgRQ7
	Zt5jZpgQhriWmJU9B8yxQkYVdUy3vxzJ5/bRpuwCAtKZjKRAbrslEeh4ag7QUdof
	jntVlmd0vY7bFuCuQv2CoCi2F5phrpqys04+YB8PPyvmGAy5YNqN9JCr4X+IH8io
	XsHRh1gPImEEzuRlsSd0802GHKXd7CDMSr3F7ux9jSfo86Rggg3UvvGP58sGi2gM
	k6RYy9uJ7QHzsLn+fDTZQ==
X-ME-Sender: <xms:EIpOabV_rjBLx2oDaJJJOyDWndxbQL0RlJvet-K4Vfmhgedd3AcjKA>
    <xme:EIpOaURslMB-bXEpX7VZFxdisl2S0VRbor4fdFIB-e3FthmyUTN9t7ZaYiYN4POJ1
    WVeQ_PTDTuXjw5aMKxO0saf_1O-Mntk0YP07zxe8wmAfXuz6iauEImb>
X-ME-Received: <xmr:EIpOaVkF3GYjSbKZSmUC30OHuJ1e3ePuPUQdDbNv5YFzyBWCyT4CYOLTu5AaEgbtkzCCesjBA9IOolInCQJy4IQf_lFq20Bh3QL8MXAoGN6urF8IDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeikeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtvdenucfhrhhomheprfhivghrrhgv
    uceurghrrhgvuceophhivghrrhgvsegsrghrrhgvrdhshheqnecuggftrfgrthhtvghrnh
    epudehtdfhtdefhfekvdevgffhhfelteelieffgeduueeuudefveetgfduleeffffgnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigpghosh
    hssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtoheprghsmhgruggvuhhssegtohgu
    vgifrhgvtghkrdhorhhgpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopehvlehf
    sheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguhhhofigvlhhlshes
    rhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:EIpOaa6c1eZSe2w-_xWVWZpwaU79860tQeB8UjkGZ5ios1HeG8A20Q>
    <xmx:EIpOabhl-vsRhKfJVSgYECzfM6o0dmdDdWgKPqR1-elyJUjPl2Wurg>
    <xmx:EIpOaXGaCSUzCW15zTRQaCKTTYakxqb8eqpGeKORD7D0MsQw-Pr8Gw>
    <xmx:EIpOaRQGkVcaR0VYzjW4eNupF13aFBYbYWDId31T1KTx5Zpp8vc4LA>
    <xmx:EYpOab-E343-QZQMOOdQfBeNAGZ5TkHkSbaoc9SnVq9DOZ64yTy9rJIm>
Feedback-ID: i97614980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Dec 2025 08:13:51 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [BUG] 9p: data corruption with cache=mmap under concurrent
 stat/write
From: Pierre Barre <pierre@barre.sh>
In-Reply-To: <81e47329-a3e9-411f-aec3-2a1477624043@app.fastmail.com>
Date: Fri, 26 Dec 2025 14:13:40 +0100
Cc: ericvh@kernel.org,
 lucho@ionkov.net,
 v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C48C493A-478A-4518-9EA2-CB52205CC1F0@barre.sh>
References: <aea6cd1d-ff2b-4288-8196-edfdfd1539f6@app.fastmail.com>
 <aUxqVn0DO7ee9K2_@codewreck.org> <5951517.DvuYhMxLoT@weasel>
 <81e47329-a3e9-411f-aec3-2a1477624043@app.fastmail.com>
To: Christian Schoenebeck <linux_oss@crudebyte.com>,
 asmadeus <asmadeus@codewreck.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

To clarify: the issue isn't with mmap access specifically. With =
cache=3Dmmap (which enables CACHE_WRITEBACK), PostgreSQL uses regular =
write() calls that go through the page cache with writeback caching.

Best,
Pierre

> On 25 Dec 2025, at 15:52, Pierre Barre <pierre@barre.sh> wrote:
>=20
> Hi Christian, Dominique,
>=20
> Thank you for your reply and merry christmas.
>=20
>>> unexpected data beyond EOF looks a lot like
>>> https://lkml.kernel.org/r/938162.1766233900@warthog.procyon.org.uk
>>>=20
>>> could you try with this patch?
>=20
> I will try this patch and report back.
>=20
>> ... you are seeing a 2nd issue? getattr() output should not be =
related to=20
>> mmap() access.
>=20
> What's strange is that this issue doesn't occur during normal Postgres =
operation or while just running benchmarks. I initially encountered it =
while running du -hs during a pgbench benchmark, and I've since been =
able to reproduce it consistently with watch -n 0.1 tree -ah. Running =
the benchmarks for hours never trigger this bug, but it (almost) =
immediately occurs during du -hs / tree -ah.
>=20
> Best,
> Pierre.
>=20
> On Thu, Dec 25, 2025, at 11:23, Christian Schoenebeck wrote:
>> On Wednesday, 24 December 2025 23:33:58 CET Dominique Martinet wrote:
>>> Hi Pierre,
>>>=20
>>> Pierre Barre wrote on Wed, Dec 24, 2025 at 03:29:01PM +0100:
>>>> I'm hitting data corruption using 9p with cache=3Dmmap when stat() =
is called
>>>> concurrently with writes.
>>> Thanks for the report
>>>=20
>>>> Environment:
>>>> - Kernel: v6.18.1-061801
>>>> - Mount options: cache=3Dmmap
>>>> - Transport: unix
>>>>=20
>>>> Reproducer:
>>>> 1. Mount 9p filesystem with cache=3Dmmap
>>>> 2. Run PostgreSQL with data directory on 9p mount
>>>> 3. Run pgbench workload
>>>> 4. Simultaneously run `watch -n 0.1 tree -ah` on the data directory
>>>>=20
>>>> PostgreSQL reports:
>>>>  ERROR: unexpected data beyond EOF in block N of relation "..."
>>>=20
>>> unexpected data beyond EOF looks a lot like
>>> https://lkml.kernel.org/r/938162.1766233900@warthog.procyon.org.uk
>>>=20
>>> could you try with this patch?
>>=20
>> Pierre, I am also confident that this patch will fix the EOF data =
issue you=20
>> encountered with PostgreSQL. However ...
>>=20
>>>>  HINT: This has been seen to occur with buggy kernels
>>>>=20
>>>> Analysis:
>>>>=20
>>>> The issue appears to be race conditions in getattr/setattr when =
using
>>>> writeback caching:
>>>>=20
>>>> 1. v9fs_vfs_getattr_dotl() condition checks `v9ses->cache` instead =
of
>>>>=20
>>>>   `v9ses->cache & CACHE_WRITEBACK`, triggering writeback flush for
>>>>   any cache mode
>>>>=20
>>>> 2. Both getattr and setattr call filemap_fdatawrite() which =
initiates
>>>>=20
>>>>   writeback but doesn't wait for completion. The subsequent server
>>>>   stat/wstat sees stale file size.
>>>>=20
>>>> Would using filemap_write_and_wait() instead be the correct fix?
>>=20
>> ... you are seeing a 2nd issue? getattr() output should not be =
related to=20
>> mmap() access.
>>=20
>> /Christian


