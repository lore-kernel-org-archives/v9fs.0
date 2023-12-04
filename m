Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B12E847
	for <v9fs@lists.linux.dev>; Mon,  4 Dec 2023 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMmp/SB6"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35d62401a3dso7229095ab.3
        for <v9fs@lists.linux.dev>; Mon, 04 Dec 2023 08:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701706847; x=1702311647; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Es+hCWrFXDwniwMcfM2dvcckNIuZXiwDz+UAIj8VFJA=;
        b=NMmp/SB6Slkl/ialX7GaCi36yVduapFKHlgHBHN5d+GL4W0+9bBRsQb4d3RWvgunTD
         0l7+2SF8HMKDSrUhHQ7TqgcGU4SF3WOrQkDW7BDot6oS2iguWvrkIRGjYcOAhpT1ToXG
         ZWEHhKmEw9mtRVMedsP/lAeIHdQBLGn2c4phDZR4dXGxD0CoVTHUJgXYOY9PU4IPoPFd
         RZ8XL9+Cf53R6fMvk1UQGsaUIQpGkgSfUDv4UQhDaui4jMR4ht+OXQQzywUnQQ+JMttc
         E9/Ol8vJqXYkdr5CkIsqGgVzVK3L3FJUT2dvTO9RojCZ9+1rA3sq5CEFhlClxWmiz5Af
         b9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706847; x=1702311647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es+hCWrFXDwniwMcfM2dvcckNIuZXiwDz+UAIj8VFJA=;
        b=OjNyu3pZS78mfeVOlw0jNc1+eloKk4vtD/PvY00akOTNbTtaBgpAPfHrcGJOwi8/yb
         d5c5fKkiNSCmrhKz0jeEWfkKaCyz338bQeX72oXa+2wy/sXGfd6tML9Ah4BX6Nw3pJWR
         YtcPk7+wWpwCDux/VKnmZ6/RPD24Elfo3vaH039kcTEDGCSkMEl6W3FF7ZNmBg0h2jIo
         1nj+h1rRKPlSvSwtoj4+KSzs+XVyIqGWe+n5q1sP8LAAo6KAJFHeCLTKeTS3BTV6qXm8
         Cb0ZG5WDWAytNkWq35mGCjcFxCLPaEK74VcaG+BlTBs+qRQ3VpylA+f5TE7HvFmYugMf
         Db+w==
X-Gm-Message-State: AOJu0YxjKEXKrjGj14Qv7+Hxg2g5jhXQywyiTrawvV+6X2SaRG1We7ya
	oCYYyIXgMAhj5Fm6zJlUVPg=
X-Google-Smtp-Source: AGHT+IEhr/y73+C8HGzgQnVsW0Y2ggL68hFdiBnBrbUv0IqcwH3zLyhK0X0PJii3PpbhwIeqJ1NM7A==
X-Received: by 2002:a92:d082:0:b0:35d:59a2:6452 with SMTP id h2-20020a92d082000000b0035d59a26452mr4564300ilh.37.1701706847586;
        Mon, 04 Dec 2023 08:20:47 -0800 (PST)
Received: from localhost.localdomain ([2601:648:8900:1ba9:692:26ff:fed8:afdd])
        by smtp.gmail.com with ESMTPSA id y24-20020a637d18000000b005742092c211sm2492261pgc.64.2023.12.04.08.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:20:47 -0800 (PST)
Date: Mon, 4 Dec 2023 08:20:37 -0800
From: JP Kobryn <inwardvessel@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>, ericvh@kernel.org,
	lucho@ionkov.net, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Message-ID: <ZW38VTs2L4vbcJLO@localhost.localdomain>
References: <20231202030410.61047-1-inwardvessel@gmail.com>
 <ZWq0BvPGYMTi-WfC@codewreck.org>
 <1881630.VfuOzHrogK@silver>
 <20231202201409.10223677@rorschach.local.home>
 <ZWva7DYTPUG95xv8@codewreck.org>
 <20231202231524.4ce1d342@gandalf.local.home>
 <ZWwS3_DGmqc73dxm@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWwS3_DGmqc73dxm@codewreck.org>

On Sun, Dec 03, 2023 at 02:32:15PM +0900, Dominique Martinet wrote:
> Steven Rostedt wrote on Sat, Dec 02, 2023 at 11:15:24PM -0500:
> > > Also, for custom tracepoints e.g. bpftrace the program needs to know how
> > > many bytes can be read safely even if it's just for dumping -- unless
> > > dynamic_array is a "fat pointer" that conveys its own size?
> > > (Sorry didn't take the time to check)
> > 
> > Yes, there's also a __get_dynamic_array_len(line) that will return the
> > allocated length of the line. Is that what you need?
> 
> Yes, thanks! So the lower two bytes of the field are its position in
> the entry and the higher two bytes its size; ok.
> It doesn't look like bpftrace has any helper for it but that can
> probably be sorted out if someone wants to dump data there.
> 
> 
> Let's update the event to use a dynamic array and have printk fomrat to
> use %*ph with that length.
> 
> JP Kobryn, does that sound good to you? I'm not sure what you were
> trying to do in the first place.
> Do you want to send a v2 or shall I?

Sounds good. I'll send out a v2. Thanks Steve for recommending the
dynamic array macros.

JP
> 
> -- 
> Dominique Martinet | Asmadeus
