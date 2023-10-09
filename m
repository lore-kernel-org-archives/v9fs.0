Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94335880
	for <v9fs@lists.linux.dev>; Mon,  9 Oct 2023 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="aLef17p0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=y9OH9A/0tZs5gOlE4MHof+N8Nd5EhBnLnFtNiEA9oIc=; b=aLef17p0jWqH/wWV1FQPPbyeuC
	MU1zujxGipaHUFxeGksF8mYxmwdBUUnJPn8OuuHXUoX3yLii/YWCpZubR3mB7pvIfbSdaJMXYViJK
	Jz79xMplG9W9I0V62qFurehS7rNMdEFxX3SBX8Gwp1+gsf5ENN2dZxf4SwMm5A+qVaV7sF7RMtyMM
	zgNswtCDMVMSHQUJgdeYyV9Nt0e2oN+eEikOs4fdcMBkLtsSx/aHIog30jceFrxCkQEsoi6Ro31Hf
	IU1oDBN7TwCra1qFGC32hKHvYiQBGsVFyfZGv2CZ1nbxK3kbdlYbSnWtA9T5Bg6q+e3RBFaGXgIB3
	m3bO/oexi6V/yQEGNGGoAxJRGvJiQOWG3hcmth2qLtPaSYKU2sEnbvoBRWb/YYVZvU5jQq2h4YdSR
	npbskRosPQeWE9LrAZLEE3M+/6Lo0DcwqzuisnFXLhmJzQ7tClTwjxChFINzhQyhbgc6HdUcfzMCj
	jOUHvN/bgFM/Z+y7Ofp/oD//V2y/NLnhRZiiXCbYzw3UlsgM+hkfDt7pVnRXHgDZtXteNlczIKCEJ
	rsYcigSyUTOQC8t8vnb9JoeVIKLlpZ/o1xzK+S2VdJYfgx1T4AvVq1KCu1X8AWn/hlCpMa1+g7Lfl
	/bkb8I0tpgDwA1s4V6MVXucEMoPQruOphI5iHyar8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 Su Hui <suhui@nfschina.com>, v9fs@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Date: Mon, 09 Oct 2023 20:34:15 +0200
Message-ID: <13910281.Zj71IQSfG8@silver>
In-Reply-To: <20231008060138.517057-1-suhui@nfschina.com>
References: <20231008060138.517057-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Sunday, October 8, 2023 8:01:39 AM CEST Su Hui wrote:
> with gcc and W=3D1 option, there's a warning like this:
>=20
> In file included from fs/9p/xattr.c:12:
> In function =E2=80=98v9fs_xattr_get=E2=80=99,
>     inlined from =E2=80=98v9fs_listxattr=E2=80=99 at fs/9p/xattr.c:142:9:
> include/net/9p/9p.h:55:2: error: =E2=80=98%s=E2=80=99 directive argument =
is null
> [-Werror=3Dformat-overflow=3D]
>    55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> use "" replace NULL to silence this warning.
>=20
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/9p/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index e00cf8109b3f..d995ee080835 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char=
 *name,
> =20
>  ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffe=
r_size)
>  {
> -	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
> +	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
>  }
> =20
>  static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
>=20

Mmm, that's not the same is it? Have you tested this change?

Currently this function causes a 'Txattrwalk' 9p message to be sent to 9p
server with its name[s] field being NULL, and the latter being the magical
hint to 9p server to not send an attribute, but rather the list of attribut=
es.

With your change I would assume that it would rather ask server for one
attribute called "". I have not tested myself, just worrying that it might
break behaviour.

/Christian


