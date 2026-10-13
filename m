Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82866471432
	for <v9fs@lists.linux.dev>; Tue, 13 Oct 2026 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888269; cv=pass; b=bjhwnvFuUf6TD3P5aLsLuook6Az1wiXmvkejWqR5ikymFa0Zj3W9osRJVdGOKhTGz0NgYT9Drb07kqQotCYZOU+ixc7SFwa6Jo7mSD1uQj3Kk3lmuyf6Fpf5SIFFh5SJxHM0IPjfu+B7eOb6NGVgK1BPWEf69ylevp9OQ9zxpDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888269; c=relaxed/simple;
	bh=PelTeFwd5ud7mnoUu0LqIyINYO9v9og7hyCKjE+gurc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/w+13uW3lFLJXX84XJk4qrX8SULLeG3kupk+IjcW1AbCufXH84o5JmBKQfsVUElzbJuLBlvywa6plxxQAQBD4UcfLPUwAJWBAtVZG1DhFUBHN4Hn+OgQ/b6DWbGwocl7x/aLfyXXoXxh8JMGh01Wcd98kjdqsv0UMg/2DWdwnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=OGQQQM3P; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="OGQQQM3P"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2acc1e170cso451046266b.1
        for <v9fs@lists.linux.dev>; Tue, 13 Oct 2026 03:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888265; cv=none;
        d=google.com; s=arc-20260327;
        b=YQtbVcfAH253gQZgISFb+Oud7KbOjpHaqAjS+TLGuCJoSlg3nF+qf9xirfGMR68JWB
         XCufxSRFqL8wRyZ/9q/crNpXmjN4ZSR0e2FOt96g4vr/+e//fKfLqT7Ji1HXgc1vf7Sh
         PdaBPymTiGvUkHIvrt+xtJIAknw5sudnLqebZGWceIgyhnEop+sdAD57FU8dWK2uHK2c
         s4wZ0eUs2nGO2L5XJmtHsu2JJmM0Si7CLW55Y0tOZsASZ5SYWRto8iZihEeSk745w5pb
         oJi1YfZLJJlH4fEI0T8t+gpjKibNRzl4tjlFwTvftMtaFmqwwRgPv6nnRgettWU0JB+7
         aWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VgQkjFUz0Kq5wc1rWCSsIQFYXBAR5PgY4WxoDpZtyJ0=;
        fh=btoaByZWkVvBdmWvHJVDZ9qnoH7qIblDupNwEkc0gac=;
        b=sF3oibs/PU42rMuFeAmvzA3ptXbxjnla+IfcinEDbuJvhNOhp2rcQ59hOUqmzNWbIB
         SWKOpskSIN3BikdYzEREzClnFjvCXF9aV7+y/GUFdfKawJQamQHHnlagnERMowlCFWzF
         +62ma7GaNsPlO/wriUZKe/gRCoHogOjzuMQWbzdvYngnUd4erhv4wo5KGvIb250WD+TH
         3/71oyG7Bt5Ve/OeXq/QKH7TbvdwC1hUCb2JVTVM+939bGujXql566K1F4oInAtTRhpl
         yrTU2kQ9suTK8oYllL20DMwDK5FhsEkIzdRk5CLZTvputFila7poKC24hy9E8p1ZjFZs
         znVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1791888265; x=1792493065; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgQkjFUz0Kq5wc1rWCSsIQFYXBAR5PgY4WxoDpZtyJ0=;
        b=OGQQQM3PUyu4CQ5E/1nnXNW2eBfMfrSdGachTzeKK/5T8UBmyMeOaEcIZ1ZzySM4wG
         dSiMiqmb/3FMCgyLEUQvqm0JIWz2SQAysiyAoZMIzH9JvsjQaq+Lux6qpPQ7cYKpPSd+
         1a2JDkCsPmAkRSKZOweIC9kgtgfHSMDhR8EJNV1I7Ftdl83HjWYF2wqwm/IvKwPrkCwO
         NKBeNtx766FIqVCgtgU2Yi+ddJpY7D6iS2iCs0ngdhtnNy4y4PbPSLqjccmWOpehC7zx
         MIeoqSSREAx2NCBE1RKnt70tbafuG7ep+qOYzR1QcJTKsHD6vARTF8qydb7tLFy1jQA1
         fgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888265; x=1792493065;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VgQkjFUz0Kq5wc1rWCSsIQFYXBAR5PgY4WxoDpZtyJ0=;
        b=qjDt04/u165QSFD6TbXLLYg71sm3yUkXbK2iUFFY4bZLuM35DAVfKclmw36CNZstHX
         NjxfKHsIjRW3u57iXBNelyxChpVerK4ovOqKkgYUAP7w0VTAlpOvhSE5JikAYu2B7BHH
         IO3bzblc1T82YGV+gG3XNl0bBt/WKOyT7E3i7+XVFwpBxpqC+UwCrPvl+9YRkm8uqWzJ
         03pcJYA7bzvSv2hSEUNejfgU+gVK73OzacjdityAVEBtbvRCnh0egsOJ4PDYEiptlUbY
         T+Q/UGdwRVNrWhr+555MkabLp3VRW/Ydh2+3TLMNNsjTmmsDxhcbHPOZz9zfbA90C8GV
         b+ew==
X-Forwarded-Encrypted: i=1; AKwUvBxQHIL43WJNpU8dnjcr6uPGKEhHhDFhH170Ih/MLBUHbHC7TqLzy2CKliu1GBZ9xjLeoWEB@lists.linux.dev
X-Gm-Message-State: AFq9FYKiTefe1LdRyL/B7npWiz4vX6Lvz3rY0ubfXNouf67918hYuds9
	b5x5AetqK3tJAHD9zKF5dadgrWSb87DSyPhwOEX8B9+VzIhsvIgCrpyVxYcmmXskyol1o2ZyAFL
	FIdeVlipOLr44O6i1dAKi5YoVB65d6hzQRYf7Oi2cSQ==
