Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA83148CF
	for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238387; cv=none; b=S16sgiO8AYn0xuCBXZdi2ohYKiMdnLS0c03O5664SXHKorhkawYhqdUg5TcEAekZ0UOWeyMYby98UFPEen724L7sXoBlRbaSico+XOwcodQ6ZsPIu9Zou82tk58zAHP20drpKIcaXvSNhZdfwJ5RyPr4R7cTxQ2/2w5oQXISfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238387; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfBcvv+rCmmyXLAVSxV3iVPv6dj+dgtDeB5jSY6uCRHuYR4x31e354qD/xLqvpWMxVyYXSv3fA57w/UeQWZeyVfLOkUX//IsDGaGmNeOoKrBVNIWcT7uniOkSQdAYBpxxcOeYNAl/KtaC36IhhE59i1JChTIpRlSZlbDlM8iBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-660be63279bso1544433a12.1
        for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 07:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238384; x=1773843184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=Xo7meIoRC1clhPjr8DiMt+GubduQXedZpKMSmWIOB2sbeJImHCL7qPGSRVdnFADDOD
         Wylw5/xqi8raeCuF9PjZ8lV6bVSALV1J+tok1TYz/sEMx9SvElqG/JcqBJgRccxwZaar
         U3/RMHcfq4R2bd/SeWPhCL1gJ6xVk9xa+0nL+cHbtt6z7bDAh99GRMPWxJal+9L9tLB2
         mmZh5Ol6U7BzbLHpHeDcFqA8S7da0TO/GiE6YeZswC+3EwpdnALnT8pSivK2Nk/+RkEQ
         w+9tx7xqpnu5CX/RrUIDDXvQCkDQQB/rZ77T3W6Wg9JvZuz/QbmiL9t3JtbVCW4XyuxO
         JSEA==
X-Forwarded-Encrypted: i=1; AJvYcCX6t24ng2NdOlswi92x9qEMcQ/Yd+Ce8CsZRtnYaq3jI8OkQOnFP+dtf4jGvsfTVvOa4WY5@lists.linux.dev
X-Gm-Message-State: AOJu0YziMqLswAgSY65RgQRoGAa+Splj7yzpCjQjRwZqou4DrV6C1fLw
	58hVAJhY5+c135dDsQu6bDKc5xVYMwtj8AJwlC4bid4YA88TW0TCXvIb+hNY0XhukEuckA==
X-Gm-Gg: ATEYQzzCC25mTPb9ixt2xnUeLWnborT2vJfGamlmKhX28xQI2931qU/AbrPyDKwG9PT
	amyXGLWNyDXntR+aJtaOAlKuhmWnSxmkravikrtRssSpzfc/0arSzpmmBADj08noc+/jD9hLsgP
	p0hl00McaK/ndWbkbLWqu3zvAfZsRkmwxduXrOn8cQTmXM/ovNMV++N+Qx9clIKGZH3TSfC7IuN
	T2MgPG8k5RgQxuHqbiFSULbUVyNB/9rrBd+whI9awpIUs2HcQS3AGmrWKkUp3PZGsyHWFK6Y39Y
	hpw521ljaznP26NMlAS90AcerJCM6aeuEtm5VvtYUsXR60lPv20iRjisOr8VaBT8UvCLqT3CQ8H
	jg0x0vcq15f1RaDDsXFBz39dpXTzYSUPNlvSN0OzSclTjiMw3sjB7oop4VgElE+0FwoAF9hoK38
	oY8Jl/3rNjERxVKT+fh1Arva55oVpA5YpABdYaGpN50ArnD64kP1wB7+aDIzf8
X-Received: by 2002:a17:907:c0f:b0:b8f:c684:db3f with SMTP id a640c23a62f3a-b97118b0cfamr465065266b.12.1773238383776;
        Wed, 11 Mar 2026 07:13:03 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66315320df2sm554410a12.24.2026.03.11.07.13.03
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:13:03 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b93698bb57aso170376766b.0
        for <v9fs@lists.linux.dev>; Wed, 11 Mar 2026 07:13:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiPC2FZoCNRXQE6T1vVtBanWt6i+7+/MSF8R8NXk5hbuivrxBaBWFhV6JDWqkyM8Kk/Nmj@lists.linux.dev
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
