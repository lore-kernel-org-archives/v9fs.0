Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084BD27448
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304982; cv=none; b=pLcfeRIsl+Mw3X6yylhlHAAcoJfH6sc4SQOr60Dd/y7m3tF6vuHAhUdbP1b+NY6f1srIY8ZkpSPuXljDObT6uQ8wfWBrvLTxxgr8N6Dwjh3GXa3u8D8RAz6DXGY2mT+00H77vUk6Fku4MYd1jk8B3Lyg8ryM9bAkCH+vnkYe+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304982; c=relaxed/simple;
	bh=7A++chr40GRcIZ+US/cPFuhsAh5QiiGvUJdU006yz0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Amyv8n/dE24gYwqz8oAYzNEn2Rth0o17c5n6bA6irvaoCRbcwQJZYmg2/6BDNqzT1nsDgp2j0b8RxT6Aft2pB8r2YzVf0k1f8HrtGkUkhdnfbvPFus8dJxVC2YGJkJQNtQjxzQIg0NnDNqdQ/TpcSb3th3JZVfhXvDXjQ/1GedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ossOpath; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kqSN6YC6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KqN8ZxvF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=++YPsFJJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ossOpath";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kqSN6YC6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KqN8ZxvF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="++YPsFJJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F22221FBCD;
	Thu, 18 Jul 2024 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721304979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxX3PiUMaaUkMtmLDxrgygfbOzHie0o5/1+shLRtqaA=;
	b=ossOpath2AnGdV+Zx6ximgWm1tjxD3kt5Ueng5AZOv7glIoVjxNqRZR0iTKe2B46lEiz1C
	se8FBKXyWEPjo8VVSACbv3x50WsRWmrbTHDgknI1vjo7isi/3GFByI1R0UqwcC1stlLjuN
	/jqnrjxpVWFkAad3NKk3ZIrfNXSp0ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721304979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxX3PiUMaaUkMtmLDxrgygfbOzHie0o5/1+shLRtqaA=;
	b=kqSN6YC6ScjvdLC0pcJwPq8VxGGdKfWwUPTPTjVEOLWtTdvbHO4eQh/zlPy8RvM9No1b3P
	QgIkycDTDYPnRyCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KqN8ZxvF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=++YPsFJJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721304978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxX3PiUMaaUkMtmLDxrgygfbOzHie0o5/1+shLRtqaA=;
	b=KqN8ZxvFFXUG4XLQe2DewwF2nE1d2mv1P9J8ovmtzx2hu+C3YoYVYTHktiNhzAyRB7Omx1
	LjWWtPcKQGXtOsnTWcEpK/+W11vWKOuYKPLq1P7x6X1BD0s8W0tKLhKOVcPAtBqKNbapNm
	97iLmd3cqBi42i17y4L63ETRG/FK5yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721304978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxX3PiUMaaUkMtmLDxrgygfbOzHie0o5/1+shLRtqaA=;
	b=++YPsFJJJka3NdJ85KDdej30loou5n57CksjYdler7uktoZquu0a/dcNeBZLh8P37AcLsv
	Jyy4m/O3ipht2tAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3A491379D;
	Thu, 18 Jul 2024 12:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FO+JN5EHmWY/bQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Jul 2024 12:16:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8EE90A0987; Thu, 18 Jul 2024 14:16:09 +0200 (CEST)
Date: Thu, 18 Jul 2024 14:16:09 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Dominique Martinet <asmadeus@codewreck.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev
Subject: Re: hangs after merge window changes
Message-ID: <20240718121609.rtowlgt6ydmz44zf@quack3>
References: <20240717102458.649b60be@kernel.org>
 <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
 <ZpgtXjz3pbJKUjL7@codewreck.org>
 <20240717163051.13e41526@kernel.org>
 <ZphskWZb_pkxMVvW@codewreck.org>
 <CAGudoHFzCFP04a5XfjWVaTjuFJ+Fw8XA83TWWqj-AwRbJHoiMw@mail.gmail.com>
 <CAGudoHE43w_gNNiV9YCg-tkiaORHUPuWP-_Znm2uXQtA+oS+iQ@mail.gmail.com>
 <20240718104203.3auoqtj63345rapd@quack3>
 <CAGudoHEoqrCgQ8=N+ioFegA-toRjTE+XvLdbtAqsvqhLuTLmNA@mail.gmail.com>
 <CAGudoHE6qMb=+-a-DGHVB3CB=ZyjV7uj17uWYqEfnB9wbgNW2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHE6qMb=+-a-DGHVB3CB=ZyjV7uj17uWYqEfnB9wbgNW2w@mail.gmail.com>
