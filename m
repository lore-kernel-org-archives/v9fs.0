Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B08236445
	for <v9fs@lists.linux.dev>; Fri, 16 May 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395755; cv=none; b=AMLCYoV25zZucPJ+jtHxnkkKYwzKxyCGtEF1AmwLbMe+xg7lsRpMVAC/j/Rx/Dwmn0JlB49QAOZ6QmpEpyE1KBn3iemrpAt60uQ+aKfq9miM3lUC90mwYOku1BY8SmZCvFlgVeZu/0ww0TM6reEC/K0+XVSfZjhM7OU9JwdTTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395755; c=relaxed/simple;
	bh=qiMV3dMi+9DlhdCTYBcFKYMBvMxUD3LJ1STAMRmHlO8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mcdl/gttZYQv6RVsklrDM4+3fT9OhAsUzFrMyprdjPw6s4VpOyW7p0MS249rAEADjbkZkDteLh+BUeD1vWYxv0Fhg7Xwxu8um04HycWR8PpxyGHCf4a7Udhv+sgUssoRAurCeXygOGFoxk7T2aLaPZZM8QUQwRsF4pWXbg7b0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqe41yA3; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqe41yA3"
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e7b52ef9dc6so1718793276.1
        for <v9fs@lists.linux.dev>; Fri, 16 May 2025 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395753; x=1748000553; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qiMV3dMi+9DlhdCTYBcFKYMBvMxUD3LJ1STAMRmHlO8=;
        b=Hqe41yA3Pc0Yxh0uKRv2Zbdr9L7+6OIj9m9HOb+tOVPP70aSIxzDlOC1m+0/ouOVFv
         8k11wjO/FVg62RUTlF7OPBqtxb2k2gdwKncUeX2LeHlZUckWXypR60s3SUCA27m6hqsf
         eq75SJgng+RmVPK+6L5WPawtKsfyVAy2KgVOvkzvFsaVnI+lek5NeEAn78kLzqOuRyWO
         P27s4NWAOiJ5+Y0UyHS8fFdPhN5Ms1CUPt0hPHmASySBHwE1Lb5K8Znihp4x1L8XTAME
         Wtlu6w5hsjZR8yz/OawRRSKZ/K8KMjk+rSUz55H7G60SH/4khKCP58asJQNTky5e2jay
         BHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395753; x=1748000553;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiMV3dMi+9DlhdCTYBcFKYMBvMxUD3LJ1STAMRmHlO8=;
        b=iP8oyQ1csyI8vUfEgOewhrf+lo+8shjDgOh8vEi9DQ2RCW2vOgz169mwVQnlox5ttL
         FA19ERNnncYr+MGiOK5GZZoFaamcB09vnxP1Fz1E2hWPKbgtA1IB39HCxQ6Sr6kKu5jd
         qs4Iyua78k/4gvtpxa+NNZOw4GcSKJ5R4jkvAiXtNJbQc14RA9GGlb1N0ErMijGdkiuD
         +GG0APBOhD3DwvvTE/4JKgTJaikSOF4u7hW8KaI5Q5UMsJLzhrxoY1N3BhoeViGPiz9A
         LZpZeuJCp9MVo8sqvCl/n3rnrtolZUW8xNqdG7Nqpt2J2zwhS/7+NtfsGPAy9ZZO+dlZ
         PZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWx3aJAmWbbxU477Kt4V2WAxEO5yaNJxvGfDyzG3T1TYM9ynMygEAZWk1H8Zs7eainQRzN@lists.linux.dev
X-Gm-Message-State: AOJu0Yz52S8bI40nuooMmxJiKA1xIyOgtwQryM6sru9oW9VtCTGxnVQ6
	aN5CyX/mgK74mIewCI7s8P50VCqTsDFeOvaxX+2GjhVx/vCNoRdmA3ZpfR0fK0fVmXD+WXhBs2/
	r8oapiK8l8UzDelqZHMC1Bjnajdjz7KA=
X-Gm-Gg: ASbGncva8eY2iMn7dTxrdWHcD2fJQAdTPisTK9ThJp6wTZzGqrQezsaNosCLXy4e207
	oqQF8QU0Yv6Y8AvhSj4HeUsEqe2AKCCioX6TNwjUHvgOGF0qEQ1aI6QOyn05/8JoGJzxILbsOr6
	E5UOwUFvi4npLvGCgUA7Xqs5Ee2u7nh9iw2Jk=
X-Google-Smtp-Source: AGHT+IEqOHRPI9mMx9Iw5eaBYbZdEYeRPHy72IJwKVqT09nHXqCoGVb4KDCzuftFzMlgMWjU6O9shtHe9RpoQvqfBL0=
X-Received: by 2002:a05:6902:2b86:b0:e78:f196:5d48 with SMTP id
 3f1490d57ef6-e7b6b18c7d4mr3667234276.13.1747395753173; Fri, 16 May 2025
 04:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Guoyu Yin <y04609127@gmail.com>
Date: Fri, 16 May 2025 19:42:22 +0800
X-Gm-Features: AX0GCFtdxDf5MJAWdsDhhE1EdqPM7pPra-wvzgCAWWruf6VBGH0_LqXshVq0ZUM
Message-ID: <CAJNGr6vHrsSZ4QrRbRrN8-+tTb7ks8+xY9W7iE2VLsdgZe-eFQ@mail.gmail.com>
Subject: [BUG]INFO: Slab ADDR objects=NUM used=NUM fp=ADDR flags=ADDR
To: ericvh@kernel.org
Cc: lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I encountered a kernel crash on linux5.10 described as "INFO: Slab
ADDR objects=NUM used=NUM fp=ADDR." The issue occurs when shutting
down the 9p-fcall-cache slab cache, with the dmesg log indicating that
objects remain in the cache, triggering kernel warnings and errors.

According to the dmesg log, the crash occurs in kmem_cache_destroy,
with the call path p9_client_destroy -> kmem_cache_destroy. This
happens during resource cleanup after a failed 9P filesystem mount.
The log shows that the 9p-fcall-cache slab cache still contains
objects (e.g., "objects=3 used=1"), indicating incomplete cleanup.

I suspect that p9_client_destroy fails to properly release all fcall
objects in the cleanup path after a mount failure, possibly due to
reference count errors or a memory leak. I recommend reviewing the
p9_client_destroy function in net/9p/client.c to ensure all fcall
objects are freed before the slab cache is destroyed.

This can be reproduced on:

HEAD commit:

2c85ebc57b3e1817b6ce1a6b703928e113a90442

console output : https://pastebin.com/raw/4CieLjqM

kernel config : https://pastebin.com/raw/gPbJY2Bq

C reproducer : https://pastebin.com/raw/EanQb7c

The C reproducer may take a few minutes to trigger this crash, please
wait for a while.

Best regards,

Guoyu
