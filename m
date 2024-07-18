Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303F6F303
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299333; cv=none; b=PLzU3rbDcxG/LrWRgZCwawJaJjCiceMPam38sJ4yBNR64QC/KBaStiu5RgGD0ew89jXdkqqMxYXJD5OhQ50y5FNFTvYxP5K93ybsAHGOuCTuX+PSuk1qkbPeLlInCAqsSKO1LMv9ZdXh+Xzq01C/JvmthCkF8olmmvs2BqBdMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299333; c=relaxed/simple;
	bh=LPeWb1vppqzeeE511qTE25+bNnaa8s7UnwhoTEJf2yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0b2QjXA/cMZFxN9svQzKunTwLjnj4ZLd/gKtBw3e8tpfIEEx9mfDyq4st1E77TSHCo+V/vqN/XD9RWcUoiUiFegc1lTu8a64dMrVZ3rkNecW5wgMnrt2VxlpXNZJAuVXUM6rS7shY6xdZXGuNB05K8oxS8UZ3eaLo3zNBy4Qws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PxRmmr9E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u6jbTs4U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TiZiMthL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GRS3cniE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PxRmmr9E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u6jbTs4U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TiZiMthL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GRS3cniE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE7051FBB6;
	Thu, 18 Jul 2024 10:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721299329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooD7AyR6FaFtJcvLynm6ZNfEf5hh+M/xZFqC8L2UHPs=;
	b=PxRmmr9E3BBU2kLHxfSD/dZ0wXXqSYX7NJysjEcKakk/Nnvu8ncfX2Ar2Xg4h+dnSYbb4J
	GCe2ibjkCeyjKK/mvZafbl/u+bSpvCLxxZQyCVfz4ttazl/qOHXb860XUiznW5Sdir+5qU
	EEjcvXFtrQlKjhKDI+ltXEt8Zb+Lwg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721299329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooD7AyR6FaFtJcvLynm6ZNfEf5hh+M/xZFqC8L2UHPs=;
	b=u6jbTs4UEpraOg+zfZIEL/BTWNe49vDrnp31yE6LN40lXdzJQfrkFAtlTphWhGxFCHRliY
	/W8o6cq0qp74LqCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TiZiMthL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GRS3cniE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721299327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooD7AyR6FaFtJcvLynm6ZNfEf5hh+M/xZFqC8L2UHPs=;
	b=TiZiMthLMDmZ/cgmY5TnjFScr5uwHYyQWGLEW9CAgQB2Ev5GTdtlI2A2+M0IoSrOHteMgF
	HigegniSD9G0n/HsjmraMFZpIhq8h87mojUbohkNttXDcwWUSqHj+LVDruh7ag7huqNlG9
	OYADSQZXZ5dd5Vz2dVRLAYCNZAskxBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721299327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooD7AyR6FaFtJcvLynm6ZNfEf5hh+M/xZFqC8L2UHPs=;
	b=GRS3cniE1XVXCyf2tGBhcBwv+rPFV2XdtelcWwylk4p9FlF0Rg+RVJ+Jjgy8V/l4HsZ/+U
	zCw7Ih3bhrhhwWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE9F3136F7;
	Thu, 18 Jul 2024 10:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GmeILn/xmGalTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Jul 2024 10:42:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7941CA0987; Thu, 18 Jul 2024 12:42:03 +0200 (CEST)
Date: Thu, 18 Jul 2024 12:42:03 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	v9fs@lists.linux.dev
Subject: Re: hangs after merge window changes
Message-ID: <20240718104203.3auoqtj63345rapd@quack3>
References: <20240717102458.649b60be@kernel.org>
 <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
 <ZpgtXjz3pbJKUjL7@codewreck.org>
 <20240717163051.13e41526@kernel.org>
 <ZphskWZb_pkxMVvW@codewreck.org>
 <CAGudoHFzCFP04a5XfjWVaTjuFJ+Fw8XA83TWWqj-AwRbJHoiMw@mail.gmail.com>
 <CAGudoHE43w_gNNiV9YCg-tkiaORHUPuWP-_Znm2uXQtA+oS+iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHE43w_gNNiV9YCg-tkiaORHUPuWP-_Znm2uXQtA+oS+iQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,codewreck.org:email]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: CE7051FBB6

