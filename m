Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E13A545E
	for <v9fs@lists.linux.dev>; Tue, 13 Oct 2026 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885403; cv=none; b=f2lWgukjxym+dTpQARGARpe3SEf5v+oPTUU+arZ/maDFL+roedMk0y2JnEHml2490YtbJia9LGHWXwbg17WiTOpFNDjrFDJtMt1TNtlFfL42CvEwtm7rODQfoqJXPcNPCtgyunafr/kQQrokMci+DqQ6JHkrrwnTuWXdhtgRKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885403; c=relaxed/simple;
	bh=HFJ4UjRCkhaihkIH92sybsRJA7S5NLo3OntK/t8+1bY=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=PawlDWLLlXc4KtxLqZ7crqKEY5nd35bpWl1vznkAvlJFhhEJS584NBD6M0RAQB+g7on50Gn9dzeq1jGvUp1yytO3ul7VHiWgwtmwrHgimgac5rS08DrRw/YNRYNAAJklvv3VnBBKQxMWrANZAG2fnLncSfeZ56jpPLD6c38FD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innovatrics.com; spf=pass smtp.mailfrom=innovatrics.com; dkim=pass (1024-bit key) header.d=innovatrics.com header.i=@innovatrics.com header.b=mppJpghm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=innovatrics.com header.i=@innovatrics.com header.b="mppJpghm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so16280905e9.0
        for <v9fs@lists.linux.dev>; Tue, 13 Oct 2026 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innovatrics.com; s=google; t=1791885399; x=1792490199; darn=lists.linux.dev;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=St+5KkhKptBQbmhWMvm7sQZJ2JL6wlGqGqKQDJo/9iM=;
        b=mppJpghmRNl/8Le2KloMgW9wI7x+UfP51y3UAvaUgQAYE5VC06qVqHfW50df7Ko8cD
         ENzbrNWkLMW6kc0O7Nse2+8TgPe0UbGcFBMIPTgdlU+YOHqekqf92l8oD15/Ci/s6wkD
         1ztvotSn888t9+aIhzsRnU8ExlmuGNbDdGlfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885399; x=1792490199;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=St+5KkhKptBQbmhWMvm7sQZJ2JL6wlGqGqKQDJo/9iM=;
        b=U1hDSTm7jyIoP6Q18KfvQW96wlCLHEEFG90zrpYpu1mu5lX/zQhQ4LD9ZBifenwDWv
         6WKKzPveBvOOVVJhcU6THWz+/Hphfi692tz6lFaf/CFCnjOZzddsafG+6Pnkzos/XOhc
         f6h5MSV7BGRZlrDa7R0zLnM4gVbGPomU6MsPJVANE0vgjLOSpCRfVWIZC5tt/4A3m5D2
         CoBBMse3rQ6NajPKxr7hWIRdFCQ/Of/2NXYJxGPjNIRolJtrnkbPq17artkgOicnR0oy
         F6RZUQ1Oj9aW3olpHh5tbZbgIOQVFFoGlIZtaddPbfD0Vkv6qAX3RKAfLqK1rP9tsGSn
         WCmg==
X-Forwarded-Encrypted: i=1; AKwUvBxfZkgNPxcFLaGVNeXKcooNWAEshnkE1BwjXUjlAUtheBQrOcDHTawYgg/CyW5TebFGqvs0@lists.linux.dev
X-Gm-Message-State: AFq9FYLrkx7x+oRgLMqCPwzUu/oW5+Ulw1ZipiG1D/oiYCSplHISlJ7t
	Ei9l5YdFlxWUpp8+5sZ8duB5tzpGjkEjLaHo+7KAWab1CO8UTaJj1XruBWXTNqQBOQ==
X-Gm-Gg: AYBFou1tZ4tvvBijk1FtnVdYCmFKeXb9K3Ea+qM4KCM3wqCBr5BrRlV2Ej5BO851Mnl
	BBVSCOxNtGOtKKwNlfJP4JpqhsU+DU5J1+2EmFSI+2UlbcBDiwdRNILelLZUIy35eaVdJ/HqP7c
	6kUws03StW2562G3gTlIchCEiLd/LuGGsXQiBDTieyzsIY1ukZKWaAx4q29A8FlZxT+erLv9mW7
	EbsQK4fbiDIEZBBKX6qptJDFdJaeG6rMfsmHGlvBd5Mb8XIADg3GrdPQ7W0gW1I51oxSsKG9sMa
	1sKLypMvcugH9ebAwCUDMVPy7zudCB8x4nXHkmz+y3clqm6O+E4LAe7qEFzEFT/EJWPaV12Z3WG
	nPcS+A+beFVeT1ZdNX7zRME1nSG1X1Dz8q5QPbP1uz3wx9+5LwWs1oHyK9I1CodboovqRh5+r+h
	7PBgXzvsNzyTmJFS5HUTmdWKSF3G5BthWoA6kGTO4LKvLGyGh8fajQd06t5JlRnYjzd8iWR8FHd
	fMezj8Pj4UmgxEjHjDkrrXLcejc1PB5gwelTTXxcyulUdqFscXWyL+ZVyRj5tT+Uz1P2VZSxpu0
	qsw6BB4xAkKwkJcT3Iz5+yLgBIC6Sjk=
