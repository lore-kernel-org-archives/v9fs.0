Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9162003AF
	for <v9fs@lists.linux.dev>; Thu, 24 Oct 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792689; cv=none; b=Pa21pzZ2Yi2ljnioUh7kJLUueC/XHkMlpTXOkRfQ1g44ct2QIxP17ygTDOaccuEyyJthy3bFLxovk60dnSQtsp92AyI7iefuRCqxMNXZaQCzhrur2IGvxXdsC7nuW2bl21wjUnOIHVBg6MApB658Vl2VJRYc2SWSA+Pcxx1Jw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792689; c=relaxed/simple;
	bh=IDg9T5Qfv2udS414YtOooo7ru8VVq4FD4hd6amCYuAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UU5mmRf7FHaslmVGQcJuvdqtMfGnULW3UeYerxrcfrXZrpO2fbvyEkHX5IpJhH3MBBtjBDEADIGFtYD1b5GBIzFaiKSBSCURpGzxKe7STI1luRqGM6uDxnPJc1ZjgqkyYLYQmxl9grBGGvpAV74pe08bI/GAym9dZTOtg0K5jhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPLaeOLc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPLaeOLc"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7203c431f93so938113b3a.1
        for <v9fs@lists.linux.dev>; Thu, 24 Oct 2024 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729792687; x=1730397487; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOOALsANStOeuuEkl2qAgILCmCOMlJnv3Z3aW8sSQTI=;
        b=JPLaeOLc9cG64OEE8Qbn+vG4oBk8O7sMQUbGWjYfo+aLTobIvcmceFkZti/h4j0j91
         oSY166WJ8eReLtarlaCoR3B25jOi/jmhSMZTvfzXaye/6+WpvJscUnzQAXwik5eGNLpY
         e3x780rT5Sibwf5Prm1ZNez7Prxv8l9IuAAkL7udfs8hoNbJEzUlwK/bWgaoHK32qGYj
         J5s6uZHffgcPeM3ww5XJ/V03mpMYGAXz2zP38XAp6keLxdtU15xX7xTtfTUS9oS/Ayw7
         P+/4X7e9e0dGcWXU8F1ahW25BI/vFXdksyoQduK8t0qMXrG5FovwcYJ7zsD140Rql9KO
         EEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792687; x=1730397487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOOALsANStOeuuEkl2qAgILCmCOMlJnv3Z3aW8sSQTI=;
        b=VmwQJ2O8eoAi6bLNg6ABDdyxy4hnAb26MPWaWIFy2kIkDLADulfAio6BPJyPy3Doqy
         2OPb9jPMKb5Vi3ZsaVITEe0a1lxqE5BLdHwlaxHWoHtzD7nWYgkq5M2kSV2lT8m7F47z
         ft+Z9EZKNBLltMdyzi/ZVAC3iJNy0UR4WPgLj6BTwlpQ2xkpR5eANSs85zHUFEUMoino
         o29COfkrfgghZKAXmF/whXXxnGwAH1C4bKb3R6MT3dHmUn8hfoO1BJ+sAXhD1URxLJ4+
         l730Thx+ffn/hojrFjA1jmWGKvE+9wH7myYUs5l9Ckly02j/a/sDSTKnF0wHw0UT5Wf4
         jzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS7or+5XgaRX7oB0sCrwWPEgi23iOvAi9ZljQ8Ptcn4nlIOB8aZ7fl5t0qQxrpnEk7ZNbw@lists.linux.dev
X-Gm-Message-State: AOJu0YxZNEKGznEQWd/nWr28wTZZWv9WeFdym9gb20Pw/ccc1NVbiOgf
	r7qxDmMZJ3vC/sfySmvcbEUk+ZmiujAgcefngB9xlKR3ZNABBMniqjg+WaMunlE9cDTUezy+PGe
	XDG1Bqb4B3NIJ+B2n+5ogS++4nt0=
X-Google-Smtp-Source: AGHT+IFAk6QlKiQ2m35u3vHdzC9nkRetI3VtuP5Qt4n3QzS2cNh0LibQmS8CXMMOOOGO+4k2Oqw2SJK3Q+JtYTTYcfQ=
X-Received: by 2002:a05:6a00:1307:b0:71e:6743:7599 with SMTP id
 d2e1a72fcca58-72030a8a143mr10153586b3a.7.1729792686812; Thu, 24 Oct 2024
 10:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241024-revert_multifolio-v1-1-becfa0dd385b@codewreck.org>
In-Reply-To: <20241024-revert_multifolio-v1-1-becfa0dd385b@codewreck.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 10:57:55 -0700
Message-ID: <CAEf4BzY_j9e3Awqn-mOmHOy4+SWn752mXX+mySQYdKoEHr2RPg@mail.gmail.com>
Subject: Re: [PATCH] Revert "9p: Enable multipage folios"
To: Dominique Martinet <asmadeus@codewreck.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+cc Linus, in case he decides the revert is necessary and wants to
apply it directly

On Wed, Oct 23, 2024 at 4:29=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> This reverts commit 1325e4a91a405f88f1b18626904d37860a4f9069.
>
> using multipage folios apparently break some madvise operations like
> MADV_PAGEOUT which do not reliably unload the specified page anymore,
>
> Revert the patch until that is figured out.
>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Fixes: 1325e4a91a40 ("9p: Enable multipage folios")
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  fs/9p/vfs_inode.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index effb3aa1f3ed..fd72fc38c8f5 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -295,7 +295,6 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
>                         inode->i_op =3D &v9fs_file_inode_operations;
>                         inode->i_fop =3D &v9fs_file_operations;
>                 }
> -               mapping_set_large_folios(inode->i_mapping);
>

This fixes our issue (might be worth recording the link to original
report for the context, [0]), so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

I think the bigger question is the MADV_PAGEOUT behavior in the
presence of multi-page folios. Currently it seems fragile and
inconsistent, working for single-page folios, but not doing anything
(and not returning any error while at it) for multi-page folios (if
the theory about the root cause of an issue is right).

  [0] https://lore.kernel.org/all/20241023165606.3051029-1-andrii@kernel.or=
g

>                 break;
>         case S_IFLNK:
>
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241024-revert_multifolio-3e117978b5c2
>
> Best regards,
> --
> Dominique Martinet | Asmadeus
>
