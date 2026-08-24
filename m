Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304E411689
	for <v9fs@lists.linux.dev>; Mon, 24 Aug 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586000; cv=pass; b=qC0TdLnMAkB3AudVurcUdU6H6lyKi4FQalMAXmr0OLIZgPuKxn1SPl3gL30ezz0aog587l95azoK9PgpXFTv+UEmpbrvS5A/WzeuvgyNL2E9ElwnG9X1fVZUAHS6mUlGtvM0loA614uEnzR+gl0NMVVXNVwLPZYEb1wA9vJbnB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586000; c=relaxed/simple;
	bh=TKa+7Rt0HMct/L3Y9OQKcWqR+kqwOl5wJxjs0oMkUU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWxr0g7aPnJa7eStHAvJVJmXoX1jwIdWYC8zVH+O/xjPLVTybRaeymtiL8RpwbKGmUv2+taB8xeeW2qvqvwBymnDGy+wPh1bUPmbax9Qb+H78/rxbFkiKLeFV5S9n6NgBkLNSrITlGtTLKw4irMzpI5zSxd7ekaJwU+v7RXtPow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF9exY83; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF9exY83"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so6461071a12.1
        for <v9fs@lists.linux.dev>; Mon, 24 Aug 2026 08:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787585997; cv=none;
        d=google.com; s=arc-20260327;
        b=QtvGtwtCPv0Izu4A47tnPvvA+XyN3oEHd6BJ69/EzILKg90Y22vyoJwpO8FzJq1tvF
         X8Ui8frHR5PakQras+yigZAaKYgEcQ7lps4n5VY2knZJy8CDMT3IuB6voPxWmG55Mw64
         M5Cejfgrwr3ioA4cIlLLSdvQI+he0VmW4NWGA3OAFlYYbdAZ7iXujAQ92Onp2IY9HE5q
         qmJxJH0gBFsBZKBnyGWJZ7U1mTQ2m5dpXUEsLMFn/jHqciVihSl8vn4j4rhvbzp1iaQ3
         UlvxQg6s0BtNzroKJ2sAKao0QTn7U0/u1BoEY9yO5UjmQvHeCVfMax5rJrjifHS6VqKd
         gKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        fh=irGyoGrD5HrMJUCr2o0/0YRbUGwlPnia4rPSkZT6f4w=;
        b=B/DxcSywImDESfgi4xchVYK2BL+Mc1iQGQBgocDuuUuZLpcn0gdHfRLhL+TcuLB456
         LFGFpab8VEJZA9PX3oOjPqzYgRirAxPzfkUvrb/MCAJSO4d5co6M1xly1O/2SddDhdfX
         ptJaPAjk2eMUWfWdRkI3i03t0uME/yDbYvWrzylQz1BjbdZ3zaffK4DkIhhg9vmpFsLD
         QC8cY7O0Xl3xMTKQ8nZdOqbwUcWVBoP7ZNsk5XWHv93it8FX+ZDi7HwNpFwov+jJD3J7
         c4WQpSBj0GznMZKBOOcisnUs8prh45FKuthrwmMQPSvxMQhwyP+2qXGbh39dfhzMYPkR
         5fnA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585997; x=1788190797; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        b=EF9exY83GnmnKwCFq+MyF0bTN9FWR8NixMvJc/KGu3u+fgbfvYnYhxKiDOW5vXx20v
         6bfH0iWj3zwv0eWN3hEES4Bhs2NyBF6zdd5vpBuqFwAk9wtLpb1XN0tkA7GBFBcaBNv4
         iWbt1+UU6nHQQuMuLNozvqW1Vb3WW4d5sKUBD+zDfeSGNkh4cZvgYG3ERDSWmu67PdFq
         rn1byrrLSgVTjodqyxAVjhd3WcIEqrrjeTrVJeCB0E05fkBohsNnuTRaVyCUls4NOWwy
         dMR8zmeF95RuVW/pgGplSjnZ5DfzUALk7qIk0+GO7z7UeIADWKnkF9At/zoVcjBjbVTv
         +f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585997; x=1788190797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        b=pNj4PssRtP5LTaLo9uz2LzyRrgZ5MhyrlDCmmogsDVrDIcD6dgEEYJRKjndJDQHBMO
         hVn0askor5sYPKNCQZpUGLEQrnLMn8qx/jnqSiV5/4eS615gY3tV+1vvbj1rssp/lw+s
         CbPguhMas5IUoqrlyHy5u1zs8eH6uMobXxe1n27QnchzTuwG6DkVJZ0I+xo8se71N1hS
         6b0vZYWdZcw2L6AfSkDZs6GvZrCEbIBR3m7C80MF6mMBKSQw5iZuMUOcKGdwTmoqSzJ7
         3g5iYmXI0rzQ2ttBYCvZwTbGGBChcQmuFUiy5/v1OkqCtDfqoOhYt75oYr46tsa89BNm
         VTIg==
