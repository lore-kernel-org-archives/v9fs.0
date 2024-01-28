Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F722F17
	for <v9fs@lists.linux.dev>; Sun, 28 Jan 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706447704; cv=none; b=HZKgOl/dAkPkE5MJh9D9ULRq/uJOJcdF7Gi6q7F+vqD+cyKZkf8R7MIlPwFcwiDX9giZMGERyUuEjdYeU33ijIJlyoSvjHSiLE5L2EO88QlSYugB7gX9+/CZJOz5LE7TbbqsnkmbLbWUsV+BniH29TWe9wRv/EA8xEGuFmuEpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706447704; c=relaxed/simple;
	bh=47IquW87I/pYxtJv9yD8P/bxu0UAKJOwTXCmSSuWj1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjRmBrHJP9novzBIZZUqJebN3CncxrgYVFLRHISNzBB3PsC86Po3S6dR/gOSQFdDkRORLv8Xn7/gVnNTi0t2qHi5dlsET/9pCi5MOZ7aZCa/3SLizT6Ivy6chet7Ht3cjau76dupIRiIQ9I8KIJpKuHCgUgkvi6l5mKyn9NK6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qgYpPG+k; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=lGIznWcO; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qgYpPG+k";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="lGIznWcO"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 64C69C009; Sun, 28 Jan 2024 14:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706447195; bh=xQ/vOvP/yvllm4fmci5fqe4uqdG9E9f7VwM1xY0YilI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgYpPG+kRezgbQWeZhElGYzqZaOcU9yUZkw1xlHCO64yu6cIe/dfhSOpiG9R0+YmI
	 IFuyKAq5MRLO/OzHHVvaMGfDUWNiUVUSVlDP/gsq//8r+0Pv0V61YkOl7PwXUMvFyT
	 Huxub5dhmF/HT4UttuXJugVlUHX7OJ3xMb6hscmblZCCNw7MQNfz7aKtiv4XfMO5X2
	 UR8qecnspn/D4TZZKBhVlbeXnW04SKMNQvUQK3xR22kQIppWN9KJZ28y5EwaYvR3v5
	 vRi6o6/hT33Ut2++lLnRRzl14JD1je4DpVcOEr+l5iFCpx9L2kT/Xzvjmx98rRvXHV
	 m67X0GkDCYwOA==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 53BBEC009;
	Sun, 28 Jan 2024 14:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706447194; bh=xQ/vOvP/yvllm4fmci5fqe4uqdG9E9f7VwM1xY0YilI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGIznWcOBscmNQLj40tSUi7k50Bz+USnLQf+26oJBNRegyAWQjVxaZjQpfhjEFgWZ
	 ozsc6csjP4yZ3hXsXFB0W7xeminVYxJp621S1W8xwl3b55b6xb3fdVVK+XG2No2f5d
	 Is/Eqx8TBLmiCPaXEjdIE2YPYRG0eBltODJwbVYApVx1991vFge+8aNh3NXNyOMhTf
	 s4bxZGB9vlZiiYy+BwfCC6lIuXMqQFVPQJV0Gg06k5F6ovtSw+Y7248hyX4loxrY32
	 6mW+p41c48HWyeEs4o+n9MpielkOR59OlBZ+bz+WoL+i6DQetYwYbyvZ5MMPmOJ85F
	 PYATip+R2mcoA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1c2c40f1;
	Sun, 28 Jan 2024 13:06:27 +0000 (UTC)
Date: Sun, 28 Jan 2024 22:06:12 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: dhowells@redhat.com, Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, linux_oss@crudebyte.com
Subject: Re: fs/9p: regression in 6.8-rc1
Message-ID: <ZbZRRBP453U8PZ8a@codewreck.org>
References: <ZbQUU6QKmIftKsmo@FV7GG9FTHL>
 <ZbRiD2a6F9cDm_9n@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbRiD2a6F9cDm_9n@codewreck.org>

Dominique Martinet wrote on Sat, Jan 27, 2024 at 10:53:19AM +0900:
> Eric Van Hensbergen wrote on Fri, Jan 26, 2024 at 02:21:39PM -0600:
> > I caught a problem in the new netfs code when running in 9p when running
> > with nocache mode.  A regression sweep is turning up a:
> >  [ 1084.438387] netfs: Zero-sized write [R=1b6da]
> > when running my ldconfig test (included at the end of this)
> > it reports:
> > /sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
> > 
> > I will try to dig into this later today if I have time, but not sure I'll get
> > to it so I wanted to make other folks aware.  I'm not sure how much other
> > elements of my test harness are contributing to reproducing the problem.

Didn't get much time, I can just confirm I can reproduce, it boils down
to a 0-size write:

$ xfs_io -f -c 'pwrite 0 0' foo
(dmesg) netfs: Zero-sized write [R=fb5]
pwrite: Input/output error



I was going to say we probably need to filter it out - but it looks like
that might be netfs' job given the call trace I get:

# retsnoop -T -e vfs_write -a :fs/9p/*.c -a :fs/netfs/*.c
FUNCTION CALL TRACE                 RESULT                  DURATION
---------------------------------   --------------------  ----------
→ vfs_write                                                         
    → netfs_unbuffered_write_iter                                   
        ↔ netfs_start_io_direct     [0]                      0.391us
        → netfs_alloc_request                                       
            ↔ v9fs_init_request     [0]                      0.431us
        ← netfs_alloc_request       [0xffff8b8a5584d600]     1.653us
        ↔ netfs_extract_user_iter   [0]                      0.671us
        → netfs_begin_write                                         
            ↔ v9fs_free_inode       [void]                  33.653us
            ↔ v9fs_free_inode       [void]                   0.511us
            ↔ v9fs_free_inode       [void]                   0.371us
            ↔ v9fs_free_inode       [void]                   0.350us
            ↔ v9fs_free_inode       [void]                   0.391us
            ↔ v9fs_free_inode       [void]                   0.361us
            ↔ v9fs_free_inode       [void]                   0.451us
            ↔ v9fs_free_inode       [void]                   0.391us
            ↔ v9fs_free_inode       [void]                   0.391us
            ↔ v9fs_free_inode       [void]                   0.451us
        ← netfs_begin_write         [-EIO]                1120.811us
        → netfs_free_request                                        
            ↔ v9fs_free_request     [void]                  28.062us
        ← netfs_free_request        [void]                  44.423us
        ↔ netfs_end_io_direct       [void]                   0.421us
    ← netfs_unbuffered_write_iter   [-EIO]                1207.784us
← vfs_write                         [-EIO]                1210.228us


David, where do you think we should catch that?
Can we leave that fix to you?


> The syzbot report (refcount underflow[1]) is also probably related; I'll
> try to find some time to check a bit more this weekend
> 
> [1] https://lkml.kernel.org/r/000000000000ee5c6c060fd59890@google.com

So that one's not directly related to this, but given the timing I'd
still bet something changed around cache... I didn't manage to
reproduce it on a very quick workload but I didn't run all that much
yet, will need to spend a bit more time on that another day...

-- 
Dominique Martinet | Asmadeus
