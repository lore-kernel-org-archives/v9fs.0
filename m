Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C615A7
	for <v9fs@lists.linux.dev>; Tue, 10 Oct 2023 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="cLZzej6i";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Wo2S7iv9"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 55D4EC01F; Tue, 10 Oct 2023 04:23:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1696904608; bh=vDDZpwwma7Avl3c22y5CxXhDLr3FrhQCVpBoVTpT7Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLZzej6iwRpfw/yDnbY1P1nWxiXfJ9Deryd9mZkGAgBhKJizV7SZdWvnz7ltlXo2k
	 AbXVzq712zwJ2NQat3uECJmclHScHyYObiXEdYxWO3KCRNi3aXISuP0z8V9JVAm/ml
	 04gGbPyOVM9ukcinXvdO7X3VM+3ZEaWtosp0G8Xj84kzNDuyMUKNc9V4uKD8L+rFw2
	 Ai8l0mz81aoWlHZ5X2qpjNNEzRc19cEnMEV4OvB/iHnHwjuy0oTstUC1HKda3olIFx
	 2Lla+WA6j7ciAzApdT4hVUQhGoX9AqPdD/snBcXEQ+6kqTQi7zVIPflpi0km8g8d62
	 Qjkys3SYx3IQA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 6D504C009;
	Tue, 10 Oct 2023 04:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1696904607; bh=vDDZpwwma7Avl3c22y5CxXhDLr3FrhQCVpBoVTpT7Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wo2S7iv9h8oygPJ3rzyYbNjLs/YiTnhz28dN0FQ4cvWcmxrEKYzhwvvWqSShV/Zqj
	 DFcKBwysqunq25EHaT+LqRVFy76WY3j4Mvf5gHzCPfP9C/cNJH2ua9amjdBr8zUEeE
	 Uh9LJvl576hU1aVOa/PY7GzchJwaPToZjaPAmg3Lt7Vv2bTM99PyOpObUiHO5ghK6F
	 QZ9QVeGt+ZYzC7DW9mbUb4fXt1pJRBfry+i8ic6VuegDn5UGdMYh6WhDOdfjf2vgVe
	 szc1JxsbuhyxydgnHYcHimIao0z3PBEtr7MXArOTQpr51NrqT4tk6rzoxQkRgG4RCu
	 08muuPd8HJxBg==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 80c398e3;
	Tue, 10 Oct 2023 02:23:22 +0000 (UTC)
Date: Tue, 10 Oct 2023 11:23:06 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, Su Hui <suhui@nfschina.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Message-ID: <ZSS1irFMxC35cg01@codewreck.org>
References: <20231008060138.517057-1-suhui@nfschina.com>
 <13910281.Zj71IQSfG8@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13910281.Zj71IQSfG8@silver>

Christian Schoenebeck wrote on Mon, Oct 09, 2023 at 08:34:15PM +0200:
> > +++ b/fs/9p/xattr.c
> > @@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
> >  
> >  ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
> >  {
> > -	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
> > +	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
> >  }
> >  
> >  static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
> > 
> 
> Mmm, that's not the same is it? Have you tested this change?
> 
> Currently this function causes a 'Txattrwalk' 9p message to be sent to 9p
> server with its name[s] field being NULL, and the latter being the magical
> hint to 9p server to not send an attribute, but rather the list of attributes.
> 
> With your change I would assume that it would rather ask server for one
> attribute called "". I have not tested myself, just worrying that it might
> break behaviour.

p9pdu_vwritef should output the same (just a 0 length) for both NULL and
"" so I think it should be ok, but it definitely needs testing.

I'll try to find time to check (getfattr -d should be enough) later this
week and add it to the pile

-- 
Dominique Martinet | Asmadeus
