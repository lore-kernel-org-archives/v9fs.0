Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA219AA46
	for <v9fs@lists.linux.dev>; Wed, 23 Oct 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726673; cv=none; b=ZUTKjexBo3ZoW0Oz8EUsPjBPs7DlW+a/HEtO8R8kzysTAP/B5aVhC1FUl6n7paDQY9xnNtb+o1p/lfVeZ4vMIaNQM6qPIqMREAP4Iz/Xi6UWCCkNbEN+Fgaje0kiPUqlR2HeyBWwppXE7P7WMOelgAPWlQhmctIXLt759UQ5dDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726673; c=relaxed/simple;
	bh=yX27D+RCq1M+cKMacOQM9hmWAROWjed9k5qUUw8Ai5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWjekrAzLzSTCBn25UzoPSl19uOn6FeXPE0w5A7s5oeFUt/MQonniFrtKLzRo/rVTHhCSw1BoGZiIEjeWZJxlC+LDV1kMEJfO7LaLFhk98W1ZL5yZkI+hYnm1TOLSC3gEeFgyyZA3xGQqgBecxcvNSf2LEFpZGC8fj9QcrmaAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A41XDVfN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A41XDVfN"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so260366b3a.0
        for <v9fs@lists.linux.dev>; Wed, 23 Oct 2024 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729726671; x=1730331471; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tDNHn4szIeDCtAm4h7XgPn2FKXJ/QxOKxP/BtC6+w8=;
        b=A41XDVfNXrEJ+xuswS9AUoYFDXhwPJ8HA8Rdyuit+N5b0W2uGaPToKRAugBSvwECxD
         OWVP8VSu8emvGHAc3FNwF3EpS0qpd95YDy458LJXEDX05ECEbLWp18VShub2m2U7mM8P
         IQRxo/+JkZXTpss9K2N6iq93imk24MVMaRSBkJcsTCTdmWqj2TH3A+bxvftI9VwgNs9I
         WS1TIqzVevrlJDS8hr02mnVjjQ7tOpYsIwRg3tY/YTS2b63TvbMRrNulrjU9dA5FK9xK
         wiPMbLke0tRCB+6zjiql1Icx85rjqt8ZGJA3dKhAqvNh3IHnhJVnnC4VxxYTQOOUB9KJ
         Z2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729726671; x=1730331471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tDNHn4szIeDCtAm4h7XgPn2FKXJ/QxOKxP/BtC6+w8=;
        b=qU6L3o/RHKzeqa6TXoJCY70Vl9vBKrmPScSAnNr9co+qmQZlMbKT6MML4T7y0UuVN0
         YVztml/+JwWp0CcO04w5saAp8p2fPSq76KOnDEPMkrc/s3AbIg1OFUnjCns/a8QuJYaZ
         AwHH8l3BuYX4UElGCxxxB87RDFqgTWMAgIW6byp4ECUr1rBFpNLaPKtFI/fzNcIqDeq4
         6MvUOK3Gh1TMvydbGm1AJ0w24WPTN2Je6yELrbwuQ/B8KAtfb0vyA8rgvX1ty9GR6rwv
         m9YJmgZhK/Uxp38vVshjD0+rrzTlCWCRDdWBQJLigrdqFfMcZNM2LuRt30t74Sbx8TZ5
         tvkw==
X-Forwarded-Encrypted: i=1; AJvYcCVC8LU1u6HjS2j2VRVTnzg4eyu7uzQegwK2itvfsbHGdehYkLFCkVuqI47ItDLmhNqgatV6@lists.linux.dev
X-Gm-Message-State: AOJu0YwcpCn/nS/3oG4XmSw7YldZFDkDscLcXrgNmtvttxqQN+yPxYBG
	dhPtfn5yLHRL0FusKn8nLxenh3bRJvO74J0dNATsaXQAJNplLSn0tY7u8wRp89+mVfXK2MN18eG
	LYYm7OSTkfpWDCn3noyiIV0sYCkc=
X-Google-Smtp-Source: AGHT+IGOo1s4ax4V5bQjVC1PnOjuBUQiTW2HspJXMvMXVnhsiHSUOW1x6SDz1F6HKJ2gPPnMjqzQoWY2CiFzsSM1cBs=
X-Received: by 2002:a05:6a00:ccc:b0:71e:7636:3323 with SMTP id
 d2e1a72fcca58-72030a505f2mr6731861b3a.7.1729726670316; Wed, 23 Oct 2024
 16:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZxL0kMXLDng3Kw_V@codewreck.org> <20241023165606.3051029-1-andrii@kernel.org>
 <ZxmFhiAL-ImjKe7Y@codewreck.org>
