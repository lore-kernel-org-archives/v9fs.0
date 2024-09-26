Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8F15B97B
	for <v9fs@lists.linux.dev>; Thu, 26 Sep 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352623; cv=none; b=WYIhfNKcN94wxKxosW7DZf9TxaE6DfDgohDEPVMkfF2ozpS0kxilNU9E1kP/BB/f0wadxRbTtrYOep522OZAy6m7nKtuUvTQFNRZxJtXlPx4lzo1s7dfXReVovQAhCi14YOk3I+7hfIdKLRcD7YMqPAJ+zNNrnSH5kOmBYsp0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352623; c=relaxed/simple;
	bh=KWWSCa4bm5iRBUvMYRVkyewVmHwFy1Gvzhu1WXJbih0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwsebJCwXTCba2VbQUXT3/JsXMYSzYGrtVetV/qaHe0lTdk6wY08EorLfDvc/GLUpfVe6pJgc1/KVY7xp6+IHOcpY6ETE3XKvevC4l/ZQud3B+SAU2U4/d7HZdbJm1ygoIHR2GzjFXdbxXCT765Fbgyvn3r819JOL/pBC4xuBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEP/fTs4; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEP/fTs4"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99e8ad977so67983685a.3
        for <v9fs@lists.linux.dev>; Thu, 26 Sep 2024 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727352621; x=1727957421; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf7Om00r0mCig/ZMqczV49KZAqpWgZLX+5yEYgrLlko=;
        b=VEP/fTs4RjC7ojtavNlsPNnfMYj/XP+Ue1f07AvovL4f+oMwgcnIzG0PUjIQGErvSo
         zkrRLi9MBNKK3GnCTMTuPc2pexwdhBE9pdnNKkBFzKdDlMscEyHMH20oNBklzDZODihq
         dYZPL+WNI7YydVCaeuV1Q5RGyNTuzWCOn5uGznUPPj7U7d4bOj9Duqm84N9zXXt25DeJ
         k7lScJkJQH5cGXiOl266OtkHZZsmggbfLNwdom4Faxw4js5o9o+2NRe7nQj3fWKx7rFq
         /0E+MoWgcpXodBnKwzh7my2ZJ4wwO0c96b1mbfRVjqPtFIyad/4270yty2v2QSa0loaf
         zffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727352621; x=1727957421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf7Om00r0mCig/ZMqczV49KZAqpWgZLX+5yEYgrLlko=;
        b=p05j9YPOAlRV0vXiaP4a9bG8lQVj7opLFw3MyWPfnVtShVAJL/I7dsV6JLQVaP9Vgx
         H28hPE7auxJIN2AfBtdxsv791L6juSPVz+SC3xRJDnwJuPAQTPCOorTfiPVdx3LGkA1e
         Oj3gL8wxYMCE/Z40DJ93xccJUbLod3jEjx4mRTmj3SD7CBwZ9b4wUlpXde9AK1myicyt
         /7oAe4+PTpbtWCCc7OQrGNQHz+ftG4ylP8Tx6+4VOrSYzlzh6eUyYkTCmPU/luKUb4Xg
         S6xUyQOT17mVoSrrPNw1s2Qi/hUJV4lcOMTOuAJ3UJneC0oze6ERauRs5Id7OLUzsoJ2
         RnFg==
X-Forwarded-Encrypted: i=1; AJvYcCXlM7CaWaLaYj5i5tqY8HtX6IVLjjhtOnmh/Q1eOCIWN/QCUacn9E3b9rdli8r+wbIiWXCa@lists.linux.dev
X-Gm-Message-State: AOJu0YzLijFVGlXos2yhHUE4/omE/rcgLhEfByRVBQnNbutYz4FKP/M6
	4skqV6AYTLhBssdD73DH75+BFbgPWrmXyT08aBZ+FpDGHLdZPRAjX18nyIriBaSGZPj71k5/YKE
	PsvKo7v8uItcddwbjvuMr9L9unaE=
X-Google-Smtp-Source: AGHT+IHOu02hfo2NqYxaYTeobf8HzVHsr74VBRW/0nvcQAkFKMdhB1GQQIM2rCkqtQJNfGD3OzyenMhMbx2gd7/MLMU=
X-Received: by 2002:a05:620a:45a9:b0:7a3:5f3f:c084 with SMTP id
 af79cd13be357-7ace741340fmr736526185a.30.1727352620663; Thu, 26 Sep 2024
 05:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
 <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com> <JH0P153MB09996860C90193AB4D293D84D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <JH0P153MB09996860C90193AB4D293D84D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Sep 2024 14:10:08 +0200
Message-ID: <CAOQ4uxiAyCTF30xwcMbgY5f=5He2oTGCACV26GO=s0CHYfJVyg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 1:17=E2=80=AFPM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Hi Amir,
>
> Yes, and my guess is that the MDE software running on your machine had re=
acted
> fanotify_read() error as a threat and removed the .config file, that is w=
hy it could not be found by the open syscall??
> >>>>No, that can't  be because I have performed the exercises by uninstal=
ling MDE software running in WSL(5.15 and 6.3).
>
> Git clone succeeds, but the listener terminates as you see in your machin=
e in standard linux. It is the same manifestation.
>
> In MDE software, Fanotify marking was just being done only with CLOSE_WRI=
TE in mask, while the example code(fanotify listener) was having mask OPEN_=
PERM | CLOSE_WRITE.
>
> I shall include OPEN_PERM in the mask in MDE and then invoke git clone an=
d then see if it succeeds.
>
> Can you explain the significance of OPEN_PERM and its relation with CLOSE=
_WRITE ?

I cannot explain but anyway the impact of the reference that fanotify
takes in the dentry
is not exactly clear to us yet.

In my test OPEN_PERM | CLOSE_WRITE also got fanotify_read() error ENOENT
see my email.

Thanks,
Amir.
