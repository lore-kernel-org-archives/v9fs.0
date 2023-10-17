Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6954175D
	for <v9fs@lists.linux.dev>; Tue, 17 Oct 2023 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="Vth5G0bN"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d84c24a810dso6458872276.2
        for <v9fs@lists.linux.dev>; Tue, 17 Oct 2023 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1697539408; x=1698144208; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OmZ/33TllYLHL47d/dVmhdUXpMsytcSlpt83kTPbFEw=;
        b=Vth5G0bN6pZeYHLJ5WSyUlpKeoTCNmqMnlKsBrsVWrNv2EAzF181OvRFaoHpbrSgUY
         C70XzU7c6iu+IhmXjYzFg82u1669sx6yjr+TdNzTcWXK/51r3v4+fk9n22RT4Zs1zTOl
         6ZgPRHFrbsAgf1Nk/1HzhG3VoWrB89iEEXNiWiKvoQfEg2H4Xpkl9P6m+cIRVUkaFGvV
         SwotzDRspuGJg7nHaJ63DpzZgJrtAdl0Xn5kxs2nf4dBjyYMEovds1EFg/q6eP+wLaCT
         f+d+RFG3s6GKmOcalYkl9WCNJ0sypfG/4NQa6nkzxQiHuiud31ez9BLrpLyqGrKF6wqJ
         uAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697539408; x=1698144208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmZ/33TllYLHL47d/dVmhdUXpMsytcSlpt83kTPbFEw=;
        b=xMkE4jwaozCKDVR26b7TZAaFHBlblL2BVMZxYBZjbGUrL/yEQzeU16YghT1nZ3Bi85
         Qb4xTmhLNkH+6LFzK+weL8FoVbS65K1RaVatjP6Ysx01Vs4YWQCuFJDXF7e5sX+v/4uP
         agy4yil4ksSqz+vcy9eLx8GYk0nUr0dAawLUJ0a22/VmAbkYuO+YE252TaYW8HMAqclU
         N4+cm2f2wPnsfkTPXRDnsyRwW9We2Q6pac0Xd5XLP7v83oLsKQ4u7UxBmd+ImpW7JNRH
         GG81tKjGGMLREOtpEq0mH0Pzst0IVNFmwmOfI2CeHSbLTP78QXwqCDJIhp0v7QnXUXi0
         4B6A==
X-Gm-Message-State: AOJu0YwaO1b6/+AGhC3dYAqnGZNmgR7mfiriADDAm1FByh1z1r0pTSSG
	FuI7IDwSygTVX70dXjRJbPoUwOXE9wWirDyPSEp8/Q==
X-Google-Smtp-Source: AGHT+IEguG9VkvSZyN+YQKkbnzU4bPPMH68Gm77P3bS20bpQvkVCehXFFJFu9p/7GSuuBt2Sz4dkmWLIuiXDJ62NRdc=
X-Received: by 2002:a25:cd44:0:b0:d9b:6c9d:e6a with SMTP id
 d65-20020a25cd44000000b00d9b6c9d0e6amr1563929ybf.0.1697539408286; Tue, 17 Oct
 2023 03:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231013155727.2217781-1-dhowells@redhat.com>
In-Reply-To: <20231013155727.2217781-1-dhowells@redhat.com>
From: Daire Byrne <daire@dneg.com>
Date: Tue, 17 Oct 2023 11:42:52 +0100
Message-ID: <CAPt2mGNpo0Uw0Ud18N4dV=ojoGK-xyj1P29tzWEhZw0i4FNVPg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/53] netfs, afs, cifs: Delegate high-level I/O to netfslib
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Marc Dionne <marc.dionne@auristor.com>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Christian Brauner <christian@brauner.io>, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Oct 2023 at 16:58, David Howells <dhowells@redhat.com> wrote:
>
>  (2) Use of fscache is not yet tested.  I'm not sure whether to allow a
>      cache to be used with a write-through write.

Just adding a quick end user "thumbs up" for this potential feature.
We currently use fscache as the backend for "NFS re-export" servers to
extend our onprem storage to remote cloud compute (which works great).

But batch compute hosts (think VFX render farm) often chunk up stages
of work into multiple batch jobs such that they read data, write
results and then read the same data on different clients. Having the
ability to also cache the recent writes closer to the compute clients
(on the re-export server) would open up a lot of new workload
possibilities for us.

>  (5) Write-through caching will generate and dispatch write subrequests as
>      it gathers enough data to hit wsize and has whole pages that at least
>      span that size.  This needs to be a bit more flexible, allowing for a
>      filesystem such as CIFS to have a variable wsize.

If I understand correctly, this is above and beyond the normal write
back cache and is more in tune with the wsize (of NFS, CIFS etc) for
each file? Again, our workloads are over longer latencies than are
normal (NFS over 200ms!) so this sounds like a nice optimisation when
dealing with slow stuttering file writes over high latency.

I can definitely volunteer for some of the fscache + NFS testing.

Cheers,

Daire
