Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520C1684A4
	for <v9fs@lists.linux.dev>; Wed,  7 Jan 2026 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745687; cv=none; b=ZkDoYTdXf2xEWgQvYpuTiHo4WmC6xX3tp12ih+WBG91tBnul45XMhLT00B6ilLEiq3cF6kXhhleL+EAjHzlgzSp+8YmGVvFBxPBZjEOzX1UdAqg6Mk4dmssWQVnmJ2plAFGcNNF0SS1EtgfSQGSL+CzlfzmYlxX5bPzMr+hOENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745687; c=relaxed/simple;
	bh=rEK6LJYN5rGFcmWudEhvxUWcSrPKDSaC9whqIwOUHhM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MIx9HawVhPB3bh6x/1De0HRfzka7PEj3pt3lWMpM7VQFcH8hdL+dY98eU1me6UcQBQp/rxr/nDiMzCQ1fXO5cAjQ9oY3uEKEb+FviTatQyFtde9eKynvjsyPiptSMC6aV9VF9yyb7acA9VnyJUdQtFHIlIpSBU8SxUq+SxeiroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=KV37jeFc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAZhRglv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="KV37jeFc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAZhRglv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D28F14000CF;
	Tue,  6 Jan 2026 19:28:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 19:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767745683;
	 x=1767832083; bh=zGxv7vPGmAPAbBKGn5NrxjMMbxcQP5+u925yoQWoIug=; b=
	KV37jeFcyi58fM0sTMB+wxbRgP8T1gxLbDfCPJUVJWY/drSXTec9/wPjmSNPS/Tb
	PtrnrC9DeyGzji/BeKbbs4Ph7e25DoQd7KmkGqYiY2VbS8RY+WXZRqWqQOTSUz0W
	xvhsb0LX87iuigIp7zmOviY9j9OhLdzcbe3PoifH958L3TlK3XlkIZTh5ewdqWt4
	47y3sFysuGavCI58MEycUjYDgMTmkVe7MqjNxsgamAUoOwDsoaOrvKUgP5YDSPjw
	11SuMO3WEPgovk+C440O78hbPVGO9gAaDLYjMjz9oaWp4V6FCNnm4AJtk3dYfQWq
	byft679HgYwaZpY8cTFh2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767745683; x=
	1767832083; bh=zGxv7vPGmAPAbBKGn5NrxjMMbxcQP5+u925yoQWoIug=; b=M
	AZhRglvj68HPUmabzUeFRVPayIBYnLN6Znd6XXm0D/X5mwGKPQEd7VxSdm4PwuoE
	mxE17Sdhcsk0bHrWEvzhpp9tNYeKjLgB2o52ylFNyiblUleFrhQfVvtw6GecjVFB
	sOdLlorkFKtei8tD8P756TEAE4gzpe9bWGMMesW6fQ8WaGBeaapdvaJVJ3gJfhkw
	61puWRxG8k2nSyd4hsMb6cdjO5ArwSB+sh09hBY3rbh7us8GuAhSeQMDiqCxnl4w
	c6FSXjG3Kcgnt2wfyjO0+aaL8dqpqMg+3kxXMQ3aD0Iw8rsOu6rX5+tGu1R5AnPO
	RBDcwO1FBgb8/AWKlEuwg==
X-ME-Sender: <xms:kqhdaQpRH43NyP1t7nr64qycRHVVvbk5H5nt2s0YApYz35yW1y9Agg>
    <xme:kqhdaXXrCykD-rLHq-q4tlFGp4TUyGNk6iIjsHYj9V3PiWd6daAM0FsPFp9mQ5CTS
    _HSePJhX8JcDtOLSMTslzKWX_rIDdnmcug9r7CYdIfjWlOPDhV2NA>
X-ME-Received: <xmr:kqhdaTYzL_2atOTJFYWh6eK2lQxVAyc58ZyFb2dmf9ZH1okHajxFaPGdel15acORmh0lSe6y9ujYqc6pFOlwdwrhqdZRHu-qrZP_cQCuQ0tuWFrOiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtddvnecuhfhrohhmpefrihgvrhhr
    vgcuuegrrhhrvgcuoehpihgvrhhrvgessggrrhhrvgdrshhhqeenucggtffrrghtthgvrh
    hnpeduhedthfdtfefhkedvvefghffhleetleeiffegudeuuedufeevtefgudelfeffgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhivghrrhgvsegsrghrrhgvrdhshhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugigpoh
    hsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopegvrhhitghvhheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpth
    htoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtohepughh
    ohifvghllhhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehvlehfsheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kqhdacexMJEY12rEsmlONsWfhy-SUjOjiLc3B-VSB0YwAnfvF1Kh0Q>
    <xmx:kqhdaV3XwnqUhuJJ1PbMCRc4Lz12pPliId3uHPkzrqdX7F4WLsOVhw>
    <xmx:kqhdabI7mBBwZPGmjeu0ruxN0_GyhnMbZfZygY0p1M1FOvXC_5Megg>
    <xmx:kqhdacEUGM59HOfWl6QPSQZyp7Mw7w5bQgflQB4nDfoBLuTQIdMfVw>
    <xmx:k6hdaWIBkSg9oJ3hWsh1a2x_RldmhTtYPxMvj2KL7Co7q_dgRQ66MOXg>
