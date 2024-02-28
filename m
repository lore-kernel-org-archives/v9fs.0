Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDC7E117
	for <v9fs@lists.linux.dev>; Wed, 28 Feb 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116403; cv=none; b=pQRpQrnEm97SMACVk3nwd26/068d99/402Dc1y8UETkIpglPHz7BeUfJS11rp+dLIDZ/w2UmTACBCEWsqqtnK6SxgQlFmqDvZ30caVkdc8JnlJphDhz4lBe3+sf33W+YM7CF5BDO5tBYoJSeZ3S4LAjKpWLvSexLG3kMsUYW1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116403; c=relaxed/simple;
	bh=k/fwf9gHyqqMuGvw0n7UDHhezIdjtSpBNDTqMDufBDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRhTK678ymqQlgYaa2Bl++LnkF/tqyjCbucYVsKeHpoNrjcUADUPVH6YB9HIEJMG7QQLHSq+z+axuRVpAN3QF4B4TrTKQs417oaATmwHGg2FEQaFu+3HmPBG7/fJSVtBdIccXNFOpkVwf4eXEPRPaQWs4WETPhKMKD786yYjMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so6629047a12.0
        for <v9fs@lists.linux.dev>; Wed, 28 Feb 2024 02:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709116400; x=1709721200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vRuDeubLHBjhVoVB4Akpy5PHWszldPz0jlTfUDlpHE=;
        b=NIlfCDwjEOtKlxXmJ+4JNY2Klz7DRojLKuNDh1YHk/xFRcJRF9WPgnxsMPjxcNAdi8
         hGNgw08FicdQwhbkGtnrMeqOFDHIGMLV3LvwQGRnZRHzm3gdoFKcTsDd7qWxXoQFoMBb
         3CDBtKfV41rs1SuePl1R3GMRn7A0TPiQnPI5lYUWIJWZCGN3afsD/aQA+jG3prwj//je
         +mnG8TDAN8DOXqXWwNAVLKY/6lQYuYG+MYSJvMvtpa7zihvzZcv6rhgDlDXihl/yiSLR
         e0hl5D0DReGsh+gpkXqf2DJgRqbJuyfJwCwF7NYerqddhNRAJGeWjeEr8uWTTrKdeFHG
         eMFA==
X-Forwarded-Encrypted: i=1; AJvYcCX7OjTMNJxRotx3xZfmlMTKiDsty2/wXiSeG4Zg6vHBmnm1NWc94cPY172wusmVsCZ4NLQXo/MrR9RnaN3JFYRN3ZMeKA==
X-Gm-Message-State: AOJu0YwsUEmJiBzlli5eTmvzXkNzcqZkRZhAh56YEW1B3wm8wjGM+wlw
	L1X/l75oP7oi7Lw4Xpin+1YPXljyYqI+bCggQbQPrCgYoWU6V9hF
X-Google-Smtp-Source: AGHT+IEhgRzu359A7s/c8B9M+rhMwMYC9oM9wGas2JeQjgi5a9QRx6Lx2zGJ2jflRVrgHsTKchE5WA==
X-Received: by 2002:a17:906:3cd:b0:a43:68b:6a3a with SMTP id c13-20020a17090603cd00b00a43068b6a3amr6605027eja.65.1709116400430;
        Wed, 28 Feb 2024 02:33:20 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ef3-20020a17090697c300b00a4396ea6628sm1683967ejb.210.2024.02.28.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:33:19 -0800 (PST)
Date: Wed, 28 Feb 2024 02:33:17 -0800
From: Breno Leitao <leitao@debian.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com,
	asmadeus@codewreck.org, ericvh@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [PATCH next] fs/9p: fix uaf in in v9fs_stat2inode_dotl
Message-ID: <Zd8L7RPrPpIB709o@gmail.com>
References: <00000000000055ecb906105ed669@google.com>
 <20240202121531.2550018-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202121531.2550018-1-lizhi.xu@windriver.com>

On Fri, Feb 02, 2024 at 08:15:31PM +0800, Lizhi Xu wrote:
> The incorrect logical order of accessing the st object code in v9fs_fid_iget_dotl
> is causing this uaf.
> 
> Fixes: 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")
> Reported-and-tested-by: syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Tested-by: Breno Leitao <leitao@debian.org>
