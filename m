Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39972223DD4
	for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771717567; cv=none; b=n/2w5ap8sdsOfD2t1F9c7Dn34MACPLoSNY8iG6t8Yvauee/nGGY+Z+IZbDqf8dEE+SftvHQo4UBKXRljepvPzD6SBdmjaiDDc3E6COqRp2x7a5zrDFvewuyynn3L4PAc4rsn+nVowtDItHQwvAdDd3bjWeHG2Vf0Ve/Ua3+icQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771717567; c=relaxed/simple;
	bh=D8wEA4P1R/wLC0WQ2gaxmvJV8Zid0j4uMfM8HtVxkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Txbe4BPIYiY4rEd06Io32cWgN/EVyCaGGpD2ehqwM4f2y2YBg7Etaw19yfLUeBIEkABybdgRNGURiHEwupLsNkUZ7liTPQih9sXzlRfs2/gGjFBFVLQ9xhCtxsFwhOkn2KMP4/bxuz05/9O+yH7moQkERCW7OsyK6kSDz96SDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9B/4Vuj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9B/4Vuj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4807068eacbso25584665e9.2
        for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771717564; x=1772322364; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6c+2c5A4IdcQR95bgfQZwtsMpRnSCzmv5kOunEAmnw=;
        b=U9B/4VujIwRlLWfCPD2INIQ63S6v6zaiqnE9wgd17tr5HulcxH5ZDaVx16F+8MYaIA
         OXyc7j6HOtiBEvYKETN3alL414e2amAN2+rd0jpuJEO1Xy5/Gh1+yPdwn/VYBSwqf8bx
         T2sgyHuZT2VSr4Ti87ONQg9b9voF2rN5crg/51U00ABNMaaItenTe0JJsLAKKWq5VN+6
         tuR1hG+nmydA9zfBp4B1+GeGQk++l/qjT+NXUvbZNlMlZejtEYbcU5PPyseMpaRNHssa
         J2nKj9pc9ah2lNhCWsoKSPRBn+kEcG84FIRVGhRVy/fsLHgY7wLWHnv23Wl4ZJmmOwrs
         aJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771717564; x=1772322364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6c+2c5A4IdcQR95bgfQZwtsMpRnSCzmv5kOunEAmnw=;
        b=w0Hr4O9QNy78fUrfHJnJ0uZ7/n/MoAjn4usKRLD1QS/xEZGnnBj+tsVBUwIfqgHEug
         hCdmWdh65wx7bnvwXd2lvygSUKfetFX1Y5V9hMFP0LsedTdoSctv6YgoEiKpDo+P5Rsq
         87CDCJ150rlGB2xurlc7DinOoYTM7IHAPQXxJweC3VB1OT+moicjO9g76ZLQGmic6qU7
         w7La8oVsnNm4dYpwrAmWFly3/X2pVm7rGizKiSOnQgQz1nkG9yV2G5uDKWCdyRYmoBiX
         BcUwe5ouiiFMJ4G4PfCHqOXTu0IzC9EtMb6lx9eT5QYK29UBVGOmlSeZwfBymXOCpjkM
         MrAA==
X-Forwarded-Encrypted: i=1; AJvYcCUAxlIKH0YdBFubGAMqc/u2r2L0Pnl0fJebbyeZxMjLje/fGTDCKggUklyLLhoFjaW+Xqyq@lists.linux.dev
X-Gm-Message-State: AOJu0YwJP7SKBcNDjffV831WH21QwnozvQ8r3bZVz4g8VNkJX5i9qEFP
	9fcKEtBPewk6JHvRCBthsa1nsbKf19STJFEvoMhqJuQluhnLAb+ti8Ay
X-Gm-Gg: AZuq6aIp16yYb7Ryz9pG3Z1QOT6IS8qA0E4rMFHLWFY1P9U7qwin8PI+y676MlCEEA0
	FQqzAkAn301PvnE22BSfYkTKQvIxdVfnY01yEC7pmvwgtetXmYFPSmYa3cBtojyVTXco+fDxJb4
	g9ij83gjC6lzJlTnxIcwTeUYR23RYvrbBnBbUS/dgJeYdNrnAGMFwy27JgawwOPSiJXwYqKF88V
	aLV6V5GCs5rN+rCbrQeHBywMSPfzWyEK3LdRlwMU3cwi2JEDO/vH43QYCvJdUea00tF+i+5NlUK
	Ok4XceAYWVdBS/3HvDEL5nyuP2WoCD3qISu+vwjT/+QPY8cuzZK+5L5HyM1UIhR9H6uIbOuz7RK
	tiQS3arqbonNSI5v/kG5pdtNBx+REL9knNI3eY+wqISj6ZLjsdgV6lE/TYz0TiJr/Cr7DOZ7N0A
	puUBBcrkIeZ4RVK86SGgYMsCAPA9TcOw==
X-Received: by 2002:a05:600c:4749:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-483a95e5ab8mr72338125e9.24.1771717564334;
        Sat, 21 Feb 2026 15:46:04 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a31c56d8sm251620925e9.8.2026.02.21.15.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 15:46:03 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: dorjoychy111@gmail.com
Cc: ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
Date: Sun, 22 Feb 2026 02:45:53 +0300
Message-ID: <20260221234553.2024832-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
References: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> I am not sure if my patch series made it properly to the mailing
> lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
> series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
> The patch series does have a big cc list (what I got from
> get_maintainers.pl excluding commit-signers) and I used git send-email
> to send to everyone. It's also showing properly in my gmail inbox. Is
> it just the website that's not showing it properly? Should I prune the
> cc list and resend? is there any limitations to sending patches to
> mailing lists with many cc-s via gmail?

I see all 5 emails on
https://lore.kernel.org/linux-fsdevel/CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com/T/#t .

So this was some temporary problem on lore.kernel.org .

Sometimes gmail indeed rejects mails if you try to send too many emails
to too many people. So I suggest adding "--batch-size=1 --relogin-delay=20"
to your send-email invocation. I hope this will make probability of
rejection by gmail less. I usually add these flags.

If you still expirence some problems with gmail, then you may apply
for linux.dev email (go to linux.dev). They are free for Linux contributors.

-- 
Askar Safin
