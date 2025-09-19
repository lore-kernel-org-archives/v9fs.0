Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086F264A72
	for <v9fs@lists.linux.dev>; Fri, 19 Sep 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273395; cv=none; b=UnP2awX9t476Heu/C1j9qWO1ONltPCA2qyHVLjBw/gBbtKWHYzxFfWcEMs5Su2g3gijf3Sh86aUfJqEmEwVwRqeuGaHZkhKHMlkbcb4MldQh0/0cc3i3n6nhpGYMYXrDBYQqAWxaiJ+71rXhINepG567O9Tcqtz4iVbmb1VMpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273395; c=relaxed/simple;
	bh=3NSAuKg48kDucBl+lQY28yZrJW6O+JKtv/vQq7ZLJw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwn1k2wSJ7PnlhbJs6AGK/BHy60etUbbEnX/Gdc/k5JWppxKh1zouwSvAaUGtDxSbatdnQ4Rl2YUc/C/8s9FWQ9IYm5MMTU8hA/aTzZUNKpocDalE+hh+7GOBrniwvlRbqzjClVJx+Blr9rUv8CuufK23nEY/yJKzTSNorciE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VlwZusdB; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VlwZusdB"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b38d4de61aso26653151cf.0
        for <v9fs@lists.linux.dev>; Fri, 19 Sep 2025 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758273393; x=1758878193; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3NSAuKg48kDucBl+lQY28yZrJW6O+JKtv/vQq7ZLJw4=;
        b=VlwZusdBt9d6me0uW3bDwjUTaKWUysJmHL2q7EM9mrchyIMJgEJZPBqwYUcSbtd/vN
         0myBjZlbhN+npoaveHbsf08XOM+tnftSjos5h2PIR7sMhRoTARu6Vv7qGMVxLz+SJf8h
         3jgB2OQmQ38mg8K63CJcCt2GqsEIII/fioxo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273393; x=1758878193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NSAuKg48kDucBl+lQY28yZrJW6O+JKtv/vQq7ZLJw4=;
        b=e06nrQF++pL9KRAsjmxAoAV6fbXR4u2bdFnW7lfbFZ7mdI/hA9YiRsPnYh/+iyVYoG
         /jDB0F+Y9FZn6kCrSqTqTQjtzDicveIfPfm+vTHQNmkZaub8jSxShxRnQQ++6/E/A7Pb
         CLXQEKEKfcrdkHpSQksXpKF42bBQYEsCLYN2yoU37ImkXx70ZOKzvo2y0MHkJDzKRmcv
         92nVUSoNXtJJCxEzNl7ADIUIR62czfgEx+beWv4MH2BXH1KznwFnGM8B+o4pc/+BxvRy
         B//kx6de1XyE5AN5ArSu4irViPGluYMwyaRGZGWkSXoPC5MTFf2yqLHjlZW/RA0xM7M+
         x2gw==
X-Forwarded-Encrypted: i=1; AJvYcCU/nwVB3fhW9yF5i96YDIHRhJ5KBI0KTq7QlvcsG5X8W2edGNf+Kf7hasYD3A19IOtvhpQ0@lists.linux.dev
X-Gm-Message-State: AOJu0YyInOrfDydYvquix5YEu7Ws/SIN+dCneUCOzTKYqndZWVkjWomc
	qmVHqpnAErMmf5WSBu88vhQXxx3HvbD0PcrxuzIz//wJD7qmHEiygaGCY9LGJTKdX2vnLXznFXO
	nUWbQ+BVH3MJm6CX7nXmGUh9+qqOrLanJ9/ByVy4hMQ==
X-Gm-Gg: ASbGncsi9ktKW3eYlfcQpBLwqUXR6AeWkxA4YPPhwuYMKvJz73HyFMPBT4AOud3/kzz
	MxUzzP6bTYwRGqmhmoLpX9omUq69tuSjG3hYQI1K3uZdWyaDeIgDMs4ME5zqcvD7MToQ5ugCHK7
	gE4EtQSzNxYPm1awP2ZkXxUT3Na5RvfbZJ9nnLmBMakqLvhKaEulx/c6gl80ltAhz9cxw8+xvoP
	FjkRI+3YO3cKaUY8PS8UVqYh6RntYrsKV0brgk=
X-Google-Smtp-Source: AGHT+IEC7DaOiqsDhZ6el+nJAXMCR2LZLpubNGOPgEov0Yiqge6V0MP8FIeK9NIu4a3q26iz/ROtYZA/OmdKQK0CbyY=
X-Received: by 2002:a05:622a:1189:b0:4b5:ee26:5371 with SMTP id
 d75a77b69052e-4c06e7cec5emr25872751cf.26.1758273392530; Fri, 19 Sep 2025
 02:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917232416.GG39973@ZenIV> <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
 <20250917232736.2556586-7-viro@zeniv.linux.org.uk>
In-Reply-To: <20250917232736.2556586-7-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Sep 2025 11:16:21 +0200
X-Gm-Features: AS18NWBdR2wSIkWeUQEoOiuG4V2oEtZ00-2g_l56ym-IbHqMpDho5hZu73hYZtE
Message-ID: <CAJfpegsxUQzZaXKFAOBmThP6e5F=XT=oDn1BDBUO0R35D39P=Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] simplify fuse_atomic_open()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, agruenba@redhat.com, 
	linux-nfs@vger.kernel.org, hansg@kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 01:27, Al Viro <viro@zeniv.linux.org.uk> wrote:

Some explanation about the dput() removal would be useful, e.g.:

Non-null res implies either an error or a positive dentry, hence the
dput(res) cleanup is unnecessary, since at that point res will always
be NULL.

> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
