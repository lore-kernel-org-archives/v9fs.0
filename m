Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212624A17
	for <v9fs@lists.linux.dev>; Thu,  4 Jan 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWfwYbRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C86C433C8
	for <v9fs@lists.linux.dev>; Thu,  4 Jan 2024 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704383960;
	bh=vUL0D3GnJf4l9qW3ozj0rNSrFbRz7RuM7/7V+0Km/zU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QWfwYbRBN4aAszNZGqCZZ3JVG6ceYHHqrx3t6fgzoeIAHSqfiACKTe9xFAzasaZ9+
	 aVwCytuXNLfIUVM2mwqWKEGOlpV9Zuss6LD1gwfdvLML9+fKLD/VAh+ltfodr6qIXb
	 P2YKR82RurlPvqLLGCbAHJAQhzzVx+Be6Re9KBlZSrkc5MDEY1cA+HD0YGbGECE48J
	 oPMPVxeWY2WaLcy5kP3HWI5eYx7tekRNotHr/Op91KrBdk2InhJFKPUcOAB+fEsWVa
	 YAHtJh/6Bk1gn8MFvfEp8v30DVlaleMdiwD9/O7L8Y38bRbcETFFjQr953xwVbJn8N
	 KTFLILf97LFtA==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbe78430946so627062276.0
        for <v9fs@lists.linux.dev>; Thu, 04 Jan 2024 07:59:20 -0800 (PST)
X-Gm-Message-State: AOJu0Yw5LldkT82EGpQipNzp574734iRnrw5V+jIv+OAThph5D3S9Yel
	NxDo73LJdlYnbPOcXeovnaOaD42EZeHUc1G41kQ=
X-Google-Smtp-Source: AGHT+IFL4byfmaVMqxJ3Si14loa7SbWmuikeoJO86v7j0rSykaebJfsEqXmY9ivd04y0zNizgsf/zMsonCG2wxiXZ6s=
X-Received: by 2002:a5b:14e:0:b0:dbe:a6da:204d with SMTP id
 c14-20020a5b014e000000b00dbea6da204dmr644989ybp.81.1704383959767; Thu, 04 Jan
 2024 07:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZZWi6fbgy8oGwR1D@FV7GG9FTHL> <ZZXCiSlrAMI5sMr3@codewreck.org>
 <CAFkjPTnCoQXMaRXhFuzquZaKe7DFfzEEGi_Z8f7hA6Rn0wHtYA@mail.gmail.com> <2900064.uouh5yoDIQ@silver>
In-Reply-To: <2900064.uouh5yoDIQ@silver>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Thu, 4 Jan 2024 09:59:08 -0600
X-Gmail-Original-Message-ID: <CAFkjPT=aRGWVjEH5KLPxH5+qBkWXWtkMNP2Hxi-T3b6_k8nqAA@mail.gmail.com>
Message-ID: <CAFkjPT=aRGWVjEH5KLPxH5+qBkWXWtkMNP2Hxi-T3b6_k8nqAA@mail.gmail.com>
Subject: Re: cache fixes (redux)
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: asmadeus@codewreck.org, v9fs@lists.linux.dev, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"

Makes sense I guess - I'll leave ACLs alone for now.

       -eric
