Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CC36F8F1
	for <v9fs@lists.linux.dev>; Wed, 27 May 2026 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863938; cv=pass; b=mkP4+jHdc7AnbAUXnxNIZmMImbzQeHMNkXC9fSLllAqHCNL7w5AO+UuTYBt6ZoVG2z5ZNYfbMJ25/KjBvCy6HTUkvk5N+HtmK4KNd7o1BDdKjmknwzVD7aRFGFz4YLl3EELG9/Z6EeLennfolxM+JvI7OLyrYIadmQ8i1JO3Tpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863938; c=relaxed/simple;
	bh=KieXeTTzSaX3Wd2Df211Un+1XB8TuDEupJ8KucegxqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0JHghK+Z/AnZxEL2zpQGHosC7Tk/gd9uI7h/JwAuzw7lcRik712eHNDQOtIYvY/eY5ZOCqSrHXFnfnKcxHU3uLpzCJo8u2Pvgx/AQPpAMvwpGIK0rydNV22AIE29129l810zDdx8e0cgC8sdnf/SxD6qZpqAKdqE5OHApOhq8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c24A2bSM; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c24A2bSM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so2899709a12.1
        for <v9fs@lists.linux.dev>; Tue, 26 May 2026 23:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779863932; cv=none;
        d=google.com; s=arc-20240605;
        b=NlTzrNihUjDgWeYdg2oJpqPsfz91kcWiAzwGI4LqFTUQvHNRkgptXh6JnnnBdiLkbV
         yiW5m7ZMI48qdocqV43zxsRvtywnB4ZwYWOo8cwzhWuEvOaysgeIcneRfw9JydZPcd1g
         XscMZw0mAYEQwmCwGRa5Xra6x8Wokfcngyt5H5eR66DJdn3qYxRLgPhpIcqk3Rlzdg1r
         ldycm71lQt5xQpy6PTdJSwfWBsWjUvVYFm18t2diRVs1WgoRbRbBcjBIdSdg9KinFw6e
         E8gvxTYFYfGCWCSjR3fxitdYqWKuI5QwjYRTohdagRrliNb9AMXqjuPqQ8ojbIKGMZIx
         iU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=36ra5VgtJ+tncYjrsa+qAxSP9cEsjFFijd+cj/4Knqo=;
        fh=NPfkj+EimQvcdPvIVYXCtPvMsGDq8hRb6iBwVlbe7Ok=;
        b=G8dRUV60O9muCgntKfuAf2mV9mw5Op46zPhCkDCs+FR9G0jiJB61tKUA8KgCrdPs/H
         EFCdOYUiGbFevsOdKF4VO5Sv79azlowhtmE87jlP5PhihygokJ67aFO8+Qnwp3qs18ln
         GPes+1iW5sGRXPCPeMj1JCdTKfPHKdh0kv7NF3PmUVMu00t/vkqtR2PRK5g9vYUYJ51d
         /UlSi52cIiFRJYbZLoY61t++gFkPROVwtasHU2629XIOtuKi0iCqVmoFEoBPZettGTx7
         o5kNJjc82B/Y+KmCfEXQ4pLiSgbOG+0EaiYJU/r/mw+5qvsar3qmDf7Y2DA7/ssUSlSD
         E2xw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779863932; x=1780468732; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36ra5VgtJ+tncYjrsa+qAxSP9cEsjFFijd+cj/4Knqo=;
        b=c24A2bSMCJBinZ5Pko4gGRzYpUsSzonxWp+QQbkq2HSsLPKW+6aXqSmOzinkriAZf1
         IqssuZU2GWQbHzJqooKEJiv1SpZPbiSj92kJsGLss9ehI7QQh9YEH++9UxbsvhWEuZ0D
         gDswcksHzzRZAZBZZdJ6k3FRJ5hs3OykJA8VO4V6um7/hY9t6G+Ljk3yCDBIDYizJo/U
         ogLWSQ+pAN6UypQqwnOy+uuk+I6lKUM8wLduW9ATspPKV7Csp12zjxEiZTK8zSb1BM5o
         IzBHhaWY0c2iVY7oZ47ImdohMRyufhYw028SFmFWquYFUzKz2F1uyk40sxk4qJIGvvfx
         0LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779863932; x=1780468732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36ra5VgtJ+tncYjrsa+qAxSP9cEsjFFijd+cj/4Knqo=;
        b=RT4Wbg5KPZ3CksU3DbxqpxBVMvfTJN9bjWYflPseZbKqTYk8RUgNnzJR86GRsnv0bg
         6G2ttHw+v5htXtOMzudVc/x8gCCVFFLox8z1B4++84/9S9YorJ2EdomHZJTMqO2u+R41
         rLEMi4hLLEyvQI8N/808lPBuqVdOK4M4SmS4ZXOGEgkiZcHHZNbDlpaoGYQvoTau5awl
         Du0/T8m6reVxiP1E+iirIfN6ccOPGX8n6MLqlPl9GgP9cmcaMIcve2mxMb8TncVSsNVk
         mnGgZvdyLuj3OHw4R4VtcIhjErSVOO9RxHJsq+sOpZj9WNpsdzmzXaBvZHyu1N1la/Dq
         8pxQ==
