Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10401C9B89
	for <v9fs@lists.linux.dev>; Mon, 21 Oct 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551634; cv=none; b=PgR/7fn96LEVmExG7ehuybU7wUJ8yGbn/Ny5SYxF6erD/FBSyjrfG+UG9vaWZATJk7rbWf0Tef/4VwOdBpv4NbqnDaV1yJRtyussmVbAihBkQTY7nXxy9+rKz8blQmcRdsoWCRZ068DJd7DjCVIt3b3pPuT+1rm8HF8JSeI1XrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551634; c=relaxed/simple;
	bh=3LeeyEafeXaGnkqTR7YkYuS9ctyqOUkRKIdPORL0JMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT6YVYPuZ8K5KmVl3lko8YhTlu6/90RSvUSEV7QPNuLrhkTpHLVSsRePg2D2YTXQpIx/x/jweaqf4DobWFG+Bk9yNswN619aAvSn1rZUp666e3w1MQdBY0xr+BBEHmhan+9w+xCAWJIictdv9s07f3GNaqwzXDSjzQro0UyHRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eGKMZY5S; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eGKMZY5S"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso389408666b.3
        for <v9fs@lists.linux.dev>; Mon, 21 Oct 2024 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729551631; x=1730156431; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rZmK1iIL6psL/Ic0R5BQSUU9uDtSN6VQwETroA+PQ+k=;
        b=eGKMZY5SAoa6WTIh8mY1EMq9jA6od/qa4VEBmjq08qBTQP8cuhGEq4jjV7Nja36g4d
         BHFVLC+xGHSmTxSbmwdSWr9WLSShZDnbst84ak8c/++3BbKUR44fHAPCKL4zbUsmbOGO
         YyvPCnXLYzo5ZD3IR7hXFl433k3YGWue9zbmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551631; x=1730156431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZmK1iIL6psL/Ic0R5BQSUU9uDtSN6VQwETroA+PQ+k=;
        b=tBFSJIwiXKa4r56dVhDJdqKp/flUL9arPpOS0lmoctrTwlvyr0fabO4Y1m/u8/EcP8
         aYAhPSJxDiCCMH9twgKOoKuMTY8TQiMG/Rwe/flr58TQ+2UjCdUP1LcjisTKMga8v+Rk
         HZ7RDcM6k76m2QLtEhRB9Tdaw9siQRU29SPHxpG6YHCGZa8yPgYpN4Vb9nA8EwyuD1i6
         yA/t/opJyOboo7FW32J63P8PhHFzL9rDzQKJ6LxwU9XGZowQxs0gGRYu9+5smZAn3Skj
         lteFd1tLrDHlASnNlRPQIIYem3kyhibxHsZ0EHBy9HRSQp2AfiV6NjZg6eMBTgT7d3Gl
         b/ng==
X-Forwarded-Encrypted: i=1; AJvYcCWh446DQ9SdQQKhehvN7OjYTor3Jj2B/fqGuK/s6LUsIbo63Q1jopKeuDSEFNVHnGBsT1qg@lists.linux.dev
X-Gm-Message-State: AOJu0YzbkKx9PPqieJzHcBWEc6p3ZfjC6pujHkfkmzUz2uJl/BtZCOcz
	hrETq7YvcCx6IIhR/lANggZdUW+5PFEgBwZ+13/dQe4vfek2a3lfj9q2bcK0XC9CAfSY7zmsMx4
	a1a/eiw==
X-Google-Smtp-Source: AGHT+IGBB5aKgyVt5hd2gHggG7a2wnjn2jY/pcfyf09/3UPHIRgDiB8Cg9hNch2QEHYVbVPQQkABVg==
X-Received: by 2002:a17:907:944d:b0:a99:dfb3:dcb4 with SMTP id a640c23a62f3a-a9aace98b43mr41423366b.39.1729551630821;
        Mon, 21 Oct 2024 16:00:30 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee11asm262926666b.68.2024.10.21.16.00.29
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 16:00:30 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so683445766b.0
        for <v9fs@lists.linux.dev>; Mon, 21 Oct 2024 16:00:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRyuvlZEsl46TyQAgNWLTZcY4Cz29CKPrG4huF2ap2YCR/zyxBYaKFt3F7PrAjltnBY9fz@lists.linux.dev
X-Received: by 2002:a17:907:97c3:b0:a9a:4e77:92f with SMTP id
 a640c23a62f3a-a9aad3d659bmr42656766b.56.1729551629565; Mon, 21 Oct 2024
 16:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com> <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
 <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info> <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
 <ZxL3FsmjGrTT_EV9@codewreck.org> <d937fd92-249e-4660-a59a-ee85b6ec4691@suse.cz>
 <ZxafcO8KWMlXaeWE@telecaster.dhcp.thefacebook.com> <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>
 <Zxa0K-4mhSI91S-w@telecaster.dhcp.thefacebook.com>
In-Reply-To: <Zxa0K-4mhSI91S-w@telecaster.dhcp.thefacebook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Oct 2024 16:00:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBSEzzC2CTtTgnJ-ou+1ye7CVw45ogeH_eFR_fDF=Z8A@mail.gmail.com>
Message-ID: <CAHk-=wiBSEzzC2CTtTgnJ-ou+1ye7CVw45ogeH_eFR_fDF=Z8A@mail.gmail.com>
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same name
To: Omar Sandoval <osandov@osandov.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Pedro Falcato <pedro.falcato@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 13:06, Omar Sandoval <osandov@osandov.com> wrote:
>
> Yup, that works here.
>
> Tested-by: Omar Sandoval <osandov@fb.com>

Ok, I changed the '%d' to a '%u' (because go big or go home), and applied it.

Hopefully I didn't screw anything up in the process.

              Linus
