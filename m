Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED8156F41
	for <v9fs@lists.linux.dev>; Sun,  8 Sep 2024 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795282; cv=none; b=GgLwY7res516xHme4W/lEtZda9u8Q3s3+dBkFmOVfDxPgH5UDd3GQ4TXkBi/zsJyTWiiPv3DRe6oZGHy/aH94Xp/bpeManaNH8Pcm/gnL6rwn09DZ4pGN+QBzer5O13vI7iSzB9cfsJPP43+voZl+8qBJLgRGtPpDSyWM9WfirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795282; c=relaxed/simple;
	bh=l8Afgqu3WXAVFAIqNvZ59IhIs09LB+0FmnTuuXCr790=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIyuXrWkN+C+4A7Qj355bASOkBDhoQrNhHCS6S10w7X7GyJ+c8emxhW3Q7UwJvv2OOA8BoFmJd5ZipF1oboJpbMfhjCGCB7FwT/J6PtT78NtSYl9pCiAXB5t+WmQRyHmaT1Tr/mjsjFz2JxtnxouHMcSQT9Ap0ocppJQk6Mcneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcA5JgvW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcA5JgvW"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718d606726cso1572027b3a.3
        for <v9fs@lists.linux.dev>; Sun, 08 Sep 2024 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725795279; x=1726400079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TevhFPkg0ehgq3/IrZZMrhzq3fN8W8bdolBRTCGu5DA=;
        b=AcA5JgvWJ/nkd6ZhESwj/Wy/3iyCXtAcu/bvSeVk2cQ/ubdM7CwmxrVhF+JWuBGZZL
         dwOcGd426mwaaTZ7QhlLAiXrK3HQgVtAwCCxuMoWfX6s0X1TD9/zW3blIqf7+EC3gKg4
         YYL1dyinmwWnpFIeS9NwR+3kx1OhZFtFkO+c69GEtRuktPvFrjeJG1pgYosJ0kVTxy63
         4eAxaRaP9fw8wc6/rCFSwZTtS/2jb5NbcruyxDSKkkAyzA3ATwPlPsVIfvZTQqaWa6Rn
         zfgGJHx/IfoZRaPlWCUW8Cy7K7UWisRiQJpIB0f/FKF0EDIShNIAMehZnKxjjJlKgeum
         RaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795279; x=1726400079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TevhFPkg0ehgq3/IrZZMrhzq3fN8W8bdolBRTCGu5DA=;
        b=fed6bXZRM1bevkAyqP2Qto34OZFX1eURlQU3muEdUlAw+a97kXTWAOUOCu16o0drxc
         ygwL2BKXxOXPmbHuiECqBIB2eo5lCYtYAzOIeSOqVF0Rib2G40zRxS4dznnMW5GkuOf9
         Z6MG8ncH4YMBKU6H1G7wzmvlFNxtUyHSTgKBBshTEazvovclCaUQqzcasCOnFfQKr14I
         Q1XDodqZHoK7yy6Hd5JDnSwMCglkxXsTOVlu5W/N2rNV8oAji7jFALmMV/qWsLhRjaGj
         yuO9N1dshs8nyhJWMt7GCYT/6E5DjPgit+e9HwpzeZmRJHRaIZIQr/bBtBHxT4YbkjGO
         iLcA==
X-Forwarded-Encrypted: i=1; AJvYcCXh0K3ME0MqQCtR8rBMVlrU+RJIAQmH0//AFx/hOTcBLMitmy24e7hGeK+imhwpsF0QBAos@lists.linux.dev
X-Gm-Message-State: AOJu0YyGVQAnzt0BLXzoV/MZ7K18tjkRl4KjRGG/dlc5kuKqK7Qtk8xD
	66paSGiecZBp9iA6NhyYcBr8fiAomBuLtgS1ly500IhznPx0c8NA
X-Google-Smtp-Source: AGHT+IH6GPQK9EkkIM7ZYRVSmYXzhsKD5YcP8izmijFJcd7CdVzsEBDd4KL7pL76B3SbTRorF5l+dQ==
X-Received: by 2002:a17:902:f547:b0:206:ae88:417f with SMTP id d9443c01a7336-206f04e17fdmr111199545ad.6.1725795278085;
        Sun, 08 Sep 2024 04:34:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2071a6109cfsm13980345ad.175.2024.09.08.04.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:34:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A1ABB4A19C6E; Sun, 08 Sep 2024 18:34:31 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux USB <linux-usb@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Jan Luebbe <jlu@pengutronix.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] tools: usb: p9_fwd: wrap USBG shell command examples in literal code blocks
Date: Sun,  8 Sep 2024 18:34:23 +0700
Message-ID: <20240908113423.158352-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171; i=bagasdotme@gmail.com; h=from:subject; bh=l8Afgqu3WXAVFAIqNvZ59IhIs09LB+0FmnTuuXCr790=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDGl3uw48Tfu/RCuuck9OdunT1UdCLn944Nl8dsskHollK qqXIr9+6yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEjtsxMkw8xnBop8Aap+KN O1+cKlqz79IftZsZvI+6tvJnr0kR9f/B8L9+53RdkbCzO1rnHdz6QMzJtYxvUZaNP3tK66q0R1z vrXgB
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reported htmldocs warning when merging usb tree:

Documentation/filesystems/9p.rst:99: ERROR: Unexpected indentation.

That's because Sphinx tries rendering p9_fwd.py output as a grid table
instead.

Wrap shell commands in "USBG Example" section in literal code blocks
to fix above warning and to be in line with rest of commands in the doc.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20240905184059.0f30ff9a@canb.auug.org.au/
Fixes: 673f0c3ffc75 ("tools: usb: p9_fwd: add usb gadget packet forwarder script")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/9p.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 2cc85f3e8659ff..514ed13a0122b0 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -86,11 +86,11 @@ When using the usbg transport, for now there is no native usb host
 service capable to handle the requests from the gadget driver. For
 this we have to use the extra python tool p9_fwd.py from tools/usb.
 
-Just start the 9pfs capable network server like diod/nfs-ganesha e.g.:
+Just start the 9pfs capable network server like diod/nfs-ganesha e.g.::
 
         $ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD
 
-Optionaly scan your bus if there are more then one usbg gadgets to find their path:
+Optionaly scan your bus if there are more then one usbg gadgets to find their path::
 
         $ python $kernel_dir/tools/usb/p9_fwd.py list
 
@@ -99,7 +99,7 @@ Optionaly scan your bus if there are more then one usbg gadgets to find their pa
           2 |   67 | unknown          | unknown          | 1d6b:0109 | 2-1.1.2
           2 |   68 | unknown          | unknown          | 1d6b:0109 | 2-1.1.3
 
-Then start the python transport:
+Then start the python transport::
 
         $ python $kernel_dir/tools/usb/p9_fwd.py --path 2-1.1.2 connect -p 9999
 

base-commit: 9c0c11bb87b09a8b7cdc21ca1090e7b36abe9d09
-- 
An old man doll... just what I always wanted! - Clara