X-Forwarded-Encrypted: i=1; AHgh+RrB2gTR3+nsUCk3YiWqc1pdPrmWk5B5GUBMNSza6HjfRKA4ongMRkvrquJArLVlE9+0XFkM@lists.linux.dev
X-Gm-Message-State: AFuF++m6gWy8ZxdLBrt1uYErbDjmGMKThd9VbmUtzshZNF3HVi1jGE75
	/1hv/ONuYGzf+KlyncIT5DJy7TpRd+iKa/JtsXzubZR3RuuFrYbyx3Mi50V8Xv02ZFMzMLc0SIQ
	gM/bE6gZ4P/9JSVAi9bSRhhu/6SizUuUu1vez
X-Gm-Gg: AR+sD10cLpdwcOLihtgKBmWBM687d0/r/g71yvjTTCmDSaxfnZE+kjllR1FUDixDIPM
	rIjy8ysXrfUzzi0a2J6dbPARqQLr2VjVaRXcJPDncaOjcpI+4Zhy+G72zHQZkJ90I91tSDBqrOV
	e1zW7BgHnKA18rOOe4YhOYblN2O+10TIxON+Ipu1IEKw3eb/mPPCpWRoVQHCy7itkigzPxlAq2D
	o/7f83R9xRezY2CPyx+u1guDGo+oXXTPfXpavLEnwiRmag0j3SQScKJvNaWndpqi015/p6W+SL1
	NdndZMzpGnA/zWe7plrmC1nyU7odpAtbeu6m2k2O+C/xcCl/IzDYVT6NDsvVe1hsJP4Bq0V6E2I
	a
X-Received: by 2002:a05:6402:1ecb:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a42eec0421mr29612154a12.0.1787585996720; Mon, 24 Aug 2026
 08:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260824144130.759997-1-dhowells@redhat.com> <20260824144130.759997-31-dhowells@redhat.com>
In-Reply-To: <20260824144130.759997-31-dhowells@redhat.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Mon, 24 Aug 2026 17:39:20 +0200
X-Gm-Features: AcwNN1UVhOm3jvQyZ6QNY0YG-DuDugP0zSGCGTU-9BV_0e1-yGju4sTdJrlUq5g
Message-ID: <CA+1jF5qPZUhCevwbu7zQDEVWss6gMdoDMhqKqH3k7v=WStRtEA@mail.gmail.com>
Subject: READ_PLUS in NetFS? Re: [PATCH v10 30/35] netfs: Simplify read abandonment
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Christian Brauner <christian@brauner.io>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Leon Romanovsky <leon@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Stefan Metzmacher <metze@samba.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ceph-devel@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:04=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Currently, if one or more of the subrequests in a read request fails, the
> read collection algorithm will attempt to salvage folios that are fully
> downloaded but that span multiple subreqs, provided all of the contributo=
ry
> subreqs succeeded, but this makes the algorithm quite complicated as a
> subreq can contribute to multiple folios and a folio can be contributed t=
o
> by multiple subreqs.
>
> Simplify this by just abandoning the rest of a read request once a
> permanently failed subreq is hit.  This is what read_folio, DIO/unbuffere=
d
> read, gap filling, RMW and write preload all need to do; readahead is the
> odd one out as it doesn't have any return other than unlocking folios.
>
> With this change, even for readahead, the rest of the read is simply
> abandoned; read() and suchlike will call ->read_folio() on each
> non-uptodate folio to retry and retrieve the error.
>
> Note that retryable failures still get retried by netfslib as part of the
> request as before.

What about READ_PLUS, i.e. sparse file reads? If you do this kind of
work of handling partial abandonment, can such a work also benefit
READ_PLUS?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast
