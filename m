Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF553D25A2
	for <v9fs@lists.linux.dev>; Fri, 18 Sep 2026 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699752; cv=none; b=DexNNaCLvlX4Qv4uCZWYFk3OQH7sYlvXgRoqwYppuToU0cSByGsrJnXpccdqCyXLtekaZpSzoIoY8iyzKZmcvh90gyDa8Ymy59XnoEdzaB5+Uq2PPtNRO4jLvfQkfH31SXP1ojua57hWS7QdSdAO6uognvszqexJ8G/ZbPsBupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699752; c=relaxed/simple;
	bh=gc/XI5HxEC4PKxsI5/WSreIkFC8b7uoh9stcxnuKnN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/OmS3tQISVpeROdC+/ix85CIu4ykgUakIjWSyVhlKIAQfqfXZIMIpE3KshRNizI1RUsMv9AAEDBRT8un/0/SN0Ul4mnSCegLrGEY/w7XXb0J1qh3VoyWPSCgX0RhOKerC6EVUMZFoBLGQ6efVf7WHTnXtYjT4LUNBB2/xi9baE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJWLj6mA; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJWLj6mA"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-39e59dca659so81343a91.1
        for <v9fs@lists.linux.dev>; Thu, 17 Sep 2026 19:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699738; x=1790304538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XPm43STPG/fDQDyOfj6yzMa2YKT8zVqw0iMraAd7aOE=;
        b=YJWLj6mADixUbf8CQvk1DQ92hI2V09AnNIPP0O2Ml8+5sbbg5sJIYoNfWxicDObUKu
         PKJ+OSSWZyIbfna0q/lKOinFTLLerFvn15YoJ0X4M6BdLcUHkKhCe36mgYED41rH2XjA
         Pw6/3RwA8GE1LFcEc+7FgHHsJkmFOrv9ZSI7oAMfR+88cKSatIl7XOedn+TX7wgEzaS+
         po7Kss8zeIEsWnqMkcorpIvR5V4Tx3mQzfgVIcByNCeYo7BQTMLyUy8tBIzXDK/BmrRn
         UjWS0GbJVhjq6Vvh7r90WI4iK4nb1V8IeU2lMz63jqagXuFOqMXxMTOMIk1nZq+I+wu0
         ZZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699738; x=1790304538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPm43STPG/fDQDyOfj6yzMa2YKT8zVqw0iMraAd7aOE=;
        b=Qur/2YGg8q7+xfen4/52Z553mLJY0Cvz72fzkZxs452qsxOEVjDhNaJ2rXT4/HlLt5
         AbRCJ7Y2nnjdPNlvqtWdV6VOybAfAF2Ed3dWQYVppcYF/F5SauBvU7NuxkAuV536ZCoC
         cqykoFaCypB70eSSLn51BiYxUh3M+y0VGU5i1Os10/+JXwnU8aFcietFh9JQSGtPGmv/
         +1syjMNkckChDbHTA+3FZ4PaAqaIjzmi0+QOCqBYJXkvXToGdU9yeW8I6U/rEKNF2SvQ
         YtTgSTdLKqUq6MtbMgdKTJVKfQHd02SsTl9+SzhrrRCtOuV/3DNKLKdcAT++WsEYjXqt
         SNQQ==
X-Forwarded-Encrypted: i=1; AKwUvByEVRICKSF9JcUHCASoeBVykhEMqrQKKZhq7qn7E4zquBEacpVB0JnlnY7K9xN6AHUHoIU+@lists.linux.dev
X-Gm-Message-State: AFuF++lBu4NQ2KVoJ97iapq7PXqih9dWdqXT9zVirG136w9lq3UeWJHa
	kBaAoh8M6+bYsFKoarjMbONA0L7xfHfpBVDOBI1bd36my3rTJbALAf6N
