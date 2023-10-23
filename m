Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC1125DD
	for <v9fs@lists.linux.dev>; Mon, 23 Oct 2023 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Maq062W6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=faow3AKZ6xEL2dgIGASYCy9P2RMmiNa4Z+LYVETpXhM=; b=Maq062W6+T8naArJJQKNpazerB
	GlyFWsYU4VQejgMsccK2Wt2jHz5I6dGZY7pLcC5kN4oCWvLEK2VTEAjs24y0rPW9U6zCX+DnQY8f3
	mDJxPWyPxFci38CBuRMfhR1vBA2UF7h0wnq9QHQFEPuY9vY1xq+0vRNR4g1Vzkbkol1QBP7JRqsu/
	0brgfl/EFBVoM86ONJMN5MX2lXfCSjY4DOoEyWySwKJLKVyAhdS2z3t/aikPS4Qd4SwAYfMpT9TKt
	DOhW2cM853eTUFagzeLNsGQ3/iVl2dlMmj1w6dKhrQaOJCL1Ku+qy9HnA/kOFQVCEveA08jjHaO41
	GIW+dfMWZmGlGBhHtHFk4od4wQtP7Vc7d2LKdatIAzeg0dNgoZxMPikqYCL1CtpGqiC8Y5Ga9LxY8
	g+Dqq16QmORBORpFWbVVYmymIQx/j92OQ5j+YAUC5pwMwtHWdpkj1CJWT/HHPs7CE4GaSgB+HvnPW
	Fh7YkIeP9f6SE+JmO/UWXiIEy3MgjZ2HtglDuhlQJrDKejXo8NLRAmk5gVvq23tbrbJd5JlseT8Dq
	2HN6ii8Yp8RRfF5UIZRN3rt6CyG8gg8YyMo85Uq8O+bVVmIHRIhoce+kji4d9vVdQ4OtPKKmc858D
	aOXe6KcPlL2Pk2vLCpyuAByPtzOBAmorFHimHBkT8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Sishuai Gong <sishuai.system@gmail.com>, asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev
Subject: Re: [PATCH] 9p/trans_fd: avoid sending req to a cancelled conn
Date: Mon, 23 Oct 2023 15:29:10 +0200
Message-ID: <6989388.Xcqm7ZWvlm@silver>
In-Reply-To: <ZTZtHdqifXlWG8nN@codewreck.org>
References:
 <AA2DB53B-DFC7-4B88-9515-E4C9AFA6435D@gmail.com>
 <ZTZtHdqifXlWG8nN@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, October 23, 2023 2:54:53 PM CEST asmadeus@codewreck.org wrote:
> Sishuai Gong wrote on Tue, Aug 08, 2023 at 12:44:31PM -0400:
> > When a connection is cancelled by p9_conn_cancel(), all requests on it
> > should be cancelled---mark req->status as REQ_STATUS_ERROR. However,
> > because a race over m->err between p9_conn_cancel() and p9_fd_request(),
> > p9_fd_request might see the old value of m->err, think that the connect=
ion
> > is NOT cancelled, and then add new requests to this cancelled connectio=
n.
> >=20
> > Fixing this issue by lock-protecting the check on m->err.
>=20
> Sorry for the (long) delay in reviewing this, and thanks for the patch!
>=20
> I've got a bit of a mixed feelings on this, as there are other obviously
> unlocked m->err accesses in the work functions and we don't really want
> to take the req lock there everytime.. These should be ok in the normal
> p9_conn_destroy that disarms poll and cancels work before calling
> p9_conn_cancel, but the other calls to p9_conn_cancel are simiarly racy
> and for example a cancel that'd be initiated by the write end could
> process a new request in p9_read_work after the reqs have been drained
> out...
>=20
> On the the other hand, this is better than the current situation so I
> think we should take it for now until someone has time to do better;
> it's just leak in the unlikely case this race is hit but we might as
> well close part of the problem.
>=20
> I don't see how that'd break anything anyway, so I'll push this to my
> next branch tomorrow after testing the rest of my patches.

Same here: I don't see it making it worse, so at least a little improvement:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> >=20
> > Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
> > ---
> >  net/9p/trans_fd.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> > index 00b684616e8d..e43a850f5190 100644
> > --- a/net/9p/trans_fd.c
> > +++ b/net/9p/trans_fd.c
> > @@ -671,10 +671,14 @@ static int p9_fd_request(struct p9_client *client=
, struct p9_req_t *req)
> >=20
> >  	p9_debug(P9_DEBUG_TRANS, "mux %p task %p tcall %p id %d\n",
> >  		 m, current, &req->tc, req->tc.id);
> > -	if (m->err < 0)
> > -		return m->err;
> >=20
> >  	spin_lock(&m->req_lock);
> > +
> > +	if (m->err < 0) {
> > +		spin_unlock(&m->req_lock);
> > +		return m->err;
> > +	}
> > +
> >  	WRITE_ONCE(req->status, REQ_STATUS_UNSENT);
> >  	list_add_tail(&req->req_list, &m->unsent_req_list);
> >  	spin_unlock(&m->req_lock);
> > =E2=80=94
> >=20
> >=20




