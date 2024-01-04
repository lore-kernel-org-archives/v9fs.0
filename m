Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499322305
	for <v9fs@lists.linux.dev>; Thu,  4 Jan 2024 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="afQbiBb2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=UE0nzoj2+l7RKTZM+mYMBa2vGSG7urVhHiLT4+pvtqE=; b=afQbiBb2Mb3MMK/Wgzj+qrDrJC
	538nvU8VFE4YPPpwTwGolcBCgDuCZgBhennmcDHlOZ5urWMBIgxexllagwS9BQGR3qqxt8ve9M2uQ
	FVWygiWncUqSovn4qXXb1r+W6XEbH4NlBSPqpcyQ4luGDZt0P+JvSgcl9UMfAjT76BF/GDyw+aXUo
	1ewhpBUsZ9NayxVpa7MN7rXueYkO7hhzZIiEmtDpOLw+zKUDQsfHj6cm7Vn572txlISMlGSNDSS2J
	sDFmvpqG1iQtg4xM1FiMQ/KP/q3zXZ2ztEVE8WT9WdscavkoHi+ARxTHNCiRsMkQGpxZPS8crXkEd
	zy0tc0cA/MKW2InXNTSO91q+CiurpUrkk7HY255yYQXcvLeKIkBc4Ki+Pv7YaV9GwaLTn1LsqLPkL
	kgxEKGpC5dG2vc3O+H2nEuZIHs58P/BsZZJhRTIn5hHZoc8z42k6tAVWRbT3bzGX4gmeadhmenHyX
	6jhdKcKYCOTlSb/JkRYgSb153PNdAG0zn19YP0uUmvWU8qPlc6piQKiVkHht5QnIj2oeflmpbxBt6
	k1MyE903dJnWA7SAdpePyEDc2m/KUg7xPHd/9ZxIuO2jBQzv4aYSJygl6eQuOfLN03dWSsvuFsm4n
	T7MHPeY9rM4MkD1QxBq6GA0atLHQWeWTP7ufGEBHw=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: asmadeus@codewreck.org, Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, Greg Kurz <groug@kaod.org>
Subject: Re: cache fixes (redux)
Date: Thu, 04 Jan 2024 13:37:34 +0100
Message-ID: <2900064.uouh5yoDIQ@silver>
In-Reply-To:
 <CAFkjPTnCoQXMaRXhFuzquZaKe7DFfzEEGi_Z8f7hA6Rn0wHtYA@mail.gmail.com>
References:
 <ZZWi6fbgy8oGwR1D@FV7GG9FTHL> <ZZXCiSlrAMI5sMr3@codewreck.org>
 <CAFkjPTnCoQXMaRXhFuzquZaKe7DFfzEEGi_Z8f7hA6Rn0wHtYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, January 3, 2024 11:48:13 PM CET Eric Van Hensbergen wrote:
> One other thing I noticed when looking through the code (related to
> xattrs and acls) - it seems on create we are pre-populating client
> side ACLs -- this requires some extra protocol and steps it feels like
> we don't have to take.  So I guess two thoughts:
> - shouldn't the server side be populating ACLs appropriately on create
> if the underlying file system supports them

To resume a discussion we recently had on this topic, i.e. relying on server
handling all permissions: ACLs are actually the line where it becomes
difficult to be handled solely by server on its own. Because AFAICS there is
nothing defined in the protocol to handle ACLs in the first place, instead
client sends xattr queries to 9p server to map ACLs as xattrs on server side:

$ getfattr foo
# file: foo
user.virtfs.gid
user.virtfs.mode
user.virtfs.system.posix_acl_access    # <-- client encoded & managed
user.virtfs.system.posix_acl_default   # <-- client encoded & managed
user.virtfs.uid
...

Now even if the protocol got extended to handle ACLs, it would still be
difficult for server to handle this task reliably; I am thinking of setups
where e.g. guest runs in an Active Directory domain, LDAP, PAM modules, and
what not (all on guest side that is). A huge bunch of information server would
simply not have and a user would need to duplicate as a setup on host side
(not a good idea for security reasons).

So in short: simple Unix permissions, sure, but anything beyond that, I don't
think so.

> - if this isn't the case it feels like we might be able to get away
> with a slightly reduced approach of walking to the new fid and sending
> the appropriate setacl proto messages and then rely on the inode
> refresh to fill the cache (if the cache is enabled
> 
> A bunch of this has come up unwinding complexity in where we are
> "creating inodes" versus using iget with optional create.  I think
> everything needs to use the latter so things show up in the hash
> appropriately.
> 
>      -eric
> 


