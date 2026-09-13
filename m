Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4E364038
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789328690; cv=pass; b=ftv8HE7Fh4QDSjK81TFNIyhdVp5IeNd7QNlllCjHZbNKM1fx5Pazxvg+lKwnMoHj6MuNhORzNfloAo+sJmZc9GTSLrwrD7ILrqGUAlLO66X/eW8vGkQLyYM3Tz10hWZYGGSvmZ7gFK2yHgvl3Kw5URA2RK6BG7LVJJCrQwHtV20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789328690; c=relaxed/simple;
	bh=c1x3tjxX5AVIWW3tLmux8nPDOgWyYyrg2724RgaFJt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnXry1S/khy7PYl1nzSAuydRVn5/gkxvi/77m7cJhh+1fxvvJte+twfHputvrVG7CEQcYi9LVmryGzUNLIJmb01UmzCXd8Ljkzi8OzO7kuedk+EqblM8kGxSub+fhvq3NUxUtqUIkx6Ve3QNwhFwai/CpHoB+owc1yOAI8uH56s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C26pl6G/; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C26pl6G/"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so107497866b.1
        for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 12:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789328687; cv=none;
        d=google.com; s=arc-20260327;
        b=KYAyGAqLYz6Fa1Ez1G9mo1HcDFU5foQxgYC1OxbNGgyaLABFnsTFFLIz/vW7afAtKG
         e7o4bc2VniD3gthoHKD7R0z7K7c13jsjV8AfGNnWILQx+YQxucQY2ZshFhSAk4cVaO8Z
         U+en4sTqRIqpIt+i4Ee204841nf+7gmiEbHJiehLb1/SL7pBr3uyt5ag60lzI3j6/RKq
         9DRT46IYsOU24WoNRvzjbczEnNVDjw7ghdeGt1nIuyXblgc2WzgnOUgPZKE0lFCTE6K7
         tfPgfCZL+Ogj696N4DEiYosEq1Bym8+2quAj/3efXTSb9DMAzpQsf86W7gJDQ/HjmIHs
         NoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8b6r+U/DEG7an93RNL6FjyRqUyeE/SvG1QM7ET5l5mc=;
        fh=p8wYhvAileODgZQKGMNlPCynCe4djbRl3Ylf3Uz3eU4=;
        b=BNKXaqkNX+uiHCcfD2P8vReAJPCspOQV9zPu+5b5Wx4wCJ0MZ/rQ0wRTpGrgyEpLBg
         0LZ7Efjw03uJcjp0iVgdFgEFVL3RUBf6ZYZrGh4Qg+Cv4yOseS3CtNI/Dm4K7jCVgTeK
         mc6MlB7RDT3ucnUdrymnvH4gRvhUBSaXCNUFq2HY4o5u3ND9Mu2R2EnoR5uVOtSc1DDv
         J//PD+1nT8iY5uJ5gzB6RZZH29w83RtOfuyjUjqHy3wZCM2mL+SjHisqqpIp3ieVG8Oe
         QJR+zzbL4gTpsBMGGN901ogG8xN5xaRtv4Ydnq6zxxTe8OvxvqWzwPHSYc9aU3ZwXbhl
         hVVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789328687; x=1789933487; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8b6r+U/DEG7an93RNL6FjyRqUyeE/SvG1QM7ET5l5mc=;
        b=C26pl6G/OKG1Y28Lo2yi1YvgFork6i2RT3sKf57r1sAJbsnxPT/yvFw2oK88Vn5JNG
         32VekqiXFXueQgXdq8hWhuPsqxY6/bjTpQjhRQCMaanhfNQQqkRMpi7fWFGvW35KIsLq
         BuUjExI/LW8AjzBWIt9JGJ69NasX8Z69BGQPRtIwqxO1yx76XtqlQN8PU75s7eN4mvrx
         QlXuXwcUQLa55d2q4kFQm42NyFR9oSIiUX/e+ZBJIuGKsW+v5SDge3yKf25abB27V4j0
         GhHnSNVtpuj0R5lGnCwhu/b+9fDq9DJL0vdyU+GytdTVPkaN34RVxuveIoUvLi5Lj6NO
         iPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789328687; x=1789933487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8b6r+U/DEG7an93RNL6FjyRqUyeE/SvG1QM7ET5l5mc=;
        b=Ig48ZAR68qWSPvz5aU04TQ3nZLdt/DDKqLksDFe0+NUvBIQGItFYxw2AqRrhBXZIuA
         HV7wFBIdewuNbBkVrcfqmkNW3AErNUVrhroGaAhm434BgzsSn6bqBI+F2F2LeZ9+qzHd
         Q1RB1x+IaKBz12HVRaZaXRTucmqYov6c/MAlyIcoECgCxZ2qFQgZ4rroHKA84fJrbw9r
         +SKK5lLuCoYEmrNWywiS+RWhHP57dhnZXCY3oq0ygYDu92CfdJqaJJm4tHgAwNWOT3XU
         +1zb7zt0GSUAd1fyfPisp8aTF/Dj6MRe0xOGBkgmoSLMCsSprMomc+WU4qiKhkWu7nVh
         YXRw==
