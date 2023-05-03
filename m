Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563A1109
	for <v9fs@lists.linux.dev>; Wed,  3 May 2023 08:44:53 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id D4CDBC021; Wed,  3 May 2023 10:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1683103491; bh=rDa2GFnRyj0u/PaMCdh8MXpYEbFGmlro85sNxPD/eVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElKdUtHVBCkVeQSbl+UNy6iaV1G4VhujQF22VhlaRZKhI6A1qMjrS5JMnEX0ozFL5
	 oQ/8GB7uqhqj7bJmGOxZoA+ARDkOD19Gs8CA8mQULrJUknNj+RP1lNRiNhu5ANfnBk
	 4PytgsK0Mfk470n1LCZdhzWCdR8rvN8VgbtHFoIvGY4WYpN1xlIOJI31R6L7ZSKFAG
	 FumSILzqCE7T/Bea0UbpgOCwMsR2IF6deW41oEnjLHiU2BGeIMR7WiVuFd85QG7POf
	 fPYOsG5bzYFoX6l08ftQlE4W/GALROmpTr7S63Jij3ro1AtzmeLvts4KRTWyp2Nyi1
	 A2JhqJBDGoKAg==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id CC6A4C009;
	Wed,  3 May 2023 10:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1683103491; bh=rDa2GFnRyj0u/PaMCdh8MXpYEbFGmlro85sNxPD/eVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElKdUtHVBCkVeQSbl+UNy6iaV1G4VhujQF22VhlaRZKhI6A1qMjrS5JMnEX0ozFL5
	 oQ/8GB7uqhqj7bJmGOxZoA+ARDkOD19Gs8CA8mQULrJUknNj+RP1lNRiNhu5ANfnBk
	 4PytgsK0Mfk470n1LCZdhzWCdR8rvN8VgbtHFoIvGY4WYpN1xlIOJI31R6L7ZSKFAG
	 FumSILzqCE7T/Bea0UbpgOCwMsR2IF6deW41oEnjLHiU2BGeIMR7WiVuFd85QG7POf
	 fPYOsG5bzYFoX6l08ftQlE4W/GALROmpTr7S63Jij3ro1AtzmeLvts4KRTWyp2Nyi1
	 A2JhqJBDGoKAg==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id ecff0b1d;
	Wed, 3 May 2023 08:44:44 +0000 (UTC)
Date: Wed, 3 May 2023 17:44:29 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <simon.horman@corigine.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 5/5] 9p: remove dead stores (variable set again
 without being read)
Message-ID: <ZFIe7dLEncWN5YaQ@codewreck.org>
References: <20230427-scan-build-v2-0-bb96a6e6a33b@codewreck.org>
 <20230427-scan-build-v2-5-bb96a6e6a33b@codewreck.org>
 <3207385.lLoMtQYYpd@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3207385.lLoMtQYYpd@silver>

Christian Schoenebeck wrote on Wed, May 03, 2023 at 10:22:46AM +0200:
> On Wednesday, May 3, 2023 9:49:29 AM CEST Dominique Martinet wrote:
> > The 9p code for some reason used to initialize variables outside of the
> > declaration, e.g. instead of just initializing the variable like this:
> > 
> > int retval = 0
> > 
> > We would be doing this:
> > 
> > int retval;
> > retval = 0;
> 
> OK, but AFAICS this patch would simply remove all initializations. I would
> expect at least a default initialization at variable declaration instead.

Yes, clang doesn't seem to complain about 'int reval = 0' so the patch
can just be updated to do that instead; I just removed them because the
sheer number made it faster to do that.
Happy to drop this last patch for now and rework it when time permits.

> > This is perfectly fine and the compiler will just optimize dead stores
> > anyway, but scan-build seems to think this is a problem and there are
> > many of these warnings making the output of scan-build full of such
> > warnings:
> > fs/9p/vfs_inode.c:916:2: warning: Value stored to 'retval' is never read [deadcode.DeadStores]
> >         retval = 0;
> >         ^        ~
> 
> Honestly I don't see much value in this warning. Can't we just disable this
> warning for 9p code or is this just controllable for the entire project?

Dead stores in itself is a useful warning, it's what found the real bug
where return value was lost in patch 1 of this series, I don't think we
should just disable the warning.

-- 
Dominique Martinet | Asmadeus
