Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4E146D7F
	for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377521; cv=none; b=Us3KYyn4RCXNhjjzvupNdkeb+ccn19mnynS9ueOW3bUVK4GBvw9AUuMSR7IR8C5P2ptoUad9jGZgKi/3aQ74zUOWRKyCHEi7EoT2JiAF1ISho+h+823hnyJxdqf13HIXmxY9V7dqAoofgK2tUqnPHV/6AkloxFr0U+bP+lwDvHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377521; c=relaxed/simple;
	bh=xJHEHWHhJmoUVG/Pdw+vyjuBG/tVovhjwXcJAdSJS/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZwKpu4fYlHHw2+WLFir7PZiAlKe+MzVYB9ZI2Y23kOCLVOtkLtyVO/ShBdva0RcQ9ZEfYAvXtp6jqlneIKh2cGQ+xZqPk1JgoLDqN75+hPQxjfvlWUvWDgLxztwAi9hWhFc8EaZYemV07Uha9K1emOC9f/16JvH4azsrGlvY8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uaw0ed1o; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaw0ed1o"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518a56cdc03so5500658e87.1
        for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713377518; x=1713982318; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIJtYnUQ5AAtgS9HaT2/DLco/xdNOScHx18B777UjDs=;
        b=uaw0ed1oKyvU7SqDwEkf11gy1Hb2pvMPdjN2nUz12Uh5vhgmitYtD76u6T1LvI8rDi
         8AzDF+7nZRoFxIzU3GZRon5p+hSZKdLN+1jygUHadnn3dx0EWHYFKts2xCeepWNn5Eyo
         xEuqCqoGggg0i1Hfwjr/pMp0Fwv2wb9wFbkp6b1emor+HzA9t8irotj9fq1dqyC+U30i
         WJPb/mqBE5DMUx/q9tKHsIzu6HVKUIfAxACqwLp4M4k459PQNZhKu1NgiWi2sCqx/YUN
         6f/ZXAY0lRsmxkfdkHg3Dcov5QhwgxF/N9obB/uFt7LGPimp8Ka7V/RsXVI8PmAr95Sk
         a9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713377518; x=1713982318;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIJtYnUQ5AAtgS9HaT2/DLco/xdNOScHx18B777UjDs=;
        b=dydzvPiGioNMuVyTcxTyRvJCIOA2zg/k+v/YIXOk0A5loC3CFRPsNn2ZRcgLc8voqE
         FO8qv7uiwjirr+TpXL+gw7uDxewkO/D7fNgiW8ve6iT9y83ztUNHtb7RTq9hdso24+jd
         UFPUiqY2VBaeoBgVcSjPrsAaYIkfEXKpcFxx9zlVcw0jDIQLqDVWIOSbvbPeqjHmec8c
         09vgzLMGiyEP2WDJ7vBDE/ElcVMaudVnqIxe+B8MdNvsm2GStGqGoGNtNeQTQn/z/7R/
         dP2LfMuaaoveFSw6utZ73Xhv+8FQbBUO2JHRY48wGxnhmn24XOpab9oTDqnJY93MZsBk
         8I2Q==
X-Gm-Message-State: AOJu0YzKV27wYlOXhAAeR+aF2eIrzgvs6Xg/f4ry/C2j40GrLqzMMHZR
	QHSB1tYVhsu+RpTnoL9+4VA9VhCjTYFrgnk3NeLkZbCap1FBl1ir3NtIS0XY6aY=
X-Google-Smtp-Source: AGHT+IG3+kCnCzkWv/785MvGldeo2hBwvfPxFjpQEnWsob/rkwmBImIAInFK98IT6QaSzR4VEc/M9g==
X-Received: by 2002:ac2:4850:0:b0:518:f2f8:edc6 with SMTP id 16-20020ac24850000000b00518f2f8edc6mr30329lfy.63.1713377517539;
        Wed, 17 Apr 2024 11:11:57 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ji16-20020a170907981000b00a5244a80cfcsm6377626ejc.91.2024.04.17.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:11:56 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:11:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ericvh@kernel.org
Cc: v9fs@lists.linux.dev
Subject: [bug report]  fs/9p: mitigate inode collisions
Message-ID: <5d527d1e-95de-4e36-845a-897cabdcaccd@moroto.mountain>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Eric Van Hensbergen,

Commit 6ae7784008d9 (" fs/9p: mitigate inode collisions") from Apr
15, 2024 (linux-next), leads to the following Smatch static checker
warning:

	fs/9p/vfs_inode.c:513 v9fs_remove()
	error: uninitialized symbol 'v9fid'.

fs/9p/vfs_inode.c
    470 static int v9fs_remove(struct inode *dir, struct dentry *dentry, int flags)
    471 {
    472         struct inode *inode;
    473         int retval = -EOPNOTSUPP;
    474         struct p9_fid *v9fid, *dfid;
    475         struct v9fs_session_info *v9ses;
    476 
    477         p9_debug(P9_DEBUG_VFS, "inode: %p dentry: %p rmdir: %x\n",
    478                  dir, dentry, flags);
    479 
    480         v9ses = v9fs_inode2v9ses(dir);
    481         inode = d_inode(dentry);
    482         dfid = v9fs_parent_fid(dentry);
    483         if (IS_ERR(dfid)) {
    484                 retval = PTR_ERR(dfid);
    485                 p9_debug(P9_DEBUG_VFS, "fid lookup failed %d\n", retval);
    486                 return retval;
    487         }
    488         if (v9fs_proto_dotl(v9ses))
    489                 retval = p9_client_unlinkat(dfid, dentry->d_name.name,
    490                                             v9fs_at_to_dotl_flags(flags));
    491         p9_fid_put(dfid);
    492         if (retval == -EOPNOTSUPP) {
    493                 /* Try the one based on path */
    494                 v9fid = v9fs_fid_clone(dentry);
    495                 if (IS_ERR(v9fid))
    496                         return PTR_ERR(v9fid);
    497                 retval = p9_client_remove(v9fid);
    498         }

v9fid is not initialized if retval != -EOPNOTSUPP.

    499         if (!retval) {
    500                 /*
    501                  * directories on unlink should have zero
    502                  * link count
    503                  */
    504                 if (flags & AT_REMOVEDIR) {
    505                         clear_nlink(inode);
    506                         v9fs_dec_count(dir);
    507                 } else
    508                         v9fs_dec_count(inode);
    509 
    510                 if (inode->i_nlink <= 0) { /* no more refs unhash it */
    511                         remove_inode_hash(inode);
    512                 } else {
--> 513                         p9_debug(P9_DEBUG_ERROR,
    514                         "WARNING: unlink inode %lx %s qid->path=%llx w/i_nlink==%d\n",
    515                         inode->i_ino, dentry->d_name.name, v9fid->qid.path, inode->i_nlink);
                                                                   ^^^^^^^^^^^^^^^
Uninitialized.

    516                 }
    517 
    518                 v9fs_invalidate_inode_attr(inode);
    519                 v9fs_invalidate_inode_attr(dir);
    520 
    521                 /* invalidate all fids associated with dentry */
    522                 /* NOTE: This will not include open fids */
    523                 dentry->d_op->d_release(dentry);
    524         }
    525         return retval;
    526 }

regards,
dan carpenter
