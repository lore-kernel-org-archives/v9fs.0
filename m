Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B318C008
	for <v9fs@lists.linux.dev>; Sun,  9 Mar 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741505741; cv=none; b=Ug30OCWIQb4QvB2aiW0HPEg1R2MmWL2/x6l+OoVimeaxutw0XfLe5zaICIjWX4lYqoYJqgr7HGrAS28guY1sAy/4GtVQb1N2MSJNjnNqralai8J6RfTIu9M7T5aNauLtDsf+xuZRdXdtDvwaTkFKXWcbLM7tpTXCFOHQXGtn5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741505741; c=relaxed/simple;
	bh=3HXNrJC1YJgYhVbPSukVAuN3sS3FuIuuddwY6xtgHCs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dl1XnW7SuujQjxJ23TSIs6HyQGLhzidrS4lbYKO2FDpvjnef+9XbDP4Ze8+eWjw+WG0vVaSNUgGOSGU2YCy7cH7cGu8kmGPQurFHoUc6+W3lEwJRpS5AOdHwmc9BS05O3BrMO1XKWm8GMx0WblpbE2HCMqjgIIWhI3UY2N3/jVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=qmrBH+BH; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="qmrBH+BH"
Message-ID: <c4517e43-b2e2-485c-b727-7e5d47930ba0@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741505727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6w89DGn0N8dEcklqSYy76PaYnkGxYFWAY1mpJJ/Sqbo=;
	b=qmrBH+BHtDuEHGLvw1pAQm35Pbuqqe01jM4GXUFMtIZ7Igqx/uT2j+KksQvC9OcQdKPjcX
	7dJI3h7KsxFYcWcpayY2e80ni63zzcfRSZHVl/N/f1mUuJbZHieAYWqiRJG8U1lKSn9FCk
	AE+al8OCsWSOOb9b7gQsAYpLmOB/XuNRx1Gjz2FURuOj5bCiZU9D8bgNDM87z8fFb0f5zy
	zNGbSMQz4vItCVPoVAAd0Mm4OpsVWnZR36fn6VlKrJUYmdB5qInvLmeKmfdm0vHJKsw1NF
	VK7oXjAowTuT4w22WtRyaYfyGrrVSrACFaYGBXRPPV+3w7xB+luaZFglM0EtfA==
Date: Sun, 9 Mar 2025 08:35:22 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
Subject: Re: [PATCH] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 Sishuai Gong <sishuai.system@gmail.com>, Marco Elver <elver@google.com>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com,
 syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
References: <20250308-p9_conn_err_benign_data_race-v1-1-729e57d5832b@iencinas.com>
 <Z8y_9b6RFZASviUs@codewreck.org>
Content-Language: en-US
In-Reply-To: <Z8y_9b6RFZASviUs@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/3/25 23:08, Dominique Martinet wrote:
> Thank for looking into it, I wasn't aware this could be enough to please
> the KCSAN gods.

Thank you for reviewing it!

> I've just gone over read/write work and I think overall the logic
> doesn't look too bad as the checks for m->err are just optimizations
> that could be skipped entierly.

That was my impression too. Thanks for confirming! 
As far as I know, this is as non-problematic as it gets. 

> So, sure, they could recheck but I don't see the point; if syzbot is
> happy with this patch I think that's good enough.

I think KCSAN shouldn't complain anymore. However, let me send a v2:

>> [1] https://lore.kernel.org/all/ZTZtHdqifXlWG8nN@codewreck.org/

I last-minute edited this snippet because it looks like it should be
like the rest of them (just a READ_ONCE, no spinlock) 

@@ -673,7 +674,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 
 	spin_lock(&m->req_lock);
 
-	if (m->err < 0) {
+	if (READ_ONCE(m->err) < 0) {
 		spin_unlock(&m->req_lock);
 		return m->err;
 	}

but as I left it, it doesn't make any sense. It's either a racy read +
READ_ONCE to make KCSAN happy or a protected read which shouldn't be a
problem. I'll just drop this hunk and leave it as it was.

>> ---
>>  net/9p/trans_fd.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
>> index 196060dc6138af10e99ad04a76ee36a11f770c65..5458e6530084cabeb01d13e9b9a4b1b8f338e494 100644
>> --- a/net/9p/trans_fd.c
>> +++ b/net/9p/trans_fd.c
>> @@ -194,9 +194,10 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>>        if (m->err) {
> 
> This is under spin lock and I don't see the compiler reordering this
> read and write, but should this also get READ_ONCE?

It wouldn't hurt, but I don't think it would do anything. spin_lock and
spin_unlock both emit compiler barriers so that code can't be moved out
of critical sections (apart from doing actual locking, release-acquire
ordering ...). I guess the only function of a READ_ONCE here would be to
ensure atomicity of the read, but 

  1) There are no concurrent writes when this read is happening due to
  the spinlock being locked

  2) Getting the load teared is almost impossible(?) as it is an aligned
  4 byte read. Even if the load got garbage, we would just return
  without reading the actual value.

I'll wait a couple of days to send the v2 in case there is any more
feedback. 

Thanks again!
