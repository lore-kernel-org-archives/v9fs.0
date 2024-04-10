Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358081E878
	for <v9fs@lists.linux.dev>; Wed, 10 Apr 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763520; cv=none; b=sxZBMgf1drP2qmHUDTSQZ2ZyDPpCN8SXyiMbzTRcWk5ohM3yXrGV0kKCcjeGAgJRmpEeycKy0pFiRWJ0ekh2sm28m6qr6yaTxWxb2wDYVsVMmoDml6TP4Y/m2CY6M1Jl/MdQk+JKlcNcxj9hpzVb5XUfkQAsbB2tM8fpXK6Gwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763520; c=relaxed/simple;
	bh=J4H8z0JjDPb7tPYdSpb9mqFA+CdACWQqEY9/4YMPKlE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To; b=TCV4YTeya6CW+eT35n+j/HMGsIMOvihM4vWFNchDKkG9614qY7H1/E3gYPIdrSqhNFLJZ64bHc4bNBAGkwMqXX2k2Oi7sst+Fs4VUssuGfDlKfWbgWzexhkz+56M8HI1nDU2DAA7V+gBvxamyqC/xPtq3x0HiS99roNB1A5/AsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/TeyOxT; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/TeyOxT"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712763516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rUywcMPSPc/3imLJt4m3tl6R+6x+WpFIGjGYmG6ZH4c=;
	b=E/TeyOxTWkWkmD/7eW3cFS7QMH2BMKpQ2Wbg9JUHOwgDeqyXm2+NKZfUu1iRA3TZSp7uB0
	i3LE1xp+vj6qwb+4/wyPSMPib+AX5Mcy19hxU3u+cXpm+daJ22nIlfmkZV8rj27sidX5wt
	lXYv9rDg9qCYFa19+x+jJkWJU/vJd3U=
Date: Wed, 10 Apr 2024 15:38:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <1296bceb87d9da7c58f7677260592683b3abdb3e@linux.dev>
TLS-Required: No
Subject: Anomolies
To: asmadeus@codewreck.org, v9fs@lists.linux.dev
X-Migadu-Flow: FLOW_OUT

Dominique - check my line of thought on this...

Okay, I'm going down lots of ratholes in my search for where the bug migh=
t be since I can't reproduce it.
One bit that I picked up that I think might be wrong is there is v9fs_fid=
_add(dentry, &fid) at the end of v9fs_vfs_mknod_dotl (which ends up being=
 the proxy for all non-atomic create events).  This was there only for ca=
ched modes previously, but when I "cleaned up" the code I propagated it. =
 I think its wrong in both cases because we v9fs_fid_put at the end of fu=
nction which should clunk and invalidate the fid, but it never gets remov=
ed from the dentry.  Of course, if I want parity with the old code, I cou=
ld only add it when we are cached, but I'm concerned its just a latent bu=
g.=20

The=20other element here that is concerning is why the entire code block =
is even necessary -- if ACLs are enabled, I guess it makes sense because =
if the host file system isn't using ACLs this lets us stash our ACLs in t=
he appropraite xattrs.  But that says it should be bounded by CONFIG_9P_F=
S_POSIX_ACL and its not clear why we deinstantiate(dentry,inode) since in=
 non-cached mode we are just gonna clean those up immediately.

----

While I haven't been able to reproduce, I'm concerned that the race condi=
tion we are chasing is based on the assumption that we can keep inode num=
bers and hence qid.paths unique and synchronized between server and clien=
t.  If the underlying file system (or server) is reusing qid.paths we'll =
get collisions and if it does it quickly we'll see lots of problems.  So =
maybe we have to just break that assumption and keep our own inode number=
s on the client -- from what I can tell there are two places we need to l=
ookup inode by qid.path/inode_number:

a) in vfs_lookup to find existing inodes so we don't duplicate the struct=
ure unnecessarily -- in uncached mode before we were always creating new =
inodes which hid any underlying problems.
b) in create routines (like mknod) where we have to walk to get a fid in =
order to set acls.  Better protocol design (by me) would have been to hav=
e the dotL creation all work like atomic create/open so we get a fid back=
 and don't take the extra protocol steps -- but that ship has sailed for =
now.

For (b) we don't have to really intantiate the inode if we are going to d=
iscard it, we just need the fid to set the acl -- the current v9fs_set_cr=
eate_acl takes inode as an argument so it can cache the acls in it, but i=
n non-cached mode that inode should be discarded anyways so it feels like=
 wasted effort.

For (a) I'm less certain of what to do -- we could go back to the deeper =
iget5 comparison which checks a number of other variables other than inod=
e number (like i_generation if available or qid.vers) to match - but I fe=
el like this is still maybe gambling with the inode number uniqueness unl=
ess i_generation is covering us, but I thought I remember something about=
 it not being universally used by underlying file systems.

      -eric
