Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922734CFD1
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776343806; cv=none; b=AyZ3OepS5txt5yO030iMzufM9S0SpAO3ue5MhdlPaj5uEmbFVo/nVw+asaSOFx0PmLrOTzs5nnS3P8kD/IzKBMCTYIMLPb3DeDVIFbx19GB7pHeaWbW5GfZEoYvlK+qmpRfnZ9wiAoz+MkIhRUxK/1TxxtKPsQ/W0ChH3HmiLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776343806; c=relaxed/simple;
	bh=sNx2BMzxPSaSJr9GxeLMneyvSbcCwdFfrWEjQDBqmfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcENPu0TzP934TgvdnsYmHrPaTziP0OoW1ieRw6dj3141tKIXSIIxxlwiLI7f8FkPq2ybtX2U71EbKWVqNosQM4ch6wWvW25whHNPwDNWyOp+XYiYkvZoDSfAFe2N3RKd26YFFzcuhTg78U30WhHFnVKi5g1uAPZ8qChi2UqYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [10.88.129.127] (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 8D21D2333B;
	Thu, 16 Apr 2026 15:49:59 +0300 (MSK)
Message-ID: <e3e9146a-d820-d35d-cebd-e7e7e4a2fa24@basealt.ru>
Date: Thu, 16 Apr 2026 15:49:59 +0300
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal
 signal
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260415155237.182891-1-kovalev@altlinux.org>
 <aeA-WpUyfWrYrvaE@codewreck.org>
Content-Language: en-US
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <aeA-WpUyfWrYrvaE@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dominique,

On 4/16/26 04:41, Dominique Martinet wrote:
> Vasiliy Kovalev wrote on Wed, Apr 15, 2026 at 06:52:37PM +0300:
>> The same defect is present in stable kernels back to 5.4. On those
>> kernels the infinite loop is broken earlier by a second SIGKILL from
>> the parent process (e.g. kill_and_wait() retrying after a timeout),
>> resulting in a zombie process and a shutdown delay rather than a
>> permanent D-state hang, but the underlying flaw is the same.
>>
>> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> It's unfortunately not that simple, just leaving here will leak things.

Following up on your concern about leaking things (as mentioned in the
thread with Shigeru Yoshida's patch) - I did some tracing with `printk`
inside `p9_req_put` and `p9_tag_remove` to see exactly what happens to
the request lifecycle with my proposed patch vs Shigeru's approach:

diff --git a/net/9p/client.c b/net/9p/client.c
index 748b92d3f0c1..4e8f4e0195b4 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -274,10 +274,13 @@ static void p9_tag_remove(struct p9_client *c, 
struct p9_req_t *r)
         spin_lock_irqsave(&c->lock, flags);
         idr_remove(&c->reqs, tag);
         spin_unlock_irqrestore(&c->lock, flags);
+       printk("tag %d removed from IDR\n", tag);
  }

  int p9_req_put(struct p9_client *c, struct p9_req_t *r)
  {
+       printk("p9_req_put req %p tag %d refcount before=%d\n",
+         r, r->tc.tag, refcount_read(&r->refcount));
         if (refcount_dec_and_test(&r->refcount)) {
                 p9_tag_remove(c, r);

There is a significant difference.

If we use Shigeru's approach [1] (preventing the flush from being
sent/processed using `!fatal_signal_pending(current)` in the condition),
the original request (tag 0) is never freed from the IDR. It creates a
definitive memory and tag leak:

[root@localhost]# ./repro
executing program
[   50.613200] p9_req_put req ff11000110157cb0 tag 65535 refcount before=3
[   50.663513] p9_req_put req ff11000110157cb0 tag 65535 refcount before=2
[   50.665156] p9_req_put req ff11000110157cb0 tag 65535 refcount before=1
[   50.666593] tag 65535 removed from IDR
executing program
[   50.688232] p9_req_put req ff11000110157ba0 tag 65535 refcount before=3
[   50.739634] p9_req_put req ff11000110157ba0 tag 65535 refcount before=2
[   50.741170] p9_req_put req ff11000110157ba0 tag 65535 refcount before=1
[   50.742587] tag 65535 removed from IDR
executing program
[   50.775708] p9_req_put req ff11000110157a90 tag 65535 refcount before=3
[   50.825104] p9_req_put req ff11000110157a90 tag 65535 refcount before=2
[   50.827719] p9_req_put req ff11000110157a90 tag 65535 refcount before=1
[   50.830432] tag 65535 removed from IDR
executing program
...

[1] 
https://lore.kernel.org/all/20260322111848.2837057-1-syoshida@redhat.com/

However, with my patch (jumping to `recalc_sigpending` *inside* the
`P9_TFLUSH` wait loop), the logic works cleanly due to the `refcount`
mechanism:

[root@localhost]# ./repro
executing program
[   48.875093] p9_req_put req ff110001056fdcb0 tag 65535 refcount before=3
[   48.925981] p9_req_put req ff110001056fdba0 tag 0 refcount before=3
[   53.873969] p9_req_put req ff110001056fdba0 tag 0 refcount before=2
[   53.876638] p9_req_put req ff110001056fdcb0 tag 65535 refcount before=2
[   53.879882] p9_req_put req ff110001056fdba0 tag 0 refcount before=1
[   53.882505] tag 0 removed from IDR
[   53.884184] p9_req_put req ff110001056fdcb0 tag 65535 refcount before=1
[   53.886905] tag 65535 removed from IDR
executing program
[   53.914764] p9_req_put req ff1100010ca97a90 tag 65535 refcount before=3
[   53.967191] p9_req_put req ff1100010ca97980 tag 0 refcount before=3
[   58.909626] p9_req_put req ff1100010ca97980 tag 0 refcount before=2
[   58.912420] p9_req_put req ff1100010ca97a90 tag 65535 refcount before=2
[   58.915358] p9_req_put req ff1100010ca97980 tag 0 refcount before=1
[   58.918478] tag 0 removed from IDR
[   58.920730] p9_req_put req ff1100010ca97a90 tag 65535 refcount before=1
[   58.923715] tag 65535 removed from IDR
executing program
[   58.946905] p9_req_put req ff1100010c5a3870 tag 65535 refcount before=3
[   58.998260] p9_req_put req ff1100010c5a3760 tag 0 refcount before=3
[   63.945960] p9_req_put req ff1100010c5a3760 tag 0 refcount before=2
[   63.948549] p9_req_put req ff1100010c5a3870 tag 65535 refcount before=2
[   63.951153] p9_req_put req ff1100010c5a3760 tag 0 refcount before=1
[   63.953651] tag 0 removed from IDR
[   63.957254] p9_req_put req ff1100010c5a3870 tag 65535 refcount before=1
[   63.960655] tag 65535 removed from IDR
executing program
...

1. The dying thread breaks out of the loop and calls `p9_req_put()`.
The refcount correctly drops from 2 to 1.

2. The tag is NOT removed from the IDR yet, preventing any Use-After-Free.
The request is safely "orphaned".

3. Shortly after, when the parent process closes the pipe/socket (or the
transport is torn down due to process exit), the transport layer cleans up
the pending requests. It calls the final `p9_req_put()`, refcount hits 0,
and the tag is properly removed from the IDR.

My logs clearly show `refcount before=1 -> tag 0 removed from IDR` upon
transport teardown, proving there is no permanent leak when breaking out
of the `TFLUSH` loop this way.

Since this safely resolves the permanent D-state hang during
`coredump_wait()` without causing the UAF or leaks that plagued earlier
kernels (pre-`728356dedeff` ("9p: Add refcount to p9_req_t")), do you
think this pragmatic fix is acceptable for mainline and stable?

> There was another patch last month, help is welcome,
> please see https://lore.kernel.org/r/ab_b-95Ok9zLQCdn@codewreck.org

While the ideal long-term goal is the asynchronous implementation (as
seen in your 9p-async-v2 branch [2]), this patch serves as a reliable
intermediate solution for a critical regression.

[2] https://github.com/martinetd/linux/commits/9p-async-v2

> (By the way, what's with the rekindled interest on this?...)
> 

The issue was identified by Syzkaller, and I have a stable C reproducer
that consistently triggers the hang. There is also a similar report on
Syzbot with a nearly identical reproducer:
https://syzkaller.appspot.com/text?tag=ReproC&x=156aa534580000

-- 
Thanks,
Vasiliy
