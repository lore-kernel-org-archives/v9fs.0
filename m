Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414C3EFFCE
	for <v9fs@lists.linux.dev>; Thu,  6 Aug 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004741; cv=pass; b=rgjJntZa80zq8fNgV8nRUUYE5psne+8DxKKoWnffySY4hAoXxU2PmFiPaSi8b9y676LnAax7r9Jxtp18dKaWx92mfeuxku6Kx4KhrFpp/3tqniHW19X1c97CMQ1za2RyiKJpB/3C73Zu0Oxmgk5xfIi4T733xTSoys6TxSsLmaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004741; c=relaxed/simple;
	bh=MBNhlcLTm8SmghvjCXS2u0qUIG9U+ekvvgxV0fjTbbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=km0j6xOlpkRI8/ri41Gqf9pNpdkCUORe6IMWK/LEcbjI1HTgFqvj9Nhf8LNUZxAitQ0gwi8/krkmUIf53eNDfrZaL/yzCRnsvAQ0jeUrzNoENMNoO1WyxFbfmY5x2yVFR4lWJhisG53WhZRDU5vJu0uII59JQ7Up28vhVpdq9Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghp+EYli; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghp+EYli"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81f52945098so14768517b3.0
        for <v9fs@lists.linux.dev>; Thu, 06 Aug 2026 01:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786004731; cv=none;
        d=google.com; s=arc-20260327;
        b=lhtlB5MtIj2PShyoHR3V6dDAZRLheJ7Z0whRZWJfnkaC1P3pZba2zwPhxP5E9Xoo+w
         Bzl/OXWjCQgpYcqIP7zhZ+GpaoNVUUchQ6UcxsMgyTekhlo1SU66m4lLpqOJCBe62FSq
         FRX2Yv+nXjxuDHjug3xD3foYhXnxeG2XTSILSPYLCEE83al9swJHcYIXf8wqmF9pCZ6Y
         lBG6+zioUmoF/jCLIYbsv/rEDlc/bznEZTHu2Ylw0o0KU2QzDIkNWbHISmTsqtJmR6U9
         FN69jrAYkKpDi4P445/TNldS/GmOZTz44ScnWnIN1s90R8AzVEVP6l4MkNhdVP3KozXO
         oceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/yaWIBn0NrtKIf26cXTq8fRTYQqnWZ234/y2lnxstbU=;
        fh=ly/E7NVm+ugTKGnnGHvCTQl+rMtW5J0X7cRLrEU2dX4=;
        b=Jv+epdzgMTijl5mIossxY7s4MBmB1ZIbG6bAjDdlz1m0RGOsS+J1QayC4xnHrGDJFu
         rPLSZ760FM+ToPZ2VnKL3X92HTB9BGejR0Adh2MEs4KDWWhVL0G2R8EAceD1SBCHMs+B
         zZ7yzaZ6y41tEAT3IJnIlHXYrd3TDGJIIiwmxwxRijbWimvN91d3de7dH9oK1QpctiEc
         kVpbCMi5Ch2548WCMk4HqbNr2NFYPpsGk7kzmuVq+bdxsQG5gLMUB1O9fI3R0rTwklcH
         1t5fOJQ0I74Ck5sECZYulGMOCM83IMn0p3LDDWCmEvm6xJ0WIOQIm7corwULLwy3ifUr
         4+eg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786004731; x=1786609531; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/yaWIBn0NrtKIf26cXTq8fRTYQqnWZ234/y2lnxstbU=;
        b=ghp+EYliYGki/94jMeOvibnKVZ4Qvk+A47uKG7Q1l+YljgEmBKvZDMpXhqjB0wIv5G
         xi7BX8T9B3YB1CE2TtQD2eXpcB/t5Gf/+2XVH7xkyhMBeld5Y2tR5pA2QvZabmCTNqpU
         61W9LnmEr/Biju8b1coxeIMvuFTEX5oZkWghYhgGpkEIE+58xeQDj5byt4DM6w1AaCZj
         DH8hbPKTInnJxKRdb7W9abZ/ivVPbzhyWtwUn94ZzR+AOJm6GoU/PPM146ALOQKGhWvH
         5A02KaL/NGsnkCYQ6ImPDlAgR1d2Q6JDRNe8/adriytcfqg3CDa2bb6WrpIMuhKV5IOf
         R0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004731; x=1786609531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yaWIBn0NrtKIf26cXTq8fRTYQqnWZ234/y2lnxstbU=;
        b=UVWk1vHglS61dKUfvz+gKbGGT1WhK0YB5efPTeB864V2Zr14ddPFFrDXNM9w8gkAYB
         VJTBm+H2ZKrcCaK03iH85OZ7Z/IW6EB3Ips7FxEU0L/cUjI5x8uHJSWXj3s0yFCtmC73
         q63joOFw1H2jXpw0D2RHAkepipWHJxcz2hgS9uV4KreAE2I6WPOVm5hsQbvt7IV3POVI
         FI5F06srs8KcmD8nUJScLikPQiNvR45tA+CpW5a11gL+BqbfaVAmBQYJsv2PLO5NLf9h
         eTt2F51B9lFfsXdul70ndEvA8QwwMbb5vTf9g5lZU+/sLErkMMkAVJnVMJXkG+PAFumI
         ta4g==
