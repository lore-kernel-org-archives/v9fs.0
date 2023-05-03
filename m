Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534309479
	for <v9fs@lists.linux.dev>; Wed,  3 May 2023 14:11:19 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-94f910ea993so859635566b.3
        for <v9fs@lists.linux.dev>; Wed, 03 May 2023 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683123077; x=1685715077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5LxvsPjOYAe3iUvm6GoNOplQUzGwHhxqPoIECxKyo0=;
        b=MlI0yIfbI0bE1J4sKC+POMzM+vqeNwr3y01aaXeiE1eRtOo8aRf+9D78mjMyeq9RGP
         3BZiyWaV4hWy2lrCHmCrUNqVY1JZmKI/q8YyfFPV7IOCJJCDLIlzqvmxK7eGkQt0L13f
         2uDPHfJkhp7XDl4hDYybia/JUdTBVhZBbxnk+9O0+9/TTXjjW1rs7l9CMgu4PvL5M0dx
         iE/G9HtGARY4p8GKlgBfYSkfnGpSBgOSZnD80okL/wt2vCQTRGLusaps4XBn57/8LbfQ
         aj7fGnwM1LnOO7Ssv00LqMQCv5OAq/efjACNJCgUwSeQViJDZSfkLEcBE5KFB4Or99EW
         4hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683123077; x=1685715077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5LxvsPjOYAe3iUvm6GoNOplQUzGwHhxqPoIECxKyo0=;
        b=ixjcl3ooYq2QX4wxzc9V7T6Nt5YkyHZB7nzfHz4roR7LxB5zU9c7kaye9vV26qzkcx
         PK83RvFHntMMK0ixQNdGukeiVn/OFp+mqOTUJMaEjC8iVRoU4T9JPIrPcfc+xcpgmGGM
         hkYo5knbUQsDJSJlSj+KUP6pCjcVxxYCJJPpx0JzqOXEJxoJpssUOYq3lO43iRvrLoWk
         kRcMlPPDesHsm39lt/LTBjX7XTWmFLl1WktZLhyTVyLrOyyjt+jBIeTZEBU1y4AVqbAR
         Sz8b5aYqcrYY+5wdUAtTCox+pMPBzRCzp9yupoB6vuKXdT9ITylW8Zt77VAAxiHybBu6
         8lWA==
X-Gm-Message-State: AC+VfDwmYYPn3PPvOSTBDOG98oICcNuke07W4tOUE+C/0nFp8qynPAfp
	m0xzP1pPwizm81gepefSywxOKnhy1TExBp4LOyc=
X-Google-Smtp-Source: ACHHUZ4ycd+6VumABdUuT3gG4UU3LoMW7fnsENTwKrMH+DfWXVkBR4bfgazOBqtq/y6Ot8Yh0BXJK0SvQJoL41aSzUk=
X-Received: by 2002:a17:907:a08a:b0:94f:3b07:a708 with SMTP id
 hu10-20020a170907a08a00b0094f3b07a708mr3652466ejc.29.1683123077123; Wed, 03
 May 2023 07:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501190602.86281-1-jandryuk@gmail.com> <ZFAWaQbDR1_r5jf-@codewreck.org>
 <CAKf6xptMDRVet-C_1H7txPb_J_xq+XnNxwrQVbNWL_2JGnbHgw@mail.gmail.com> <ZFGdTDrPa1LD899y@codewreck.org>
In-Reply-To: <ZFGdTDrPa1LD899y@codewreck.org>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 3 May 2023 10:11:05 -0400
Message-ID: <CAKf6xps8Z8GJZV6SJDmh7cM6v8EDuE6=V8+h1adjivaB70wLsA@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: Remove INET dependency
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 2, 2023 at 7:31=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Jason Andryuk wrote on Tue, May 02, 2023 at 08:03:15AM -0400:
> > > Good catch.
> > > Could you add depends on INET to NET_9P_FD in net/9p/Kconfig?
> >
> > trans_fd.o builds without INET and without UNIX.  Looks like trying to
> > use either TCP or UNIX sockets would lead to runtime errors, but it
> > also supports generic file descriptors.  That could be useful for
> > someone.   Since it builds, would it be okay to leave this patch
> > unchanged, or do you still want the depends added?  Leaving the patch
> > unchanged provides more flexibility, though the runtime errors may
> > surprise users.  While I built a Xen kernel without INET or UNIX, that
> > is an unusual scenario.  Typically INET and UNIX sockets will be built
> > in anyway even without a depends.
>
> Hmm, good point; the socket interface is common between INET and
> UNIX.. And you're right about the ability to use plain fd as well.
>
> How about 'imply INET'? That will automatically select INET when
> enabled, but allow someone to disable it explicitly.

This sounds good.

Thanks,
Jason
