Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DA54673;
	Mon,  9 Sep 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873471; cv=none; b=P7EpdNs2PM1a6AaN6LZThztxGC0tWwRIwm4Md77EGyGP9vgvYDuH48OxFMbbHS9XlTKMvtv+8efRlrCuLNeAaE0mnSDCpMdW/cX3oqRN6naB8sIeDaM9BuMxBbCO6HQAiGtlaihTXyohbdkxO5eGrUm8rLIF13v7DwmxoiN82BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873471; c=relaxed/simple;
	bh=vMsCMBWWCN5qiWU38RYxz/K8nuEjx26DHh6Qg/t71Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fPyODCBMe1OSQbpYHDPic2+QEsyfuxmkxvE2whfknbM/XjlhDHdHCMSXpcMvmk5eiuLUr1jTo89SC+CQ0uqBQZaKuUtATbLy0IjG4Aqh3ozRCtKjnSyDid0XiCzMni7ApM/LXOqcWbQU6QSDiK6q29/R4ozUKrktptWi8isfYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL+6v8OV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL+6v8OV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2863EC4CEC5;
	Mon,  9 Sep 2024 09:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725873470;
	bh=vMsCMBWWCN5qiWU38RYxz/K8nuEjx26DHh6Qg/t71Sg=;
	h=From:To:Cc:Subject:Date:From;
	b=VL+6v8OVcj2rTW7i9pI6tHFjJiC9w9tzsw9RdAQyKe/sGlHYPVOCoZNvVAv5Cgx12
	 AVNFqrDNnRWvS7Qd/oAShRQQVrCi0stzeOtexxHuW0X0xsUIo1w0atNgsw/C0YM/CG
	 be2Ug/Pc+Akk8200KKIGW/fdp2aJgtxLeOvXE8UkgZ1s3OV1yGAjeQTWeM4bhwM0bq
	 dv80JwKpM6cis+eWxU4gGZDRbwZxsavaXdCGG8ETxkUCNZnogO6+TfNv+D3sn22cVI
	 llWg388P+MfKZUamLdbpVGD7YNtOA2fkgz8WGWSnmsOTlHizhUHQ/dw8hwrmVpsziH
	 RucaUXFOzhpiQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/9p/usbg: fix CONFIG_USB_GADGET dependency
Date: Mon,  9 Sep 2024 11:17:38 +0000
Message-Id: <20240909111745.248952-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When USB gadget support is in a loadable module, 9pfs cannot
link to it as a built-in driver:

x86_64-linux-ld: vmlinux.o: in function `usb9pfs_free_func':
trans_usbg.c:(.text+0x1070012): undefined reference to `usb_free_all_descriptors'
x86_64-linux-ld: vmlinux.o: in function `disable_ep':
trans_usbg.c:(.text+0x1070528): undefined reference to `usb_ep_disable'
x86_64-linux-ld: vmlinux.o: in function `usb9pfs_func_unbind':
trans_usbg.c:(.text+0x10705df): undefined reference to `usb_ep_free_request'
x86_64-linux-ld: trans_usbg.c:(.text+0x107061f): undefined reference to `usb_ep_free_request'
x86_64-linux-ld: vmlinux.o: in function `usb9pfs_func_bind':
trans_usbg.c:(.text+0x107069f): undefined reference to `usb_interface_id'
x86_64-linux-ld: trans_usbg.c:(.text+0x10706b5): undefined reference to `usb_string_id'

Change the Kconfig dependency to only allow this to be enabled
when it can successfully link and work.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/9p/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index 2d7e596e22c3..63f988f0c9e8 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -42,7 +42,7 @@ config NET_9P_XEN
 
 config NET_9P_USBG
 	bool "9P USB Gadget Transport"
-	depends on USB_GADGET
+	depends on USB_GADGET=y || USB_GADGET=NET_9P
 	help
 	  This builds support for a transport for 9pfs over
 	  usb gadget.
-- 
2.39.2

