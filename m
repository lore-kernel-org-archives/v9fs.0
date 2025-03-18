Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78801F755E;
	Tue, 18 Mar 2025 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332930; cv=none; b=VZOmTfJaBR8GegILKfMh0Hhl0vlPdaoCaIU1TU1bBuuSxusu+rcvhEDhIgk11+4BgjvEy+W8uj8eOkVVeO6ozmvZoD+xXT8cqlmPSOjTxmBM+6SNAJBDgiZO4TBZRY3Og+rFqu3oFufQ1mfpO3Rhg1IgXYenZNAxlZ4A7n7p3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332930; c=relaxed/simple;
	bh=UbriOW/G9dO2oX3E78VLJWlhyyuFgHeEcWqNyYrdOm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjkFzj9GruUjKmXBkeiQ3rxSghHGkh0F8MbeBnHxX01Ksl7wFRydr+ZVK52qTJjZ33LrRepBUhiAiMFexHLtexDcx1jkkUHsYhCHwhJihwyico37IRRAcENXWD/XQSUs+EU7h5dE+vnoOsGJ0E8ciauuBrV1L2rNuIVniK6UKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=BogtIbFx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="BogtIbFx"
Message-ID: <fd13d2e0-1ed2-4b63-ab3a-4cb650b45a2c@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742332916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3rVL5NtPGOGj2V0UQUWJI5zHq/89EL1iqRC9ONnsRs=;
	b=BogtIbFxY3ByXLndkvBLuYYF+rC0s7Q6G1xe/ZGMhc1132STkbDpxq7iEL6zQAgQ3t4vxz
	9u2tvxNE0sWk/4ZWLNIi1RWXFmi5u+GONQu++I1ldXrPWkt9MAeqXUHGbHVdddYNUZNBp9
	V452Ejwn9BcI3phw0/Z8yu80NeEbfm5U9agsl+csARaq9/pacXYeBnfrrLwZL3vAWbrW/v
	S0cR9PpOXIGGGo+EM1BoSn3BK12Mi90QPmBBZe35gHx7yyaOpqAIjziZRkHq681LfBiqhE
	iO0XIC89Jk3VkX7P4ONo8nlW4oBVHUUUbzjORucaXsDQBJjsmIilGR+6rQuq3A==
Date: Tue, 18 Mar 2025 22:21:52 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
To: Ignacio Encinas Rubio <ignacio.encinas@semidynamics.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-kernel-mentees@lists.linux.dev, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20250313-p9_conn_err_benign_data_race-v2-1-0bb9f45f6bb2@iencinas.com>
 <Z9dBfEf0naCsNrNv@codewreck.org>
 <0807e0cc-457b-49bd-bce5-a961ad7f0ffb@semidynamics.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <0807e0cc-457b-49bd-bce5-a961ad7f0ffb@semidynamics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Trimming CC to avoid spamming people (I hope that's ok)

Hello Dominique!

On 17/3/25 18:01, Ignacio Encinas Rubio wrote:
> On 16/3/25 22:24, Dominique Martinet wrote:
>> There's this access out of the lock so perhaps this should look like
>> this instead (with or without the READ_ONCE)
>>
>> +       err = READ_ONCE(m->err);
>> +       if (err < 0) {
>>                 spin_unlock(&m->req_lock);
>> -               return m->err;
>> +               return err;
> 
> Oops, this is embarrassing... Thanks for catching it.
> 
>> Anyway, m->err is only written exactly once so it doesn't matter the
>> least in practice, 
> 
> I think this one deserves a fix, I disagree :)
> 
>> and it looks like gcc generates exactly the same
>> thing (... even if I make that `return READ_ONCE(m->err)` which
>> surprises me a bit..), so this is just yak shaving.
> 
> This is weird... I'll double check because it shouldn't generate the
> same code as far as I know.

I had a bit of time to check this. I understood you said that (A)

	err = READ_ONCE(m->err);
	if (err < 0) {
		spin_unlock(&m->req_lock);
		return READ_ONCE(m->err);
	}

compiles to the same thing as (B)

	err = READ_ONCE(m->err);
	if (err < 0) {
		spin_unlock(&m->req_lock);
		return err;
	}

if you didn't say this, just ignore this email :). With gcc (GCC) 
14.2.1 20250110 (Red Hat 14.2.1-7) I'm seeing a difference:

``` (A)
movl	40(%rbx), %eax	# MEM[(const volatile int *)ts_13 + 40B], _14
# net/9p/trans_fd.c:679: 	if (err < 0) {
testl	%eax, %eax	# _14
js	.L323	#,

[...]

.L323:
# ./include/linux/spinlock.h:391: 	raw_spin_unlock(&lock->rlock);
	movq	%r12, %rdi	# _21,
	call	_raw_spin_unlock	#
# net/9p/trans_fd.c:681: 		return READ_ONCE(m->err);
	movl	40(%rbx), %eax	# MEM[(const volatile int *)ts_13 + 40B], <retval>
# net/9p/trans_fd.c:697: }
	popq	%rbx	#
	popq	%rbp	#
	popq	%r12	#
	jmp	__x86_return_thunk
```

``` (B)
movl	40(%rbx), %r12d	# MEM[(const volatile int *)ts_13 + 40B], <retval>
# net/9p/trans_fd.c:679: 	if (err < 0) {
testl	%r12d, %r12d	# <retval>
js	.L323	#,

[...]

.L323:
# ./include/linux/spinlock.h:391: 	raw_spin_unlock(&lock->rlock);
	movq	%r13, %rdi	# _20,
	call	_raw_spin_unlock	#
# net/9p/trans_fd.c:697: }
	movl	%r12d, %eax	# <retval>,
	popq	%rbx	#
	popq	%rbp	#
	popq	%r12	#
	popq	%r13	#
	jmp	__x86_return_thunk
```

(A) performs another memory read after the spinlock has been unlocked
while (B) reuses the value from the register. If you're using an old GCC
it might have bugs. I can't recall where exactly but I have seen links
to GCC bugs regarding this issues somewhere (LWN posts or kernel docs?)

To get the assembly I just got the command from .trans_fd.o.cmd and 
added "-S -fverbose-asm" (I can't really read x86 assembly)
