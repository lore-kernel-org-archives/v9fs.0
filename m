Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96D2222CB
	for <v9fs@lists.linux.dev>; Thu, 15 May 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294578; cv=none; b=JrbVzlmMSe5MqFXRGziWu6knsbo2m8uxwbDsnBmgxLh8l3SGBQaqHKPAoe3Ju2BVf93c3l2OgbGTfeSFiTJ4nOaPB2v0n7L8Ya8022xkLAe0bqMQ+cuAc2rkXgrFAweiC1kiW2m8NJ8yBOB9RWgsSAoWibfp55d7tF6KH7gctAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294578; c=relaxed/simple;
	bh=szsR6cUA/KBk1A+1+MXOmIwq7e5nLTeC1bHAQuEP98Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sETyuI6tNwjyv/gCD+eCtxdZKdFdNBynvdQaWruMNWCaivvnWkztab5WfgAj3NkOafOliyWKQ/o4btyxbH7XhpCCSMZAeNOj700PD2yOUhFytTHTi+gJ+rWTpXQ50+2oSl8r9W/+GR2rn7tvV1016WBjAHT1fFxBESqhr1CpMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me8rVj2b; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me8rVj2b"
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e740a09eae0so565642276.1
        for <v9fs@lists.linux.dev>; Thu, 15 May 2025 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747294575; x=1747899375; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=szsR6cUA/KBk1A+1+MXOmIwq7e5nLTeC1bHAQuEP98Q=;
        b=Me8rVj2bwhPUN/7cl/+XF9iMrYknmWidQ+2Te4prNs8GfvlOEkMlCKBldVKVj8Ubtb
         8HNIDtdXqRA1nVEe+jVSA8w5ycybVQy5U/tOU0XQFLxTIAr82B6QTKc4ffOk7I+sEllj
         XMX8klXGbPtAbGS8xlUG/NRreaF/Ap9gPvpxydpmVxVZ7XTsfc59BA8to30UafIvb7Uq
         opf0AdQ9UZ8ZIJ1rnD62gqPcmUivqtnf57lZ/n3D52MxSM6dhObMOTTcohlyfeU32vCT
         1OmoINTZzkVziRAjqevZ64xcdSMpWxDX+WnZmIpEeh3/6TmPBs1M4kCB3rKLKIrXjP/q
         QQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747294575; x=1747899375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szsR6cUA/KBk1A+1+MXOmIwq7e5nLTeC1bHAQuEP98Q=;
        b=ATA4zum1eduYZZ9OQH/OWKU+GyedQS3v4pJBTBtrQWzZhPsxXsQ0eHuzu4GiXcPpOQ
         KwH0nSKxJONsy64Kl0FqJ67P/d1/uB15cFK2EFVd6z0vV0J8f+TB2PVAHRb6GyDrziJd
         Yb8oUYARVqGfTNCU5F+1JRRX1gpVRH+2+Fn74cAQjw28/La8UqUeC2fC9/ZkpkZWXEmu
         cgizfM53nFzhkydrSdZCUOk6/wugmBc9KsgznOfTCrGjcHp8rhv7g/594tlVt5s3eDKK
         /4K0MYXjgA6iQQmTdrGPx+LW5FOfWpxX+Thy916bSRGTHjv+bRzY6x8iqhfBGrzsoBrA
         ja8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgtOCkZ5uePxq8U3o8KyDibLgEsS7WXWNxv9WjuPFNSriwoKph7QlVrX+68ZVrhLyKYqnu@lists.linux.dev
X-Gm-Message-State: AOJu0YzNMkMwRnPqlA7NOfkSivSKwxLqiS8E0EFBU+sbTlQsrUA5oY2u
	RzEUQtmmvo/ZcuQuIS/W9/BrdD5+B7UqnEqh2Aoin/lYnAcDhjniXZwN61/5d/Wyv5i2BeXLFZE
	Ek/Haf2aTJIJtwZpRdsQJWUoe3OA=
X-Gm-Gg: ASbGncsKipdiX5s65lvq7hMypyJcrpR1n5qiKaNZBDAerCZ66cbEofinTnj2Mlufc70
	UL0QTA0WbEDjjmPRUajjh4I45kN9pogDL0rK+z4NePIuurbvrpGI0Ajk2fszJ5hXsu19ZRWXfRH
	Xo7N0oUUcsf1tM0ezhp9bk7JgU6TKqsv03LUAWxUCm478=
X-Google-Smtp-Source: AGHT+IG8opHlVFnveV6TiQeURD6a+n3enll8lWBn546ETe3NrD2IJ5PQV2MZ9ReruHPc7XhuXvimqgjVj7A1AZfCbXA=
X-Received: by 2002:a05:6902:2483:b0:e72:9612:f78c with SMTP id
 3f1490d57ef6-e7b3d5ecb32mr7878678276.40.1747294574780; Thu, 15 May 2025
 00:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Guoyu Yin <y04609127@gmail.com>
Date: Thu, 15 May 2025 15:36:04 +0800
X-Gm-Features: AX0GCFt2pwByeaCyYPSlsoCOUmmtgbUEuL0FPS9I2GL2H_SPAs4BqIugp1TYGtQ
Message-ID: <CAJNGr6uG6h=dBLjfB5ajZjv4qdf8-LjcW-i8L3_oqhbvBosSuA@mail.gmail.com>
Subject: [BUG] INFO: rcu_tasks_trace detected stalls? (Late IPI?)
To: ericvh@kernel.org
Cc: lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I discovered a kernel crash with the description "INFO:
rcu_tasks_trace detected stalls? (Late IPI?)". Analysis of the logs
suggests that the issue may be related to numerous 9P network file
system connection failures and high system load.

Specifically, the p9_fd_create_tcp function repeatedly fails when
attempting to connect to 127.0.0.1, with the error "problem connecting
socket to 127.0.0.1". This could lead to resource exhaustion,
affecting CPU scheduling and interrupt handling, ultimately triggering
the RCU stall. The logs also show EXT4 file system errors (e.g., block
bitmap inconsistencies and delayed block allocation failures), likely
a side effect of Syzkaller testing.

I recommend investigating the 9P network file system=E2=80=99s connection
logic (particularly the socket connection part in p9_fd_create_tcp)
and system resource usage to pinpoint the root cause of the connection
failures and high load.

This can be reproduced on:

HEAD commit:

38fec10eb60d687e30c8c6b5420d86e8149f7557

report: https://pastebin.com/raw/0LB0VhWw

console output : https://pastebin.com/raw/EtnaHBBq

kernel config : https://pastebin.com/raw/u0Efyj5P

C reproducer : https://pastebin.com/raw/WzZ023uX
