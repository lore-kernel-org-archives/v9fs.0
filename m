Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFE1C14
	for <v9fs@lists.linux.dev>; Tue,  2 May 2023 12:03:29 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-959a3e2dd27so730780466b.3
        for <v9fs@lists.linux.dev>; Tue, 02 May 2023 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683029008; x=1685621008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/YRcfxmNsr6Lwk5XiJCdhjiGVkTxQwDjCgW062Di2c=;
        b=o4kdKwTRk33hC4HFcBT+9b69VKLPjjiKCZpZtoFD1ZnB8NitPdOUHk5aiyQQdQKpnE
         S755qs/iAEPdoqWzgHnm8nvpBxEL4GerVyo1qoRBz8+M+DCyhRyh/07WdUCO2qd2rtKh
         hn71j5Hb+bm8A3fyrNZz9tXMVybcf3jvbZnA6Xa22Oroh+uATM0eoq4nbzeV9ZvmjmWa
         CYtI3Y7/Qqe9yDTxyyyPVlzXNgaJe0uU6csAwyWLOQWoZ1egG93e4fNOB4SQuQ2Uukis
         EF8rlIuLxuXTZTLbNzJ4awhOe8mC14lHN36kPXG8XJeOY5mTMbbyc/MidvKmbiKVf5vh
         E1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683029008; x=1685621008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/YRcfxmNsr6Lwk5XiJCdhjiGVkTxQwDjCgW062Di2c=;
        b=KYqkeLIqrk+67ct8BkOcpLGsbw+dhBBDuWwWKMwGm+0YMTrxP5j82CZv9ws5a8OlOX
         dBIsyQKIi8duipyMcuyXnKDfUH0fk0d03l4cX+yvw1t4xMJ1P4lUxjYOeXDyUUc+yWFs
         /MRNbOXgPdfWQPUbNxd4KN7RmGIja2+P8wU915wRa7tOT/ECM/0GJsZYa1RNkjyURfH6
         BMzo0fv1166nOKxyXHVNJcmNFGPw4OZQxABdAIqak9JSlYA0NItnw4hrI3epe7ATNLAp
         mNrqBBFEAcnc7DmxciICq7ZuTGNS5Fcn2nLERlwNrw01ZTUSWSDER/uz6Rl9qRWnV5Ex
         Zf1g==
X-Gm-Message-State: AC+VfDxVloe6kZVrh/vLJxqjRo816GeCYV4J2z7BZNCRVXwvmtv+hglX
	hZeJzeOxKab/sgpm2/stEw1N4j7J8O2YLiUSP6U=
X-Google-Smtp-Source: ACHHUZ77IpXZRekNr9ddahoipzbC1kDJT3R5mRFNBoWxh8ZKY2WJdgkQlRP98U6GJ3oEml7kk+65AQHLB49FL8/62VM=
X-Received: by 2002:a17:907:1613:b0:94a:82ca:12e5 with SMTP id
 hb19-20020a170907161300b0094a82ca12e5mr16593096ejc.45.1683029007546; Tue, 02
 May 2023 05:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501190602.86281-1-jandryuk@gmail.com> <ZFAWaQbDR1_r5jf-@codewreck.org>
In-Reply-To: <ZFAWaQbDR1_r5jf-@codewreck.org>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Tue, 2 May 2023 08:03:15 -0400
Message-ID: <CAKf6xptMDRVet-C_1H7txPb_J_xq+XnNxwrQVbNWL_2JGnbHgw@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: Remove INET dependency
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Dominique

On Mon, May 1, 2023 at 3:43=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Jason Andryuk wrote on Mon, May 01, 2023 at 03:06:00PM -0400:
> > 9pfs can run over assorted transports, so it doesn't have an INET
> > dependency.  Drop it and remove the includes of linux/inet.h.
> >
> > This allows configuring 9pfs over Xen with INET disabled.
>
> Good catch.
> Could you add depends on INET to NET_9P_FD in net/9p/Kconfig?

trans_fd.o builds without INET and without UNIX.  Looks like trying to
use either TCP or UNIX sockets would lead to runtime errors, but it
also supports generic file descriptors.  That could be useful for
someone.   Since it builds, would it be okay to leave this patch
unchanged, or do you still want the depends added?  Leaving the patch
unchanged provides more flexibility, though the runtime errors may
surprise users.  While I built a Xen kernel without INET or UNIX, that
is an unusual scenario.  Typically INET and UNIX sockets will be built
in anyway even without a depends.

Thanks,
Jason
