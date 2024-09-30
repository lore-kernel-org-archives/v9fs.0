Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DDF19ABC5
	for <v9fs@lists.linux.dev>; Mon, 30 Sep 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724443; cv=none; b=ZrMW+60jfepprsmB0zOqTxOZ9r4GWxygnWWbqLZGt/HzbkeMfdN5rVEcy/d1ImfOx/fnxMcwmE/u996R6i6/nFYZvQwPcs8CFmgEtozckznEkqbUMxwDQZ+EKOFU+kz/iHdvadHYDea4+CkRy71XRfPwchCnTA7xqEdjAU4WEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724443; c=relaxed/simple;
	bh=ZSI71VfgsPW9jmTOsnIN09a8tp2Zltjs0l+l2+dvrM4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KawFNp/tFu8AC/OiALadKJMuwr2q+b8bzHwHTBHte4FNRvcKdFwf5fjIxx0qKgBx/JcIVHELmcNpBWmXAXdVE+2abPXgHp4CV2ZmbBZNMiJO9wEg5SCOlbtGkUdQECXmuIVzXOxTAG8q1v5EydX3gSvY4cgjYg3NCxOkeLMj2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL+46meC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL+46meC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b8be13cb1so13953095ad.1
        for <v9fs@lists.linux.dev>; Mon, 30 Sep 2024 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727724441; x=1728329241; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSI71VfgsPW9jmTOsnIN09a8tp2Zltjs0l+l2+dvrM4=;
        b=lL+46meCJ5SDnK4S9hWglRZXMzHKQr76PxHuEy8dMty0wvX5we99gTjJ5tJjDGHZ16
         1S3AovYRJzWhh/dexcv6LdC4BkBck2tHoXqoAL1O5zz0Ds0NDoeFhBs825Z3BWHw54WL
         7gBKiVwqyUVe1lLGT0oOB+5xA5naKfHzakdudnT/LqBWmjGubDaefhZcrysGk16z9SQv
         Owlaw3IKvrcLBq39XjcTf0gyzNS24FjBG/hcNniApuTCCKnpXBnp8Qs/IABPawhpGAQ4
         DBOoc2k2AMqacX8QEUqJiUGqC5jQKqEKcysT6rgiL7pRq1rjMhOxg/5mpavlC4HBxKtV
         nnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727724441; x=1728329241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSI71VfgsPW9jmTOsnIN09a8tp2Zltjs0l+l2+dvrM4=;
        b=ttLlMNF+1AJJHUqL4hqIQFJ54W2wtexyZMAPFC8A9zzJtC0moHV2mCPfXziEMkwiAe
         pU6MMORLMH+/OAc29iUhOxk9dCJS854IIdGjf6gMFdg8kBSuV/xNlPLV3dOv5Y82rc3l
         MIFDQnMNZmbTeY7gHINHUDBTg3BbDT0jbzfMy3BhhPfPBP+m8+9fKrZuLl+sHbrEYXHI
         LCt6D0uX8F/pYeDdoshocXlNQj9y+X/pWEpcf75ZQb5qQp0zOWfyq/cqFA1gfQQPyxtf
         HvDjNu2329//H47lC+GZs6iQnk6nZIFcxfDlTbRTd4Sfy9FNye4A1iNYU65yKECnaRdM
         kJew==
X-Forwarded-Encrypted: i=1; AJvYcCX9Q8pBYK5icG9GR9s2oTXu56C/Tl7aZdRjm4Iy7YGS1BHMIsbgDEktUWIFw8U+3s9eIgxB@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo1VRX379vfLzyuoN+ueI9jLpOK/kprIZg5IF5581fQtpdPcYh
	UnGbqiQtWb6uogauHB5ToufWzYBGSfMmxZOQXMtiiZ/pTWnk1PNr
X-Google-Smtp-Source: AGHT+IE5LZEwGMZKkvbjZjxjC9ZU09pH/y4FRVHIQHiz8SiyRcXl3F0aiqKrl0A1iXG03jHtCG9HDQ==
X-Received: by 2002:a17:902:d490:b0:20b:93be:a2b5 with SMTP id d9443c01a7336-20b93bea53bmr40831425ad.32.1727724441157;
        Mon, 30 Sep 2024 12:27:21 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db292b19sm6780357a12.17.2024.09.30.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:27:20 -0700 (PDT)
Message-ID: <88f034c09850004f6468f8b31a9fc31058d36981.camel@gmail.com>
Subject: Re: [PATCH] iov_iter: fix advancing slot in iter_folioq_get_pages()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org, Al
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: kernel-team@fb.com, v9fs@lists.linux.dev, David Howells
 <dhowells@redhat.com>,  Manu Bretelle <chantr4@gmail.com>, Leon Romanovsky
 <leon@kernel.org>
Date: Mon, 30 Sep 2024 12:27:15 -0700
In-Reply-To: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
References: 
	<cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-09-30 at 11:55 -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> iter_folioq_get_pages() decides to advance to the next folioq slot when
> it has reached the end of the current folio. However, it is checking
> offset, which is the beginning of the current part, instead of
> iov_offset, which is adjusted to the end of the current part, so it
> doesn't advance the slot when it's supposed to. As a result, on the next
> iteration, we'll use the same folio with an out-of-bounds offset and
> return an unrelated page.
>=20
> This manifested as various crashes and other failures in 9pfs in drgn's
> VM testing setup and BPF CI.
>=20
> Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to ha=
ndle a sequence of folios")
> Link: https://lore.kernel.org/linux-fsdevel/20240923183432.1876750-1-chan=
tr4@gmail.com/
> Tested-by: Manu Bretelle <chantr4@gmail.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---

Tried this on top of the following commit from net-fs-fixes branch:
e1b0d67c7ae0 ("9p: Don't revert the I/O iterator after reading")

The boot issue is gone, thank you!

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

