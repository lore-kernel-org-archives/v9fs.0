Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4B10EC
	for <v9fs@lists.linux.dev>; Thu,  4 May 2023 11:55:31 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50bcc565280so524554a12.2
        for <v9fs@lists.linux.dev>; Thu, 04 May 2023 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683201329; x=1685793329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEOKwlwL1tkxEiR+ZdLCkG8rCyDeDRTeVbJGwPAXSGE=;
        b=Rx1PxkEUSZX2Gwh18KtwSk/5C3dFrgX+H2AaM8bftpCHHttp6xvlf0Sp8WZOExZqdG
         gwnypz9DeKJMlnrBp7XMThdEgw1wHlr8EygBPLkdB6OCXakp1aRlphjih3t8jpI51o5h
         yTtRbCoUBunmy8cVUU4/Tuq+FJ+TwsPfAG7nKr5vt0HLtgRT6tqLnF0MFndEIr5L66fw
         0suNDQ5uLyhLsyq6o7j7/e9xpvIfW7mBlZOWGd0pnnDTMJXnwLx/3U/rP88yjBVo203h
         +tgs0kKHVpwDi7C6tCbafSBxP4PLrQ6VuXjVYGYiCK9aMmccOeVSO2dUqs9d98GFfjOB
         puaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683201329; x=1685793329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEOKwlwL1tkxEiR+ZdLCkG8rCyDeDRTeVbJGwPAXSGE=;
        b=Kd41C1JBgOO/nlzcxg9mhLgLxlmfRG9KSvSHWAoxX5+9rdD+HxdNOywj+3h3oOFGiV
         qNSy9cBt1NaqTwFKyUl80SZuDb3kF1rS+0K5FKGTL3OdjSqt0g+S41rpsZXjIurOiVFx
         3+DTAIEBODZE1fwVOF2OqO/3+jaWg4+9OAN6kIVE9a903trwqWxhA/70QDObLYN+Qre5
         MTebOBsMpi0N0vOYe8yTgepogHlrLJjFrEkWifHD7fyoHFLwGb9bFr0mbMvQl9JUrm5s
         Mi0qbdDae1RyS/vHmm3UYIpsoL+ANH4HdnbpsU2QuysDynPNbuSQlrdbb3AlxAuv5pXg
         OVTA==
X-Gm-Message-State: AC+VfDwAjehGsrIA9AkTr5nGq7hC4nZRGA8Yqm1XZnY2gsj3G1A+aHdr
	l+o/W/OJHBnb8WBvjtptnjKavclEZblO7qU6RTU=
X-Google-Smtp-Source: ACHHUZ66jegOa5ttR5HXWcc2L930eGU8hxtxNvfRUtILZHde78W74TppXdoANsNB+Ml/w7UwAF+nsq6hfEdAKFwvr8g=
X-Received: by 2002:a17:907:805:b0:94b:d57e:9d4e with SMTP id
 wv5-20020a170907080500b0094bd57e9d4emr6665740ejb.3.1683201329031; Thu, 04 May
 2023 04:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230503141123.23290-1-jandryuk@gmail.com> <4317357.pJ3umoczA4@silver>
In-Reply-To: <4317357.pJ3umoczA4@silver>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Thu, 4 May 2023 07:55:17 -0400
Message-ID: <CAKf6xpscky_LLxStzZ6uAyeWPXC3gALsA_zVFpF8X7uktw=MxQ@mail.gmail.com>
Subject: Re: [PATCH v2] 9p: Remove INET dependency
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 4, 2023 at 6:58=E2=80=AFAM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> On Wednesday, May 3, 2023 4:11:20 PM CEST Jason Andryuk wrote:
> > 9pfs can run over assorted transports, so it doesn't have an INET
> > dependency.  Drop it and remove the includes of linux/inet.h.
> >
> > NET_9P_FD/trans_fd.o builds without INET or UNIX and is unusable over
>
> s/unusable/usable/ ?

Whoops!  Yes, you are correct.  Thanks for catching that.

Regards,
Jason
