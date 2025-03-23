Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B54C8F;
	Sun, 23 Mar 2025 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742735140; cv=none; b=QQg+WLNzfwsM1rZJPAgr3bb+/vuYbBbxui6E4giLX0mZSSLXdYH7lr2Megb9B5JcfPlATkqGrj0kDDNZZ0jYnkyREGCaBZO4mnQLtRvfNkW3q2gDWrNhFVfdRvRMkQT7d8+CgxfoGPUmtMYqWsKwjxuQ6IEJ7vEVRJY/xhztKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742735140; c=relaxed/simple;
	bh=FnGnuH4v5LYu5NfrVRzYb2uuwWRU8dSBPh3Ax4G6XLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osZ2W4f8N/eC2p2H2J19L9XiQkLQ7UwyvBBZCTUq2l//MGdMHqgrcKUssfKCj5TKJ7Bc5bKrvpszTlMUuMxoHO9IAoAjZjk6VRvN99s1z80KpRinLFLfIiF3deibV7QyLvT+NdNut20c+BoiLZEJS68fnG8AKcIHg5ETIVmU4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=LgZ3XWvn; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="LgZ3XWvn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=SG1PT6YtdkULD0AZzNIe+VWal3k+5o9YRVrkxQYxhWs=; b=LgZ3XWvnqxrpc5fhKk3FOKtNAw
	XJw06zNjZTNeHSXBkG8Fit5Tz9+fvfxaO2NayqIKokCfyYxKqdGS1EukMMtiCIXGKQjLe2C0rnooB
	zEo+F62NRP5S8zQiqdLNgvMZ3U6Adqum+wZ2nPGAxuWJ6iELYR4yvSuYfVM9P+sPk9Yak6vKSGitS
	FTzJpoNY0NaiO/+PHqcpKMUiJf7URQ278e4u1K3bEDJDbWQkDB8dIlNUglDiJf1yjroEo7kz7tPGa
	/CH65rYA3sRo8rk2500tlzedncsXxZ/J+GNQooTc02YrZ2sxw8CusPsLlziWy722ze0LqrvwSMGcy
	mVYoQ4MeqNvZuqYSeIchOk0sDiz3AzCTlASH4BE5YoqGudNdTCsxluo1GzZFjUpVp9cHifsKtvsg0
	ToBeHpJmH6DODOaY8J0fD5NKwxoQPpCfUHov6JhigorOEdONakIPtwWUxXRtEs0Pb+pQfYhzcTxXC
	IlC+4gCsx7tceixZDsa6Un59iTDlV6MVP84wh3onzw2ujtItW25mPCebvy6+dA+44TRq1h0lVciIh
	L5a5fxsOFXRcTYUcVaZfq1BWqyrjPratj6Y4dSeVKHJX6hvYz9zaiLmjVXjYCFmWIkkBSrtSy9Q3z
	KYf8nLmesx14jocP6ycCVCbsaxLecI519tZ1Dcbj4=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Sasha Levin <sashal@kernel.org>, asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Use hashtable.h for hash_errmap
Date: Sun, 23 Mar 2025 14:05:21 +0100
Message-ID: <2699178.Jt51f5JuzZ@silver>
In-Reply-To: <Z98q_K71xueitBeB@codewreck.org>
References:
 <20250320145200.3124863-1-sashal@kernel.org> <Z98q_K71xueitBeB@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 22, 2025 10:26:20 PM CET asmadeus@codewreck.org wrote:
> Sasha Levin wrote on Thu, Mar 20, 2025 at 10:52:00AM -0400:
> > Convert hash_errmap in error.c to use the generic hashtable
> > implementation from hashtable.h instead of the manual hlist_head array
> > implementation.
> > 
> > This simplifies the code and makes it more maintainable by using the
> > standard hashtable API and removes the need for manual hash table
> > management.
> 
> I'm not entierly convinced this is simpler from my little island (that's
> one more API to learn about vs code that doesn't look all that
> different), but I guess I can see the point from an overall perspective.
> 
> I see no problem with this, I'll pick it up for -next
> Note this code is not used for 9p2000l iirc so I currently don't have
> any test for it :/
> (but it's simple enough that I'm willing to take the risk)

Correct, that code is only used for legacy 9p2000 and 9p2000.u protocol
versions, but not for the default 9p2000.L version which is transmitting
numeric (Linux) error codes only (i.e. error strings are never transmitted
with 9p2000.L, hence no translation via hash map needed).

/Christian


