Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A02EC0BD
	for <v9fs@lists.linux.dev>; Mon, 13 Oct 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343316; cv=none; b=qONsZiKheA0CxsxH4oCSfHw+CNau/yWRM3FSjlN5lZCX+lfFcD4hSnBxY8jgokJtTv931r+UZDetrYeCKcSKkFpFMPVp8YgxKdsMGzGh06CoftWv8NsE1one8k5skAezAfPMgCA+vAzsp68iFqDeG1Y1fR6dbkVHyJaOy20sCM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343316; c=relaxed/simple;
	bh=ZDF9V6SdJC6O5Ci089i93CmqQdlIvNR7SmEpklYtaiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OURJb1JML9J6KGr03s01K6x/f/sG5qttZPg3JZtF9atsoPf2mRVL9PywwSeMnKYKIvsf7zKu7j3UB3xxxZFZXr4UUd5E+5x0aWg8CJ2tRc2j5fhKp7YjIuBe5lVIRSBoIDGApI4ru+aqF4KwS1HUrCuk7SOH5X6X+4+5Ya7kHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gu7D0XjR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gu7D0XjR"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso2153104f8f.0
        for <v9fs@lists.linux.dev>; Mon, 13 Oct 2025 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760343312; x=1760948112; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=Gu7D0XjRXE2eRjRt2lPVqPH6yqn9K9izlGBQOhMvFc3JgXIx2tYc3XosThsa1bZHeG
         eAM7A8961wi2qVUIHJPGz/NdG+/Q0tVo02Sh84AVMG1MiLYSWZkXTkEv2hP21C56XRsF
         lpz0oluCnMYtujH5pOPfYwGYoACyCfvZ1X86OVcBBBPfQhzXHtkDpi3OOY8mN5SEk+b8
         a5huuWhyc1Zus0AnudzRDWWeJ/FuAuKPa2kjaV4cVwmiblu+jVU02f85D2/tDYInzZ4J
         +EyfByLSBMUiOQaoKCUzGCRROOQ7kjt3Vw6mnMNpvffSKaOpI5d162UraHgzSKXDiG9k
         4jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343312; x=1760948112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=I27gR6rRsPf7WZhl6d5jYBT4rXH6Vq09NfJ/MT6y6HTRVayoTCpd583/5tVUBjqBuu
         L6jEimcg1/JOjEefraJIUrsgA7ZsFuX68fclubBdrRNYBLEKfY1fKd50r2bKCKayk71L
         Mi4Ai0fV1NY++DcdmoUEAQfA+VYkof0GZq8BwfiN/MPj/Yrc6WC/GDvI3WvVEMqGdnAh
         oTPp3wVqirGQOR09MavTHWKl1E+HVlyOb4yNcsoA5khqGyu6x5gyl++g1QNaDFnwHcv4
         blwvic+yYJ1jfcYk0x7XlPEQgp5PvzerUXNCE+rk6PikfqYmJgAGP70Bh8iV5HKvTj6N
         Q3fw==
X-Forwarded-Encrypted: i=1; AJvYcCU9vy5BLmmd1MTTNhTNmnpkB40tRBwSC08KoIR3QeURCgsG/i+R/5qE/dw5/Y9xFHNZoE0e@lists.linux.dev
X-Gm-Message-State: AOJu0YwNREx+8l4x7P1WIfaDaW43tvg6qceFLlXfZ9JPQcmDN8V3sUzh
	qXF9tvU4Srm3K9X6bMawmhGGD7EGZ3EhpkW8trvmRLIXxl4hl7i1KurtgMgnYHyTS85kqB7y/HV
	S9MhhFfB7t8TYX6LOY4nnBYW/sbzFbKse5IOaVawgDQ==
X-Gm-Gg: ASbGncvCe7ivLF0iazD6kNqtgBq6b9ExKV95BvQ9V93xh1Ym21BK1mxtO/daS1KZWEu
	luQDrSEwJMcVr8eZN7wr9ltQXvMTV81VuuKBFmNFLAu0yTf37MgIbeE84z4qlYLB+MHfKLVdJ4H
	UvkDTfLVSa7T9i4DeWRzu0pUu8IPirDBL8mHxNb8UOhGKC4N3wk7qnjv6OTYRyCAIju7kXDpKin
	PdYE3P+QgzC+fajZ0F7VbsVXnxbqD4cHBU=
X-Google-Smtp-Source: AGHT+IEXSnK8vgh5qb4+sZ5l2hFRJWnorbBdcfDu2E4RvgYsaMIAeq5q8p6/Cp6GKDAeCkB0EX+DEBuZJrHy3pYKRvM=
X-Received: by 2002:a05:6000:430b:b0:3ed:e1d8:bd72 with SMTP id
 ffacd0b85a97d-42666da6dc9mr13043087f8f.17.1760343312390; Mon, 13 Oct 2025
 01:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-6-hch@lst.de>
 <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
In-Reply-To: <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 13 Oct 2025 10:15:01 +0200
X-Gm-Features: AS18NWCgT3XSP_MN-BMfr65K92-imDhnpGub1dZ7jpbkZ5N0Fj6p03e4QIM-oxw
Message-ID: <CAPjX3FdRvkie6XMvAjSXb4=8bcjeg1qNjYVT5KOBUDrc+H=nDQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] btrfs: push struct writeback_control into start_delalloc_inodes
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 09:56, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 2025/10/13 11:58, Christoph Hellwig wrote:
> > In preparation for changing the filemap_fdatawrite_wbc API to not expose
> > the writeback_control to the callers, push the wbc declaration next to
> > the filemap_fdatawrite_wbc call and just pass thr nr_to_write value to
>
> s/thr/the
>
> > start_delalloc_inodes.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> ...
>
> > @@ -8831,9 +8821,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> >                              &fs_info->delalloc_roots);
> >               spin_unlock(&fs_info->delalloc_root_lock);
> >
> > -             ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
> > +             ret = start_delalloc_inodes(root, nr_to_write, false,
> > +                             in_reclaim_context);
> >               btrfs_put_root(root);
> > -             if (ret < 0 || wbc.nr_to_write <= 0)
> > +             if (ret < 0 || nr <= 0)
>
> Before this change, wbc.nr_to_write will indicate what's remaining, not what you
> asked for. So I think you need a change like you did in start_delalloc_inodes(),
> no ?

I understand nr is updated to what's remaining using the nr_to_write
pointer in start_delalloc_inodes(). Right?

--nX

> >                       goto out;
> >               spin_lock(&fs_info->delalloc_root_lock);
> >       }
>
>
> --
> Damien Le Moal
> Western Digital Research
>
