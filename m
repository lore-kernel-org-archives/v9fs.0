Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C08405C59
	for <v9fs@lists.linux.dev>; Sat, 16 May 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778922518; cv=none; b=i85zUYXpl9mvEVvpE0ij7b6fBo+LdPvD409jMlEMXV7A2lMpY+CAYbkmlCwhst8zxlfWSgfRztBgnVc567gR3pBTy1KPHOKsLpRr4mKXvvNtOijVK+slCqZfwtuU6M88w4yomJiuIcwwU6iOU45zhvQVjpN9Xqy7hmkbckoOcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778922518; c=relaxed/simple;
	bh=lEM/uFs8JgoZFzVMCP1XgQpcA+rsQdco84WFpWLSfHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfQ5YIjOCYynJKAlEp9tMmQJF8/UoTZFPXGPp+zuDfUyA+nW7iRdsnGMJt489yKh0XsVFRha7UDlEwT7l8f+TaXVhSVbA7nIyuiw8qI8nhmIRoA7pJfvWeORjFNyE438ahCO7+tUyrEKts4RTfUj9SXaEqnT1L1aLy/gqAiZgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LqmSp2jn; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LqmSp2jn"
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id OB0ZwntsoDTmsOB0Zw7Wky; Sat, 16 May 2026 11:08:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1778922513;
	bh=8ExfsbKHlN1xMBejAZsls6S/8xiWPK6W+llnN5OD7BQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LqmSp2jnyoUk89oHfzyPDRAcaSoeWpK7itUYK2NH6tpTJYsywiwg8BgdwdxJO0Z6a
	 0oqJ9ef14xMMygCgEoYhzkxjV3nDnzrrefN4xhAUg1t4IHt77qXjHWHRB2QIO7f2Zb
	 iT4ypzPPEF4nbqh4ajliMkjJz4qvNVFskG7w59lyvCMndZA6k1VeBbPxir73SkmBSi
	 1ITkrG7MVr26t41EMhm67d1cIKsmWDZNflThqme9VDWtkOhiuCH23tMTFe68fqcU/r
	 30iTRDoWkA4FPnzPjZJZb9LCIHwQdviD5tJpXfRcg5GA1YlLghfgKgV8o6/vX40QWC
	 69yy896zfGVxw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 May 2026 11:08:33 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	v9fs@lists.linux.dev
Subject: [PATCH net-next] net/9p/usbg: Constify struct configfs_item_operations
Date: Sat, 16 May 2026 11:08:28 +0200
Message-ID: <2478bdabd7d169a686879c049f11dc307b5debbd.1778922467.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct configfs_item_operations' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  25167	   9336	    256	  34759	   87c7	net/9p/trans_usbg.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  25231	   9272	    256	  34759	   87c7	net/9p/trans_usbg.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/9p/trans_usbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 1ce70338999c..419cda13a7b5 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -804,7 +804,7 @@ static void usb9pfs_attr_release(struct config_item *item)
 	usb_put_function_instance(&usb9pfs_opts->func_inst);
 }
 
-static struct configfs_item_operations usb9pfs_item_ops = {
+static const struct configfs_item_operations usb9pfs_item_ops = {
 	.release		= usb9pfs_attr_release,
 };
 
-- 
2.54.0

