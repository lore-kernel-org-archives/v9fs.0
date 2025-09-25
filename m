Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE001DE4E0
	for <v9fs@lists.linux.dev>; Thu, 25 Sep 2025 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766676; cv=none; b=bS2hTRVXSnRKbNWA9xuRKvSC8dRsoVAT94MamlKNPoSVIPwp0E3V1D05002TdlRBr1NiJ5TWPEi/El0K/7zuht1y7LlZj6c50/3R5ff0Y2scsNFymE1F/QGN30c55C0sHMXQ/D5NeIM1Pz9lMmCJP/O+EzL67kPtZF4f9OfSAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766676; c=relaxed/simple;
	bh=b0buBmbL7bhvDKCcmegp+vUX/gOszwA/zehkm3eakvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NURP7Z2pJd8IjyWnxlGTBSFmN/2Q2SNPquny30kZSrs0a9GvTUdClI0fxXFEZpOM6whGWjYvQ3DU2uUJEomraw9V4JElBwBO6Eof2VBLsIl4UOoOwi1000GSO49RUCLMYppEcvMkI0YnOZGPyNz1+yKSEYDRt+o8hSfXAuMiXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=UyGqNu7T; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UyGqNu7T"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C4DD714C2D3;
	Thu, 25 Sep 2025 04:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1758766670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNMQ8lWb9g6VQAwABshsItEru2CDZ3amHqDj+pLRKs0=;
	b=UyGqNu7ThAQ9eAuTnZ3BfOFc9UDGvzN0qHccMhl+OMsGV58nEemEWcg3OpsB72ZePd3Pp9
	nQGAYBqLYWCde0MO2Ue2JTVsrfj0MQOut+Q6BTTz/EYuKkxW0GnC0HqKsMUdHrsCHnu8sj
	LmBRpAVxVO7lbxjzVIAZ049TCXoIHvwWTC7t3L5dhpNzoeMpjvcs3y+C+gh2J4NXFxmTQY
	epQs+RO7aUWM5mlwSvkPhNXNk08h4SWrv3Be5SX53ClLLmpsnPBfo1djPjE6WGohW+eYLc
	HfUc1ss871ALSsF2bQ/l091gqpm1UtfPa/djLcjhJq+zXyVGoD1qHwUfF25/wg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c7d01c14;
	Thu, 25 Sep 2025 02:17:46 +0000 (UTC)
Date: Thu, 25 Sep 2025 11:17:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Edward Adam Davis <eadavis@qq.com>, ericvh@kernel.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net,
	syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [PATCH next V2] 9p: Correct the session info
Message-ID: <aNSmO8iou5dJ1VHq@codewreck.org>
References: <tencent_074BFE748F778366103D0B36E0971837E809@qq.com>
 <tencent_85467F89852EDEEEF58C8F67D446F592F106@qq.com>
 <aKlg5Ci4WC11GZGz@codewreck.org>
 <1edd88ee-30a8-4cfd-aa88-c181c4ab3f48@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1edd88ee-30a8-4cfd-aa88-c181c4ab3f48@redhat.com>

Eric Sandeen wrote on Wed, Sep 24, 2025 at 05:19:11PM -0500:
> > What I'm not following now is how the v9ses is created/handled around
> > the new mount API:
> > - in v9fs_get_tree a v9ses is allocated and passed along in
> > fc->s_fs_info (that this patches now uses)
> 
> This one should exist for the lifetime of the mount, and is the real,
> live session info.
> 
> > - but in v9fs_init_fs_context then a `v9fs_context` is created that
> > also embeds (not a pointer) a v9ses struct, which is accessed through
> > fc->fs_private as the code before this patch.
> 
> This one should be ephemeral, used to hold options during mount/remount.
> (see the patch description for
> "9p: create a v9fs_context structure to hold parsed options")
> 
> The idea is that the v9ses within the v9fs_context is used to hold
> state/options while parsing or reconfiguring. Its lifetime is only during
> mount/remount, and freed in v9fs_free_fc when that is done.
> 
> Before it is freed, at the end of mount/remount, the values stored in it
> are copied into the "live" v9ses in v9fs_apply_options().

Thanks for clarifying this;

