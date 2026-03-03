Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B2492507
	for <v9fs@lists.linux.dev>; Tue,  3 Mar 2026 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553815; cv=pass; b=oLQ3BHtxZu2j35CBozT8n5vxnwfV4AhZKjRMT3bYjStJ8cFNejJD0W+T2mFxWpSqFHC2lBTVn+K57WgXWSX2T/UwR3xRA5+sTdNtl5kgz3Dnr51oheCqi1Fsbcpd8FiPrQDq1Z5qGjuBGaJWcSThh5zt4L9tgxyt8rdkwB4K+9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553815; c=relaxed/simple;
	bh=gHpW9dghu1qABWYgr+nGS1MyA1zHANwq+LZU97nUyCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dzbm1yOHb2qa0nFikCWhuLz09sT+Z+8I4+4KKz5xkeNM6HqQxxfrp3wtrDHpVD8L5du9CnOexZEIhCE0L4Ka6RYvOiiRQyiBVvSy7RwPDp/egJYLt4YpkFCTwQkjdtvKRsyPQ7ibYjFZLX/XxD8vRXKyiXieqyRW30hSbUXh458=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WLJtMKHQ; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WLJtMKHQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae50a33ff8so19078745ad.3
        for <v9fs@lists.linux.dev>; Tue, 03 Mar 2026 08:03:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772553813; cv=none;
        d=google.com; s=arc-20240605;
        b=eVJnJzcyffCwuG+rIAjQX+F8MEBvBY04TXpqVPpsAQNryq5bhm5vxL2V5g+hNZhhKf
         182Mys+XLlDjcTQcdM7QRw+jcQYWrh4Y3Oln+cRNUkM9T/r10p4BKBAWQ+EBsauzj+ly
         +zMpmghLNt5+bHnSqzCNiRCbk122c5LWVzQaCVi2+Bkivm1DeE0s7/T2cZOby9MlRB6R
         9vlNuXd3M49vsr5QkPIsxPbslFtud3jELmAb3dyyMFtxt5+xXXxtz9tZzEaJOPj2zGG0
         tNz08sfZLqkK1ARpA37wPWBsBhzXGsYS2qwYIAnzd2UZ/afIMKfFa3JM2tIcbHL8Roy2
         gVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HCKOB8v5PMk665Bqff0+UwFdzmHKS9yVAUuIB18V7V4=;
        fh=J7jukWfcEvqZZeAE8Y4Ppq5SlRAV+TT4lI9kwFYqWok=;
        b=dQClK3eNwwWHeeveUzRW/0pBNFlltV1ahqLEAcudlxnJyDhUc2MGmTId+Rgr6SsvSE
         uFNmGh9Fq49lX2tVPo28jp8jAc9/cklXXpKPpL6ZMwKlxSKcR+n5Dr3dXyfW3fJHh6T0
         JJMGtGkXf8e+uRLa81KHMaXXJ7Wk7EdmDix/TkH7B0uinN5+UjODqfU7hsTxtWW00JUj
         NsgrSxlYWC0i+XRJGg6OvAlLnaWmLlUHwjIMYU5biXg51bC0FelOhTGe7MiTs5nu/UAH
         xY/PZq5IEG8UNAdN0D8UlDLj6YbFC9HlTbL9AdlOjmsxTPbRJNh5Lj8VtkLVVEUybkux
         TYMQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772553813; x=1773158613; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCKOB8v5PMk665Bqff0+UwFdzmHKS9yVAUuIB18V7V4=;
        b=WLJtMKHQjX6ZT3AKWKXTg2+QqTAa5f3skCA/fKwWOnu/rNIeiwmtk0a8nfjqxYWf/x
         34bXeVEfVY+bGJTiD3KzdepKAFKTyHJqq0qNXTOL8NQerZL+guuYwInlM+UB6Rntzxlq
         /SKOu/laPuXFuQjxi5RnozzXY1IDBv3s2ebmJfzVp2QHOJDLKL9gc+Ixf1OM9sNN2sDi
         bGx9vjL1UiS2Uo6XBCFyYln8FIqbDhP7L/mxQYBCdksqPtyAPQd/s7bPOlMoNz/iHRlT
         08r7BD41UYFhWRQNaAdNdnAu2YH28getHDOPURYqi9cs7RkD0DM4R3+dDyPGxN04YFK1
         78tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772553813; x=1773158613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCKOB8v5PMk665Bqff0+UwFdzmHKS9yVAUuIB18V7V4=;
        b=rDGlR9WK8ub0qTT+0iQoq4ZZVeVj2PWk5VE2JnCPDhWJf/56mN4Oj0iKQyBoERY69H
         ovPY/FtV19CdJhNBXJa8oVo80Vnh2wcWOl3qjriWlptMCAdVI8qjJyuoYFL4opWZjiLV
         EAU62b+wscUhXW68/NWXbxZgvyu+ASl0qml2kmdaZCxQAMtSCK3eWY8selyQZmFkSAdV
         Vk+rd4/R+paywpctSU4zq44zBqEIZD+qbNcwGSdjaZWKUrAdrK5VwXXAWHaNFOSjLe4r
         w/TqL6P2qwv0ftJjoPtUfmd5z1JQoMl125WS33eZ5rWkx2FWS4snRMXAIQuA6sJQoo1i
         K0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVuT24ewXae28iq4oq05oVcsNzCrIpkhzMWTZSvnR9EHDzhRd2nUf84o7dRVzJvZoI+eGIP@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl0+gnSGj/I/+WBiH9P+7215k9++D4Qh8fdN3ZdgPp+Z7tkQah
	WndEf+SCSK3ZkBwqsLwSiaE15Ao7dDvwP44hQQfIdc/jLG3j25sS2BgD0Ka+pR3U8CGnybApn4B
	PPzH9l7lp0FM0V/O3P5HujHcoP4SBcuQi7mU3yBHO
