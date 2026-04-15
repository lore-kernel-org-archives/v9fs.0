Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DE32AAB2
	for <v9fs@lists.linux.dev>; Wed, 15 Apr 2026 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249391; cv=none; b=sqlXJIDO7vD6LPzgWI80uro6ZOzn91QSekgMO4nymG7ObgBhF3YJ8WHAXRbnyTF1n0LwoTlxvqfMgW2Xqv3GeL1VmAtWVLKOMNTZqKhkbdbBl4aZoDuqim5lCiRP2uPbTBt2N9edidtr+Nn77S8oFMfLkMDSxAh5xX7Fgr3ZwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249391; c=relaxed/simple;
	bh=NxnF4CK1FqxBbrKmbiMurgO82lCtFPaN6WHaOcYG2EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1KFOke1EP5w62uPdJD5PxUj9N0si4borqCi7XdNo0cQT7CBL/5IbKQxqxTXPrYQO3XbwcZsa22Ci0NAsfQbt5DngVGRkT13uL/bSy6nfF2QFAlWCuS86u2+ZldhbVaH1EKaBbEkPISfCKX8j1WD1Wzo8tZN0y88nQ/6dPofVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F80y9KA5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F80y9KA5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so88167945e9.2
        for <v9fs@lists.linux.dev>; Wed, 15 Apr 2026 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776249387; x=1776854187; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQsaK5fpmw9qRbAqGp4qBmJu047lOibXZ/dUKVuEGTc=;
        b=F80y9KA5kvsHe/N/nW+FWAMEIGYQr0Ra5COaTVYMZQ3vIUiEehBqJRWdQk0ocloIjP
         c1hRNZn/7os+/1B5cnl9lCbVaz8wnj2wDLCKdrw7MZNoM8csxVYMRxN6MZNkFYNpvOTb
         GVbG+yJGgJbZ/uKPJdl3TC5RVrQZoOIi9y9OLKylKK/6zNUPxM6EtmMAWGVGDqam2g2M
         ouYuuz4g1ZGOKAswoq38DY79gPfCIaO8tXO+f+inQSQUyM5/6E4bCk2jc+MoJ0VWscMu
         2hJ6Mt4Q/fyAH6myMA/W/IHWbpaV6jDDzZt6UFtHduBBLluHmf5AOhriThaWegNTCrN/
         JLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249387; x=1776854187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQsaK5fpmw9qRbAqGp4qBmJu047lOibXZ/dUKVuEGTc=;
        b=JNkuwuVnPMw1O34JcaAyZhcQiYzxWWvz47aEIzFX88l9m7vCdUQ764gKr4HvGwTkCM
         I8ZM27yuZgl+A2Mt6INfsiC0iwbqLXxvFxaH73xyK2zzZhmcG/vnQbNwzdh/niI9wsPX
         9RMb6QDnMfDTZ3ckOO440np+zwiryHmgyeSXrLEvD8dM5coXU/Dkja4Lg3//EfbksF+9
         yXKStojTf4iXWpOyT1uO5byo+AFMoywHtIpVz8k86olBJYvGjNF5qrAc+b7fzzaumpjK
         kXVEN7pY6+CMTqMahlTDCmMKWn1EskIz0LfPvPSzjY5cF1p1AB4YkRuwnNDnw4Ij6dM1
         LexA==
X-Forwarded-Encrypted: i=1; AFNElJ/Y5d69msGSVWYJbQqhbdc248+wJA0VrFkqaUhGAl9uOtSafMPjOHzMgm1/S1ilOmgkNW+W@lists.linux.dev
X-Gm-Message-State: AOJu0YzU07wpbx5vGSKTuJjAM09ozpRPMuW5D1PUbMynUraS4FnjX7s6
	WAwtMNg5TlYOmgHeh/qwZEfL98SXfLzSiuQEkSI+7XyOGA3SeJhT4hbD
X-Gm-Gg: AeBDieu6YSfAy9N2oqTOdEtvBpxpTbvvDZKJtuE0h9h9KUVZLI37eiBRKnOioMHXWor
	tQd20Q69TWiLHDflwVHCzvCPIhcb3jfAZEVf7PJ5leCW1hJIuNliy/IwXzhCd7n/3eUZ/lQEDzD
	bgj8nEktAoiUsk2lN9veuEFd/cr4BzQ50p4zCCYHCFqiKep3hDgsQu4Q/oQq82HiizEE1K2LtLv
	CDSkhEevLrgPxppje93lTqru6af0caQQ18LMyebglfDYwck7eSuHSfkmmKf4/AkZry/MERvbSY5
	voHSo1/u1kTKkV+adPMhJamMGha/c3RJEKAU5I4sLFRPG+U9o9pY2DOJqVFZgyffoLxCxVRNGc3
	Fiz9euU92PYtLDq/k59hoyQblYaNdjb51o9L0K8/aYxvYS1TgsR0e/j43iAIh6RHZXaDnXU/ZWg
	QN2s44DkEguXK4MyrJtPDY3+bjRMdMGy+0hbljL3xmcyn9MNXU0/07C4Zwg9q/ZlOmhJuOBZP9s
	3w=
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr298005975e9.2.1776249386934;
        Wed, 15 Apr 2026 03:36:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3fd3b7sm4531195f8f.35.2026.04.15.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:36:26 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:36:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Pierre Barre" <pierre@barre.sh>
