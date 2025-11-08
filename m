Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8404221277
	for <v9fs@lists.linux.dev>; Sat,  8 Nov 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762593579; cv=none; b=nV/UKYE9NhFDEmECuSXxegMioKxHMoegocsiiLJIcreV3pRoX6tVwFlb4nnfqzAsboQqj3COxAM75FInfwvMCALyVjMvzj5nJf6fEBfOJ0onsSQWDRU36qsE+NHquwqvy4GTLEAS+eCCEO1hT5AT21FZiJefioPi7BL5r46JwQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762593579; c=relaxed/simple;
	bh=Y49FEVhEZCj60/+Ylnua7B5NNXsJ25LsdBXGXmWxbi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLz6KTJxk+lh3zygYFMJqI79+Hh2E306UXaNjclNatLHav9sradQENPF3FRQ+OTjkrQxvnmu3EzIV98yrwaIy/ivQu3TBqIZdTB9VcFG16OW9rbKjON9vK2Nb7dtUdyTySv8o1QoGFyhv310batFdZhVwBpu11Rm4Z7t2Xkza0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JolopQ+s; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JolopQ+s"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ade456b6abso1295166b3a.3
        for <v9fs@lists.linux.dev>; Sat, 08 Nov 2025 01:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762593577; x=1763198377; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMJJSbsWQXZcDWYlPD+q/sMKmcoPg7XO2KNCJJBRcPk=;
        b=JolopQ+sE6nsUhaaLuPmWqi5bQZUp2DSjTRtFdyq4133dTcNDDwpo9TpauqC6u9XcE
         7/qxAGs7bSwsB9jc6z8BmRqq69KbrXYABihWFEZqdYoiuUUWIlecFX3guBk7Qnk2vPJ5
         V8wiHj+GIFw2PLm4myaFqIT0BBEfkB/GUBEIXW8O0DNkzlWj+PF3F5CND+URQwAuaCCc
         elNSr2+zEM5p4FG0h9VPvL4jX9XuTsoCSs4v/EOf/tf4cXtb51bihO6OXWf6ErOJF7le
         05jKd8LDr2N4f7Lkm88P4mG1QzDKUL/kp6N9LQvo1PPdmsbEAaotekd5tgk9fd1Yo0N0
         hLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762593577; x=1763198377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMJJSbsWQXZcDWYlPD+q/sMKmcoPg7XO2KNCJJBRcPk=;
        b=YiV54YiUh8uW1Qiajmw4LmdJTkgOzo2kBlVNUIB+Vg8AjltMhEvhab0BQo3ZnhOSpy
         eDTVPlCv5NpET8nKn/GY9p0X6tYz4jWbpi4sqg2hbwrnD26YbNWpThVE69/KmoXlHpsq
         GYh412iMZSmJN3ktnkscb/2UUFG7FibfDtYWo09yB3lH43SHGcd/1Tmh4iiEJK3RmBPW
         fOQsNXIEU/jtk5zqnHzFHXVkcWVdYHwUTwsslPgQg9dOzS9UKewTQEJnJojOICzVlZfm
         C9Dbo/zg3AELfRatk1/HTMFpYv33A1RKwxUFv0rPGD4AfJ78OFu5N4yLhMYwZX+XKCWf
         NXHg==
X-Forwarded-Encrypted: i=1; AJvYcCWej/OgNbHDnydVEnYvmsrk/39EYDpVLKNJbCoXynXXDOTzdN9Sy7VmtVclNbxZZJZuauQa@lists.linux.dev
X-Gm-Message-State: AOJu0Yy32ONMumywg4gVnlkEJAeGoB5QdytnML6X6UlbQRD/ksPwnWFo
	tD0vUFa7U5efQ/7GcVF9tZB/gvP2YZPi6Sxs9xqVYnnrTwS0AXhzlBkx