X-Forwarded-Encrypted: i=1; AKwUvBxYsBDK6GhwqVI1IYWa093XfokcBeTtXWaSTlxGYe6ZuHvHbfuKjbLfoWuOvp9/lNsNe8mH@lists.linux.dev
X-Gm-Message-State: AFuF++nE4jYugU2qf9BaRBxloqPRE+ajfhKUVaChn4WrkexC9MwqPRxA
	GmvmFm57tZyphwXSR/MoHjsaq9JZmuhxj6tPS9MB77rxnHTcHKXPDba4c6jruzZE3aBoqbVaFmQ
	HncUb5a16EWptiF1Cj+c/uYR86JtRSxQ=
X-Gm-Gg: AYBFou2S5uRISKRoolEdW7WiKOU0X/X/XMSQdUx27PJ9W7z16IYkb+4CcVAFqZ9od4z
	C/vdWv4EWb31sQBz2UelwM4zk/1EjZ6TMlu87r+NeVBJ5mryBvpInYTbAh4tgkmz9l2hkobFET4
	Ci7Gf/SrAl6rYl51qUsgxgXT9JsIoQhCcbS9nYHhvUYdh7EzdyZmWpAl3/wwhok2KTZqa2OiN1v
	N/dPl8lOGiaqRIapKICX18b7mZl4IWj06rtmHfsb+sQvyYtaa+A+2yvA6N8Y1U2EEF00WHImRpC
	sXljRFjrfxIH/x4ReWMScLX52RJelPxP1Hbgs4+PVFuOy9QInZyoG3oK/dFTfsl8h/EwgXCdF+A
	dyDB16RysEk1o/z13gRYB8vngTsdYsDaH1AvG668gCMui1ZTErowTVAn0Air3tGIDHNuPCmF6wZ
	4uisRcoZZhHiuCMt1l9KP9KPNdVBhLbqyCrNrUaKJiepUO77pjPIVy7mhgZM17Yx+qkw==
X-Received: by 2002:a17:907:7243:b0:c24:d6f0:aa0 with SMTP id
 a640c23a62f3a-c29a42b6f36mr194728466b.11.1789328687262; Sun, 13 Sep 2026
 12:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260519015739.634423-1-rosenp@gmail.com> <147ee577-8a72-407c-b332-45dda9f153b3@suse.com>
 <aqZyNoWsZp9mvrN9@codewreck.org>
In-Reply-To: <aqZyNoWsZp9mvrN9@codewreck.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 13 Sep 2026 12:44:35 -0700
X-Gm-Features: AcwNN1WkGf_NNwT-XIS-7nDNPApAUFWz0kyN1ZEHHVq65U-G5fRQYlTnu-GfYQU
Message-ID: <CAKxU2N8XR5i36yrbNckkKgrzyGnqO-3tQV=KEVg6Z00bUnBHug@mail.gmail.com>
Subject: Re: [PATCH] 9p/xen: Use flexible array for data rings
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, v9fs@lists.linux.dev, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 2:52=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> J=C3=BCrgen Gro=C3=9F wrote on Wed, May 27, 2026 at 07:39:07AM +0200:
> > On 19.05.26 03:57, Rosen Penev wrote:
> > > Store the fixed set of Xen 9p data rings in the frontend private
> > > allocation instead of allocating a separate rings array.
> > >
> > > This keeps the data ring storage tied to the frontend lifetime and
> > > simplifies the allocation and cleanup paths.
> > >
> > > Assisted-by: Codex:GPT-5.5
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >   net/9p/trans_xen.c | 68 ++++++++++++++++++++-----------------------=
---
> > >   1 file changed, 30 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> > > index f9fb2db7a066..5a110d71d18c 100644
> > > --- a/net/9p/trans_xen.c
> > > +++ b/net/9p/trans_xen.c
> > > @@ -55,7 +55,7 @@ struct xen_9pfs_front_priv {
> > >     char *tag;
> > >     struct p9_client *client;
> > > -   struct xen_9pfs_dataring *rings;
> > > +   struct xen_9pfs_dataring rings[];
> >
> > Any reason not to use rings[XEN_9PFS_NUM_RINGS] instead of a flex array=
?
>
> Rosen, do you intend to resend with this fixed number?
Sent
>
> Given that's just a two line diff from your patch (just changing the
> type and keeping kzalloc_obj instead of kzalloc_flex) I can do it myself
> but I also don't have any direct merit from it, so if I don't hear back
> I'll forget about this
> (unless J=C3=BCrgen says he actually read the whole diff and it's worth
> taking for simplification, I don't have time...)
>
> Thanks,
> --
> Dominique Martinet | Asmadeus
