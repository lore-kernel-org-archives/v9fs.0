Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCF21D3A;
	Wed, 26 Jul 2023 14:07:43 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qOfAz-0000Xw-Qr; Wed, 26 Jul 2023 16:07:41 +0200
Message-ID: <44198ebe-76bc-b4b5-9426-0a65463b4a99@leemhuis.info>
Date: Wed, 26 Jul 2023 16:07:41 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mmap on 9p broken in 6.4
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: v9fs@lists.linux.dev
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <ZK25XZ+GpR3KHIB/@pengutronix.de>
 <b013c216-2298-05b4-58bc-fd69e13de05e@leemhuis.info>
In-Reply-To: <b013c216-2298-05b4-58bc-fd69e13de05e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690380463;752510c9;
X-HE-SMSGID: 1qOfAz-0000Xw-Qr

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 13.07.23 13:22, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:

> On 11.07.23 22:19, Robert Schwebel wrote:
>>
>> TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
>> "rootflags=ignoreqv" fixes it as well, but it feels like a regression.
>> [...]
>> I could track down the breakage to
>>
>>   1543b4c5071c54d76aad7a7a26a6e43082269b0c
>> [...]
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 1543b4c5071c54d76aad7a7a26a6e43082269b
> #regzbot title 9p: mmap() seems to be broken with qemu as server
> #regzbot ignore-activity

#regzbot fix: fs/9p: remove unnecessary invalidate_inode_pages2
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
