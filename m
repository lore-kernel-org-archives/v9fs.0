Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67737419D;
	Sun, 15 Mar 2026 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773600646; cv=none; b=aBAZSViOlHx2Cfnw6KMiLCYVfEN3A/4YlWqXel8wz6ZZQeCEJSIexmVLW18eHxmD5Z7nOpmWyhGw1U0Maqc8MLpEIRx+ZO32Zd18RhoAeuvceC8hM3k/DPCd4dRChwUFeYM9gVBSUBFO+o5ACrl4iApVaZh4dtkj9mIhBzoXCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773600646; c=relaxed/simple;
	bh=GkvZvkes32PJcEa4T4Xn4AOsksu8M/Kijlpnkph9hWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7rBAUQ0W1XIGl5ni6XJ0KMZInEPPuC8vs8zn6k9SCZA8IDHyVuyRWKEGQr2HleEXtl3wseb5zcLl0/RrkBGOM2gtGF8mTC213rvhhviX5i/0xal2YXwd12eFZK7jgWWz6+fxt1fHPpSanIDLC9Gw9YETBdrN96S3lg7gXtI1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=iLHcYNWX; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="iLHcYNWX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=DXmzypO0G8pckQFtkBQuNoCLV7u1rhHXrjkdjQGgRKs=; b=iLHcYNWXACBrnXFAzBiMWah+WF
	nIYwfl5c3/fKjdEJzb7/VTQYii2wWCIX4JGwwzzhKNak6nmbQrO/5B6alwXt706yFn0E1Q60oaHqL
	aQtMu5Q1uQInAhW0zcNuiOiNHoI3hTDAxlhtoEfPG8qHaHBBbacGcFwmOPm1lHXsPpK17q74B+v0I
	tdmysIyFP3UFoZ6qdSbe/ZwiGajcrkunY6GS530KOmJxYBpZ+OSoUXb6HZePT2dN1rNcM5Oq38q+w
	5as+er+/qhtzN341eIuzQPcIVq2XY5gn2b0Bm9LQ2a6SAboYmfpnSzlhENM7S3cJ4p3v8X2Z0hy3C
	vO8vTv3zRHkp7jFj24kDGcABEgnxFPfaeEuqVDs+NNdNVfJkGRQ1B4aUXiOYDM755VLP0AhrZ7RbS
	nWxLtvLpuQPX8UUZ786u8r1+s+ipC6jD4XWxn5x1gZagDoV53IgJlbVBBLGME/h3elpAO9m09F8hf
	FDawMEnU3eSROiOhwdpPbTLFxZ6/RxCWC9QcyTZjxo3WUI4/9bHpvIeTBEuKlC6O7CA+seLYTmjIA
	IPNJh1ig0uulOLjbEO6lppYQzBxGc9KGfZxpZzJjGtf6+ecKMkIFbkGFp2gp4quJIYE4IOlk9C2yF
	o+pZoy/LWsD9qiEXR8sDzdaeYR7G05p5PCe/ShzBA=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, Kit Dallege <xaum.io@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] 9p: document missing enum values in kernel-doc comments
Date: Sun, 15 Mar 2026 19:50:31 +0100
Message-ID: <3682866.iIbC2pHGDl@weasel>
In-Reply-To: <20260315170702.65160-1-xaum.io@gmail.com>
References: <20260315170702.65160-1-xaum.io@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 15 March 2026 18:07:02 CET Kit Dallege wrote:
> Add kernel-doc entries for all undocumented enum values:
> - p9_debug_flags: P9_DEBUG_CACHE, P9_DEBUG_MMAP
> - p9_msg_t: all 9P2000.L message types (TLOPEN/RLOPEN through
>   TUNLINKAT/RUNLINKAT)
> - p9_open_mode_t: P9L_MODE_MASK, P9L_DIRECT, P9L_NOWRITECACHE,
>   P9L_LOOSE
> 
> Assisted-by: Claude:claude-opus-4-6

Of course. :)

