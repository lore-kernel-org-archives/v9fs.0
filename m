Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9B1A6824
	for <v9fs@lists.linux.dev>; Mon,  2 Mar 2026 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495105; cv=pass; b=Nj1n141jPliwNurpBzLaKg4SVff6TCtBDP3tpkw/Sb+XzDPdFw1pte/UTUfuzWHciXheUtYFQqDKT+1lyzKkg51+sDxbEIOyBoGJ96vh0MtzwlwNtb9TeO88lNHswVbWQ1b/B7W1bj4er602im6XTcXTyfra1hT0KyBTN7JKui8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495105; c=relaxed/simple;
	bh=gI6mzU+h6MF7rNPJ4817XIF1lxMBARF2p+anpiUg0wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/IyAKEAt9hV2C7irzHJqSD/wq4c/PopyUvQmc5XhufEkUKzlnK8Dqr0hks5DmgxKdyp5nZTstr4LwuQyf0i8m8cDPg4fI5XYV6bLjwEvZLK4RzV4PMswl1h/fkDjCyN9UiE1rYJMp3WWtab6lHlrxSpLY1mqot715v9StL8f0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dKur1WsN; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dKur1WsN"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-359863611faso746713a91.3
        for <v9fs@lists.linux.dev>; Mon, 02 Mar 2026 15:45:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772495103; cv=none;
        d=google.com; s=arc-20240605;
        b=eo7c54983k25RKybZGRRW5OkCWhqnbIIn1hHEkX/c+SPIDCqSH4akHKT7UfSeyI3i2
         xkx+ogJRpT0gcuFS8NgKrfH7B6SIfefAzMx3hTWt2gm4CjAJYPIz6INm7Mo/RZHISJzE
         etXQt1rJGyuUhZpEZfxUPrFalIRxo4maacWGU2/e/cGSZbG/L4Bib0rODU+hbg1ASbrj
         1+xJ5+Ml7f9WpQiukf3cDqS4VoIgYM5JJsW0vyNESi0ZDJhfjxn++PNNg6w76/wzDi44
         PCHNW1sJrfpOey8mvvPb7qgOrVT2sSAccclYuiLhQp4o0lv3PhynPr2DNr/0nCBPPfY7
         X97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u082M2vpZx7MrZkmV/F7ZdAH+CJQSjxHglDjea1+awA=;
        fh=2XISIKBvclv2KY7/qGtLQ5E/euxKsQ4+Jomi5ur7LEA=;
        b=aI1O72olodo4pCOCZhSpjYmisWTRkEL1jlfR63PiN9ZmIjvueH0xzBRwZoP0pBSvkY
         8S9xYJQFxC63dL85HDWqPskDKwtfPv1bSY3GynWp+WTxzUtmt2gphFLvjQd6Oqf4T27q
         1SQZ4t55pctztxVx3rCFBVixUkzpL2nq5W3YFYq9akYJcXsqvHBK2fj4uAyL8YWejodu
         fwchooTD1cAx8vc+9J+JxJNArC0QkdHhoCpX4j3kHEzM64miehHhO9cGZp+wpemd1lwp
         PFoY755CQxN1YpPxCORqn9dK8ht6okFJ63W1tir+z8QuKjN5XPqg0uBXs5xzHmkbsD4Y
         1Rtg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772495103; x=1773099903; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u082M2vpZx7MrZkmV/F7ZdAH+CJQSjxHglDjea1+awA=;
        b=dKur1WsNzpmOhCi00v+OxvDQ3ckNtwPkm5cBnDpOWROLuSCozs4VQdwVOxCHSa3jpO
         zxwxS36YezuO5vI2ZtSDWJkY7CrydS/4Hc0JvsVDeccui5y848R/7uWKvAxUvaVM5ZVw
         s+yTaxidGeEdvVGwOwZE8VWfMQLuopWhD8HFrFxQd3hFmLAe0W7K1OZPYf617b1kYsH1
         gj6gJtN+CQxQqDTBz3UpAiD6RLHOfbjE2B42twCQ0MEg6qzInz9DbU/OyTFyb/bJa0J4
         ILg3Q59fFMs7rVJTzebeiryvrD93SaV3sFaHZPMrKSVTxbAgChysTewCUpTfqJA8gP4+
         y6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772495103; x=1773099903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u082M2vpZx7MrZkmV/F7ZdAH+CJQSjxHglDjea1+awA=;
        b=KL7hPTfm0+sPkosKNLGYJuZ9RP6HGFBNdY0aB3hGzpGCSNHp48TqUrW2ZDx7djRu5E
         Vm1aibMQtI8cb+7CmOr7nAF6gjCuz2WPgatAAY/D1tI+/1UtNl9XSICh3r8MtdY5YxeN
         68JlrOwEpwmhfidFabGeAzw6IjrrN23lgV17iHnlgspRtFuhq2ZLsUJ/deWrGb4wqet+
         6nFkI8MaF7a5/G2I9PbTT3Jxzv6KbEsIagYbq51k85sR6Zy1ATH9lcnYfEsic6FV4vTH
         AaEV0q4StsiBwGlTzbT/6aj1FheHJEpmXxwZTZ0sqs1K8BYAP4XChImfRcKMYED+eV8S
         z64w==
