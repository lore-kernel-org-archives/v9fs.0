Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB194343E4
	for <v9fs@lists.linux.dev>; Fri, 31 Jul 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510285; cv=none; b=BD6IgnaFF1RvhPnqS4arYKIHXXqIUrrNYXHU6SC6yACLMHS/iVPNxtzcKzszMNke0fPK26jKW9QIlML75NQgp7ew+GwfP5LBPKvQlH1mB8jmrPXUorhQG3Ek7lUfM+JWmdlPDHdmBLr4JmTLRR4GrxH+xN8NnzaxldCoAvRRlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510285; c=relaxed/simple;
	bh=9XfU8m9tSyay/7H/o/K6AIyEgpODnHxgJIw/8azuWlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XlhVRsl1oAtIiINZ/Tdt7TyexMZLRVtiQSL8mk7cPFKZoF88ZZ5lZwOmC+aPiTZlbYJSiwI4gqUk5NYajf6VAKCBCxAfR0YOP9TwM7SdTWNUzM5gJgjw3CHYXlEK0TSzw75AiBffq3cTU+2fTeFSNUolIt9e43KKz6Jgneo3hjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlHUt38i; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlHUt38i"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664b8b65192so131411d50.0
        for <v9fs@lists.linux.dev>; Fri, 31 Jul 2026 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785510282; x=1786115082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mEC1T4rg4Niur9mZ8qTP+i49mzDy92w7tFYDv9o49ew=;
        b=JlHUt38ioAk+WL0KR5jUIv0jwJSoJl6ibY+R49E4Giv9WXmraLX9/EzHVxYAxX8/B8
         3eoQjnqZGhL8EzSshDYckyJVSzfJUQUEwPD9K17o2T9JRU7YOc4u3+rJTIiqifykftZR
         wlbzEFq9IUgON8u+wPqurifQ9TKRzfyCG78hQRH7s71u3haJo8o+x7EQwmXTy4FztAzf
         fzG4pM4U8kCj+FkHa0AZvftsJZLSscxYuGD2PsoErudvMeQnv/3VgxChoRzIvHdYAxY+
         ap4uBzfsz7Zp1mzMnmNNVWSB5DfDRP1VUfh/a4VP3xBpUhvOZ+zMDF+DA1+0rTG+Z/0F
         dYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510282; x=1786115082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEC1T4rg4Niur9mZ8qTP+i49mzDy92w7tFYDv9o49ew=;
        b=gu+uEglJ9/tYUerAKuFDGiPK9dHFGmX/x7mW8D7L+ks/l7ke4YOzKtibiq8Twe6zzJ
         S2VCrXWSWWtsR6aIa8LfG1M1juJ99PkdSgz9ijx3xaxfFHcbPXBc4/QpLPZeJCzYuyae
         W48amVDd4U8fXd+wAzFITyOlfvJnDApiwGeT9fj4438OM/Wm0g3Xwq/Y18LdB/hutIPm
         naPibJ8lsLd2oqI7taYvOKwgvzUU+effGcKZRxQoNzSXI2NzRGz8TNuGUMtEMjEk7231
         17FTodcTlMEcxTTj1R+rdepuji+XAA5bjYSeObgNzNZSjyfyb7ahPS/Mj0gtgrZLm/Q9
         8xTg==
X-Gm-Message-State: AOJu0YznTzsBQcL8x98SYJQlSpdUNtfv2dmHx0o7bRyCfufZ8GNtHsbD
	yutJikl4jJN2J0mRd1bnD0gSEnjRcLZ8JjBJ6HDdF/oXmQp3GlN4KdjG
X-Gm-Gg: AR+sD11JqR9bOBzeLmOHfUftBLVkIBLSANj00pkSI/cc45xQREM34RX3/gqXP3IYpYZ
	BjEs2b7TG7DZ/O7qUBojeV6XwJNo8Abiw5hWIxxsDo5INSf1KKcGST2Mm2wj2nKOtBdliIhT6gz
	4GbWegl/CLy1GJUTJUBbYDBaxaPLX8ivsQ8dlI8ilam9/0IqCDmqYFVkCRigo4lGQCSfmA5SvkR
	3tyLHQb3uutaHEcN/iD2C7ufjKq+r3WgD37Xwdb9W5MYS7RngKzNWO5JNmE1wkmasLQCWTUsCI1
	pBHWSFS/eHmTeDpnNEKkGKnb+VGQoNMcfBiIDNgOBqClRTNrnv5uX6LZ9b6qXpJiFgigb71LPaK
	fMzuhX9i5ws2OBeLm/bU7FR87TOncL8yVax96Z/QF3Ba19e6H3ehFXavy8XaYbkNdeA6+dJxqr6
	lWUvJrBMKGklMtCAPGtADyl7yIkpn8wp9QZhcB1+JuveXSAAFjcsgUueYqLC6+sPKEm9IbLXOpj
	4slw2dNcGu/6yjGR+QTvhwXmsH87xhcCRMysAadkzDDVrkAbCCVUuw=
X-Received: by 2002:a05:690e:4544:10b0:668:99c7:2bc6 with SMTP id 956f58d0204a3-6694f23f018mr216528d50.3.1785510282473;
        Fri, 31 Jul 2026 08:04:42 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948cff867sm696184d50.4.2026.07.31.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:04:42 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <mgr@kernel.org>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/9p/usbg: fix descriptor cleanup use-after-free
Date: Fri, 31 Jul 2026 23:04:14 +0800
Message-ID: <20260731150414.3135662-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb9pfs_free_func() frees the f_usb9pfs object before calling
usb_free_all_descriptors().  The usb_function passed to the latter is
embedded in the freed object, so removing the function from a gadget
dereferences freed memory.

The failing teardown sequence is:

  configfs unlink
    usb9pfs_free_func()
      kfree(usb9pfs)
      usb_free_all_descriptors(f)
        dereference the embedded usb_function

KASAN reported:

  BUG: KASAN: slab-use-after-free in usb_free_all_descriptors+0x138/0x190
  Read of size 8 at addr ffff888106a73088 by task poc/95
  Call Trace:
   usb_free_all_descriptors+0x138/0x190
   config_usb_cfg_unlink+0x1f0/0x2f0
   configfs_unlink+0x321/0x6f0

Free the descriptors before freeing their containing object.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/9p/trans_usbg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 419cda13a7b5..8c2f0d8592c8 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -725,8 +725,6 @@ static void usb9pfs_free_func(struct usb_function *f)
 	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
 	struct f_usb9pfs_opts *opts;
 
-	kfree(usb9pfs);
-
 	opts = container_of(f->fi, struct f_usb9pfs_opts, func_inst);
 
 	mutex_lock(&opts->lock);
@@ -734,6 +732,7 @@ static void usb9pfs_free_func(struct usb_function *f)
 	mutex_unlock(&opts->lock);
 
 	usb_free_all_descriptors(f);
+	kfree(usb9pfs);
 }
 
 static int usb9pfs_set_alt(struct usb_function *f,
