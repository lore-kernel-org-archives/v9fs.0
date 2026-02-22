Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A41CDFD5
	for <v9fs@lists.linux.dev>; Sun, 22 Feb 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771744796; cv=pass; b=Q5oCtFF/5sXXvHjIOUB3/auGYRRD7/lvHtLqehkBSA/XbheW0E+cY1PDGm/cWkjbcsk3wR47LzhUVGVGWBr0r5vZrk3JPBD9ODgbAWNMAOXg3lPN9rCqHqxc2PjCWUTonIIai27MLiYHOw+SXFRrrLp4Culow4aSDKJBIgSHbvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771744796; c=relaxed/simple;
	bh=0lDfK3AuaNxxPB1Mx5JPD44YULX91cix/sE9XtEee8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdobE2f49SmPRRSGPjrUB2uGZU9+5EIYVxLPKfWcrPZtcBO93acWtv9mUcbr4owAudTUvK4e0utsD8lppXfDmsoMOYJk8xkQTgeVBxFnlFCruAj1e2aKIZkaXKX88sUUuJvANJjBuxguomLZbuwgoTGpWBdOFJ0/lKFdRqdHpSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHzA8O3g; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHzA8O3g"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5663601fe8bso3199467e0c.1
        for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 23:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771744794; cv=none;
        d=google.com; s=arc-20240605;
        b=du2DFTJhiJWE4Ohupa1c9g59OCw2oCu1vTieSiw/jq1dMb3yRFMdwSDfqtZm8JqLEP
         vP6e207J0wEnko7aQ8UrCSv5C0hGG1aXelZqyLXJte7IfmDR+DZS2h592dpqj9YOJOCb
         dGPicKXmdFZiImBhlKC9QZ2lcGXJkY+fb4M8ZKqKhBBto3JZTcJNZlp05767IgytvK90
         rk6XViCZRFxYOiqTutm7NLbkHnPFsCSfHy7FuoPe8yozJx4ZqvlqLuaRKvfp9N+WAeik
         aQ9dupuJBLj7GZo9qp5UgWxaWiu9QQ1s0ApLpoOFOztnNT20ojU4MwIRfE0xrqYMiTAQ
         VWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        fh=uN7fLyZENHLJK+bZIH75hvL1JJRTice9hhxGXRkQivU=;
        b=Kcf/iCKWcLU+9RY89FadoQ/wq9hGBTFTKz+8kg7rgorTuNtXAUJwHzafHo+cXfUksV
         wJTB18oN3O4RCiCVUEWirji4O/rNctnaQpZllMVzFOHqf7trdyGYMDXodqXz5nLf7+bS
         pTKPgssJuI3hbT2pwp15vlEnyRiqG6f8sMMmSXZESGFquBkxzC+Ryj5+KwvfRLe8MgjB
         gKBFLzN8IYuUh9Hcp6jr3ha5IBN6TieaHZJfdlFodv9l/pFPMnxgqN3ttR5pu5ag+2Ls
         I5PZN0DQuB9jYQ3OK7Fo87bMoRRbFjc3/rhXYF6GeZQXA9h3uKJdl5zZkqjH0/4RjP8/
         dUZw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771744794; x=1772349594; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=FHzA8O3gZJlP9U+n2bQJUGLvNB6IykHDU/iy+BCfhFTy1h6KjueJW4SVa2X+D1GIU+
         OsxQnBACF3rue/pPBckCch/qE3CygqFNxr0QsJN/BmIVuTmwPy17e4Q9Dprtvxu9Wotz
         pSNa6iZOi2fEU4ExQJ2AJoe5gMIpp+He0MRLtie5mNMMDKmbV4M3XdDZg5N8tarEWoab
         geAGHpGnXqGPizOTfn1lx4ke7v1rAPqvsIdbGLTtSulQ1BpGoAvF5gHuUvwbCoFB4ivN
         O6or80Jh0hd+R5EFHzAaolP7yfIUUD161eUkZxKo6V+Mufg6CYEYm2YOxgR2w0EOEnqf
         3GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771744794; x=1772349594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=LWoRXW4fjA0cMpKn4MNG/9rw/rXNXlrk8+bq/nOUguQTvpMkk2P0U6HE0G4tTECB3V
         gJzXAb+GgofyksJZwgnuiOX7CP1F3Eq0sqR8wccEpvC6VvTkuYHm+86TffwkaL4yD1uE
         5S12E1unrRDWJzdGfRvkm3iQL7xNCOkr+WycTm4l0rAz98o/485va41FReOuLIs8XT48
         dngPUeAFG6AL12+CpQjNRNd0TygOgX+vgr0JpawjlDXRjo3MvDaphKMXGIFXEO2iNGkf
         h58iT4usr13MkZ/asPa1JGij5shlUdhYWsmd8771TBiZHl42GaWVprdr5NPKCZUPKT+R
         EeQg==
