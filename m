Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76987B
	for <v9fs@lists.linux.dev>; Tue, 25 Apr 2023 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=7kx1qUQxgga2/a3bSbV5m/RprEGXZf8Y2L0EBWV11Fo=; b=hb4B9WReqAkGQoCg8EskPjo3W1
	aFJr1z5R3YHuK88lyFwj7/dEHV9/odC/FZo8/EMub9qjH/5OZAFT71VdAtBr30I0xn8/dHlLyUYY7
	pycDt1EvjYR/3h/r+zcNLJ/t4Mlh1NpwXaDT3dVwS2pDYqtywZDEouchKheqgdJw6osgFa1CYDYqO
	JFH/4pn938hlPFNo0TsG7P8nfAX0nQv/Jo4PWb6+SttjyuhS0mrtKferBqqpt480fNAjJ8bZeHbt0
	E9bLpYTvxWTCIlCoLUvSkCX/CecuAMyrU3udkynCuth7koDiC9XEA9OGRsnVDruS3b37lwOKNMPjW
	tpxwvFbkzBTFX8N5UwEIU6go7wIY38wXFJrqCjvD+vVuFBPEYQKdANHH6bPP9AwF/18u1SUHE071z
	joH7Xy9pIM5R7YlNnMuTx+iEYidTym2ixgrPsXHXJeue06og4k+DvjTCj6TRT0+ssBAWn/9yeCIQ6
	Pt+/GyR/siHs05bSGu0+JzxKhnzVsCv6Gi1Nfcpc9Iu+HbfRExUZUgD3HN8p/GPPJWWAz0YhQexoA
	MR5Gs6OTUQzGPE6iH60LGZhM4+D22/plq7vMB2nG4/sq6OR1KIR8MHteHSh4Xtpa4g+4N3UH9s2gD
	og7eN964d7OtS3cLFLbuzNwFsVkuQT3QuhuEbaqLY=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 v9fs@lists.linux.dev
Subject: Re: [PATCH] fs/9p: Fix a datatype used with V9FS_DIRECT_IO
Date: Tue, 25 Apr 2023 14:19:09 +0200
Message-ID: <7975041.c8dSIL3S0B@silver>
In-Reply-To: <ZEeuFlEAaARGqZol@codewreck.org>
References:
 <80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.1682405206.git.christophe.jaillet@wanadoo.fr>
 <2755033.v0V8SJffbf@silver> <ZEeuFlEAaARGqZol@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, April 25, 2023 12:40:22 PM CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Tue, Apr 25, 2023 at 11:18:37AM +0200:
> > > I'm surprised W=1 doesn't catch this... and now I'm checking higher
> > > (noisy) W=, or even clang doesn't seem to print anything about e.g.
> > > 'v9ses->flags & V9FS_DIRECT_IO is never true' or other warnings I'd have
> > > expected to come up -- out of curiosity how did you find this?
> > 
> > Both gcc and clang only trigger an implicit conversion warning if the value of
> > the expression can be evaluated at compile time (i.e. all operands are
> > constant), then compiler realizes that the compile-time evaluated constant
> > value is too big for the assignment destination and triggers the warning.
> 
> Right, `v9ses->flags = V9FS_DIRECT_IO` would have triggered it but not
> with `|=` -- but in this case I was also expecting the check
> `v9ses->flags & V9fs_DIRECT_IO` to flag something odd...

No, because before that binary expression is "reduced" by the compiler,
`v9ses->flags` is already auto-promoted from `char` to `int`. So it is
effectively:

  INT_RVALUE BITWISE_AND INT_LITERAL

And not:

  CHAR_LVALUE BITWISE_AND INT_LITERAL

And up to this parser state that's absolutely valid.

The compiler would only able to detect this issue if it would carry the
information (min. used bits at runtime) along over multiple reductions,
up to the parser state where it eventually reduces the assignment, which is
apparently not implemented ATM.

I am however more suprised that neither clang's sanitizer, nor static analyzer
detect this issue either.

> But nothing seems to care; testing with this snippet:
> ---
> int foo(char x) {
> 	if (x & 0x200)
> 		return 1;
> 	return 0;
> }
> int foo2(unsigned char x) {
> 	if (x < 0)
> 		return 1;
> 	return 0;
> }
> ---
> gcc warns that the x < 0 is always false (clang actually doesn't, even
> with scan-build, I must be missing a flag?), but I didn't find anything
> complaining about the &.

-Wtype-limits (or specifically -Wtautological-unsigned-zero-compare) does it.

> I'd expect something like coverity to perform a bit better here but it's
> a pain to use the "free for open source" version (... I just requested
> access to https://scan.coverity.com/projects/128 but I have no idea if
> they build next or not)
> 
> Oh, well; glad Christophe noticed anyway.
> 
> > > Would probably be interesting to run some form of the same in our
> > > automation.
> > 
> > If there is any ATM? I als tried this issue with clang's undefined behaviour
> > sanitizer and with the clang static analyzer. Both did not detect it.
> 
> There's at least the intel bot building with W=1 and warning if any new
> such warning pops up (and I'd like to say I check myself, but I probably
> forget about half the time; I looked at making W=1 default for our part
> of the tree but it didn't look trivial? I'll try to have another look);
> but I'm not aware of anyone testing with scan-build or something else
> that'd contact us on new defects.
> 
> 




