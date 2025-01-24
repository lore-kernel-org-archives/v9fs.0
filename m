Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FAC1662E9
	for <v9fs@lists.linux.dev>; Fri, 24 Jan 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760354; cv=none; b=US6s+TYu/MDO1BV5FF64rxBr7reWf6RwtfDeD4FG0aYYv8nFqz9bLNwMt7xjJndwXXMns0f1nMGsjnMl7Q9cEd8O7dwjpgfnuCwSIGJfqEgT2uiPtctpAAWBPlEMyy/A0/xZtyEH0PXQtCPkNeEESc4SFwxq8OTTJFQGVRUHtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760354; c=relaxed/simple;
	bh=yK692yG9rCLRCr4JcnEbyFTPQVjOTIcIXHrJEk7hVjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwOVq8/B84XJ+DH9cH8sUep9UDsR1/zPKORAovn4bKI7Sr3mJPWrAmZTzb2GVjdRLrIyQbHyHFNfb4UD4vMKyaU12VDh6ddywO8oNp5jkXItqQs7fLI7bygFuYgKVTp86c76V9TG9Pt0q57hOw0OXDp4TcHfqkN7h5mB8abzVe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TIG/m6vw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIG/m6vw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2162699e0ccso5426575ad.0
        for <v9fs@lists.linux.dev>; Fri, 24 Jan 2025 15:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737760352; x=1738365152; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNzSzzyQUcplP/qykucuxAz6BFKZfcYKB7neGtxgfe0=;
        b=TIG/m6vwpZq8LAsoH99jDitEj4a9uQ4VHNPRiU9CMA6uAtRH506JNoTrm8WF9o/ti6
         KWXpKZUmJ7jF5kIHuMYMGeyMrIQ2rBFbayevk6gwFSwYs0SEaMegJ8pU6p6/ZeORjGhY
         Bs8yrC0zcRuhmnmZa7CAYRPX5FySHuxVGCiM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737760352; x=1738365152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNzSzzyQUcplP/qykucuxAz6BFKZfcYKB7neGtxgfe0=;
        b=uzzgPbk0nxnwKPc0Sdx4DhSi9I+l7TMtMxOvXNwmG9M5mEbWkHT+DAORWkQqZeeYF1
         tw6LrmS5gFQlXFfOeWsymtd0x9ECthOavXb25mpDL8r3KpRI6StznMfTsZW03stsqMjD
         VQJDCRoMfEPhFYlto5sJetEgPCRzy+96NZ0hQF6sZDO5EkZOOj28GfRy0XlRmZnTJLQ4
         GXMD/TTz0Lru9q18muJqQ8LoS9zwYPMf4sYP3M6XI/yP0zhNCk894JDZ/4wv067vgquZ
         HTtQTs0QE0MfbZUFRCSqW5NRgcfQL8Mmauhb2lYT1yRpGDAAuTNNA56MQPePI5E8UzCH
         bFjg==
X-Forwarded-Encrypted: i=1; AJvYcCViCO2PfeHLHzHX172qqSv0KOTGuDTVUjJhAJmDqEnwmJQUk24n7N6WT93ECaCERJEbchh+@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1Lc7ANP6NA1o8zxVNNLjjSUXzq5S9rYkgUnQFyOHjLBOvm+rJ
	lO6skfqIV/h7MKcVtkyJMDLbcoxq5XtTnshzTZylK74YT0YuHC7xacuiL4AfSLwXUE3fXr2eGSM
	=