X-Gm-Gg: ASbGncsGS4ugCYM38YgOtPEWQSoR+zcjDtw9Tp/6P6+ptUp30ECeClbO01aV0HpUDRA
	+hbQSwYJrc/sQkYU7Herkg+twPXpLhlAYRjkX/6tc1l8WEtgDLRESZjAcT5va7YAHo5a1M/grCv
	prUtHdQLHiiL6sd4qjlfoVZUFiaCOAUJ9fw1DRfJCpI5YlhHfuRJBn0YOV2yPZNbkT1TuwAoCT7
	FoF5XdTj7QhFeIboksb6XmhCo9+uIhzYv+fy8HSWWn9rO2STXtyyjuYDVSTeet8LT2IoAgep1LK
	q/0Idk323QCkJBZ/r6BLVS+/WGgrfpAuGNVMdzgWmcXVe99Q1kWnYc+43svtHxh1BhMVScVdQa0
	8juoV4l6lCxdNUVaGeBo9Muszo6FvckdTKm6s9hZDWFJe1mK/1jBcYHbU2pDYzP/rb24F8GS2Fy
	4J
X-Google-Smtp-Source: AGHT+IF0YP4Otkbzly3RQbSixJdpmmdp1zu3glQ2poSUDNCvD7oGyUzRXByQOYxnN497yc+CfkoJmg==
X-Received: by 2002:a05:6a00:a8d:b0:7ac:69cd:ea0d with SMTP id d2e1a72fcca58-7b226f8dd18mr2391831b3a.19.1762593576763;
        Sat, 08 Nov 2025 01:19:36 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cf79sm5483323b3a.3.2025.11.08.01.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 01:19:35 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 77412400200B; Sat, 08 Nov 2025 16:19:33 +0700 (WIB)
Date: Sat, 8 Nov 2025 16:19:33 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Chris Mason <clm@fb.com>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bob Copeland <me@bobcopeland.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Hans de Goede <hansg@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	NeilBrown <neilb@ownmail.net>, linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
	ecryptfs@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	gfs2@lists.linux.dev, linux-um@lists.infradead.org,
	linux-mm@kvack.org, linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] vfs: remove the excl argument from the ->create()
 inode_operation
Message-ID: <aQ8LJfKC0R-4ehLU@archie.me>
References: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>
 <aQ7fOmknHIxcxuha@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hTQgJTXrd9+JcPiP"
Content-Disposition: inline
In-Reply-To: <aQ7fOmknHIxcxuha@codewreck.org>


--hTQgJTXrd9+JcPiP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 03:12:10PM +0900, Dominique Martinet wrote:
> Jeff Layton wrote on Fri, Nov 07, 2025 at 10:05:03AM -0500:
> > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesyst=
ems/vfs.rst
> > index 4f13b01e42eb5e2ad9d60cbbce7e47d09ad831e6..7a55e491e0c87a0d18909bd=
181754d6d68318059 100644
> > --- a/Documentation/filesystems/vfs.rst
> > +++ b/Documentation/filesystems/vfs.rst
> > @@ -505,7 +505,10 @@ otherwise noted.
> >  	if you want to support regular files.  The dentry you get should
> >  	not have an inode (i.e. it should be a negative dentry).  Here
> >  	you will probably call d_instantiate() with the dentry and the
> > -	newly created inode
> > +        newly created inode. This operation should always provide O_EX=
CL
>=20
> This and the block below change halfway from tab (old text) to spaces
> (your patch)
>=20
> Looks like the file has a few space-indented sections though so it won't
> be the first if that goes in as is, the html-rendering doesn't seem to
> care :)

FYI: I'm using Vim. My important settings (in ~/.vimrc) are:

```
set nojoinspaces
set textwidth=3D0
set backspace=3D2
```

However, ftplugin override these for each file type, so you have to essenti=
ally
"fork" the relevant ftplugin file for each type if you want for your settin=
gs
to take precedence. For example, in case of reST, copy
/usr/share/vim/vim91/ftplugin/rst.vim to ~/.vim/ftplugin/rst and override t=
he
already defined options there:

```
=2E..
" keep tabs as-is
setlocal comments=3Dfb:.. commentstring=3D..\ %s noexpandtab
=2E..
if exists("g:rst_style") && g:rst_style !=3D 0
    setlocal noexpandtab shiftwidth=3D8 softtabstop=3D0 tabstop=3D8
endif
=2E..
```

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--hTQgJTXrd9+JcPiP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQ8LHwAKCRD2uYlJVVFO
o2WVAPsFBRuUsYfWxAnWROgP/61sBqVYDc/UsPimcXm5dJJfgQD9ESTXpfxlpefS
VKeWBneX6svZYShHE5RzrbcYO+G5GA0=
=gW2v
-----END PGP SIGNATURE-----

--hTQgJTXrd9+JcPiP--
