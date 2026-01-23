Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20512D2493
	for <v9fs@lists.linux.dev>; Fri, 23 Jan 2026 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180780; cv=none; b=adUxdF+EaOH1hwTb4zm8AUzG6d0qaBImiYN7N9n+2F/d2LWi/2+wjrO5LabsjMda8JSJaD3ifhpjUfyS19x4xFTfj7vNnY+9QwuBcrrWWL9zJ6YgFzwH+qmBFUMg1HaQIinsX98AJR0cz70QW6ReGY0jSlgT/bu72neD0qIMO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180780; c=relaxed/simple;
	bh=Pynp0nE/3zAtaQ+2+SSJ/nl47ljUhiFgkbGLgQ6OWNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sAIcUOMqJVwWvlnxpBe8LE1yIp8cVbP8irRlfv4El/RdIyo4b5hrYQARXVC2ieFLTklJRmcluLEKbPcNQ8CW+M1qTGBR7RE4ZRahEnjt46ebTqO+s5OBIt9iFMp7rJMbtY6mqDPSUySTmBkvQiHlc47D9Jm8d+qSHt/S78z01uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=ugFuDEZv reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=AVhjNzSX; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="ugFuDEZv";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="AVhjNzSX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769181678; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=SAgBVedFuyxPIgCRhhig25olZXujs9yuAYM+zynQ8pg=; b=ugFuDEZvsNS+/lhMdKu61LIKch
	jxqbz25H/a2isHHFqYQYJNr6DdmNKh96l5AK71D/6maGlyVxLRlxm+4M3LTigV/kvmd8nBlabyFh3
	yu+Y/sei1tDk+zpQAFV+JIHoWOfiDJt7Hvp1USh6FHSLMfJGayu+uDzxz3H/z3gYMqkYYHPuTSwT6
	cIWORhx+ocivC+OsMvkxVZ31c5bUyCuTQNxC3w95Y9JD2159mFJDDXJC0ojTghDRlxvP2RZM/eu/7
	kDnnYBLlj+nZVyVvBrDJE7QRUUPhql6OU4YNVDnJ9i41868eimFSXOzjDae+wx3L0FiA7qcU0mX48
	Ooex+4Jw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769180777; h=from : subject
 : to : message-id : date;
 bh=SAgBVedFuyxPIgCRhhig25olZXujs9yuAYM+zynQ8pg=;
 b=AVhjNzSX6apeqNejiqedBlL7aZwY3l/Fa3oKKlC9j8b2ZcTBby8MwftzmKOXtSijYfGd3
 vnUHg5iJxrqmqWY+EKVrvxNgR3V8N9qX011PO2srUzCg/XALWVkj2EXsTsnaA2Rnuc3IEgh
 zRX83ahq/qgpTh+y9iBXPAkux2K2STPe/Swenhu/2L0MHwYqwkVPXxdJFqkTvC7nYicnVNy
 KbwgCEwpsjMsm7e/m5KuTdMnbcN0m4a35gUMjQlor0mGqOCGdkf0988e73kTHF2+RVtj7Dw
 v+Ou//DqyR8DFBf+lNnlg+53nBeGEZ+CzImh2u/ko4MD7Udj9s+BwMTfOyNA==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjN-TRk3KW-7v; Fri, 23 Jan 2026 15:05:49 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjM-AIkwcC8p1zf-KKLF; Fri, 23 Jan 2026 15:05:48 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 0/2] wait/9p: Account 9P RPC waiting time as I/O wait
Date: Fri, 23 Jan 2026 15:48:06 +0100
Message-ID: <cover.1769179462.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: q-2GbdK2nHD3.RfiX7ZR5YwB5.IoReVARJSTg
Feedback-ID: 510616m:510616apGKSTK:510616sLG8nV3o7E
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

This patch serie helps to attribute the time spent waiting for server
responses during 9P RPC calls to I/O wait time in system metrics. As a
result, I/O-intensive operations on a 9pfs mount will now be reflected
in the "wa" column instead of the "id" one of tools like top.

Changes since v1:
  - Convert a bunch of other 9P's wait_event_killable candidates

Remi Pommarel (2):
  wait: Introduce io_wait_event_killable()
  9p: Track 9P RPC waiting time as IO

 include/linux/wait.h  | 15 +++++++++++++++
 net/9p/client.c       |  4 ++--
 net/9p/trans_virtio.c | 14 +++++++-------
 net/9p/trans_xen.c    |  4 ++--
 4 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.50.1

