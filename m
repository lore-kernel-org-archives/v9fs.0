Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCB7B
	for <v9fs@lists.linux.dev>; Tue, 25 Apr 2023 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=BHW6lOjF2/MreJruUAvsHwDdg1hNEm0hYuqgSYNZ7rU=; b=QUX1v0aEYSHcAuCErNP/NsH6Zu
	OdQ8annen0W4z5oS4TbLmKIdNMEffyzuWY+661xeEOsUsEVkT4M1POGHTgDHAH2ZaE86X3oZY/ewW
	9AUxge9cp54U/J8CWCB9F0OFQ2RTMg8X/o/jalfWDTSgjOr+H4vb4RQ+fLqUcd2rIUHp8LfD/Wbke
	Q+iOsYy06AmdZWSheK/KEI9iJSBEzIVOYaDquz1aSyx1WDfFi++iVtmPVqlDr+PkKqPO8wrcC+xC1
	IOrA6xMvLXZmPPrkxP1LLZOK3cj90RNsXvmmzBSgeSM3oMYtZ3o8wN+t/VVlPcA3iREIYb2xZyExR
	sCqEeC2vxSuC/0WQeO7rtCE6ZX//xG+X9/Uh8FSIUrQOZSmnJYCh+3aVbmxYHNElqL4lgG/ABGQLZ
	V9mTSYcwfeRs3No47N0QxVjjcLcUuhd9GuAtoUfT/9vT7ZwMJ0p7twyMqgKuNWGjnXvt2+u338UoB
	UCHK4ntPBn3LSGVze0rAlIzrUHoi+u49+bx9KoumTaNyILIqyGmBkMDX6qVywYOthAnR+L5kMLtsF
	xHwj1pvQ0xMonhBwuyOUI7Qt6t7kWJYKNToBQpzonqP0WDAhVZV1YeU8LRYSby+AwIky463GyjR5p
	mc2BK8SNERlDBxVa538t8/mcKpdvrr2gm7CIdQ4F4=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, v9fs@lists.linux.dev
Subject: Re: [PATCH] fs/9p: Fix a datatype used with V9FS_DIRECT_IO
Date: Tue, 25 Apr 2023 11:18:37 +0200
Message-ID: <2755033.v0V8SJffbf@silver>
In-Reply-To: <ZEd8d7W6HnHE_66m@codewreck.org>
References:
 <80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.1682405206.git.christophe.jaillet@wanadoo.fr>
 <ZEd8d7W6HnHE_66m@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, April 25, 2023 9:08:39 AM CEST Dominique Martinet wrote:
> Christophe JAILLET wrote on Tue, Apr 25, 2023 at 08:47:27AM +0200:
> > The commit in Fixes has introduced some "enum p9_session_flags" values
> > larger than a char.
> > Such values are stored in "v9fs_session_info->flags" which is a char only.
> > 
> > Turn it into an int so that the "enum p9_session_flags" values can fit in
> > it.
> 
> Good catch, thanks!

Indeed!

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> I'm surprised W=1 doesn't catch this... and now I'm checking higher
> (noisy) W=, or even clang doesn't seem to print anything about e.g.
> 'v9ses->flags & V9FS_DIRECT_IO is never true' or other warnings I'd have
> expected to come up -- out of curiosity how did you find this?

Both gcc and clang only trigger an implicit conversion warning if the value of
the expression can be evaluated at compile time (i.e. all operands are
constant), then compiler realizes that the compile-time evaluated constant
value is too big for the assignment destination and triggers the warning.

However as soon as any variable is involved in the expression, like in this
code, then the final value of the expression cannot be evaluated at compile-
time. Small operands (e.g. `char` types) in the expression are auto-promoted
to `int`, hence no warning at this stage, and finally you have an assignment
with unknown `int` value.

This could certainly be improved by carrying along the information that an
expression evaluates to at least x bits at runtime (when the compiler reduces
the expression).

> Would probably be interesting to run some form of the same in our
> automation.

If there is any ATM? I als tried this issue with clang's undefined behaviour
sanitizer and with the clang static analyzer. Both did not detect it.

> 
> > Fixes: 6deffc8924b5 ("fs/9p: Add new mount modes")
> 
> (Not a problem per se: but note this commit hasn't been merged yet, so
> using commit IDs is a bit dangerous. Might want to remark this in the
> free comment section so Eric pays attention to not break that when applying)
> 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
> 
> 



