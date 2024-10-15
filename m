Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E728691;
	Tue, 15 Oct 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015653; cv=none; b=HRxifj/EBFl1GBRGadurIQ9ewjEUUr5weQBXcsE1d6DB7eRtaSTOS3s74t1Oa86GbqEZceiE+o8kT58zVbsUeAA6KE5O5tyFY8liPqp3SMGvvv/OTM+tq/dPhrSDR+00Hwh1w/82l13qZ183ub9F+PCuXGrwveS4ZPD4UxZKobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015653; c=relaxed/simple;
	bh=6aynL6Gig9/U+p30VyRE1uYq8pO0zyWR2gG4OF1dUec=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WnfkYQh5qC08SThdLZBi89iAI9DjLlzHQOy5rpJOajsjb3QgUwB0mQenY1HFibSJ6UGtGcbLCM2I+zbNQC9IkykR5jmE7MeUbwmA/K5dgcPSor15yE4oYUrKd+IwHdC0PEiu0H+jQrge59+LHNmDT1kLTzoozMlFgbcVTE2kiaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dNHcsg7+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dNHcsg7+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0rmEo4AJN9UfaY3o7MBm7HGCI98gYY0kjy7UDjni+VU=; t=1729015651;
	x=1729447651; b=dNHcsg7+QPHr8UnKkQqQGETrgh+2+aIFNTCmxBFp5AKfxfY6/jwGLn7RZFXLy
	2t9m0rhP8WIDrH6yW7MDaQ6NOExx59DjlAPwgTBG6RJ6i2hN99ntKAHPTUq7DGwi7HpzPAh2EHKL+
	5EwTw3PB+/yRYZb302qYXpG0wCZvWrst1+YtT0DbNrnr9gmzcBPgtuzfGRH5vuvXxdstbKAKMAQ61
	OI0pC3iQuDg99mWFokxSa/tpxsFHVGKCt8BsakOGjBlSm8W4f2JK2bec9jZW3A4K8m8DFFF1sYF3H
	oSiyFo6oAqsV4hW61cG05O3VTLydafU/nECWtNv8AtYiuclcfw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t0lx3-0003rt-Io; Tue, 15 Oct 2024 20:07:21 +0200
Message-ID: <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>
Date: Tue, 15 Oct 2024 20:07:10 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
To: Will Deacon <will@kernel.org>, ericvh@kernel.org
Cc: lucho@ionkov.net, asmadeus@codewreck.org,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, oss@crudebyte.com,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com,
 keirf@google.com, regressions@lists.linux.dev
References: <20240923100508.GA32066@willie-the-truck>
 <20241009153448.GA12532@willie-the-truck>
Content-Language: en-US, de-DE
In-Reply-To: <20241009153448.GA12532@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729015651;9022dc2e;
X-HE-SMSGID: 1t0lx3-0003rt-Io

Hi Will! Top-posting for once, to make this easily accessible to everyone.

Thx for bringing this to my attention. I had hoped that Eric might reply
and waited a bit, but that did not happen. I kind of expected that, as
he seems to be  somewhat afk, as the last mail from him on lore is from
mid-September; and in the weeks before that he did not post much either.
Hmmm. :-/

CCed Christian and Al, maybe they might be able to help directly or
indirectly somehow. If not, we likely need to get Linus involved to
decide if we want to at least temporarily revert the changes you mentioned.

Ciao, Thorsten

On 09.10.24 17:34, Will Deacon wrote:
> On Mon, Sep 23, 2024 at 11:05:08AM +0100, Will Deacon wrote:
>>
>> I'm trying to use kvmtool to run a simple guest under an Android host
>> but, for v6.9+ guest kernels, 'init' reliably fails to run from a 9pfs
>> mount because VFS emits this error:
>>
>>   | VFS: Lookup of 'com.android.runtime' in 9p 9p would have caused loop
>>
>> The host directory being shared is a little odd, as it has symlinks out
>> to other mount points. In the guest, /apex is a symlink to /host/apex.
>> On the host, /apex/com.android.runtime is a mounted loopback device:
>>
>> /dev/block/loop13 on /apex/com.android.runtime type ext4 (ro,dirsync,seclabel,nodev,noatime)
>>
>> This used to work prior to 724a08450f74 ("fs/9p: simplify iget to remove
>> unnecessary paths") and it looks like Oleg ran into something similar
>> before:
>>
>>   https://lore.kernel.org/all/20240408141436.GA17022@redhat.com/
>>
>> although he worked around it by driving QEMU with different options.
>>
>> I can confirm that reverting the following commits gets mainline guests
>> working again for me:
>>
>> 	724a08450f74 "fs/9p: simplify iget to remove unnecessary paths"
>> 	11763a8598f8 "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
>> 	10211b4a23cf "fs/9p: remove redundant pointer v9ses"
>> 	d05dcfdf5e16 " fs/9p: mitigate inode collisions"
>>
>> Do you have any better ideas? I'm happy to test anything you might have,
>> since this is 100% reproducible on my setup.
> 
> Adding the regression tracker as I've not heard anything back on this :(
> #regzbot introduced: 724a08450f74
