Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738743A7842
	for <v9fs@lists.linux.dev>; Fri,  1 May 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645761; cv=pass; b=lywfsUAMTruCONdaSYsY1nvcpQv1ZRBhxhHcTnEYoT30pQqlIipG8JNEaNtnO60ZHoK7ZMgT76ZXtwuPW1oYE+c24h/DjFNGN0NJ46c+OYLPTcFvj4LIsBY1ALd0SU3g05yUCMiMh2nSNOJRU27BrYg+dhatl6DYNbnjPUDeOCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645761; c=relaxed/simple;
	bh=mq4Pv/rTDob2iNuqT3iMr9IyUiJi4IE1doWYfBTmK9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P53EC9A5ZBSWTFM6WUHwHKAkhaSi7rxaCie2TBVM1Fp/kABi9FbbrcN/FxiEXE3LPI7+CSq0gTv8x6ntKzfj5OCt0G44+KnevlQdGEqkqN8y9NpkxnPB8emLuuegKUHO46YowqNqvUIaczIMCou2kg1sPh0b8erc0rj0TOsuo1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+RMpMBv; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+RMpMBv"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-95672e8d787so321356241.3
        for <v9fs@lists.linux.dev>; Fri, 01 May 2026 07:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777645759; cv=none;
        d=google.com; s=arc-20240605;
        b=NP0EbetnH9Me7dwZuDyk4GLXke+NnSwo/GUkT2aNg7NN3Wppe0Q2KwxefBjfZkPooq
         ztxqqQYZERZSpniZTft1//nYen8SSpg9cXjfPuTQB61nTn5IO+V/wVbRlp2MA682A49n
         mEnr0xHnxxtUOvgrVUg3hV5I00fdmFGqUxJ3nTg8pjJYsW94SxqzI2MTalRPPWAFP8xg
         b6ZfXUKy8T3VWptO/ZESki8Ljj4Bu+RuR99BQ5c4klJ/8X8LYcEmkS0ro55PZHDQZ6rB
         +psQaa04WsTPNq/zs22kayYjFi3N21LfFUK3iWTsS60YR3jq2B0gdOkVQGNtd104/TU5
         OWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FtNWZo2goa9XDh0PKCyT0HpJevDRPSvkHWhqM9mCn3s=;
        fh=qUGXJQ0tzEg5VOZq67hMKcuVPEeUxPI65MANeABCE4M=;
        b=V8TfGzZdHOM6tzkrccsWhGSuyhnV8L1W4BHWUicnSyRIFSuJO0NwYY0q7JaYa8WjwS
         zeHs8O04yrPt8gTjTkyydh4VSPSTm4hwpza6QzJYooA7E97a9c9KEmZAv+beycfAFZum
         7b7Es5n16GY74kq8/P778WDeaYjNvJyC+xqW/LZwwGZJ//Nfk91KLRVPLJQvIcPbQslb
         jokqjiLdFySiCGZ5mhqGHFcK4MoBTswYuZhEMq4k5AATIiejKKnJqkFeSvHwoD/mjMD3
         F6utJJN2Z5s3+xM0LMj/mXJq8BmNhKfm/O9RKBp8d383FyPTKveS3mYINyReYku9tvEz
         +afw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777645759; x=1778250559; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtNWZo2goa9XDh0PKCyT0HpJevDRPSvkHWhqM9mCn3s=;
        b=F+RMpMBvJdkM7i1fqBhuO3OMjRpo5LUhayimxR6eMvhoKJiPtfpJQof75+cLln3d5N
         YIJzeTMkbcP0Ze9hjq6gwfub89zENSLylYIuOwBtwn4g5lVzto8BOG5zpTP7X2jwGSQd
         96a1BcWkM+gJnTQk4tyYS3hBpzpGjNaURbJHBeWae1kuE44yjFpUaumdHb7SXsfm0rF+
         Mh68Ayau8J+PJcOY0UQbSKF1h0WN6E1944nS0j9Dz8OEnmurQduNTZ6ByLOJme35YYjM
         sxETf7ErJXyobFmu/d/1vq1GX4qax+Rr+W8hOBco4+t2gdG764KG8TO/HL2Vc72khUGu
         TKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777645759; x=1778250559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtNWZo2goa9XDh0PKCyT0HpJevDRPSvkHWhqM9mCn3s=;
        b=JtxPP40ul/PGAEa2wh/pvZzsd0FIID4neoYIRi1ZXMzioc1khXhfxN/FduaNow03YL
         bIYJcFIShPRzsO7qxAZhFk4aqoG51lfp/q5miENaY2mO8Kz6oCTTosm4uKTQP1ZcTkTp
         vW1lz/uxpm/QC5cvrn19u0QISCYIj07aCOrtVPTpdK4vpGdHd91ge5G+B9b8NloVcpDh
         DFWq4Z3i2aoGpFkpYFbpxho1fyUV/0fc4HAltLKD9EDzsuBB+j6l0LQnsMPGCu4cQTmR
         n1PNixJMlfzdiQZPyx9BwplFKtIAQ5XbrDc8/6YmCLgd3EnYOfagbXSqV9RmboWxl6+G
         2L3A==
