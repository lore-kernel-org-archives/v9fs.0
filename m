Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E3199385
	for <v9fs@lists.linux.dev>; Tue, 28 Jan 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056806; cv=none; b=tFPWygUHu5/CLWTZK17zH3uQIPBd6tItVV/jyDtYENAjuwazuCsuq2hSWVZPG1HhWpXDfbitZRhGNNT3aZaoFI+sJx0zzdxTJQTYJ/+KZL+Jcc9+XMGnwgs6MOjzHHuz6W/pXiQU4hzmLeLx2e+0hTZH24pcO5m3+o4kCKC2Ewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056806; c=relaxed/simple;
	bh=CTt6FJeEz8PKfEvXUcfrbb2W9N03Pct7gpU7cvpZ2sY=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=AL1tFmuiVPUTDS6QMWPwywpsQKTsTzK/vJj9OYhyhxOlvRPOspBPDpe31BJyd1Wd7qpj6IEM1OWRuLsJwWSf7vwc8tksPLVul+4YKOkOtS9fP6ucLGEQkBoJh/9mSqRFHmwanZSk6XW9YlySRl79HjJH2r+K4I4+9kvjzKfto5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KayJkOj6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KayJkOj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738056803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jbqcm38PsHs4LcYNLGGlnzcQpQ6OWBsjXDx6bIsk090=;
	b=KayJkOj602eLPoUDGie2CHbCuuQtpcIH8uJ8NlOX+lLFNfQSK/Q7SzHmYWLnqD3x4ItaKu
	9jPHMJqDDHCaVMORYGIMgvc0+RXMZIw5hJmCPfa65inKbT+T+CR5rN3WAlrEZovItUn42Q
	oiluGnv9x1hdCQMfTjamWEXNJrDnYFk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-WI0CUzjLPy2snmXOMPcLyA-1; Tue,
 28 Jan 2025 04:33:17 -0500
X-MC-Unique: WI0CUzjLPy2snmXOMPcLyA-1
X-Mimecast-MFC-AGG-ID: WI0CUzjLPy2snmXOMPcLyA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 131041801F1B;
	Tue, 28 Jan 2025 09:33:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.56])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE51E19560AD;
	Tue, 28 Jan 2025 09:33:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <3173328.1738024385@warthog.procyon.org.uk>
References: <3173328.1738024385@warthog.procyon.org.uk>
To: Ihor Solodrai <ihor.solodrai@pm.me>,
    Marc Dionne <marc.dionne@auristor.com>,
    Steve French <stfrench@microsoft.com>
Cc: dhowells@redhat.com, Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Add retry stat counters
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3187273.1738056718.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Tue, 28 Jan 2025 09:33:09 +0000
Message-ID: <3187377.1738056789@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Here's an additional patch to allow stats on the number of retries to be
obtained.  This isn't a fix per se.

David
---
From: David Howells <dhowells@redhat.com>

netfs: Add retry stat counters

Add stat counters to count the number of request and subrequest retries an=
d
display them in /proc/fs/netfs/stats.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h    |    4 ++++
 fs/netfs/read_retry.c  |    3 +++
 fs/netfs/stats.c       |    9 +++++++++
 fs/netfs/write_issue.c |    1 +
 fs/netfs/write_retry.c |    2 ++
 5 files changed, 19 insertions(+)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index eb76f98c894b..1c4f953c3d68 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -135,6 +135,8 @@ extern atomic_t netfs_n_rh_write_begin;
 extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
+extern atomic_t netfs_n_rh_retry_read_req;
+extern atomic_t netfs_n_rh_retry_read_subreq;
 extern atomic_t netfs_n_wh_buffered_write;
 extern atomic_t netfs_n_wh_writethrough;
 extern atomic_t netfs_n_wh_dio_write;
@@ -147,6 +149,8 @@ extern atomic_t netfs_n_wh_upload_failed;
 extern atomic_t netfs_n_wh_write;
 extern atomic_t netfs_n_wh_write_done;
 extern atomic_t netfs_n_wh_write_failed;
+extern atomic_t netfs_n_wh_retry_write_req;
+extern atomic_t netfs_n_wh_retry_write_subreq;
 extern atomic_t netfs_n_wb_lock_skip;
 extern atomic_t netfs_n_wb_lock_wait;
 extern atomic_t netfs_n_folioq;
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 8316c4533a51..0f294b26e08c 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -14,6 +14,7 @@ static void netfs_reissue_read(struct netfs_io_request *=
rreq,
 {
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+	netfs_stat(&netfs_n_rh_retry_read_subreq);
 	subreq->rreq->netfs_ops->issue_read(subreq);
 }
 =

@@ -260,6 +261,8 @@ void netfs_retry_reads(struct netfs_io_request *rreq)
 	struct netfs_io_stream *stream =3D &rreq->io_streams[0];
 	DEFINE_WAIT(myself);
 =

+	netfs_stat(&netfs_n_rh_retry_read_req);
+
 	set_bit(NETFS_RREQ_RETRYING, &rreq->flags);
 =

 	/* Wait for all outstanding I/O to quiesce before performing retries as
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index f1af344266cc..ab6b916addc4 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -29,6 +29,8 @@ atomic_t netfs_n_rh_write_begin;
 atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
+atomic_t netfs_n_rh_retry_read_req;
+atomic_t netfs_n_rh_retry_read_subreq;
 atomic_t netfs_n_wh_buffered_write;
 atomic_t netfs_n_wh_writethrough;
 atomic_t netfs_n_wh_dio_write;
@@ -41,6 +43,8 @@ atomic_t netfs_n_wh_upload_failed;
 atomic_t netfs_n_wh_write;
 atomic_t netfs_n_wh_write_done;
 atomic_t netfs_n_wh_write_failed;
+atomic_t netfs_n_wh_retry_write_req;
+atomic_t netfs_n_wh_retry_write_subreq;
 atomic_t netfs_n_wb_lock_skip;
 atomic_t netfs_n_wb_lock_wait;
 atomic_t netfs_n_folioq;
@@ -81,6 +85,11 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_wh_write),
 		   atomic_read(&netfs_n_wh_write_done),
 		   atomic_read(&netfs_n_wh_write_failed));
+	seq_printf(m, "Retries: rq=3D%u rs=3D%u wq=3D%u ws=3D%u\n",
+		   atomic_read(&netfs_n_rh_retry_read_req),
+		   atomic_read(&netfs_n_rh_retry_read_subreq),
+		   atomic_read(&netfs_n_wh_retry_write_req),
+		   atomic_read(&netfs_n_wh_retry_write_subreq));
 	seq_printf(m, "Objs   : rr=3D%u sr=3D%u foq=3D%u wsc=3D%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq),
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 69727411683e..77279fc5b5a7 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -253,6 +253,7 @@ void netfs_reissue_write(struct netfs_io_stream *strea=
m,
 	subreq->retry_count++;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+	netfs_stat(&netfs_n_wh_retry_write_subreq);
 	netfs_do_issue_write(stream, subreq);
 }
 =

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index c841a851dd73..545d33079a77 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -203,6 +203,8 @@ void netfs_retry_writes(struct netfs_io_request *wreq)
 	struct netfs_io_stream *stream;
 	int s;
 =

+	netfs_stat(&netfs_n_wh_retry_write_req);
+
 	/* Wait for all outstanding I/O to quiesce before performing retries as
 	 * we may need to renegotiate the I/O sizes.
 	 */

