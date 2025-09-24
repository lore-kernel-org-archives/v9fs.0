Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B292557A
	for <v9fs@lists.linux.dev>; Wed, 24 Sep 2025 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755695; cv=none; b=s5rs+t12qi+JncjUb5J7oxhcbofNJCUIGLEtR+7B2WwMRMknbavi3eiU+11VLrMq30nfMaLtNh68KzInmjWF6q8ojM5kBVf1BhQgwiSzj/2CkqtUlWkEKRS0JWXmQe31ZPS+3gjc3vgPa/bPKbipf7OTB2XiTXB6TCRpDQGcInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755695; c=relaxed/simple;
	bh=FHz9QvNr3N90ksVna8Xeih/dvbD0MgQximufPDav4Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJvE/74SR1uh/1i4Lfc8ZsHE5NtPBvw3IGd3eyya91nyeRDPqeAjkrDXuKHPY0Vbf7/oBTQOSsuFnIfrZRT5heUHHfZB5SIq36JMrrRtnJaahEjRA8jR6zXMcGqoZ+YGOCY20foI7hsB8REb+PO5Vm5obqd8B39am7TzG2GOSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrNsHxwj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrNsHxwj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758755692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrpUHrdvoFbiEj+xcfKgHlliFB9WZ5o8OArit+Bt6SI=;
	b=SrNsHxwjm828X05d95n6pu7W1HN9OkSozxHajY8ExBkdLd69/tVjjoIFJTjZ1cO+KQmSxA
	EXbc0xP9qroksNc9zx3IdOEoFKfAPsnks0bCnQDAzIlwk1kFg6uhboJFIjotxR0RRnYQqf
	nJOCvMDJwN6bkhA8OMf/5DTH1S7XQ8c=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-LiJXrk3nNROCBAU6n2FAkA-1; Wed, 24 Sep 2025 19:14:50 -0400
X-MC-Unique: LiJXrk3nNROCBAU6n2FAkA-1
X-Mimecast-MFC-AGG-ID: LiJXrk3nNROCBAU6n2FAkA_1758755689
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8936161680bso42208639f.0
        for <v9fs@lists.linux.dev>; Wed, 24 Sep 2025 16:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755689; x=1759360489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrpUHrdvoFbiEj+xcfKgHlliFB9WZ5o8OArit+Bt6SI=;
        b=eyQgvDhAMw3VqIMM9UE2hS8TaCYWLa35mn8U4SggQ0Azpbf/IwJSf5AVawe9pXSKVQ
         7z4WZVRS1qkDNF07pWPByWKRB40GgnU4i4Qt4dwYqfsdX31+vA4uf6KN9d+n1ScQDd6W
         5HjHE1YgqfnSTDY0PzRnWmPjKUmBbGHNhXSzKs+1mggkAOeyQhIt6gR1d1JkmF1DY5TA
         sTgOyIJvrucl3hIEKZkISQnqhlXF6fvpRu1sLIzXsLSwEkXv7shHfUcOaMBTLPp/E/9b
         7XJgCOQvO4vhMOBJ5cCTD5XKPVADarzx8SU99hH9c5EaNdD/lRAttHIJgFnTtUPJPgSW
         vERQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNJ2Ua7kYe0fGQyZWqfnRMYswzxWyfE5AfWBBbDy+mNw8Odzi45v4c400DlxMif+1mmTDC@lists.linux.dev
X-Gm-Message-State: AOJu0Yy28V5Bfv2sHv1CIlRH1D1vmsTTEhmk5IJgS1hUp+AoJEtnVNOU
	X5+DpwBTz13QkHzSvO/GRePYGiO40FRdvRZFNK885rJ2Nz88DBCXwq8tCVXzgfRExgpou2OAE2M
	Xb98yx8KsAdxjr0UbtlsdkyH7m4TWpvWLOOKwrABCixJDZKaeJVhMid8=
