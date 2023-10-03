Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358191548D
	for <v9fs@lists.linux.dev>; Tue,  3 Oct 2023 13:55:55 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a22f9e2f40so11090207b3.1
        for <v9fs@lists.linux.dev>; Tue, 03 Oct 2023 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696341355; x=1696946155; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e47KQqmvrattxja1YQ2aTfwqutE4ILLnK+WXsK/hoxs=;
        b=Z0uWNfpv6nxG54YHWOot0Y83CALszxF3tVGGto0OVlfaHB6N4VJuHOR/lq5gpe8pE9
         NN95LdYhg/SyMgVHJnHBwaOCXUjpHtgRPdhVB/wvyek0Gy6UQD/yd4+bZt6LeyWcVFuv
         Yp/NxBE/WC7y00dTzKoilCxzUvkaG8tjCotj5gZ41AaTXf5mGYvZoOGtkP/kV9TVHWMQ
         8jjbyOQ6s6wqNAfvuEGWNgWB+QyPg3s02HeGasrNmZFVk2dFgTS7lMyvuq0aFYRmT6q8
         3EeBwj7h5Pf/JKWs8jgH389qph9iPuIclPEsfE8+4Tc0Wo+/pkShdUL0iXOTWjjwoP6e
         gIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696341355; x=1696946155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e47KQqmvrattxja1YQ2aTfwqutE4ILLnK+WXsK/hoxs=;
        b=bMRjdr8VoRalrOKpc2XwS+foSEu5gATkxUZteU5flzmyNGPopny1V3bbHzelE9qhAB
         aumRi0cu1q9lgj8J0cwmjuMp9t62i3f7Jel7KOduyNHk0moOKkzAOc6ryuJMqKw9tt1F
         aVUC5XfQrFx+BLndjBDT42Whhc5uSr22xGfY893QA6SX6ogwpaKBDkxAtTwue1lAhXI7
         +xcajDBhoYCwawd6Fh7v8urwIpN5lLXH92xx14S4wwfELYOTOvm5EwkGGRPov6Ce70QY
         l7iE2XWobkvkhbAw+DIPB7DncRvqTmcK2cxSvs39+4TKxmQ1S2hFGG7RUwwrojZ1EHSA
         CBFw==
X-Gm-Message-State: AOJu0YzKgwY5EGdqqfKVOunHCUH/6pTY5Xp8E0hH+15paKceTD659zW5
	9VtIqetbbI+M93bAqxHoNrQGe23piW/fzIup85A=
X-Google-Smtp-Source: AGHT+IEhXzR//Jjev9ftMKRZBGzNI4vilpgfXx5YzJgF49LCZZ9ICYZFaD6VDvwLkYWpxBxMCcyEznVjJ7bMzxesXQQ=
X-Received: by 2002:a25:1f56:0:b0:d78:f32:5849 with SMTP id
 f83-20020a251f56000000b00d780f325849mr13126245ybf.24.1696341354734; Tue, 03
 Oct 2023 06:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230930050033.41174-1-wedsonaf@gmail.com> <20230930050033.41174-4-wedsonaf@gmail.com>
 <41368837.HejemxxR3G@silver> <ZRfkVWyuNaapaOOO@codewreck.org>
In-Reply-To: <ZRfkVWyuNaapaOOO@codewreck.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 3 Oct 2023 10:55:44 -0300
Message-ID: <CANeycqptxu1qWAHLc76krDmfgesANPX+FLEV51qhtXam6Ky9nQ@mail.gmail.com>
Subject: Re: [PATCH 03/29] 9p: move xattr-related structs to .rodata
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>, Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Sept 2023 at 06:03, Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Christian Schoenebeck wrote on Sat, Sep 30, 2023 at 10:12:25AM +0200:
> > On Saturday, September 30, 2023 7:00:07 AM CEST Wedson Almeida Filho wrote:
> > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > >
> > > This makes it harder for accidental or malicious changes to
> > > v9fs_xattr_user_handler, v9fs_xattr_trusted_handler,
> > > v9fs_xattr_security_handler, or v9fs_xattr_handlers at runtime.
> > >
> > > Cc: Eric Van Hensbergen <ericvh@kernel.org>
> > > Cc: Latchesar Ionkov <lucho@ionkov.net>
> > > Cc: Dominique Martinet <asmadeus@codewreck.org>
> > > Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> > > Cc: v9fs@lists.linux.dev
> > > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Thanks for the review, Christian!

> Looks good to me on principle as well (and it should blow up immediately
> on testing in the unlikely case there's a problem...)
>
> Eric, I don't think you have anything planned for this round?
> There's another data race patch laying around that we didn't submit for
> 6.6, shall I take these two for now?
>
> (Assuming this patch series is meant to be taken up by individual fs
> maintainers independantly, it's never really clear with such large
> swatches of patchs and we weren't in Cc of a cover letter if there was
> any... In the future it'd help if either there's a clear cover letter
> everyone is in Cc at (some would say keep everyone in cc of all
> patches!), or just send these in a loop so they don't appear to be part
> of a series and each maintainer deals with it as they see fit)

There is a cover letter
(https://lore.kernel.org/all/20230930050033.41174-1-wedsonaf@gmail.com/),
apologies for not CCing you there. I was trying to avoid spamming
maintainers with unrelated changes.

We need changes in fs/xattr.c (which are in the first patch of the
series) to avoid warnings, so unfortunately this can't be taken
individually. My thought was that individual fs maintainers would
review/ack the patches and this would be taken through the fs tree.

>
> --
> Dominique
