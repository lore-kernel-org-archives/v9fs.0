Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077842D8DA6
	for <v9fs@lists.linux.dev>; Tue, 24 Mar 2026 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366232; cv=none; b=Pqd3LIp6VXdmSjWTN5Orew/eAxhsYqnps9cEsuyJo2ZuqG3t9V4SAmAlGLAHtlsapQM3JABod8rTDabTSlWODwSryr3M9zNljvdKAxRrqUgmKoD45cFYgaQy9S08mAO0vKn2iptFJwZwnlCKv035CcMBiXwv7+mq9QIwnrHAKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366232; c=relaxed/simple;
	bh=Bu2wHnsfyVCBRLqs/qFqpCpWbNZU9IWydkfD9a+hfmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0tU5ZmqYLY+VN0MArBeJskYmud4+GaeSzkglL4rBlV2scts+U/VfS4qGgaPhxJrqchAXDAB/qAUm+vLKeYOKxMnQdNq+pDMX9twwAnIXJKzPapuNm7jmldjHGpDbV4wb9DKqm0RMpdHZQO45SIXfpitUvl0OtXXKb7i1LG0M+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbuxkS4m; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbuxkS4m"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2c0bb213b16so9650934eec.0
        for <v9fs@lists.linux.dev>; Tue, 24 Mar 2026 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366230; x=1774971030; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ+kgyofxnEfZs4ZHfEa7STlMNaQTks5c3rgcS6drhI=;
        b=XbuxkS4mXHurfbrmubUE0OTTYnoUaxM0/v8mKEHRxSKQvMtIpxUO5s+IRScH7J3eFF
         5HLH9mNpDv7b2yDeq9zUzcNkRepOfjGFZeX400Mg2mi5DK1RtVl6WONR2d74CQnM6nba
         oeJzXXaNRBhhnG4VcTj1+yzWS27A0INP0ekNotoIDmp+98QpxeC+nrtEzRRTsFD3HPrw
         BuEbx2GBFS3V8VhR3Jezs5nhdyTxFmLEGUIIyXebZh67pJoltW/+cuEm5J3+Uvg34WTM
         jdMbOlS3lg1azDAR4Y+ihVOWfbBwqzh1qdETi4k87kzb7O66Z+ZqyYo/PeZZTA9QqmiM
         ObAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366230; x=1774971030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ+kgyofxnEfZs4ZHfEa7STlMNaQTks5c3rgcS6drhI=;
        b=q2gwPw/MMmcZgsc2s22hpRTB0IC1hlZKlTnL+UurIaOuc2XJcwdFlv7AOTd9hkj53w
         bmmw0B5FXr1VWw4UQ3Y4OMbC3bUOPmaoQrk+2TIJKCajQGuU0ozVOFJ4bruvHHwBGZA7
         q+N8ZQ9G+kl/RrOwThZbJ1z+rLhG61qAa461Yvy7qvIoyiqge7VZeOtwz5+FveCbx5pl
         HGcpXW9VSohf37rINHRlxO7jTE/0jlDaWn2SbnisARUdfP7PpdC6wwJictLK3WC1CVjD
         VzMER2Fx13+/2MdufEbrsBsJfznxLOdPSF6FpqWkhPrigg1gHR8HoG6BVffoJuAhJXCW
         3qSw==
X-Forwarded-Encrypted: i=1; AJvYcCW3hY1eOGjuW+W8VWpTNAWfxT1AMLqPoixaBCExtXfAJi0QIDLTanwrwoox3XAqxjIj6S0V@lists.linux.dev
X-Gm-Message-State: AOJu0YwFybiL1TEyUzTpTk1JtjsR8j6sDwHt26Rlxgwm5deQjpdLkMm+
	uMKeIVyuYrwtZkBpyP4z2ExtlyLusc8mN9MNaWTzktKrc5C/af/+10JB
X-Gm-Gg: ATEYQzxheia971aFh+GG4YiCvoCERvzIX+4qJrrDGOJJ9Dnuw6Z0a5IIvZUhTa6JNV3
	6bQBgPP+ML3I2dKNtNhZG4zM4hH+Wv5wE1h59I5ZvtfE2u8WQnJxQpRBr8PPir+eK/wVuBxZb7T
	VoGAJcs4AzEDiUTr4I3xUSFGrDstQ2Lf5COLA78VfMjDBk3dV1vSc4LDeQBd2Fdx926CABzALlJ
	EvMFAtpaTdImTM2bzMTHHmNHPGohrtEj4kcty+L5KRedPJO+sRnOpAKqAEMxmWSS4OUzrtECF/L
	nLU/KKQs5rp0QWQ6F7nJNtwLwFRxpD43SjHsz6xxv0gnXCMTeu0EWD7VqsUj3COYjL+rplTukE/
	koXx6xQslvvim32UJDX3VGi7r9ml3H+pO8IkeQOWIMnmbV+6h3O2jfMVqE1ZBqumHnDeqe3fl4a
	SupMUyFQWXQ5c0fiBixOvhwJYOZL850ugPtwFlOhN5eEuDAbxIZOBO/ycERGuUC8S5y4YLZZwXx
	0N+XwCh
X-Received: by 2002:a05:7300:d50f:b0:2c1:23d:c73b with SMTP id 5a478bee46e88-2c1097c1a67mr7855727eec.34.1774366229928;
        Tue, 24 Mar 2026 08:30:29 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10aefd778sm20842577eec.0.2026.03.24.08.30.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:29 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: asmadeus@codewreck.org,
	ericvh@kernel.org,
	lucho@ionkov.net
Cc: stefano.stabellini@amd.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 0/2] 9p/trans_xen: fixes and parser cleanup
Date: Tue, 24 Mar 2026 23:30:21 +0800
Message-ID: <20260324153023.86853-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=ericterminal@gmail.com; h=from:subject; bh=Kf963KsFDED0IqbKEbalvOK4reVUn2jRfHURzivswk0=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqt5dbNI46fKhbKPmiKYKp4FiwmGBWoX2W/PTWr// zf/pZN2x0QWBjEuBksxRZa7//fNzfW6Nec69+FcmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP 0EjHQMeYgYtTAKba/CDDb9baA4KSd1lZH32wZp/XlaWycp3co5lLTq9e9cUjgL+sR4mRYcHfbeJ /gsXrVmxOK/J1MjpfsFaOte7Iy/pvfVdZHu68zwIA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

Hi,

This series provides a stability fix and a parser modernization for the
9p Xen transport. It has been split from the previous mixed series
following feedback from Dominique Martinet to ease review and testing.

Patch 1 fixes a potential double-free/Oops during initialization failure
by making the dataring cleanup idempotent.

Patch 2 replaces deprecated simple_strtoul() with kstrtouint() in the
backend version parsing logic, ensuring stricter input validation.

Testing:
- Verified the series using virtme-ng.
- Patch 1: Tested error paths by forcing init failures on non-Xen systems;
  dmesg confirms the new sentinel-based cleanup correctly prevents Oops.
- Patch 2: Verified with a userspace mock harness that it correctly
  handles empty tokens (,,) and rejects malformed input (1abc).

v3:
- Split into a dedicated 9p/trans_xen series for v9fs.
- No functional changes since v2.

Yufan Chen (2):
  9p/trans_xen: make cleanup idempotent after dataring alloc errors
  9p/trans_xen: replace simple_strto* with kstrtouint

 net/9p/trans_xen.c | 77 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 27 deletions(-)

-- 
2.47.3