I had which is a pointer and which is embedded wrong on the first
reading so I first wrote that this should be ok if we could just null
the pointer in fs_private to avoid access after the copy, but the
temporary values are the embedded ones we can't "unaccess"...
Hmm, do we need anything else in fs_private after v9fs_apply_options()?
Would it make sense to call v9fs_free_fc() early on and null the full
fs_private in or after v9fs_apply_options()?

Using a different struct tailored for mount options is certainly more
appropriate if you have the time to do it, but as long as the risk of
accessing "the wrong one" goes away I'm fine either way, so if you think
nulling fs_private is possible without too much churn I think that's
good enough.

What do you think?



> >> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> >> index f6065b5e0e5d..bcb6ebdb8037 100644
> >> --- a/fs/9p/vfs_super.c
> >> +++ b/fs/9p/vfs_super.c
> >> @@ -49,8 +49,7 @@ static int v9fs_set_super(struct super_block *s, struct fs_context *fc)
> >>  static int v9fs_fill_super(struct super_block *sb, struct fs_context *fc)
> >>  {
> >>  	int ret;
> >> -	struct v9fs_context	*ctx = fc->fs_private;
> >> -	struct v9fs_session_info *v9ses = &ctx->v9ses;
> >> +	struct v9fs_session_info *v9ses = sb->s_fs_info;
> 
> This seems correct (though we can get rid of *fc too right?) 

(Sounds right as nothing else seems to use fc)

> To get here (v9fs_fill_super), we've gone through:
> 
> v9fs_get_tree(fc)
> 	// this will be our real live v9ses for the mount
> 	v9ses = kzalloc(sizeof(struct v9fs_session_info), GFP_KERNEL);
> 
>         v9fs_session_init(v9ses, fc)
> 		// copies fc/context options in context v9ses
> 		// into the "real" v9ses
>                 v9fs_apply_options(v9ses, fc)
> 		// inits maxdata on the real, live v9ses
> 		v9ses->maxdata = v9ses->clnt->msize - P9_IOHDRSZ;
> 
> 	fc->s_fs_info = v9ses;	// real, live v9ses on fc->s_fs_info now.
>         sb = sget_fc(fc, NULL, v9fs_set_super);
> 		s->s_fs_info = fc->s_fs_info; // live v9ses on s->fs_info now
>                 err = set(s, fc)
> 			v9fs_set_super(s, fc)
> 				// assigns s->s_fs_info to fc->s_fs_info
> 				// but I think this is redundant
> 				// and should be removed

My reading is that we need it, because the super block isn't the fs
context, and we need it for v9fs_umount_begin (it doesn't help that the
field name is the same between both structs, and that some super_block
variables are just 's' and others are 'sb', but I think that's the only
place where it's used)

At this point these are both the "real live" v9ses so that should be
fine as far as I can see.

> 				*v9ses = fc->s_fs_info;
> 	                        s->s_fs_info = v9ses;
> 				return set_anon_super(s, NULL);
> 
>         v9fs_fill_super(sb, fc)
> 
> and yes, with my patch were were using the option-holding "v9ses" here,
> not the actual, fully initialized, legitimate v9ses for this mount, and
> because v9ses->maxdata is not something that gets options parsed into it,
> it was unset, and it so hit this bug. :(
> 
> Going back to the prior explanation of the fc context, it's probably
> a better idea to not re-use the v9ses struct "for convenience" and
> make a new dedicated structure just for option parsing, so unset
> structure members aren't even present and therefore inaccessible.
> I'm sorry for the mistake.
> 
> I should spin up a new version of the series fixing this and the
> uint32/int32 difference you spotted as well

That would be great!

I'm not sure the unsigned makes much different ultimately, but might as
well make it a fsparam_s32 as you suggested...
Now I understand the lifecycle a bit better I can have another read with
that in mind before merging, and we can do the nulling fs_private or
other "make sure this bug doesn't come back" later if you don't have
time, I'm leaving this up to you.

> and credit Edward for his fix in the new commit log somehow?

I've never really been sure what kind of tag is appropriate in this
case, but I assume any mention would be welcome :)


Thanks,
-- 
Dominique Martinet | Asmadeus