In-Reply-To: <ZxmFhiAL-ImjKe7Y@codewreck.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 16:37:37 -0700
Message-ID: <CAEf4BzaAjpcGfFahFcYavBtiKJC6LHf55Q_y6i5MDfCWkU-mZQ@mail.gmail.com>
Subject: Re: [GIT PULL] 9p fixes for 6.12-rc4
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, pedro.falcato@gmail.com, regressions@leemhuis.info, 
	torvalds@linux-foundation.org, v9fs@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:24=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Adding David/Willy to recpients as I'm not 100% up to date on folios
>
> Andrii Nakryiko wrote on Wed, Oct 23, 2024 at 09:56:06AM -0700:
> > > The following changes since commit 98f7e32f20d28ec452afb208f9cffc0844=
8a2652:
> > >
> > >   Linux 6.11 (2024-09-15 16:57:56 +0200)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://github.com/martinetd/linux tags/9p-for-6.12-rc4
> > >
> > > for you to fetch changes up to 79efebae4afc2221fa814c3cae001bede66ab2=
59:
> > >
> > >   9p: Avoid creating multiple slab caches with the same name (2024-09=
-23 05:51:27 +0900)
> > >
> > > ----------------------------------------------------------------
> > > Mashed-up update that I sat on too long:
> > >
> > > - fix for multiple slabs created with the same name
> > > - enable multipage folios
> > > - theorical fix to also look for opened fids by inode if none
> > > was found by dentry
> > >
> > > ----------------------------------------------------------------
> > > David Howells (1):
> > >      9p: Enable multipage folios
> >
> > Are there any known implications of this change on madvise()'s MADV_PAG=
EOUT
> > behavior? After most recent pull from Linus's tree, one of BPF selftest=
s
> > started failing. Bisection points to:
> >
> >   9197b73fd7bb ("Merge tag '9p-for-6.12-rc4' of https://github.com/mart=
inetd/linux")
> >
> > ... which is just an empty merge commit. So the "9p: Enable multipage f=
olios"
> > by itself doesn't cause any regression, but when merged with the rest o=
f the
> > code it does. I confirmed by reverting
> > 1325e4a91a40 ("9p: Enable multipage folios"), after which the test in q=
uestion
> > is succeeding again.
>
> (looks like 3c217a182018 ("selftests/bpf: add build ID tests") wasn't in
> yet on the 9p multipage folios commit)
>
> > The test in question itself is a bit involved, but what it ultimately t=
ries to
> > do is to ensure that part of ELF file containing build ID is paged out =
to cause
> > BPF helper to fail to retrieve said build ID (due to non-faulable conte=
xt).
> >
> > For that, we use the following sequence in target binary and process:
> >
> > madvise(addr, page_sz, MADV_POPULATE_READ);
> > madvise(addr, page_sz, MADV_PAGEOUT);
> >
> > First making sure page is paged in, then paged out. We make sure that b=
uild ID
> > is memory mapped in a separate segment with its own single-page memory =
mapping.
> > No changes or regressions there. No huge pages seem to be involved.
>
> That's probably obvious but I guess the selftest runs the binary
> directly from a 9p mount?

Yep, should have pointed that out explicitly.

>
> > It used to work reliably, now it doesn't work. Any clue why or what sho=
uld we
> > do differently to make sure that memory page with build ID information =
is not
> > paged in (reliably)?
>
> Unless David/Willy has a solution immediately I'd say let's take the time=
 to
> sort this out and revert that commit for now -- I'll send a revert patch
> immediately and submit it to Linus on Saturday.
>
> Conceptually I guess something is broken with MADV_PAGEOUT on >1 page
> folio, perhaps it's only evicting folios if the whole folio is in range
> but it should evict any folio that touches the range or something?

Could be, yeah. It's not necessarily a bug of 9P itself, but it would
be nice to have some way to page out memory. Maybe we need some extra
flags or a new MADV_PAGEOUT_OVERLAPPING command for madvise(), or
something along those lines?

>
> Sorry I don't have time to dig further here, hopefully that's not too
> difficult to handle and we can try again in rc1 proper of another cycle,
> I shouldn't have sent that this late.
>

No worries, thanks for a quick reply!

>
> (leaving full text below for new recipients)
> > Thanks!
> >
> > P.S. The target binary and madvise() manipulations are at:
> >
> >   tools/testing/selftests/bpf/uprobe_multi.c, see trigger_uprobe()
> > The test itself in BPF selftest is at:
> >
> >   tools/testing/selftests/bpf/prog_tests/build_id.c, see subtest_nofaul=
t(),
> >   build_id_resident is false in this case.
> >
> > >
> > > Dominique Martinet (1):
> > >       9p: v9fs_fid_find: also lookup by inode if not found dentry
> > >
> > > Pedro Falcato (1):
> > >       9p: Avoid creating multiple slab caches with the same name
> > >
> > >  fs/9p/fid.c       |  5 ++---
> > >  fs/9p/vfs_inode.c |  1 +
> > >  net/9p/client.c   | 10 +++++++++-
> > >  3 files changed, 12 insertions(+), 4 deletions(-)
> > >
> >
>
> Thanks,
> --
> Dominique Martinet | Asmadeus