Feedback-ID: i97614980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 19:28:01 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2] 9p: fix i_size update race in getattr with writeback
 caching
From: Pierre Barre <pierre@barre.sh>
In-Reply-To: <2025543.PYKUYFuaPT@weasel>
Date: Wed, 7 Jan 2026 01:27:50 +0100
Cc: ericvh@kernel.org,
 lucho@ionkov.net,
 asmadeus <asmadeus@codewreck.org>,
 David Howells <dhowells@redhat.com>,
 v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <64008E3D-7EEE-4E6C-9392-986C1D8E8858@barre.sh>
References: <20251227180137.730385-1-pierre@barre.sh>
 <2025543.PYKUYFuaPT@weasel>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On 5 Jan 2026, at 12:35, Christian Schoenebeck =
<linux_oss@crudebyte.com> wrote:
>=20
> On Saturday, 27 December 2025 19:01:37 CET Pierre Barre wrote:
>> With writeback caching (cache=3Dmmap), v9fs_stat2inode() and
>> v9fs_stat2inode_dotl() unconditionally overwrite i_size from the =
server
>> response, even when dirty pages may exist locally. This causes =
processes
>> using lseek(SEEK_END) to see incorrect file sizes, leading to data
>> corruption when extending files while concurrent stat() calls occur.
>>=20
>> Fix by passing V9FS_STAT2INODE_KEEP_ISIZE when CACHE_WRITEBACK is
>> enabled to preserve the client's authoritative i_size.
>>=20
>> Signed-off-by: Pierre Barre <pierre@barre.sh>
>> ---
>=20
> Adding David Howells to this discussion.
>=20
> David, I read today that you suggested [1] to go for a wait approach =
instead?
> So somewhat similar to what Pierre suggested in v1 [2].

FWIW, I tested the initial approach I described and this seems to result =
in no real performance improvements compared to not using any writeback =
caching at all.

Best,
Pierre