> Signed-off-by: Kit Dallege <xaum.io@gmail.com>
> ---
>  include/net/9p/9p.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
> index 60cad0d200a4..6b645a0d3487 100644
> --- a/include/net/9p/9p.h
> +++ b/include/net/9p/9p.h
> @@ -24,6 +24,8 @@
>   * @P9_DEBUG_PKT: packet marshalling/unmarshalling
>   * @P9_DEBUG_FSC: FS-cache tracing
>   * @P9_DEBUG_VPKT: Verbose packet debugging (full packet dump)
> + * @P9_DEBUG_CACHE: cache operations tracing
> + * @P9_DEBUG_MMAP: memory-mapped I/O tracing
>   *
>   * These flags are passed at mount time to turn on various levels of
>   * verbosity and tracing which will be output to the system logs.
> @@ -68,10 +70,36 @@ void _p9_debug(enum p9_debug_flags level, const char
> *func, * @P9_RSYMLINK: make symlink response
>   * @P9_TMKNOD: create a special file object request
>   * @P9_RMKNOD: create a special file object response
> + * @P9_TLOPEN: open a file for I/O (9P2000.L)
> + * @P9_RLOPEN: response with file access information (9P2000.L)

not really, it returns the QID and the iounit, that's it

>   * @P9_TLCREATE: prepare a handle for I/O on an new file for 9P2000.L
>   * @P9_RLCREATE: response with file access information for 9P2000.L
>   * @P9_TRENAME: rename request
>   * @P9_RRENAME: rename response
> + * @P9_TREADLINK: read symbolic link request
> + * @P9_RREADLINK: read symbolic link response

9P2000.L

link *target* ?

> + * @P9_TGETATTR: get file attributes request (9P2000.L)
> + * @P9_RGETATTR: get file attributes response (9P2000.L)
> + * @P9_TSETATTR: set file attributes request (9P2000.L)
> + * @P9_RSETATTR: set file attributes response (9P2000.L)
> + * @P9_TXATTRWALK: walk to an extended attribute
> + * @P9_RXATTRWALK: response with extended attribute handle

9P2000.L

prepare to read/list extended attributes

> + * @P9_TXATTRCREATE: create an extended attribute
> + * @P9_RXATTRCREATE: response for extended attribute creation

*prepare* to set extended attribute.

9P2000.L

> + * @P9_TREADDIR: read directory entries request
> + * @P9_RREADDIR: read directory entries response

9P2000.L

> + * @P9_TFSYNC: flush file data to storage request
> + * @P9_RFSYNC: flush file data to storage response

flush *cached* file data ...

9P2000.L

> + * @P9_TLOCK: acquire or test a POSIX lock
> + * @P9_RLOCK: lock acquisition response

acquire or *release* ...

9P2000.L

> + * @P9_TGETLOCK: get lock information
> + * @P9_RGETLOCK: lock information response

test for existence of POSIX record lock

9P2000.L

> + * @P9_TLINK: create a hard link
> + * @P9_RLINK: hard link response

9P2000.L

> + * @P9_TRENAMEAT: rename using directory fids
> + * @P9_RRENAMEAT: rename response

9P2000.L

legacy TRENAME does also use fids. This is a safer variant of TRENAME.

> + * @P9_TUNLINKAT: unlink using directory fid
> + * @P9_RUNLINKAT: unlink response

9P2000.L

unlink a file or directory

>   * @P9_TMKDIR: create a directory request
>   * @P9_RMKDIR: create a directory response

9P2000.L

>   * @P9_TVERSION: version handshake request

negotiate 9p protocol version

9p2000.L: https://github.com/chaos/diod/blob/master/protocol.md
9p2000.u: http://ericvh.github.io/9p-rfc/rfc9p2000.u.html
9p2000:   http://ericvh.github.io/9p-rfc/rfc9p2000.html

Claude, RTFM!

> @@ -194,6 +222,10 @@ enum p9_msg_t {
>   * @P9_ORCLOSE: remove the file when the file is closed
>   * @P9_OAPPEND: open the file and seek to the end
>   * @P9_OEXCL: only create a file, do not open it
> + * @P9L_MODE_MASK: mask for protocol mode bits (client-side only)
> + * @P9L_DIRECT: disable client-side caching for this file
> + * @P9L_NOWRITECACHE: disable write caching for this file
> + * @P9L_LOOSE: enable loose cache consistency
>   *
>   * 9P open modes differ slightly from Posix standard modes.
>   * In particular, there are extra modes which specify different