X-Gm-Gg: ATEYQzwYL1enYY/Wu7WtvGC6URO6VDtNjBgT7syMs1+dtqglfRUkMxrNZkQIBsvHFcS
	NtxcFKZBo74P5lPe+mX3MWYHMmJMLk3wNf2t5jd0PvJ8gmDOFC8y8gjk/MimeklUfjBADj4YzMR
	2nwYgOPbdFJ3raIMXU9CuQAMFd1rb+kaFg6N7nUNo1ft5ag7QJ0rVQl72TTKyrnj96vznbSDFYy
	E4P9CdQ4O1XnNh+go+RNZyVo3Yfx1vpEX7+c+WGLLTnj/PHioxGCMDj7GmEn/Y0zX2qkPJ2c21X
	VdRp794=
X-Received: by 2002:a17:902:f60d:b0:2ae:6457:30b4 with SMTP id
 d9443c01a7336-2ae645735cdmr15498765ad.36.1772553812817; Tue, 03 Mar 2026
 08:03:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-3-e5388800dae0@kernel.org> <CAHC9VhRnmBuXEKkUPQhJ_LDzcksjoAJL-ne6mFoJdR1hnDdzsg@mail.gmail.com>
 <7a0165fe39e82a1effd8cce5c2c4e82d6a42cb3a.camel@kernel.org>
In-Reply-To: <7a0165fe39e82a1effd8cce5c2c4e82d6a42cb3a.camel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Mar 2026 11:03:20 -0500
X-Gm-Features: AaiRm51FwCY5Sd0470l_ykVC0rIb7qnpGdc7B1bNvF1bAK1vXw1y1CZQ64VgwhQ
Message-ID: <CAHC9VhTyhnG7-ojnTnVdh_m1x=rKxw9YEH9g7Xp9m4F78aA5cA@mail.gmail.com>
Subject: Re: [PATCH v2 003/110] audit: widen ino fields to u64
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org, audit@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 6:05=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
> On Mon, 2026-03-02 at 18:44 -0500, Paul Moore wrote:
> > On Mon, Mar 2, 2026 at 3:25=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > inode->i_ino is being widened from unsigned long to u64. The audit
> > > subsystem uses unsigned long ino in struct fields, function parameter=
s,
> > > and local variables that store inode numbers from arbitrary filesyste=
ms.
> > > On 32-bit platforms this truncates inode numbers that exceed 32 bits,
> > > which will cause incorrect audit log entries and broken watch/mark
> > > comparisons.
> > >
> > > Widen all audit ino fields, parameters, and locals to u64, and update
> > > the inode format string from %lu to %llu to match.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  include/linux/audit.h   | 2 +-
> > >  kernel/audit.h          | 9 ++++-----
> > >  kernel/audit_fsnotify.c | 4 ++--
> > >  kernel/audit_watch.c    | 8 ++++----
> > >  kernel/auditsc.c        | 2 +-
> > >  5 files changed, 12 insertions(+), 13 deletions(-)
> >
> > We should also update audit_hash_ino() in kernel/audit.h.  It is a
> > *very* basic hash function, so I think leaving the function as-is and
> > just changing the inode parameter from u32 to u64 should be fine.

...

> It doesn't look like changing the argument type will make any material
> difference. Given that it should still work without that change, can we
> leave this cleanup for you to do in a follow-on patchset?

I would prefer if you made the change as part of the patch, mainly to
keep a patch record of this being related.

Ideally I'd really like to see kino_t used in the audit code instead
of u64, but perhaps that is done in a later patch that I didn't see.

--=20
paul-moore.com