X-Rspamd-Queue-Id: F22221FBCD
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Thu 18-07-24 13:40:14, Mateusz Guzik wrote:
> On Thu, Jul 18, 2024 at 12:57 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Thu, Jul 18, 2024 at 12:42 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 18-07-24 06:08:45, Mateusz Guzik wrote:
> > > > > Previously it was interlocked with the inode_hash_lock.
> > >
> > > I agree.
> > >
> > > > > Easiest & safest way out is for the lockless lookup to never block and
> > > > > instead fallback to locked operation if it can't immediately get the
> > > > > inode. Another options is to take advantage of the invariant on
> > > > > i_state:
> > > > >          BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
> > > > >
> > > > > and not fail to find the inode considering this value.
> > > > >
> > > > > That said let me chew on it.
> > > >
> > > > I'm going to have to do dayjob stuff, will look into reproducing it
> > > > later (if i'm correct about the bug it should be viable to add some
> > > > artificial delays to make it triggerable much easier).
> > > >
> > > > But should you repro in the meantime, the code below should do it (i
> > > > don't know if that's specifically what I'm going to submit though):
> > >
> > > Maybe it would be more elegant as:
> > >
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index f356fe2ec2b6..d0c39e71e403 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -2291,6 +2291,16 @@ static void __wait_on_freeing_inode(struct inode *inode, bool locked)
> > >  {
> > >         wait_queue_head_t *wq;
> > >         DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
> > > +
> > > +       /*
> > > +        * If the inode is already unhashed, evict() may be past the __I_NEW
> > > +        * wakeup. Return immediately to avoid sleeping indefinitely.
> > > +        */
> > > +       if (unlikely(inode_unhashed(inode))) {
> > > +               BUG_ON(locked);
> > > +               return;
> >
> > this is missing spin_unlock(&inode->i_lock);
> >
> > > +       }
> > > +
> > >         wq = bit_waitqueue(&inode->i_state, __I_NEW);
> > >         prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > >         spin_unlock(&inode->i_lock);
> > > --
> > > 2.35.3
> > >
> >
> > Putting the check here was my first variant, I don't have a strong
> > opinion on this front. Whatever immediate fixup can get massaged. For
> > something to actually commit I was thinking a little nicer, see below.
> >
> > While the bug being here is on me, I do think the current state
> > avoidably facilitated it by implicitly depending on the hash state.
> >
> > In evict() you can find:
> >         spin_lock(&inode->i_lock);
> >         wake_up_bit(&inode->i_state, __I_NEW);
> >         BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
> >         spin_unlock(&inode->i_lock);
> >
> > This should probably move to a dedicated routine to pair up with
> > __wait_on_freeing_inode (and yes, I know there are other spots which
> > wake up based i_state) -- this much could be done in the fixup. It
> > would also asserts on the unhashed condition so it would be apparent
> > this is the invariant for (dis)allowing sleep.
> >
> > Longer term imo it should have something which provides the definite
> > "no wakeups past this point" indicator not dependent on the above,
> > maybe a dedicated i_state flag combination.
> >
> > This brings me to lack of VFS_ debug macros which would allow for
> > generous sprinkling of asserts without affecting production kernels --
> > someone(tm) should look into it.
> >
> > I'll try to find some time in the evening to repro and validate that
> > this is indeed the issue though.
> > --
> 
> Now that I had some caffeine I see we both messed up here -- bailing
> on the unhashed status without I_FREEING is not necessarily equivalent
> to doing this after, so the check indeed should land in
> __wait_on_freeing_inode.

Yeah.

> That said, assuming testing passes later, I'm going to submit this
> (with maybe some word-smithing):
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index f356fe2ec2b6..e1082d61c093 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -676,7 +676,18 @@ static void evict(struct inode *inode)
> 
>         remove_inode_hash(inode);
> 
> +       /*
> +        * Wake up waiters in __wait_on_freeing_inode().
> +        *
> +        * Lockless hash lookup may end up finding the inode before we removed
> +        * it above, but only lock it *after* we are done with the wakeup below.
> +        * Should this happen there will be noone to wake the waiter.
> +        *
> +        * Use inode_unhashed() status as an indicator whether blocking there is
> +        * safe.
> +        */
>         spin_lock(&inode->i_lock);
> +       BUG_ON(!inode_unhashed(inode));

So this is going to trip on XFS I'm afraid. XFS is not using VFS to hash
inodes and sets inode->i_hash through hlist_add_fake() and
remove_inode_hash() does nothing for it. So XFS inodes return
!inode_unhashed(inode) all the way until they are destroyed. Now this is
fine because these inodes have no way to get to __wait_on_freeing_inode().
Also the !inode_unhashed() check looks a bit weird just a few lines below
remove_inode_hash() so I'd just drop this check.

Otherwise the fix looks good to me!

								Honza


>         wake_up_bit(&inode->i_state, __I_NEW);
>         BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
>         spin_unlock(&inode->i_lock);
> @@ -2291,6 +2302,16 @@ static void __wait_on_freeing_inode(struct
> inode *inode, bool locked)
>  {
>         wait_queue_head_t *wq;
>         DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
> +
> +       /*
> +        * Handle racing against evict().
> +        */
> +       if (unlikely(inode_unhashed(inode))) {
> +               BUG_ON(locked);
> +               spin_unlock(&inode->i_lock);
> +               return;
> +       }
> +
>         wq = bit_waitqueue(&inode->i_state, __I_NEW);
>         prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
>         spin_unlock(&inode->i_lock);
> 
> -- 
> Mateusz Guzik <mjguzik gmail.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
