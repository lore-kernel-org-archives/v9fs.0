Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41A304BBD
	for <v9fs@lists.linux.dev>; Fri, 24 Oct 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305167; cv=none; b=X6c3kw0nlhr8eTayUQ4e4zPZ25jBnh+dWAkPLtffFIYy7HqsJhoVQXT24+uqYsD7QGmRMs7VZlTsXb5D7OMLvS/ZVH+P/997N4xMei+EznOfVWdyQ7f1LoNCIHVd0hX8FDHS9+PHyCjBst6lcqHms7nK7Uirl667ZhiQZ+I2FJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305167; c=relaxed/simple;
	bh=esg5jJJrldcsg4Eme/FaVfbzYkFZVxjJszNLHkfgbVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DNYyvdHRKTM4AQVR2hqtm6enyoOa8ksklAYG8pm1gSadkv1rEmC8YYikfCdfzxDEWlWDbAyWyS/7m82MnKZBqoLztiA+Iy86tWH470+FVWT0ae4qkHeq67BBVoSmyevUtL77JXohJrxcpFcy194/yKuWr9i/xGc+lTjJQL6uBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WK/AcVsR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WK/AcVsR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1958248f8f.2
        for <v9fs@lists.linux.dev>; Fri, 24 Oct 2025 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761305164; x=1761909964; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6njyGgpXnyix7DPfE/AD+aT34+lBZHSBxI3vVRiYPz8=;
        b=WK/AcVsRx0Zbqn4o41EcK9hbKiFZw0zvmv6VLQnLzSIf2dqubFj1FanKa/vO5U+WKw
         r2StmNBatTkvNfSeMdCWRj/9VbyQyVY3s5i/R6XGrwLs4WXYdrPNjKgkiSTglI3ChayV
         aEZqAGwKfNuuOsKUGqj74Yfz1rAGfAH5TrhMt6555hPlj8qF/ZU5qnIp5Jw8xesTWU3d
         iH/a1AEzCaEgcHWQY0Zll+fLRZcKxgTUoNerag7BhFqUgEChOrgBkjTX/xzqUPRwCt6K
         Fss2RUwtKbAQ8RayHBSjdX/UHeGhz6/LEDMbNUVNcRUeSIe8YVG5xtcY9C0kExPWb2jH
         ooDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305164; x=1761909964;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6njyGgpXnyix7DPfE/AD+aT34+lBZHSBxI3vVRiYPz8=;
        b=qwaJeexmKLvA/UfWeJf9OfnayBLxM2BoT+0P1h+kq5KlZIti6yR2n3zNZcsAsb7EvK
         RdQLR9vtDIeUB3C1di562KjcSX5KG9yvrshjgQvD8OxZlKx1+MLpdZfQtttHjc+V0oJd
         CDEsqIknFFklnDVmtaY1WJloiRd3KlOaW+dKReUDAALDqTw0OHWLy4MHskqpuS2fH9Iy
         MJ4XAahtyhcosKXi32bIDwCN5At4+yigPnqU4GnXB0HX/Xpd6hFi/4ch5X3lNobaMOA7
         1kCmSAajy5Y5FDsPYLw4LJtKWvdZ9okF1tw+/umiHLfR+5EIPVRB8uyO7Tq7otzFIrko
         HoFg==
X-Forwarded-Encrypted: i=1; AJvYcCXDy2K7ThroBLvP5GY+st4gJkV9oXxMMAPmrfH9Z3W/nIyHSKgYdUoJkFfEunMiFNDNmup5@lists.linux.dev
X-Gm-Message-State: AOJu0YybCME5LRgNEWOHtFXqZU7WoKLwB+AFHqPqYS3ECyNyPRN6hKPR
	bZLp03VlFe88CvUXqotW9aHQkKyHzwslU6vbJedrjPkzZO1+zu1iykieEY9NEC3W/yY=
X-Gm-Gg: ASbGnctNlOK1C97n5irJztl2ilT0eZSx1Em8EWtLKxy94Ana+++D0tpMFe1QvJuSdre
	zBwOFw5xBf82Hg1FkRCJY5qeGoZdfOjBahskd9fW8gYnuADnq7oG5bjlHpDyxzgwzHwIu26QymW
	DF9uIvKMi+lKCdAIk6uwuUeVKZoKqt4Z6m4Aqzllr0T+LJdxlJELswK2E/0uJRDg8Lt8s/vMYTB
	F5bEOPfVao/pTeMPWUMGqrPRhu2qihN9tKwtoHt3PKnoSBQi3XbaAtOrZGuQchdpr7VkuXPgI52
	MIV4mYtY5Ww5Eb7xDyqTPTbUHd8ElOd3I3xbSecXN6qXSVSnYCH25HiTozJvFJCx1La1UTgvOYa
	tdBU86nWPt5vi3KSLGxLpPCL0qB+Oy0hu3A0wGZhhfa7p24qQqd7BRSzmX71PbtDcmVWTqwvwjD
	J0ori/IQ==
X-Google-Smtp-Source: AGHT+IHTMdM53JxT5mbRrB/df/8148lrYpgmBufghOqk/tj4eesUFtAgikytzGYIeyYeUAUMaIogTA==
X-Received: by 2002:a5d:5d87:0:b0:3ec:8c8:7b79 with SMTP id ffacd0b85a97d-4299075d0d3mr1809575f8f.61.1761305163789;
        Fri, 24 Oct 2025 04:26:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4298d4a49ffsm4962650f8f.13.2025.10.24.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:26:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:26:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/9p: delete unnnecessary condition
Message-ID: <aPtiSJl8EwSfVvqN@stanley.mountain>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We already know that "retval" is negative, so there is no need to check
again.  Also the statement is not indented far enough.  Delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/9p/vfs_dentry.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index c1acbc98465d..c5bf74d547e8 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -109,7 +109,6 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 			p9_debug(P9_DEBUG_VFS,
 				"refresh inode: dentry = %pd (%p), got error %pe\n",
 				dentry, dentry, ERR_PTR(retval));
-		if (retval < 0)
 			return retval;
 		}
 	}
-- 
2.51.0