X-Forwarded-Encrypted: i=1; AJvYcCWkNhMPZZ4jat5H5gTHh+r+IUthlo8yELtXN050+XBuMlSE0Yp9S6xJemHcBJg4fTWyeWA7@lists.linux.dev
X-Gm-Message-State: AOJu0YzrlwFsEJyxN7cgFMPPaKNCqs1eVLHckU/h4i2CyQYK/sUPdAEF
	nW03wl/Vr0TN6ChyxVE+KPTPk0Ekxlyad4SUmNN6DqU0M7c6UdDwKqBny+86CEMJZDLiG0otdEh
	P5P6IJNjPXRlZNjIGMnPgHcBwQEMimJQ=
X-Gm-Gg: AZuq6aLBeVk77tKOV0G+cY3pzVoMEqrNgcrtK+Con1fpvAZB/CcFUqScat+K0ZsoDHv
	6RUFwvHivKXRUwv5ZNDLdSBRUT/u7VLZVfziqbzD539/n+ky4VkLrIqJyX2YI+giDKlh3h9llZG
	xOQ0HurAQWYx+wc9NVnZ2gJU3kZLn0sjPyD9EAuGUyZSDiRKGs+5vRtilGgbiLba2v3PUUDv88a
	/N3Z/ky7KwiW01LVwg1edXLL+o13+og0k2EWgFv+zxNASen7xmUyDDDkNkvU/gEY2HLRCfsealj
	kaR+CiD2k2rvzTDt4sBegemAAZM7N1C3yuBSqXnVGWs7wAFAEvq9Pw==
X-Received: by 2002:a05:6123:2c6:b0:55a:ab0d:bf74 with SMTP id
 71dfb90a1353d-568e489e04bmr2702083e0c.13.1771744793575; Sat, 21 Feb 2026
 23:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
 <20260221234553.2024832-1-safinaskar@gmail.com>
In-Reply-To: <20260221234553.2024832-1-safinaskar@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 22 Feb 2026 13:19:42 +0600
X-Gm-Features: AaiRm51yAd7WZH0JTtET-y37usKeLDtT6X5Vgs22uOg_jqenzkdmMaQOnOQPf2k
Message-ID: <CAFfO_h4dNydbmKSTP8uD9X6ouEZTyJUGoTBXrEHWeHtD1B=p5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
To: Askar Safin <safinaskar@gmail.com>
Cc: ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 5:46=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> > I am not sure if my patch series made it properly to the mailing
> > lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
> > series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
> > The patch series does have a big cc list (what I got from
> > get_maintainers.pl excluding commit-signers) and I used git send-email
> > to send to everyone. It's also showing properly in my gmail inbox. Is
> > it just the website that's not showing it properly? Should I prune the
> > cc list and resend? is there any limitations to sending patches to
> > mailing lists with many cc-s via gmail?
>
> I see all 5 emails on
> https://lore.kernel.org/linux-fsdevel/CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-=
sb5Mpk3ts1oVUHtg@mail.gmail.com/T/#t .
>

Yes, indeed. They showed up after a while.

> So this was some temporary problem on lore.kernel.org .
>
> Sometimes gmail indeed rejects mails if you try to send too many emails
> to too many people. So I suggest adding "--batch-size=3D1 --relogin-delay=
=3D20"
> to your send-email invocation. I hope this will make probability of
> rejection by gmail less. I usually add these flags.
>

Understood. I did not know about these flags.

> If you still expirence some problems with gmail, then you may apply
> for linux.dev email (go to linux.dev). They are free for Linux contributo=
rs.
>

Alright.

Thank you!

Regards,
Dorjoy
