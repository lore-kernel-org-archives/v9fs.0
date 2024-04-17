Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD94364
	for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314527; cv=none; b=M/eBMbfA0msh7Hsz4gmlsrRRfGRXqjZV5cbr0LFPwtPQY0EMIeW+b+vXmnK5WUi7VR6gI8G6M2Pv22f3M+HqLKuF0EQydjxR0kXZb361//TW49QF8jNFtfbcMT97aWHuam/kXf8xhS8HqU+srokKRxuXd2mYRo30xT88UuPpV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314527; c=relaxed/simple;
	bh=ywKttlaKNA4oI6byxZZvaG6cjUF8Ri/eWGqbqu14V18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThTjtArUVBvixvc9nMzb44eEvDd28c2UU/JsBO/PPGIbqSB5N2iQjCyztdns2OtDoNEJwhf1vtv623MV+wifwlBjpa/fUa7Ad6jG294ryr4fmKI2x3gc7WjQlFbfknZ1MME6CTF1RaiilnAZ9vHjs6U0Pv1tMJi8UTmqjZzT1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJxhFRko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJxhFRko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDD8C4AF07
	for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 00:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713314526;
	bh=ywKttlaKNA4oI6byxZZvaG6cjUF8Ri/eWGqbqu14V18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jJxhFRkoxQOJtmT9Wa7DMmeBrgej4hioAwp09nlpYyEd4SG3xoj0LkwVx1YXF4xI7
	 6MJekEYsG/nXfGMt0plMzrnnCHGZDHk21WQMbGHal4gs19KTJNofOp91N1sQ7d2qJj
	 pUEbe0qkqjgXzJ9DU7OtlfZUsfivaMPSheV2MPF+/NuQ6Xr5coJXC2t0EuD7pDzfTM
	 ma7nJFJA/2V/AlflnvQjJYbIK7KH24mZEQPhJRckrnzePmkLBr4q0a06uu/+xi3jkW
	 4CCHM8Pt9uE1Bp14g/DuC464URHGIh+zF03+cQLRc0h4xJvzgJLDSiWkusi0uMU7l/
	 gI+St1ETyIiOw==
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-479c9c2d2b0so1535616137.0
        for <v9fs@lists.linux.dev>; Tue, 16 Apr 2024 17:42:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpiQek9q8bziKgB1iiikrN6eDOaeZeMgbBstRyESAVRA5qwh6hviXuaaYKQAom/MezIDOuER+USDs9wCmcH00wFFrkoA==
X-Gm-Message-State: AOJu0YzAcT39DhvC6fYeHtopNC3k7ZS7uKB5qWl7sSGXG5V3h83qRt5Y
	Ct2jwOBFmikzpJTOSuXKG0X3meC48NwygQV/zBQf8N4Jt1WPgDligABKSFF/0Gnba+mxOld5s67
	L+6l5GTsKOaTgatqHcNVNXIl5nWM=
X-Google-Smtp-Source: AGHT+IF9pXoq9bHs5KRnJrXrPoieXjMbpsaKxf/UrG7M1R/gVTfVYknXOvnvcm+Sa7BZ1R93YkXdAdsIbYZbXI1Ocu8=
X-Received: by 2002:a05:6102:38d2:b0:47a:40f9:5bb5 with SMTP id
 k18-20020a05610238d200b0047a40f95bb5mr16204596vst.22.1713314526044; Tue, 16
 Apr 2024 17:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
 <ZhNP4SISzZOGwy4A@codewreck.org> <A9C784B0-3B04-4EBF-8AFF-DD5088B5EF67@linux.dev>
 <74C91BF3-4BC7-46A7-9BB2-1360E07B6FE5@linux.dev> <d7164a3abce2d194041d9179a9ef153d75edb099@linux.dev>
 <ZhmbZp827i8coxit@vm3> <CAFkjPTmowPL3vSKSEveEEn9jE46Bo5wM5PXcTX98MkXzcc-zyw@mail.gmail.com>
 <0B23BE9F-87A1-4434-9191-E5FC71031892@linux.dev>
In-Reply-To: <0B23BE9F-87A1-4434-9191-E5FC71031892@linux.dev>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Tue, 16 Apr 2024 19:41:55 -0500
X-Gmail-Original-Message-ID: <CAFkjPT=E8fn+W82c+_mf8V4Ok0bJ5JxZ9S=8We3CgXW64qafaw@mail.gmail.com>
Message-ID: <CAFkjPT=E8fn+W82c+_mf8V4Ok0bJ5JxZ9S=8We3CgXW64qafaw@mail.gmail.com>
Subject: Re: ftruncate fails
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>, 
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

It's fine as a bug, I'm just making sure it wasn't part of the
regressions of some recent patches.  (those were my first priority).
I'll take a look at reproducing and see if there is something we can
do here, I haven't looked at ftruncate/fstatfs and what path they
typically take through the kernel - but we should be able to figure
out how to accommodate the open/unlink idiom but I really need to look
at the in-kernel trace and server trace to understand why you are
getting the EOPNOTSUPP which doesn't make sense to me because we
implement statfs in the client (there is no seperate path that I see
for fstatfs) (so maybe worth double checking FVP actually implemented
that in their server) -- but also need to make sure the fid it grabs
is the open fid and not try for a transient fid (although I think that
would be ENOENT, not EOPNOTSUPP).   Similar probably for
v9fs_vfs_setattr_dotl -- both of these are used to grabbing the
transient fids, not open fids -- so I may need a catch for fstatfs and
ftruncate to find an open fid on that file.

Will let you know what I find tomorrow.

        -eric
