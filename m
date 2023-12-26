Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1384F5E3
	for <v9fs@lists.linux.dev>; Tue, 26 Dec 2023 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBjJZAh/"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5c85e8fdd2dso35834667b3.2
        for <v9fs@lists.linux.dev>; Tue, 26 Dec 2023 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703607212; x=1704212012; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n9H3GF3PlNOuXqvZSlzkZW1ZmAGGZa81GLwoUh/mElM=;
        b=JBjJZAh/SHqelg/StgftkRRYbHrT0R6P+w7fGBM35x8PR9j7l2OFEuo468MKBFNi71
         wR1Iqotqkshs2gSjTmEH2f8mXvqTodoGAYrsoexdvNa0DQygG3XJdgY4Mnd5d9syISoC
         DCsVBHNuiNU19kFaEPyYJLitMta5ZkTnvAAFsq9Z+XXZpqX/A7Dwp876E+RjXoOnukUX
         iwH4zQAGZXtOeGqYWEZjdVCJbfg7Bz5SIEDVcvnxiaD7fC5geRLu/uy8/yUP4Jl4XWHL
         ZBJB8teXvwiRjOr7dV/OEXXKHwZDVRaFAFQBt30jYRiF1RUjW5IGL4zmrV496b3ycQ0R
         0pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703607212; x=1704212012;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9H3GF3PlNOuXqvZSlzkZW1ZmAGGZa81GLwoUh/mElM=;
        b=rUH2wKjiUVywKxmn/4Alj4IDBLcs0qfMGskWlUQImvEGqWao/bDrWdl29fvOOdR+72
         qyJQu4bwdIqFnZLgwMU79B1QVsRM0AH9tkOvG3DSWjc6Pv/ySPN1qKZQKzYA9sCb0EcE
         PxkTKTHWwGd3FheJUIvuuq6Wvu6jEilV1m+QncIewyc/NY8iopqtrjkpuOInw9RnGbbK
         exRo4MfYxP8l+++/HDoD0zmp7HmGJf6UPJZZE5a74mYxaYd3k9IOMUEhsd3TkBshYeSP
         FfrRJOFhcMTy5Y3ZMcS84HDPHNv3GJ4gKFjKndH5KqktSTMtcMJaN54CVUGZWxG+2cBl
         xDYQ==
X-Gm-Message-State: AOJu0YwB/OU6+GEzFwCJEpd2acazwGI5Fh/OxguT9KDmOw6Fc4/DVOQf
	9NmfYGQn4OMNi9ngCKIRC9ffkcASbwPHBQIc5SV5rKxS
X-Google-Smtp-Source: AGHT+IGwgJv3TOhb+B2pqLA/9pcathY4MXZ3U0IPhF87O1/ZCBJl5X9kfB1i9kxkneHwwIpCvtBp3O8Gs02ihPV/Kyo=
X-Received: by 2002:a25:d651:0:b0:dbd:b7b8:47da with SMTP id
 n78-20020a25d651000000b00dbdb7b847damr3004519ybg.91.1703607211818; Tue, 26
 Dec 2023 08:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: Tue, 26 Dec 2023 10:13:20 -0600
Message-ID: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
Subject: cache fixes (redux)
To: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

It's the holidays so I have some time to spend brain cycles on 9p --
I've been looking over the meta -data caching problems and found
several low-hanging fixes that might help without having to do the big
re-write I tried last year.

The two things I'm going after first

- The fact that we never seem to use multi-walk (this isn't a cache
specific problem, it actually is somewhat worse in non-cache mode).
This seems to be because fid_lookup goes recursive before entering
multiwalk.  This should be a fairly simple fix - I'm just going to add
an argument to limit recursion, but I'm noodling on whether we need
that path a bit first.

- figure out why even in loose mode we seem to be sending a lot of
stat/getattr -- this seems to be related to some code that came in
with the cache code.  It seems we almost always stat/getattr because
we are constantly creating new inodes.  There's some comments in
vfs_inode.c:755 that talk about needing to do this for parallel lookup
-- but this all seems like a hack.  Anyone have better insight into
why we need this?  We always to the stat/getattr to retreive the stat
to compare against because we don't trust qid.path -- which I think is
wrong.  If there is an issue with unlinked files, I think we can do
something smarter to differentiate them, maybe using a qid.type

     - QUESTION: it seems like P9_QTLINK and P9_QTSYMLINK are no
longer used, can these be recovered?  I was thinking of reusing one of
these to mark unlinked files which we could do a more comprehensive
compare for if its actually necessary.

FWIW - I do plan to go back and try and do the broader rewrite on the
meta-data cache because I think we'll need it for temporal caches to
work properly, but I figure if I knock these two out it'll make life
better for many people's common use cases.

     -eric
