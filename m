Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE76253D9
	for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 15:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EB9C433C7
	for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689607767;
	bh=0YKskkLWLYYAdPQTYsxFMiOsoioCRE77sLgpA/AR0dw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q7eVrstNGYzGiJVpmUi7p+5JBGyJQuuOmHaxZd5duTNqnSMqDDBDCjYmY3mGZ5Dkc
	 oKj2nq+7mUkYP/2ar6GmurNin5MjQv/O0vGuFgLZyQEAPM+8XEzZ6/RmfWCn1JkSbt
	 7lwmifymFPkLXh1gmlEz67HDAFuwOhGnbDNLP7ls7pP1kR5o2M65koU++j8ld/JbqI
	 y+foqwUTJQXSheym04141ql0EnhhxpTEBdyePGLvvxjogfcSisJZQHo8ZyR6iWoZQ4
	 SR7/xkwGOw5qt68JL2cB/QK9woccQPBu1McDocPpp9rrn37Odc04pWFbbrlg3XUe09
	 VwNYB1bw5y1fw==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-cc4f4351ac7so2916610276.2
        for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 08:29:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLZWADgkpiaV2FDVcDzoGiE5wI6YW/Mfs3B363RkQa5Nr2VktYKF
	Bn36IjrW6BroSU/+2yKgRdB7m/78TSPKaHGUbFg=
X-Google-Smtp-Source: APBJJlGUn6P0TsMmtofHblsuKH6U2UDXCd0uoYXMgq9DEt/h3WxA16vDgAh9U69wK1a3kqjgHiNtmagui+YfHKPxK4Q=
X-Received: by 2002:a0d:dfcf:0:b0:570:6a58:d864 with SMTP id
 i198-20020a0ddfcf000000b005706a58d864mr10935163ywe.51.1689607766145; Mon, 17
 Jul 2023 08:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZK25XZ+GpR3KHIB/@pengutronix.de> <8322841.litLk3al4c@silver>
 <CAFkjPTmrbe9Djs_iYf=vu1xbTLhey0OmePR2Jw=C_dbQVYnAhQ@mail.gmail.com>
 <11571626.Ud7ZN73ssd@silver> <ZLDe09znEIA9t+KF@pengutronix.de>
 <CAFkjPTkNhGEDVyozHbVCkkFEkuQKiO6tn8Qjt4occMoupUupZw@mail.gmail.com>
 <CAFkjPTmyo0yXy2cGN9Zzic6Jd3QXLdhj5bUtNpQCvAudShx+Rw@mail.gmail.com> <ZLUlWpnmM6068KV3@pengutronix.de>
In-Reply-To: <ZLUlWpnmM6068KV3@pengutronix.de>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 17 Jul 2023 10:29:14 -0500
X-Gmail-Original-Message-ID: <CAFkjPTkYKeTHk8DUJBCk8T9nmFV27onyU+j9DbcNQPMYAw8sAw@mail.gmail.com>
Message-ID: <CAFkjPTkYKeTHk8DUJBCk8T9nmFV27onyU+j9DbcNQPMYAw8sAw@mail.gmail.com>
Subject: Re: mmap on 9p broken in 6.4
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, kernel@pengutronix.de, v9fs@lists.linux.dev, 
	groug@kaod.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Robert, I was holding off on sending the patches out until I
could make sure they fixed the problem, but considering I've been
having trouble reproducing in my environment I'll send them out now.
They are also currently available on github on this branch if that
makes it any easier:
https://github.com/v9fs/linux/tree/b4/fixes-overly-restrictive-mmap

        -eric

On Mon, Jul 17, 2023 at 6:26=E2=80=AFAM Robert Schwebel
<r.schwebel@pengutronix.de> wrote:
>
> Hi Eric,
>
> On Sun, Jul 16, 2023 at 02:48:27PM -0500, Eric Van Hensbergen wrote:
> > A quick update on this, I have a patch and it passes regressions
>
> Thanks for taking care! If you send the patch(es), I can test them in my
> setup.
>
> rsc
> --
> Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  =
|
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    =
|
