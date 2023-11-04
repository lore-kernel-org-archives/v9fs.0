Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C0747B
	for <v9fs@lists.linux.dev>; Sat,  4 Nov 2023 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZwVyRQzf"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so5361071a12.3
        for <v9fs@lists.linux.dev>; Sat, 04 Nov 2023 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699125812; x=1699730612; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JxepWvacGDqpCJSE7j7k1s9SrOuSbIYvnugxYe8U1sM=;
        b=ZwVyRQzfqOLie8rJmVsCV63BwPERlHEeoLL7kJpe7HJ3NZnKYPVMdIN9Ov6UDK/r/W
         XrAn5EyCKbKM0FGMJJK3Kjc8dAfRV7ZN5QRTc6ffBz94dSp2Zu29Ag5kZVrSWoyiCNF2
         4goGxgDT5oFXGe+eTTdRUp7o+be7ARQtk+Y8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699125812; x=1699730612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxepWvacGDqpCJSE7j7k1s9SrOuSbIYvnugxYe8U1sM=;
        b=pTXFXba5Y9gg8U4SQseXwAj0d8Qri0kQfesN8zR/AfF7l5qKoKf9KS9gqQoTsbLESF
         364cuTNWkuV2HjmG6mkvOGzRW7rIZp2/kGS9hQdLmDVeA44H+tWjr1cPjmUXBVo+6T9N
         xLSN9wvYy4vUhaTucF/65FVROVPM1yxiGukqdEaOkFkUThzO3WW7RVFZF0884dF+Akzq
         Yy1uweeSemeu3VnKnLaE9ZQk7sOlUubE3N4bU86ckHkpWwkcPnuJja3DlcGHs5BXaZ4V
         qPSb0bLL1X66MAZAeWnzpN384gzE+e2LkJxovZKnWP/mRbw9ihW5NTfP0ffHdeeH111W
         JdIQ==
X-Gm-Message-State: AOJu0YzrbLeqDQZTvVK/7W6uWLNqILRpVB007rlGI+iQy898YbcU7HKm
	qeMcL49a9QzDfphdgL1Eziof/rm6i2hv1qQSSc/1Yg==
X-Google-Smtp-Source: AGHT+IEkZko850A9i2QN9OOLWITJbeLfKUF3uRRAC1Sv5VaqE2ukRxqFszWbHLikpd3cU7M8VERy9w==
X-Received: by 2002:a17:907:a45:b0:9a2:86b:bb18 with SMTP id be5-20020a1709070a4500b009a2086bbb18mr11416873ejc.26.1699125812727;
        Sat, 04 Nov 2023 12:23:32 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090634cc00b009adc5802d08sm2234900ejb.190.2023.11.04.12.23.31
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 12:23:31 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9de7a43bd1aso75931566b.3
        for <v9fs@lists.linux.dev>; Sat, 04 Nov 2023 12:23:31 -0700 (PDT)
X-Received: by 2002:a17:907:1c1a:b0:9ba:33ef:fe4c with SMTP id
 nc26-20020a1709071c1a00b009ba33effe4cmr10254548ejc.64.1699125811553; Sat, 04
 Nov 2023 12:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZUW82S8bGg2BAeNU@codewreck.org>
In-Reply-To: <ZUW82S8bGg2BAeNU@codewreck.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 Nov 2023 09:23:14 -1000
X-Gmail-Original-Message-ID: <CAHk-=whcrbGbc5RJ40iCF55q45Hwgb0qw-MfuJqC8SrK62wgKQ@mail.gmail.com>
Message-ID: <CAHk-=whcrbGbc5RJ40iCF55q45Hwgb0qw-MfuJqC8SrK62wgKQ@mail.gmail.com>
Subject: Re: [GIT PULL] 9p fixes for 6.7-rc1
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Nov 2023 at 17:39, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
>       9p/fs: add MODULE_DESCIPTION
> (^ I've just noticed DESCIPTION -> DESCRIPTION typo, but I guess it's
> understandable enough and I'd rather not rebase the branch just before
> sending the pull request (that last memory leak patch came in late
> enough) -- please say if you'd rather I fix it up and I'll resend this)

No, no, a typo in the commit message is very much not a reason for
rebasing etc. So sending it to me as-is was th weight thing to do.

I did fix it in the resulting merge message shortlog since you pointed
it out, but hey, if we fixed every typo we had in our commits, we'd be
doing nothing but rebasing.

Kernel people aren't necessarily great at spelling, and that's true
even for those of us where English is our first language.

            Linus
