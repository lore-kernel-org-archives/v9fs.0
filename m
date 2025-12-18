Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6228469B;
	Thu, 18 Dec 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055295; cv=none; b=ogrw6O98a5mf4Vn6na2rw6P3BA5FMqG6SSKe7yRmyrYFSh/Ptvt37izzM952S2huVlANUkQa1AG2hj4c88L6DL1dqZvi60eSposIPFfG/BIG9IqWlZ6qH6CJ8GdRvUHAMT007tV5UkT+gpRAVUg7CIeUcoxlLtL9KoqzD+RvmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055295; c=relaxed/simple;
	bh=9xIXtFFLXyxiEixD/DKSujUGOHWDORq1gGGXPCIYw5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyxY7qHhSOFQSCtf4od0Oqv7kNB2xJSQx9qYgQyOww0Af55R1z7E2TkB5eANoAtVIss9NO/S9dYibYFOWZvzQdLq2JJ1UzpqbPnbHL1uV+VKdGibLRw092+dISrxED2VGoUKY6S0ELYS8ERdYoTdfw9BrwyWP42umpnqr6MsWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=JWPBgL8m; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="JWPBgL8m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=VXgAcE4wz+awHxHju7k9V7hkpzFyIPTpkULF20bCZ5g=; b=JWPBgL8mH3c78b9pHnybHVEtP+
	sdreUB+9ul3LmiXxg3Kcxjt+sg70ssRO/r09ERCoqSYdmhJknLJrHZiQeaCLD7/z2TNrJtYkVFMU+
	616rjimCRHfPGxWVE2LqFMbvqy/cP7SoKBVj0njKgK01axOgcho03jXSZ+5H028U1gIzWBb+JgINl
	ilJhHcSWBvu3CaVNyxQ3C7VY7LqsovAKe7KTjQHuoR4gUNwx4pKf+oJdW7uln/e11JMYcOy0eYRm2
	eWIyILE9PSqv1uWRmR342nCdvhQm0kv0k5W5jWDPGAJb2gai8TeoVkrUSDEemfDsODEkMjy2i2sjZ
	0Big83yZCRNy9X21bCdvKLA+fdiG+m5eiotTZvbZtz2EDXa0K+1vVuUcHtVNBCWkSHu1tW2JKsQdl
	YbGRq7++NjRuBHkiAiMFvFS8DYqjm8MPy5PRIVS4vF01KjVqRmpHT3tle06lg4R22TTTMCC1kkWGX
	la8iKF+rlGi0GQ7jM2VodVgBZTqSioHDKb9rN4djhNuDYz06IPEcpRdL0RihMOhE2UDhlEIHQAEPn
	gJ6WmPIam8Ye7vRT4AVdw884pwEKsk7UgNj0AYUQu6OZEE3QsHmLmrEYVp3pkEkq1UuqjQbtLEg2v
	pePDmP/AgUbAcQjH9kQGn11FiEXJNC/qfK4OJVmE8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 Tuo Li <islituo@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Tuo Li <islituo@gmail.com>
Subject:
 Re: [PATCH] net: 9p: Fix a possible null-pointer dereference in
 p9_cm_event_handler()
Date: Thu, 18 Dec 2025 11:54:48 +0100
Message-ID: <2810825.mvXUDI8C0e@weasel>
In-Reply-To: <20251218071012.7740-1-islituo@gmail.com>
References: <20251218071012.7740-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 18 December 2025 08:10:12 CET Tuo Li wrote:
> In p9_cm_event_handler(), rdma is checked in the RDMA_CM_EVENT_DISCONNECTED
> case, indicating that it may be NULL. If this happens, a null-pointer
> dereference can occur when complete() is called:
> 
>   complete(&rdma->cm_done);
> 
> To prevent such a potential null-pointer dereference, add a defensive check
> before invoking complete().
> 
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>



