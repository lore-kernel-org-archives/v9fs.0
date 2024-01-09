Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED036D6CE
	for <v9fs@lists.linux.dev>; Tue,  9 Jan 2024 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4KU61vT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48660C433C7;
	Tue,  9 Jan 2024 03:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704770831;
	bh=WgewrTItOAQlr4HiToExjYr+NGisneCrdPmYsdtv8NE=;
	h=From:Date:Subject:To:Cc:From;
	b=K4KU61vTIckT4YB+liIijSUUlKXjp0uVj3uY+rz3/3HqG0INPK13AGYIM6UQBIVPq
	 hErqc8pbPfnTy66Ab4FtE+jYSBRjoKqCU1gd3uIl1tbNXKagQuMqA8Zy2GvU1OjgeF
	 u7aufZdAqvZOmZvkSsSnA8IxvHHqoFkLd8ZDuMkK5q1afCSDPK+B93RDGGsRdvIeSf
	 E84eEAuu3rZXBhfypzOWXxhztx15ctsPkj8RPhFJrPUEo/Nl8qUcA7LhAm08/U06cV
	 GN/KHPKfWCN0P8fgiaLuBvSyXi6og7MrOyTmMObfD2GpdwIntMcJ/CXbAXKIeWReJX
	 crIkeDF6WOjRA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Tue, 09 Jan 2024 03:26:59 +0000
Subject: [PATCH RFC] fs/9p: restructure code to make use of multiwalk
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-multiwalk-by-default-v1-1-12226a296f29@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAK9nGUC/x3MSQqAMAxA0atI1gZaq6BeRVy0mmpwpHVEvLvF5
 Vv8/4Anx+ShjB5wdLDnZQ6QcQRNr+eOkNtgSESSCilynPZx41OPA5obW7I6GI1SNjOykbYwENL
 VkeXr31b1+35JeQWmZgAAAA==
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6370; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=WgewrTItOAQlr4HiToExjYr+NGisneCrdPmYsdtv8NE=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnL0NGPYYQdhZdNE8U3VmS78wo/UhAZ2SLTcd1
 zSiDBPQs4SJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZy9DQAKCRCI/9X7Sl//
 mE2gD/0Wfe0drJfuxPzwhR/DRUEP8e9AG5F1SsrsbLvxR4adZFPtkJUVqmCtWogNKgGOwQrynzo
 TCwaxwvokqG2wE15JXAw/oZvFjRN3EH1F0iY23wEPSEUNvxulDIqlMxEdyzjYw3n4HhqpzRmu5v
 CerWHtdL4+bEjiELn4XNHr25JKbA4hQpVyN9EG4DjM4dMKVjhYdiY09BbAD3g+6+6rvEE1oqzLu
 uYzhf4Dq0wULAMsTxpOZQfpju6sGLEW3/sACDy7JzJpm8Kkr183vDaFx3TdD6RWIAh+W/neFqr4
 sYyyJfz01BhhYuVa1HerTVVgThqAeM/Z73kyUGexU5bN/Xo5O+ZdvBjn8U1T0L5/y0beu/JPneA
 vR5U+Asj3jTDYHNQ2iDYOFstvum3NjHjh2AAauX+Ic5BFyvajD0UEKxsZPS7HU8VMZDzVJXb+yn
 7J/F0jAxmkFYgaCp2QCu1G3ya/DDDzvTiJUiAVSGoX9vIj3qHyF3ikXM4oiX9R0+AKpVZi26DkA
 3Od9ZXNz9+bxrp4If1fA5NqPMJVzRJRVUjGxWKs2viLIHryOM+61BO9S6Rt4n6sBY9/pCtKMe7E
 vWnyhqBv89itvunh7+i555FLlsg0Z1jjYOls/X1YQ3A/dL7EXrtpG/UCD6Qdd4iXMYJCWDd0GtD
 unwB5JzD96cVu0g==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

There was some code to use multiwalk, but based
on the existing code it would never be used.  This
patch makes the default to try and use multiwalk
as much as possible.

In single-user code path, I couldn't get this to actually
get tested because it always finds the fid.  I think I
can test with an su environment, but I don't have one setup
at the moment.

Dominique was right that multiwalk is difficult to trigger
due to call-path (it'll always establish entry, by entry and
when those have fids we don't need multiwalk).  I went down
a rat-hole to circumvent this (which started looking very
similar to my transient fid rework).  I do think there is a
path there, but its a much more invasive rewrite than I want
to do this evening.

This patch on its own seems like a cleaner solution than what
was there before, but I really need to find a way to test it
before submitting upstream.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/fid.c | 146 +++++++++++++++---------------------------------------------
 1 file changed, 35 insertions(+), 111 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..502fd8dd1295 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -139,69 +139,19 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 	return ret;
 }
 
