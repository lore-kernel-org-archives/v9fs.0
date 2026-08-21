Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453483264F2
	for <v9fs@lists.linux.dev>; Fri, 21 Aug 2026 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276977; cv=pass; b=cNbHiinSzJvhA/5xCGNK6LwaWaDMKGgT8EqhRCF34cNH9fo4Bik9wKVoYBRsCjqBL1+MyjEVmSC0wf0dw4Xla3oZbflea+KE5P+t+gMv0sjaRvehwr6EJYEC86RoOzVGBZ2LmWXG7wlSbZiwtA/52vGV8jg25qru346NTbo8GRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276977; c=relaxed/simple;
	bh=MBNhlcLTm8SmghvjCXS2u0qUIG9U+ekvvgxV0fjTbbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slrfvMcO5JpuYMF35eGpQnNH/FjFG+gIdFUpFumEWH3OUFVNE9BnG3tIDtECxms0Z9lG5mZegFK0GnxAIjSesytSTztd3GxU+EcAE5SHzBAsjpGBKad0Y+RqplBrEVyt6hxkTLpwf/3ChtsnimmGXxZlif/CCs1RHgsWjrHuRME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnCXMHsP; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnCXMHsP"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66c70d73210so585704d50.0
        for <v9fs@lists.linux.dev>; Thu, 20 Aug 2026 18:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787276975; cv=none;
        d=google.com; s=arc-20260327;
        b=r/us2w8bm6WIM1PbJpOfLFrNRRI8IlT6Q6R0sTQS1dGIPeqThF64fFviHiB6cRF7xh
         JRzB30wg7F1dMuv2/hDLaVz1ak2fIGlYU8VXpmDMbSq6JKRSIHnQUDroHpK2g/Vzh/Rx
         wI+iudpNadEL1+ZMGIujs+YQPIPZATGd+7o8+S7SEn04SvrFLTgjUFD08Lkas9uDjtSn
         PizDV7R+zzPcHfQgbF+0FhqaLBfjdc6OBCyBlRFKhVrkjJuyldpD74QENOUjm9/M/+zs
         3YLl45Idbk7AtwXDQ2hE3gOUxlJDy2xeJrmHix30DdIq/L3/WKndSz0W7CySoPLJ2dkE
         m77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/yaWIBn0NrtKIf26cXTq8fRTYQqnWZ234/y2lnxstbU=;
        fh=ly/E7NVm+ugTKGnnGHvCTQl+rMtW5J0X7cRLrEU2dX4=;
        b=oT9Zqok7QD0I+Y4nZy3ssyJXtSWWe6VqNnpnl2aWtgRdUL91GdouokaFEWihfo7Lwx
         1dK2V+MCm+b4JZ0xcmoRLBWFlp3bZoBVmnna4c7gkIE9TRaIchtmLd6JSTuhNwZ8pWxa
         9y6ri4Cl6JunCtBT3dGFysPD9SBE2YWzs0xyNUOYgoQsejivVqcqk5yhW+MiQgOZ/DgE
         fFBYKNv3YGQJMj5uL7CrHNhBpD+0B0rsmDjnh0LWPgBhTeM9Oap9bXMVzPivuxjQnv5k
         usnUtD/aohM4AQUJQxqnTfpBbBrRGxGVKnNLfF4bf+npTbFfHEQAtxDSpqmPGkmedFlF
         iwxQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276975; x=1787881775; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/yaWIBn0NrtKIf26cXTq8fRTYQqnWZ234/y2lnxstbU=;
        b=lnCXMHsPI0Y0+JOPoyEriK/W29b67nS/Nu/AH7yVssILiY2ki7l8ow6dhuc9VQhI+v
         3xGX8g2HwrqBB0GtMyG/i3Ol1QEEKY6FRoYn0pDg0s8lWynpzJPip86wa/8+dTq4fof1
         Y7C537qJbmoT+nIJdSOPUB8KNlaclB7d9TJkUKfTFFchw1W/XcqgOzCuOAaYPbpEFEpb
         IDC4YSRj2sei2G3mL08zGN0g+ubO22Vc8S/U4+4IS4x6ScFbw6JX1WqCxXJWAzSFBWhK
         B1sRwcrNcKPmxkQl7/QL7sya9LEx3Mbja1GieqofokjMZ8QeM/GDUlesK0ts0t0e03RJ
         wBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276975; x=1787881775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yaWIBn0NrtKIf26cXTq8fRTYQqnWZ234/y2lnxstbU=;
        b=jVVguiEY0/rySaKX6I2xrE4x9T3xW3uG/qvaXkbgDwOUezYfsHSvq84jWHf9YRdqMa
         +QFCMknSvyi8rSn3P+T5KjlsP7LCk15ouoPBsN5tOEVG5zMByoSfKyBlJZXk9XseleDk
         18TLwY0CcHV730U/oH+VaHBrg4S4xaotNvBstby5CfJBxxFqrh1E2fnBORaO80zDi3U1
         RSYszvcp8q8tSqvpjM5gYu+xrxXQhfO8eOXH8tDFTckmKh3ImPgExicB222FDJG2VhOr
         u88QVLBfClKn5UJ6GHXSzGkjj1M1+zF79YqG/Y8/CXGmBkzk+tdsjjx5jbnMb0L7W5Bu
         b4Vw==
X-Gm-Message-State: AFuF++nfXz0Gw8DYHuKn2B0/sXBkme661JKtuFB0qYe3NHl3kHHyNtHr
	d9FbfqBS5aGE20DTeN3e4Q4vs+Bf6MSxP2UGmggBltjyrSDdgVntCmgCq3zBsg2hcToLfwC2trb
	T41MoGYmFnc8CfBlHVg3yRaeT0sGhuqY=
X-Gm-Gg: AR+sD13Bf5Gxrq9EQ3nQzGiIM6cxfzdfXuX4yiAdWaF/3EyXyhlPquB+lf9K2gPmPPV
	FZl1/a/ASHJ4tH2mSYiH21WkqwZ5JU2suoISta3i7G6CKE5UnPdQlxDr7qJ0UqpMB2IhIYel5H+
	nM5U4bSsLHF6lPLrbtOHlZbz6HRX/SzVNZfjc9N+D4PJ8RuhB1+2M7uO3tEqrNkaKv202xAyF7M
	KC+GoXBK5m0FGIdMEUDumlpFEALkQU1wDdcIEerDoXzCWyZv/mBvrOev1jOnSBOLvCzeSAwZLzO
	O1ECIuH1oASfCKIbbOyqMSyLkiAouXcCiW7b9h7F/RIJp1BzOYgkXIOViTWX6QeZb4pnhmAq+/c
	x5QKnzw3Nk7gBpJASydJSQKrtTAi3aFcSqg==
X-Received: by 2002:a05:690e:bcf:b0:667:e04a:8a30 with SMTP id
 956f58d0204a3-66ce49f762cmr1262898d50.20.1787276975109; Thu, 20 Aug 2026
 18:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260725014448.18711-1-kartikey406@gmail.com>
In-Reply-To: <20260725014448.18711-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 07:19:22 +0530
X-Gm-Features: AcwNN1XplIezQUrx4nOWJDPEkIELZFKnqopMA87slNnZgWm-Xnvzc9BtoH5Bm_I
Message-ID: <CADhLXY4z+W4Nwzm4anPFD5owcm__rzyt1jdnq0W_b6VHaMxHBA@mail.gmail.com>
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
