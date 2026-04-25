Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2131194C
	for <v9fs@lists.linux.dev>; Sat, 25 Apr 2026 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777150695; cv=pass; b=qsbqzAdFp7OcXMs10c0MwR6n90qjU4kQvBSmTy3xIxwkawWqr9IN9j8R/R9L5dMEuneKbccOT2qtSKvKM/bsEYhyguxvV2Yyx3iDxKU2bBINcYsrBE3HSCyaRl9AE4xcSxP3cwz+lloaHApy6nzHgqBWszoFL8PkXWZRZo5DRfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777150695; c=relaxed/simple;
	bh=jUBvTzQJRtAV4LW3s6zauqnBqllalHIbp0nX7EjE1Po=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RTj+0DmED6oB25QfhMZuJhldk8TdJ3GGOIJCuBVRmiOYUcRjLCEnm/7evy4bSAwSL/6UEJZEaXylmrd02curfoju5VXqJzMIsw0yUIbzOKwExUbZ750abzUpeUs7uL1x3MA3yJVksKSdLGSz9TUVlNDK/j5sGq1zjvRlHIZeV4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnFsReYi; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnFsReYi"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56d9f191ae6so5880951e0c.3
        for <v9fs@lists.linux.dev>; Sat, 25 Apr 2026 13:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777150692; cv=none;
        d=google.com; s=arc-20240605;
        b=TgdtaX+nUVHVPzDs/je5sX8yzf4Ll8IeBB2gyQns7U0mLUtdlVHF6N4B+Ec5bsJ54S
         JklDW271dAM6JgkDF7KhnUZ+WzC8rj0G7/ao62h3oPPuktWw7pIdiW8E4r4AzrPrPmzZ
         nxFhI9QqQYNzmjWB0mNAHDAXyMD/DFIofnmO6JZc0hSwBLwIXVhCoAENlXcgHjdwnjZ4
         ORCSkmXVlHVV327KQnso//gaUuLepdViadRFsw06bSv8m1XHTYXdxHULmLk1W1RRON5A
         PTbtPf0NW2apikcyVYVHo1G1Dd+vVMkpxIzK2k6l66NmcUT1q5EA+bf327XlJ0H74phY
         bh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hdLEEPVLUXpjrIYnOnJSx5KKABD7QmlXM0k6w+OOB2w=;
        fh=z98JtFNGNlq6SLs5kpFQyLjHZFSA7SMeOY5BesNWIkA=;
        b=KpFbrkhchUnN5bJ2d/4F4pGvWVSzgQinvY6GyiXxLhD9HrWu74292v+Ecx7toG9AyV
         xYHGHO56guGWWZvUbOG51TrAGKwpRjdRsDX4qC4jFbwMRFNboWianoDvHxeM++r+7zzN
         k4H71r5JhHtSQ7W0hCDmCv7ii/YoWu1o6gIm+UJ24lhwUGK76MxwwzPN8O6yUwe+O7r2
         iX8gPJ9exxI0fZ23z4QIrEyYgjaGG0O2ve2SapGXj4yA0eEginATTc56QeenLysw6cU1
         xJYpqPA+9GtZD/yEIjqVzSkUnZJCZ+08yqWa7vSjI4BvVPGFT3YhG9owdBE1+34EY7zp
         OBcg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777150692; x=1777755492; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hdLEEPVLUXpjrIYnOnJSx5KKABD7QmlXM0k6w+OOB2w=;
        b=MnFsReYiAZk7Lo9nahhJ81vqDu3LOVK2qCX3OiBy+DVNWt2RKW8kh+u7kQiNsjgFaH
         1jYpkuFCB+kQ/pOn9WSjyQUtpTMyBjZsLCM1a/MT9JXw3ga7wBSSxscmBbCgVFnRV2dF
         MxjRs+Ekyiq6pBRsKVNXWiudOe+M6KyRvrhgKxjA6172RCWBH0BhVP5B3cRuqTP/mSf9
         wiyGVbAf0xlUhW69DU2P0IMMKGSwBhzBoqefaW9E3z3ZFFCfmwJr7jfoI5j3Uu6tj0P7
         wMdbQ4P7JbweaD4US17XsVQLX2gmSkuEr6LV4j1ZToR7xjuJSMKmC35T+uXqB7mcKjCo
         wAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777150692; x=1777755492;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdLEEPVLUXpjrIYnOnJSx5KKABD7QmlXM0k6w+OOB2w=;
        b=byzURwM9JhN9RAU5yPYHO7cSRSpHy+RFtFPDu2msHIXgn03cNBw+EDd336kULCCmaa
         N7mKLkONHBJRc70SBW0jBvZW9WEZCCUZdnW0+66bxMjlC7XvLo74ONyRZTZXLRWrwMCQ
         FcevdwSa3iLoDsRFUzG3hwVOMF8b/3yGIL+24pfpyyABM9pbG/HOXZXW1R/NMxW7P+na
         6S1fXkxkle8VhmustuYxWQeM/weqF/ti8MSZi7Gw2qCiqs6un8mU707m1gQgPsyUQKq0
         pQHChLhNWJKXU81WSd87cmwg5dMIblfnb1DB5WUcYKCEP7SQTuMM0gXC6G6PrijG+fk0
         YcvA==