-/*
- * We need to hold v9ses->rename_sem as long as we hold references
- * to returned path array. Array element contain pointers to
- * dentry names.
- */
-static int build_path_from_dentry(struct v9fs_session_info *v9ses,
-				  struct dentry *dentry, const unsigned char ***names)
-{
-	int n = 0, i;
-	const unsigned char **wnames;
-	struct dentry *ds;
-
-	for (ds = dentry; !IS_ROOT(ds); ds = ds->d_parent)
-		n++;
-
-	wnames = kmalloc_array(n, sizeof(char *), GFP_KERNEL);
-	if (!wnames)
-		goto err_out;
-
-	for (ds = dentry, i = (n-1); i >= 0; i--, ds = ds->d_parent)
-		wnames[i] = ds->d_name.name;
-
-	*names = wnames;
-	return n;
-err_out:
-	return -ENOMEM;
-}
-
-static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
-					       kuid_t uid, int any)
+static struct p9_fid *v9fs_first_fid(struct dentry *dentry,
+					       kuid_t uid, int any, const unsigned char ***wnames, 
+						   int *wn, int n)
 {
-	struct dentry *ds;
-	const unsigned char **wnames, *uname;
-	int i, n, l, access;
+	const unsigned char *uname;
+	int access;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid, *root_fid, *old_fid;
+	struct p9_fid *fid;
 
 	v9ses = v9fs_dentry2v9ses(dentry);
 	access = v9ses->flags & V9FS_ACCESS_MASK;
 	fid = v9fs_fid_find(dentry, uid, any);
-	if (fid)
-		return fid;
-	/*
-	 * we don't have a matching fid. To do a TWALK we need
-	 * parent fid. We need to prevent rename when we want to
-	 * look at the parent.
-	 */
-	down_read(&v9ses->rename_sem);
-	ds = dentry->d_parent;
-	fid = v9fs_fid_find(ds, uid, any);
-	if (fid) {
-		/* Found the parent fid do a lookup with that */
-		old_fid = fid;
-
-		fid = p9_client_walk(old_fid, 1, &dentry->d_name.name, 1);
-		p9_fid_put(old_fid);
-		goto fid_out;
-	}
-	up_read(&v9ses->rename_sem);
-
-	/* start from the root and try to do a lookup */
-	root_fid = v9fs_fid_find(dentry->d_sb->s_root, uid, any);
-	if (!root_fid) {
+	if ((!fid) && (dentry->d_sb->s_root == dentry)) { 
 		/* the user is not attached to the fs yet */
 		if (access == V9FS_ACCESS_SINGLE)
 			return ERR_PTR(-EPERM);
@@ -216,63 +166,22 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		if (IS_ERR(fid))
 			return fid;
 
-		root_fid = p9_fid_get(fid);
+		fid = p9_fid_get(fid);
 		v9fs_fid_add(dentry->d_sb->s_root, &fid);
 	}
-	/* If we are root ourself just return that */
-	if (dentry->d_sb->s_root == dentry)
-		return root_fid;
-
-	/*
-	 * Do a multipath walk with attached root.
-	 * When walking parent we need to make sure we
-	 * don't have a parallel rename happening
-	 */
-	down_read(&v9ses->rename_sem);
-	n  = build_path_from_dentry(v9ses, dentry, &wnames);
-	if (n < 0) {
-		fid = ERR_PTR(n);
-		goto err_out;
-	}
-	fid = root_fid;
-	old_fid = root_fid;
-	i = 0;
-	while (i < n) {
-		l = min(n - i, P9_MAXWELEM);
-		/*
-		 * We need to hold rename lock when doing a multipath
-		 * walk to ensure none of the path components change
-		 */
-		fid = p9_client_walk(old_fid, l, &wnames[i],
-				     old_fid == root_fid /* clone */);
-		/* non-cloning walk will return the same fid */
-		if (fid != old_fid) {
-			p9_fid_put(old_fid);
-			old_fid = fid;
-		}
-		if (IS_ERR(fid)) {
-			kfree(wnames);
-			goto err_out;
-		}
-		i += l;
-	}
-	kfree(wnames);
-fid_out:
-	if (!IS_ERR(fid)) {
-		spin_lock(&dentry->d_lock);
-		if (d_unhashed(dentry)) {
-			spin_unlock(&dentry->d_lock);
-			p9_fid_put(fid);
-			fid = ERR_PTR(-ENOENT);
-		} else {
-			__add_fid(dentry, fid);
-			p9_fid_get(fid);
-			spin_unlock(&dentry->d_lock);
+	if (fid) {
+		*wn = n;
+		if(n>0) {
+			*wnames = kmalloc_array(n, sizeof(char *), GFP_KERNEL);
+			if (!*wnames)
+				return ERR_PTR(-ENOMEM);
+			*wnames[n-1] = dentry->d_name.name;	
 		}
+ 		return fid;
 	}
-err_out:
-	up_read(&v9ses->rename_sem);
-	return fid;
+
+	/* recurse up tree */
+	return v9fs_first_fid(dentry->d_parent, uid, any, wnames, wn, n+1);
 }
 
 /**
@@ -290,6 +199,9 @@ struct p9_fid *v9fs_fid_lookup(struct dentry *dentry)
 	kuid_t uid;
 	int  any, access;
 	struct v9fs_session_info *v9ses;
+	const unsigned char **wnames;
+	struct p9_fid *fid;
+	int wn;
 
 	v9ses = v9fs_dentry2v9ses(dentry);
 	access = v9ses->flags & V9FS_ACCESS_MASK;
@@ -311,6 +223,18 @@ struct p9_fid *v9fs_fid_lookup(struct dentry *dentry)
 		any = 0;
 		break;
 	}
-	return v9fs_fid_lookup_with_uid(dentry, uid, any);
+
+	fid = v9fs_fid_find(dentry, uid, any);
+	if (!fid) {
+		down_read(&v9ses->rename_sem);
+		fid = v9fs_first_fid(dentry, uid, any, &wnames, &wn, 0);
+		if ((!IS_ERR(fid)) && (wn>0)) {
+			fid = p9_client_walk(fid, wn, wnames, 1);
+			kfree(wnames);
+		}
+		up_read(&v9ses->rename_sem);
+	}
+
+	return fid;
 }
 

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240108-multiwalk-by-default-b33f5b1c1f9b

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

