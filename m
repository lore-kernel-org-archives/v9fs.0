Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04D399
	for <v9fs@lists.linux.dev>; Tue,  2 Apr 2024 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016474; cv=none; b=Qwegw2V0q5sX3Bzz37Awbv3vwZFpZBqq1U93E27wyL+yJmKnaK7j/VjgMyQuOTus7vyS8Z6byit4I1IAfmRbCWg5f7D3FRdfz3dt/WgzUAUKR6jSoY0NX7609rIq1B+5K8gu+N75F5lHiSxbzsanTkOTNZKT9uVIT4UnrSmZaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016474; c=relaxed/simple;
	bh=kiBxqSXfPeMq7CEo52jQZUXDlOyMqHnGsuPVnKgVGcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igURTVO9WXd1YULqtGeJq+bBsLScQCjy+Fdujt6viRsyDIwXU252HVxlXUGZXYTywC54HLFCJu7SlanhM+vaCnCF/LdngdHMLvF1jcqj1Y0pZcMTBKt9sZj49L7gpqUjsypUsG2QfbvMB7ojHRHjl85Y8tigY2nVS5K3aTEf1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C/dSET1d; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C/dSET1d"
Date: Mon, 1 Apr 2024 20:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712016470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kiBxqSXfPeMq7CEo52jQZUXDlOyMqHnGsuPVnKgVGcI=;
	b=C/dSET1d7GaA9R0/7QT3mL+F2A551AQjzrKQZqqQ62LiidOx29+a2kAW2hG96xggzriwq+
	34P9ywnw113dkaqdYonH7y77HgSPwSCtc7pmctniorZALqQ72oW36lEjR6tHRZG23+K7eF
	eddsB+4OgQ+sdkH2AlVyAw0UJKuASsI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>
Cc: v9fs@lists.linux.dev
Subject: Re: new 9p kasan splat in 6.9
Message-ID: <ikookkidwzvjwuexmsco437lusgk24rffec7pyxwnquhydsk4p@evfumg2ygpsq>
References: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
 <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 02, 2024 at 12:02:43AM +0000, Eric Van Hensbergen wrote:
> This should be fixed in -rc2.

I'm still seeing sporadic weird fstests failures on rc2 though - note
that I'm not testing 9p specifically, but using it for copying results
to the host.

Example:
https://evilpiepirate.org/~testdashboard/c/cecfed9b446da5fba9d73e6448c9f0d1ff5d95ff/xfstests-nocow.generic.035/log.br

I see runs where this causes the number of test failures to jump from
the typical ~30 all the way up to 50; IOW, these happen all in a row
when they happen.

https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing&commit=cecfed9b446da5fba9d73e6448c9f0d1ff5d95ff

What's going on with 9p testing? It seems we've got multiple bugs that
made it to rc1 that would have been caught with only moderate testing.
