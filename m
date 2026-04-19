Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C682918C2C
	for <v9fs@lists.linux.dev>; Sun, 19 Apr 2026 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776586944; cv=none; b=STkZ1boNMjtqGNH8B7+QtcL5QAd5pVKmeeeHXZhjNOFGfoObRf0sesHWv3j8dKLwEF+xSQWbmktBcHjcJkroQnlbhFtZg1uHK6qhGFVksQQtDNZZhpLvcZNYZMHnKnMdWDVFSh2WOELQgcgrIbJJjSJmloG9pejvHYKlswkZRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776586944; c=relaxed/simple;
	bh=yaw1wXzy4/getzhUa3oF7rpNZQK3hNRQnIdjQy4bpgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VA3RV2TjQT8bKFCor2ckI5PllbOyujVxeh0lPWeGua0JXmUMFun0TPs7H0o89TYY5zRgs+UPI7Evj1s0gDkQflXNon781AbUUShNIEi9DNUkpwACt/LlR81xhmLjSr03F4MxSeohHPMNizLxW0zp86lgcF7pmFSSe2XAKD38iaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [10.88.16.7] (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 71C7C23375;
	Sun, 19 Apr 2026 11:22:12 +0300 (MSK)
Message-ID: <bd83eb25-3142-3d91-f605-4d6f01182d03@basealt.ru>
Date: Sun, 19 Apr 2026 11:22:11 +0300
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal
 signal
Content-Language: en-US
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260415155237.182891-1-kovalev@altlinux.org>
 <aeA-WpUyfWrYrvaE@codewreck.org>
 <e3e9146a-d820-d35d-cebd-e7e7e4a2fa24@basealt.ru>
 <aeFoRIOUNQZWmTG5@codewreck.org>
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <aeFoRIOUNQZWmTG5@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/17/26 01:52, Dominique Martinet wrote>
> So if I understand this right, with a sane server, the tag will be used
> until umount or a reply (to either the flush or the original request)?

 From what I tested — until a reply. Tested on latest master.

Added virtio-9p to QEMU cmdline:

   -virtfs 
local,path=/tmp/shared,mount_tag=p9host,security_model=none,id=p9host

Mounted in VM:

   mount -t 9p -o trans=virtio,version=9p2000.L,access=any p9host 
/mnt/p9real

Tested with and without patch:

   # SIGKILL
   dd if=/dev/zero of=/mnt/p9real/bigfile bs=1M count=500 &
   PID=$!; sleep 1 && kill -KILL $PID; wait $PID

   # SIGINT
   dd if=/dev/zero of=/mnt/p9real/bigfile bs=1M count=500 &
   PID=$!; sleep 1 && kill -INT $PID

SIGKILL — transport cleanup picks up the remaining ref:

   p9_req_put req ff11000108aa8... tag 0 refcount before=2
   p9_req_put req ff11000108aa8... tag 0 refcount before=2
   tag 0 removed from IDR
   [1]+  Killed  dd ...

SIGINT — server replies and drops the last ref:

   p9_req_put req ff1100010e073... tag 0 refcount before=2
   p9_req_put req ff1100010e073... tag 0 refcount before=1
   tag 0 removed from IDR
   1+0 records in
   [1]+  Interrupt  dd ...

No hangs, no leaks, no regressions with or without patch in either case.

Syzkaller reproducer (trans=fd, no peer): without patch — permanent
D-state, process never exits. With patch, each iteration completes
cleanly and both tags are properly removed from IDR:

   p9_req_put tag 65535 refcount 3->2->1, removed from IDR
   p9_req_put tag 0     refcount 3->2->1, removed from IDR

Also verified forced kill of the reproducer — tags cleaned up correctly.

Severity is low and likely unreachable in production, but it slows
down syzkaller — the hung process ties up a worker slot until the
harness kills it by timeout (143s on our setup).

-- 
Thanks,
Vasiliy
