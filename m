Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4A2E7BAD
	for <v9fs@lists.linux.dev>; Wed, 21 Jan 2026 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027711; cv=none; b=cyHFdjgFWQOZOHc1EwI/hnU3bDdcABp99qT+MRWu8MTGNuf/Xrme6KKHIS3yby8qFCoKjW0urxN3bpq6yPz4TbeIPD6xPigcHKizRBOhOEox+awfINd6Ka32snwg3GPQtDpKocl07TnfqwYDNylrmGNR/1FbG5kQtnDOp4HwoTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027711; c=relaxed/simple;
	bh=68r8bE6qhwjbZqaNnErslOyPOA3WUR4dKp6zwT9IzoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPGMh0InEujZL7OyTeIhu2YLU1RRhV7FetUitPf7ePpczr1aNJDV5lLNQKY7OVamMHZiaLjjzTWwbiKLJ/Q7D1S6R2IUSJ9OFunaEU7D4il2Dvyr9jwNqJkDLhvw6LN7W35afWq7gZzHH9QtTkQkcToojRrLowwo7RtNTv+sDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=mZsulu1G reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=C98IlIyz; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="mZsulu1G";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="C98IlIyz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769028608; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=x8yZEnRd7C3j49tb9f9GokLxR8hXGi7pt3NNBUhXvEo=; b=mZsulu1GU7mDeWAt7FJtdBttFA
	yMyZu8HN090cZori6ZzL/rL5+yV3Z9HR5sW4AFh+/5i3FB5oa5y2AukHMBTIdNJHK227o8CaH7Ssb
	yAORTGMKWnzz3VldBmnsKWUdj8mSl8WBqmkB6JiDfpxorjItCtiIJEa6RbhrSS9+9g7FBr5EBPRcI
	JhlmunckMOGurbf6Sla+z5XPY7Xk0cZ6M4iIQLdFBebxpxx2WmLECr12jLIjqZ/DThyOAQQ64KjKZ
	GMR9n1DjrRtvhcuHAKIstnhtkgyx/kGPwVnjTVQe7uL7ypMcX0UwIk4ZUB/2rflUjxjpPTJ9Wrcts
	sAqwv92Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769027708; h=from : subject
 : to : message-id : date;
 bh=x8yZEnRd7C3j49tb9f9GokLxR8hXGi7pt3NNBUhXvEo=;
 b=C98IlIyzqDN2pHX6kS0g6eL9No1rgd+PnC/tPKf3w6URzJjHJbN3jcj+fug5+UKS2XnyL
 RQyJ3DrDEcVA9poLDGtZu0o4ihen3PA65iZmBdNwhQ6hzvrS7y8ODM9N+0UuzlwaBl2O3yv
 GK77N2l2xX/HypucIbv95GWFYLKCcvQl+L/SDFQY7PIlnvLMa4nVnFY1kRp6kOVfoBQzwWt
 K+5QMcWm+xrk/acY9gHtYePZR4c+OEnJhbsLnsWiYu7enwi+Ctw11jMQ8NB0OosmPLZ1Df0
 BY+/nqa/o9aM1njbvsYmAwoc87p7Av5R1HZ03MjQMZuIogRF0s0j4ncLxA9g==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3Y-TRk6mP-9F; Wed, 21 Jan 2026 19:39:56 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3X-FnQW0hPpTp5-n3YU; Wed, 21 Jan 2026 19:39:55 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 0/2] wait/9p: Account 9P RPC waiting time as I/O wait
Date: Wed, 21 Jan 2026 20:21:57 +0100
Message-ID: <cover.1769009696.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: ohMFxz5fazcO.2xzBozXMjAL4.Nfk3YQuGGQT
Feedback-ID: 510616m:510616apGKSTK:510616scHTfb7n3f
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

This patch serie helps to attribute the time spent waiting for server
responses during 9P RPC calls to I/O wait time in system metrics. As a
result, I/O-intensive operations on a 9pfs mount will now be reflected
in the "wa" column instead of the "id" one of tools like top.

Thanks,

Remi Pommarel (2):
  wait: Introduce io_wait_event_killable()
  9p: Track 9P RPC waiting time as IO

 include/linux/wait.h | 15 +++++++++++++++
 net/9p/client.c      |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.50.1

