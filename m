Received: from e3i677.smtp2go.com (e3i677.smtp2go.com [158.120.86.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695FD3EBF31
	for <v9fs@lists.linux.dev>; Thu, 12 Feb 2026 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889374; cv=none; b=mUDCNXnqiRpihDXO59iIvVomE1VJtMqNX3I1hHFK26cszaI4Zp1mdotx5aoqeukaPnFZnuWY/5/p8aB27aHd6rU3pK+8p3KrL8sRoqkhuPcbFwmGUU9t6Md+KhViYOwf3GGlbieHfDQbPNI1c2iO2z5+Iq0/LIQgRn6XBmsE6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889374; c=relaxed/simple;
	bh=HNEpAuZGU8T/U+euPf7PsgW+b7BopHEn/wG+L+SBZpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/aO7rG1yCHyCuJxQhALdy5JxKKviSmS0tEPLXPRE71K+vt3YfCbat5uuqWxn3BBL7psacw+KxhswSqzo8KG96X/xQIErOfFzBlLd/UPs52SIly9Ub4bh58CXAsUjlDQlHK0fIVpqXWMHq6ScusGx82dAztlPE0SYJOlkD0Fg2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=BpRuqLjA; arc=none smtp.client-ip=158.120.86.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="BpRuqLjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1770889371; h=from : subject
 : to : message-id : date;
 bh=cSz0rTGp9/+1Z7AIaEcK3nmcIXZNhHRnmZh2Iy17Igg=;
 b=BpRuqLjAGcVRa/4KkrcHObTZuBpg248uKJlpTvL88rvAwlX45Fhzw1+OPUwzd3iv9zK/D
 M11r7O3mRcyO3OxIpCfBugf0znaCBIpUsHiUooc8FnRQKd6Oonxo7GYSIG3F79ZV4USmiVi
 aRIZX+HRgxYxuR8kOA4HxQJ1bkWIPUaf0jRfd2+XuoMl8poMCOzsj2tPDDSyhEJhtzLbRZu
 +WqBH6bcNYrfTwdvFBL7ycbdRkFZhTTxIeMiaC/+raLN/HptqhS7RBukCl75rJH+24P1P3s
 hYEcOFNaf1QJauucnwYWs++t72X8yv1vZx9P1SbllhmXJcto3wdsaE1ekqVg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vqTDk-FnQW0hPtR4n-nC1s;
	Thu, 12 Feb 2026 09:42:48 +0000
Date: Thu, 12 Feb 2026 10:24:27 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v2 2/3] 9p: Introduce option for negative dentry cache
 retention time
Message-ID: <aY2cS77rIL-h-8il@pilgrim>
References: <cover.1769013622.git.repk@triplefau.lt>
 <7e38e7bd31674208ab2b0de909c0744feda2c03f.1769013622.git.repk@triplefau.lt>
 <3929797.kQq0lBPeGt@weasel>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3929797.kQq0lBPeGt@weasel>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sCOEI9QSwV
X-smtpcorp-track: jtESA5usqEE8.lPIA3sla7K59.bqaPQQEVaf6

On Wed, Feb 11, 2026 at 04:58:02PM +0100, Christian Schoenebeck wrote:
> On Wednesday, 21 January 2026 20:56:09 CET Remi Pommarel wrote:
> > Add support for a new mount option in v9fs that allows users to specify
> > the duration for which negative dentries are retained in the cache. The
> > retention time can be set in milliseconds using the ndentrytmo option.
> > 
> > For the same consistency reasons, this option should only be used in
> > exclusive or read-only mount scenarios, aligning with the cache=loose
> > usage.
> > 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >  fs/9p/v9fs.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> > index 1da7ab186478..f58a2718e412 100644
> > --- a/fs/9p/v9fs.c
> > +++ b/fs/9p/v9fs.c
> > @@ -39,7 +39,7 @@ enum {
> >  	 * source if we rejected it as EINVAL */
> >  	Opt_source,
> >  	/* Options that take integer arguments */
> > -	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
> > +	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrytmo,
> >  	/* String options */
> >  	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
> >  	/* Options that take no arguments */
> > @@ -93,6 +93,7 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
> >  	fsparam_string	("access",	Opt_access),
> >  	fsparam_flag	("posixacl",	Opt_posixacl),
> >  	fsparam_u32	("locktimeout",	Opt_locktimeout),
> > +	fsparam_s32	("ndentrytmo",	Opt_ndentrytmo),
> 
> Not better "ndentrytimeout" ?

I just wanted to avoid to re-align all the above, but lazyness should
not prevail over readability :). I will change that thanks.

> 
> My first thought was whether it was really worth introducing a dedicated
> timeout option exactly for negative dentries (instead of a general cache
> timeout option). But on a 2nd thought it actually needs separate handling, as
> negative dentries have the potential to pollute with a ridiculous amount of
> bogus entries.

Agreed.

> 
> Wouldn't it make sense to enable this option with some meaningful value for
> say cache=loose by default? 24 hours maybe?

That is an interesting question, I have seen pretty satisfying (at least
for me) perf results on the different builds I ran, even with a 1 to 2
seconds cache timeout, maybe this would be a good tradeoff for
cache=loose being almost transparent in the eye of the user ? But maybe
this is too specific to the build workflow (that hit the same negative
dentries fast enough) ?

> 
> > 
> >  	/* client options */
> >  	fsparam_u32	("msize",	Opt_msize),
> > @@ -159,6 +160,8 @@ int v9fs_show_options(struct seq_file *m, struct dentry
> > *root) from_kgid_munged(&init_user_ns, v9ses->dfltgid));
> >  	if (v9ses->afid != ~0)
> >  		seq_printf(m, ",afid=%u", v9ses->afid);
> > +	if (v9ses->ndentry_timeout != 0)
> > +		seq_printf(m, ",ndentrytmo=%d", v9ses->ndentry_timeout);
> >  	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
> >  		seq_printf(m, ",uname=%s", v9ses->uname);
> >  	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
> > @@ -337,6 +340,10 @@ int v9fs_parse_param(struct fs_context *fc, struct
> > fs_parameter *param) session_opts->session_lock_timeout =
> > (long)result.uint_32 * HZ; break;
> > 
> > +	case Opt_ndentrytmo:
> > +		session_opts->ndentry_timeout = result.int_32;
> > +		break;
> > +
> >  	/* Options for client */
> >  	case Opt_msize:
> >  		if (result.uint_32 < 4096) {
> 

Thanks,

-- 
Remi