X-Gm-Message-State: AOJu0YyR4y3tHu8PPPIufQl0KogjvnhxSn/mT0f56e1KwONg+4YC0L6g
	xdJkQDU54lzi3gzTXc8lPkEYlInkh+3IuMRpthQ3VWRq34UAgEx6uNYKTGtohoVUGZRiFBmEPTA
	VOFMpoY1Tsmo+GLQMl/N++hk7stF2jWTppZ+e
X-Gm-Gg: AeBDieu/syV4klH2RdHJBCfLZGtk18hwdUu12FjHPNqVwrwS12VpgePUL5ZP+o9tYEs
	GV/eJTV+vSd7voge43y1BMpNeumCCm0tlHdBScNqOHSgYXJhCjPyHQNXE6hJTTjSQBcUkzlBeVB
	ErKSfSlKbEz3wjiy2fK9U+7caae7pTQ5Qf11dBfgt0b+uP/dNalGwG76R5okN9i3xo1HSdhrxSs
	sVBS6hac/oBWoZhU8PcpqulYfV03TlA73LKZGRTgBNGaMy1lVtekizOZ684tss8c/rAtVTDktaf
	dbIvzkK6ugQdJgpeBFtdLnkusFhEruLjF9QZVb4PRwZ8ja7XG5HUrQAc0yAZaxRnOaQpCJbrzvL
	q+h0teyufMbyfDcBbSCiKz8nAe7SSRcRwPW21
X-Received: by 2002:a05:6102:a53:b0:612:21f8:5afd with SMTP id
 ada2fe7eead31-62ad2344316mr3629342137.12.1777645759176; Fri, 01 May 2026
 07:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFkjPTniiwtBLf7yUepG_846QM6BeuKbxeisByQVTwkEQtjsZQ@mail.gmail.com>
 <240a0dbe-370f-4c8c-9dea-877ad1f7481a@app.fastmail.com>
In-Reply-To: <240a0dbe-370f-4c8c-9dea-877ad1f7481a@app.fastmail.com>
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: Fri, 1 May 2026 09:29:08 -0500
X-Gm-Features: AVHnY4JksealnWmSoIZSpCyTw88tJa6v76JBO-KfkpDIfwg-Tyry45Y7gIfT_8U
Message-ID: <CAFkjPT=sF=cxhLuun9UaX6dT6soqZze5G1cXZPJRAXfCW5QXbw@mail.gmail.com>
Subject: Re: FYI: v9fs/test rework
To: Pierre Barre <pierre@barre.sh>
Cc: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Awesome, thanks for the pointers, I'll have a look.

On Fri, May 1, 2026 at 9:11=E2=80=AFAM Pierre Barre <pierre@barre.sh> wrote=
:
>
> Hi Eric,
>
> Glad to hear you're picking v9fs back up. In case any of it is useful as =
a reference point, I've been maintaining a fair amount of 9p CI for ZeroFS,=
 exercising the Linux v9fs client against the ZeroFS server across a few tr=
ansports and mount option combinations:
>
> https://github.com/Barre/ZeroFS/tree/main/.github/workflows
>
> Not a generic test harness like what you're building, but there may be so=
me scenarios or pitfalls in there worth borrowing, including xfstests:
>
> https://github.com/Barre/ZeroFS/blob/main/.github/workflows/xfstests-9p.y=
ml
>
> Happy to answer questions if anything looks relevant.
>
> Best,
> Pierre
>
> On Sat, Apr 25, 2026, at 22:58, Eric Van Hensbergen wrote:
> > I've started picking up v9fs again for something work related, but set
> > out to first fix my test infrastructure.  Being lazy, I'm having
> > Cursor do the test infrastructure rework for me -- it is still a work
> > in progress, but I think it's already handling the old tests and
> > starting to add new ones.  I need to suck in more of the diod testing
> > framework as well so that I have full coverage there, and then I'm
> > going to look at adding hugelgupf/9p and go9p.
> >
> > As part of this, I should be able to fix it for nightly builds and/or
> > at least tracking upstream with regression tests across the multiple
> > servers.
> >
> > Currently running in the main branch of github.com/v9fs/test
> >
> > Fortunately for everyone I'm not tilting at the caching stuff quite
> > yet, I'm more interested in the synthetic file system angle.  So don't
> > worry about me breaking everything (yet).
> >
> >        -eric
