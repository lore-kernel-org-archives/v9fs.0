Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0280C2E6CBE
	for <v9fs@lists.linux.dev>; Thu, 25 Sep 2025 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785077; cv=none; b=rwrHAipid4Xzfv9izasnckw3SeM1LHkpndNSRJ866MZbwuEqKiEUz/gH2/VHPYYtJ+zQiL9WCCrV+AchciWA/5BRPoDEVkX6YkgR+mJHdSCecCJICKPfRKjtQKqAGEgh7viLad8YzCkdsMPNw7HCbrKtcm20OPiHuSoX3HOmck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785077; c=relaxed/simple;
	bh=gXkC48jZEfx26QB8BC/bIEiwPwA7tHHefTHOyazdGUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br4cX9+rAg209dqd0cyU6vBW3AmtEPIdjv+Kpuchx6AOvVMAkILGJMKUdkPSupXIDY6jRol4vbfZ0Ua8u6tcgWruzaPNM3GdhEspYv7S7uF7aDXrLHBUG4ARzHndj9Kp3nZaC8lid25SjNUzVoBRc+kCaA068cwSElbaf628nm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Ozzw1ei2; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Ozzw1ei2"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0809014C2D3;
	Thu, 25 Sep 2025 09:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1758785068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WI9AYV+82PBrcw5NdTsFHSifmbsZ04mfKgfiRuz3TZk=;
	b=Ozzw1ei2SNuqyisGytcqz4ZhjWAL1KKfd1OmmmVBBO3OSSnzN1fzP/X64c0kA7v3oDzv3E
	W9par3r/fRtikXfQZEJ0wa8LFTX6yimExg3OLgxExYszVqKYaiqtG1KC3LSQAahjbzx/NH
	1e9j9sCloCpm1pA4TuVNq/qmAB6jvSrYC88WjediT23kZr/OW3sO9wsmJc2JwQLzcDwUr4
	GqerXuEt6wUupmmkgwRKQZy+txL1Li5/OagDOnW2fpqLISSiwKVxyo99QenUB+0AiDPt8+
	VK1+nu+3+tf+XwzFfsgTViiCp2414zdXoKIvTcnSWFlCr4cQhibliAg726BGzA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0d3338cf;
	Thu, 25 Sep 2025 07:24:24 +0000 (UTC)
Date: Thu, 25 Sep 2025 16:24:09 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Edward Adam Davis <eadavis@qq.com>, ericvh@kernel.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net,
	syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [PATCH next V2] 9p: Correct the session info
Message-ID: <aNTuGdJwihpa3Ixh@codewreck.org>
References: <tencent_074BFE748F778366103D0B36E0971837E809@qq.com>
 <tencent_85467F89852EDEEEF58C8F67D446F592F106@qq.com>
 <aKlg5Ci4WC11GZGz@codewreck.org>
 <1edd88ee-30a8-4cfd-aa88-c181c4ab3f48@redhat.com>
 <aNSmO8iou5dJ1VHq@codewreck.org>
 <45072767-8ed5-4abc-895b-9a4f5429bd3e@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45072767-8ed5-4abc-895b-9a4f5429bd3e@redhat.com>

Eric Sandeen wrote on Wed, Sep 24, 2025 at 11:29:16PM -0500:
> On 9/24/25 9:17 PM, Dominique Martinet wrote:
> > Using a different struct tailored for mount options is certainly more
> > appropriate if you have the time to do it, but as long as the risk of
> > accessing "the wrong one" goes away I'm fine either way, so if you think
> > nulling fs_private is possible without too much churn I think that's
> > good enough.
> > 
> > What do you think?
> 
> I think that in retrospect, (ab)using the full v9ses was a poor choice by
> me, it clearly caused confusion (for me!)

I definitely won't complain if we get a dedicated struct :)

> > My reading is that we need it, because the super block isn't the fs
> > context, and we need it for v9fs_umount_begin (it doesn't help that the
> > field name is the same between both structs, and that some super_block
> > variables are just 's' and others are 'sb', but I think that's the only
> > place where it's used)
> > 
> > At this point these are both the "real live" v9ses so that should be
> > fine as far as I can see.
> 
> I said remove because sget_fc() does s->s_fs_info = fc->s_fs_info, and
> then v9fs_set_super essentially does s->s_fs_info = fc->s_fs_info again,
> so I think it's redundant but I'll look again when I'm less sleepy. 

Ah, I had missed the setting in sget_fc() -- you're right, we should get
rid of the one in v9fs_set_super()
(or actually, get rid of v9fs_set_super altogether and pass
set_anon_super() directly to sget_fc())


> > Now I understand the lifecycle a bit better I can have another read with
> > that in mind before merging, and we can do the nulling fs_private or
> > other "make sure this bug doesn't come back" later if you don't have
> > time, I'm leaving this up to you.
> 
> Sounds good. Thanks again, and sorry for somehow completely missing this
> thread earlier.

No worry, I should have re-sent a ping earlier as well.

> (Assume we've missed this merge window by now, so I probably won't rush
> on this but will try to do it sooner than later.)

Alright, I don't think we want to rush this, so let's get this next
cycle :)

Thanks,
-- 
Dominique Martinet | Asmadeus
