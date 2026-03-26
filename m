Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71D3FB7CE
	for <v9fs@lists.linux.dev>; Thu, 26 Mar 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534844; cv=none; b=LuYo4ux2dQU5DKHq8wn1xJUugt5HXP1CP+SRbPKIf/1IBZgprQrwdVf1DjFuXzbryW43uybfaGKD2WJKr/yhDt2oZ4vNEcgTY7KrhFwP44NjjX/XQDNT/31BMEEdBNiXnAma/Gmb8zW2tJiRk0k77HzeOHxB+F/cMx5e28cbyxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534844; c=relaxed/simple;
	bh=4GuxjtBu05AKU6vPjLN91uKmiwjkBY146mMAHOLVBfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIYY+M+KTzrRECpIA/A8W/VgD1VAHNPyO/C0V9r6iXPDcdrp9MKFQPLcYtiOFIFapB4dY3vJhSi+F7ZaD7bgCGq0RN1uotjUW4GIpAWCWv11vCo+VgjZJrdDzO/L2q43jVQR2RfskTlpOuqEiHSBahlygXf2CsVAaLna4ujuxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=aD2KrMxB; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="aD2KrMxB"
Message-ID: <fb437a64-efa3-4284-90b3-dfff336d533b@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1774534825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GuxjtBu05AKU6vPjLN91uKmiwjkBY146mMAHOLVBfo=;
	b=aD2KrMxBMNvi7eX45TA2mMPnX+OpNAsRXdHd2hO3Y/FZBxxBH4juI5vVj9+1384jX2gnWW
	MQPGoX8eqtIORxQI5B4Ffu5wMRWB5v2OcgFpWiZ3RhsK6Tb63jJk88FVFAudIdjgyf33hA
	6UkXPdeglJvj65t97hO8QwrZml/yDEshMJijI/PNewLz/zlvnGMwIU9AC+Po5l4ttxCAY6
	W1qK3KRu13XOG4HrKN9r2OojDhQrl3iVaVmlHgl5MUG9WBBU+HQ30KfkoAVoMa7ZiLHHhQ
	V6v5O4YDl0StX6YdsEymIsoVnNdyHbqS/9J2cGDJBsD9g0au0wN5KoI4+C2Ncg==
Date: Thu, 26 Mar 2026 22:19:27 +0800
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 25/26] netfs: Limit the the minimum trigger for progress
 reporting
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
 Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-26-dhowells@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260326104544.509518-26-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

There are two "the"s in the subject.

On 3/26/26 18:45, David Howells wrote:
> [PATCH 25/26] netfs: Limit the the ...


