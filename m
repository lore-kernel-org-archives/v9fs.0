Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2EE14E2F3
	for <v9fs@lists.linux.dev>; Thu, 11 Apr 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843555; cv=none; b=qLA4KP71B4wHxKP6WAmDWSJR+slM6drDhKsbhQ0PL5zcVWkWkTisNaU4/tuALz6C4hirIuJyeg4m5GitCz/0IZTlLSRCKZJ0nv+kubnEs01fYfIpLPNIH0HvRPIAcdRGMMDFrbOGLA/flDcFp5cLPGsLF4RuXQUK9aZbd4FTeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843555; c=relaxed/simple;
	bh=gX+V/rAyNYBt1HTuJNTsPikDXoD4GZeFcx8GczlF3XA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XW9xaOHN6muYvAfrwCewR5cnBF/2AGt242Q6ECCqfblNh6DiNU5FtwccN/GiDLc2Hc1o4R/KnqJV0oH9Nhm1lAP9cGUK6kX/R4bjVaoMYvf11dV5US2GHKJQtAfutRDyVEVXCKLTCFtEX1WE9X2jF5jkrY+W5SZvl6pFc3cclU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUNl26dE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUNl26dE"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6114c9b4d83so68234977b3.3
        for <v9fs@lists.linux.dev>; Thu, 11 Apr 2024 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712843553; x=1713448353; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vyF6pPtvtzUxauZeIWWisS/B6GyYAQ4u7iu8BDcabjw=;
        b=fUNl26dElje5dlEmFARVZDB3jY7Ye1l7nWNfk2O3MBQgLAFaGLClJe4nRE4PgHJnOL
         qioZFPTunH8BcGOPxhlKBJHuy1t2etX0CH4zrffdYKevZ9Wp+9uba5BLHO8GBDygUkns
         T6iMH65magsljDGxiTBjSFMRf5ijbuz27eYfNqfvlvf7FwIqQ4SF9QMbVF2pphGUxuXr
         9AK6ntscOa9LNbkaHzaZ5fJRJi0KFviTjn8kQzTV3ii8Ihn8HK5Ov/+yNZyrFRDGYstg
         0SzQsWZVU30zkQST/NCp0uoPmr4Wq9ZyQKBTh7fiSIzYqlUznMLTUzfrVC05RcQ8iZ9L
         WoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712843553; x=1713448353;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyF6pPtvtzUxauZeIWWisS/B6GyYAQ4u7iu8BDcabjw=;
        b=TxVZlZs/p9E3/bfhXQBrL3+KZs+hfY+eeahh6gbxW/osU2kzrpArAR+ICok9RexSeS
         0tgATjexxyuCLt/y5IHK0j2bSjpv0Bf4J0cD6L9NNR5ZemRAv1E3nj/FiuZ3Kbm+0QEY
         X/qjDiZwst0pB/wC7YEC3HlHfRa3DYvtFVr1872r02Zzoc+7/lbZcSgOEHQacOkf2M8U
         RSCjjQLfxqJF7JildvpziAN4yKJJ8zvWeEVudRpebgE9dBCyNo58TiLCxwAed8xuSLpC
         xTg9SlZJ39PJdgAIxW7chk4zjzaJm2zvvA51T2PDDw/mlisQMONu74Yen8QK5YrlQFBD
         3i4w==
X-Gm-Message-State: AOJu0YxjbIa0OGBHrcfAqL3BU17QAYQGMBqIR1r8esGAQBEFz+N20szX
	ZNNZqoUsHlhg2VfYFjB8pn4x2vbbfzq0CK08oE87T4lASf0Bk1ejJ43A6nXdC8rd09WQyM30pQj
	6OlVF7jFe3R52mrQTZE7m5RQbzBVfcjAl
X-Google-Smtp-Source: AGHT+IED0LmNXUx+Hp5W58eZ08gBCEVboGgqcGgqhF8X0FMEukv6+M0IY0/Ok2MeFf1aDt3vyvugH8XGTzsyWiVrS+0=
X-Received: by 2002:a05:690c:92:b0:618:4a3f:2752 with SMTP id
 be18-20020a05690c009200b006184a3f2752mr5678378ywb.11.1712843552925; Thu, 11
 Apr 2024 06:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: Thu, 11 Apr 2024 08:52:21 -0500
Message-ID: <CAFkjPTnn+Oc55hNg3B_aDE7=0bm2AHJRW5wpksA4N-QiutPGpw@mail.gmail.com>
Subject: Update on inode number collisions bugs in v6.9
To: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Just a quick update on this to keep everyone in the loop.  I did a
number of experiments last night -- it does seem that reverting just
the drop_inode removal deals with the collision scenarios (at least
the ones where the loose cache isn't being used) that aren't
overlapping mounts (like Oleg's case).

The likelihood of these collisions seems to be heavily related to the
underlying file system (and its use of inodes).  As part of this I
diagnosed that my dev regression environment was actually using a
mount of the an underlying OSX volume (via Docker) for the regression
file system target -- this both slowed down my regressions (which may
indicate a timing related issue) and likely has very different
policies for how inodes are allocated that most linux file systems.

I switched my regressions to a ext4 volume mount and immediately
started hitting my asserts I put in to find inode collisions when
running dbench.  Almost all of these seem to be happening when we are
expecting a new inode but finding an existing one.  As I said, these
go away if we are aggressively dropping inodes (old non-cache
behavior), but seems to indicate we have issues in some of our
accounting which was also indicated by by the inode bloat in legacy
mode (https://lore.kernel.org/v9fs/20240315155732.77dabf51@eclair/T/#u).

In any case, I'll likely send a revert to the drop inode today so that
other testing is unblocked, but I'm going to try and drill down on the
inode accounting problems before I revert the iget simplification to
see if that addresses the regressions in cache mode.  We still need a
client side mitigation for the multidev problem, but I feel like if I
can unblock Kent and others who have been struggling with their test
environments, maybe I can buy myself another -rc or two to try and
find a better fix that keeping around duplicate inodes to hide
underlying problems -- which seems brittle at best.

      -eric