X-Forwarded-Encrypted: i=1; AJvYcCVOCb4Kv8I2Le72tUb34mBqGUmzhZ2V7oFXP8BOT+I54lVCYXtgYKI57g1SzA24wUAJBOmb@lists.linux.dev
X-Gm-Message-State: AOJu0Yy88goGFYyb7ogvLSJXuGJBQEyvMGRShXjUHPEl2bSX74sqjrDR
	rljaDsXj44M1HnIFZF6aq8W5ynrYy2jFCLvBnlTuClFw+exg+oYx//3gQPx8eZf/gKjiXrp0O0V
	lWyD4lBKgeKMiuWQDSNltW7E+kWzBUkXlRzcjopm8
X-Gm-Gg: ATEYQzwJ1Kiq3eDf11S7fDqzqbpVAP/T4tjOGoL4ci7xSRViJM8LP4VnwZXVxzmCyFT
	e8NbHQgLmZ1G8jNEZ9R23hEFMthyHDYo+7DAq2NFRQTVbW99aH6CcSso8sH6hVi+pPz91yXByem
	AhfAYiq8ufsu5GmgyZxcfR0dBy1PjYgIt4xlJt0VaodueW/62EgKL9RiRK47WGaWkMZQICdrQ2D
	/P65InET8/fVzsHClBhbbfgACLiz51TVLawZ5RPQt0cuB4+tbx2hq5TEmO193GLbEthzNwoOL2n
	FkmWz/8=
X-Received: by 2002:a17:90b:578e:b0:356:2eff:df05 with SMTP id
 98e67ed59e1d1-35965c9d15dmr12730172a91.16.1772495102745; Mon, 02 Mar 2026
 15:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org> <20260302-iino-u64-v2-3-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-3-e5388800dae0@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Mar 2026 18:44:51 -0500
X-Gm-Features: AaiRm51Sffi2V1GbWbKQK3xjBHaGrjaqO3h4_HvI_INFaL56ZEFyr07E1_3tePs
Message-ID: <CAHC9VhRnmBuXEKkUPQhJ_LDzcksjoAJL-ne6mFoJdR1hnDdzsg@mail.gmail.com>
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

On Mon, Mar 2, 2026 at 3:25=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> inode->i_ino is being widened from unsigned long to u64. The audit
> subsystem uses unsigned long ino in struct fields, function parameters,
> and local variables that store inode numbers from arbitrary filesystems.
> On 32-bit platforms this truncates inode numbers that exceed 32 bits,
> which will cause incorrect audit log entries and broken watch/mark
> comparisons.
>
> Widen all audit ino fields, parameters, and locals to u64, and update
> the inode format string from %lu to %llu to match.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/audit.h   | 2 +-
>  kernel/audit.h          | 9 ++++-----
>  kernel/audit_fsnotify.c | 4 ++--
>  kernel/audit_watch.c    | 8 ++++----
>  kernel/auditsc.c        | 2 +-
>  5 files changed, 12 insertions(+), 13 deletions(-)

We should also update audit_hash_ino() in kernel/audit.h.  It is a
*very* basic hash function, so I think leaving the function as-is and
just changing the inode parameter from u32 to u64 should be fine.

--=20
paul-moore.com
