Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2B101E8;
	Thu, 13 Jul 2023 11:22:31 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qJuOr-0002vb-Vr; Thu, 13 Jul 2023 13:22:22 +0200
Message-ID: <b013c216-2298-05b4-58bc-fd69e13de05e@leemhuis.info>
Date: Thu, 13 Jul 2023 13:22:21 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: mmap on 9p broken in 6.4
Content-Language: en-US, de-DE
To: Robert Schwebel <r.schwebel@pengutronix.de>,
 Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 kernel@pengutronix.de,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZK25XZ+GpR3KHIB/@pengutronix.de>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZK25XZ+GpR3KHIB/@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689247352;6852b903;
X-HE-SMSGID: 1qJuOr-0002vb-Vr

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 11.07.23 22:19, Robert Schwebel wrote:
> 
> TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
> "rootflags=ignoreqv" fixes it as well, but it feels like a regression.
> [...]
> I could track down the breakage to
> 
>   1543b4c5071c54d76aad7a7a26a6e43082269b0c
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 1543b4c5071c54d76aad7a7a26a6e43082269b
#regzbot title 9p: mmap() seems to be broken with qemu as server
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

