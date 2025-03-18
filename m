Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7C2066F9
	for <v9fs@lists.linux.dev>; Tue, 18 Mar 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335972; cv=none; b=QctNuuHcYuwVJTff/7BW/VeHcHK+tUFe8NNrcczaDePJ2bZii04Op/oilV3HcRI+MftIcJwc4+Ky95PqUkGcBvbHaw3h9SfBJYGULzQy+l2Qt3ROKJOUbeCQBck8IAHD21AzDHzwMpH74DbZxLx+92dq6pjJCt3cB1NNiJ2PNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335972; c=relaxed/simple;
	bh=OwwsgwQ2Izw3x1y2MMKUm4iHOo1nsQ9SMS4vXK/5DpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3/6a2QfrvG1SGjIjqOPJarhZmUwc6a3vZQa5UUV98/8zOElTrw0ie9n04MFpn8JG/Jl3a7ZyjOp1sbWot8wZSKZuBsF4epEC55FUpr+auZEPcXTXiNdmbL8kupnFT9UXzMkHEKkn6AFqFb6kD5YQFXmNSOVogMiZzA91MAha/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=XL+Vb47D; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="XL+Vb47D"
Message-ID: <ee98477c-38c6-41b7-ab94-294fa438bbe9@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742335967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEZdAofGncLSq8KXP8xzdxsPJOAVYd6GsrKysQDd3nE=;
	b=XL+Vb47DLZm8hAczVvTY3dDAv/Aj4WzxBQcPBi0WGgwpfUi0qrWRI89PixKCmca5c02XiS
	V2TKJYwTYGk2PaNX1u/lvCZMxrUsPN18k/Y4NxVTyIz698OVTWkIZTAeWzHpMifjs9itPU
	ee0aeR4L928uYbdEKBiQ5wGw6i/omtaBnu++jRd1Jp9ZgESrNuklAsfen6aL3rwB6LCA0f
	2ni/CmJRvW/2Bso8QS6tj76SovPsFzwxC0EYio6U+wygrE6UbuqZhlniVKgmmJxKKlPj2f
	Uxbkgn3h/ooEOTirIzgW2LVwz9v2OFvwIgL4hOV1F27vukfWjyRi2OnItojEYA==
Date: Tue, 18 Mar 2025 23:12:43 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v3] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev
References: <20250318-p9_conn_err_benign_data_race-v3-1-290bb18335cc@iencinas.com>
 <Z9ntJxTCg2Y0fcRc@codewreck.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <Z9ntJxTCg2Y0fcRc@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 18/3/25 23:01, Dominique Martinet wrote:
> Thank you!
> 
> I've updated the patch in my -next branch, and it'll go to Linus in a
> couple of weeks with the 6.15 merge window

Thank you! 

> (our mails crossed, feel free to ignore the other one)

How ironic... it seems we had a race condition! :)