Cc: "Eric Van Hensbergen" <ericvh@kernel.org>, "Latchesar Ionkov"
 <lucho@ionkov.net>, asmadeus <asmadeus@codewreck.org>, "Christian
 Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: use kvzalloc for readdir buffer
Message-ID: <20260415113625.6d38441d@pumpkin>
In-Reply-To: <a93672d6-1b99-4d4f-a8e4-c7f8b0d10b36@app.fastmail.com>
References: <06399e04-b019-4c3d-b941-5771b6ac33c2@app.fastmail.com>
	<20260415100157.4aa33364@pumpkin>
	<a93672d6-1b99-4d4f-a8e4-c7f8b0d10b36@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 11:27:21 +0200
"Pierre Barre" <pierre@barre.sh> wrote:

> Hi David,
> 
> Perhaps what you describe can explain what I was seeing there:
> https://lore.kernel.org/v9fs/496d10b9-40fe-4f81-8014-37497c37ff63@app.fastmail.com/
(After seeking, getdents() returns stale cached entries instead of fetching from the new position.)

Absolutely.
But the fix probably isn't trivial.
The offset that you need for the seek isn't directly related to the number
of bytes copied to the user buffer - which is what I suspect ftell() (or
whatever gets used) returns.
I think there is some mechanism for arbitrary directory offsets; but IIRC that
requires the code put the 'file system offset for the next directory entry'
somewhere in the directory entry.
Such an offset would have to be one the remote system would understand.

A partial 'non-fix' would be to reject seeks to other than offset 0.

	David

> 
> Thanks,
> Pierre
> 
> On Wed, Apr 15, 2026, at 11:01, David Laight wrote:
> > On Wed, 15 Apr 2026 07:45:08 +0200
> > "Pierre Barre" <pierre@barre.sh> wrote:
> >  
> >> The readdir buffer is sized to msize, so kzalloc() can fail under
> >> fragmentation with a page allocation failure in v9fs_alloc_rdir_buf()
> >> / v9fs_dir_readdir_dotl().
> >> 
> >> The buffer is only a response sink and is never pack_sg_list()'d,
> >> so kvzalloc() is safe for all transports, unlike the fcall buffers
> >> fixed in e21d451a82f3.
> >> 
> >> Signed-off-by: Pierre Barre <pierre@barre.sh>
> >> ---
> >>  fs/9p/vfs_dir.c | 2 +-
> >>  net/9p/client.c | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> >> index af7f72abbb76..487c177aae38 100644
> >> --- a/fs/9p/vfs_dir.c
> >> +++ b/fs/9p/vfs_dir.c
> >> @@ -70,7 +70,7 @@ static struct p9_rdir *v9fs_alloc_rdir_buf(struct file *filp, int buflen)
> >>         struct p9_fid *fid = filp->private_data;
> >> 
> >>         if (!fid->rdir)
> >> -               fid->rdir = kzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);
> >> +               fid->rdir = kvzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);  
> >
> > That code isn't really well thought out at all.
> > The default for buflen seems to be 128k + 24 - 24.
> > struct p9_rdir adds another 8 bytes, I'm not sure whether that doubles it to
> > 128k or just adds an extra page (which might be 64k not 4k).
> > It also looks as though the user can specify an arbitrary buffers size (min 4k).
> > So who knows how big that (and other associated) buffers actually are.
> >
> > The buffer seems to persist across readdir() system calls.
> > I can't see any code that might attempt to honour seekdir().
> > I hope there is a global lock that stops multiple threads issuing readdir()
> > on the same fd in parallel.
> >
> > 	David
> >  
> >>         return fid->rdir;
> >>  }
> >> 
> >> diff --git a/net/9p/client.c b/net/9p/client.c
> >> index f60d1d041adb..6d9b9054841e 100644
> >> --- a/net/9p/client.c
> >> +++ b/net/9p/client.c
> >> @@ -765,7 +765,7 @@ static void p9_fid_destroy(struct p9_fid *fid)
> >>         spin_lock_irqsave(&clnt->lock, flags);
> >>         idr_remove(&clnt->fids, fid->fid);
> >>         spin_unlock_irqrestore(&clnt->lock, flags);
> >> -       kfree(fid->rdir);
> >> +       kvfree(fid->rdir);
> >>         kfree(fid);
> >>  }
> >> 
> >> --
> >> 2.51.0
> >>  