X-Gm-Message-State: AOJu0YxLGHr1CBMAju2zeDU5sQNQMt6ODQR7C/U1w1oypV1L8xAUcgfr
	1VKxf0TuFzI7t4dgYOqNas4lWUpNQdl+K90b/Ci+peWpsSPckQMsSEK2GNhdHrc3r6JCJQkBRVe
	2MSAmftn42fpJ61lAt1t2qeOtxnUM7y1ghIpMYbw=
X-Gm-Gg: AeBDiet5QghIJZp6dCdqkW+5EowrtLRiSKjSwakcyFk31dWY6CLRzvYxXxcEq4BENZU
	2NN/QrMY4Z76s/zZtyZs/7hXCbjwtcOMHmcLzTlQtEIHX2NyaUMjyi+NmcWUYRCMuGeuagL7fsZ
	4ScUG+nJb9XGAc2Q23mSZr5ScDnJuOGjhXqXBYUr8Bc/OhaSYnzR0F36PpQ3TXTl5BWvgqZBUxJ
	v/wAGYbJgeef1jH1ikyxY7hnzWIZ2O5DbdcDpUv1ek5h7MEr8kqUaqtsgNHyH2NcnvDG+p6qGHt
	whzJ1Q0l+f2etuoTxOfBedw5To7dOYl6hFiJjrWTAps3hyOzmAlY/opszzmdK0Ygd3fqN5Y4lWM
	1lQ==
X-Received: by 2002:a05:6122:82a9:b0:56f:b0bd:2276 with SMTP id
 71dfb90a1353d-56fb0bd24ddmr19430303e0c.0.1777150692492; Sat, 25 Apr 2026
 13:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: Sat, 25 Apr 2026 15:58:01 -0500
X-Gm-Features: AVHnY4JJkTJgd_SXD4RFBXu_EWn_2mYXj8GVwp0uKyBNAwwANo8b5on9Eap9xlw
Message-ID: <CAFkjPTniiwtBLf7yUepG_846QM6BeuKbxeisByQVTwkEQtjsZQ@mail.gmail.com>
Subject: FYI: v9fs/test rework
To: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I've started picking up v9fs again for something work related, but set
out to first fix my test infrastructure.  Being lazy, I'm having
Cursor do the test infrastructure rework for me -- it is still a work
in progress, but I think it's already handling the old tests and
starting to add new ones.  I need to suck in more of the diod testing
framework as well so that I have full coverage there, and then I'm
going to look at adding hugelgupf/9p and go9p.

As part of this, I should be able to fix it for nightly builds and/or
at least tracking upstream with regression tests across the multiple
servers.

Currently running in the main branch of github.com/v9fs/test

Fortunately for everyone I'm not tilting at the caching stuff quite
yet, I'm more interested in the synthetic file system angle.  So don't
worry about me breaking everything (yet).

       -eric