X-Gm-Gg: AYBFou3yJxsXsIxjCLPsowh/bH8+aGgLlerNE8uJhb92AqUqfTsSTQYWk00YLXH0wO9
	gV5GIQlVRIqK6eETHWk4alfIsplPICnA6ffu28JCUOwhb+o5fHt7Va1kDe3jZ5fGlzJCMU8eo5y
	Xsy/35q0CNqh0QVsHayOBAkiCWKqHG+A/4/t8t0kj1Eo/VTmyNhokT9uTD1uQZvPUp+xNQWeoM4
	MLlEB2O7IsdTqD/PZIc/XwzYX0LXRC8sOG1o2HpDPCHQce6lRXF17aQpi2PHc02seuF75WTc1JQ
	5uZjCXmw0mP30o44/drE0x5Zp+mO7nJEUAd/pND9H3ANbs1iyPjImKb7OB5uR54i20O6wMSbuXQ
	R0ex4o26RNN8=
X-Received: by 2002:a17:907:e158:b0:c34:e9fe:82ed with SMTP id
 a640c23a62f3a-c34e9fe8db4mr344907066b.28.1791888264638; Tue, 13 Oct 2026
 03:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260910220242.2165023-1-dhowells@redhat.com> <20261011.cachefiles-seek-hole-walk.pchmelar@innovatrics.com>
 <1655915.1791879248@warthog.procyon.org.uk>
In-Reply-To: <1655915.1791879248@warthog.procyon.org.uk>
From: Daire Byrne <daire@dneg.com>
Date: Tue, 13 Oct 2026 11:43:48 +0100
X-Gm-Features: AclHuK_oVCRmnPd9NH08Wt-JPyd6g1EMor68YJAilUyzKCf7DPZ-awFW_Pr3mM8
Message-ID: <CAPt2mGPPYTv=mBo=ysFt49t9=6AVh=P4uvHh4EwZ4Xh=ZULo=Q@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] netfs, cachefiles: Changes for next, primarily
 occupancy tracking-related
To: David Howells <dhowells@redhat.com>
Cc: Petr Chmelar <petr.chmelar@innovatrics.com>, Christian Brauner <christian@brauner.io>, 
	Paulo Alcantara <pc@manguebit.org>, Matthew Wilcox <willy@infradead.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Marc Dionne <marc.dionne@auristor.com>, 
	Stefan Metzmacher <metze@samba.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I don't know if it's particularly useful (or relevant), but we set an
extent hint size of 8MB on the backing XFS filesystem for
fscache/cachefiles.

For our workloads (mostly larger files), this seems to work quite well
in keeping down the extent counts on the cachefiles objects. It's
perhaps not very space efficient at first, but it seems to improve
over time as more data is cached.

Also, compared to XFS, ext4 seems to do a better job of keeping the
extent counts lower even without an extent hint.

In terms of granularity, I think we'd be fine with something like 256k
(as we are with 8MB). But we would still want to be able to cache a
wide range of file sizes (4k -> TBs).

We also have a particularly horrible random IO 4k workload where the
files are MBs on disk but get read in random 4k chunks over a few
hours. We specifically detect these reads and have a (readahead)
daemon that goes and reads the entire file into cache rather than
waiting for it to grow organically (in 4k chunks).

Daire


On Tue, 13 Oct 2026 at 09:28, David Howells <dhowells@redhat.com> wrote:
>
> Petr Chmelar <petr.chmelar@innovatrics.com> wrote:
>
> > The cover letter leaves non-contiguous objects, which still use
> > SEEK_DATA/SEEK_HOLE, for a later series.  We hit that case badly in
> > production, so here are numbers in case they help with its priority.
>
> I know.  But it's a tricky problem to solve as I need to store a map of the
> content somewhere.  xattrs are painful as I can only read or write them
> atomically and as whole blobs - and also I'm not sure if I need to limit the
> size of any given xattr to 512 bytes.  Further, the xattr wangling interface
> inside the kernel assumes a flat virtual buffer rather than taking an I/O
> iterator.
>
> I have patches that store a bitmap in an xattr, with 1 bit per 256K block of
> cachefile, for a 512 byte xattr able to map up to 1G of file size.  I need to
> revisit this at some point soon.  It may be better to switch to storing an
> extent list, but:
>
> > On our NFS clients (Ubuntu, v6.8, cache on XFS), a sequential read of a
> > fully cached 184 GB object with 1,080,732 extents ran at 0.4 MB/s.
>
> Trying to store a million+ extent records in a single xattr would kind of
> suck.  Now, it might be possible to collapse that somewhat if a lot of the
> extents are virtually sequential within the file, since I don't care about
> physical sequentiality.
>
> Also, can you tell if you have a preferred cache granularity?  Would a 256K
> granularity, say, use too much space?
>
> > I expect the right fix is for cachefiles to track what it has written
> > itself, as CONTENT_ALL now does for contiguous files, rather than
> > something like the above.
>
> Indeed - as mentioned above.
>
> > I can send the workaround if it's useful as a reference,
>
> If you could, that would be great!
>
> > and I'm happy to test whatever you plan for this case on our workload.
>
> Thanks.  Now I just need to reproduce your bug.  Note that I posted another
> cachefiles patch that Christian hasn't picked up yet:
>
> https://lore.kernel.org/linux-fsdevel/1091807.1791483394@warthog.procyon.org.uk/T/#u
>
> David
>
>