X-Gm-Message-State: AOJu0Yxhbkx/5Lxg/3bPB3VCq8x7O6GqSULWrd/3d1tenYzdsGcAwgc6
	0C4ezfpM1PJlJoDzRzDfqhuKt4R9cDoNKCSVnD4du/9KuOUkEwxLMfoIVtLFgk88B2X7th7/GJ7
	B6k4KB1P8ud91HPuqnmDbOZTsmtBea6w=
X-Gm-Gg: Acq92OGWdFSEGqZL6tOKeMUEtTz6Tdef8WjP02qAieHw18uUavUNMl+tviITxfOaBdm
	HwgLS1V3aJriTOpnrj4sP4eLkY2cg0gJspbJzQsWopYTgbdfaBJHP3mv4MlnjOp3s8w5LmYophr
	rhYt3eJ+iNcuLaDUDAu55tRs6wWKsFjmZQehBJHim7i/K8rmKumBMA0L3VjTpYIvf4GGtAtk2cy
	3qu/x2zLXXWto63G72kTnQaq+OaD5nMWh+IN45ru29HQsZSDfrI57t7Z1fN2Bjbpr0vIeRyjyrT
	jqpQ4i11rS3KiOI5l43VQzRJt+soXEIR53D0jk4L/Mf2W1pM+CGTgcrWA5SRW7+J3GLRDqm0hZO
	1vrZb3X4seQ6USPq2Wp0aFYdQqDRyvPMLZ3jidmYV531bIN/ywcpU6wokLducpeoVOOil
X-Received: by 2002:a05:6402:142:b0:67d:98bd:e44e with SMTP id
 4fb4d7f45d1cf-6882fa79169mr8835960a12.17.1779863931592; Tue, 26 May 2026
 23:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260519015739.634423-1-rosenp@gmail.com> <147ee577-8a72-407c-b332-45dda9f153b3@suse.com>
In-Reply-To: <147ee577-8a72-407c-b332-45dda9f153b3@suse.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 26 May 2026 23:38:39 -0700
X-Gm-Features: AVHnY4IIj2ZshEO37UwTLdLNgc9FgzAprKEjm1w49qSFoSFsTv-p5h8BGJb3W0I
Message-ID: <CAKxU2N-t6mjfGPmeRq3ychV0XKULhwOvq7EVQHtjG2eQ=KDGpQ@mail.gmail.com>
Subject: Re: [PATCH] 9p/xen: Use flexible array for data rings
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 10:39=E2=80=AFPM J=C3=BCrgen Gro=C3=9F <jgross@suse=
.com> wrote:
>
> On 19.05.26 03:57, Rosen Penev wrote:
> > Store the fixed set of Xen 9p data rings in the frontend private
> > allocation instead of allocating a separate rings array.
> >
> > This keeps the data ring storage tied to the frontend lifetime and
> > simplifies the allocation and cleanup paths.
> >
> > Assisted-by: Codex:GPT-5.5
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   net/9p/trans_xen.c | 68 ++++++++++++++++++++-------------------------=
-
> >   1 file changed, 30 insertions(+), 38 deletions(-)
> >
> > diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> > index f9fb2db7a066..5a110d71d18c 100644
> > --- a/net/9p/trans_xen.c
> > +++ b/net/9p/trans_xen.c
> > @@ -55,7 +55,7 @@ struct xen_9pfs_front_priv {
> >       char *tag;
> >       struct p9_client *client;
> >
> > -     struct xen_9pfs_dataring *rings;
> > +     struct xen_9pfs_dataring rings[];
>
> Any reason not to use rings[XEN_9PFS_NUM_RINGS] instead of a flex array?
>
> The number of rings is a compile time constant, after all!
flexibility really. I don't know if this will ever change.
>
>
> Juergen
