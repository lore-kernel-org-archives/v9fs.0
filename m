Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE017154BF
	for <v9fs@lists.linux.dev>; Fri, 28 Jul 2023 17:45:24 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99bdcade7fbso271079466b.1
        for <v9fs@lists.linux.dev>; Fri, 28 Jul 2023 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690566322; x=1691171122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WY3Feo8GPlidh1PLbTYaalrVAHf4dxKu9JSTiyyBg5Q=;
        b=Tf8RCsMUawT9Lcim2FlNcW649OJli0tjM2vUORcuG0ev9z5EE6npEp30lmBntt0udn
         231FWDICa/goN9zdEawmwUvLn+dH9WSZUDnzpV2eL04p5PZ8C2aAClwup++3p/9RMP5V
         OENb0767LotLvTjNmVUbH5shIZ8LN4ZLpzAv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566322; x=1691171122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY3Feo8GPlidh1PLbTYaalrVAHf4dxKu9JSTiyyBg5Q=;
        b=KQi5HQnO/c+YBfJG9TtFOz9gW/2guZAHFsNECpqOaIDqYk286B+0kiM8qjd+gcgfUD
         ROIxBf5+aeGZ+VRX41IhZaw/Jmwg0sBdaC47UjJp2iCq1DAZuXc/EJ0ojdnnr/Tuv0II
         l0/AugmRAy0LEyk40cAzyE0Nvf87+Mr1gXIzIv5X3OfPUqveajvSi5EadtqRkCbtNs1s
         bCTD4h/TKZXJLVWisvUF60gDypWOutu+tkemD44gBpsiVY3XjwULvUXfqs9i+RBPrejj
         6HKEDKgWCEoo5SW3q5gdWxh0NeFYaE1pW5Avz3PHjCaesk0lXXCe6NM1sK8bxLzTktOA
         zzJg==
X-Gm-Message-State: ABy/qLZYulfnWGf/OFI8Di4rkYneMJ81prx+G0hWtgTABU+nhwG0vRDP
	UK51zqjyLcjPQv3K1Ykmg0IHY7v2VfWTKBhDsIUbYdyx
X-Google-Smtp-Source: APBJJlGgOgTheKu3WfaRbSnyjIPc1PGZZg39yM8tygMil/JbfSGvxBgNge40R6PtAer2h89BrffgJw==
X-Received: by 2002:a17:906:4e:b0:99b:4ed4:5526 with SMTP id 14-20020a170906004e00b0099b4ed45526mr75461ejg.7.1690566322743;
        Fri, 28 Jul 2023 10:45:22 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id ck8-20020a170906c44800b00982be08a9besm2316343ejb.172.2023.07.28.10.45.22
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:45:22 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so3036959a12.1
        for <v9fs@lists.linux.dev>; Fri, 28 Jul 2023 10:45:22 -0700 (PDT)
X-Received: by 2002:a05:6402:1651:b0:522:595f:5a29 with SMTP id
 s17-20020a056402165100b00522595f5a29mr2522798edx.29.1690566321333; Fri, 28
 Jul 2023 10:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
In-Reply-To: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 28 Jul 2023 10:45:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnCth-xYWDG8q8ESFJO-KYGNbaXQkMg5ABLEGPmtFE6A@mail.gmail.com>
Message-ID: <CAHk-=whnCth-xYWDG8q8ESFJO-KYGNbaXQkMg5ABLEGPmtFE6A@mail.gmail.com>
Subject: Re: [GIT PULL] fs/9p fixes for v6.5-rc3
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jul 2023 at 19:09, Eric Van Hensbergen <ericvh@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git fixes/next

Please be more careful.

You *meant* to write "tags/9p-fixes-6.5-rc3", not "fixes/next".

                    Linus