X-Gm-Gg: ASbGncvAfFjKkxHsa2/y7PLU+epPZuAlyd3MrJ1FQh2FQFwg+Cc6T8/32m2C6kk+CKi
	AYRdKiSlYsW6rwn8ztN6WEketApC9r5B42dGgdrYlnTbg5ebqMu3/pwyECIhYWMsi72g5ZPXNUX
	9w9MBLqDZBE6VK4/UFpYEKd/rMwHx96oUbqov8h24dfg650+4OdvvaYk/MOXMTjsU+ZYM/1S9C6
	udChFYVAIn5DlZ5h/Cop2JMXupGactOODbKyc/7t1u74AAbLCgIMS47+QTFgY6QDHFHHCU0e2vG
	0bkxPC565Ck1lfAhsPxT9y33AJja3lAZDtWBvfC3NsHD9/7YHWAU6+JV+m2sf+6Q2NWjoUHkmQ=
	=
X-Received: by 2002:a05:6e02:4419:20b0:41f:6b74:e238 with SMTP id e9e14a558f8ab-425955d01c5mr19617585ab.1.1758755689355;
        Wed, 24 Sep 2025 16:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcZ4Y1lj47HBIrBG1qA74lTGNhKIEIZ2hG7k1V0eNNq+JbBebLEu9zatMHXAoQMSoX044Ubg==
X-Received: by 2002:a05:6e02:4419:20b0:41f:6b74:e238 with SMTP id e9e14a558f8ab-425955d01c5mr19617375ab.1.1758755689015;
        Wed, 24 Sep 2025 16:14:49 -0700 (PDT)
Received: from [10.0.0.82] (174-20-23-24.mpls.qwest.net. [174.20.23.24])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6583ef2fsm200515173.31.2025.09.24.16.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 16:14:48 -0700 (PDT)
Message-ID: <24cb212f-fac1-48c2-8418-0160f92d9d84@redhat.com>
Date: Wed, 24 Sep 2025 18:14:47 -0500
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
 lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
 syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
References: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
 <aKaW9bi5INq7OwGy@codewreck.org>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aKaW9bi5INq7OwGy@codewreck.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6kPolbx_i9GPITnGeNe_CtWTGFhw5aMX0B-EaFXA5AA_1758755689
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 10:48 PM, Dominique Martinet wrote:
> Hi Eric,

Again, apologies, not sure how I missed this as well.

But circling back:

> syzbot wrote on Wed, Aug 20, 2025 at 07:58:31PM -0700:
>> UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
>> shift exponent 32 is too large for 32-bit type 'int'
>> Call Trace:
>>  <TASK>
>>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
>>  __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
>>  v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
>>  v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
>>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
>>  do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
>>  do_mount fs/namespace.c:4138 [inline]
> 
> I thinks the mount rework triggered this one (full copy below or at [1])
> [1] https://lore.kernel.org/all/68a68b57.050a0220.3d78fd.0012.GAE@google.com/T/#u
> 
> From a quick look the old code bound msize to 4k-INT_MAX, but the new
> code accepts higher uint32 values.
> To be honest I'm not sure INT_MAX even makes sense as later allocations
> are likely to work :) but for now something as simple as this is likely
> to work (I'm not sure I got the test thing right, let's see...)
> 
> Shall I just roll that into your patch, unless you know of a more
> appropriate limit?
> There doesn't seem to be any easy to use variable about max allocation
> size, a limit of a few MB is probably sensible but I don't like
> artificial restrictions just to please syzbot so happy to defer to
> someone else here.
> 
> 
> #syz test
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 55ba26186351..cc65330ee684 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -302,6 +302,10 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>                         p9_debug(P9_DEBUG_ERROR, "msize should be at least 4k\n");
>                         return -EINVAL;
>                 }
> +               if (result.uint_32 > INT_MAX) {
> +                       p9_debug(P9_DEBUG_ERROR, "msize too big\n");
> +                       return -EINVAL;
> +               }

FWIW if we need to limit msize to a signed int, we can just change the
Opt_msize entry in v9fs_param_spec[] to an fsparam_s32 and anything
bigger should be rejected by the core parsers. The parsed value would be
retrieved via result.int_32 (vs. result.uint_32 here).

(I had seen {Opt_msize, "msize=%u"} and thought "unsigned" but missed
that it actually used match_int(). So probably a couple other spots
diverged with my patch as well, though maybe they are of less
consequence.)

-Eric

