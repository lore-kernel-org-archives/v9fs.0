Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1A125AD;
	Wed, 19 Jul 2023 14:17:52 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qM7zx-0001xr-1o; Wed, 19 Jul 2023 16:17:49 +0200
Message-ID: <2f873530-9c72-af23-0290-a2100df9ba56@leemhuis.info>
Date: Wed, 19 Jul 2023 16:17:46 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] fs/9p: fix mmap regression
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689776272;3309b74c;
X-HE-SMSGID: 1qM7zx-0001xr-1o

On 17.07.23 18:28, Eric Van Hensbergen wrote:
> This series attempts to fix a reported exception with mmap
> on newer kernels. 
> 
> -- original regression report --
> 
> TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
> "rootflags=ignoreqv" fixes it as well, but it feels like a regression.
>
> [...]
> 
> I could track down the breakage to
> 
>   1543b4c5071c54d76aad7a7a26a6e43082269b0c
> 
> My test setup has, in addition to the patch above, the following patches also
> reverted on top of a vanilla 6.4 kernel:
> 
>   4eb3117888a923f6b9b1ad2dd093641c49a63ae5
>   21e26d5e54ab7cfe6b488fd27d4d70956d07e03b
> 
> as 1543b cannot be reverted without those; however, the effect only goes away
> when I also revert 1543b. The kernel has no other patches applied, only these
> three reverts.
> 
> -- end bug report --
> 
> Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>

This tag afaics should be in some or all of the commits -- together with
a Link: or Closes: tag to the report
(https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/ ).

'Fixes:' tags would seem appropriate here as well. And to get this fixed
in Linux 6.4.y. a "Cc: <stable..." would be great as well.

See Documentation/handling-regressions.rst (
https://docs.kernel.org/process/handling-regressions.html ) and the
links to Documentation/process/submitting-patches.rst or
Documentation/process/5.Posting.rst for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot ^backmonitor:
https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
