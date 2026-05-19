Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3743DD87F
	for <v9fs@lists.linux.dev>; Tue, 19 May 2026 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178551; cv=none; b=aaqBm1apJH07cU+w4PWXar+OLlG2/FnppuMlJcHP7+sqDccoLQizOMnmQTm3HgMkpYALE5AC21fjl4jf6qlhCziffMCs1nt2ylBXRRchcrSG8a9w5vPrrFloeHBdLogH4QxFkuQ3VweVpzhoc5Ism4quv7O1dWwPanlEDtVMjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178551; c=relaxed/simple;
	bh=ukNhp2SUe+V00i+CScbinEy01SmNCkigc3dUv72ANDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaAwi87kLsuh+HqgyskMqV/5a7pttRU4nP5yEZFB4BgWmOBwjEy22F5XRdrVJAP3xs7inH24uEE3JOwfTT1+3plPe4d+dkZCnplpK2YuagQaxCfKHj8750LwnHXxh1Y+jbAHjjBFlGE4RxtBQ7Sw2KU1BpTvQVN1GULiJ5YY74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh8QYz50; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh8QYz50"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so2798952f8f.0
        for <v9fs@lists.linux.dev>; Tue, 19 May 2026 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779178548; x=1779783348; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq7q4q44H1XtbreNnGBa/qXoQQzGGv2LByvvEOVI2FM=;
        b=dh8QYz50TEsOAO0VU+ZLhhSfvABKBH1jC/4nuXLCRPmbYRDYxmmVC99gJFkYRY0q0o
         i6Ldg3HJLzLIO2pkSGfTHb62OI2R2bz8FUrj3ofmlQS112CfHJLLz7CyvV7jEzFfb9+3
         lGRnL9mk2cunzjM0aWjJS8h3Kkm7VU5wYbH7oVSmSvv/469wPG2XyfbQC0z0YmgrfjbE
         2IHXj+DN5Afj9Ov69RmBcAzoSz+LpcqzDr+6re9b7H5p0oNhnrFSSWG7MlCCygizV8L0
         +v/Z53jUgt7X+xoS2db+LcVTS3Hr+UM7A8XxSxdf4TIP3agb3zx+D+ellQOroUmKClSl
         gOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178548; x=1779783348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gq7q4q44H1XtbreNnGBa/qXoQQzGGv2LByvvEOVI2FM=;
        b=SW9fPmBdqoce+IlG/6oeNIbgymeF+FdH3qFjCmWxXABq+lhmVDA00H79aLusyarKiY
         Thw4aCk9X8heq+dQe+1qdY5uufas53qGCgUYcgXVJZ372FTsVgX6+vW9jKzulhyIFE66
         AADoYQ0nI9PY+wV8Iq4Sh+CK3gHiHVH2+HPfeQY1wwDpm3WnbPbwD3stcm0gK9MU8ZqJ
         qT9DBBggl/1fWPDWvoQxnPaZEqWYlTbO0bbH5n96ac/hWFQ8eQPaWLrhGKptK1F9Pep0
         4WkRscmQtuQeSLH7X4SpZJ/bu/Z/HpPuevsu6vEdm2o3i54xrftWqBJZEQVjiVFJQz9N
         ZQsw==
X-Forwarded-Encrypted: i=1; AFNElJ+8lHRDpzMTsXnHjVYRwY8QluwgsoiLxkc6sFJg6Y0gJxYlWV1Q0g1BI6QSitM1oIUKPBr0@lists.linux.dev
X-Gm-Message-State: AOJu0YyVeRwYYO+KCpI0DyxK/E0FMB/rc+GJo/mXuKvum0PRTU3Ehs5l
	DISgrIgXl0T2yWeviI3HjTbwK9I9pYeaIu3I0/VXqlJyBZsG1d6tuUMH