On Thu 18-07-24 06:08:45, Mateusz Guzik wrote:
> On Thu, Jul 18, 2024 at 5:54 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Thu, Jul 18, 2024 at 3:15 AM Dominique Martinet
> > <asmadeus@codewreck.org> wrote:
> > >
> > > Jakub Kicinski wrote on Wed, Jul 17, 2024 at 04:30:51PM -0700:
> > > > On Thu, 18 Jul 2024 05:45:18 +0900 Dominique Martinet wrote:
> > > > > Eric Van Hensbergen wrote on Wed, Jul 17, 2024 at 01:01:26PM -0500:
> > > > > > I held way back on adding anything new over the past cycle, so this
> > > > > > sounds likely some external change maybe perturbing an older issue.
> > > > > > What guest side mount options, qemu options and qemu version are you
> > > > > > using?
> > > > >
> > > > > Mount option if any would be much appreciated, yes.
> > > > > Also, what version you upgraded from to limit the limit the search a
> > > > > bit; the previous 6.9 tree?
> > > >
> > > > Between networking pull requests. Basically
> > > > 528dd46d0fc35c0176257a13a27d41e44fcc6cb3 to
> > > > 51835949dda3783d4639cfa74ce13a3c9829de00
> > >
> > > Thanks, this includes this commit:
> > > 7180f8d91fcb ("vfs: add rcu-based find_inode variants for iget ops")
> > >
> > > I think that's our most likely candidate at this point, adding Mateusz
> > > and others involved in Cc until I find more time to reproduce.
> > >
> > > @Mateusz, Jan, Christian - sorry if it wasn't the culprit.
> > > We're seeing new hangs in find_inode_fast between the above two commits,
> > > see the extact hang traces top of  the original mail:
> > > https://lore.kernel.org/v9fs/CAFkjPTnTDWrfCSVzvtSszjoerOeWBn8Z6DC4qFMH70Aq7Pqr1Q@mail.gmail.com/T/#t
> > >
> > >
> > > > > Also couldn't find much infos about the CI in general, given the traces
> > > > > I don't think the workload matters all that much but it can give
> > > > > something to start with e.g. running from initrd and mounting 9p or
> > > > > using 9p as rootfs; that shouldn't make a difference but might as well
> > > > > try to reproduce from something close to the actual netdev CI given the
> > > > > low reproducibility.
> > > >
> > > > What CI does is described here:
> > > > https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> > > > it's fairly simple, virtme-ng just runs kselftests inside a VM with
> > > > the host FS mounted via 9p-virtio.
> > > >
> > > > I'd offer running experiments on the exact systems, but this week
> > > > I'm partially AFK (at a conference).
> > >
> > > Thanks.
> > > You're not doing anything specific, I'll hopefully be able to reproduce
> > > it running similar workloads at which point I'll try to improve the
> > > reproducer and get a closer look if Mateusz or others didn't beat me to
> > > it.
> > >
> >
> > I think I see the bug -- find_inode_fast can race if evict calling
> > remove_inode_hash and issuing the wakeup.
> >
> > Specifically it can find the inode and only get the lock *after* both
> > removal and wakeup are done. At that point one of the set flags is
> > I_FREEING, which is a sufficient condition for it to block.
> >
> > Previously it was interlocked with the inode_hash_lock.

I agree.

> > Easiest & safest way out is for the lockless lookup to never block and
> > instead fallback to locked operation if it can't immediately get the
> > inode. Another options is to take advantage of the invariant on
> > i_state:
> >          BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
> >
> > and not fail to find the inode considering this value.
> >
> > That said let me chew on it.
> 
> I'm going to have to do dayjob stuff, will look into reproducing it
> later (if i'm correct about the bug it should be viable to add some
> artificial delays to make it triggerable much easier).
> 
> But should you repro in the meantime, the code below should do it (i
> don't know if that's specifically what I'm going to submit though):

Maybe it would be more elegant as:

diff --git a/fs/inode.c b/fs/inode.c
index f356fe2ec2b6..d0c39e71e403 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2291,6 +2291,16 @@ static void __wait_on_freeing_inode(struct inode *inode, bool locked)
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
+
+	/*
+	 * If the inode is already unhashed, evict() may be past the __I_NEW
+	 * wakeup. Return immediately to avoid sleeping indefinitely.
+	 */
+	if (unlikely(inode_unhashed(inode))) {
+		BUG_ON(locked);
+		return;
+	}
+
 	wq = bit_waitqueue(&inode->i_state, __I_NEW);
 	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->i_lock);
-- 
2.35.3

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