> [1] =
https://lore.kernel.org/all/1696785.1767599663@warthog.procyon.org.uk/
> [2] =
https://lore.kernel.org/all/20251227083751.715152-1-pierre@barre.sh/
>=20
> I understand the point about cifs and nfs, where you must expect =
foreign
> changes on server side by another client.
>=20
> For 9pfs though IMO it would make sense to distinguish:
>=20
> for cache=3Dloose (and cache=3Dfscache?) we are not expecting host =
side changes,
> so we could safely go for the approach suggested by this patch here =
and not
> wait for flushing dirty data and just use the locally cached file size =
(for
> performance reasons).
>=20
> And for all other cache modes going for the cifs/nfs approach and wait =
for
> flushing? Does this make sense?
>=20
> I just tested this reported issue with the following reproducer:
>=20
> --------------------------
>=20
> #!/bin/bash
>=20
> rm -f foo.txt
>=20
> for i in {1..50}
> do
>  echo $i >> foo.txt &
>  ls -lha foo.txt &
> done
>=20
> sync
>=20
> cat foo.txt
>=20
> echo
>=20
> wc -l foo.txt
>=20
> --------------------------
>=20
> For cache=3Dloose I couldn't reproduce, but with cache=3Dmmap I could =
reproduce
> data corruption, folio writeback hangup and the following error =
message:
>=20
> [   60.847671] [append] R=3D134d: No submit
>=20
> ...
>=20
> [  243.153292] INFO: task sync:986 blocked for more than 120 seconds.
> [  243.161516]       Tainted: G            E       6.19.0-rc1+ #107
> [  243.168847] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
> [  243.178702] task:sync            state:D stack:0     pid:986   =
tgid:986   ppid:884    task_flags:0x400000 flags:0x00080002
> [  243.190379] Call Trace:
> [  243.192285]  <TASK>
>=20
> [  243.193891]  __schedule (kernel/sched/core.c:5256 =
kernel/sched/core.c:6863)
> [  243.195999]  schedule (kernel/sched/core.c:6946 =
kernel/sched/core.c:6960)
> [  243.197730]  io_schedule (kernel/sched/core.c:7764 (discriminator =
1) kernel/sched/core.c:7790 (discriminator 1))
> [  243.199418]  folio_wait_bit_common (mm/filemap.c:1312)
> [  243.201451]  ? __pfx_wake_page_function (mm/filemap.c:1134)
> [  243.203399]  folio_wait_writeback =
(./arch/x86/include/asm/bitops.h:202 ./arch/x86/include/asm/bitops.h:232 =
./include/asm-generic/bitops/instrumented-non-atomic.h:142 =
./include/linux/page-flags.h:597 mm/page-writeback.c:3087)
> [  243.205371]  __filemap_fdatawait_range (mm/filemap.c:529 =
(discriminator 1))
> [  243.207377]  ? _raw_spin_unlock =
(./include/linux/spinlock_api_smp.h:143 (discriminator 3) =
kernel/locking/spinlock.c:186 (discriminator 3))
> [  243.209305]  ? finish_task_switch.isra.0 =
(./arch/x86/include/asm/paravirt.h:671 kernel/sched/sched.h:1570 =
kernel/sched/core.c:4995 kernel/sched/core.c:5112)
> [  243.212030]  ? __schedule (kernel/sched/core.c:5259)
> [  243.214083]  ? wb_wait_for_completion (fs/fs-writeback.c:227)
> [  243.215925]  filemap_fdatawait_keep_errors =
(./arch/x86/include/asm/bitops.h:202 ./arch/x86/include/asm/bitops.h:232 =
./include/asm-generic/bitops/instrumented-non-atomic.h:142 =
mm/filemap.c:363 mm/filemap.c:627)
> [  243.217628]  sync_inodes_sb (./include/linux/sched.h:2062 =
fs/fs-writeback.c:2777 fs/fs-writeback.c:2897)
> [  243.218914]  ? __pfx_sync_inodes_one_sb (fs/sync.c:75)
> [  243.220186]  __iterate_supers (fs/super.c:64 fs/super.c:925)
> [  243.221601]  ksys_sync (fs/sync.c:103)
> [  243.222746]  __do_sys_sync (fs/sync.c:115)
> [  243.223950]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 =
(discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> [  243.226140]  entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:131)
> [  243.228375] RIP: 0033:0x7f51e4613707
> [  243.230260] RSP: 002b:00007ffdb2fccad8 EFLAGS: 00000246 ORIG_RAX: =
00000000000000a2
> [  243.234092] RAX: ffffffffffffffda RBX: 00007ffdb2fccc38 RCX: =
00007f51e4613707
> [  243.238153] RDX: 00007f51e46f3501 RSI: 00007ffdb2fcef3e RDI: =
00007f51e46ae557
> [  243.241063] RBP: 0000000000000001 R08: 0000000000000000 R09: =
0000000000000000
> [  243.244028] R10: 00007f51e45be0d0 R11: 0000000000000246 R12: =
00005568f2d350fb
> [  243.247586] R13: 0000000000000000 R14: 0000000000000000 R15: =
00005568f2d37b00
> [  243.251622]  </TASK>
>=20
> BTW running this script with cache=3Dloose made me realize that Linux =
9p client
> is always requesting server for every "ls foo.txt", which makes it =
extremely
> slow unnecessarily.
>=20
>> fs/9p/vfs_inode.c      | 7 ++++++-
>> fs/9p/vfs_inode_dotl.c | 7 ++++++-
>> 2 files changed, 12 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
>> index 97abe65bf7c1..bfba21f5d8a9 100644
>> --- a/fs/9p/vfs_inode.c
>> +++ b/fs/9p/vfs_inode.c
>> @@ -993,7 +993,12 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const =
struct
>> path *path, if (IS_ERR(st))
>> return PTR_ERR(st);
>>=20
>> - v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb, 0);
>> + /*
>> + * With writeback caching, the client is authoritative for i_size.
>> + * Don't let the server overwrite it with a potentially stale value.
>> + */
>> + v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb,
>> + (v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);
>> generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), =
stat);
>>=20
>> p9stat_free(st);
>> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
>> index 643e759eacb2..67a0ded2e223 100644
>> --- a/fs/9p/vfs_inode_dotl.c
>> +++ b/fs/9p/vfs_inode_dotl.c
>> @@ -453,7 +453,12 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
>> if (IS_ERR(st))
>> return PTR_ERR(st);
>>=20
>> - v9fs_stat2inode_dotl(st, d_inode(dentry), 0);
>> + /*
>> + * With writeback caching, the client is authoritative for i_size.
>> + * Don't let the server overwrite it with a potentially stale value.
>> + */
>> + v9fs_stat2inode_dotl(st, d_inode(dentry),
>> + (v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);
>> generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), =
stat);
>> /* Change block size to what the server returned */
>> stat->blksize =3D st->st_blksize;
>=20
>=20
>=20