X-Gm-Gg: ASbGnctP6XJVdES/3bX3qXrK25QRhRdYmVArCLp/6B2VpEXT8aOwr/EFsucTuvN/g5V
	/dL9nkk68l9HKqKBCjZejqCEbiZEwNJmZIj43C4lOB24GVmFuzRJc0GPP/30A+UUZ/xUBfqGiQQ
	Odmq2MhVAw/CgUmMO++rJkTuvn+8lH2c43b/e/Y1VpCJbuRf4fNDqBe3RWjy3s1Da4+C1W36rzB
	qfM6/sEBPpHcEJMJDSKdl1h1rEXj2ySFAVRKQHAlMDu8TOWhj5Ytzk6RZ7e0GKfoacQGdO0mc9E
	i7h/sMtOpA2o1E7NUk8vN45ITCZwvyy1BR/w4l3oM20xpteM
X-Google-Smtp-Source: AGHT+IHFA16N7NDkQsv728pe1ujmhSzRbgJE7zN+4pU0L0p8jPR2cYqzcN5b3DiHYTlt+9W11RZVlA==
X-Received: by 2002:a17:903:234d:b0:215:94e0:7 with SMTP id d9443c01a7336-21c355bf8d1mr174456325ad.7.1737760352336;
        Fri, 24 Jan 2025 15:12:32 -0800 (PST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141dacsm21624425ad.133.2025.01.24.15.12.30
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 15:12:31 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216728b1836so44017665ad.0
        for <v9fs@lists.linux.dev>; Fri, 24 Jan 2025 15:12:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqhJ5qWDeaxqDGhjKusdMK1aJGJtcLsVVcbYZYxLbL4j6IV+kqRdjrxKINlyVUC1sbHWn0@lists.linux.dev
X-Received: by 2002:a05:6a00:4c90:b0:728:ac38:4bee with SMTP id
 d2e1a72fcca58-72daf9ac957mr44718115b3a.2.1737760349927; Fri, 24 Jan 2025
 15:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250124211432.5698-3-joshuamurphy@posteo.net>
In-Reply-To: <20250124211432.5698-3-joshuamurphy@posteo.net>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Fri, 24 Jan 2025 15:12:03 -0800
X-Gmail-Original-Message-ID: <CABVzXAnHmyXtsNPHrYDCubifhrGdDyy_W7=mX_FQ58Pwt1swFA@mail.gmail.com>
X-Gm-Features: AWEUYZlytU608FhlQn6PeusWybP1ITlaCT19jAm_5UK4zMEzOoPALCVEEdahzQ4
Message-ID: <CABVzXAnHmyXtsNPHrYDCubifhrGdDyy_W7=mX_FQ58Pwt1swFA@mail.gmail.com>
Subject: Re: [PATCH] net/9p/fd: change port to char *
To: Joshua Murphy <joshuamurphy@posteo.net>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org, 
	linux_oss@crudebyte.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 1:16=E2=80=AFPM Joshua Murphy <joshuamurphy@posteo.=
net> wrote:
>
> The port variable in the option structs is changed to char * to
> remove the conversions from u16 to char *.
>
> Signed-off-by: Joshua Murphy <joshuamurphy@posteo.net>
> ---
[...]
> @@ -746,8 +746,8 @@ static int p9_fd_cancelled(struct p9_client *client, =
struct p9_req_t *req)
>  static int p9_fd_show_options(struct seq_file *m, struct p9_client *clnt=
)
>  {
>         if (clnt->trans_mod =3D=3D &p9_tcp_trans) {
> -               if (clnt->trans_opts.tcp.port !=3D P9_PORT)
> -                       seq_printf(m, ",port=3D%u", clnt->trans_opts.tcp.=
port);
> +               if (!strcmp(clnt->trans_opts.tcp.port, P9_PORT))
> +                       seq_printf(m, ",port=3D%s", clnt->trans_opts.tcp.=
port);

The sense of this check looks reversed; since strcmp() returns 0 when
the strings are equal, this will only print the port number when it
matches the default.

I also wonder if any userspace code relies on the canonicalization of
the port number into decimal; I think specifying (for example)
"port=3D0x1234" works and would previously show "port=3D4660" in
/proc/mounts, but now would show the original string in hexadecimal.
This is certainly a corner case, though.

Thanks,
-- Daniel