X-Received: by 2002:a05:600c:1c07:b0:4a1:b044:9ccd with SMTP id 5b1f17b1804b1-4a1b0449d00mr3292955e9.28.1791885399299;
        Tue, 13 Oct 2026 02:56:39 -0700 (PDT)
Received: from [10.11.72.5] (bip-static-148.213-81-147.telecom.sk. [213.81.147.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm289830295e9.3.2026.10.13.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:56:38 -0700 (PDT)
From: Petr Chmelar <petr.chmelar@innovatrics.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    netfs@lists.linux.dev,
    linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/5] cachefiles: Don't rely on backing fs storage map
 for most use cases
Message-ID: <20261013.cachefiles-partial-zeros-trace.pchmelar@innovatrics.com>
In-Reply-To: <1655268.1791878098@warthog.procyon.org.uk>
References: <20260910220242.2165023-1-dhowells@redhat.com>
 <20260910220242.2165023-5-dhowells@redhat.com>
 <20261011.cachefiles-partial-zeros.pchmelar@innovatrics.com>
 <1655268.1791878098@warthog.procyon.org.uk>
Date: Tue, 13 Oct 2026 09:56:37 +0000
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"

David Howells <dhowells@redhat.com> wrote:

> Unfortunately, I can't reproduce this.  Can you get me some tracing?

Thanks for looking.  The trace shows reads served from the cache over
ranges that were never written to it; details below.

I think the reason you don't see it is how the file gets into the cache,
which I should have said in the report.  In your run, fio lays the file
out through the mount, so the client fills its cache sequentially and the
object ends up CONTENT_ALL.  In ours, the client never writes the file:
it is written on the server side beforehand, and the client's cache fills
only as the client reads it, at random offsets, so the object stays
BACKFS_MAP.  That is how our training nodes use the cache: they read data
sets that they didn't write, mostly at random offsets.

I reran it on 9f8b64f66 over 9p with your tracepoints enabled, with the
same result: 936 of 4096 64 KiB blocks wrong, 825 of them zeros, first
wrong blocks 10, 13, 15, 24, 26 and 27.  I'm sending you the trace
off-list; it is 790 KB as bzip2.

What the trace shows:

 - After the random reads the object is set to BACKFS_MAP:

     cachefiles_coherency: o=00000001 SET ok   B=c4 oz=10000000 c=3

   After dropping the page cache it is looked up again (o=00000002 OK,
   c=3) and set to c=4.

 - Before the full read, WRIT TERM subrequests cover 2048 of the 4096
   64 KiB blocks, as expected for half the file.

 - During the full read, READ subrequests from the cache cover 2143
   blocks, and 936 of those never had a WRIT: the same count as the wrong
   blocks, starting with the same blocks, 10, 13, 15, 24, 26 and 27.
   For example this one read:

     R=0000285a[1] READ TERM  f=110 s=7c000 7c000/7c000 s=7 e=0

   covers 0xa0000-0xb0000, 0xd0000-0xe0000 and 0xf0000-0xf8000, and no
   write ever reached those ranges.  The writes around it were:

     R=00002291[3] WRIT TERM  f=100 s=70000 20000/20000 s=6 e=0
     R=000024dc[1] WRIT TERM  f=100 s=90000 10000/10000 s=16 e=0
     R=00002291[4] WRIT TERM  f=100 s=b0000 20000/20000 s=9 e=0
     R=000024dc[2] WRIT TERM  f=100 s=e0000 10000/10000 s=3 e=0

So for the BACKFS_MAP object, the occupancy the read is based on treats
the holes between those writes as data.

> One further question occurs to me: does the entire 256M file fit in the
> test VM's memory?

Yes.  The VM has 7946 MiB of memory with 7498 MiB available, and the page
cache is dropped before the full read.

The setup, for reference:

 - 9f8b64f66 with netfs, fscache, cachefiles, 9p and 9p fscache built in;
   QEMU without KVM, 4 vCPUs, 8 GiB RAM
 - 9p: QEMU virtfs local, security_model=none, the host directory on XFS;
   mounted with trans=virtio,version=9p2000.L,cache=fscache,msize=1048576
 - part.bin: 256 MiB from /dev/urandom, written on the host before the
   mount
 - cache: XFS on a loop device in the guest, cachefilesd 0.10.10

The trace analysis was done with LLM assistance.

Thanks,
Petr