X-Gm-Gg: Acq92OE3XSIMQSn1hD5jUcD+p/1RP10kCztKPPsYt4gvtH7dJlOejBHu263hPC0Gnkn
	htC7scbtPG4sJrE1hyY+B3LyJrl/H6i25/Mn/KR1JMgJuZq/FtaehunStvKnclIZh6jfJ1FZd9x
	IHVyUSk6Bcz+XSKFJBHToTwXTUds7V9CDIbJdqCz2ieMnLnnpgsPPA12B/ddiVdVwHNuE6g9Ogf
	PWPM+4YaqJwkN1oliCpBwcpVFkdvS+Zt1n4cZBBFH823LJ63hXCdbwjV3zfQCk+s6X7FUEDv7mW
	4925zHDRfIVZZfc/ep3OD1rlNjg4tbfBwiczCMeDd4fzWEf755j/gVxjDIHCn0pymcCmXFahh3j
	8yddJ8OFg/zOKvAwj2nH2ge+57AIlxl/B+En0H+ukttK9jUfqgMFOVxo4XQqJgh423vA3ZSx9aY
	aPH+AoRPJkmKzzhSvSI2oWwwficLp6eSa4/d4yKxeCdqz/Y9w2Zh8554jKGPNiKZkr
X-Received: by 2002:a5d:4577:0:b0:450:b883:dd3c with SMTP id ffacd0b85a97d-45d9352412cmr26263969f8f.20.1779178547828;
        Tue, 19 May 2026 01:15:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e7c22d8b7sm14602897f8f.6.2026.05.19.01.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:15:47 -0700 (PDT)
Date: Tue, 19 May 2026 09:15:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Matthew Wilcox
 <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Paulo
 Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>, Leon Romanovsky
 <leon@kernel.org>, Steve French <sfrench@samba.org>, ChenXiaoSong
 <chenxiaosong@chenxiaosong.com>, Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Dominique Martinet
 <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, Trond
 Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/21] netfs: Keep track of folios in a segmented
 bio_vec[] chain
Message-ID: <20260519091545.171c4b85@pumpkin>
In-Reply-To: <20260518222959.488126-1-dhowells@redhat.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 23:29:32 +0100
David Howells <dhowells@redhat.com> wrote:

> Hi Christian,
> 
> Could you add these patches to the VFS tree for next?
> 
> The patches get rid of folio_queue, rolling_buffer and ITER_FOLIOQ,
> replacing the folio queue construct used to manage buffers in netfslib with
> one based around a segmented chain of bio_vec arrays instead.  There are
> three main aims here:
> 
>  (1) The kernel file I/O subsystem seems to be moving towards consolidating
>      on the use of bio_vec arrays, so embrace this by moving netfslib to
>      keep track of its buffers for buffered I/O in bio_vec[] form.
> 
>  (2) Netfslib already uses a bio_vec[] to handle unbuffered/DIO, so the
>      number of different buffering schemes used can be reduced to just a
>      single one.
> 
>  (3) Always send an entire filesystem RPC request message to a TCP socket
>      with single kernel_sendmsg() call as this is faster, more efficient
>      and doesn't require the use of corking as it puts the entire
>      transmission loop inside of a single tcp_sendmsg().
> 
> For the replacement of folio_queue, a segmented chain of bio_vec arrays
> rather than a single monolithic array is provided:
> 
> 	struct bvecq {
> 		struct bvecq		*next;
> 		struct bvecq		*prev;
> 		unsigned long long	fpos;
> 		refcount_t		ref;
> 		u32			priv;
> 		u16			nr_segs;
> 		u16			max_segs;
> 		enum bvecq_mem		mem_type:2;
> 		bool			inline_bv:1;
> 		bool			discontig:1;

There doesn't seem to be any point using bitfields.
There is a massive hole here anyway.

> 		struct bio_vec		*bv;
> 		struct bio_vec		__bv[];
> 	};
> 
> The fields are:
> 
>  (1) next, prev - Link segments together in a list.  I want this to be
>      NULL-terminated linear rather than circular to make it possible to
>      arbitrarily glue bits on the front.

Do you ever need to follow the list backwards?
If not making prev point to the pointer to the entry (probably a tailq?)
makes the logic simpler (and safer) because you can remove an item without
knowing whether it is the head or which list it is on.

> 
>  (2) fpos, discontig - Note the current file position of the first byte of
>      the segment; all the bio_vecs in ->bv[] must be contiguous in the file
>      space.  The fpos can be used to find the folio by file position rather
>      then from the info in the bio_vec.

Should fpos be off_t (or u64) rather than 'long long' (they are all the
same underlying type).

>      If there's a discontiguity, this should break over into a new bvecq
>      segment with the discontig flag set (though this is redundant if you
>      keep track of the file position).  Note that the beginning and end
>      file positions in a segment need not be aligned to any filesystem
>      block size.

At this point you lose me :-)

-- David