X-Gm-Message-State: AOJu0Yy4ofAuTsOGYlm1h4oLkTiaGEtaz7ZNjg7ZGPoD7thOac9IWE4W
	wJ1Fr9Twoc+11XPC30NGtKG/vKS+3KE7Da74dlACwEPu1mI9QP7mzmOIypulpg7WxMsdwU3u841
	fgJkUhlRGJ1uevE/s5U85Ljd2p0ScZLA=
X-Gm-Gg: AR+sD131dpIIzTJXlKApm0hcmBN2H/R2eHdPKJ7sjUT7MhDcprDBvwLRGkUuZ14ysLR
	QJqNU0pzud5fwbbiSFFffOPWKfokHCNSYPmZwbiMvJRx+TLm4wTIvAzweVUWEQxBK5UfqblH88Z
	tR3Of8T4cs6+dBBPhvVm3Bwu7xRTbilR8HSl0OopehRs3MjwqTkKgeSPtEXLj2ZvGQ5nyqkA2nq
	nnSyJpeTqWJ1u5b5p6/YAWrgDfIQY68hRtE3E+lsnndCxUMWMP7BiINqPpXDGtQOpRgAr3QTbeU
	77EtrpKJ15X93kY6VhHz+BAkT5W1fiehDmXYwgiJ/KjVqoZYbfIKgXz4qRMW9gCfpM6VliZM19W
	fwpTeqkZOF+In0RdlAaYJU61s4RxBs6IG4X0=
X-Received: by 2002:a05:690c:45c9:b0:81e:8498:b970 with SMTP id
 00721157ae682-8213277553cmr15130787b3.0.1786004731310; Thu, 06 Aug 2026
 01:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260725014448.18711-1-kartikey406@gmail.com>
In-Reply-To: <20260725014448.18711-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 6 Aug 2026 13:55:19 +0530
X-Gm-Features: AUfX_mxY39C7XC5BDSOszuwHAsKFk5NvLEKwyaDEw502-igLBn3cnuiXFwLntxw
Message-ID: <CADhLXY6OdJXA2-yxCbdSjcrJDDyvb=pmQKOvdGXEsg77Bm-JYA@mail.gmail.com>
Subject: Re: [PATCH] 9p: don't WARN_ONCE on racy symlink fid lookup failure
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org, 
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+344c09c64fcd8d3d2782@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 7:14=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> v9fs_init_request() WARN_ONCE()s when v9fs_fid_lookup() fails for a
> symlink read via the page cache. This is a benign TOCTOU race: a
> concurrent unlink()/rename() can remove the target between the walk
> finding the dentry and p9_client_walk() completing, so the lookup
> legitimately fails with -ENOENT (observed: dentry=3D/file0, err=3D-2).
>
> With panic_on_warn=3D1, this WARN escalates to a full kernel panic --
> an unprivileged local DoS reachable by racing mount() against a
> concurrent unlink/rename.
>
> Return the error directly instead of WARN_ONCE().
>
> Reported-by: syzbot+344c09c64fcd8d3d2782@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D344c09c64fcd8d3d2782
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/9p/vfs_addr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 1ac0b3dcc077..121679488ab9 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -140,13 +140,16 @@ static int v9fs_init_request(struct netfs_io_reques=
t *rreq, struct file *file)
>                         goto no_fid;
>                 p9_fid_get(fid);
>         } else if (S_ISLNK(rreq->inode->i_mode)) {
> +               /* racing unlink/rename can make this fail with -ENOENT;
> +                * that's expected, not a kernel bug, so don't WARN
> +                */
>                 dentry =3D d_find_any_alias(rreq->inode);
>                 if (!dentry)
>                         goto no_fid;
>                 fid =3D v9fs_fid_lookup(dentry);
>                 dput(dentry);
>                 if (IS_ERR(fid))
> -                       goto no_fid;
> +                       return PTR_ERR(fid);
>         } else {
>                 fid =3D v9fs_fid_find_inode(rreq->inode, writing, INVALID=
_UID, true);
>                 if (!fid)
> --
> 2.43.0
>

Gentle Reminder. Let me know anythng else needed from my side.

Thanks

Deepanshu
