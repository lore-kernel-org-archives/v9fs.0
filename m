Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C686353
	for <v9fs@lists.linux.dev>; Sat, 22 Mar 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742657950; cv=none; b=TvQbY8eAl2UCVJHPfBukLYKt0RuW25GOWFX57ePnxn2g/pDwvoGuyZGsUsKNKonSAuiaNkGFPM/2XoWkjpW9coQdBJ3sSFBxB80EYmOiGsOjsGdPMg3EHRvDgqc+RbX4OhkEigTtXig3DdB/t37vo7H5STcrCzlPrBzxl63aLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742657950; c=relaxed/simple;
	bh=WHARC3Nzff1uZ5ZfEW+7Q/6rg2A3pfMsEGrJWaxBQjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MmoEtQ9RDRY1ZIycYgek+tkRKZ9mn0sLc7xzIhG0jfjssGgkNN8Mg38DjH758w2sCy2JN6lj1RRwdVJ2tOzFJcd+/xb35L89g4k1lCN2TQVnjcx0qUsjoz+vuhg2iFkXPXm4dWjn5RvxEPIwOjPFICJ3QKi4N1/OcCFBW1vr5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=DXAqvnZz; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="DXAqvnZz"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 52MFciaa024937-52MFciac024937
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 22 Mar 2025 17:38:44 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1tw0vs-007cB3-4m; Sat, 22 Mar 2025 17:38:44 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Sat, 22 Mar
 2025 17:38:43 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 933f0184;
	Sat, 22 Mar 2025 15:38:43 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <v9fs@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
	<asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation/fs/9p: fix broken link
Date: Sat, 22 Mar 2025 17:36:39 +0200
Message-ID: <20250322153639.4917-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-01.utu.fi (130.232.247.41) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhaXUgEAQYdEEUMBwsoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhfSFhIWEhYSFpaSAkbBQkMDR0bKAsHDA0fGg0LA0YHGg9IWEhZXEgLBxoKDRwoBB8GRgYNHEhYSFlfSA0aAQseACgDDRoGDQRGBxoPSFhIWl1IBAEGHRBFDAcLKB4PDRpGAw0aBg0ERgcaD0hYSFpbSAQBBh0QNwcbGygLGh0MDQoRHA1GCwcFSFhIWV5IBB0LAAcoAQcGAwceRgYNHEhYSFpYSB5RDhsoBAEbHBtGBAEGHRBGDA0eSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=40sLRjlGyKYYF65xfJkKQZc0ed9roRBzndmq5fi4YXo=;
 b=DXAqvnZzZfUOak86jA7ua4ORR+/1qjVr0pkFH3QR/4kRkW9CgHLAlysUkNcDiccsSjyn8pNYwYpT
	zsqX85iqZF37AyifvFhcveFwC4f8sdIV0xvgZHa5sQ0v0eUYSPbBby3hig+u7KBJjbFi16Wj3MEX
	ZbyngnimDSpJqXwr0TUk4tMt6zoBpAkz/9j9Uoj+lq+lFqHUJeGd6M5W664gTXPqP2FIpUfXerkp
	ryfrsMO6260TyOKAWWeYcRlxtB09+/TjPSDOn7fVeMtvD76PxOCX1GgSbipCjwMuYrOnLGrGfdNd
	gIyMsc32gkF2CMQCO1V9brahMoyMznie859izQ==

In b529c06f9dc7 (Update the documentation referencing Plan 9 from User
Space., 2020-04-26), another instance of the link was left unfixed.
Fix that as well.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/filesystems/9p.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 2bbf68b56b0d..28871200e87c 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -40,7 +40,7 @@ For remote file server::
 
 	mount -t 9p 10.10.1.2 /mnt/9
 
-For Plan 9 From User Space applications (http://swtch.com/plan9)::
+For Plan 9 From User Space applications (https://9fans.github.io/plan9port/)::
 
 	mount -t 9p `namespace`/acme /mnt/9 -o trans=unix,uname=$USER
 

base-commit: 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
-- 
2.30.2

