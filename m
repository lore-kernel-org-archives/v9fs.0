Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C1FBE2
	for <v9fs@lists.linux.dev>; Tue, 10 Oct 2023 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="YzZE4smW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=vZ/Iuu84hep1RjBDXaiCtQLKdDGxvE+knWVOSwSOFmg=; b=YzZE4smWZ+q1Mv7lXM23xEuJHM
	ZP7WoGJCARna5evriYPQuoydFF0clnT/ChUm0MTeGEUNK15U5UXFt8o+INlOw8DimXlAxraQv7Mzy
	6uFAF1ts4lE6i46Rt6eOYHYtw6s7lhmv+tvyxFdZ+IaJe3IgBZqP6lzaHlBnQ7z6HPBiSN9g2y04x
	6c1yIy6h2MFxa3qarhFqqXcyYHOWXcnsCG0P3Ztv3iNTK+jVdx2eWIj8xmiRq9t6FXTDWq6yq01wX
	kmrqCZpSZXxeDHFjHUo/l3RIdjvdupSYF0V6hZ39d6w4q1jGq0A/diV7mbm4EhU/F5YJQuIoZVTkJ
	YZnO8kZiyUfmiKR4Hl8XHbYx3oIvm+TDZIqDdfMYnPGx+0bybv+4FihZ2fxIjyaU9zgUg3f1hs9Td
	PbohF7ljIpr7/U6tdJY3wSV72clciralsqhHOzcggHjGBNEGKTiRcweeUnRJvhThvOgbeyFqKZEGB
	cLLbrrOdjR5MGW9L3Yd+BlJ7aEL0kGjZl7L4JF74qsh/aGHL41rsYW0VZNKyjW39fEc7MEaI+KklP
	tKA5a8O2lwqqoRLBWhHXEbD3NHWYQWhMle4gqLJh3Me5Yu0rb76vU4aMKOTuAiTvP5PuqU4rIn0Xv
	OlhzQo8VRUFFTnoDV/t0p0Tx+ZBUDK10hMeH+T5vo=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, Su Hui <suhui@nfschina.com>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Date: Tue, 10 Oct 2023 09:59:11 +0200
Message-ID: <1795281.aKYqWbn8Tv@silver>
In-Reply-To: <ZSS1irFMxC35cg01@codewreck.org>
References:
 <20231008060138.517057-1-suhui@nfschina.com> <13910281.Zj71IQSfG8@silver>
 <ZSS1irFMxC35cg01@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, October 10, 2023 4:23:06 AM CEST asmadeus@codewreck.org wrote:
> Christian Schoenebeck wrote on Mon, Oct 09, 2023 at 08:34:15PM +0200:
> > > +++ b/fs/9p/xattr.c
> > > @@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
> > >  
> > >  ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
> > >  {
> > > -	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
> > > +	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
> > >  }
> > >  
> > >  static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
> > > 
> > 
> > Mmm, that's not the same is it? Have you tested this change?
> > 
> > Currently this function causes a 'Txattrwalk' 9p message to be sent to 9p
> > server with its name[s] field being NULL, and the latter being the magical
> > hint to 9p server to not send an attribute, but rather the list of attributes.
> > 
> > With your change I would assume that it would rather ask server for one
> > attribute called "". I have not tested myself, just worrying that it might
> > break behaviour.
> 
> p9pdu_vwritef should output the same (just a 0 length) for both NULL and
> "" so I think it should be ok, but it definitely needs testing.
> 
> I'll try to find time to check (getfattr -d should be enough) later this
> week and add it to the pile

Yeah, I think you are right Dominique, it should end up the same as both cases
result in a string length of 0.

/Christian


