Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60C137775
	for <v9fs@lists.linux.dev>; Fri, 19 Jul 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399312; cv=none; b=RrcgZ+9nSchl5LzQnJ5JSb/ijAES8AU3GQRvuAVJexVThld+np1FvUuhjewT8rNVP7x2F+MlS/f/rr3UgmVd/pF6l8ouUN1kEO6Kh6tduW8iu0Aj7HeoPC0DTzsejSH5Xq+VncSM3Xo5gx1F1w+iJN81qzP9+yocjecc14FMpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399312; c=relaxed/simple;
	bh=Vc67S1kdc7iKyDC7H3kMbghNofGLtY7/Kf7SW+N5/ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+ZuiKKR/asV0APzCuWpA2SHxkKbU0Mb24gIj/b69Os/zJ1PzunB+vR/h8EHYnyshi5KpcuDWfgUbWeyOOzjD9SCppv4b04zJRxNoW0ufCXaxTkqfx4GiF2dZl3Ee8tWCYZbaRBokSgzPZdxQ5tr0Xmm3A09aQAJVoXRUoYzpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ8nl9Ui; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ8nl9Ui"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea952ce70so1834030e87.3
        for <v9fs@lists.linux.dev>; Fri, 19 Jul 2024 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721399309; x=1722004109; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc67S1kdc7iKyDC7H3kMbghNofGLtY7/Kf7SW+N5/ec=;
        b=DQ8nl9UipH3t3+9ou0A4nVgZDoeMmy2VU2k3ZJ+M7KiIu93V3qh4PMbO6Gl8ajRrle
         vhianLSjC/UTJ9zyKjJHfUIvsJhyQUnALkle3pPVecoVHCgYLtHSrK6n0qdxUFppTcob
         t2DfH4soDg2w0zSi7DP7SVp371smeIz/NZi9ZWUuTsLHd1eUSiyGuc2pCZi3TWjV1sS+
         DShdhmrdV6YaKcQras86fMchQ0Ez7N7ilr6OO06FfXOqONFNNW3JeEpiDbC0UgFKLu3G
         RTsWs/kTSvCFjrLL50Ykr8zo7e89ShPLI9LObmFxH0tbYIF5nQLwnGKdhNyvBmyUdin9
         w+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721399309; x=1722004109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc67S1kdc7iKyDC7H3kMbghNofGLtY7/Kf7SW+N5/ec=;
        b=baDTeWUfOng3OoG/YrF7C7MmelwnsgxOdH+Hz1TSv5L9xDpLI5ZzJirrgAkvzLkm1O
         vNHSoxBSRjiTYwiuBQhzJjlKOFiFOHqzC8nt8X4BfRXtl2+tAMlkwk9MLhyc7dnum69D
         yUjmqlROcDCO4k1VoW/5iwvEOgsKLv7gGmVQLWf+rgBtfiyFYYvW0CdVOi2CPPc5XZL8
         K511nCTrWKH3V59wboBVmqwqjJsww/hGUbJMQ5HZoLToF04hHpXFi1DJdW5865w7Xge4
         iu1dpzh/WUWf2LaJvPfp8bBnaT1qtSFF0h7yifx6FrpfybqBoi61hvrdJVq5P0VKCn30
         7VGg==
X-Forwarded-Encrypted: i=1; AJvYcCWcx5+ozBY8chS39zCV/FbMLSmdIDKZgReDrFNjBy7tNLtX3YdRk/Ewa9oWmNwbgDOvszbUTMzE+csZbh53JBirTD/uTQ==
X-Gm-Message-State: AOJu0YyXF6JCHZ+NFptvCTDfLkMXLsHeqc0yRkeYra7ebgIQXugRPmVZ
	7tCbaw9Dao45TXUgCyKqZy2H0BYM7OdbtWEFIlc30b3vw79fswNvVgFEgBCN6+7gP8JvvswPgyM
	DMlx4817vu9Rg7gMGtRefQ/A+D/E=
X-Google-Smtp-Source: AGHT+IEl20bZ1rbKHuxKfD3ohnwBvqEtcb9/MlOAaSiLNDkt6m1MNwWETMaTtXODiBeTcyxvY+1aERXHVxLVB9Z1fJ0=
X-Received: by 2002:a05:6512:1292:b0:52c:c9b6:df0f with SMTP id
 2adb3069b0e04-52ef588067amr1235998e87.61.1721399308925; Fri, 19 Jul 2024
 07:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240718151838.611807-1-mjguzik@gmail.com> <20240719062550.0c132049@kernel.org>
In-Reply-To: <20240719062550.0c132049@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Jul 2024 16:28:15 +0200
Message-ID: <CAGudoHFZ+rCMEXM4rqd-Gwaq1n6yr21+KqByJ2-FgjV1zN+ncw@mail.gmail.com>
Subject: Re: [PATCH] vfs: handle __wait_on_freeing_inode() and evict() race
To: Jakub Kicinski <kuba@kernel.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 3:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 18 Jul 2024 17:18:37 +0200 Mateusz Guzik wrote:
> > Link: https://lore.kernel.org/v9fs/20240717102458.649b60be@kernel.org/
> > Reported-by: Dominique Martinet <asmadeus@codewreck.org>
>
> =F0=9F=A7=90=EF=B8=8F click on that link... Anyway, can confirm, problem =
goes away:
>

well the reporter address can be easily massaged if you want, I
grabbed the person who cc'ed me

> Tested-by: Jakub Kicinski <kuba@kernel.org>

thanks

--=20
Mateusz Guzik <mjguzik gmail.com>