X-Gm-Gg: AYBFou19ARnS2IEj5EwBXElaGMKYBQJOIjslFmlLIGs38WH1Zs+KkNfk3n9m2iANcBM
	duRkhpgMEs2fjch+3gFO6EzfIzFdOpqyOpnnMIwZyIZnvDNcM6CcT7ajwe2ev62xvuVtm5O94XE
	Xb+k+05sedJ8U3v+bEzBQdKpnE7qYe958F2IrTYQC9McPvHF3m/NBisQ6gA1JUktfjVZDwA/wHk
	InzPP+CjX96WZiXfNko+Q4nMcSsRH8ht6E95LucGzvNgSYIS2kzi+x33eElTVGdsyVPDoif1ep0
	f2vvx5c4E1FDj+DsVNs8ytzWQl/SrKsy60lVUOmNwUo9Ue+i+yUNLJowU6Ik3xRBOEDX8mLVhUZ
	DWVyl4dN6N5QpJz/v+sYvR2KXNokbkwnfmFe9C/sAirg0AAd/Li7OLxPBBHy283LWPw4k+HegAZ
	vdrTe1zS9vKgv2wl0Jgo+BDSGaOS74XE0rXazfDiWtoWl42yep2hd3DqAieIeRId7yJv4rOwlyq
	lj4UKmt5Qpuvabd36Vc9qIwb7jtwG4R0V9WhAg6/i374DEt
X-Received: by 2002:a17:90b:2d87:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-39e54d8ecdemr4317714a91.5.1789699738525;
        Thu, 17 Sep 2026 19:48:58 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b023bsm388217eec.23.2026.09.17.19.48.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:48:58 -0700 (PDT)
From: Haobin Wu <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	jack@suse.cz,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com,
	willy@infradead.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v3 0/3] 9p: handle long directory entry names in readdir
Date: Fri, 18 Sep 2026 10:48:48 +0800
Message-ID: <20260918024851.51229-1-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A host directory entry whose name is longer than 255 bytes currently
makes 9p's readdir fail with -EIO and hides every entry after it, which
is how this was noticed on WSL (Plan 9 shares of Windows drives).

Patch 1 drops the copy into the fixed 256-byte p9_dirent::d_name and
uses the string p9pdu_vreadf() already allocated, so the listing no
longer aborts.

Patch 2 then skips entries whose name is longer than NAME_MAX in the
9p2000.L readdir instead of returning them to userspace, as discussed
with Dominique and Jan on v1: the VFS only enforces PATH_MAX in
verify_dirent_name(), and nothing can operate on such a name afterwards
anyway.

Patch 3 applies the same limit to the legacy 9p2000/9p2000.u readdir.
It is a separate commit because it changes behaviour there: such names
used to be listed.

On patch 3, to be explicit about why this is a behaviour change: the
256-byte limit lives in p9dirent_read(), whose only caller is the
9p2000.L path. v9fs_dir_readdir() parses with p9stat_read(), where
p9_wstat::name comes from the 's' conversion (kmalloc(len + 1), no
NAME_MAX check), so legacy really did emit over-long names.

Changes since v2:
- Patch 2: say why the entry is skipped in the debug message and log it
  at P9_DEBUG_ERROR, the level of the strscpy() message it replaces
  (Christian, Dominique).
- New patch 3: same NAME_MAX limit in v9fs_dir_readdir() for legacy
  9p2000(.u), as its own commit (Christian, Dominique).
- Dropped the Assisted-by: trailers.

Changes since v1:
- Use my real name in From/Signed-off-by (Dominique).
- Split into two patches (Dominique).
- Reworded the subject and commit message of patch 1 to describe the
  existing readdir path and clarify that no allocation is added
  (Dominique).
- New patch 2 skipping entries longer than NAME_MAX (Dominique, Jan).
- Dropped the bouncing sripathik@in.ibm.com address from Cc.

v2: https://lore.kernel.org/all/20260916135403.15789-1-853555@gmail.com/
v1: https://lore.kernel.org/all/20260826064819.52523-1-853555@gmail.com/

Haobin Wu (3):
  9p: skip intermediate directory entry name copy in p9dirent_read()
  9p: skip directory entries with names longer than NAME_MAX
  9p: skip over-long directory entry names for legacy 9p2000 too

 fs/9p/vfs_dir.c         | 31 +++++++++++++++++++++++++------
 include/net/9p/client.h |  2 +-
 net/9p/protocol.c       | 12 ++----------
 3 files changed, 28 insertions(+), 17 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.54.0 (Apple Git-157)

